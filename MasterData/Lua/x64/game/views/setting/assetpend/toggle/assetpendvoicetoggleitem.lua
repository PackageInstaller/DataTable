local AssetPendVoiceToggleItem = class("AssetPendVoiceToggleItem", ReduxView)

function AssetPendVoiceToggleItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.id_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.selectController_ = self.controllerEx_:GetController("select")

	self:RefreshUI()
end

function AssetPendVoiceToggleItem:Dispose()
	AssetPendVoiceToggleItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.gameObject_ = nil
	self.transform_ = nil
end

function AssetPendVoiceToggleItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		manager.notify:Invoke(ASSET_PEND_CLICK_TOGGLE, self.id_)
	end)
end

function AssetPendVoiceToggleItem:RefreshUI()
	local var_5_0 = GetTips("ASSET_PEND_VOICE")

	self.nameText1_.text = var_5_0
	self.nameText2_.text = var_5_0

	SetActive(self.gameObject_, true)
end

function AssetPendVoiceToggleItem:RefreshSelectState(arg_6_1)
	if self.id_ == arg_6_1 then
		self.selectController_:SetSelectedState("true")
	else
		self.selectController_:SetSelectedState("false")
	end
end

return AssetPendVoiceToggleItem
