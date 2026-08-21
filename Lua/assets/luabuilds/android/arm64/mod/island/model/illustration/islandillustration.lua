local var_0_0 = class("IslandIllustration", import("model.vo.BaseVO"))

var_0_0.TYPES = {
	NPC = 2,
	ITEM = 3,
	FISH = 4,
	CHAR = 1
}
var_0_0.STATUS = {
	UNLOCK = 3,
	LOCK = 1,
	CAN_UNLOCK = 2
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_1
	arg_1_0.status = var_0_0.STATUS.LOCK
	arg_1_0.isTip = false
	arg_1_0.basePoint = 0
	arg_1_0.levelPoints = 0
	arg_1_0.levelPointGotData = {}
	arg_1_0.starPoints = 0
	arg_1_0.starPointGotData = {}

	arg_1_0:InitConfigData()

	return
end

function var_0_0.bindConfigTable(arg_2_0)
	return pg.island_illustrated_guide
end

function var_0_0.InitConfigData(arg_3_0)
	return
end

function var_0_0.bindLinkConfigTable(arg_4_0)
	return switch(arg_4_0:getConfig("type"), {
		[var_0_0.TYPES.CHAR] = function()
			return pg.island_chara_template
		end,
		[var_0_0.TYPES.NPC] = function()
			return pg.island_unit_character
		end,
		[var_0_0.TYPES.ITEM] = function()
			return pg.island_item_data_template
		end,
		[var_0_0.TYPES.FISH] = function()
			return pg.island_fish
		end
	})
end

function var_0_0.GetLinkConfigID(arg_9_0)
	return arg_9_0:getConfig("unlock_id")
end

function var_0_0.getLinkConfigTable(arg_10_0)
	local var_10_0 = arg_10_0:bindLinkConfigTable()

	assert(var_10_0, "should bindLinkConfigTable() first: " .. arg_10_0.__cname)

	return var_10_0[arg_10_0:GetLinkConfigID()]
end

function var_0_0.getLinkConfig(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getLinkConfigTable()

	assert(var_11_0 ~= nil, "LinkConfig missed, type -" .. arg_11_0.__cname .. " configId: " .. tostring(arg_11_0.configId))

	return var_11_0[arg_11_1]
end

function var_0_0.GetName(arg_12_0)
	return switch(arg_12_0:getConfig("type"), {
		[var_0_0.TYPES.CHAR] = function()
			return pg.island_unit_character[arg_12_0:getLinkConfig("unit_id")].name
		end,
		[var_0_0.TYPES.NPC] = function()
			return arg_12_0:getLinkConfig("name")
		end,
		[var_0_0.TYPES.ITEM] = function()
			return arg_12_0:getLinkConfig("name")
		end,
		[var_0_0.TYPES.FISH] = function()
			return arg_12_0:getLinkConfig("name")
		end
	})
end

function var_0_0.GetEnName(arg_17_0)
	return switch(arg_17_0:getConfig("type"), {
		[var_0_0.TYPES.CHAR] = function()
			return pg.island_unit_character[arg_17_0:getLinkConfig("unit_id")].english_name
		end,
		[var_0_0.TYPES.NPC] = function()
			return arg_17_0:getLinkConfig("english_name")
		end,
		[var_0_0.TYPES.ITEM] = function()
			return ""
		end,
		[var_0_0.TYPES.FISH] = function()
			return ""
		end
	})
end

function var_0_0.GetDesc(arg_22_0)
	return switch(arg_22_0:getConfig("type"), {
		[var_0_0.TYPES.CHAR] = function()
			return pg.island_unit_character[arg_22_0:getLinkConfig("unit_id")].describe_illustrated_guid
		end,
		[var_0_0.TYPES.NPC] = function()
			return arg_22_0:getLinkConfig("describe_illustrated_guid")
		end,
		[var_0_0.TYPES.ITEM] = function()
			return arg_22_0:getLinkConfig("desc")
		end,
		[var_0_0.TYPES.FISH] = function()
			return pg.island_item_data_template[arg_22_0:getLinkConfig("item_id")].desc
		end
	})
end

function var_0_0.GetIcon(arg_27_0)
	return switch(arg_27_0:getConfig("type"), {
		[var_0_0.TYPES.CHAR] = function()
			return "ShipYardIcon/" .. IslandShip.StaticGetPrefab((arg_27_0:GetLinkConfigID()))
		end,
		[var_0_0.TYPES.NPC] = function()
			return "island/IslandCharIcon/" .. arg_27_0:getLinkConfig("rendering")
		end,
		[var_0_0.TYPES.ITEM] = function()
			return "island/" .. arg_27_0:getLinkConfig("icon")
		end,
		[var_0_0.TYPES.FISH] = function()
			return "island/" .. pg.island_item_data_template[arg_27_0:getLinkConfig("item_id")].icon
		end
	})
end

function var_0_0.SetPointData(arg_32_0, arg_32_1)
	arg_32_0.basePoint = arg_32_1.base
	arg_32_0.levelPoints = 0
	arg_32_0.levelPointGotData = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1.lv_list) do
		arg_32_0.levelPoints = arg_32_0.levelPoints + iter_32_1.value
		arg_32_0.levelPointGotData[iter_32_1.lv] = iter_32_1.value
	end

	arg_32_0.starPoints = 0
	arg_32_0.starPointGotData = {}

	for iter_32_2, iter_32_3 in ipairs(arg_32_1.star_list) do
		arg_32_0.starPoints = arg_32_0.starPoints + iter_32_3.value
		arg_32_0.starPointGotData[iter_32_3.lv] = iter_32_3.value
	end

	return
end

function var_0_0.SetStatus(arg_33_0, arg_33_1)
	arg_33_0.status = arg_33_1

	if arg_33_0.status == var_0_0.STATUS.CAN_UNLOCK then
		arg_33_0.isTip = true
	elseif arg_33_0.status == var_0_0.STATUS.UNLOCK then
		arg_33_0.basePoint = arg_33_0:getConfig("collect_add")
	end

	return
end

function var_0_0.GetStatus(arg_34_0)
	return arg_34_0.status
end

function var_0_0.CheckTip(arg_35_0)
	arg_35_0.isTip = arg_35_0.status == var_0_0.STATUS.CAN_UNLOCK

	return
end

function var_0_0.IsTip(arg_36_0)
	return arg_36_0.isTip
end

function var_0_0.GetPoints(arg_37_0)
	return arg_37_0.basePoint + arg_37_0.levelPoints + arg_37_0.starPoints
end

function var_0_0.GetTypeAndLinkId(arg_38_0)
	return pg.island_illustrated_guide[arg_38_0].type, pg.island_illustrated_guide[arg_38_0].unlock_id
end

return var_0_0
