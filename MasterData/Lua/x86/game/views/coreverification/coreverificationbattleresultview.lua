BattleScoreResultView = import("game.views.battleResult.score.BattleScoreResultView")

local CoreVerificationBattleResultView = class("CoreVerificationBattleResultView", BattleScoreResultView)

function CoreVerificationBattleResultView:UIName()
	return "Widget/System/BattleResult/BattleCoreVerification/CoreVerificationBattleResult"
end

function CoreVerificationBattleResultView:InitUI()
	self.hasSnapshot_ = GetBattleResultSnapShot()

	self:BindCfgUI()
end

function CoreVerificationBattleResultView:AddListener()
	self:AddBtnListener(self.btnBack_, nil, function()
		self:CloseFunc()
	end)
	self:AddBtnListener(self.statisticsBtn_, nil, function()
		self:GoToBattleStatistics()
	end)
end

function CoreVerificationBattleResultView:RefreshUI()
	local var_6_0 = self.stageData:GetDest()

	self.battleTime2Text_.text = self:GetBattleTime()

	local var_6_1 = CoreVerificationInfoCfg[var_6_0]

	self.titleText_.text = CoreVerificationData:IsChallengeType(var_6_0) and GetTips("CORE_VERIFICATION_TAB_DES_2") or string.format(GetTips("CORE_VERIFICATION_TAB_DES_1"), GetTips("NUM_" .. CoreVerificationInfoCfg[var_6_0].difficult))

	SetActive(self.battlescoreGo_, var_6_1.stage_type == 1)

	if var_6_1.stage_type == 1 then
		self.battlescoreText_.text = CoreVerificationData:GetSuperScore(var_6_0)
	end
end

function CoreVerificationBattleResultView:GoToBattleStatistics()
	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = self.params_.stageData,
		battleTime = self:GetBattleTime(),
		hasSnapshot_ = self.hasSnapshot_
	})
end

function CoreVerificationBattleResultView:OnExit()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self.stageData:GetHeroTeam()) do
		if iter_8_1 ~= 0 then
			table.insert(var_8_0, iter_8_1)
		end
	end

	CoreVerificationData:BattleStageData(self.stageData:GetDest(), var_8_0, LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

return CoreVerificationBattleResultView
