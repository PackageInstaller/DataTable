local BackYardShopFilterPanel = class("BackYardShopFilterPanel", import("...Decoration.panles.BackYardDecorationFilterPanel"))

function BackYardShopFilterPanel:SortForDecorate(arg_1_1, arg_1_2)
	local var_1_0 = arg_1_2[2]
	local var_1_1 = arg_1_2[3]

	local function var_1_2(arg_2_0)
		if arg_2_0:getConfig("new") == -1 then
			return 0
		elseif arg_2_0:canPurchaseByGem() and not arg_2_0:canPurchaseByDormMoeny() then
			return 1
		elseif arg_2_0:canPurchaseByGem() and arg_2_0:canPurchaseByDormMoeny() then
			return 3
		elseif arg_2_0:canPurchaseByDormMoeny() then
			return 4
		else
			return 5
		end

		return
	end

	local function var_1_3(arg_3_0)
		if arg_3_0:getConfig("new") > 0 then
			return 4
		elseif pg.furniture_shop_template[arg_3_0.configId].time ~= "always" then
			return 3
		elseif pg.furniture_shop_template[arg_3_0.configId].time == "always" then
			return 2
		else
			return 1
		end

		return
	end

	function BackYardShopFilterPanel:SortByDefault1(arg_4_1)
		local var_4_0 = var_1_2(self)
		local var_4_1 = var_1_2(arg_4_1)

		if var_4_0 == var_4_1 then
			local var_4_2 = var_1_3(self)
			local var_4_3 = var_1_3(arg_4_1)

			if var_4_2 == var_4_3 then
				return self.id < arg_4_1.id
			else
				return var_4_2 < var_4_3
			end
		else
			return var_4_0 < var_4_1
		end

		return
	end

	function BackYardShopFilterPanel:SortByDefault2(arg_5_1)
		local var_5_0 = var_1_2(self)
		local var_5_1 = var_1_2(arg_5_1)

		if var_5_0 == var_5_1 then
			local var_5_2 = var_1_3(self)
			local var_5_3 = var_1_3(arg_5_1)

			if var_5_2 == var_5_3 then
				return self.id > arg_5_1.id
			else
				return var_5_3 < var_5_2
			end
		else
			return var_5_0 < var_5_1
		end

		return
	end

	local var_1_4 = self:canPurchase() and 1 or 0
	local var_1_5 = arg_1_1:canPurchase() and 1 or 0

	if var_1_4 == var_1_5 then
		if arg_1_2[1] == BackYardShopFilterPanel.SORT_MODE.BY_DEFAULT then
			return BackYardShopFilterPanel["SortByDefault" .. var_1_1](self, arg_1_1)
		elseif arg_1_2[1] == BackYardShopFilterPanel.SORT_MODE.BY_FUNC then
			return BackYardShopFilterPanel.SORT_BY_FUNC(self, arg_1_1, var_1_0, var_1_1, function()
				return BackYardShopFilterPanel["SortByDefault" .. var_1_1](self, arg_1_1)
			end)
		elseif arg_1_2[1] == BackYardShopFilterPanel.SORT_MODE.BY_CONFIG then
			return BackYardShopFilterPanel.SORT_BY_CONFIG(self, arg_1_1, var_1_0, var_1_1, function()
				return BackYardShopFilterPanel["SortByDefault" .. var_1_1](self, arg_1_1)
			end)
		end
	else
		return var_1_5 < var_1_4
	end

	return
end

function BackYardShopFilterPanel:sort(arg_8_1)
	table.sort(arg_8_1, function(arg_9_0, arg_9_1)
		return BackYardShopFilterPanel.SortForDecorate(arg_9_0, arg_9_1, {
			self.sortData[1],
			self.sortData[2],
			self.orderMode
		})
	end)

	self.furnitures = arg_8_1

	return
end

return BackYardShopFilterPanel
