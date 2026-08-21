local var_0_0 = class("BattleGateScenarioSubStrike")

ys.Battle.BattleGateScenarioSubStrike = var_0_0
var_0_0.__name = "BattleGateScenarioSubStrike"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	arg_1_1:sendNotification(GAME.BEGIN_STAGE_DONE, {
		prefabFleet = {},
		stageId = getProxy(ChapterProxy):getActiveChapter():getConfigMiscArg("submarine_support"),
		system = SYSTEM_SCENARIO_SUB_STRIKE
	})

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	getProxy(ChapterProxy):getActiveChapter():writeBack(arg_2_0.statistics._battleScore >= ys.Battle.BattleConst.BattleScore.S, arg_2_0)
	arg_2_1:sendNotification(GAME.CHAPTER_OP, {
		type = ChapterConst.OPSubStrike,
		arg1 = arg_2_0.statistics._battleScore,
		callback = function()
			arg_2_1:sendNotification(GAME.FINISH_STAGE_DONE, {
				statistics = arg_2_0.statistics,
				score = arg_2_0.statistics._battleScore,
				system = SYSTEM_SCENARIO_SUB_STRIKE
			})

			return
		end
	})

	return
end

function var_0_0.GetPreloadList(arg_4_0)
	local var_4_1 = getProxy(BayProxy)

	for iter_4_0, iter_4_1 in ipairs((getProxy(ChapterProxy):getActiveChapter():getChapterSupportFleet():getTeamByName(TeamType.Submarine))) do
		table.insert({}, (var_4_1:getShipById(iter_4_1)))
	end

	local var_4_2, var_4_3 = ys.Battle.BattleResourceManager.GetInstance().GetPlayerShipResource({}, arg_4_0.system)

	return var_4_2, var_4_3
end

return var_0_0
