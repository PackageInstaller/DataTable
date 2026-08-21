-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Debug\\Modules\\luacov\\linescanner.lua

local LineScanner = {}

LineScanner.__index = LineScanner

function LineScanner:new()
	return setmetatable({
		first = true,
		enabled = true,
		comment = false,
		after_function = false
	}, self)
end

local function replace(s, old, new)
	old = old:gsub("%p", "%%%0")
	new = new:gsub("%%", "%%%%")

	return (s:gsub(old, new))
end

local fixups = {
	{
		"=",
		" ?= ?"
	},
	{
		"(",
		" ?%( ?"
	},
	{
		")",
		" ?%) ?"
	},
	{
		"<FULLID>",
		"x ?[%[%.]? ?[ntfx0']* ?%]?"
	},
	{
		"<IDS>",
		"x ?, ?x[x, ]*"
	},
	{
		"<FIELDNAME>",
		"%[? ?[ntfx0']+ ?%]?"
	},
	{
		"<PARENS>",
		"[ %(]*"
	}
}

local function fixup(pat)
	for _, fixup_pair in ipairs(fixups) do
		pat = replace(pat, fixup_pair[1], fixup_pair[2])
	end

	return pat
end

local any_hits_exclusions = {
	"",
	"end[,; %)]*",
	"else",
	"repeat",
	"do",
	"if",
	"then",
	"while t do",
	"if t then",
	"local x",
	fixup("local x="),
	fixup("local <IDS>"),
	fixup("local <IDS>="),
	"local function x"
}
local zero_hits_exclusions = {
	"[ntfx0',= ]+,",
	"{ ?} ?,",
	fixup("<FIELDNAME>=.+[,;]"),
	fixup("<FIELDNAME>=function"),
	fixup("<FIELDNAME>=<PARENS>'"),
	"return function",
	"function",
	"[ntfx0]",
	"''",
	"{ ?}",
	fixup("<FULLID>"),
	fixup("local x=function"),
	fixup("local x=<PARENS>'"),
	fixup("local x=(<PARENS>"),
	fixup("local <IDS>=(<PARENS>"),
	fixup("local x=n"),
	fixup("<FULLID>=<PARENS>'"),
	fixup("<FULLID>=function"),
	"} ?,",
	"} ?, ?function",
	"break",
	"{",
	"}?[ %)]*",
	"[ntf0']+ ?}[ %)]*"
}

local function excluded(exclusions, line)
	for _, e in ipairs(exclusions) do
		if line:match("^ *" .. e .. " *$") then
			return true
		end
	end

	return false
end

function LineScanner:find(pattern)
	return self.line:find(pattern, self.i)
end

function LineScanner:skip_string()
	local _, quote_i = self:find("^(\\*)%1" .. self.quote)

	if not quote_i then
		_, quote_i = self:find("[^\\](\\*)%1" .. self.quote)
	end

	if quote_i then
		self.i = quote_i + 1
		self.quote = nil

		table.insert(self.simple_line_buffer, "'")

		return true
	else
		return false
	end
end

function LineScanner:skip_long_string()
	local _, bracket_i = self:find("%]" .. self.equals .. "%]")

	if bracket_i then
		self.i = bracket_i + 1
		self.equals = nil

		if self.comment then
			self.comment = false
		else
			table.insert(self.simple_line_buffer, "'")
		end

		return true
	else
		return false
	end
end

function LineScanner:skip_args()
	local _, paren_i = self:find("%)")

	if paren_i then
		self.i = paren_i + 1
		self.args = nil

		return true
	else
		return false
	end
end

function LineScanner:skip_whitespace()
	local next_i = self:find("%S") or #self.line + 1

	if next_i ~= self.i then
		self.i = next_i

		table.insert(self.simple_line_buffer, " ")
	end
end

function LineScanner:skip_number()
	if self:find("^0[xX]") then
		self.i = self.i + 2
	end

	local _

	_, _, self.i = self:find("^[%x%.]*()")

	if self:find("^[eEpP][%+%-]") then
		self.i = self.i + 2
		_, _, self.i = self:find("^[%x%.]*()")
	end

	_, _, self.i = self:find("^[iull]*()")

	table.insert(self.simple_line_buffer, "0")
end

local keywords = {
	["false"] = "f",
	["nil"] = "n",
	["true"] = "t"
}

for _, keyword in ipairs({
	"and",
	"break",
	"do",
	"else",
	"elseif",
	"end",
	"for",
	"function",
	"goto",
	"if",
	"in",
	"local",
	"not",
	"or",
	"repeat",
	"return",
	"then",
	"until",
	"while"
}) do
	keywords[keyword] = keyword
end

function LineScanner:skip_name()
	local _, _, name = self:find("^([%w_]*)")

	self.i = self.i + #name

	if keywords[name] then
		name = keywords[name]
	else
		name = "x"
	end

	table.insert(self.simple_line_buffer, name)

	if name == "function" then
		self.after_function = true
	end
end

function LineScanner:check_inline_options(comment_body)
	if comment_body:find("^%s*luacov:%s*enable%s*$") then
		self.enabled = true
	elseif comment_body:find("^%s*luacov:%s*disable%s*$") then
		self.enabled = false
	end
end

function LineScanner:consume(line)
	if self.first then
		self.first = false

		if line:match("^#!") then
			return true, true
		end
	end

	self.line = line
	self.simple_line_buffer = {}
	self.i = 1

	while self.i <= #line do
		if self.quote then
			if not self:skip_string() then
				break
			end
		elseif self.equals then
			if not self:skip_long_string() then
				break
			end
		elseif self.args then
			if not self:skip_args() then
				break
			end
		else
			self:skip_whitespace()

			if self:find("^%.%d") then
				self.i = self.i + 1
			end

			if self:find("^%d") then
				self:skip_number()
			elseif self:find("^[%a_]") then
				self:skip_name()
			else
				if self:find("^%-%-") then
					self.comment = true
					self.i = self.i + 2
				end

				local _, bracket_i, equals = self:find("^%[(=*)%[")

				if equals then
					self.i = bracket_i + 1
					self.equals = equals

					if not self.comment then
						table.insert(self.simple_line_buffer, "'")
					end
				elseif self.comment then
					self.comment = false

					local comment_body = self.line:sub(self.i)

					self:check_inline_options(comment_body)

					break
				else
					local char = line:sub(self.i, self.i)

					if char == "." then
						local _, _, dots = self:find("^(%.*)")

						self.i = self.i + #dots

						table.insert(self.simple_line_buffer, dots)
					else
						self.i = self.i + 1

						if char == "'" or char == "\"" then
							table.insert(self.simple_line_buffer, "'")

							self.quote = char
						elseif self.after_function and char == "(" then
							self.after_function = false
							self.args = true
						else
							table.insert(self.simple_line_buffer, char)
						end
					end
				end
			end
		end
	end

	if not self.enabled then
		return true, true
	end

	local simple_line = table.concat(self.simple_line_buffer)

	return excluded(any_hits_exclusions, simple_line), excluded(zero_hits_exclusions, simple_line)
end

return LineScanner
