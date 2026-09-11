ChapterChallengeItemView = import("game.views.chapter.challenge.ChapterChallengeItemView")

local ChapterEquipEnchantmentItemView = class("ChapterEquipEnchantmentItemView", ChapterChallengeItemView)

function ChapterEquipEnchantmentItemView:AddRedPoint()
	self.multiTag_ = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(nil, self.chapterClientID_, true)

	if self.multiTag_ <= 0 and RegressionDataNew:IsRegressionOpen() then
		local var_1_0, var_1_1, var_1_2 = RegressionDataNew:GetMultipleValue()

		if var_1_0 and var_1_0 > 0 and var_1_2 then
			self.multiTag_ = var_1_2
		end
	end

	if self.multiTag_ <= 0 then
		SetActive(self.multiGo_, false)
		manager.redPoint:bindUIandKey(self.panelTf_, RedPointConst.DAILY_EQUIP_ENCHANT)
	else
		self.multiRatioText_.text = self.multiTag_ / 100

		SetActive(self.multiGo_, true)

		local var_1_3 = self.panelTf_:Find("notice_img")

		if var_1_3 then
			SetActive(var_1_3.gameObject, false)
		end
	end
end

function ChapterEquipEnchantmentItemView:RemoveRedPoint()
	if not self.multiTag_ or self.multiTag_ <= 0 then
		manager.redPoint:unbindUIandKey(self.panelTf_, RedPointConst.DAILY_EQUIP_ENCHANT)
	end
end

function ChapterEquipEnchantmentItemView:ClickItem(arg_3_1)
	if self:CheckLock() then
		return
	end

	JumpTools.OpenPageByJump("/enchantment")
end

return ChapterEquipEnchantmentItemView
