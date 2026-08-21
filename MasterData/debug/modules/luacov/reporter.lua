-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\luacov\\reporter.lua

local reporter = {}
local LineScanner = require("Debug/Modules/luacov.linescanner")
local luacov = require("Debug/Modules/luacov.runner")
local util = require("Debug/Modules/luacov.util")
local lfs_ok, lfs = pcall(require, "lfs")
local dir_sep = package.config:sub(1, 1)

if not dir_sep:find("[/\\]") then
	dir_sep = "/"
end

local function dirtree(dir)
	assert(dir and dir ~= "", "Please pass directory parameter")

	if dir:sub(-1):match("[/\\]") then
		dir = string.sub(dir, 1, -2)
	end

	dir = dir:gsub("[/\\]", dir_sep)

	local function yieldtree(directory)
		for entry in lfs.dir(directory) do
			if entry ~= "." and entry ~= ".." then
				entry = directory .. dir_sep .. entry

				local attr = lfs.attributes(entry)

				coroutine.yield(entry, attr)

				if attr.mode == "directory" then
					yieldtree(entry)
				end
			end
		end
	end

	return coroutine.wrap(function()
		yieldtree(dir)
	end)
end

local function fileMatches(filename, pattern)
	return string.find(filename, pattern)
end

local ReporterBase = {}

ReporterBase.__index = ReporterBase

function ReporterBase:new(conf)
	local stats = require("Debug/Modules/luacov.stats")
	local data = stats.load(conf.statsfile)

	if not data then
		return nil, "Could not load stats file " .. conf.statsfile .. "."
	end

	local files = {}
	local filtered_data = {}
	local max_hits = 0

	for filename, file_stats in pairs(data) do
		if luacov.file_included(filename) then
			filename = luacov.real_name(filename)

			if filtered_data[filename] then
				luacov.update_stats(filtered_data[filename], file_stats)
			else
				table.insert(files, filename)

				filtered_data[filename] = file_stats
			end

			max_hits = math.max(max_hits, filtered_data[filename].max_hits)
		end
	end

	if conf.includeuntestedfiles then
		if not lfs_ok then
			os.exit(1)
		end

		local function add_empty_file_coverage_data(file_path)
			if file_path:match("^%.[/\\]") then
				file_path = file_path:sub(3)
			end

			if luacov.file_included(file_path) then
				local file_stats = {
					max_hits = 0,
					max = 0
				}
				local filename = luacov.real_name(file_path)

				if not filtered_data[filename] then
					table.insert(files, filename)

					filtered_data[filename] = file_stats
				end
			end
		end

		local function add_empty_dir_coverage_data(directory_path)
			for filename, attr in dirtree(directory_path) do
				if attr.mode == "file" and fileMatches(filename, ".%.lua$") then
					add_empty_file_coverage_data(filename)
				end
			end
		end

		if conf.includeuntestedfiles == true then
			add_empty_dir_coverage_data("." .. dir_sep)
		elseif type(conf.includeuntestedfiles) == "table" and conf.includeuntestedfiles[1] then
			for _, include_path in ipairs(conf.includeuntestedfiles) do
				if fileMatches(include_path, ".%.lua$") then
					add_empty_file_coverage_data(include_path)
				else
					add_empty_dir_coverage_data(include_path)
				end
			end
		end
	end

	table.sort(files)

	local out, err = io.open(conf.reportfile, "w")

	if not out then
		return nil, err
	end

	local o = setmetatable({
		_out = out,
		_cfg = conf,
		_data = filtered_data,
		_files = files,
		_mhit = max_hits
	}, self)

	return o
end

function ReporterBase:config()
	return self._cfg
end

function ReporterBase:max_hits()
	return self._mhit
end

function ReporterBase:write(...)
	return self._out:write(...)
end

function ReporterBase:close()
	self._out:close()

	self._private = nil
end

function ReporterBase:files()
	return self._files
end

function ReporterBase:stats(filename)
	return self._data[filename]
end

function ReporterBase:on_start()
	return
end

function ReporterBase:on_new_file(filename)
	return
end

function ReporterBase:on_file_error(filename, error_type, message)
	return
end

function ReporterBase:on_empty_line(filename, lineno, line)
	return
end

function ReporterBase:on_mis_line(filename, lineno, line)
	return
end

function ReporterBase:on_hit_line(filename, lineno, line, hits)
	return
end

function ReporterBase:on_end_file(filename, hits, miss)
	return
end

function ReporterBase:on_end()
	return
end

do
	local cluacov_ok = pcall(require, "cluacov.version")
	local deepactivelines

	if cluacov_ok then
		deepactivelines = require("cluacov.deepactivelines")
	end

	function ReporterBase:_run_file(filename)
		local file, open_err = io.open(filename)

		if not file then
			self:on_file_error(filename, "open", util.unprefix(open_err, filename .. ": "))

			return
		end

		local active_lines

		if cluacov_ok then
			local src, read_err = file:read("*a")

			if not src then
				self:on_file_error(filename, "read", read_err)

				return
			end

			src = src:gsub("^#![^\n]*", "")

			local func, load_err = util.load_string(src, nil, "@file")

			if not func then
				self:on_file_error(filename, "load", "line " .. util.unprefix(load_err, "file:"))

				return
			end

			active_lines = deepactivelines.get(func)

			for index, value in ipairs(active_lines) do
				-- block empty
			end

			file:seek("set")
		end

		self:on_new_file(filename)

		local file_hits, file_miss = 0, 0
		local filedata = self:stats(filename)
		local line_nr = 1
		local scanner = LineScanner:new()
		local config = self:config()

		if config.filediff[filename] then
			local _type = config.filediff[filename]._type
			local parts = config.filediff[filename].parts
			local idxs = config.filediff[filename].idxs
			local idx_dict = {}

			for key, value in pairs(idxs) do
				local kn, vn = tonumber(key), tonumber(value)

				for i = kn, kn + vn - 1 do
					idx_dict[i] = 1
				end
			end

			while true do
				local line = file:read("*l")

				if not line then
					break
				end

				local always_excluded, excluded_when_not_hit = scanner:consume(line)
				local hits = filedata[line_nr] or 0
				local included = not always_excluded and (not excluded_when_not_hit or hits ~= 0)

				if cluacov_ok then
					included = included and active_lines[line_nr]
				end

				local cando = _type == "all"

				if _type == "part" and idx_dict[line_nr] then
					cando = true
				end

				if cando then
					local canhit = false

					for index, value in ipairs(parts) do
						if value == line then
							canhit = true

							break
						end
					end

					if included and canhit then
						if hits == 0 then
							self:on_mis_line(filename, line_nr, line)

							file_miss = file_miss + 1
						else
							self:on_hit_line(filename, line_nr, line, hits)

							file_hits = file_hits + 1
						end
					else
						self:on_empty_line(filename, line_nr, line)
					end
				end

				line_nr = line_nr + 1
			end
		end

		file:close()
		self:on_end_file(filename, file_hits, file_miss)
	end

	function ReporterBase:run()
		self:on_start()

		for _, filename in ipairs(self:files()) do
			self:_run_file(filename)
		end

		self:on_end()
	end
end

local DefaultReporter = setmetatable({}, ReporterBase)

DefaultReporter.__index = DefaultReporter

function DefaultReporter:on_start()
	local most_hits = self:max_hits()
	local most_hits_length = #("%d"):format(most_hits)

	self._summary = {}
	self._empty_format = (" "):rep(most_hits_length + 1)
	self._zero_format = ("*"):rep(most_hits_length) .. "0"
	self._count_format = ("%% %dd"):format(most_hits_length + 1)
	self._printed_first_header = false
end

function DefaultReporter:on_new_file(filename)
	self:write(("="):rep(78), "\n")
	self:write(filename, "\n")
	self:write(("="):rep(78), "\n")
end

function DefaultReporter:on_file_error(filename, error_type, message)
	io.stderr:write(("Couldn't %s %s: %s\n"):format(error_type, filename, message))
end

function DefaultReporter:on_empty_line(_, _, line)
	if line == "" then
		self:write("\n")
	else
		self:write(self._empty_format, " ", line, "\n")
	end
end

function DefaultReporter:on_mis_line(_, _, line)
	self:write(self._zero_format, " ", line, "\n")
end

function DefaultReporter:on_hit_line(_, _, line, hits)
	self:write(self._count_format:format(hits), " ", line, "\n")
end

function DefaultReporter:on_end_file(filename, hits, miss)
	self._summary[filename] = {
		hits = hits,
		miss = miss
	}

	self:write("\n")
end

do
	local function coverage_to_string(hits, missed)
		local total = hits + missed

		if total == 0 then
			total = 1
		end

		return ("%.2f%%"):format(hits / total * 100)
	end

	function DefaultReporter:on_end()
		self:write(("="):rep(78), "\n")
		self:write("Summary\n")
		self:write(("="):rep(78), "\n")
		self:write("\n")

		local lines = {
			{
				"File",
				"Hits",
				"Missed",
				"Coverage"
			}
		}
		local total_hits, total_missed = 0, 0

		for _, filename in ipairs(self:files()) do
			local summary = self._summary[filename]

			if summary then
				local hits, missed = summary.hits, summary.miss

				table.insert(lines, {
					filename,
					tostring(summary.hits),
					tostring(summary.miss),
					coverage_to_string(hits, missed)
				})

				total_hits = total_hits + hits
				total_missed = total_missed + missed
			end
		end

		table.insert(lines, {
			"Total",
			tostring(total_hits),
			tostring(total_missed),
			coverage_to_string(total_hits, total_missed)
		})

		local max_column_lengths = {}

		for _, line in ipairs(lines) do
			for column_nr, column in ipairs(line) do
				max_column_lengths[column_nr] = math.max(max_column_lengths[column_nr] or -1, #column)
			end
		end

		local table_width = #max_column_lengths - 1

		for _, column_length in ipairs(max_column_lengths) do
			table_width = table_width + column_length
		end

		for line_nr, line in ipairs(lines) do
			if line_nr == #lines or line_nr == 2 then
				self:write(("-"):rep(table_width), "\n")
			end

			for column_nr, column in ipairs(line) do
				self:write(column)

				if column_nr == #line then
					self:write("\n")
				else
					self:write((" "):rep(max_column_lengths[column_nr] - #column + 1))
				end
			end
		end
	end
end

function reporter.report(reporter_class)
	local configuration = luacov.load_config()

	reporter_class = reporter_class or DefaultReporter

	local rep, err = reporter_class:new(configuration)

	if not rep then
		os.exit(1)
	end

	if configuration.deletereport then
		os.remove(configuration.reportfile)
	end

	rep:run()
	rep:close()

	if configuration.deletestats and configuration.isshutdown then
		os.remove(configuration.statsfile)
	end
end

reporter.ReporterBase = ReporterBase
reporter.DefaultReporter = DefaultReporter

return reporter
