local var_0_0 = g.core.model.User.gveDataMgr
local DebugGveGridCheck = class("DebugGveGridCheck", require("app.fairyGUI.debug.UI_DebugGveGridCheck"))

function DebugGveGridCheck:ctor()
	self.m_checkCfgBtn:addClickListener(handler(self, self.onFullCheck))
end

function DebugGveGridCheck:onFullCheck()
	self:onCheckCfg()
	self:reCheckMountain()
	self.m_logTxt:setText(self._logStr)
	print(self._logStr)
end

function DebugGveGridCheck:onCheckCfg()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in g.core.config.gve_grid_info.ipairs() do
		var_3_0[iter_3_1.x .. "_" .. iter_3_1.y] = true
	end

	local var_3_1 = {}

	local function var_3_2(arg_4_0, arg_4_1)
		if var_3_0[arg_4_0 .. "_" .. arg_4_1] then
			var_3_0[arg_4_0 .. "_" .. arg_4_1] = nil

			return true
		end

		return false
	end

	local function var_3_3(arg_5_0, arg_5_1)
		return {
			cc.p(arg_5_0 + 1, arg_5_1),
			cc.p(arg_5_0, arg_5_1 + 1),
			cc.p(arg_5_0 - 1, arg_5_1),
			cc.p(arg_5_0, arg_5_1 - 1)
		}
	end

	local function var_3_4(arg_6_0, arg_6_1, arg_6_2)
		if var_3_2(arg_6_0, arg_6_1) then
			table.insert(arg_6_2, {
				x = arg_6_0,
				y = arg_6_1
			})

			return (var_3_3(arg_6_0, arg_6_1))
		end

		return {}
	end

	local var_3_5 = next(var_3_0)

	while var_3_5 do
		local var_3_6 = {}
		local var_3_7 = string.split(var_3_5, "_")
		local var_3_8 = var_3_4(tonumber(var_3_7[1]), tonumber(var_3_7[2]), var_3_6)

		while next(var_3_8) do
			local var_3_9 = {}

			for iter_3_2, iter_3_3 in ipairs(var_3_8) do
				table.insertto(var_3_9, (var_3_4(iter_3_3.x, iter_3_3.y, var_3_6)))
			end

			var_3_8 = var_3_9
		end

		table.insert(var_3_1, var_3_6)

		var_3_5 = next(var_3_0)
	end

	local var_3_10 = ""

	for iter_3_4, iter_3_5 in ipairs(var_3_1) do
		if #iter_3_5 < 100 then
			for iter_3_6, iter_3_7 in ipairs(iter_3_5) do
				if g.core.config.gve_grid_info.match(function(arg_7_0)
					if arg_7_0.x == iter_3_7.x and arg_7_0.y == iter_3_7.y then
						return true
					end

					return false
				end)[1].level == 1 then
					var_3_10 = var_3_10 == "" and "x = " .. iter_3_5[1].x .. ",y = " .. iter_3_5[1].y .. "地块所在周围存在风险！" or var_3_10 .. "\nx = " .. iter_3_5[1].x .. ",y = " .. iter_3_5[1].y .. "地块所在周围存在风险！"

					break
				end
			end
		end
	end

	if var_3_10 == "" then
		var_3_10 = "检查未发现异常"
	end

	self._logStr = var_3_10 .. "\n"
end

function DebugGveGridCheck:reCheckMountain()
	self._logStr = self._logStr .. "----------------检查山装饰数据----------------\n"

	local GveMountainConfig = require("app.view.module.gve.const.GveMountainConfig")

	for iter_8_0 = 0, 289 do
		for iter_8_1 = 0, 289 do
			if GveMountainConfig[iter_8_0 .. "_" .. iter_8_1] and GveMountainConfig[iter_8_0 .. "_" .. iter_8_1] ~= 311 and GveMountainConfig[iter_8_0 .. "_" .. iter_8_1] ~= 312 and var_0_0:getGveData():getBuildDataByPos({
				x = iter_8_0,
				y = iter_8_1
			}) then
				self._logStr = self._logStr .. iter_8_0 .. "," .. iter_8_1 .. "可能存在问题!!!!"
			end
		end
	end
end

return DebugGveGridCheck
