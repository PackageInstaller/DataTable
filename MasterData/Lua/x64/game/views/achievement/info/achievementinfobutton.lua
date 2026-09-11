local AchievementInfoButton = class("AchievementInfoButton", ReduxView)

function AchievementInfoButton:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.achievementType_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "toggle")
end

function AchievementInfoButton:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		AchievementData:SetScrollRecord(false)
		self:Go("/achievementInfo", {
			achievementType = self.achievementType_
		})
	end)
end

function AchievementInfoButton:RefreshSelectType(arg_4_1)
	if self.achievementType_ == arg_4_1 then
		self.controller_:SetSelectedState("on")
	else
		self.controller_:SetSelectedState("off")
	end
end

function AchievementInfoButton:Dispose()
	AchievementInfoButton.super.Dispose(self)
end

return AchievementInfoButton
