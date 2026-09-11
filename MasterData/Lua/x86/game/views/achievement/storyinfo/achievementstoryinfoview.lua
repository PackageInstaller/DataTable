local AchievementStoryInfoView = class("AchievementStoryInfoView", ReduxView)

function AchievementStoryInfoView:UIName()
	return "Widget/System/AchievementsUI/AchievementStoryInfoUI"
end

function AchievementStoryInfoView:UIParent()
	return manager.ui.uiPop.transform
end

function AchievementStoryInfoView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function AchievementStoryInfoView:OnEnter()
	local var_4_0 = AchievementStoryCfg[self.params_.storyID]

	SetActive(self.imageBg_.gameObject, AchievementStoryCfg[self.params_.storyID].bg ~= "")

	if var_4_0.bg ~= "" then
		self.imageBg_.sprite = getSpriteViaConfig("Loading", var_4_0.bg)
	end

	self.textTitle_.text = GetI18NText(var_4_0.name)
	self.textContent_.text = GetI18NText(var_4_0.desc)
	self.scrollView_.verticalNormalizedPosition = 1
end

function AchievementStoryInfoView:OnExit()
	return
end

function AchievementStoryInfoView:Dispose()
	AchievementStoryInfoView.super.Dispose(self)
end

function AchievementStoryInfoView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		self:Back()
	end)
end

return AchievementStoryInfoView
