local ChapterSelectSubChapterToggleItem = class("ChapterSelectSubChapterToggleItem", ReduxView)

function ChapterSelectSubChapterToggleItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()

	self.paintImage_.immediate = true

	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.isCompleteController_ = self.controllerEx_:GetController("clear")
	self.tagController_ = self.controllerEx_:GetController("showTag")

	self:OnEnter()
end

function ChapterSelectSubChapterToggleItem:SetData(arg_2_1)
	if self.chapterClientID_ then
		manager.redPoint:unbindUIandKey(self.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, self.chapterClientID_))
	end

	self.chapterClientID_ = arg_2_1
	self.paintImage_.spriteAsync = SpritePathCfg.ChapterPaint.path .. ChapterClientCfg[arg_2_1].chapter_paint

	self.tagController_:SetSelectedState(ChapterTools.GetChapterShowTypeData(arg_2_1))
	manager.redPoint:bindUIandKey(self.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, self.chapterClientID_))
	self:Show(true)
end

function ChapterSelectSubChapterToggleItem:OnEnter()
	return
end

function ChapterSelectSubChapterToggleItem:OnExit()
	if self.chapterClientID_ then
		manager.redPoint:unbindUIandKey(self.redRoot_, string.format("%s_%s", RedPointConst.COMBAT_SUB_PLOT, self.chapterClientID_))
	end
end

function ChapterSelectSubChapterToggleItem:SetSelect(arg_5_1)
	local var_5_0

	if self.chapterClientID_ == nil then
		do return end

		var_5_0 = tostring
	end

	self.isCompleteController_:SetSelectedState(var_5_0(ChapterTools.GetChapterClientFinishPercentage(self.chapterClientID_) == 1))
	self.selectController_:SetSelectedState(tostring(arg_5_1))
	self.transform_:SetAsLastSibling()
end

function ChapterSelectSubChapterToggleItem:RefreshLock()
	if self.chapterClientID_ == nil then
		return
	end

	self.isLock_ = not ChapterTools.IsUnlockSubPlotClient(ChapterClientCfg[self.chapterClientID_].chapter_list[1])

	self.lockController_:SetSelectedState(tostring(self.isLock_))
end

function ChapterSelectSubChapterToggleItem:Dispose()
	ChapterSelectSubChapterToggleItem.super.Dispose(self)

	self.paintImage_ = nil

	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterSelectSubChapterToggleItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if ChapterClientCfg[BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.SUB_PLOT)].id ~= self.chapterClientID_ then
			BattleFieldAction.ChangeSelectChapterID((BattleFieldData:GetCacheChapter(self.chapterClientID_)))

			return
		end
	end)
end

function ChapterSelectSubChapterToggleItem:SetLocalPosition(arg_10_1)
	self.transform_.localPosition = arg_10_1
end

function ChapterSelectSubChapterToggleItem:GetLocalPosition()
	return self.transform_.localPosition
end

function ChapterSelectSubChapterToggleItem:Show(arg_12_1)
	SetActive(self.gameObject_, arg_12_1)
end

function ChapterSelectSubChapterToggleItem:GetChapterClientID()
	return self.chapterClientID_
end

return ChapterSelectSubChapterToggleItem
