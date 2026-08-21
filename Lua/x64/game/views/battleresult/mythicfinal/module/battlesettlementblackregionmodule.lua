local var_0_0 = class("BattleSettlementBlackRegionModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_0:InstView(arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.InstView(arg_2_0, arg_2_1)
	local var_2_0 = "Widget/System/BattleResult/Common/Module/BattleBlackRegionContent"

	return (Object.Instantiate(Asset.Load(var_2_0), arg_2_1))
end

function var_0_0.BuildContext(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.RenderView(arg_7_0, arg_7_1)
	arg_7_0.stageData = arg_7_1.stageData

	local var_7_0
	local var_7_1 = arg_7_0.stageData:GetDest() == 0 and 1 or arg_7_0.stageData:GetDest()

	arg_7_0.teamindextext_.text = string.format(var_7_1 .. "/" .. #MythicData:GetCurLevelIdList())

	arg_7_0:RenderBattleTime()
	arg_7_0:RenderPoint()
end

function var_0_0.RenderBattleTime(arg_8_0)
	local var_8_0 = GetTips("DAY")
	local var_8_1 = GetTips("HOUR")
	local var_8_2 = GetTips("TIP_MINUTE")
	local var_8_3 = GetTips("SECOND")
	local var_8_4 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime
	local var_8_5 = math.floor(var_8_4 / 86400)
	local var_8_6 = math.fmod(math.floor(var_8_4 / 3600), 24)
	local var_8_7 = math.floor(math.fmod(math.floor(var_8_4 / 60), 60))
	local var_8_8 = math.floor(math.fmod(var_8_4, 60))

	arg_8_0.sec1Txt_.text = var_8_3
	arg_8_0.wasteSecondTxt_.text = var_8_8

	if var_8_7 > 0 then
		arg_8_0.min1Txt_.text = var_8_2
		arg_8_0.wasteMinuteTxt_.text = var_8_7
	else
		arg_8_0.min1Txt_.text = ""
		arg_8_0.wasteMinuteTxt_.text = ""
	end

	local var_8_9 = MythicData:GetBattlingTime()
	local var_8_10 = math.floor(var_8_9 / 86400)
	local var_8_11 = math.fmod(math.floor(var_8_9 / 3600), 24)
	local var_8_12 = math.floor(math.fmod(math.floor(var_8_9 / 60), 60))
	local var_8_13 = math.floor(math.fmod(var_8_9, 60))

	arg_8_0.sec2Txt_.text = var_8_3
	arg_8_0.reminSecondTxt_.text = var_8_13

	if var_8_12 > 0 then
		arg_8_0.min2Txt_.text = var_8_2
		arg_8_0.reminMinuteTxt_.text = var_8_12
	else
		arg_8_0.min2Txt_.text = ""
		arg_8_0.reminMinuteTxt_.text = ""
	end
end

function var_0_0.RenderPoint(arg_9_0)
	if #MythicData:GetCurLevelIdList() > 1 and arg_9_0.stageData:GetDest() < #MythicData:GetCurLevelIdList() then
		SetActive(arg_9_0.scoreObj_, false)
	else
		if not MythicData:GetIsNew() then
			RankAction.QueryOwnCommonRank(RankConst.RANK_ID.MATRIX)
			MythicAction.UpdateMythicFinalRedPoint()
		end

		SetActive(arg_9_0.scoreObj_, true)

		arg_9_0.scoreTxt_.text = MythicData:GetCurPoint()
	end
end

function var_0_0.Dispose(arg_10_0)
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
