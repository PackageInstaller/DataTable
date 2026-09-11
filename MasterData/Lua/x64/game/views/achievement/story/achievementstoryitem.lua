local AchievementStoryItem = class("AchievementStoryItem", ReduxView)

function AchievementStoryItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = ControllerUtil.GetController(self.transform_, "state")

	self:SetData(arg_1_2)
	self:Refresh()
end

function AchievementStoryItem:AddListeners()
	self:AddBtnListener(self.buttonStory_, nil, function()
		if AchievementData:GetStoryReadFlag(self.id_) ~= true then
			AchievementAction.ReadAchievementStory(self.id_, function(arg_4_0)
				if isSuccess(arg_4_0.result) then
					self:Refresh()
				else
					ShowTips(arg_4_0.result)
				end
			end)
		end

		JumpTools.OpenPageByJump("achievementStoryInfo", {
			storyID = self.id_
		})
	end)
end

function AchievementStoryItem:SetData(arg_5_1)
	self.id_ = arg_5_1
	self.textTitle_.text = GetI18NText(AchievementStoryCfg[self.id_].name)
	self.textTitle2_.text = GetI18NText(AchievementStoryCfg[self.id_].name)
end

function AchievementStoryItem:Refresh()
	if AchievementStoryCfg[self.id_].unlock_point <= AchievementData:GetAchievementPoint() then
		self.stateController_:SetSelectedState("unlock")
	else
		self.stateController_:SetSelectedState("lock")
	end

	if AchievementData:GetStoryReadFlag(self.id_) == true then
		SetActive(self.goRedPoint_, false)
	else
		SetActive(self.goRedPoint_, true)
	end
end

function AchievementStoryItem:Dispose()
	AchievementStoryItem.super.Dispose(self)
end

return AchievementStoryItem
