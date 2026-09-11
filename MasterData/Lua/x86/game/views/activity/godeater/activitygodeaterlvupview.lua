local ActivityGodEaterLvUpView = class("ActivityGodEaterLvUpView", ReduxView)

function ActivityGodEaterLvUpView:UIName()
	return "Widget/Version/V4_2_GodEaterUI/V4_2_GodEaterUI_AFK/V4_2_GodEaterUI_AFK_LvUpPopUI"
end

function ActivityGodEaterLvUpView:UIParent()
	return manager.ui.uiPop.transform
end

function ActivityGodEaterLvUpView:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivityGodEaterLvUpView:InitUI()
	self:BindCfgUI()
end

function ActivityGodEaterLvUpView:OnEnter()
	self:RefreshUI()
end

function ActivityGodEaterLvUpView:OnTop()
	return
end

function ActivityGodEaterLvUpView:RefreshUI()
	if self.params_ then
		local var_7_1

		if self.params_ then
			var_7_1 = self.params_.nowlV or 2

			if ActivityGodEaterLevelCfg[self.params_.lastlV or 1] and ActivityGodEaterLevelCfg[var_7_1] then
				self.levelnumText_.text = string.format("%s", var_7_1)
				self.textdesc01Text_.text = GetTips("GODEATER_LV_DES_1")
				self.textdesc02Text_.text = GetTips("GODEATER_LV_DES_2")
			end
		end
	end

	local var_7_2 = var_7_1 == GameSetting.godeater_subactivity_unlock1.value[1]

	SetActive(self.tab03Go_, var_7_1 == GameSetting.godeater_subactivity_unlock1.value[1])

	if var_7_2 then
		self.textdesc03Text_.text = GetTips("GODEATER_DES_6")
	end
end

function ActivityGodEaterLvUpView:AddUIListeners()
	self:AddBtnListener(self.bgmaskBtn_, nil, function()
		self:Back()
	end)
end

function ActivityGodEaterLvUpView:OnExit()
	manager.windowBar:HideBar()
	self:StopTimer()
	self:RemoveTween()
end

function ActivityGodEaterLvUpView:RemoveTween()
	return
end

function ActivityGodEaterLvUpView:StopTimer()
	return
end

function ActivityGodEaterLvUpView:Dispose()
	ActivityGodEaterLvUpView.super.Dispose(self)
end

return ActivityGodEaterLvUpView
