local DecomposeConfirmPopView = class("DecomposeConfirmPopView", ReduxView)

function DecomposeConfirmPopView:UIName()
	return "Widget/System/Bag/SplitGetPopUI"
end

function DecomposeConfirmPopView:UIParent()
	return manager.ui.uiPop.transform
end

function DecomposeConfirmPopView:Init()
	self:InitUI()
	self:AddListeners()
end

function DecomposeConfirmPopView:InitUI()
	self:BindCfgUI()

	self.itemScroller_ = LuaList.New(handler(self, self.indexItem), self.itemListGo_, CommonItemView)
	self.returnScroller_ = LuaList.New(handler(self, self.indexReturnItem), self.returnListGo_, CommonItemView)
end

function DecomposeConfirmPopView:AddListeners()
	self:AddBtnListener(self.btnConfirm_, nil, function()
		if self.type_ == "equip" then
			EquipAction.EquipDecompose(self.params_.itemList)
		elseif self.type_ == "servant" then
			ServantAction.ServantDecompose(self.params_.itemList)
		end

		self:Back()
	end)
	self:AddBtnListener(self.btnBack_, nil, function()
		self:Back()
	end)
end

function DecomposeConfirmPopView:OnEnter()
	self.type_ = self.params_.type
	self.itemList_ = self:SortItem(self.params_.itemList)
	self.returnList_ = self.params_.returnList

	self.itemScroller_:StartScroll(#self.itemList_)
	self.returnScroller_:StartScroll(#self.returnList_)
end

function DecomposeConfirmPopView:SortItem(arg_9_1)
	local var_9_0 = {}

	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		table.insert(var_9_0, iter_9_1)
	end

	table.sort(var_9_0, function(arg_10_0, arg_10_1)
		return ItemCfg[arg_10_0.id or arg_10_0.prefab_id].rare < ItemCfg[arg_10_1.id or arg_10_1.prefab_id].rare
	end)

	return var_9_0
end

function DecomposeConfirmPopView:indexItem(arg_11_1, arg_11_2)
	local var_11_0 = clone(ItemTemplateData)
	local var_11_1 = self.itemList_[arg_11_1]

	if self.type_ == "equip" then
		var_11_0.id = var_11_1.prefab_id or var_11_1.id
	end

	var_11_0.hideBottomRightTextFlag = true

	if self.type_ == "equip" then
		var_11_0.equipLevel = EquipTools.CountEquipLevel(var_11_1)
	end

	arg_11_2:SetData(var_11_0)
end

function DecomposeConfirmPopView:indexReturnItem(arg_12_1, arg_12_2)
	local var_12_0 = clone(ItemTemplateData)

	var_12_0.id = self.returnList_[arg_12_1].id
	var_12_0.number = self.returnList_[arg_12_1].number

	arg_12_2:SetData(var_12_0)
end

function DecomposeConfirmPopView:OnExit()
	return
end

function DecomposeConfirmPopView:Dispose()
	self.itemScroller_:Dispose()
	self.returnScroller_:Dispose()
	DecomposeConfirmPopView.super.Dispose(self)
end

return DecomposeConfirmPopView
