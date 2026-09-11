local AssetPendToggleItem = class("AssetPendToggleItem", ReduxView)

function AssetPendToggleItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.id_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("select")

	self:RefreshUI()
end

function AssetPendToggleItem:Dispose()
	AssetPendToggleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function AssetPendToggleItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(ASSET_PEND_CLICK_TOGGLE, self.id_)
	end)
end

function AssetPendToggleItem:RefreshUI()
	self.nameText1_.text = AssetPendToggleCfg[self.id_].toggle_name
	self.nameText2_.text = AssetPendToggleCfg[self.id_].toggle_name

	SetActive(self.gameObject_, true)
end

function AssetPendToggleItem:RefreshSelectState(arg_6_1)
	if self.id_ == arg_6_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

return AssetPendToggleItem
