local ChapterMapToggleView = class("ChapterMapToggleView", ReduxView)

function ChapterMapToggleView:Ctor(arg_1_1, arg_1_2)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.controller_ = ControllerUtil.GetController(self.transform_, "name")
end

function ChapterMapToggleView:OnExit()
	return
end

function ChapterMapToggleView:Dispose()
	ChapterMapToggleView.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function ChapterMapToggleView:AddListeners()
	self:AddBtnListener(self.button_, nil, function()
		if table.keyof(ChapterMainPlotToggleCfg[self.id_].chapter_client_list, self.selectChapterClientID_) then
			return
		end

		BattleFieldData:SetCacheChapterClient(BattleConst.TOGGLE.PLOT, ChapterMainPlotToggleCfg[self.id_].chapter_client_list[1])
		manager.notify:Invoke(CHANGE_PLOT_SELECT_CHAPTER)
	end)
end

function ChapterMapToggleView:SetData(arg_6_1)
	self.id_ = arg_6_1

	self:RefreshUI()
	self:Show(true)
end

function ChapterMapToggleView:SetSelectID(arg_7_1)
	self.selectChapterClientID_ = arg_7_1

	if table.keyof(ChapterMainPlotToggleCfg[self.id_].chapter_client_list, arg_7_1) then
		self.controller_:SetSelectedState("yes")
	else
		self.controller_:SetSelectedState("no")
	end
end

function ChapterMapToggleView:RefreshUI()
	self.text_.text = ChapterMainPlotToggleCfg[self.id_].name
end

function ChapterMapToggleView:Show(arg_9_1)
	SetActive(self.gameObject_, arg_9_1)
end

function ChapterMapToggleView:GetTransform()
	return self.transform_
end

return ChapterMapToggleView
