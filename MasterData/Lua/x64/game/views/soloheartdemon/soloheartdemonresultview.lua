BattleScoreResultView = import("game.views.battleResult.score.BattleScoreResultView")

local SoloHeartDemonResultView = class("SoloHeartDemonResultView", BattleScoreResultView)
local var_0_1 = {
	"SOLO_HEART_DEMON_EASY",
	"SOLO_HEART_DEMON_HARD",
	"SOLO_HEART_DEMON_NIGHTMARE"
}

function SoloHeartDemonResultView:UIName()
	return "UI/BattleResult/SoloHeartMultipletUI"
end

function SoloHeartDemonResultView:InitUI()
	self:BindCfgUI()
end

function SoloHeartDemonResultView:AddListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:CloseFunc()
	end)
end

function SoloHeartDemonResultView:RefreshUI()
	local var_5_0 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua

	self.missTimes = 0

	if var_5_0.recordDatas:TryGetValue(8, nil) then
		self.missTimes = var_5_0.recordDatas[8] or 0
	end

	self.hitTime = 0

	if var_5_0.recordDatas:TryGetValue(61, nil) then
		self.hitTime = var_5_0.recordDatas[61] or 0
	end

	self.battleTime = var_5_0.battleTime
	self.hitDamage = tonumber(tostring(BattleTools.GetBattleStatisticsData()[1].hurt))
	self.battleTime2Text_.text = self:GetBattleTime()

	local var_5_1 = SoloHeartDemonData:GetDataByPara("stageToDifficulty")[self.stageData:GetDest()]
	local var_5_2 = SoloHeartDemonData:GetDataByPara("difficultyData")[var_5_1]

	self.hitDamageTxt_.text = tostring(self.hitTime)
	self.difficultytext.text = GetTips(var_0_1[var_5_1])

	SetActive(self.hitNewGo_, self.hitTime < var_5_2.hitTime)
	SetActive(self.timeNewGo_, var_5_2.shortestBattleTime > self.battleTime)

	self.score = SoloHeartDemonData:GetDataByPara("battleScore") or 0
	self.scoreTxt_.text = self.score

	SetActive(self.scoreNewGo_, self.score > var_5_2.maxScore)
end

function SoloHeartDemonResultView:OnSoloDemonHeartScoreUpdate()
	local var_6_0 = SoloHeartDemonData:GetDataByPara("difficultyData")[stageToDifficulty[self.stageData:GetDest()]]

	self.scoreTxt_.text = SoloHeartDemonData:GetDataByPara("battleScore")

	SetActive(self.scoreNewGo_, SoloHeartDemonData:GetDataByPara("battleScore") > var_6_0.maxScore)
end

function SoloHeartDemonResultView:OnExit()
	SoloHeartDemonData:UpdateBattleFinishData(2, self.battleTime, self.score, self.hitDamage, self.missTimes, self.hitTime, self.stageData:GetDest())
end

return SoloHeartDemonResultView
