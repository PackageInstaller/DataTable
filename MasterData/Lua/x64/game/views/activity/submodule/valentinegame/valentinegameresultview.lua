local ValentineGameResultView = class("ValentineGameResultView", ReduxView)

function ValentineGameResultView:UIName()
	return ValentineGameTools.GetResultUIName(self.params_.activityID)
end

function ValentineGameResultView:UIParent()
	return manager.ui.uiMain.transform
end

function ValentineGameResultView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ValentineGameResultView:InitUI()
	self:BindCfgUI()

	self.indexCon_ = ControllerUtil.GetController(self.gameObject_.transform, "index")
end

function ValentineGameResultView:AddUIListeners()
	self:AddBtnListener(self.bgBtn_, nil, function()
		if self.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			JumpTools.OpenPageByJump("/valentineGameTest", {
				activityID = self.params_.mainActivityID
			})
		end
	end)
end

function ValentineGameResultView:OnEnter()
	self:RefreshUI()
end

function ValentineGameResultView:RefreshUI()
	self.indexCon_:SetSelectedState(table.indexof(ActivityCfg[self.params_.mainActivityID].sub_activity_list, self.params_.activityID))

	local var_8_0, var_8_1 = ValentineGameTools.GetPointRule(self.params_.mainActivityID)

	if self.params_.point <= var_8_0 then
		self.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_1")
		self.completeText_.text = GetI18NText(ActivityValentineCfg[self.params_.activityID].result_desc[1])
	elseif self.params_.point <= var_8_1 then
		self.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_2")
		self.completeText_.text = GetI18NText(ActivityValentineCfg[self.params_.activityID].result_desc[2])
	else
		self.resultText_.text = GetTips("ACTIVITY_VALENTINE_RESULT_TITLE_3")
		self.completeText_.text = GetI18NText(ActivityValentineCfg[self.params_.activityID].result_desc[3])
	end
end

function ValentineGameResultView:OnTop()
	manager.windowBar:HideBar()
end

function ValentineGameResultView:OnExit()
	self.canvasGroup_.alpha = 0
end

function ValentineGameResultView:Dispose()
	self:RemoveAllListeners()
	self.super.Dispose(self)
end

return ValentineGameResultView
