local AchievementManagerButton = class("AchievementManagerButton", ReduxView)

function AchievementManagerButton:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.achievementType_ = arg_1_2

	self:BindCfgUI()
	self:AddListeners()
end

function AchievementManagerButton:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		AchievementData:SetScrollRecord(false)
		self:Go("/achievementInfo", {
			achievementType = self.achievementType_
		})
	end)
end

function AchievementManagerButton:OnEnter()
	self.imageProcess_.fillAmount = AchievementData:GetFinishAchievementCnt(self.achievementType_) / AchievementData:GetAchievementCnt(self.achievementType_)

	SetActive(self.goTips_, manager.redPoint:getTipValue(string.format("%s_%s", RedPointConst.ACHIEVEMENT, self.achievementType_)) > 0)
end

function AchievementManagerButton:Dispose()
	AchievementManagerButton.super.Dispose(self)
end

return AchievementManagerButton
