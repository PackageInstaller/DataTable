local ChapterPartBtnView = class("ChapterPartBtnView", ReduxView)

function ChapterPartBtnView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()

	self.partBtnItemList_ = {}

	for iter_1_0 = 1, self.transform_.childCount do
		local var_1_0 = self[string.format("chapterPart%sGo_", iter_1_0)]

		if var_1_0 then
			self.partBtnItemList_[iter_1_0] = ChapterPartBtnItem.New(var_1_0, iter_1_0)
		end
	end
end

function ChapterPartBtnView:OnEnter()
	for iter_2_0, iter_2_1 in ipairs(self.partBtnItemList_) do
		iter_2_1:OnEnter()
	end
end

function ChapterPartBtnView:OnExit()
	for iter_3_0, iter_3_1 in ipairs(self.partBtnItemList_) do
		iter_3_1:OnExit()
	end
end

function ChapterPartBtnView:Dispose()
	ChapterPartBtnView.super.Dispose(self)

	for iter_4_0, iter_4_1 in ipairs(self.partBtnItemList_) do
		iter_4_1:Dispose()
	end

	self.partBtnItemList_ = nil
end

function ChapterPartBtnView:Show(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function ChapterPartBtnView:RefreshUI(arg_6_1)
	local var_6_0 = getChapterClientCfgByChapterID(arg_6_1)

	if #var_6_0.chapter_list > 1 and (var_6_0.id == ChapterConst.CHAPTER_CLIENT_XUHENG_PART_2_2 or var_6_0.id == ChapterConst.CHAPTER_CLIENT_LUWU_ZHIMING or var_6_0.id == ChapterConst.CHAPTER_CLIENT_OUMOFEISI or var_6_0.id == ChapterConst.CHAPTER_CLIENT_BAICHAO or var_6_0.id == ChapterConst.CHAPTER_CLIENT_KEERGAI or var_6_0.id == ChapterConst.CHAPTER_CLIENT_21) then
		self:Show(true)

		for iter_6_0 = 1, self.transform_.childCount do
			if self.partBtnItemList_[iter_6_0] then
				if not var_6_0.chapter_list[iter_6_0] then
					self.partBtnItemList_[iter_6_0]:SetActive(false)
				else
					self.partBtnItemList_[iter_6_0]:SetActive(true)
					self.partBtnItemList_[iter_6_0]:SetChapterID(var_6_0.chapter_list[iter_6_0], arg_6_1)
				end
			end
		end
	else
		self:Show(false)
	end
end

return ChapterPartBtnView
