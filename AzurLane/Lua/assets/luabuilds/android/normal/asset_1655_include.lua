pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = pg

local var_0_1

var_0_1 = var_0 or {}
cs = ys

local var_0_2

var_0_2 = var_0 or {}

local var_0_3 = cs

local function var_0_4(arg_1_0)
	string = var_1_10001

	return var_1_10001.gsub(arg_1_0 or "", "<%[(.-)%]>", function(arg_2_0)
		pg = var_2_10001

		return var_2_10001.equip_data_code[arg_2_0] and var_1.text
	end)
end

confNEO = var_0_10001

local var_0_5

var_0_5 = var_0_10001 or {
	__index = function(arg_3_0, arg_3_1)
		rawget = var_1_10002

		local var_3_0 = var_1_10002(arg_3_0, "__name")
		local var_3_1

		rawget = var_4

		local var_3_2

		if not var_4(arg_3_0, "__sub__") then
			var_3_2 = {
				var_3_0
			}
		end

		rawget = var_5

		local var_3_3 = var_5(arg_3_0, "__stream__")

		ipairs = var_6

		for iter_3_0, iter_3_1 in var_6(var_3_2) do
			if var_3_3 then
				cs = var_1_10011

				if var_1_10011[iter_3_1][arg_3_1] then
					pg = var_1_10011

					if not var_1_10011.base[iter_3_1][arg_3_1] then
						LuaHelper = var_1_10011
						var_1_10011 = var_1_10011.SetConfVal

						local var_3_4 = iter_3_1

						cs = var_1_10013
						var_1_10013 = var_1_10013[iter_3_1][arg_3_1][1]
						cs = var_1_10014

						var_1_10011(var_3_4, var_1_10013, var_1_10014[iter_3_1][arg_3_1][2])
					end
				end
			end

			pg = var_1_10011

			if var_1_10011.base[iter_3_1][arg_3_1] then
				break
			end
		end

		if var_3_1 == nil then
			return nil
		end

		rawget = var_6

		local var_3_5 = var_6(arg_3_0, "__namecode__")

		rawget = var_7

		local var_3_6

		if not var_7(var_3_1, "base") then
			var_3_6 = nil
		end

		setmetatable = var_8
		arg_3_0[arg_3_1] = var_8({}, {
			__index = function(arg_4_0, arg_4_1)
				local var_4_0

				if var_3_1[arg_4_1] == nil and var_3_6 then
					var_4_0 = arg_3_0[var_3_6][arg_4_1]
				end

				type = var_2_10003

				if var_2_10003(var_4_0) == "string" then
					if var_3_0 == "equip_data_statistics" then
						var_4_0 = var_0_4(var_4_0)
					end

					if var_3_5 then
						HXSet = var_3
						var_4_0 = var_3.hxLan(var_4_0)
					end
				end

				arg_4_0[arg_4_1] = var_4_0

				return var_4_0
			end
		})

		return arg_3_0[arg_3_1]
	end
}
require = confNEO

var_1("localConfig")

require = var_1

var_1("const")

require = var_1

var_1("config")

setmetatable = var_1
pg = var_2

var_1(var_2, {
	__index = function(arg_5_0, arg_5_1)
		local var_5_0 = "ShareCfg." .. arg_5_1

		ShareCfg = var_3

		local var_5_1

		if var_3[var_5_0] then
			require = var_5_1

			var_5_1(var_5_0)
		else
			var_5_1 = 1

			::label_5_0::

			ShareCfg = var_1_10004

			if var_1_10004[var_5_0 .. "_" .. var_5_1] then
				repeat
					require = var_1_10004

					var_1_10004(var_5_0 .. "_" .. var_5_1)

					var_5_1 = var_5_1 + 1

					goto label_5_0
				until true
			end
		end

		rawget = var_5_1
		pg = var_1_10004

		return var_5_1(var_1_10004, arg_5_1)
	end
})

setmetatable = var_1

local var_0_6 = var_1({}, {
	__index = function(arg_6_0, arg_6_1)
		pg = var_1_10002

		if var_1_10002.error_message[arg_6_1] then
			pg = var_2

			return var_2.error_message[arg_6_1].desc
		else
			return "none"
		end

		return
	end
})
local var_0_7 = ERROR_MESSAGE
local var_0_8 = 1
local var_0_9 = BVCurIndex
local var_0_10 = 1

require = BVLastIndex

var_1("Framework/Include")

require = var_1

var_1("Support/Include")

require = var_1

var_1("classes")

require = var_1

var_1("Net/Include")

require = var_1

var_1("Mgr/Include")

require = var_1

var_1("GameCfg/Include")

require = var_1

var_1("Mod/Battle/Include")

require = var_1

var_1("skillCfg")

require = var_1

var_1("buffCfg")

require = var_1

var_1("cardCfg")

require = var_1

var_1("genVertify")

require = var_1

var_1("buffFXPreloadList")

require = var_1

var_1("nodecanvas/Include")

return
