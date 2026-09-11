local DailyChapterItemBtn = class("DailyChapterItemBtn", ReduxView)

function DailyChapterItemBtn:OnCtor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.parentView_ = arg_1_1
	self.gameObject_ = Object.Instantiate(arg_1_2, arg_1_3.transform)
	self.transform_ = self.gameObject_.transform
	self.chapterID_ = arg_1_4

	SetActive(self.gameObject_, true)
	self:Init()
end

function DailyChapterItemBtn:Init()
	self:BindCfgUI()
	self:AddListeners()
	self:IsLock()
	self:RefreshItem()
end

function DailyChapterItemBtn:Dispose()
	self.parentView_ = nil

	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.btn_ = nil
	self.gameObject_ = nil
	self.text_ = nil
	self.canvasGroup_ = nil
	self.unsubscribeFun = nil
	self.selector_ = nil
	self.lockGo_ = nil

	DailyChapterItemBtn.super.Dispose(self)
end

function DailyChapterItemBtn:SetData(arg_4_1)
	self.chapterID_ = arg_4_1

	self:IsLock()
	self:RefreshItem()
end

function DailyChapterItemBtn:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.isLock_ then
			return
		end

		self.parentView_:SwitchDailyChapter(self.chapterID_)
	end)
end

function DailyChapterItemBtn:RefreshItem()
	if self.isLock_ then
		SetActive(self.lockGo_, true)

		self.canvasGroup_.alpha = 0.5
	else
		SetActive(self.lockGo_, false)

		self.canvasGroup_.alpha = 1
	end

	self.text_.text = GetI18NText(ChapterCfg[self.chapterID_].subhead)
end

function DailyChapterItemBtn:SetSiblingIndex(arg_8_1)
	self.transform_:SetSiblingIndex(arg_8_1)
end

function DailyChapterItemBtn:IsLock()
	self.isLock_ = BattleStageData:GetStageData()[ChapterCfg[self.chapterID_].section_id_list[1]] == nil
end

return DailyChapterItemBtn
