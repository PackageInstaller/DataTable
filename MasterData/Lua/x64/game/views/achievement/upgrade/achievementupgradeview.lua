local AchievementUpgradeView = class("AchievementUpgradeView", ReduxView)

function AchievementUpgradeView:UIName()
	return "Widget/System/AchievementsUI/AchievementUpgradeUI"
end

function AchievementUpgradeView:UIParent()
	return manager.ui.uiPop.transform
end

function AchievementUpgradeView:Init()
	self:BindCfgUI()
	self:AddListeners()
end

function AchievementUpgradeView:OnEnter()
	LeanTween.value(self.gameObject_, self.params_.currentPoint / self.params_.upgradePoint, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
		self.slider_.value = arg_5_0
	end)):setOnComplete(System.Action(function()
		self.canCancel_ = true

		LeanTween.cancel(self.gameObject_)
	end))
end

function AchievementUpgradeView:OnExit()
	LeanTween.cancel(self.gameObject_)
end

function AchievementUpgradeView:Dispose()
	AchievementUpgradeView.super.Dispose(self)
end

function AchievementUpgradeView:AddListeners()
	self:AddBtnListener(self.buttonClose_, nil, function()
		if self.canCancel_ then
			self:Back()
		end
	end)
end

return AchievementUpgradeView
