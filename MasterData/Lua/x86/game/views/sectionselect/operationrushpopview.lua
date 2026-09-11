local OperationRushPopView = class("OperationRushPopView", ReduxView)

function OperationRushPopView:UIName()
	return "Widget/System/Operation/OperationRushPopUI"
end

function OperationRushPopView:UIParent()
	return manager.ui.uiPop.transform
end

function OperationRushPopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function OperationRushPopView:InitUI()
	self:BindCfgUI()
end

function OperationRushPopView:OnEnter()
	self.chapterID_ = self.params_.chapterID
	self.stageID_ = self.params_.stageID
	self.stageType_ = self.params_.stageType
	self.multiple_ = self.params_.multiple
	self.activityID_ = self.params_.activityID

	local var_5_0 = ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY)

	self.curDunDunText_.text = var_5_0

	local var_5_2 = (self.params_.cost and self.params_.cost or BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).cost) * self.multiple_

	self.nextDunDunText_.text = var_5_0 - (self.params_.cost and self.params_.cost or BattleStageTools.GetStageCfg(self.stageType_, self.stageID_).cost) * self.multiple_
	self.multipleText_.text = string.format(GetTips("QUICK_BATTLE_TIPS1"), var_5_2, self.multiple_)
end

function OperationRushPopView:AddUIListener()
	self:AddBtnListener(self.yesBtn_, nil, function()
		BattleStageAction.OperationRush(self.chapterID_, self.stageID_, self.stageType_, self.multiple_, self.activityID_, function()
			JumpTools.Back()
		end)
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		self:Back()
	end)
end

return OperationRushPopView
