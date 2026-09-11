local BattleSeaWarfareResultView = class("BattleSeaWarfareResultView", ReduxView)

function BattleSeaWarfareResultView:UIName()
	return "Widget/System/SandPlay_QuanZhou/QuanZhou_Navigation/QuanZhou_NabigationBattleResult"
end

function BattleSeaWarfareResultView:UIParent()
	return manager.ui.uiPop.transform
end

function BattleSeaWarfareResultView:Init()
	self:InitUI()
	self:AddListener()
end

function BattleSeaWarfareResultView:InitUI()
	self:BindCfgUI()

	self.resultController_ = self.controllerEx_:GetController("battleResult")
	self.stageTypeController_ = self.controllerEx_:GetController("stageType")
	self.successText_.text = GetTips("SUCCESS")
	self.failText_.text = GetTips("FAIL")
	self.reChallengeBtnText_.text = GetTips("CHALLENGE_AGAIN")
	self.comfirmBtnText_.text = GetTips("ROGUE_TEAM_BUTTON_CONFIRM")
end

function BattleSeaWarfareResultView:AddListener()
	self:AddBtnListener(self.backBtn_, nil, function()
		BattleInstance.QuitBattle(self.params_.stageData, not self.isSuccess_)
	end)
	self:AddBtnListener(self.onceMoreBtn_, nil, function()
		BattleInstance.OnceMoreBattle(self.params_.stageData)
	end)
end

function BattleSeaWarfareResultView:OnEnter()
	self.stageData_ = self.params_.stageData
	self.isSuccess_ = self.params_.isSuccess

	self:RefreshUI()
end

function BattleSeaWarfareResultView:OnTop()
	self.anim_:Play("UI_Tag1_loop 1", -1, 0)
	self.anim_:Update(0)
end

function BattleSeaWarfareResultView:RefreshUI()
	self.stageTitle_.text = BattleSeaWarfareStageCfg[self.stageData_:GetStageId()].name

	self.resultController_:SetSelectedState(self.isSuccess_ == true and "win" or "lose")

	self.resultText_.text = GetTips(self.isSuccess_ == true and "CHALLENGE_SUCCESS" or "CHALLENGE_FAIL")

	self:RefreshStageType()
	self:RefreshPopReward()
end

function BattleSeaWarfareResultView:RefreshStageType()
	self.seaWarfareStageID_ = self.stageData_:GetDest()

	if SeaWarfareStageCfg[self.seaWarfareStageID_].type == SeaWarfareConst.STAGE_TYPE.NORMAL then
		self.stageTypeController_:SetSelectedState("normal")
	else
		self.stageTypeController_:SetSelectedState("challenge")
	end
end

function BattleSeaWarfareResultView:RefreshPopReward()
	local var_12_0 = SeaWarfareTools.GetNeedPopFirstRewardStageID()

	if var_12_0 then
		SeaWarfareTools.SetNeedPopFirstRewardStageID(nil)
		showRewardUI((getRewardFromDropCfg(SeaWarfareStageCfg[var_12_0].reward, true)))
	end
end

return BattleSeaWarfareResultView
