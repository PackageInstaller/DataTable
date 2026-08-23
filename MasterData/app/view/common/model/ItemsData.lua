local ItemsData = class("ItemsData")
local var_0_1 = g.core.config.item_info
local var_0_2 = g.core.config.knight_advance_material_info
local var_0_3 = g.core.model.User.bagData
local var_0_4 = g.core.const.ConstMgr

function ItemsData:ctor()
	self:initData()
end

function ItemsData:initData()
	return
end

function ItemsData:getBagList()
	local var_3_0 = 0
	local var_3_1 = var_0_3:getList(var_0_4.BAG_TYPE.ITEM)
	local var_3_2 = self:getAmatList()
	local var_3_3 = {}
	local var_3_4 = false
	local var_3_5 = var_0_3:getList(var_0_4.BAG_TYPE.EXPIRABLE_ITEM)
	local var_3_6 = self:getWingList()

	for iter_3_0 = 1, #var_3_6 do
		table.insert(var_3_3, var_3_6[iter_3_0])
	end

	for iter_3_1 = 1, #var_3_1 do
		local var_3_7 = var_0_1.fetch(var_3_1[iter_3_1].id)

		if var_3_7 and var_3_7.if_show == 1 then
			local var_3_9 = {
				type = var_0_4.BAG_TYPE.ITEM,
				value = var_3_1[iter_3_1].id,
				size = var_3_1[iter_3_1].num
			}

			var_3_9.time = var_3_1[iter_3_1].time or 0

			table.insert(var_3_3, var_3_9)

			if var_3_7.limited_time ~= 0 or var_3_1[iter_3_1].time and var_3_1[iter_3_1].time ~= 0 then
				local var_3_10 = g.core.common.ServerTime:getLeftSeconds((var_3_7.limited_time ~= 0 or nil) and (var_3_7.limited_time or var_3_1[iter_3_1].time))

				if var_3_10 > 0 and var_3_10 < 43200 then
					var_3_4 = true
					var_3_0 = var_3_0 + 1
				end
			end
		end
	end

	for iter_3_2 = 1, #var_3_2 do
		table.insert(var_3_3, var_3_2[iter_3_2])
	end

	for iter_3_3 = 1, #var_3_5 do
		if g.core.common.ServerTime:getLeftSeconds(var_3_5[iter_3_3].expire_time) > 0 then
			local var_3_12 = {
				type = var_0_4.BAG_TYPE.EXPIRABLE_ITEM,
				value = var_3_5[iter_3_3].base_id,
				size = var_3_5[iter_3_3].num
			}

			var_3_12.time = var_3_5[iter_3_3].expire_time or 0
			var_3_12.onlyId = var_3_5[iter_3_3].id

			table.insert(var_3_3, var_3_12)
		end
	end

	return var_3_3, var_3_4, var_3_0
end

function ItemsData:getWingList()
	local var_4_0 = g.core.model.User.fragmentsData:getFragmentListByType(g.core.common.Goods.FRAGMENT.TYPE_WING)
	local var_4_1 = {}

	for iter_4_0 = 1, #var_4_0 do
		var_4_1[iter_4_0] = {
			type = var_0_4.BAG_TYPE.FRAGMENT,
			value = var_4_0[iter_4_0].id,
			size = var_4_0[iter_4_0].num
		}
	end

	return var_4_1
end

function ItemsData:getAmatList()
	local var_5_0 = var_0_3:getList(var_0_4.BAG_TYPE.ADVANCE_EQUIPMENT)
	local var_5_1 = {}

	for iter_5_0 = 1, #var_5_0 do
		var_5_1[iter_5_0] = {
			type = var_0_4.BAG_TYPE.ADVANCE_EQUIPMENT,
			value = var_5_0[iter_5_0].id,
			size = var_5_0[iter_5_0].num
		}
	end

	table.sort(var_5_1, function(arg_6_0, arg_6_1)
		local var_6_0 = var_0_2.get(arg_6_0.value)
		local var_6_1 = var_0_2.get(arg_6_1.value)

		if var_6_0.quality ~= var_6_1.quality then
			return var_6_0.quality > var_6_1.quality
		end

		return arg_6_0.value < arg_6_1.value
	end)

	return var_5_1
end

function ItemsData:getExpItemList()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs((var_0_3:getList(var_0_4.BAG_TYPE.ITEM))) do
		local var_7_1 = var_0_1.get(iter_7_1.id)

		if var_7_1.item_type == 1 then
			var_7_0[#var_7_0 + 1] = {
				info = var_7_1,
				num = iter_7_1.num
			}
		end
	end

	return var_7_0
end

function ItemsData:getCommanderScoreItemList()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs((var_0_3:getList(var_0_4.BAG_TYPE.ITEM))) do
		local var_8_1 = var_0_1.get(iter_8_1.id)

		if var_8_1.item_type == 37 then
			var_8_0[#var_8_0 + 1] = {
				info = var_8_1,
				num = iter_8_1.num
			}
		end
	end

	return var_8_0
end

function ItemsData:getItemNumById(arg_9_1)
	local var_9_0 = var_0_3:getItem(var_0_4.BAG_TYPE.ITEM, arg_9_1)

	if var_9_0 then
		return var_9_0.num
	end

	return 0
end

function ItemsData:getCommaderLvUpItemData()
	local var_10_0 = {}

	for iter_10_0 = 1, var_0_1.getLength() do
		local var_10_1 = var_0_1.indexOf(iter_10_0)

		if var_10_1.item_type == var_0_4.ITEM_CONST.ITEM_TYPE.COMMANDER_LVUP_MAT then
			table.insert(var_10_0, {
				id = var_10_1.id,
				num = var_0_3:getCountById(var_0_4.BAG_TYPE.ITEM, var_10_1.id)
			})
		end
	end

	return var_10_0
end

function ItemsData:getExpItemData()
	local var_11_0 = {}

	for iter_11_0 = 1, var_0_1.getLength() do
		local var_11_1 = var_0_1.indexOf(iter_11_0)

		if var_11_1.item_type == var_0_4.ITEM_CONST.ITEM_TYPE.KNIGHT_LVUP_MAT then
			table.insert(var_11_0, {
				id = var_11_1.id,
				num = var_0_3:getCountById(var_0_4.BAG_TYPE.ITEM, var_11_1.id)
			})
		end
	end

	return var_11_0
end

function ItemsData:getPetExpItemData()
	local var_12_0 = {}

	for iter_12_0 = 1, var_0_1.getLength() do
		local var_12_1 = var_0_1.indexOf(iter_12_0)

		if var_12_1.item_type == var_0_4.ITEM_CONST.ITEM_TYPE.PET_EXP then
			table.insert(var_12_0, {
				id = var_12_1.id,
				num = var_0_3:getCountById(var_0_4.BAG_TYPE.ITEM, var_12_1.id)
			})
		end
	end

	return var_12_0
end

function ItemsData:getBioPropData()
	return (var_0_3:getList(var_0_4.BAG_TYPE.BIOGRAPHY_ITEM))
end

function ItemsData:getThemeBioPropData()
	return (var_0_3:getList(var_0_4.BAG_TYPE.THEME_BIO_ITEM))
end

function ItemsData:getFavoData()
	return (var_0_3:getList(var_0_4.BAG_TYPE.FAVORABILITY_ITEM))
end

function ItemsData:getFurnitureData()
	return (var_0_3:getList(var_0_4.BAG_TYPE.FURNISHING))
end

function ItemsData:getDailyBoxGameItemInfo()
	for iter_17_0 = 1, var_0_1.getLength() do
		local var_17_0 = var_0_1.indexOf(iter_17_0)

		if var_17_0.item_type == g.core.const.ConstMgr.ITEM_CONST.ITEM_TYPE.DAILY_BOX_GAME then
			return var_17_0
		end
	end
end

function ItemsData:getNewSlgItemList()
	local var_18_0 = {}

	for iter_18_0 = 1, var_0_1.getLength() do
		local var_18_1 = var_0_1.indexOf(iter_18_0)

		if var_18_1.item_type ~= g.core.const.ConstMgr.ITEM_CONST.ITEM_TYPE.NEW_SLG and var_18_1.id ~= 2669 then
			if var_18_1.id == 2670 then
				local var_18_3 = {
					info = var_18_1
				}

				var_18_3.num = var_0_3:getCountById(var_0_4.BAG_TYPE.ITEM, var_18_1.id)

				table.insert(var_18_0, var_18_3)
			end
		end
	end

	return var_18_0
end

return ItemsData
