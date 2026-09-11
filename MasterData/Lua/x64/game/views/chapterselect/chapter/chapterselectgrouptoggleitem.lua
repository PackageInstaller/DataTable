local ChapterSelectGroupToggleItem = class("ChapterSelectGroupToggleItem", ReduxView)

function ChapterSelectGroupToggleItem:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.finishAllController_ = self.controllerEx_:GetController("finishAll")
end

function ChapterSelectGroupToggleItem:SetData(arg_2_1)
	self.groupID_ = arg_2_1
	self.nameText_.text = ChapterMainPlotToggleCfg[arg_2_1].name

	self.finishAllController_:SetSelectedState(tostring(self:IsCollectAllStar()))
	self.transform_:SetAsLastSibling()
	self:Show(true)
end

function ChapterSelectGroupToggleItem:IsCollectAllStar()
	for iter_3_0, iter_3_1 in ipairs(ChapterMainPlotToggleCfg[self.groupID_].chapter_client_list) do
		if ChapterTools.GetChapterClientFinishPercentage(iter_3_1) ~= 1 then
			return false
		end
	end

	return true
end

function ChapterSelectGroupToggleItem:Dispose()
	ChapterSelectGroupToggleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterSelectGroupToggleItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		BattleFieldAction.ChangeSelectChapterID(ChapterClientCfg[ChapterMainPlotToggleCfg[self.groupID_].chapter_client_list[1]].chapter_list[1])
	end)
end

function ChapterSelectGroupToggleItem:Show(arg_7_1)
	SetActive(self.gameObject_, arg_7_1)
end

return ChapterSelectGroupToggleItem
