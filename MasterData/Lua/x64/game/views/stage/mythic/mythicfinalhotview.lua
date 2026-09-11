local MythicFinalHotView = class("MythicFinalHotView", ReduxView)

function MythicFinalHotView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI(self.gameObject_)
	self:AddListeners()

	self.List_ = LuaList.New(handler(self, self.RefreshFilterItem), self.uiList_, MythicFinalHotItem)
	self.levelList_ = MythicFinalCfg.all
	self.handler_ = handler(self, self.OnMythicFinalHotItemClick)
end

function MythicFinalHotView:OnEnter()
	local var_2_0 = MythicData:GetCurHotLevelId()

	self.filterID_ = 1

	if var_2_0 then
		self.filterID_ = table.indexof(MythicFinalCfg.all, var_2_0) or 1
	end

	self:RefreshUI()
	self.List_:StartScroll(#self.levelList_, self.filterID_)
	manager.notify:RegistListener(MYTHIC_FINAL_HOTITEM_CLICK, self.handler_)
end

function MythicFinalHotView:OnExit()
	manager.notify:RemoveListener(MYTHIC_FINAL_HOTITEM_CLICK, self.handler_)
	SetActive(self.filterPanel_, false)
end

function MythicFinalHotView:AddListeners()
	self:AddBtnListener(self.mask_, nil, function()
		SetActive(self.filterPanel_, false)
	end)
	self:AddBtnListener(self.btn_, nil, function()
		SetActive(self.filterPanel_, true)
	end)
	self:AddBtnListener(self.closebtn_, nil, function()
		SetActive(self.filterPanel_, false)
	end)
end

function MythicFinalHotView:RefreshFilterItem(arg_8_1, arg_8_2)
	arg_8_2:SetSpectID(self.levelList_[arg_8_1], arg_8_1, self.filterID_)
end

function MythicFinalHotView:OnMythicFinalHotItemClick(arg_9_1)
	self.filterID_ = arg_9_1

	SetActive(self.filterPanel_, false)
	self:RefreshUI()
end

function MythicFinalHotView:RefreshUI()
	self.levelText_.text = MythicFinalCfg[self.filterID_].id
	self.hotlevelText_.text = string.format(MythicFinalCfg[self.filterID_].level_diffuculty)

	MythicData:SetCurHotLevelId(MythicFinalCfg[self.filterID_].id)

	if MythicData:GetHotLevelIsPass(MythicData:GetCurHotLevelId()) then
		SetActive(self.ispassGo_, true)
	else
		SetActive(self.ispassGo_, false)
	end
end

function MythicFinalHotView:OnMythicFinalUpdate()
	local var_11_0 = MythicData:GetCurHotLevelId()

	self.filterID_ = 1

	if var_11_0 then
		self.filterID_ = table.indexof(MythicFinalCfg.all, var_11_0) or 1
	end

	self:RefreshUI()
	self.List_:StartScroll(#self.levelList_, 1)
end

function MythicFinalHotView:Dispose()
	if self.List_ then
		self.List_:Dispose()

		self.List_ = nil
	end

	MythicFinalHotView.super.Dispose(self)
end

return MythicFinalHotView
