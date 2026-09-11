local GotoSkuldStage = class("GotoSkuldStage", BattleSettlementStrategyBase)

function GotoSkuldStage:OnGotoSettlement(arg_1_1)
	self:GotoSkuldStage(arg_1_1.num, arg_1_1.stageData, arg_1_1.starMissionData, arg_1_1.battleResult, arg_1_1.isHalfWay_)
end

function GotoSkuldStage:GotoSkuldStage(arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	if BattleSkuldStageCfg[arg_2_2:GetStageId()].tag == BattleConst.BATTLE_TAG.STORY then
		arg_2_5 = false
	end

	if isSuccess(arg_2_1) and not arg_2_5 then
		function BattleCallLuaCallBack()
			manager.story:CheckBattleStory(arg_2_2:GetStageId(), manager.story.WIN, function()
				manager.story:RemovePlayer()

				local var_4_0, var_4_1 = GetResultReward()
				local var_4_2 = arg_2_2:GetDest()

				SkuldSystemData:PassLevel(var_4_2)

				local var_4_3 = 0
				local var_4_4 = {}

				for iter_4_0, iter_4_1 in pairs(var_4_0) do
					if iter_4_1[1] == CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id then
						var_4_3 = iter_4_1[2]
					else
						table.insert(var_4_4, {
							iter_4_1[1],
							iter_4_1[2]
						})
					end
				end

				gameContext:Go("/battleResultSkuldView", {
					stageData = arg_2_2,
					rewardList = var_4_4,
					skuldIconNum = var_4_3,
					battleResult = arg_2_4,
					levelID = var_4_2
				})
				EndBattleLogic(arg_2_1)
			end, false)
		end
	else
		self:GotoBattleFaild(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	end
end

return GotoSkuldStage
