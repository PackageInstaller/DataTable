BattleScoreResultView = import("game.views.battleResult.score.BattleScoreResultView")

local var_0_0 = class("SoloHeartDemonResultView", BattleScoreResultView)
local var_0_1 = {
	"SOLO_HEART_DEMON_EASY",
	"SOLO_HEART_DEMON_HARD",
	"SOLO_HEART_DEMON_NIGHTMARE"
}

function var_0_0.UIName(arg_1_0)
	return "UI/BattleResult/SoloHeartMultipletUI"
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.AddListener(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.btnBack_, nil, function()
		arg_3_0:CloseFunc()
	end)
end

function var_0_0.RefreshUI(arg_5_0)
	local var_5_0 = BattleTools.GetBattleStatisticsData()
	local var_5_1 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua
	local var_5_2 = var_5_1.recordDatas
	local var_5_3

	arg_5_0.missTimes = 0

	if var_5_2:TryGetValue(8, var_5_3) then
		arg_5_0.missTimes = var_5_2[8] or 0
	end

	arg_5_0.hitTime = 0

	if var_5_2:TryGetValue(61, var_5_3) then
		arg_5_0.hitTime = var_5_2[61] or 0
	end

	arg_5_0.battleTime = var_5_1.battleTime
	arg_5_0.hitDamage = tonumber(tostring(var_5_0[1].hurt))
	arg_5_0.battleTime2Text_.text = arg_5_0:GetBattleTime()

	local var_5_4 = SoloHeartDemonData:GetDataByPara("stageToDifficulty")[arg_5_0.stageData:GetDest()]
	local var_5_5 = SoloHeartDemonData:GetDataByPara("difficultyData")[var_5_4]

	arg_5_0.hitDamageTxt_.text = tostring(arg_5_0.hitTime)
	arg_5_0.difficultytext.text = GetTips(var_0_1[var_5_4])

	SetActive(arg_5_0.hitNewGo_, arg_5_0.hitTime < var_5_5.hitTime)
	SetActive(arg_5_0.timeNewGo_, var_5_5.shortestBattleTime > arg_5_0.battleTime)

	arg_5_0.score = SoloHeartDemonData:GetDataByPara("battleScore") or 0
	arg_5_0.scoreTxt_.text = arg_5_0.score

	SetActive(arg_5_0.scoreNewGo_, arg_5_0.score > var_5_5.maxScore)
end

function var_0_0.OnSoloDemonHeartScoreUpdate(arg_6_0)
	local var_6_0 = stageToDifficulty[arg_6_0.stageData:GetDest()]
	local var_6_1 = SoloHeartDemonData:GetDataByPara("difficultyData")[var_6_0]

	arg_6_0.scoreTxt_.text = SoloHeartDemonData:GetDataByPara("battleScore")

	SetActive(arg_6_0.scoreNewGo_, SoloHeartDemonData:GetDataByPara("battleScore") > var_6_1.maxScore)
end

function var_0_0.OnExit(arg_7_0)
	SoloHeartDemonData:UpdateBattleFinishData(2, arg_7_0.battleTime, arg_7_0.score, arg_7_0.hitDamage, arg_7_0.missTimes, arg_7_0.hitTime, arg_7_0.stageData:GetDest())
end

return var_0_0
