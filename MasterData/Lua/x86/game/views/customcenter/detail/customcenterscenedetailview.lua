local CustomCenterSceneDetailView = class("CustomCenterSceneDetailView", ReduxView)

function CustomCenterSceneDetailView:UIName()
	return "Widget/System/CustomCenter/CustomCenterDetailUI"
end

local var_0_1 = {
	DESC = 1,
	TAG = 2
}

function CustomCenterSceneDetailView:UIParent()
	return manager.ui.uiMain.transform
end

function CustomCenterSceneDetailView:Init()
	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}
	self.typeController_ = self.controllerEx_:GetController("type")
	self.showDescController = self.controllerEx_:GetController("showDesc")

	function self.onItemSelect(arg_4_0)
		self:OnItemSelect(arg_4_0)
	end

	function self.onItemClearSelect(arg_5_0)
		self:OnItemClearSelect(arg_5_0)
	end
end

function CustomCenterSceneDetailView:OnEnter()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	self.sceneID_ = self.params_.sceneID
	self.curType_ = var_0_1.DESC

	self:RefreshUI()
end

function CustomCenterSceneDetailView:OnExit()
	self:SetTagDetail(nil, nil)
	manager.windowBar:HideBar()
end

function CustomCenterSceneDetailView:Dispose()
	for iter_8_0, iter_8_1 in ipairs(self.itemList_) do
		iter_8_1:Dispose()
	end

	self.itemList_ = {}

	CustomCenterSceneDetailView.super.Dispose(self)
end

function CustomCenterSceneDetailView:AddListeners()
	self:AddBtnListener(self.typeBtn_, nil, function()
		self.curType_ = self.curType_ == var_0_1.DESC and var_0_1.TAG or var_0_1.DESC

		self:SwitchType()
	end)
end

function CustomCenterSceneDetailView:RefreshUI()
	self.titleText_.text = HomeSceneSettingCfg[self.sceneID_].title
	self.descText_.text = HomeSceneSettingCfg[self.sceneID_].desc

	self:SwitchType(HomeSceneSettingCfg[self.sceneID_])
	self:RefreshItemList(HomeSceneSettingCfg[self.sceneID_].scene_tag)
end

function CustomCenterSceneDetailView:SwitchType()
	self.tagTglGroup_:SetAllTogglesOff()

	if self.curType_ == var_0_1.DESC then
		self.typeController_:SetSelectedState("desc")
	else
		self.typeController_:SetSelectedState("tag")
	end
end

function CustomCenterSceneDetailView:RefreshItemList(arg_13_1)
	for iter_13_0 = 1, #arg_13_1 do
		local var_13_0 = self.itemList_[iter_13_0] or CustomCenterSceneDetailTagItem.New(self.itemGo_, self.itemParent_)

		self.itemList_[iter_13_0] = var_13_0

		var_13_0:SetData(arg_13_1[iter_13_0])
		var_13_0:SetOnSelectCallback(self.onItemSelect)
		var_13_0:SetOnClearCallback(self.onItemClearSelect)
	end

	for iter_13_1 = #arg_13_1 + 1, #self.itemList_ do
		self.itemList_[iter_13_1]:Show(false)
	end
end

function CustomCenterSceneDetailView:OnItemSelect(arg_14_1)
	self:SetTagDetail(arg_14_1.cfg.tag_desc, arg_14_1.cfg.tag_detail)
end

function CustomCenterSceneDetailView:OnItemClearSelect(arg_15_1)
	self:SetTagDetail(nil, nil)
end

function CustomCenterSceneDetailView:SetTagDetail(arg_16_1, arg_16_2)
	if arg_16_2 then
		self.tagName_.text = arg_16_1
		self.tagDesc_.text = arg_16_2

		self.showDescController:SetSelectedState("true")
	else
		self.showDescController:SetSelectedState("false")
	end
end

return CustomCenterSceneDetailView
