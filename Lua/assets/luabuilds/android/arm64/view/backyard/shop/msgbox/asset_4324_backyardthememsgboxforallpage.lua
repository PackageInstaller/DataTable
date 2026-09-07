local BackYardThemeMsgBoxForAllPage = class("BackYardThemeMsgBoxForAllPage", import(".BackYardThemeMsgBoxPage"))

function BackYardThemeMsgBoxForAllPage:SetUp(arg_1_1, arg_1_2, arg_1_3)
	BackYardThemeMsgBoxForAllPage.super.SetUp(self, arg_1_1, arg_1_2, arg_1_3)

	self.purchase.text = i18n("purchase_backyard_theme_desc_for_all")

	setActive(self.purchaseTr, true)
	setText(self.gemPurchaseBtn:Find("content/Text"), i18n("word_buy"))
	setText(self.goldPurchaseBtn:Find("content/Text"), i18n("word_buy"))

	return
end

function BackYardThemeMsgBoxForAllPage:GetAddList()
	local var_2_0 = {}
	local var_2_1 = self.dorm:GetPurchasedFurnitures()

	for iter_2_0, iter_2_1 in ipairs((self.themeVO:GetFurnitures())) do
		if pg.furniture_data_template[iter_2_1].count > 1 then
			for iter_2_2 = 1, pg.furniture_data_template[iter_2_1].count - self.dorm:GetOwnFurnitureCount(iter_2_1) do
				table.insert(var_2_0, Furniture.New({
					id = iter_2_1
				}))
			end
		elseif not var_2_1[iter_2_1] then
			table.insert(var_2_0, Furniture.New({
				id = iter_2_1
			}))
		end
	end

	return var_2_0
end

return BackYardThemeMsgBoxForAllPage
