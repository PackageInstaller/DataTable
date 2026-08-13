class = var_0_10000

local var_0_0 = var_0_10000("BattleGateScenarioSubStrike")

ys = var_0_10001
var_0_10001.Battle.BattleGateScenarioSubStrike = var_0_0
var_0_0.__name = "BattleGateScenarioSubStrike"

function var_0_0.Entrance(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.getActiveChapter(var_1_0)
	local var_1_2 = var_3.getConfigMiscArg(var_1_1, "submarine_support")
	local var_1_3 = {
		prefabFleet = {},
		stageId = var_1_2
	}

	SYSTEM_SCENARIO_SUB_STRIKE = var_6
	var_1_3.system = var_6

	local var_1_4 = arg_1_1
	local var_1_5 = arg_1_1.sendNotification

	GAME = var_1_10009

	var_1_5(var_1_4, var_1_10009.BEGIN_STAGE_DONE, var_1_3)

	return
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ChapterProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.getActiveChapter(var_2_0)
	local var_2_2 = arg_2_0.statistics._battleScore

	ys = var_2_0

	local var_2_3 = var_2_2 >= var_2_0.Battle.BattleConst.BattleScore.S

	var_2_1:writeBack(var_2_3, arg_2_0)

	local function var_2_4()
		local var_3_0 = arg_2_1
		local var_3_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_3_2 = var_2_10003.FINISH_STAGE_DONE
		local var_3_3 = {
			statistics = arg_2_0.statistics,
			score = arg_2_0.statistics._battleScore
		}

		SYSTEM_SCENARIO_SUB_STRIKE = var_5
		var_3_3.system = var_5

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end

	local var_2_5 = arg_2_1
	local var_2_6 = arg_2_1.sendNotification

	GAME = var_9

	local var_2_7 = var_9.CHAPTER_OP
	local var_2_8 = {}

	ChapterConst = var_1_10011
	var_2_8.type = var_1_10011.OPSubStrike
	var_2_8.arg1 = arg_2_0.statistics._battleScore
	var_2_8.callback = var_2_4

	var_2_6(var_2_5, var_2_7, var_2_8)

	return
end

function var_0_0.GetPreloadList(arg_4_0)
	local var_4_0 = {}
	local var_4_1

	getProxy = var_1_10003
	BayProxy = var_1_10005

	local var_4_2 = var_1_10003(var_1_10005)

	getProxy = var_1_10004
	ChapterProxy = var_1_10006

	local var_4_3 = var_1_10004(var_1_10006)

	ys = var_1_10005

	local var_4_4 = var_1_10005.Battle.BattleResourceManager.GetInstance()
	local var_4_5 = var_4_3:getActiveChapter()
	local var_4_6 = var_6.getChapterSupportFleet(var_4_5)
	local var_4_7 = var_7.getTeamByName

	TeamType = var_1_10011

	local var_4_8 = var_4_7(var_4_6, var_1_10011.Submarine)

	ipairs = var_4_5

	for iter_4_0, iter_4_1 in var_4_5(var_4_8) do
		local var_4_9 = var_4_2:getShipById(iter_4_1)

		table = var_1_10015

		var_1_10015.insert(var_4_0, var_4_9)
	end

	local var_4_10, var_4_11 = var_4_4.GetPlayerShipResource(var_4_0, arg_4_0.system)

	return var_4_10, var_4_11
end

return var_0_0
