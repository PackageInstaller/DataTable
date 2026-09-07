local MedalShopPurchasePanel = class("MedalShopPurchasePanel", import(".GuildShopPurchasePanel"))

function MedalShopPurchasePanel:getUIName()
	return "MedalShopPurchaseMsgUI"
end

function MedalShopPurchasePanel:OnConfirm()
	self:emit(NewShopMainMediator.ON_MEDAL_SHOPPING, self.data.id, self.selectedList)

	return
end

return MedalShopPurchasePanel
