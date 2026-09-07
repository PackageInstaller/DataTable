pg = pg or {}
ys = ys or {}
cs = cs or {}

local function var_0_0(arg_1_0)
	return string.gsub(arg_1_0 or "", "<%[(.-)%]>", function(arg_2_0)
		return pg.equip_data_code[arg_2_0] and pg.equip_data_code[arg_2_0].text
	end)
end

confNEO = confNEO or {
	__index = function(self, arg_3_1)
		local var_3_0 = rawget(self, "__name")
		local var_3_1
		local var_3_2 = rawget(self, "__sub__") or {
			var_3_0
		}
		local var_3_3 = rawget(self, "__stream__")

		for iter_3_0, iter_3_1 in ipairs(var_3_2) do
			if var_3_3 and cs[iter_3_1][arg_3_1] and not pg.base[iter_3_1][arg_3_1] then
				LuaHelper.SetConfVal(iter_3_1, cs[iter_3_1][arg_3_1][1], cs[iter_3_1][arg_3_1][2])
			end

			var_3_1 = pg.base[iter_3_1][arg_3_1]

			if pg.base[iter_3_1][arg_3_1] then
				break
			end
		end

		if var_3_1 == nil then
			return nil
		end

		local var_3_4 = rawget(self, "__namecode__")
		local var_3_5 = rawget(var_3_1, "base") or nil

		self[arg_3_1] = setmetatable({}, {
			__index = function(arg_4_0, arg_4_1)
				local var_4_0 = var_3_1[arg_4_1]

				if var_3_1[arg_4_1] == nil and var_3_5 then
					var_4_0 = self[var_3_5][arg_4_1]
				end

				if type(var_4_0) == "string" then
					if var_3_0 == "equip_data_statistics" then
						var_4_0 = var_0_0(var_4_0)
					end

					if var_3_4 then
						var_4_0 = HXSet.hxLan(var_4_0)
					end
				end

				arg_4_0[arg_4_1] = var_4_0

				return var_4_0
			end
		})

		return self[arg_3_1]
	end
}

require("localConfig")
require("const")
require("config")
setmetatable(pg, {
	__index = function(arg_5_0, arg_5_1)
		if ShareCfg["ShareCfg." .. arg_5_1] then
			require("ShareCfg." .. arg_5_1)
		else
			local var_5_0 = 1

			while ShareCfg[("ShareCfg." .. arg_5_1) .. "_" .. var_5_0] do
				require(("ShareCfg." .. arg_5_1) .. "_" .. var_5_0)

				var_5_0 = var_5_0 + 1
			end
		end

		return rawget(pg, arg_5_1)
	end
})

ERROR_MESSAGE = setmetatable({}, {
	__index = function(arg_6_0, arg_6_1)
		if pg.error_message[arg_6_1] then
			return pg.error_message[arg_6_1].desc
		else
			return "none"
		end

		return
	end
})
BVCurIndex = 1
BVLastIndex = 1

require("Framework/Include")
require("Support/Include")
require("classes")
require("Net/Include")
require("Mgr/Include")
require("GameCfg/Include")
require("Mod/Battle/Include")
require("skillCfg")
require("buffCfg")
require("cardCfg")
require("genVertify")
require("buffFXPreloadList")
require("nodecanvas/Include")

return
