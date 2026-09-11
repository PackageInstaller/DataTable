local ChapterSelectChapterToggleItem = class("ChapterSelectChapterToggleItem", ReduxView)

function ChapterSelectChapterToggleItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("select")
	self.lockController_ = self.controllerEx_:GetController("lock")
	self.isCompleteController_ = self.controllerEx_:GetController("isComplete")
end

function ChapterSelectChapterToggleItem:SetData(arg_2_1, arg_2_2)
	self.chapterClientID_ = arg_2_1

	local var_2_0 = ChapterClientCfg[arg_2_1]

	self.nameText_.text = ChapterClientCfg[arg_2_1].toggle == BattleConst.TOGGLE.PLOT and var_2_0.desc or var_2_0.name

	local var_2_1 = ChapterTools.GetChapterClientFinishPercentage(arg_2_1)

	self.percentageText_.text = string.format("%s%%", math.floor(var_2_1 * 100))

	self.isCompleteController_:SetSelectedState(tostring(var_2_1 == 1))

	self.isLock_ = not ChapterTools.IsFinishPreChapter(var_2_0.chapter_list[1])

	self.lockController_:SetSelectedState(tostring(self.isLock_))
	self.selectController_:SetSelectedState(tostring(arg_2_2))
	self.transform_:SetAsLastSibling()
	self:Show(true)
end

function ChapterSelectChapterToggleItem:Dispose()
	ChapterSelectChapterToggleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterSelectChapterToggleItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if ChapterClientCfg[BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.PLOT)].id ~= self.chapterClientID_ then
			BattleFieldAction.ChangeSelectChapterID((BattleFieldData:GetCacheChapter(self.chapterClientID_)))

			return
		end
	end)
end

function ChapterSelectChapterToggleItem:GetLocalPosition()
	return self.transform_.localPosition
end

function ChapterSelectChapterToggleItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

return ChapterSelectChapterToggleItem
