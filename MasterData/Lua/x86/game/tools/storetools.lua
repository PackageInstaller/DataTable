local var_0_0 = {
	getHideItemIDList = function()
		return {
			InviteData:GetDataByPara("drawItemId"),
			30011
		}
	end
}

function var_0_0.getMaterialList()
	local var_2_0 = {}
	local var_2_1 = var_0_0.getHideItemIDList()

	for iter_2_0, iter_2_1 in pairs(var_0_0.GetMaterialListExceptTypes(ItemConst.ITEM_STORE_MATERIAL_IGNORE)) do
		if iter_2_1.num > 0 and not table.keyof(var_2_1, iter_2_1.id) then
			local var_2_2 = clone(ItemTemplateData)

			var_2_2.id = iter_2_1.id
			var_2_2.number = iter_2_1.num
			var_2_2.timeValid = iter_2_1.timeValid or 0

			table.insert(var_2_0, var_2_2)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.DROP_TICKET] or {}) do
		local var_2_3 = ItemTools.getItemNum(iter_2_3)

		if var_2_3 > 0 and var_2_1[iter_2_3] ~= true then
			local var_2_4 = clone(ItemTemplateData)

			var_2_4.id = iter_2_3
			var_2_4.number = var_2_3

			table.insert(var_2_0, var_2_4)
		end
	end

	for iter_2_4, iter_2_5 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.CHANGE_NAME_CARD] or {}) do
		local var_2_5 = ItemTools.getItemNum(iter_2_5)

		if var_2_5 > 0 and var_2_1[iter_2_5] ~= true then
			local var_2_6 = clone(ItemTemplateData)

			var_2_6.id = iter_2_5
			var_2_6.number = var_2_5

			table.insert(var_2_0, var_2_6)
		end
	end

	for iter_2_6, iter_2_7 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.AUTOCHESS_CARD_PACK] or {}) do
		local var_2_7 = ItemTools.getItemNum(iter_2_7)

		if var_2_7 > 0 and var_2_1[iter_2_7] ~= true then
			local var_2_8 = clone(ItemTemplateData)

			var_2_8.id = iter_2_7
			var_2_8.number = var_2_7

			table.insert(var_2_0, var_2_8)
		end
	end

	for iter_2_8, iter_2_9 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.PERIODICITY_EXPLORE_TICKER_INSTANCE] or {}) do
		local var_2_9 = CurrencyData:GetTimeVaildCurrencyListBySubTypes(iter_2_9)

		if var_2_9 and var_2_1[iter_2_9] ~= true then
			for iter_2_10, iter_2_11 in pairs(var_2_9) do
				if iter_2_11.num > 0 then
					local var_2_10 = clone(ItemTemplateData)

					var_2_10.id = iter_2_11.id
					var_2_10.number = iter_2_11.num
					var_2_10.timeValid = iter_2_11.timeValid or 0

					table.insert(var_2_0, var_2_10)
				end
			end
		end
	end

	for iter_2_12, iter_2_13 in pairs((FukubukuroData:GetFukuburoList())) do
		local var_2_11 = clone(ItemTemplateData)

		var_2_11.id = iter_2_13.item_id
		var_2_11.number = 1
		var_2_11.instance_id = iter_2_13.instance_id

		table.insert(var_2_0, var_2_11)
	end

	return var_2_0
end

function var_0_0.getMaterialMinTimestamp()
	local var_3_0

	if #CurrencyData:CheckExpiredCurrencyList() > 0 or #MaterialData:CheckExpiredMaterialList() > 0 then
		return 0
	end

	for iter_3_0, iter_3_1 in ipairs((var_0_0.getMaterialList())) do
		local var_3_1 = ItemTools.GetItemExpiredTimeByInfo(iter_3_1)

		if var_3_1 ~= 0 then
			if var_3_0 == nil then
				var_3_0 = var_3_1
			elseif var_3_1 < var_3_0 then
				var_3_0 = var_3_1
			end
		end
	end

	return var_3_0
end

function var_0_0:GetMaterialListExceptTypes()
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in pairs((MaterialData:MaterialList())) do
		if not self.type[ItemCfg[iter_4_0].type] and not self.subType[ItemCfg[iter_4_0].sub_type] then
			for iter_4_2, iter_4_3 in pairs(iter_4_1) do
				table.insert(var_4_0, {
					id = iter_4_0,
					num = iter_4_3,
					timeValid = iter_4_2
				})
			end
		end
	end

	return var_4_0
end

function var_0_0.GetMaterialListByTypes(arg_5_0)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs((MaterialData:MaterialList())) do
		if table.indexof(arg_5_0, ItemCfg[iter_5_0].type) then
			for iter_5_2, iter_5_3 in pairs(iter_5_1) do
				table.insert(var_5_0, {
					id = iter_5_0,
					num = iter_5_3,
					timeValid = iter_5_2
				})
			end
		end
	end

	return var_5_0
end

function var_0_0.GetMaterialListBySubTypes(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs((MaterialData:MaterialList())) do
		if table.indexof(arg_6_0, ItemCfg[iter_6_0].sub_type) then
			for iter_6_2, iter_6_3 in pairs(iter_6_1) do
				table.insert(var_6_0, {
					id = iter_6_0,
					num = iter_6_3,
					timeValid = iter_6_2
				})
			end
		end
	end

	return var_6_0
end

return var_0_0
