local var_0_0 = class("GotoPolyhedronStage", BattleSettlementStrategyBase)

function var_0_0.OnGotoSettlement(arg_1_0, arg_1_1)
	arg_1_0:OnGotoPolyhedron(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult)
end

function var_0_0.OnGotoPolyhedron(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0, var_2_1 = GetResultReward()

	if isSuccess(arg_2_1) then
		if arg_2_4.errorCode == 12000 then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})

			return
		end

		local var_2_2 = PolyhedronData:GetPolyhedronInfo():GetState()

		if PolyhedronConst.STATE_TYPE.STARTED == var_2_2 then
			DoPolyhedronNextTrigger()
		elseif PolyhedronConst.STATE_TYPE.SETTLEMENT == var_2_2 then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
		else
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battlePolyhedronFailed", {
				stageData = arg_2_2,
				starMissionData = arg_2_3,
				battleResult = arg_2_4
			})
			manager.story:RemovePlayer()
			EndBattleLogic(arg_2_1)
		end
	end
end

return var_0_0
