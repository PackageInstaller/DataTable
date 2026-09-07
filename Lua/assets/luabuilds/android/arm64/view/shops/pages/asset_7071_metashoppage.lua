local MetaShopPage = class("MetaShopPage", import(".ActivitySelectableShopPage"))

function MetaShopPage:ResId2ItemId(arg_1_1)
	return arg_1_1
end

function MetaShopPage:SetResIcon()
	MetaShopPage.super.SetResIcon(self, DROP_TYPE_ITEM)

	return
end

function MetaShopPage:UpdateTip()
	self.tipText.text = i18n("meta_shop_tip")

	return
end

function MetaShopPage:SetPurchaseConfirmCb(arg_4_1)
	self.purchaseWindow:ExecuteAction("SetConfirmCb", function(arg_5_0, arg_5_1, arg_5_2)
		self:emit(NewShopMainMediator.ON_META_SHOP, self.shop.activityId, 1, arg_5_0, arg_5_2, arg_5_1)

		return
	end)
	self.purchaseWindow:ExecuteAction("Hide")

	return
end

function MetaShopPage:OnUpdatePlayer()
	return
end

function MetaShopPage:OnUpdateItems()
	self:RefreshResItemList()

	return
end

function MetaShopPage:GetResDataList()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs((self.shop:GetResList())) do
		local var_8_1 = self.items[iter_8_1]
		local var_8_3

		if not self.items[iter_8_1] then
			var_8_1 = Item.New({
				count = 0,
				id = iter_8_1
			})
			var_8_3 = {
				type = DROP_TYPE_ITEM,
				resID = iter_8_1
			}
		end

		var_8_3.cnt = var_8_1.count

		table.insert(var_8_0, var_8_3)
	end

	return var_8_0
end

function MetaShopPage:RefreshUI()
	self:UpdateTip()
	setActive(self.tipTextGo, true)
	setActive(self.helpBtn, false)
	setActive(self.resolveBtn, false)
	setActive(self.refreshBtn, false)

	return
end

function MetaShopPage:OnPurchase(arg_10_1, arg_10_2)
	self:emit(NewShopMainMediator.ON_META_SHOP, self.shop.activityId, 1, arg_10_1.id, arg_10_2, {
		{
			key = arg_10_1:getConfig("commodity_id"),
			value = arg_10_2
		}
	})

	return
end

function MetaShopPage:GetPaintingName()
	local var_11_0, var_11_1, var_11_2 = MetaShopPage.super.GetPaintingName(self)

	return type(var_11_0) == "table" and var_11_0[math.random(1, #var_11_0)] or var_11_0, var_11_1, var_11_2
end

return MetaShopPage
