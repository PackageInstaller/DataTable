local BattleGateScenarioSubStrike = class("BattleGateScenarioSubStrike")

ys.Battle.BattleGateScenarioSubStrike = BattleGateScenarioSubStrike
BattleGateScenarioSubStrike.__name = "BattleGateScenarioSubStrike"

function BattleGateScenarioSubStrike:Entrance(arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = {},
		stageId = getProxy(ChapterProxy):getActiveChapter():getConfigMiscArg("submarine_support"),
		system = SYSTEM_SCENARIO_SUB_STRIKE
	})

	return
end

function BattleGateScenarioSubStrike:Exit(arg_2_1)
	getProxy(ChapterProxy):getActiveChapter():writeBack(self.statistics._battleScore >= ys.Battle.BattleConst.BattleScore.S, self)
	arg_2_1:sendNotification(GAME.CHAPTER_OP, {
		type = ChapterConst.OPSubStrike,
		arg1 = self.statistics._battleScore,
		callback = function()
			arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
				statistics = self.statistics,
				score = self.statistics._battleScore,
				system = SYSTEM_SCENARIO_SUB_STRIKE
			})

			return
		end
	})

	return
end

function BattleGateScenarioSubStrike:GetPreloadList()
	local var_4_0 = {}
	local var_4_2 = getProxy(BayProxy)

	for iter_4_0, iter_4_1 in ipairs((getProxy(ChapterProxy):getActiveChapter():getChapterSupportFleet():getTeamByName(TeamType.Submarine))) do
		table.insert(var_4_0, (var_4_2:getShipById(iter_4_1)))
	end

	local var_4_3, var_4_4 = ys.Battle.BattleResourceManager.GetInstance():GetPlayerShipResource(self.system)

	return var_4_3, var_4_4
end

return BattleGateScenarioSubStrike
