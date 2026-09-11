ChapterChallengeItemView = import("game.views.chapter.challenge.ChapterChallengeItemView")

local ChapterEquipExperienceItemView = class("ChapterEquipExperienceItemView", ChapterChallengeItemView)

function ChapterEquipExperienceItemView:ClickItem(arg_1_1)
	local var_1_0

	if self:CheckLock() then
		do return end

		var_1_0 = {}
	end

	var_1_0.chapterID = ChapterClientCfg[arg_1_1].chapter_list[1]

	JumpTools.OpenPageByJump("/daily", var_1_0)
end

function ChapterEquipExperienceItemView:AddRedPoint()
	self.multiTag_ = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(nil, self.chapterClientID_, true)

	if self.multiTag_ <= 0 and RegressionDataNew:IsRegressionOpen() then
		local var_2_0, var_2_1, var_2_2 = RegressionDataNew:GetMultipleValue()

		if var_2_0 and var_2_0 > 0 and var_2_2 then
			self.multiTag_ = var_2_2
		end
	end

	if self.multiTag_ <= 0 then
		SetActive(self.multiGo_, false)
		manager.redPoint:bindUIandKey(self.panelTf_, ChapterTools.GetRedPoint(self.chapterClientID_))
	else
		self.multiRatioText_.text = self.multiTag_ / 100

		SetActive(self.multiGo_, true)

		local var_2_3 = self.panelTf_:Find("notice_img")

		if var_2_3 then
			SetActive(var_2_3.gameObject, false)
		end
	end
end

function ChapterEquipExperienceItemView:RemoveRedPoint()
	if not self.multiTag_ or self.multiTag_ <= 0 then
		manager.redPoint:unbindUIandKey(self.panelTf_, ChapterTools.GetRedPoint(self.chapterClientID_))
	end
end

return ChapterEquipExperienceItemView
