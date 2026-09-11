local SkuldSystemTrustItem = class("SkuldSystemTrustItem", ReduxView)

function SkuldSystemTrustItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function SkuldSystemTrustItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function SkuldSystemTrustItem:InitUI()
	self:BindCfgUI()
end

function SkuldSystemTrustItem:RefreshUI()
	local var_4_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_SKULD_COIN_4_0.item_id)

	self.itemText_.text = var_4_0 .. "/" .. GameSetting.skuld_trust_max.value[1]
	self.fillImage_.fillAmount = var_4_0 / GameSetting.skuld_trust_max.value[1]
end

function SkuldSystemTrustItem:OnEnter()
	manager.redPoint:bindUIandKey(self.transform_, RedPointConst.SKULD_SYSTEM_TRUST_ALL)
end

function SkuldSystemTrustItem:OnExit()
	self.callback = nil

	manager.redPoint:unbindUIandKey(self.transform_, RedPointConst.SKULD_SYSTEM_TRUST_ALL)
end

function SkuldSystemTrustItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callBack then
			self.callBack()
		end

		JumpTools.OpenPageByJump("skuldSystemTrustView")
	end)
end

function SkuldSystemTrustItem:SetCallBack(arg_9_1)
	self.callBack = arg_9_1
end

function SkuldSystemTrustItem:Dispose()
	SkuldSystemTrustItem.super.Dispose(self)
end

return SkuldSystemTrustItem
