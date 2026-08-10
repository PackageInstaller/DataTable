local var_0_0 = {}
local var_0_1 = require("game/bridge/BattleCooperationSettlementStrategy/BattleCooperationGotoHandler")

var_0_1:Init()

function var_0_0.GotoTeam(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	print("联机服务端战斗数据返回")
	print("联机收到服务器的消息，获取到新的战斗结果(0:战斗进行中,1:胜利,2:失败,3：主动退出, 4:不同步):", arg_1_1.result)

	if arg_1_1.result > BattleConst.BATTLE_RESULT.UNFINISHED and arg_1_1.result <= BattleConst.BATTLE_RESULT.NOSYNC then
		local var_1_0 = BattleController.GetInstance():GetBattleStageData()

		print("BattleCooperationCallLua.进入目标结算stage: " .. var_1_0:GetType())

		local var_1_1 = CollectHeroExpChange(var_1_0)

		if isSuccess(arg_1_1.result - 1) then
			CheckBattleResultNeedAddHeroExp()
		end

		var_0_0.goToResult(arg_1_1.result - 1, arg_1_1.star_list, {
			oldPlayerEXPInfo = arg_1_3,
			heroDataCollect = var_1_1,
			errorCode = arg_1_2
		})
		GetBattleResultNeedAddHeroExp()
	end
end

function var_0_0.goToResult(arg_2_0, arg_2_1, arg_2_2)
	_G.PrintAllOpen_ = false

	print("关闭心跳包打印，用于监测网络状态")
	SetForceShowQuanquan(false)

	if _G.CannotConnectTimer then
		_G.CannotConnectTimer:Stop()

		_G.CannotConnectTimer = nil
	end

	local var_2_0 = BattleController.GetInstance():GetBattleStageData()

	var_0_1:GotoResult(var_2_0, arg_2_0, arg_2_1, arg_2_2)

	if isSuccess(arg_2_0) then
		if not BattleCallLuaCallBackWait and not BattleCallLuaWaitLoading then
			BattleCallLuaCallBack()

			function BattleCallLuaCallBack()
				return
			end
		end
	elseif arg_2_0 == 3 then
		function BattleCallLuaCallBack()
			gameContext:Go("/battleCooperationFailed", {
				data_math_error = true,
				stageData = var_2_0
			})
			EndBattleLogic(arg_2_0)
		end

		if not BattleCallLuaCallBackWait and not BattleCallLuaWaitLoading then
			BattleCallLuaCallBack()

			function BattleCallLuaCallBack()
				return
			end
		end
	else
		BattleCallLuaCallBackWait = false

		if not BattleCallLuaWaitLoading then
			BattleCallLuaCallBack()

			function BattleCallLuaCallBack()
				return
			end
		end
	end
end

return var_0_0
