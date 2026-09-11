local AshSystemTrustItem = class("AshSystemTrustItem", ReduxView)

function AshSystemTrustItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function AshSystemTrustItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function AshSystemTrustItem:InitUI()
	self:BindCfgUI()
end

function AshSystemTrustItem:RefreshUI()
	local var_4_0 = ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_ASH_COIN_4_4.item_id)

	self.itemText_.text = string.format("<size=84><color=\"#FFEAB4\">%d</color></size><color=\"#D8B884\">/%d</color>", var_4_0, GameSetting.skuld_trust_max.value[1])
	self.fillImage_.fillAmount = var_4_0 / GameSetting.skuld_trust_max.value[1]
end

function AshSystemTrustItem:OnEnter()
	return
end

function AshSystemTrustItem:OnExit()
	self.callback = nil
end

function AshSystemTrustItem:AddUIListener()
	return
end

function AshSystemTrustItem:SetCallBack(arg_8_1)
	self.callBack = arg_8_1
end

function AshSystemTrustItem:Dispose()
	AshSystemTrustItem.super.Dispose(self)
end

return AshSystemTrustItem
