local ChapterDailyItemView = class("ChapterDailyItemView", import("..ChapterBaseItemView"))

function ChapterDailyItemView:OnEnter()
	ChapterDailyItemView.super.OnEnter(self)
	self:AddRedPoint()
end

function ChapterDailyItemView:OnExit()
	ChapterDailyItemView.super.OnExit(self)
	self:RemoveRedPoint()
end

function ChapterDailyItemView:RefreshCustomItem(arg_3_1)
	if self.oldCfgID_ ~= arg_3_1.id then
		self.nameText_.text = GetI18NText(arg_3_1.name)

		SetSpriteWithoutAtlasAsync(self.icon_, arg_3_1.drop_icon)

		self.oldCfgID_ = arg_3_1.id
	end
end

function ChapterDailyItemView:ClickItem(arg_4_1)
	if self:CheckLock() then
		return
	end

	local var_4_1 = BattleFieldData:GetStageByClientID(arg_4_1)

	JumpTools.OpenPageByJump("/daily", {
		chapterID = (var_4_1 or nil) and getChapterIDByStageID(var_4_1)
	})
end

function ChapterDailyItemView:AddRedPoint()
	self.multiTag_ = ActivityMultiRewardData:GetMultiRatioByChapterOrToggle(nil, self.chapterClientID_, true)

	if self.multiTag_ <= 0 and RegressionDataNew:IsRegressionOpen() then
		local var_5_0, var_5_1, var_5_2 = RegressionDataNew:GetMultipleValue()

		if var_5_0 and var_5_0 > 0 and var_5_2 then
			self.multiTag_ = var_5_2
		end
	end

	if self.multiTag_ <= 0 then
		SetActive(self.multiGo_, false)
		manager.redPoint:bindUIandKey(self.panelTf_, ChapterTools.GetRedPoint(self.chapterClientID_))
	else
		self.multiRatioText_.text = self.multiTag_ / 100

		SetActive(self.multiGo_, true)

		local var_5_3 = self.panelTf_:Find("notice_img")

		if var_5_3 then
			SetActive(var_5_3.gameObject, false)
		end
	end
end

function ChapterDailyItemView:RemoveRedPoint()
	if not self.multiTag_ or self.multiTag_ <= 0 then
		manager.redPoint:unbindUIandKey(self.panelTf_, ChapterTools.GetRedPoint(self.chapterClientID_))
	end
end

return ChapterDailyItemView
