local var_0_0 = {}
local var_0_1 = 14
local var_0_2 = 20
local lang_pack_list = require("app.core.config.cfg.language_bins.lang_pack_list")
local var_0_4 = cc.FileUtils:getInstance()

var_0_0.LAZY_LOAD = true

if device.isWindows() then
	var_0_0.LAZY_LOAD = false
end

var_0_0.patch = {}

local function var_0_5(arg_1_0)
	return arg_1_0 % 4294967296
end

local function var_0_6(arg_2_0, arg_2_1)
	local var_2_0, var_2_1, var_2_2, var_2_3 = arg_2_0:byte(arg_2_1, arg_2_1 + 3)

	return var_2_0 + var_2_1 * 256 + var_2_2 * 65536 + var_2_3 * 16777216
end

local var_0_7 = bit

if not bit then
	local var_0_8, var_0_9 = pcall(require, "bit")

	if var_0_8 then
		var_0_7 = var_0_9
	end
end

var_0_7 = var_0_7 or bit32

local var_0_10

if var_0_7 then
	var_0_10 = var_0_7.bxor or bit32.bxor
end

local function var_0_11(arg_3_0)
	local var_3_0 = 3421674724
	local var_3_1 = 2216829733

	for iter_3_0 = 1, #arg_3_0 do
		var_3_1 = var_0_5(var_0_10(var_3_1, arg_3_0:byte(iter_3_0)))
		var_3_0 = var_0_5(var_3_0 * 256 + (var_3_1 * 256 + var_3_0 * 435 + math.floor(var_3_1 * 435 / 4294967296)) % 4294967296)
		var_3_1 = var_0_5(var_3_1 * 435 % 4294967296)
	end

	return var_0_5(var_3_0), var_0_5(var_3_1)
end

local function var_0_12(arg_4_0)
	local var_4_0 = 2166136261

	local function var_4_1(arg_5_0, arg_5_1)
		local var_5_0 = var_0_7.rshift(arg_5_0, 16)
		local var_5_1 = var_0_7.band(arg_5_0, 65535)
		local var_5_2 = var_0_7.rshift(arg_5_1, 16)
		local var_5_3 = var_0_7.band(arg_5_1, 65535)
		local var_5_4 = var_0_7.rshift(var_5_1 * var_5_3, 16) + var_0_7.band(var_5_1 * var_5_2, 65535) + var_0_7.band(var_5_0 * var_5_3, 65535)
		local var_5_5 = var_5_0 * var_5_2 + var_0_7.rshift(var_5_1 * var_5_2, 16) + var_0_7.rshift(var_5_0 * var_5_3, 16) + var_0_7.rshift(var_5_4, 16)

		return var_0_5(var_0_7.band(var_0_7.band(var_5_1 * var_5_3, 65535) + var_0_7.lshift(var_0_7.band(var_5_4, 65535), 16), 4294967295))
	end

	for iter_4_0 = 1, #arg_4_0 do
		var_4_0 = var_0_5(var_0_10(var_4_0, arg_4_0:byte(iter_4_0)))
		var_4_0 = var_4_1(var_4_0, 16777619)
	end

	return var_0_5(var_4_0)
end

function var_0_0:_module_name()
	local var_6_0 = self:find("_")

	if var_6_0 then
		return self:sub(1, var_6_0 - 1)
	end

	if self:match("^%d+$") then
		return "numeric"
	end

	return "misc"
end

local var_0_13 = "app/core/config/cfg/language_bins"

var_0_0._bin_cache = {}
var_0_0.LRU_CAPACITY = 512
var_0_0._lru = var_0_0.LRU_CAPACITY > 0 and (function(arg_7_0)
	local var_7_0 = {
		size = 0,
		map = {},
		cap = arg_7_0
	}

	local function var_7_1(arg_8_0)
		if var_7_0.head == arg_8_0 then
			return
		end

		if arg_8_0.prev then
			arg_8_0.prev.next = arg_8_0.next
		end

		if arg_8_0.next then
			arg_8_0.next.prev = arg_8_0.prev
		end

		if var_7_0.tail == arg_8_0 then
			var_7_0.tail = arg_8_0.prev
		end

		arg_8_0.prev = nil
		arg_8_0.next = var_7_0.head

		if var_7_0.head then
			var_7_0.head.prev = arg_8_0
		end

		var_7_0.head = arg_8_0
		var_7_0.tail = var_7_0.tail or arg_8_0
	end

	local function var_7_2()
		if not var_7_0.tail then
			return
		end

		var_7_0.map[var_7_0.tail.key] = nil
		var_7_0.tail = var_7_0.tail.prev

		if var_7_0.tail then
			var_7_0.tail.next = nil
		else
			var_7_0.head = nil
		end

		var_7_0.size = var_7_0.size - 1
	end

	function var_7_0.get(arg_10_0)
		if not var_7_0.map[arg_10_0] then
			return nil
		end

		var_7_1(var_7_0.map[arg_10_0])

		return var_7_0.map[arg_10_0].val
	end

	function var_7_0.put(arg_11_0, arg_11_1)
		if var_7_0.map[arg_11_0] then
			var_7_0.map[arg_11_0].val = arg_11_1

			var_7_1(var_7_0.map[arg_11_0])

			return
		end

		local var_11_0 = {
			key = arg_11_0,
			val = arg_11_1,
			next = var_7_0.head
		}

		if var_7_0.head then
			var_7_0.head.prev = var_11_0
		end

		var_7_0.head = var_11_0
		var_7_0.tail = var_7_0.tail or var_11_0
		var_7_0.map[arg_11_0] = var_11_0
		var_7_0.size = var_7_0.size + 1

		if var_7_0.size > var_7_0.cap then
			var_7_2()
		end
	end

	function var_7_0.clear()
		var_7_0.map = {}
		var_7_0.head, var_7_0.tail = nil
		var_7_0.size = 0
	end

	return var_7_0
end)(var_0_0.LRU_CAPACITY) or nil

local var_0_14 = 200

function var_0_0._close_all()
	for iter_13_0, iter_13_1 in pairs(var_0_0._bin_cache) do
		if iter_13_1.fh then
			iter_13_1.fh:close()
		end
	end

	var_0_0._bin_cache = {}
end

function var_0_0:_bin_for_module()
	if self:match("^%d+$") then
		local var_14_0 = math.floor((tonumber(self) - 1) / var_0_14) * var_0_14 + 1

		return string.format("%d-%d.bin", var_14_0, var_14_0 + var_0_14 - 1)
	end

	return self .. ".bin"
end

function var_0_0._load_bin(arg_15_0)
	if var_0_0._bin_cache[arg_15_0] then
		return var_0_0._bin_cache[arg_15_0]
	end

	local var_15_0 = var_0_4:fullPathForFilename(var_0_13 .. "/" .. arg_15_0)

	print(var_15_0)

	local var_15_1 = io.open(var_15_0, "rb")

	if not var_15_1 then
		return nil
	end

	local var_15_2 = var_15_1:read(var_0_1)

	if not var_15_2 or #var_15_2 < var_0_1 then
		var_15_1:close()

		return nil
	end

	local var_15_3 = var_0_6(var_15_2, 7)
	local var_15_4 = var_0_6(var_15_2, 11)
	local var_15_5

	if var_0_0.LAZY_LOAD then
		var_15_5 = {
			fh = var_15_1,
			count = var_15_3,
			data_offset = var_15_4
		}
	else
		local var_15_6 = var_15_3 * var_0_2
		local var_15_7 = var_15_1:read(var_15_3 * var_0_2)

		if not var_15_7 or var_15_6 > #var_15_7 then
			var_15_1:close()

			return nil
		end

		var_15_1:seek("set", var_15_4)

		local var_15_8 = var_15_1:read("*a") or ""

		var_15_1:close()

		var_15_5 = {
			entries = var_15_7,
			blob = var_15_8,
			count = var_15_3
		}
	end

	var_0_0._bin_cache[arg_15_0] = var_15_5

	return var_15_5
end

function var_0_0:_read_entry(arg_16_1)
	local var_16_0

	if self.entries then
		var_16_0 = self.entries:sub(arg_16_1 * var_0_2 + 1, arg_16_1 * var_0_2 + var_0_2)

		if not var_16_0 or #var_16_0 < var_0_2 then
			return nil
		end
	else
		self.fh:seek("set", var_0_1 + arg_16_1 * var_0_2)

		var_16_0 = self.fh:read(var_0_2)

		if not var_16_0 or #var_16_0 < var_0_2 then
			return nil
		end
	end

	return var_0_6(var_16_0, 1), var_0_6(var_16_0, 5), var_0_6(var_16_0, 9), var_0_6(var_16_0, 13), (var_0_6(var_16_0, 17))
end

function var_0_0._find_value(arg_17_0)
	local var_17_0 = var_0_0._load_bin((var_0_0._bin_for_module(var_0_0._module_name(arg_17_0))))

	if not var_17_0 then
		return nil
	end

	local var_17_1, var_17_2 = var_0_11(arg_17_0)
	local var_17_3 = var_0_12(arg_17_0)

	while 0 <= var_17_0.count - 1 do
		local var_17_4 = math.floor((0 + (var_17_0.count - 1)) / 2)
		local var_17_5, var_17_6, var_17_7, var_17_8, var_17_9 = var_0_0._read_entry(var_17_0, var_17_4)

		if not var_17_5 then
			break
		end

		if var_17_1 == var_17_5 and var_17_2 == var_17_6 and var_17_3 == var_17_7 then
			if var_17_9 == 0 then
				return ""
			end

			if var_17_0.blob then
				return var_17_0.blob:sub(var_17_8 + 1, var_17_8 + var_17_9)
			else
				var_17_0.fh:seek("set", var_17_0.data_offset + var_17_8)

				return var_17_0.fh:read(var_17_9)
			end
		end

		local var_17_10, var_17_11

		if var_17_1 < var_17_5 or var_17_1 == var_17_5 and (var_17_2 < var_17_6 or var_17_2 == var_17_6 and var_17_3 < var_17_7) then
			var_17_10 = var_17_4 - 1
		else
			var_17_11 = var_17_4 + 1
		end
	end

	return nil
end

function var_0_0.get(arg_18_0)
	return var_0_0.fetch(arg_18_0)
end

function var_0_0.fetch(arg_19_0)
	if not arg_19_0 then
		return nil
	end

	local var_19_0 = var_0_0.patch[arg_19_0]

	if not var_0_0.patch[arg_19_0] then
		if var_0_0._lru then
			local var_19_1 = var_0_0._lru.get(arg_19_0)

			if var_19_1 ~= nil then
				return {
					key = arg_19_0,
					value = var_19_1
				}
			end
		end

		var_19_0 = var_0_0._find_value(arg_19_0)

		if var_19_0 and var_0_0._lru then
			var_0_0._lru.put(arg_19_0, var_19_0)
		end
	end

	if not var_19_0 then
		return nil
	end

	return {
		key = arg_19_0,
		value = var_19_0 or ""
	}
end

function var_0_0.init()
	local var_20_0 = table.concat({
		device.obbDirPath,
		"res/language",
		(require("app.core.lang.MultilingualMgr"):getUseLang())
	}, "/")

	for iter_20_0, iter_20_1 in ipairs(lang_pack_list) do
		local var_20_1 = table.concat({
			var_0_13,
			iter_20_1
		}, "/")
		local var_20_2 = var_0_4:fullPathForFilename(var_20_1)

		if g.core.utils.Tools.isDiskPathEx(var_20_2) then
			g.core.utils.Tools.copyFile(var_20_2, table.concat({
				var_20_0,
				var_20_1
			}, "/"), table.concat({
				var_20_0,
				var_0_13
			}, "/"))
		end
	end
end

function var_0_0.close()
	var_0_0._close_all()

	if var_0_0._lru then
		var_0_0._lru.clear()
	end
end

return var_0_0
