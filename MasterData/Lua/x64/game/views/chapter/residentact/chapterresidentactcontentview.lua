local ChapterResidentActContentView = class("ChapterResidentActContentView", ReduxView)

function ChapterResidentActContentView:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.chapterToggle_ = arg_1_2
	self.actItemList = {}
	self.viewList = {}

	self:InitUI()

	self.changeSelectHandler_ = handler(self, self.ScrollAndClickItemByActivityID)
end

function ChapterResidentActContentView:OnEnter(arg_2_1)
	self.params_ = arg_2_1

	self:RefreshUI()
	manager.notify:RegistListener(CHAPTER_RESIDENT_ACT_SWITCH_VIEW, self.changeSelectHandler_)
end

function ChapterResidentActContentView:OnExit()
	manager.notify:RemoveListener(CHAPTER_RESIDENT_ACT_SWITCH_VIEW, self.changeSelectHandler_)

	for iter_3_0, iter_3_1 in pairs(self.actItemList or {}) do
		if iter_3_1 then
			iter_3_1:OnExit()

			iter_3_1 = nil
		end
	end

	for iter_3_2, iter_3_3 in pairs(self.viewList or {}) do
		if iter_3_3 then
			iter_3_3:OnExit()

			iter_3_3 = nil
		end
	end
end

function ChapterResidentActContentView:Dispose()
	for iter_4_0, iter_4_1 in pairs(self.actItemList or {}) do
		if iter_4_1 then
			iter_4_1:Dispose()

			iter_4_1 = nil
		end
	end

	self.actItemList = nil

	for iter_4_2, iter_4_3 in pairs(self.viewList or {}) do
		if iter_4_3 then
			iter_4_3:Dispose()

			iter_4_3 = nil
		end
	end

	self.viewList = nil

	ChapterResidentActContentView.super.Dispose(self)
end

function ChapterResidentActContentView:SetActive(arg_5_1)
	SetActive(self.gameObject_, arg_5_1)
end

function ChapterResidentActContentView:InitUI()
	self:BindCfgUI()
end

function ChapterResidentActContentView:OnClickSelect(arg_7_1)
	if self.selectActItem and self.selectActItem:GetChapterID() == arg_7_1:GetChapterID() then
		return false
	end

	if self.selectActItem then
		self.selectActItem:UpdateSelectState(false)

		local var_7_1 = self.selectActItem:GetChapterID()

		if self.viewList[var_7_1] then
			self.viewList[var_7_1]:RefreshUI()
			self.viewList[var_7_1]:SetActive(false)
		end
	end

	self.selectActItem = arg_7_1

	self.selectActItem:UpdateSelectState(true)

	local var_7_2 = self.selectActItem:GetChapterID()

	self.viewList[var_7_2] = self.viewList[var_7_2] or ChapterResidentTools.GetResidentActViewClass(self.selectActItem:GetActID()):New(self.contentNode_)

	self.viewList[var_7_2]:RefreshUI()
	self.viewList[var_7_2]:SetActive(true)
	BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.RESIDENT_ACT, var_7_2)
end

function ChapterResidentActContentView:RefreshUI()
	self:RefreshUIActItemList()
	self:DefaultSelectIndex()
end

function ChapterResidentActContentView:GetCacheActivityID()
	local var_9_0 = BattleFieldData:GetCacheChapterClient(BattleConst.TOGGLE.RESIDENT_ACT)

	if var_9_0 then
		return ChapterClientCfg[var_9_0].activity_id
	end
end

function ChapterResidentActContentView:DefaultSelectIndex()
	if self.params_ then
		local var_10_0 = self.params_.activityID or self:GetCacheActivityID()

		if var_10_0 then
			if (self.selectActItem and self.selectActItem:GetActID() or nil) == var_10_0 then
				local var_10_1 = self.selectActItem:GetChapterID()

				if self.viewList[var_10_1] then
					self.viewList[var_10_1]:RefreshUI()
					self:ScrollToIndex(var_10_0)

					return
				end
			end

			for iter_10_0, iter_10_1 in pairs(self.actItemList) do
				if iter_10_1:GetActID() == var_10_0 then
					self:OnClickSelect(iter_10_1)

					return
				end
			end
		end

		if not self.selectActItem then
			self:OnClickSelect(self.actItemList[1])

			goto label_10_0
		end
	end

	do
		local var_10_2 = self.selectActItem:GetChapterID()

		if self.viewList[var_10_2] then
			self.viewList[var_10_2]:RefreshUI()
		end
	end

	::label_10_0::
end

function ChapterResidentActContentView:RefreshUIActItemList()
	self.actDataList = ChapterResidentTools.GetResidentChapterOpenList()

	for iter_11_0, iter_11_1 in pairs(self.actDataList or {}) do
		self.actItemList[iter_11_0] = self.actItemList[iter_11_0] or self:CreateActItem()

		self.actItemList[iter_11_0]:SetData(iter_11_1)
	end
end

function ChapterResidentActContentView:CreateActItem()
	local var_12_0 = Object.Instantiate(self.actItemGo_, self.listContent_)
	local var_12_1 = ChapterResidentActItem.New(var_12_0)

	SetActive(var_12_0, true)
	var_12_1:SetClickCallback(handler(self, self.OnClickSelect))

	return var_12_1
end

function ChapterResidentActContentView:ScrollToIndex(arg_13_1)
	local var_13_0 = 1

	for iter_13_0, iter_13_1 in pairs(self.actItemList) do
		if iter_13_1:GetActID() == arg_13_1 then
			var_13_0 = iter_13_0
		end
	end

	self.scrollView_.content.anchoredPosition = Vector2.New(0, (var_13_0 - 1) * 132)
end

function ChapterResidentActContentView:ScrollAndClickItemByActivityID(arg_14_1)
	for iter_14_0, iter_14_1 in pairs(self.actItemList) do
		if iter_14_1:GetActID() == arg_14_1 then
			self:OnClickSelect(iter_14_1)

			break
		end
	end

	self:ScrollToIndex(arg_14_1)
end

return ChapterResidentActContentView
