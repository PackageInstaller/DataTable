ChapterChallengeItemWithCD = import("game.views.chapter.challenge.ChapterChallengeItemWithCD")

local ChapterEquipItemView = class("ChapterEquipItemView", ChapterChallengeItemWithCD)

function ChapterEquipItemView:GetLostTime()
	local var_1_0 = BattleEquipData:GetBattleEquipData().next_refresh_time

	if var_1_0 < manager.time:GetServerTime() then
		BattleEquipAction.RequestBattleEquipInfo()

		return var_1_0 + 86400
	end

	return var_1_0
end

function ChapterEquipItemView:ClickItem(arg_2_1)
	local var_2_0

	if self:CheckLock() then
		do return end

		var_2_0 = {}
	end

	var_2_0.chapterID = ChapterClientCfg[arg_2_1].chapter_list[1]

	JumpTools.OpenPageByJump("/equipSection", var_2_0, ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION)
end

function ChapterEquipItemView:AddRedPoint()
	self.multiTag_ = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(nil, self.chapterClientID_, true)

	if self.multiTag_ <= 0 and RegressionDataNew:IsRegressionOpen() then
		local var_3_0, var_3_1, var_3_2 = RegressionDataNew:GetMultipleValue()

		if var_3_0 and var_3_0 > 0 and var_3_2 then
			self.multiTag_ = var_3_2
		end
	end

	if self.multiTag_ <= 0 then
		SetActive(self.multiGo_, false)
		manager.redPoint:bindUIandKey(self.panelTf_, ChapterTools.GetRedPoint(self.chapterClientID_))
	else
		self.multiRatioText_.text = self.multiTag_ / 100

		SetActive(self.multiGo_, true)

		local var_3_3 = self.panelTf_:Find("notice_img")

		if var_3_3 then
			SetActive(var_3_3.gameObject, false)
		end
	end
end

function ChapterEquipItemView:RemoveRedPoint()
	if not self.multiTag_ or self.multiTag_ <= 0 then
		manager.redPoint:unbindUIandKey(self.panelTf_, ChapterTools.GetRedPoint(self.chapterClientID_))
	end
end

return ChapterEquipItemView
