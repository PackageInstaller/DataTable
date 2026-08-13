class = var_0_10000

local var_0_0 = "IslandIllustration"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

var_0_1.TYPES = {
	NPC = 2,
	ITEM = 3,
	FISH = 4,
	CHAR = 1
}
var_0_1.STATUS = {
	UNLOCK = 3,
	LOCK = 1,
	CAN_UNLOCK = 2
}

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.configId = arg_1_1
	arg_1_0.status = var_0_1.STATUS.LOCK
	arg_1_0.isTip = false
	arg_1_0.basePoint = 0
	arg_1_0.levelPoints = 0
	arg_1_0.levelPointGotData = {}
	arg_1_0.starPoints = 0
	arg_1_0.starPointGotData = {}

	arg_1_0:InitConfigData()

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.island_illustrated_guide
end

function var_0_1.InitConfigData(arg_3_0)
	return
end

function var_0_1.bindLinkConfigTable(arg_4_0)
	switch = var_1_10001

	return var_1_10001(arg_4_0:getConfig("type"), {
		[var_0_1.TYPES.CHAR] = function()
			pg = var_2_10000

			return var_2_10000.island_chara_template
		end,
		[var_0_1.TYPES.NPC] = function()
			pg = var_2_10000

			return var_2_10000.island_unit_character
		end,
		[var_0_1.TYPES.ITEM] = function()
			pg = var_2_10000

			return var_2_10000.island_item_data_template
		end,
		[var_0_1.TYPES.FISH] = function()
			pg = var_2_10000

			return var_2_10000.island_fish
		end
	})
end

function var_0_1.GetLinkConfigID(arg_9_0)
	return arg_9_0:getConfig("unlock_id")
end

function var_0_1.getLinkConfigTable(arg_10_0)
	local var_10_0 = arg_10_0:bindLinkConfigTable()

	assert = var_1_10002

	var_1_10002(var_10_0, "should bindLinkConfigTable() first: " .. arg_10_0.__cname)

	return var_10_0[arg_10_0:GetLinkConfigID()]
end

function var_0_1.getLinkConfig(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getLinkConfigTable()

	assert = var_1_10003

	local var_11_1 = var_11_0 ~= nil
	local var_11_2 = "LinkConfig missed, type -"
	local var_11_3 = arg_11_0.__cname
	local var_11_4 = " configId: "

	tostring = var_1_10009

	var_1_10003(var_11_1, var_11_2 .. var_11_3 .. var_11_4 .. var_1_10009(arg_11_0.configId))

	return var_11_0[arg_11_1]
end

function var_0_1.GetName(arg_12_0)
	switch = var_1_10001

	return var_1_10001(arg_12_0:getConfig("type"), {
		[var_0_1.TYPES.CHAR] = function()
			local var_13_0 = arg_12_0
			local var_13_1 = var_0.getLinkConfig(var_13_0, "unit_id")

			pg = var_2_10001

			return var_2_10001.island_unit_character[var_13_1].name
		end,
		[var_0_1.TYPES.NPC] = function()
			local var_14_0 = arg_12_0

			return var_0.getLinkConfig(var_14_0, "name")
		end,
		[var_0_1.TYPES.ITEM] = function()
			local var_15_0 = arg_12_0

			return var_0.getLinkConfig(var_15_0, "name")
		end,
		[var_0_1.TYPES.FISH] = function()
			local var_16_0 = arg_12_0

			return var_0.getLinkConfig(var_16_0, "name")
		end
	})
end

function var_0_1.GetEnName(arg_17_0)
	switch = var_1_10001

	return var_1_10001(arg_17_0:getConfig("type"), {
		[var_0_1.TYPES.CHAR] = function()
			local var_18_0 = arg_17_0
			local var_18_1 = var_0.getLinkConfig(var_18_0, "unit_id")

			pg = var_2_10001

			return var_2_10001.island_unit_character[var_18_1].english_name
		end,
		[var_0_1.TYPES.NPC] = function()
			local var_19_0 = arg_17_0

			return var_0.getLinkConfig(var_19_0, "english_name")
		end,
		[var_0_1.TYPES.ITEM] = function()
			return ""
		end,
		[var_0_1.TYPES.FISH] = function()
			return ""
		end
	})
end

function var_0_1.GetDesc(arg_22_0)
	switch = var_1_10001

	return var_1_10001(arg_22_0:getConfig("type"), {
		[var_0_1.TYPES.CHAR] = function()
			local var_23_0 = arg_22_0
			local var_23_1 = var_0.getLinkConfig(var_23_0, "unit_id")

			pg = var_2_10001

			return var_2_10001.island_unit_character[var_23_1].describe_illustrated_guid
		end,
		[var_0_1.TYPES.NPC] = function()
			local var_24_0 = arg_22_0

			return var_0.getLinkConfig(var_24_0, "describe_illustrated_guid")
		end,
		[var_0_1.TYPES.ITEM] = function()
			local var_25_0 = arg_22_0

			return var_0.getLinkConfig(var_25_0, "desc")
		end,
		[var_0_1.TYPES.FISH] = function()
			local var_26_0 = arg_22_0
			local var_26_1 = var_0.getLinkConfig(var_26_0, "item_id")

			pg = var_2_10001

			return var_2_10001.island_item_data_template[var_26_1].desc
		end
	})
end

function var_0_1.GetIcon(arg_27_0)
	switch = var_1_10001

	return var_1_10001(arg_27_0:getConfig("type"), {
		[var_0_1.TYPES.CHAR] = function()
			local var_28_0 = arg_27_0
			local var_28_1 = var_0.GetLinkConfigID(var_28_0)
			local var_28_2 = "ShipYardIcon/"

			IslandShip = var_28_0

			return var_28_2 .. var_28_0.StaticGetPrefab(var_28_1)
		end,
		[var_0_1.TYPES.NPC] = function()
			local var_29_0 = "island/IslandCharIcon/"
			local var_29_1 = arg_27_0

			return var_29_0 .. var_1.getLinkConfig(var_29_1, "rendering")
		end,
		[var_0_1.TYPES.ITEM] = function()
			local var_30_0 = "island/"
			local var_30_1 = arg_27_0

			return var_30_0 .. var_1.getLinkConfig(var_30_1, "icon")
		end,
		[var_0_1.TYPES.FISH] = function()
			local var_31_0 = arg_27_0
			local var_31_1 = var_0.getLinkConfig(var_31_0, "item_id")
			local var_31_2 = "island/"

			pg = var_31_0

			return var_31_2 .. var_31_0.island_item_data_template[var_31_1].icon
		end
	})
end

function var_0_1.SetPointData(arg_32_0, arg_32_1)
	arg_32_0.basePoint = arg_32_1.base
	arg_32_0.levelPoints = 0
	arg_32_0.levelPointGotData = {}
	ipairs = var_2

	for iter_32_0, iter_32_1 in var_2(arg_32_1.lv_list) do
		arg_32_0.levelPoints = arg_32_0.levelPoints + iter_32_1.value
		arg_32_0.levelPointGotData[iter_32_1.lv] = iter_32_1.value
	end

	arg_32_0.starPoints = 0
	arg_32_0.starPointGotData = {}
	ipairs = var_2

	for iter_32_2, iter_32_3 in var_2(arg_32_1.star_list) do
		arg_32_0.starPoints = arg_32_0.starPoints + iter_32_3.value
		arg_32_0.starPointGotData[iter_32_3.lv] = iter_32_3.value
	end

	return
end

function var_0_1.SetStatus(arg_33_0, arg_33_1)
	arg_33_0.status = arg_33_1

	if arg_33_0.status == var_0_1.STATUS.CAN_UNLOCK then
		arg_33_0.isTip = true
	elseif arg_33_0.status == var_0_1.STATUS.UNLOCK then
		arg_33_0.basePoint = arg_33_0:getConfig("collect_add")
	end

	return
end

function var_0_1.GetStatus(arg_34_0)
	return arg_34_0.status
end

function var_0_1.CheckTip(arg_35_0)
	arg_35_0.isTip = arg_35_0.status == var_0_1.STATUS.CAN_UNLOCK

	return
end

function var_0_1.IsTip(arg_36_0)
	return arg_36_0.isTip
end

function var_0_1.GetPoints(arg_37_0)
	return arg_37_0.basePoint + arg_37_0.levelPoints + arg_37_0.starPoints
end

function var_0_1.GetTypeAndLinkId(arg_38_0)
	pg = var_1_10001

	return var_1_10001.island_illustrated_guide[arg_38_0].type, var_1.unlock_id
end

return var_0_1
