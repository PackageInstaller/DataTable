local BattleService = class("BattleService")
local var_0_1 = g.core.battle.BattleProxy

function BattleService:ctor()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_REPLY_BATTLE_REPORT, self._onGetBattleReport, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CHECK_BATTLE_RESULT, self._onCheckBattleResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_CLIENT_TEST_BATTLE, self._onTestResult, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_BATTLE_VIDEO, self._onBattleVideo, self)
end

function BattleService:_onGetBattleReport(arg_2_1, arg_2_2, arg_2_3)
	var_0_1:addReport((require("app.core.network.ProtoBuilder"):decodeByMsgName("BattleReport", arg_2_3.report)))
end

function BattleService:_onCheckBattleResult(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = false
	local var_3_1 = arg_3_3.ret
	local var_3_2 = 0

	if arg_3_3.result then
		local var_3_3 = require("app.core.network.ProtoBuilder"):decodeByMsgName("CheckResult", arg_3_3.result)

		var_3_1 = var_3_3.ret
		var_3_2 = var_3_3.data_version

		if not var_3_3.check then
			var_3_0 = true
		end
	end

	local var_3_4 = g.core.lang:get(1015, {
		num = var_3_1
	})

	if (var_3_1 ~= 1 or nil) and true then
		var_0_1:showBattleErrorTips((var_3_1 == 1001 or nil) and g.core.lang:get(1016, {
			num1 = var_3_2,
			num2 = require("app.core.config.cfg.version")
		}), var_3_1, arg_3_2)
	end
end

function BattleService:_onTestResult(arg_4_1, arg_4_2, arg_4_3)
	arg_4_3.seed = self.testSeed

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TEST_BATTLE_RESULT, true, arg_4_3)
end

function BattleService:_onBattleVideo(arg_5_1, arg_5_2, arg_5_3)
	var_0_1:playVidioBattle(arg_5_3.battle_video)
end

return BattleService
