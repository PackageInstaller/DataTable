local ShopContentViewBase = class("ShopContentViewBase", ReduxView)

function ShopContentViewBase:OnCtor(arg_1_1)
	self.containerGo_ = arg_1_1

	self:Init()
end

function ShopContentViewBase:Init()
	self:InitUI()
	self:AddUIListener()
end

function ShopContentViewBase:InitUI()
	self:BindCfgUI()
end

function ShopContentViewBase:AddUIListener()
	return
end

function ShopContentViewBase:ScrollByPosition(arg_5_1, arg_5_2)
	return
end

function ShopContentViewBase:ResetFilter()
	return
end

function ShopContentViewBase:SetShopId(arg_7_1)
	self.shopId_ = arg_7_1
end

function ShopContentViewBase:SetShopHideHome(arg_8_1)
	self.hideHomeBtn_ = arg_8_1
end

function ShopContentViewBase:UpdateBarByShopId()
	local var_9_0 = {}

	table.insert(var_9_0, BACK_BAR)

	if self.hideHomeBtn_ == nil or self.hideHomeBtn_ == 0 then
		table.insert(var_9_0, HOME_BAR)
	end

	table.insert(var_9_0, NAVI_BAR)

	local var_9_1 = {}

	for iter_9_0 = 1, #ShopListCfg[self.shopId_].cost_id do
		local var_9_2 = CurrencyIdMapCfg[ShopListCfg[self.shopId_].cost_id[iter_9_0]] and CurrencyIdMapCfg[ShopListCfg[self.shopId_].cost_id[iter_9_0]].item_id or ShopListCfg[self.shopId_].cost_id[iter_9_0]

		if var_9_2 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			var_9_2 = CurrencyConst.GetPlatformDiamondId()
		end

		table.insert(var_9_0, var_9_2)
		table.insert(var_9_1, var_9_2)
	end

	manager.windowBar:SwitchBar(var_9_0)

	for iter_9_1 = 1, #var_9_1 do
		local var_9_3 = var_9_1[iter_9_1]

		manager.windowBar:SetBarCanAdd(var_9_1[iter_9_1], ShopConst.ADD_CURRENCY[var_9_1[iter_9_1]] == true and _G.CHANNEL_MASTER_ID == 1)

		if var_9_3 == CurrencyIdMapCfg.CURRENCY_TYPE_DORM_GOLD.item_id then
			manager.windowBar:SetBarCanClick(var_9_3, true)
		end
	end
end

function ShopContentViewBase:OnShopClick(arg_10_1)
	local var_10_0 = getShopCfg(arg_10_1.id, self.shopId_)

	if ItemCfg[var_10_0.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		if ShopTools.HaveSkin(var_10_0.give_id) then
			return
		end
	elseif var_10_0.limit_num then
		if var_10_0.limit_num ~= -1 and var_10_0.limit_num <= arg_10_1.buyTime then
			return
		end

		local var_10_1, var_10_2 = ShopTools.JudgeIsLvLimit(var_10_0.level_limit)

		if var_10_1 then
			return
		end
	end

	JumpTools.OpenPopUp("shopBuy", {
		goodInfo = arg_10_1
	})
end

function ShopContentViewBase:GetShopGoodList()
	return ShopTools.FilterShopDataList(self.shopId_)
end

function ShopContentViewBase:GetLuaList()
	return self.list_
end

function ShopContentViewBase:GetItemList()
	return
end

function ShopContentViewBase:RefreshShopGoodInfo(arg_14_1)
	for iter_14_0, iter_14_1 in pairs(self:GetItemList()) do
		local var_14_0 = iter_14_1:GetItemInfo()
		local var_14_1 = ShopData.GetShop(self.shopId_)[arg_14_1]

		if var_14_1 ~= nil then
			local var_14_2 = var_14_1.buy_times or 0

			if arg_14_1 == var_14_0.id and var_14_2 ~= var_14_0.buyTime then
				iter_14_1:SetData({
					id = arg_14_1,
					shopId = self.shopId_,
					buyTime = var_14_2,
					next_refresh_timestamp = var_14_1.next_refresh_timestamp
				})
			end
		end
	end
end

function ShopContentViewBase:RefreshList(arg_15_1)
	self:UpdateBarByShopId()
end

function ShopContentViewBase:OnEnter()
	return
end

function ShopContentViewBase:OnExit()
	return
end

function ShopContentViewBase:Dispose()
	ShopContentViewBase.super.Dispose(self)
end

function ShopContentViewBase:GetScrolledPosition()
	return self:GetLuaList():GetScrolledPosition()
end

return ShopContentViewBase
