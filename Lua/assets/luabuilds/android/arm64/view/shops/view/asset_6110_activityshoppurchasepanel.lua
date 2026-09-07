local ActivityShopPurchasePanel = class("ActivityShopPurchasePanel", import(".GuildShopPurchasePanel"))

function ActivityShopPurchasePanel:Show(arg_1_1)
	ActivityShopPurchasePanel.super.Show(self, arg_1_1)

	if arg_1_1.icon then
		GetImageSpriteFromAtlasAsync(arg_1_1.icon, "", self.resIcon)
	end

	return
end

function ActivityShopPurchasePanel:SetConfirmCb(arg_2_1)
	self.confirmCallback = arg_2_1

	return
end

function ActivityShopPurchasePanel:OnConfirm()
	if self.confirmCallback then
		local var_3_0 = {}
		local var_3_1 = {}

		for iter_3_0, iter_3_1 in ipairs(self.selectedList) do
			var_3_1[iter_3_1] = var_3_1[iter_3_1] or 0
			var_3_1[iter_3_1] = var_3_1[iter_3_1] + 1
		end

		for iter_3_2, iter_3_3 in pairs(var_3_1) do
			table.insert(var_3_0, {
				key = iter_3_2,
				value = iter_3_3
			})
		end

		self.confirmCallback(self.data.id, var_3_0, #self.selectedList)
	end

	return
end

return ActivityShopPurchasePanel
