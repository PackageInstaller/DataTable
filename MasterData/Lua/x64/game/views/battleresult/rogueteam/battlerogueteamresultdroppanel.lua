local BattleRogueTeamResultDropPanel = class("BattleRogueTeamResultDropPanel", ReduxView)

function BattleRogueTeamResultDropPanel:Ctor(arg_1_1)
	self.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Activity_Roulike/item/RoguelikeResultPanel"), arg_1_1.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()
end

function BattleRogueTeamResultDropPanel:Dispose()
	BattleRogueTeamResultDropPanel.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function BattleRogueTeamResultDropPanel:AddListeners()
	return
end

function BattleRogueTeamResultDropPanel:OnEnter()
	self:RefreshUI()
end

function BattleRogueTeamResultDropPanel:RefreshUI()
	local var_5_0 = ChallengeRogueTeamData:GetBattleResultData()

	self.treasureCntText_.text = var_5_0[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.TREASURE_CNT]

	SetActive(self.treasureGo_, var_5_0[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.TREASURE_CNT] > 0)

	self.relicCntText_.text = var_5_0[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.RELIC_CNT]

	SetActive(self.relicGo_, var_5_0[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.RELIC_CNT] > 0)

	self.goldCntText_.text = var_5_0[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.GOLD_CNT]

	SetActive(self.goldGo_, var_5_0[ChallengeRogueTeamConst.BATTLE_RESULT_DATA_TYPE.GOLD_CNT] > 0)
end

return BattleRogueTeamResultDropPanel
