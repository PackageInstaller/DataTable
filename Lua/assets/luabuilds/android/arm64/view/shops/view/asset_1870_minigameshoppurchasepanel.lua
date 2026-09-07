local MiniGameShopPurchasePanel = class("MiniGameShopPurchasePanel", import(".GuildShopPurchasePanel"))

function MiniGameShopPurchasePanel:getUIName()
	return "MiniGameShopPurchaseMsgUI"
end

function MiniGameShopPurchasePanel:Show(arg_2_1)
	MiniGameShopPurchasePanel.super.Show(self, arg_2_1)

	self.confirmCallback = arg_2_1.confirm

	return
end

function MiniGameShopPurchasePanel:OnConfirm()
	if self.confirmCallback then
		self.confirmCallback(self.data.id, self.selectedList)
	end

	return
end

return MiniGameShopPurchasePanel
