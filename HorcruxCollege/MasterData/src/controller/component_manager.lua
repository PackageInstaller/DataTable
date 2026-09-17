local var_0_0 = {}
local item_data = require("data.item_data")
local component_strengthen_data = require("data.component_strengthen_data")
local component_effect_data = require("data.component_effect_data")
local var_0_6 = require("data.item_data")
local var_0_7 = config._DEBUG and 0 or 1
local playermodel = require("model.playermodel")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local network = require("network.network")
local component_strengthen_weight_data = require("data.component_strengthen_weight_data")
local recommend_chip_data = require("data.recommend_chip_data")
local var_0_14 = {}
local var_0_16 = COMPONENT_MAIN_ATTR
local var_0_17 = FIGHT_ATTR_INFO
local var_0_18 = setmetatable({}, {
	__index = function(arg_1_0, arg_1_1)
		return var_0_17[var_0_16[arg_1_1]]
	end
})
local var_0_20 = ATTR_TRANS_FAC
local var_0_21 = FIGHT_ATTR_FORMAT

function var_0_0.init(arg_2_0)
	for iter_2_0 = 1, 7 do
		var_0_14[iter_2_0] = {}

		for iter_2_1 = 1, 10 do
			var_0_14[iter_2_0][iter_2_1] = {}
		end
	end

	for iter_2_2, iter_2_3 in pairs(component_strengthen_data) do
		var_0_14[iter_2_3.equip_quality][iter_2_3.level][iter_2_3.intensify_level] = iter_2_3
	end

	arg_2_0.recommendCache = {}
end

function var_0_0.getComponentStrengthTable(arg_3_0)
	return var_0_14
end

BASIC_COMPONENT_SUB_ATTR = 0
MAX_COMPONENT_SUB_ATTR = 20
SUB_ATTR_FACTOR = 1

function var_0_0.calculateSubAttr(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_3 = arg_4_3 or 0

	if arg_4_4 then
		return arg_4_3 * SUB_ATTR_FACTOR * (var_0_20[arg_4_2] or 1)
	else
		return (BASIC_COMPONENT_SUB_ATTR + arg_4_3 * SUB_ATTR_FACTOR) * ((not var_0_20[arg_4_2] or nil) and 1)
	end
end

var_0_0.calculateAttr = var_0_0.calculateSubAttr

function var_0_0.getSubAttrInfo(arg_5_0, arg_5_1, arg_5_2)
	return var_0_21(arg_5_1, arg_5_2)
end

var_0_0.getAttrInfo = var_0_0.getSubAttrInfo

function var_0_0.getComponentLevel(arg_6_0, arg_6_1)
	return item_data[arg_6_1].rank or 1
end

function var_0_0.putComponent(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	error("cant put component in client , use set item by server item")
end

function var_0_0.deleteComponent(arg_8_0, arg_8_1)
	require("controller.item_manager"):deleteItem(arg_8_1)
end

local function var_0_22(arg_9_0)
	if not arg_9_0 then
		return nil
	end

	if type(arg_9_0) == "table" then
		return arg_9_0.effect
	end

	if type(arg_9_0) ~= "string" then
		return nil
	end

	local var_9_0 = arg_9_0:match("effect=(%d+)")

	if var_9_0 then
		return tonumber(var_9_0)
	end

	return nil
end

local function var_0_23(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1

	if playermodel.items[arg_10_0] then
		var_10_1 = item_data[playermodel.items[arg_10_0].itemid]
		var_10_0 = item_data[playermodel.items[arg_10_0].itemid].main_attr and string.format("equipment/component/%d-%d-%d.png", component_effect_data[playermodel.items[arg_10_0].component_attr.effect].image_id, var_10_1.pos, item_data[playermodel.items[arg_10_0].itemid].main_attr) or string.format("equipment/component/%d-%d-%d.png", component_effect_data[playermodel.items[arg_10_0].component_attr.effect].image_id, var_10_1.pos, playermodel.items[arg_10_0].component_attr.attr1)
	else
		local var_10_2

		var_10_1 = item_data[arg_10_0]
		var_10_2 = arg_10_1 and (var_0_22(arg_10_1) or item_data[arg_10_0].effect1) or var_0_22((string.format("effect=%d", item_data[arg_10_0].effect1)))

		local var_10_3 = var_10_1.main_attr

		var_10_0 = var_10_1.main_attr and (var_10_2 and string.format("equipment/component/%d-%d-%d.png", component_effect_data[var_10_2].image_id, var_10_1.pos, var_10_3) or string.format("equipment/component/unknow-%d-1-%d.png", var_10_1.pos, var_10_3)) or var_10_2 and string.format("equipment/component/%d-%d.png", component_effect_data[var_10_2].image_id, var_10_1.pos) or string.format("equipment/component/unknow-%d-1.png", var_10_1.pos)
	end

	local var_10_4 = cc.Sprite:create(var_10_0)

	if var_10_1.equip_condition and var_10_1.equip_condition ~= "all" then
		local var_10_5 = ccui.ImageView:create(string.format("public/career_icon/%s.png", var_10_1.equip_condition), config._DEBUG and 0 or 1)

		var_10_5:setPosition(var_10_4:getContentSize().width - 10, var_10_4:getContentSize().height - 10)
		var_10_4:addChild(var_10_5)
	end

	return var_10_4
end

local function var_0_24(arg_11_0, arg_11_1)
	if playermodel.items[arg_11_0] then
		local var_11_1 = ccui.Layout:create()

		var_11_1:setContentSize(cc.size(87, 90))
		var_11_1:setAnchorPoint(cc.p(0.5, 0.5))
		var_11_1:setScale(0.54)

		local var_11_3 = cc.Sprite:create(item_data[playermodel.items[arg_11_0].itemid].main_attr and string.format("equipment/component/%d-%d-%d.png", component_effect_data[playermodel.items[arg_11_0].component_attr.effect].image_id, item_data[playermodel.items[arg_11_0].itemid].pos, item_data[playermodel.items[arg_11_0].itemid].main_attr) or string.format("equipment/component/%d-%d-%d.png", component_effect_data[playermodel.items[arg_11_0].component_attr.effect].image_id, item_data[playermodel.items[arg_11_0].itemid].pos, playermodel.items[arg_11_0].component_attr.attr1))

		var_11_3:setPosition(cc.p(var_11_1:getContentSize().width / 2, var_11_1:getContentSize().height / 2))
		var_11_1:addChild(var_11_3)

		if arg_11_1 and arg_11_1 > 0 then
			local var_11_4 = ccui.ImageView:create("EquipLayer/bg_extra.png", var_0_7)

			var_11_4:setPosition(cc.p(var_11_1:getContentSize().width / 2, 25))
			var_11_4:setScale(1.7241379310344829)
			var_11_1:addChild(var_11_4)

			local var_11_5 = cc.Label:createWithTTF("+" .. arg_11_1, FONT_NAME, 22)

			var_11_5:setPosition(cc.p(var_11_4:getContentSize().width / 2, var_11_4:getContentSize().height / 2))
			var_11_5:setAnchorPoint(cc.p(0.5, 0.5))
			var_11_5:setColor(cc.c3b(230, 236, 238))
			var_11_4:addChild(var_11_5)
		end

		return var_11_1
	else
		error("can't create a equip component icon for unowned component")
	end
end

function var_0_0.create_component_icon(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	return arg_12_2 == 1 and var_0_24(arg_12_1, arg_12_4) or var_0_23(arg_12_1, arg_12_3)
end

function var_0_0.decode_component_config(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return nil
	end

	if type(arg_13_1) == "table" then
		return arg_13_1
	end

	if type(arg_13_1) ~= "string" then
		return nil
	end

	return {
		extra = 0,
		attr = 0,
		effect = tonumber((arg_13_1:match("effect=(%d+)")))
	}
end

function var_0_0:initComponentIntrowithItemid(arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = self:decode_component_config(arg_14_2)
	local var_14_1 = {}
	local var_14_2 = {}
	local var_14_5 = item_data[arg_14_1].main_attr
	local var_14_6

	if not item_data[arg_14_1].main_attr then
		var_14_5 = playermodel.items[arg_14_3].component_attr.attr1
		var_14_6 = playermodel.items[arg_14_3].component_attr.attr2
	end

	table.insert(var_14_1, var_0_18[var_14_5] .. " + " .. 0 * var_0_20[var_0_16[var_14_5]] + self:calculateAttr(arg_14_1, var_0_16[var_14_5], var_14_0.attr))
	table.insert(var_14_1, component_effect_data[var_14_0.effect].intro)

	if var_14_6 then
		table.insert(var_14_2, var_0_18[var_14_6] .. " + " .. 0 * var_0_20[var_0_16[var_14_6]] + self:calculateAttr(arg_14_1, var_0_16[var_14_6], var_14_0.attr))
		table.insert(var_14_2, component_effect_data[var_14_0.effect].intro)
	end

	return var_14_1, var_14_2
end

function var_0_0:initComponentIntro(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	arg_15_2 = arg_15_2 or false

	local var_15_0 = playermodel.items[arg_15_1].itemid
	local var_15_1 = item_data[playermodel.items[arg_15_1].itemid].main_attr
	local var_15_2
	local var_15_3
	local var_15_4

	if arg_15_1 and playermodel.items[arg_15_1] and playermodel.items[arg_15_1].component_attr and playermodel.items[arg_15_1].component_attr.attr2 then
		var_15_1 = playermodel.items[arg_15_1].component_attr.attr1
		var_15_2 = playermodel.items[arg_15_1].component_attr.attr2
		var_15_3 = var_0_16[playermodel.items[arg_15_1].component_attr.attr2]
		var_15_4 = 0 * var_0_20[var_0_16[playermodel.items[arg_15_1].component_attr.attr2]] + self:calculateAttr(var_15_0, var_0_16[playermodel.items[arg_15_1].component_attr.attr2], playermodel.items[arg_15_1].component_attr.attr)
	end

	local var_15_5 = var_0_16[var_15_1]
	local var_15_8 = 0 * var_0_20[var_0_16[var_15_1]] + self:calculateAttr(var_15_0, var_0_16[var_15_1], playermodel.items[arg_15_1].component_attr.attr)
	local var_15_9

	if arg_15_2 then
		var_15_9 = {}

		table.insert(var_15_9, var_0_18[var_15_1] .. " + " .. var_0_21(var_15_5, var_15_8))

		if var_15_2 then
			table.insert(var_15_9, var_0_18[var_15_2] .. " + " .. var_0_21(var_15_3, var_15_4))
		end

		if arg_15_3 then
			table.insert(var_15_9, component_effect_data[playermodel.items[arg_15_1].component_attr.effect].name)
		else
			table.insert(var_15_9, component_effect_data[playermodel.items[arg_15_1].component_attr.effect].intro)
		end
	else
		var_15_9 = var_15_9 .. L_PROPERTY .. " \n"
		var_15_9 = var_15_9 .. "   " .. var_0_18[var_15_1] .. " + " .. var_15_8 .. "\n" .. "   " .. var_0_18[var_15_2] .. " + " .. var_15_4 .. "\n"
		var_15_9 = var_15_9 .. "\n\n" .. component_effect_data[playermodel.items[arg_15_1].component_attr.effect].intro
	end

	return var_15_9
end

function var_0_0:getComponentAttrsInfo(arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = item_data[playermodel.items[arg_16_1].itemid].main_attr
	local var_16_2

	if arg_16_1 and playermodel.items[arg_16_1] and playermodel.items[arg_16_1].component_attr and playermodel.items[arg_16_1].component_attr.attr2 then
		var_16_1 = playermodel.items[arg_16_1].component_attr.attr1
		var_16_2 = playermodel.items[arg_16_1].component_attr.attr2
	end

	local var_16_3 = var_0_16[var_16_1]
	local var_16_6 = 0 * var_0_20[var_0_16[var_16_1]] + self:calculateAttr(playermodel.items[arg_16_1].itemid, var_0_16[var_16_1], playermodel.items[arg_16_1].component_attr.attr)

	var_16_0.main_attr = var_0_18[var_16_1] .. " + " .. self:getAttrInfo(var_0_16[var_16_1], var_16_6)
	var_16_0.main_attr_num = item_data[playermodel.items[arg_16_1].itemid].main_attr
	var_16_0.sub_attr = {}
	var_16_0.suit = component_effect_data[playermodel.items[arg_16_1].component_attr.effect].intro
	var_16_0.suitName = component_effect_data[playermodel.items[arg_16_1].component_attr.effect].name
	var_16_0.extra = playermodel.items[arg_16_1].component_attr.extra
	var_16_0.main_attr_des = var_0_18[var_16_1]
	var_16_0.main_attr_num_des = self:getAttrInfo(var_16_3, var_16_6)
	var_16_0.name = item_data[playermodel.items[arg_16_1].itemid].name
	var_16_0.value = var_16_6
	var_16_0.pos = item_data[playermodel.items[arg_16_1].itemid].pos

	if arg_16_1 and playermodel.items[arg_16_1] and playermodel.items[arg_16_1].component_attr and playermodel.items[arg_16_1].component_attr.attr2 then
		local var_16_7 = 0 * var_0_20[var_0_16[var_16_2]] + self:calculateAttr(playermodel.items[arg_16_1].itemid, var_0_16[var_16_2], playermodel.items[arg_16_1].component_attr.attr)

		var_16_0.main_attr_num = playermodel.items[arg_16_1].component_attr.attr1
		var_16_0.main_attr_num2 = playermodel.items[arg_16_1].component_attr.attr2
		var_16_0.main_attr_des2 = var_0_18[var_16_2]
		var_16_0.main_attr_num_des2 = self:getAttrInfo(var_0_16[var_16_2], var_16_7)
		var_16_0.value2 = var_16_7
		var_16_0.main_attr2 = var_0_18[var_16_2] .. " + " .. self:getAttrInfo(var_0_16[var_16_2], var_16_7)
	end

	return var_16_0
end

function var_0_0.getComponentInfo(arg_17_0, arg_17_1)
	local var_17_0 = {}

	var_17_0.name = component_effect_data[playermodel.items[arg_17_1].component_attr.effect].name
	var_17_0.equip_quality = item_data[playermodel.items[arg_17_1].itemid].equip_quality

	return var_17_0
end

function var_0_0.getExtraPoint(arg_18_0, arg_18_1)
	return playermodel.items[arg_18_1].component_attr.extra or 0
end

function var_0_0.getSoulComponentConditions(arg_19_0, arg_19_1)
	local var_19_0 = {
		suit = {
			"soul_" .. arg_19_1,
			"all"
		}
	}
	local major_factor_data = require("data.major_factor_data")

	var_19_0.suit[#var_19_0.suit + 1] = major_factor_data[servant_data[arg_19_1].major].career
	var_19_0.suit[#var_19_0.suit + 1] = major_factor_data[servant_data[arg_19_1].major].attacktype

	return var_19_0
end

function var_0_0.filterComponent(arg_20_0, arg_20_1)
	local var_20_0
	local var_20_1
	local var_20_2

	if arg_20_1.suit and next(arg_20_1.suit) ~= nil then
		var_20_2 = {}

		for iter_20_0, iter_20_1 in pairs(arg_20_1.suit) do
			var_20_2[iter_20_1] = true
		end
	end

	if arg_20_1.pos and next(arg_20_1.pos) ~= nil then
		var_20_0 = {}

		for iter_20_2, iter_20_3 in pairs(arg_20_1.pos) do
			var_20_0[iter_20_3] = true
		end
	end

	if arg_20_1.role and next(arg_20_1.role) ~= nil then
		var_20_1 = {}

		for iter_20_4, iter_20_5 in pairs(arg_20_1.role) do
			var_20_1[iter_20_5] = true
		end
	end

	local function var_20_3(arg_21_0, arg_21_1)
		if arg_21_0.operator == 1 then
			return arg_21_1 >= arg_21_0.level
		elseif arg_21_0.operator == 2 then
			return arg_21_1 <= arg_21_0.level
		elseif arg_21_0.operator == 3 then
			return arg_21_1 == arg_21_0.level
		end
	end

	local var_20_4 = {}

	if arg_20_1.itemList then
		for iter_20_6, iter_20_7 in pairs(arg_20_1.itemList) do
			if not playermodel.items[iter_20_7].component_attr.use and (not var_20_2 or var_20_2[playermodel.items[iter_20_7].component_attr.effect]) and (not var_20_0 or var_20_0[item_data[playermodel.items[iter_20_7].itemid].pos]) and (not var_20_1 or var_20_1[item_data[playermodel.items[iter_20_7].itemid].equip_condition]) and (not arg_20_1.rank or var_20_3({
				operator = 2,
				level = arg_20_1.rank
			}, item_data[playermodel.items[iter_20_7].itemid].rank)) then
				table.insert(var_20_4, iter_20_7)
			end
		end
	else
		for iter_20_8, iter_20_9 in pairs(playermodel.items) do
			if iter_20_9.itemtype == kITEM_COMPONENT and not iter_20_9.component_attr.use and (not var_20_2 or var_20_2[iter_20_9.component_attr.effect]) and (not var_20_0 or var_20_0[item_data[iter_20_9.itemid].pos]) and (not var_20_1 or var_20_1[item_data[iter_20_9.itemid].equip_condition]) and (not arg_20_1.rank or var_20_3({
				operator = 2,
				level = arg_20_1.rank
			}, item_data[iter_20_9.itemid].rank)) then
				table.insert(var_20_4, iter_20_8)
			end
		end
	end

	return var_20_4
end

function var_0_0:getServantComponentlist(arg_22_1)
	local var_22_0 = {}

	if playermodel.component[arg_22_1] then
		for iter_22_0, iter_22_1 in pairs(playermodel.component[arg_22_1]) do
			if playermodel.items[iter_22_1.id] and playermodel.items[iter_22_1.id].component_attr then
				table.insert(var_22_0, {
					itemid = playermodel.items[iter_22_1.id].itemid,
					attr = playermodel.items[iter_22_1.id].component_attr.attr,
					effect = playermodel.items[iter_22_1.id].component_attr.effect,
					extra = playermodel.items[iter_22_1.id].component_attr.extra,
					entityid = iter_22_1.id
				})
			else
				playermodel.component[arg_22_1][iter_22_0] = nil
			end
		end
	end

	local var_22_1, var_22_2 = self:getComponentlistByData(var_22_0, (require("controller.core_manager"):getServantCoreRank(arg_22_1)))

	if playermodel.reinforce_component[arg_22_1] ~= 0 then
		var_22_1.reinforce_component = component_effect_data[playermodel.reinforce_component[arg_22_1]].skill_up
	end

	return var_22_1, var_22_2
end

var_0_0.getSoulComponentlist = var_0_0.getServantComponentlist

function var_0_0:getComponentlistByData(arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = {}
	local var_23_1 = {}

	if not arg_23_1 then
		return var_23_0, var_23_1
	end

	local var_23_2 = {}

	for iter_23_0, iter_23_1 in pairs(arg_23_1) do
		local var_23_3 = {}

		if not item_data[iter_23_1.itemid] then
			break
		end

		local var_23_6 = item_data[iter_23_1.itemid].main_attr
		local var_23_7
		local var_23_8

		if iter_23_1.attr1 and iter_23_1.attr2 then
			var_23_6 = iter_23_1.attr1
			var_23_7 = iter_23_1.attr2
			var_23_8 = var_0_16[iter_23_1.attr2]
			var_23_3.main2 = {
				[var_0_16[iter_23_1.attr2]] = var_0_20[var_0_16[iter_23_1.attr2]] * 0 + self:calculateAttr(iter_23_1.itemid, var_0_16[iter_23_1.attr2], iter_23_1.attr)
			}
		end

		if not iter_23_1.attr2 and not var_23_6 and iter_23_1.entityid and playermodel.items[iter_23_1.entityid] and playermodel.items[iter_23_1.entityid].component_attr and playermodel.items[iter_23_1.entityid].component_attr.attr2 then
			var_23_6 = playermodel.items[iter_23_1.entityid].component_attr.attr1
			var_23_7 = playermodel.items[iter_23_1.entityid].component_attr.attr2
			var_23_8 = var_0_16[playermodel.items[iter_23_1.entityid].component_attr.attr2]
			var_23_3.main2 = {
				[var_0_16[playermodel.items[iter_23_1.entityid].component_attr.attr2]] = var_0_20[var_0_16[playermodel.items[iter_23_1.entityid].component_attr.attr2]] * 0 + self:calculateAttr(iter_23_1.itemid, var_0_16[playermodel.items[iter_23_1.entityid].component_attr.attr2], iter_23_1.attr)
			}
		end

		local var_23_9 = var_0_16[var_23_6]

		if var_0_16[var_23_6] then
			var_23_3.main = {
				[var_23_9] = var_0_20[var_23_9] * 0 + self:calculateAttr(iter_23_1.itemid, var_23_9, iter_23_1.attr)
			}
		else
			assert(var_23_9, "component " .. var_23_9 .. " is nil")
			assert(var_23_8, "component " .. var_23_8 .. " is nil")
		end

		table.insert(var_23_2, {
			effect = iter_23_1.effect,
			mainattr = var_23_6,
			mainattr2 = var_23_7
		})

		var_23_0[#var_23_0 + 1] = var_23_3
	end

	var_23_0.reinforce_component = arg_23_3 and arg_23_3 ~= 0 and component_effect_data[arg_23_3].skill_up
	var_23_0.effect = nil

	if #var_23_2 == 3 then
		local var_23_10

		for iter_23_2, iter_23_3 in ipairs(var_23_2) do
			if not var_23_10 then
				var_23_10 = iter_23_3.effect
			elseif iter_23_3.effect ~= var_23_10 then
				var_23_10 = nil

				break
			end
		end

		if var_23_10 then
			var_23_0.effect = component_effect_data[var_23_10].skill

			table.insert(var_23_1, var_23_10)
		end
	end

	return var_23_0, var_23_1
end

function var_0_0.checkComponentBagStatus(arg_24_0)
	return
end

function var_0_0:strengthenComponent(arg_25_1, arg_25_2, arg_25_3)
	local item_manager = require("controller.item_manager")
	local var_25_1
	local var_25_2 = playermodel.items[arg_25_1].component_attr
	local var_25_3 = item_data[playermodel.items[arg_25_1].itemid]
	local var_25_5 = var_0_14[(arg_25_1 and playermodel.items[arg_25_1] and playermodel.items[arg_25_1].component_attr and playermodel.items[arg_25_1].component_attr.attr2 or nil) and item_data[playermodel.items[arg_25_1].itemid].equip_quality + 1][item_data[playermodel.items[arg_25_1].itemid].level][playermodel.items[arg_25_1].component_attr.extra + 1]

	if not var_0_14[(arg_25_1 and playermodel.items[arg_25_1] and playermodel.items[arg_25_1].component_attr and playermodel.items[arg_25_1].component_attr.attr2 or nil) and item_data[playermodel.items[arg_25_1].itemid].equip_quality + 1][item_data[playermodel.items[arg_25_1].itemid].level][playermodel.items[arg_25_1].component_attr.extra + 1] then
		if arg_25_3 then
			arg_25_3(2)
		end

		return
	end

	local var_25_6 = 1
	local var_25_7 = {}

	while var_25_5["material" .. var_25_6] do
		if var_25_5["material" .. var_25_6 .. "_num"] > item_manager:getItemNumber(var_25_5["material" .. var_25_6]) then
			if arg_25_3 then
				arg_25_3(3)
			end

			return
		else
			table.insert(var_25_7, {
				dropid = var_25_5["material" .. var_25_6],
				dropNum = var_25_5["material" .. var_25_6 .. "_num"]
			})
		end

		var_25_6 = var_25_6 + 1
	end

	local var_25_8, var_25_9, var_25_10 = self:getStrengthenExpected(arg_25_1, (self:getComponentMaterialExp(arg_25_2)))

	if var_25_10 > playermodel.gold then
		if arg_25_3 then
			arg_25_3(4)
		end

		return
	end

	local var_25_11 = {}

	if arg_25_2 then
		for iter_25_0, iter_25_1 in pairs(arg_25_2) do
			if type(iter_25_1) == "table" then
				var_25_1 = iter_25_1.num
			else
				table.insert(var_25_11, iter_25_1)
			end
		end
	else
		var_25_11 = nil
	end

	self:saveComponentAttr(arg_25_1)
	network:rpc("strengthen_component", {
		entityid = arg_25_1,
		materialComponent = var_25_11,
		assemblyNum = var_25_1
	}, function(arg_26_0)
		if arg_26_0.result == 1 then
			var_25_2.extra = arg_26_0.component.extra
			var_25_2.attr = arg_26_0.component.attr
			var_25_2.strengthen = arg_26_0.component.strengthen
			var_25_2.exp = arg_26_0.component.exp

			if var_25_11 then
				for iter_26_0, iter_26_1 in pairs(var_25_11) do
					item_manager:deleteItem(iter_26_1)
				end
			end

			if var_25_1 then
				item_manager:deleteItem(5100002, var_25_1)
			end

			if var_25_2.use then
				for iter_26_2, iter_26_3 in pairs(playermodel.curSoul) do
					if iter_26_3.classtype == 1 and playermodel.component[iter_26_3.fight_girl] then
						for iter_26_4, iter_26_5 in pairs(playermodel.component[iter_26_3.fight_girl]) do
							if iter_26_5.id == arg_25_1 then
								FightManager.registerPlayerChangeComponent()
								cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))

								break
							end
						end
					end
				end
			end

			for iter_26_6, iter_26_7 in pairs(var_25_7) do
				item_manager:deleteItem(iter_26_7.dropid, iter_26_7.dropNum)
			end

			playermodel.gold = playermodel.gold - var_25_10

			global_update_gold_stone_diamond(var_25_10)
			AnalyticManager.strengthComponentSuccess({
				component_attr = var_0_18[var_25_3.main_attr],
				level = var_25_2.extra
			})
			self:disPlayComponentChangeAttr(arg_25_1)
			require("controller.audio_manager"):playeffectMusicTest("sound/upgrade")

			if arg_25_3 then
				arg_25_3(1)
			end
		elseif arg_26_0.result == 2 then
			if arg_25_3 then
				arg_25_3(2)
			end
		elseif arg_26_0.result == 3 then
			if arg_25_3 then
				arg_25_3(3)
			end
		elseif arg_25_3 then
			arg_25_3(0)
		end
	end)
end

function var_0_0:saveComponentAttr(arg_27_1)
	self.oldInfo = self:getComponentStrengthenInfo(arg_27_1)
end

function var_0_0:disPlayComponentChangeAttr(arg_28_1, arg_28_2)
	local fight_capacity_manager = require("controller.fight_capacity_manager")
	local var_28_1 = self:getComponentStrengthenInfo(arg_28_1)
	local var_28_2 = {}

	for iter_28_0, iter_28_1 in ipairs(var_28_1) do
		var_28_2[iter_28_0] = iter_28_1 - self.oldInfo[iter_28_0]
	end

	local var_28_4 = self:getStrengthenInfo(arg_28_1)
	local var_28_7 = item_data[playermodel.items[arg_28_1].itemid].equip_quality
	local var_28_9 = var_0_6[playermodel.items[arg_28_1].itemid].main_attr
	local var_28_10

	if not var_0_6[playermodel.items[arg_28_1].itemid].main_attr then
		var_28_9 = playermodel.items[arg_28_1].component_attr.attr1
		var_28_10 = playermodel.items[arg_28_1].component_attr.attr2
	end

	local var_28_11 = var_0_16[var_28_9]
	local var_28_12

	if var_28_10 then
		var_28_12 = var_0_16[var_28_10]
	end

	local var_28_13 = {}
	local var_28_14 = {}
	local var_28_15 = {}
	local var_28_16 = {
		cc.c3b(217, 219, 237),
		cc.c3b(39, 213, 46),
		cc.c3b(1, 191, 253),
		cc.c3b(236, 90, 253),
		cc.c3b(250, 130, 72),
		(cc.c3b(255, 0, 0))
	}

	if arg_28_2 then
		local var_28_17 = 0
		local var_28_18 = 0
		local var_28_19 = 0
		local var_28_20 = 0

		for iter_28_2, iter_28_3 in ipairs(self.oldInfo) do
			if iter_28_3 > 0 then
				for iter_28_4 = 1, iter_28_3 do
					var_28_17 = var_28_17 + self:calculateAttr(playermodel.items[arg_28_1].itemid, var_28_11, component_strengthen_weight_data[var_28_7]["add_value" .. iter_28_2])
					var_28_19 = var_28_19 + self:calculateAttr(playermodel.items[arg_28_1].itemid, var_28_12, component_strengthen_weight_data[var_28_7]["add_value" .. iter_28_2])
				end
			end
		end

		local var_28_21 = 1

		for iter_28_5, iter_28_6 in ipairs(var_28_1) do
			if iter_28_6 > 0 then
				for iter_28_7 = 1, iter_28_6 do
					var_28_18 = var_28_18 + self:calculateAttr(playermodel.items[arg_28_1].itemid, var_28_11, component_strengthen_weight_data[var_28_7]["add_value" .. iter_28_5])
					var_28_20 = var_28_20 + self:calculateAttr(playermodel.items[arg_28_1].itemid, var_28_12, component_strengthen_weight_data[var_28_7]["add_value" .. iter_28_5])
				end

				var_28_21 = iter_28_5
			end
		end

		if not var_28_10 then
			table.insert(var_28_13, var_0_18[var_28_9] .. " + " .. var_0_21(var_28_11, var_28_18 - var_28_17))
		else
			table.insert(var_28_13, var_0_18[var_28_9] .. " + " .. var_0_21(var_28_11, var_28_18 - var_28_17) .. "\n" .. var_0_18[var_28_10] .. " + " .. var_0_21(var_28_12, var_28_20 - var_28_19))
		end

		table.insert(var_28_14, var_28_16[var_28_21])
		table.insert(var_28_15, var_28_7)

		var_28_13[#var_28_13 + 1] = arg_28_2
	else
		for iter_28_8, iter_28_9 in pairs(var_28_2) do
			if iter_28_9 ~= 0 then
				for iter_28_10 = 1, iter_28_9 do
					local var_28_22 = self:calculateAttr(playermodel.items[arg_28_1].itemid, var_28_11, component_strengthen_weight_data[var_28_7]["add_value" .. iter_28_8])

					table.insert(var_28_13, not var_28_10 and var_0_18[var_28_9] .. " + " .. var_0_21(var_28_11, var_28_22) or var_0_18[var_28_9] .. " + " .. var_0_21(var_28_11, var_28_22) .. "\n" .. var_0_18[var_28_10] .. " + " .. var_0_21(var_28_12, (self:calculateAttr(playermodel.items[arg_28_1].itemid, var_28_12, component_strengthen_weight_data[var_28_7]["add_value" .. iter_28_8]))))
					table.insert(var_28_14, var_28_16[iter_28_8])
					table.insert(var_28_15, iter_28_8)
				end
			end
		end
	end

	local var_28_25 = ccui.Layout:create()

	var_28_25:setTouchEnabled(true)
	var_28_25:setContentSize(cc.size(GameDisplay.width, GameDisplay.height))
	var_28_25:setAnchorPoint(cc.p(0, 0))
	var_28_25:setPosition(cc.p(0, -GameDisplay.fix_y))
	var_28_25:setBackGroundColorType(ccui.LayoutBackGroundColorType.none)
	global_basic_scene:addChild(var_28_25, 100000)
	var_28_25:setTouchEnabled(true)
	var_28_25:addTouchEventListener(function(arg_29_0, arg_29_1)
		if arg_29_1 ~= ccui.TouchEventType.ended then
			return
		end

		var_28_25:stopAllActions()
		var_28_25:runAction(cc.RemoveSelf:create())
	end)

	local var_28_26 = {
		1,
		1,
		1.2,
		1.3,
		1.5,
		1.8
	}
	local var_28_27 = 1

	var_28_25:runAction(cc.RepeatForever:create(cc.Sequence:create(cc.CallFunc:create(function()
		if var_28_15[var_28_27] then
			local var_30_0 = var_28_26[var_28_15[var_28_27]] or 1
			local var_30_1 = ccui.ImageView:create("public/panelbg/component_strengthen_effect_bg.png", var_0_7)

			var_30_1:setPositionX(320)
			var_30_1:setPositionY(GameDisplay.height / 2)
			global_basic_scene:addChild(var_30_1, 100000)

			local var_30_2 = cc.Label:createWithTTF(var_28_13[var_28_27], FONT_TITLE, 32)

			var_30_2:setPosition(cc.p(var_30_1:getContentSize().width / 2, var_30_1:getContentSize().height / 2))
			var_30_2:setColor(var_28_14[var_28_27])
			var_30_1:addChild(var_30_2)
			var_30_1:setScale(4 * var_30_0)
			var_30_1:runAction(cc.Sequence:create(cc.ScaleTo:create(0.1, 1), cc.DelayTime:create(0.2 * var_30_0), cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(0, 200)), cc.FadeOut:create(0.3)), cc.RemoveSelf:create()))
		elseif var_28_13[var_28_27] then
			local var_30_3 = cc.Node:create()

			global_basic_scene:addChild(var_30_3)
			var_30_3:runAction(cc.Sequence:create(cc.CallFunc:create(var_28_13[var_28_27]), cc.RemoveSelf:create()))
		end

		var_28_27 = var_28_27 + 1

		if var_28_27 > #var_28_13 then
			var_28_25:stopAllActions()
			var_28_25:removeFromParent()
		end
	end), cc.DelayTime:create(0.25))))
end

function var_0_0:getStrengthenStatus(arg_31_1)
	local var_31_0 = playermodel.items[arg_31_1].itemid

	return var_0_14[(arg_31_1 and playermodel.items[arg_31_1] and playermodel.items[arg_31_1].component_attr and playermodel.items[arg_31_1].component_attr.attr2 or nil) and item_data[var_31_0].equip_quality + 1][item_data[var_31_0].level][self:getExtraPoint(arg_31_1) + 1] ~= nil
end

function var_0_0:getStrengthenInfo(arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	local var_32_0 = arg_32_4 or 1
	local var_32_1 = playermodel.items[arg_32_1].itemid
	local var_32_2 = item_data[playermodel.items[arg_32_1].itemid].main_attr
	local var_32_3
	local var_32_4

	if arg_32_1 and playermodel.items[arg_32_1] and playermodel.items[arg_32_1].component_attr and playermodel.items[arg_32_1].component_attr.attr2 then
		var_32_2 = playermodel.items[arg_32_1].component_attr.attr1
		var_32_3 = playermodel.items[arg_32_1].component_attr.attr2
		var_32_4 = var_0_16[playermodel.items[arg_32_1].component_attr.attr2]
	end

	local var_32_5 = var_0_16[var_32_2]
	local var_32_6 = {
		{},
		{},
		{}
	}
	local var_32_7 = {
		{},
		{},
		{}
	}

	var_32_6[1].name = var_0_18[var_32_2]
	var_32_6[1].value = 0 * var_0_20[var_32_5] + self:calculateAttr(var_32_1, var_32_5, playermodel.items[arg_32_1].component_attr.attr)

	if arg_32_2 then
		var_32_6[1].key = var_32_5
	end

	var_32_6[2].name = var_0_18[var_32_2]

	if arg_32_1 and playermodel.items[arg_32_1] and playermodel.items[arg_32_1].component_attr and playermodel.items[arg_32_1].component_attr.attr2 then
		var_32_7[1].name = var_0_18[var_32_3]
		var_32_7[1].value = 0 * var_0_20[var_32_4] + self:calculateAttr(var_32_1, var_32_4, playermodel.items[arg_32_1].component_attr.attr)

		if arg_32_2 then
			var_32_7[1].key = var_32_4
		end

		var_32_7[2].name = var_0_18[var_32_3]
	end

	local var_32_8 = 4
	local var_32_9 = 1

	while component_strengthen_weight_data[item_data[playermodel.items[arg_32_1].itemid].equip_quality]["add_weight" .. var_32_9] do
		if component_strengthen_weight_data[item_data[playermodel.items[arg_32_1].itemid].equip_quality]["add_weight" .. var_32_9] > 0 then
			var_32_8 = component_strengthen_weight_data[item_data[playermodel.items[arg_32_1].itemid].equip_quality]["add_value" .. var_32_9]

			break
		end

		var_32_9 = var_32_9 + 1
	end

	local var_32_10 = 4

	while component_strengthen_weight_data[item_data[playermodel.items[arg_32_1].itemid].equip_quality]["add_weight" .. var_32_9] do
		if component_strengthen_weight_data[item_data[playermodel.items[arg_32_1].itemid].equip_quality]["add_weight" .. var_32_9] > 0 then
			var_32_10 = math.max(component_strengthen_weight_data[item_data[playermodel.items[arg_32_1].itemid].equip_quality]["add_value" .. var_32_9])
		end

		var_32_9 = var_32_9 + 1
	end

	var_32_6[2].value = var_32_6[1].value + self:calculateAttr(var_32_1, var_32_5, var_32_8 * var_32_0)
	var_32_6[2].max_value = var_32_6[1].value + self:calculateAttr(var_32_1, var_32_5, var_32_10 * var_32_0)

	if arg_32_2 then
		var_32_6[2].key = var_32_5
	end

	if arg_32_1 and playermodel.items[arg_32_1] and playermodel.items[arg_32_1].component_attr and playermodel.items[arg_32_1].component_attr.attr2 then
		var_32_7[2].value = var_32_7[1].value + self:calculateAttr(var_32_1, var_32_4, var_32_8 * var_32_0)
		var_32_7[2].max_value = var_32_7[1].value + self:calculateAttr(var_32_1, var_32_4, var_32_10 * var_32_0)

		if arg_32_2 then
			var_32_7[2].key = var_32_4
		end
	end

	local var_32_11 = {}

	for iter_32_0 = playermodel.items[arg_32_1].component_attr.extra, var_32_0 do
		local var_32_13 = var_0_14[(arg_32_1 and playermodel.items[arg_32_1] and playermodel.items[arg_32_1].component_attr and playermodel.items[arg_32_1].component_attr.attr2 or nil) and item_data[playermodel.items[arg_32_1].itemid].equip_quality + 1][item_data[playermodel.items[arg_32_1].itemid].level][playermodel.items[arg_32_1].component_attr.extra + iter_32_0]

		if var_0_14[(arg_32_1 and playermodel.items[arg_32_1] and playermodel.items[arg_32_1].component_attr and playermodel.items[arg_32_1].component_attr.attr2 or nil) and item_data[playermodel.items[arg_32_1].itemid].equip_quality + 1][item_data[playermodel.items[arg_32_1].itemid].level][playermodel.items[arg_32_1].component_attr.extra + iter_32_0] then
			while var_32_13["material" .. 1] do
				var_32_11[#var_32_11 + 1] = {
					dropid = var_32_13["material" .. 1],
					dropNum = var_32_13["material" .. 1 .. "_num"]
				}
			end

			if var_32_13.cost then
				var_32_11.gold = var_32_11.gold or 0
				var_32_11.gold = var_32_11.gold + var_32_13.cost
			end
		end
	end

	local var_32_15 = item_data[playermodel.items[arg_32_1].itemid].equip_quality

	if arg_32_1 and playermodel.items[arg_32_1] and playermodel.items[arg_32_1].component_attr and playermodel.items[arg_32_1].component_attr.attr2 then
		var_32_15 = item_data[playermodel.items[arg_32_1].itemid].equip_quality + 1
	end

	if not var_0_14[var_32_15][item_data[playermodel.items[arg_32_1].itemid].level][playermodel.items[arg_32_1].component_attr.extra].need_exp then
		var_32_11.gold = var_0_14[var_32_15][item_data[playermodel.items[arg_32_1].itemid].level][playermodel.items[arg_32_1].component_attr.extra].unit_exp_cost_gold
	end

	self:getPowerValueBySoul(arg_32_1)

	return var_32_6, var_32_11, playermodel.items[arg_32_1].component_attr.extra, var_32_7
end

function var_0_0.smeltComponent(arg_33_0, arg_33_1, arg_33_2)
	print("smeltComponent has been deprecated, use BreakdownComponent...")
end

function var_0_0.checkNewComponent(arg_34_0, arg_34_1, arg_34_2)
	return
end

local function var_0_25(arg_35_0, arg_35_1)
	if not var_0_6[arg_35_1].equip_condition then
		return true
	end

	if var_0_6[arg_35_1].equip_condition == "all" then
		return true
	end

	if not string.find(var_0_6[arg_35_1].equip_condition, "_") then
		return var_0_6[arg_35_1].equip_condition == modelData[servant_data[arg_35_0].modelid].career
	end

	if tonumber(split(var_0_6[arg_35_1].equip_condition, "_")[2]) == servant_data[arg_35_0].major then
		return true
	end

	return false
end

function var_0_0.setComponent(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4)
	local item_manager = require("controller.item_manager")
	local fight_capacity_manager = require("controller.fight_capacity_manager")

	if item_data[playermodel.items[arg_36_3].itemid].pos ~= arg_36_2 then
		if arg_36_4 then
			arg_36_4(3)
		end

		return
	end

	if not var_0_25(arg_36_1, playermodel.items[arg_36_3].itemid) and arg_36_4 then
		arg_36_4(5)
	end

	local var_36_3 = require("data.core_data")[playermodel.cores[arg_36_1].coreid].rank
	local var_36_4 = "null"

	if playermodel.component[arg_36_1] and playermodel.component[arg_36_1][arg_36_2] then
		var_36_4 = playermodel.items[playermodel.component[arg_36_1][arg_36_2].id].itemid
	end

	network:rpc("set_component", {
		servantid = arg_36_1,
		pos = arg_36_2,
		entityid = arg_36_3
	}, function(arg_37_0)
		print(dump(arg_37_0))

		if arg_37_0.result == 1 then
			if playermodel.component[arg_36_1] and playermodel.component[arg_36_1][arg_36_2] then
				playermodel.items[playermodel.component[arg_36_1][arg_36_2].id].component_attr.use = nil

				item_manager:add_bag_weight(playermodel.items[playermodel.component[arg_36_1][arg_36_2].id].itemid, 1)

				playermodel.component[arg_36_1][arg_36_2] = nil
				playermodel.reinforce_component[arg_36_1] = 0
			end

			local var_37_0 = playermodel.items[arg_36_3].component_attr.use

			if playermodel.items[arg_36_3].component_attr.use then
				for iter_37_0, iter_37_1 in pairs(playermodel.component[var_37_0]) do
					if iter_37_1.id == arg_36_3 then
						playermodel.component[var_37_0][iter_37_0] = nil

						break
					end
				end

				playermodel.reinforce_component[var_37_0] = 0
			end

			playermodel.component[arg_36_1] = playermodel.component[arg_36_1] or {}
			playermodel.items[arg_36_3].component_attr.use = arg_36_1

			if not var_37_0 then
				item_manager:remove_bag_weight(playermodel.items[arg_36_3].itemid, 1)
			end

			playermodel.component[arg_36_1][arg_36_2] = {
				pos = arg_36_2,
				id = arg_36_3
			}

			if arg_37_0.popitems then
				for iter_37_2, iter_37_3 in pairs(arg_37_0.popitems) do
					item_manager:setItemByServerItem(iter_37_3)
				end
			end

			if playermodel:isSoulInFight(arg_36_1) or playermodel:isSoulInFight(var_37_0) then
				FightManager.registerPlayerChangeComponent()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			AlertManager:check_component_update(false)
			AnalyticManager.set_component({
				set_component_before_itemid = var_36_4,
				set_component_after_itemid = (arg_36_3 or nil) and playermodel.items[arg_36_3].itemid
			})

			if arg_36_4 then
				arg_36_4(1)
			end
		elseif arg_37_0.result == 6 then
			global_ShowBlockWords(L_COMPONENT_CANNOT_EQUIP)

			if arg_36_4 then
				arg_36_4(6)
			end
		elseif arg_36_4 then
			arg_36_4(0)
		end

		arg_36_0:checkComponentBagStatus()
	end)
end

function var_0_0.detachComponent(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	if not playermodel.component[arg_38_1] or not playermodel.component[arg_38_1][arg_38_2] then
		if arg_38_3 then
			arg_38_3(2)
		end

		return
	end

	local item_manager = require("controller.item_manager")

	network:rpc("detach_component", {
		servantid = arg_38_1,
		pos = arg_38_2
	}, function(arg_39_0)
		if arg_39_0.result == 1 then
			playermodel.items[playermodel.component[arg_38_1][arg_38_2].id].component_attr.use = nil

			item_manager:add_bag_weight(playermodel.items[playermodel.component[arg_38_1][arg_38_2].id].itemid, 1)

			playermodel.component[arg_38_1][arg_38_2] = nil

			if playermodel:isSoulInFight(arg_38_1) then
				FightManager.registerPlayerChangeComponent()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			AlertManager:check_component_update(true)

			playermodel.reinforce_component[arg_38_1] = 0

			if arg_38_3 then
				arg_38_3(1)
			end
		elseif arg_39_0.result == 3 then
			global_ShowBlockWords(L_COMPONENT_CANNOT_Unload)

			if arg_38_3 then
				arg_38_3(3)
			end
		elseif arg_38_3 then
			arg_38_3(0)
		end

		arg_38_0:checkComponentBagStatus()
	end)
end

function var_0_0.getDecomposeItems(arg_40_0, arg_40_1)
	local var_40_0 = 0

	for iter_40_0, iter_40_1 in pairs(arg_40_1) do
		local var_40_1 = 0

		if item_data[playermodel.items[iter_40_1].itemid] then
			var_40_1 = item_data[playermodel.items[iter_40_1].itemid].sale_price
		end

		local var_40_2 = playermodel.items[iter_40_1].component_attr.extra

		var_40_0 = var_40_0 + ((playermodel.items[iter_40_1].component_attr.extra and var_40_2 > 0 or nil) and var_0_14[item_data[playermodel.items[iter_40_1].itemid].equip_quality][item_data[playermodel.items[iter_40_1].itemid].level][var_40_2].sale_price) + var_40_1
	end

	return var_40_0
end

function var_0_0.BreakdownComponent(arg_41_0, arg_41_1, arg_41_2)
	if #arg_41_1 <= 0 then
		if arg_41_2 then
			arg_41_2(3)
		end

		return
	end

	for iter_41_0, iter_41_1 in pairs(arg_41_1) do
		if not playermodel.items[iter_41_1] then
			if arg_41_2 then
				arg_41_2(4)
			end

			return
		end

		if playermodel.items[iter_41_1].component_attr.use then
			if arg_41_2 then
				arg_41_2(2)
			end

			return
		end
	end

	local item_manager = require("controller.item_manager")

	network:rpc("break_down_component", {
		entityids = arg_41_1
	}, function(arg_42_0)
		if arg_42_0.result == 1 then
			AnalyticManager.decomposeSuccess1({
				ComponentId = playermodel.items[arg_41_1[1]].itemid,
				ComponentLv = playermodel.items[arg_41_1[1]].component_attr.extra
			})

			for iter_42_0, iter_42_1 in pairs(arg_41_1) do
				item_manager:deleteItem(iter_42_1)
			end

			if arg_42_0.gold then
				playermodel.gold = playermodel.gold + arg_42_0.gold
			end

			local var_42_0 = {}

			if arg_42_0.items then
				for iter_42_2, iter_42_3 in pairs(arg_42_0.items) do
					local var_42_1 = item_manager:setItemByServerItem(iter_42_3)

					if var_42_1 and var_42_1 ~= 0 then
						table.insert(var_42_0, {
							dropid = iter_42_3.itemid,
							dropNum = var_42_1,
							entityid = iter_42_3.entityid
						})
					end
				end
			end

			global_update_gold_stone_diamond(arg_42_0.gold)
			AlertManager:check_component_update(false)
			AnalyticManager.sellItemInBag(arg_42_0.gold)

			if arg_41_2 then
				arg_41_2(1, {
					gold = arg_42_0.gold,
					items = var_42_0
				})
			end
		elseif arg_41_2 then
			arg_41_2(arg_42_0.result)
		end
	end)
end

function var_0_0.BreakRemakeComponent(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	local item_manager = require("controller.item_manager")

	network:rpc("break_remake_component", {
		entityids = arg_43_1,
		isbreak = arg_43_2
	}, function(arg_44_0)
		if arg_44_0.result == 0 then
			if arg_43_2 then
				global_ShowBlockWords(L_COMPONENT_BREAK_REMAKE.chooseBreak)
			else
				global_ShowBlockWords(L_COMPONENT_BREAK_REMAKE.chooseRemake)
			end
		end

		if arg_44_0.result == 2 then
			global_ShowBlockWords("材料不足")
		end

		if arg_44_0.result == 3 then
			global_ShowBlockWords("图灵新钞不足")
		end

		if arg_44_0.result == 1 then
			for iter_44_0, iter_44_1 in ipairs(arg_43_1) do
				if playermodel.items[iter_44_1].component_attr.use then
					playermodel.items[iter_44_1].component_attr.use = nil
				end
			end

			for iter_44_2, iter_44_3 in ipairs(arg_44_0.consumeids) do
				item_manager:deleteItem(iter_44_3.entityid, iter_44_3.num)
			end

			if arg_43_2 then
				item_manager:setItemByServerItem(arg_44_0.getitem)

				if arg_43_3 then
					arg_43_3(arg_44_0.consumeids)
					LayerManager:pushInLayer("PopPurchaseResultLayer", {
						items = {
							{
								dropid = arg_44_0.getitem.itemid,
								dropNum = arg_44_0.num,
								entityid = arg_44_0.getitem.itemid
							}
						}
					})
				end
			else
				item_manager:setItemByServerItem(arg_44_0.getitem)

				playermodel.gold = playermodel.gold - arg_44_0.num

				if arg_43_3 then
					arg_43_3(arg_44_0)
				end

				LayerManager:pushInLayer("PopPurchaseResultLayer", {
					items = {
						{
							dropid = arg_44_0.getitem.itemid,
							dropNum = arg_44_0.num,
							entityid = arg_44_0.getitem.entityid
						}
					}
				})
			end
		end
	end)
end

function var_0_0:countNum(arg_45_1)
	local var_45_0 = 0

	for iter_45_0, iter_45_1 in ipairs(arg_45_1) do
		if iter_45_1 and playermodel.items[iter_45_1] and playermodel.items[iter_45_1].component_attr and playermodel.items[iter_45_1].component_attr.attr2 then
			local var_45_1 = 0

			for iter_45_2 = 0, playermodel.items[iter_45_1].component_attr.extra - 1 do
				var_45_1 = var_45_1 + self:getComponetLevelUpNeedExp(iter_45_1, iter_45_2)
			end

			var_45_0 = var_45_0 + 15 + math.floor((playermodel.items[iter_45_1].component_attr.exp + var_45_1) / 100)
		else
			local var_45_2 = 0
			local var_45_3 = 0

			if var_0_6[playermodel.items[iter_45_1].itemid].equip_quality > 4 then
				for iter_45_3 = 0, playermodel.items[iter_45_1].component_attr.extra - 1 do
					var_45_2 = var_45_2 + self:getComponetLevelUpNeedExp(iter_45_1, iter_45_3)
				end
			end

			if var_0_6[playermodel.items[iter_45_1].itemid].equip_quality == 3 then
				var_45_3 = 2
			elseif var_0_6[playermodel.items[iter_45_1].itemid].equip_quality == 4 then
				var_45_3 = 5
			elseif var_0_6[playermodel.items[iter_45_1].itemid].equip_quality == 5 then
				var_45_3 = 8 + math.floor((playermodel.items[iter_45_1].component_attr.exp + var_45_2) / 100)
			elseif var_0_6[playermodel.items[iter_45_1].itemid].equip_quality == 6 then
				var_45_3 = 10 + math.floor((playermodel.items[iter_45_1].component_attr.exp + var_45_2) / 100)
			end

			var_45_0 = var_45_0 + var_45_3
		end
	end

	return var_45_0
end

function var_0_0.getPowerValueBySoul(arg_46_0, arg_46_1, arg_46_2)
	return score
end

function var_0_0.getSubValue(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = 0

	for iter_47_0, iter_47_1 in pairs(arg_47_1) do
		if arg_47_2 and arg_47_2 < iter_47_0 then
			break
		end

		var_47_0 = var_47_0 + iter_47_1
	end

	return var_47_0
end

function var_0_0.getScore(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_1 then
		return 0
	end

	local var_48_0 = 0

	if playermodel.items[arg_48_1] then
		if item_data[playermodel.items[arg_48_1].itemid] then
			var_48_0 = var_48_0 + 10000 * item_data[playermodel.items[arg_48_1].itemid].equip_quality
		end
	end

	return var_48_0
end

function var_0_0:getPotential(arg_49_1)
	if not arg_49_1 then
		return 0
	end

	return playermodel.items[arg_49_1].component_attr.attr + (self:getMaxLevel(playermodel.items[arg_49_1].itemid) - item_data[playermodel.items[arg_49_1].itemid].level) * 12
end

function var_0_0.getMaxLevel(arg_50_0, arg_50_1)
	return #var_0_14[(not var_0_6[arg_50_1].main_attr or nil) and item_data[arg_50_1].equip_quality + 1][var_0_6[arg_50_1].level]
end

function var_0_0.compound_component_chip(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local item_manager = require("controller.item_manager")

	if require("data.item_data")[arg_51_1].bag_item_type ~= kITEM_COMPONENT_CHIP then
		if arg_51_3 then
			arg_51_3(2)
		end

		return
	end

	if not item_manager:isHaveEnoughItem(arg_51_1, 5) then
		if arg_51_3 then
			arg_51_3(3)
		end

		return
	end

	if arg_51_2 < 5 then
		if arg_51_3 then
			arg_51_3(3)
		end

		return
	end

	arg_51_2 = math.floor(arg_51_2 / 5) * 5

	network:rpc("compound_component_chip", {
		itemid = arg_51_1,
		num = arg_51_2
	}, function(arg_52_0)
		if arg_52_0.result == 1 then
			item_manager:deleteItem(arg_51_1, arg_51_2)

			if arg_51_3 then
				arg_51_3(1, arg_52_0.items)
			end
		elseif arg_51_3 then
			arg_51_3(arg_52_0.result)
		end
	end)
end

function var_0_0:getUpGradeData(arg_53_1)
	if not self:getStrengthenStatus(arg_53_1) then
		return
	end

	local var_53_0, var_53_1, var_53_2, var_53_3 = self:getStrengthenInfo(arg_53_1, true)
	local var_53_4 = {}
	local var_53_5 = {}

	var_53_4[2] = {
		name = var_53_0[1].name,
		value = var_53_0[1].value,
		newvalue = var_53_0[2].value,
		key = var_53_0[2].key,
		max_value = var_53_0[2].max_value,
		key = var_53_0[2].key
	}
	var_53_4[1] = {
		name = L_COMPONENT_TEXT.UpInfo.name[1],
		value = var_53_2,
		newvalue = var_53_2 + 1
	}

	if var_53_2 ~= 3 then
		var_53_4[3] = var_53_0[3]

		for iter_53_0, iter_53_1 in ipairs(var_53_0[3]) do
			var_53_4[3][iter_53_0].newvalue = var_0_21(iter_53_1.key, iter_53_1.value) .. "+" .. var_0_21(iter_53_1.key, var_0_20[iter_53_1.key] * 4) .. "~" .. var_0_21(iter_53_1.key, var_0_20[iter_53_1.key] * MAX_COMPONENT_SUB_ATTR)
		end
	end

	if arg_53_1 and playermodel.items[arg_53_1] and playermodel.items[arg_53_1].component_attr and playermodel.items[arg_53_1].component_attr.attr2 then
		var_53_5[2] = {
			name = var_53_3[1].name,
			value = var_53_3[1].value,
			newvalue = var_53_3[2].value,
			key = var_53_3[2].key,
			max_value = var_53_3[2].max_value,
			key = var_53_3[2].key
		}
		var_53_5[1] = {
			name = L_COMPONENT_TEXT.UpInfo.name[1],
			value = var_53_2,
			newvalue = var_53_2 + 1
		}

		if var_53_2 ~= 3 then
			var_53_5[3] = var_53_3[3]

			for iter_53_2, iter_53_3 in ipairs(var_53_3[3]) do
				var_53_5[3][iter_53_2].newvalue = var_0_21(iter_53_3.key, iter_53_3.value) .. "+" .. var_0_21(iter_53_3.key, var_0_20[iter_53_3.key] * 4) .. "~" .. var_0_21(iter_53_3.key, var_0_20[iter_53_3.key] * MAX_COMPONENT_SUB_ATTR)
			end
		end
	end

	local var_53_6 = {}

	for iter_53_4 = 1, #var_53_1 do
		var_53_6[iter_53_4] = {}

		if type(var_53_1[iter_53_4].dropid) == "string" then
			if var_53_1[iter_53_4].dropid == "gold" then
				var_53_6[iter_53_4].id = "gold"
				var_53_6[iter_53_4].neednum = var_53_1[iter_53_4].dropNum
				var_53_6[iter_53_4].ownnum = playermodel.gold
			elseif var_53_1[iter_53_4].dropid == "diamond" then
				var_53_6[iter_53_4].id = "diamond"
				var_53_6[iter_53_4].neednum = var_53_1[iter_53_4].dropNum
				var_53_6[iter_53_4].ownnum = playermodel.diamond
			end
		else
			var_53_6[iter_53_4].id = var_53_1[iter_53_4].dropid
			var_53_6[iter_53_4].neednum = var_53_1[iter_53_4].dropNum
			var_53_6[iter_53_4].ownnum = itemManager:getItemNumber(var_53_1[iter_53_4].dropid)
		end
	end

	return {
		labels = var_53_4,
		labels2 = var_53_5,
		materials = var_53_6,
		gold_cost = var_53_1.gold
	}
end

function var_0_0:checkIsCanReplaceBetter(arg_54_1, arg_54_2)
	local item_data = require("data.item_data")

	local function var_54_4(arg_58_0)
		local var_58_0

		for iter_58_0 = 1, 3 do
			if playermodel.component[arg_58_0] and playermodel.component[arg_58_0][iter_58_0] then
				if not var_58_0 then
					var_58_0 = playermodel.items[playermodel.component[arg_58_0][iter_58_0].id].component_attr.effect
				elseif var_58_0 ~= playermodel.items[playermodel.component[arg_58_0][iter_58_0].id].component_attr.effect then
					var_58_0 = nil

					return
				end
			else
				var_58_0 = nil

				return nil
			end
		end

		return var_58_0
	end

	local var_54_5

	for iter_54_0, iter_54_1 in pairs(playermodel.items) do
		if iter_54_1.itemtype == kITEM_COMPONENT and item_data[iter_54_1.itemid].pos == arg_54_2 and not iter_54_1.component_attr.use then
			var_54_5 = playermodel.component[arg_54_1] and playermodel.component[arg_54_1][arg_54_2] and (var_54_5 or self:getScore(playermodel.component[arg_54_1][arg_54_2].id, arg_54_1)) or 0

			if var_54_5 < self:getScore(iter_54_1.entityid, arg_54_1) then
				local var_54_6 = var_54_4(arg_54_1)

				if var_54_6 then
					if var_54_6 == iter_54_1.component_attr.effect then
						return true
					end
				else
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.isBecomeStronger(arg_59_0, arg_59_1)
	if not playermodel.component[arg_59_1] then
		return false
	end

	for iter_59_0, iter_59_1 in pairs(playermodel.component[arg_59_1]) do
		if var_0_0:isTipsStrengComponent(iter_59_1.id, arg_59_1) then
			return true
		end
	end

	return false
end

function var_0_0.isTipsStrengComponent(arg_60_0, arg_60_1, arg_60_2)
	return false
end

function var_0_0.getComponentExp(arg_61_0, arg_61_1)
	if not arg_61_1 then
		return 0
	end

	return playermodel.items[arg_61_1].component_attr.exp or 0
end

function var_0_0.getComponetLevelUpNeedExp(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = playermodel.items[arg_62_1].itemid

	return var_0_14[(arg_62_1 and playermodel.items[arg_62_1] and playermodel.items[arg_62_1].component_attr and playermodel.items[arg_62_1].component_attr.attr2 or nil) and item_data[var_62_0].equip_quality + 1][item_data[var_62_0].level][arg_62_2 or playermodel.items[arg_62_1].component_attr.extra].need_exp
end

local var_0_26 = {
	255,
	65280,
	16711680,
	4278190080
}

function var_0_0.getComponentStrengthenInfo(arg_63_0, arg_63_1)
	local var_63_0 = {
		0,
		0,
		0,
		0,
		0,
		0,
		0,
		0
	}

	for iter_63_0, iter_63_1 in pairs(playermodel.items[arg_63_1].component_attr.strengthen or {}) do
		var_63_0[(iter_63_0 - 1) * 4 + 1] = bit.band(var_0_26[1], iter_63_1)
		var_63_0[(iter_63_0 - 1) * 4 + 2] = bit.rshift(bit.band(var_0_26[2], iter_63_1), 8)
		var_63_0[(iter_63_0 - 1) * 4 + 3] = bit.rshift(bit.band(var_0_26[3], iter_63_1), 16)
		var_63_0[(iter_63_0 - 1) * 4 + 4] = bit.rshift(bit.band(var_0_26[4], iter_63_1), 24)
	end

	return var_63_0
end

function var_0_0.getComponentMaterialExp(arg_64_0, arg_64_1)
	local var_64_0 = 0
	local var_64_1 = 0

	if arg_64_1 then
		for iter_64_0, iter_64_1 in pairs(arg_64_1) do
			var_64_1 = type(iter_64_1) == "number" and playermodel.items[iter_64_1].component_attr and var_0_14[(iter_64_1 and playermodel.items[iter_64_1] and playermodel.items[iter_64_1].component_attr and playermodel.items[iter_64_1].component_attr.attr2 or nil) and var_0_6[playermodel.items[iter_64_1].itemid].equip_quality + 1][var_0_6[playermodel.items[iter_64_1].itemid].level][playermodel.items[iter_64_1].component_attr.extra].give_exp or 100 * iter_64_1.num
			var_64_0 = var_64_0 + var_64_1
		end
	end

	return var_64_0
end

function var_0_0.getStrengthenExpected(arg_65_0, arg_65_1, arg_65_2)
	playermodel.items[arg_65_1].component_attr.exp = playermodel.items[arg_65_1].component_attr.exp or 0
	playermodel.items[arg_65_1].component_attr.strengthen = playermodel.items[arg_65_1].component_attr.strengthen or {}

	local var_65_0 = playermodel.items[arg_65_1].itemid
	local var_65_1 = var_0_6[playermodel.items[arg_65_1].itemid].equip_quality

	if arg_65_1 and playermodel.items[arg_65_1] and playermodel.items[arg_65_1].component_attr and playermodel.items[arg_65_1].component_attr.attr2 then
		var_65_1 = var_0_6[var_65_0].equip_quality + 1
	end

	local var_65_2 = var_0_6[var_65_0].level
	local var_65_4 = playermodel.items[arg_65_1].component_attr.exp
	local var_65_5 = playermodel.items[arg_65_1].component_attr.extra
	local var_65_6 = 0

	if var_0_14[var_65_1][var_0_6[var_65_0].level][playermodel.items[arg_65_1].component_attr.extra].need_exp then
		while arg_65_2 > 0 do
			local var_65_7

			if var_0_14[var_65_1][var_65_2][var_65_5].need_exp then
				var_65_7 = var_0_14[var_65_1][var_65_2][var_65_5].need_exp - var_65_4
			end

			if not var_65_7 then
				var_65_4 = 0

				break
			end

			if var_65_7 <= arg_65_2 then
				if not var_0_14[var_65_1][var_65_2][var_65_5 + 1] then
					var_65_4 = 0

					break
				end

				arg_65_2 = arg_65_2 - var_65_7
				var_65_4 = 0
				var_65_6 = var_65_6 + var_0_14[var_65_1][var_65_2][var_65_5].unit_exp_cost_gold * var_65_7
				var_65_5 = var_65_5 + 1
			else
				var_65_4 = var_65_4 + arg_65_2
				var_65_6 = var_65_6 + var_0_14[var_65_1][var_65_2][var_65_5].unit_exp_cost_gold * arg_65_2
				arg_65_2 = 0
			end
		end
	else
		var_65_6 = var_0_14[var_65_1][var_65_2][var_65_5].unit_exp_cost_gold
		var_65_5 = var_65_5 + 1
	end

	return var_65_5, var_65_4, var_65_6
end

function var_0_0.getComponentLevelNeedExp(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = var_0_6[playermodel.items[arg_66_1].itemid].equip_quality

	if arg_66_1 and playermodel.items[arg_66_1] and playermodel.items[arg_66_1].component_attr and playermodel.items[arg_66_1].component_attr.attr2 then
		var_66_0 = var_0_6[playermodel.items[arg_66_1].itemid].equip_quality + 1
	end

	local var_66_1 = var_0_6[playermodel.items[arg_66_1].itemid].level

	if not var_0_14[var_66_0] then
		return 0
	end

	if not var_0_14[var_66_0][var_66_1] then
		return 0
	end

	local var_66_2 = 0

	for iter_66_0 = playermodel.items[arg_66_1].component_attr.extra, arg_66_2 do
		if var_0_14[var_66_0][var_66_1][iter_66_0] then
			var_66_2 = var_66_2 + (var_0_14[var_66_0][var_66_1][iter_66_0].need_exp or 0)
		end
	end

	return var_66_2 - playermodel.items[arg_66_1].component_attr.exp
end

function var_0_0.getComponentImageId(arg_67_0, arg_67_1)
	local var_67_0 = item_data[arg_67_1]
	local var_67_1 = itemattr and var_0_22(itemattr) or var_0_22((string.format("effect=%d", item_data[arg_67_1].effect1)))
	local var_67_2 = var_67_0.main_attr

	return var_67_0.main_attr and (var_67_1 and component_effect_data[var_67_1] and string.format("component/%d-%d-%d", component_effect_data[var_67_1].image_id, var_67_0.pos, var_67_2) or string.format("component/unknow-%d-1-%d", var_67_0.pos, var_67_2)) or var_67_1 and component_effect_data[var_67_1] and string.format("component/%d-%d", component_effect_data[var_67_1].image_id, var_67_0.pos) or string.format("component/unknow-%d-1", var_67_0.pos)
end

function var_0_0.set_reinforce_component(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	if not arg_68_2 or not next(arg_68_2) then
		global_ShowBlockWords(L_COMPONENT[1])

		if arg_68_3 then
			arg_68_3({
				result = 11
			})
		end

		return
	end

	local var_68_0
	local var_68_1 = {}

	if arg_68_2 then
		for iter_68_0, iter_68_1 in pairs(arg_68_2) do
			if type(iter_68_1) == "table" then
				var_68_0 = iter_68_1.num
			else
				table.insert(var_68_1, iter_68_1)
			end
		end
	else
		var_68_1 = nil
	end

	network:rpc("set_reinforce_component", {
		servantid = arg_68_1,
		materialComponent = var_68_1,
		assemblyNum = var_68_0
	}, function(arg_69_0)
		if arg_69_0.result == 0 then
			print("servantid is nil ", arg_68_1)
		elseif arg_69_0.result == 2 then
			print("未装备3个零件")
			global_ShowBlockWords(L_COMPONENT[2])
		elseif arg_69_0.result == 3 then
			print("3个零件的品质不同")
			global_ShowBlockWords(L_COMPONENT[3])
		elseif arg_69_0.result == 4 then
			print("芯片品质小于5")
			global_ShowBlockWords(L_COMPONENT[4])
		elseif arg_69_0.result == 5 then
			print("所有零件不为同一个套装")
			global_ShowBlockWords(L_COMPONENT[5])
		elseif arg_69_0.result == 6 then
			global_ShowBlockWords(L_GOLD_LACK)
		elseif arg_69_0.result == 7 then
			global_ShowBlockWords(L_COMPONENT[6])
			print("已固化")
		elseif arg_69_0.result == 8 then
			global_ShowBlockWords(L_COMPONENT[7])
		elseif arg_69_0.result == 9 then
			global_ShowBlockWords(L_COMPONENT[8])
		elseif arg_69_0.result == 10 then
			-- block empty
		elseif arg_69_0.result == 11 then
			global_ShowBlockWords(L_COMPONENT[9])
		elseif arg_69_0.result == 1 then
			local item_manager = require("controller.item_manager")

			playermodel.reinforce_component[arg_69_0.servantid] = arg_69_0.reinforce_component

			if arg_69_0.consumes then
				for iter_69_0, iter_69_1 in ipairs(arg_69_0.consumes) do
					item_manager:deleteItem(iter_69_1.entityid, iter_69_1.num)
				end

				if var_68_0 then
					item_manager:deleteItem(5100002, var_68_0)
				end
			end
		end

		if arg_68_3 then
			arg_68_3(arg_69_0)
		end
	end)
end

function var_0_0.is_reinforce_component(arg_70_0, arg_70_1)
	return playermodel.reinforce_component[playermodel.items[arg_70_1].component_attr.use] ~= 0
end

local var_0_27 = {
	defence = 7,
	strike_damage_add = 8,
	hp_percent = 5,
	extra_attack = 4,
	energydefence = 10,
	extra_heal_extern = 2,
	rage_recover_speed = 14,
	dodge = 3,
	critical = 6,
	extra_heal = 9,
	extra_energy_attack = 13,
	spellpower = 1,
	extra_mechanical_attack = 12,
	extra_defence = 11
}
local var_0_28 = 1
local var_0_29 = {
	[var_0_27.spellpower] = 2,
	[var_0_27.extra_heal_extern] = 2,
	[var_0_27.dodge] = 2,
	[var_0_27.extra_attack] = 1,
	[var_0_27.hp_percent] = 2,
	[var_0_27.critical] = 1,
	[var_0_27.defence] = 2,
	[var_0_27.strike_damage_add] = 2,
	[var_0_27.extra_heal] = 2,
	[var_0_27.energydefence] = 2,
	[var_0_27.extra_defence] = 2,
	[var_0_27.extra_mechanical_attack] = 2,
	[var_0_27.extra_energy_attack] = 2,
	[var_0_27.rage_recover_speed] = 2
}

function var_0_0:isRecommendComponent(arg_71_1, arg_71_2)
	local core_manager = require("controller.core_manager")

	if playermodel.grade > 380 then
		return false
	end

	local var_71_1 = self:parseRecommendAttrs(arg_71_1)

	if #var_71_1 ~= 4 then
		print("recommend attrs is error, servantid is: ", arg_71_1)

		return false
	end

	local var_71_2 = var_0_6[playermodel.items[arg_71_2].itemid]
	local var_71_3 = FIGHT_ATTR_INFO[COMPONENT_MAIN_ATTR[var_0_6[playermodel.items[arg_71_2].itemid].main_attr]] or ""
	local var_71_4 = require("data.component_effect_data")[var_71_2.effect1].name or ""

	if (var_71_3 ~= var_71_1[1] or var_71_4 ~= var_71_1[2]) and (var_71_3 ~= var_71_1[3] or var_71_4 ~= var_71_1[4]) then
		return false
	end

	return true, var_0_29[var_71_2.main_attr] or var_0_28
end

function var_0_0:parseRecommendAttrs(arg_72_1)
	if self.recommendCache[arg_72_1] then
		return self.recommendCache[arg_72_1]
	end

	local model_data = require("data.model_data")

	if not model_data["" .. arg_72_1] then
		return {}
	end

	local var_72_1 = model_data["" .. arg_72_1].Recommended_attribute
	local var_72_2

	if not model_data["" .. arg_72_1].Recommended_attribute then
		print("miss recommend attrs, servantid: ", arg_72_1)

		do return {} end

		var_72_2 = {}
	end

	for iter_72_0 in string.gmatch(var_72_1, "([\x80-\xBF\xC2-\xF4]+)") do
		if iter_72_0 == "闪避" then
			iter_72_0 = "闪避率"
		end

		var_72_2[#var_72_2 + 1] = iter_72_0
	end

	self.recommendCache[arg_72_1] = var_72_2

	return var_72_2
end

function var_0_0.createMaxComponentData(arg_73_0, arg_73_1)
	local var_73_0 = {}

	arg_73_1 = tonumber(arg_73_1)

	assert(recommend_chip_data[arg_73_1], "servant " .. arg_73_1 .. " not have chip component")

	for iter_73_0 = 1, 3 do
		table.insert(var_73_0, {
			extra = 0,
			itemid = recommend_chip_data[arg_73_1]["item" .. iter_73_0],
			sub_attr = {
				value = 0.1,
				key = COMPONENT_MAIN_ATTR[var_0_6[recommend_chip_data[arg_73_1]["item" .. iter_73_0]].main_attr]
			},
			effect = var_0_6[recommend_chip_data[arg_73_1]["item" .. iter_73_0]].effect1
		})
	end

	return var_73_0
end

function var_0_0.hadAdjustComponent(arg_74_0, arg_74_1)
	if type(arg_74_1) == "number" then
		if playermodel.items[arg_74_1].component_attr and playermodel.items[arg_74_1].component_attr.reroll_num and playermodel.items[arg_74_1].component_attr.reroll_num > 0 then
			return true
		end
	end

	return false
end

function var_0_0:canAdjustComponent(arg_75_1)
	if self:hadAdjustComponent(arg_75_1) then
		return false
	end

	if self:getStrengthenStatus(arg_75_1) then
		return false
	end

	local var_75_0 = 1
	local var_75_1 = 0

	while component_strengthen_weight_data[var_0_6[playermodel.items[arg_75_1].itemid].equip_quality]["add_weight" .. var_75_0] do
		if component_strengthen_weight_data[var_0_6[playermodel.items[arg_75_1].itemid].equip_quality]["add_weight" .. var_75_0] > 0 then
			var_75_1 = var_75_0
		end

		var_75_0 = var_75_0 + 1
	end

	if var_75_1 == 0 then
		return false
	end

	local var_75_2 = self:getComponentStrengthenInfo(arg_75_1)
	local var_75_3 = self:getExtraPoint(arg_75_1)
	local var_75_4 = 0

	for iter_75_0, iter_75_1 in ipairs(var_75_2) do
		var_75_4 = iter_75_1 + var_75_4
	end

	if var_75_4 == 0 and var_75_3 > 0 then
		return false
	end

	return var_75_2[var_75_1] ~= var_75_3 or var_75_4 ~= var_75_3
end

function var_0_0:adjustComponent(arg_76_1, arg_76_2, arg_76_3)
	local item_manager = require("controller.item_manager")
	local var_76_1
	local var_76_2 = playermodel.items[arg_76_1].component_attr
	local var_76_3 = item_data[playermodel.items[arg_76_1].itemid]

	if item_manager:getItemNumber(5100001) < 1 then
		if arg_76_3 then
			arg_76_3(3)
		end

		return
	end

	if self:getAdjustNeedGold(arg_76_1) > playermodel.gold then
		if arg_76_3 then
			arg_76_3(4)
		end

		return
	end

	self:saveComponentAttr(arg_76_1)

	local var_76_5 = {}

	for iter_76_0, iter_76_1 in pairs(arg_76_2) do
		if type(iter_76_1) == "table" then
			var_76_1 = iter_76_1.num
		else
			var_76_5[#var_76_5 + 1] = iter_76_1
		end
	end

	network:rpc("component_reroll", {
		entityid = arg_76_1,
		materialComponent = var_76_5,
		assemblyNum = var_76_1
	}, function(arg_77_0)
		if arg_77_0.result == 1 then
			var_76_2.extra = arg_77_0.component.extra
			var_76_2.attr = arg_77_0.component.attr
			var_76_2.strengthen = arg_77_0.component.strengthen
			var_76_2.exp = arg_77_0.component.exp
			var_76_2.reroll_num = arg_77_0.component.reroll_num

			if var_76_2.use then
				for iter_77_0, iter_77_1 in pairs(playermodel.curSoul) do
					if iter_77_1.classtype == 1 and playermodel.component[iter_77_1.fight_girl] then
						for iter_77_2, iter_77_3 in pairs(playermodel.component[iter_77_1.fight_girl]) do
							if iter_77_3.id == arg_76_1 then
								FightManager.registerPlayerChangeComponent()
								cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))

								break
							end
						end
					end
				end
			end

			for iter_77_4, iter_77_5 in pairs(arg_77_0.cost_items) do
				item_manager:deleteItem(iter_77_5.entityid, iter_77_5.num)
			end

			playermodel.gold = playermodel.gold - arg_77_0.cost_gold

			global_update_gold_stone_diamond(arg_77_0.cost_gold)
			AnalyticManager.strengthComponentSuccess({
				component_attr = var_0_18[var_76_3.main_attr],
				level = var_76_2.extra
			})
			self:disPlayComponentChangeAttr(arg_76_1, function()
				if arg_76_3 then
					arg_76_3(1)
				end
			end)
			require("controller.audio_manager"):playeffectMusicTest("sound/upgrade")
		elseif arg_77_0.result == 2 then
			if arg_76_3 then
				arg_76_3(2)
			end
		elseif arg_77_0.result == 3 then
			if arg_76_3 then
				arg_76_3(3)
			end
		elseif arg_76_3 then
			arg_76_3(0)
		end
	end)
end

function var_0_0.getAdjustNeedExp(arg_79_0, arg_79_1)
	return component_strengthen_weight_data[item_data[playermodel.items[arg_79_1].itemid].equip_quality].cost_exp or 0
end

function var_0_0.getAdjustNeedGold(arg_80_0, arg_80_1)
	return component_strengthen_weight_data[item_data[playermodel.items[arg_80_1].itemid].equip_quality].cost_gold or 0
end

function var_0_0:getComponentAttrRange(arg_81_1)
	local var_81_1 = var_0_16[(arg_81_1 and playermodel.items[arg_81_1] and playermodel.items[arg_81_1].component_attr and playermodel.items[arg_81_1].component_attr.attr2 or nil) and playermodel.items[arg_81_1].component_attr.attr1]
	local var_81_2 = self:calculateAttr(playermodel.items[arg_81_1].itemid, var_0_16[(arg_81_1 and playermodel.items[arg_81_1] and playermodel.items[arg_81_1].component_attr and playermodel.items[arg_81_1].component_attr.attr2 or nil) and playermodel.items[arg_81_1].component_attr.attr1], playermodel.items[arg_81_1].component_attr.attr)
	local var_81_3 = var_81_2
	local var_81_4 = var_81_2
	local var_81_5 = 0
	local var_81_6 = 0

	for iter_81_0, iter_81_1 in ipairs((self:getComponentStrengthenInfo(arg_81_1))) do
		if iter_81_1 > 0 and component_strengthen_weight_data[item_data[playermodel.items[arg_81_1].itemid].equip_quality]["add_weight" .. iter_81_0] and component_strengthen_weight_data[item_data[playermodel.items[arg_81_1].itemid].equip_quality]["add_weight" .. iter_81_0] > 0 then
			var_81_4 = var_81_4 - self:calculateAttr(playermodel.items[arg_81_1].itemid, var_81_1, component_strengthen_weight_data[item_data[playermodel.items[arg_81_1].itemid].equip_quality]["add_value" .. iter_81_0] * iter_81_1)

			if var_81_6 == 0 then
				var_81_3 = var_81_3 - self:calculateAttr(playermodel.items[arg_81_1].itemid, var_81_1, component_strengthen_weight_data[item_data[playermodel.items[arg_81_1].itemid].equip_quality]["add_value" .. iter_81_0])
				var_81_6 = iter_81_0
			end

			var_81_5 = var_81_5 + iter_81_1
		end
	end

	local var_81_7 = 1

	::label_81_0::

	local var_81_9

	if component_strengthen_weight_data[item_data[playermodel.items[arg_81_1].itemid].equip_quality]["add_weight" .. 1] then
		repeat
			if component_strengthen_weight_data[item_data[playermodel.items[arg_81_1].itemid].equip_quality]["add_weight" .. 1] > 0 then
				var_81_7 = 1
			end

			goto label_81_0
		until true

		var_81_9 = {
			key = var_81_1,
			minValue = var_81_3 + self:calculateAttr(playermodel.items[arg_81_1].itemid, var_81_1, component_strengthen_weight_data[item_data[playermodel.items[arg_81_1].itemid].equip_quality]["add_value" .. var_81_6 + 1])
		}
	end

	var_81_9.maxValue = var_81_4 + self:calculateAttr(playermodel.items[arg_81_1].itemid, var_81_1, component_strengthen_weight_data[item_data[playermodel.items[arg_81_1].itemid].equip_quality]["add_value" .. var_81_7] * var_81_5)

	return var_81_9
end

function var_0_0.isMaxLevel(arg_82_0, arg_82_1)
	return #var_0_14[item_data[playermodel.items[arg_82_1].itemid].equip_quality][item_data[playermodel.items[arg_82_1].itemid].level] <= playermodel.items[arg_82_1].component_attr.extra
end

function var_0_0:isMaxLevelByServantid(arg_83_1)
	local var_83_0 = true

	if playermodel.component[arg_83_1] then
		for iter_83_0, iter_83_1 in pairs(playermodel.component[arg_83_1]) do
			if not self:isMaxLevel(iter_83_1.id) then
				var_83_0 = false

				break
			end
		end
	end

	return var_83_0
end

function var_0_0:isAllMaxLevelByServantid(arg_84_1)
	local var_84_0 = true

	if playermodel.component[arg_84_1] then
		for iter_84_0 = 1, 3 do
			if not playermodel.component[arg_84_1][iter_84_0] then
				var_84_0 = false

				break
			end

			if not self:isMaxLevel(playermodel.component[arg_84_1][iter_84_0].id) then
				var_84_0 = false

				break
			end
		end
	else
		var_84_0 = false
	end

	return var_84_0
end

function var_0_0:canFastStrengthen(arg_85_1)
	local filter_config_manager = require("controller.filter_config_manager")
	local var_85_1 = filter_config_manager:getDefaultFilterData(filter_config_manager.COMPONENT_STRENGTHEN)

	if not var_85_1.filterConfig.use then
		var_85_1.filterConfig.use = {}

		table.insert(var_85_1.filterConfig.use, false)

		var_85_1.filterConfig.lock = {}

		table.insert(var_85_1.filterConfig.lock, false)
	end

	var_85_1.sortOrder = 0
	var_85_1.sortType = 1

	local var_85_2 = {}

	for iter_85_0, iter_85_1 in pairs((require("controller.bag_manager").create():getBagData(var_85_1))) do
		if item_data[playermodel.items[iter_85_1].itemid].equip_quality ~= 3 and item_data[playermodel.items[iter_85_1].itemid].equip_quality ~= 4 or playermodel.items[iter_85_1].component_attr and playermodel.items[iter_85_1].component_attr.use then
			-- block empty
		else
			var_85_2[#var_85_2 + 1] = iter_85_1
		end
	end

	local var_85_3 = false

	if playermodel.component[arg_85_1] then
		for iter_85_2, iter_85_3 in pairs(playermodel.component[arg_85_1]) do
			if not self:isMaxLevel(iter_85_3.id) then
				local var_85_4 = {}
				local var_85_5 = self:getExtraPoint(iter_85_3.id)

				for iter_85_4, iter_85_5 in pairs(var_85_2) do
					if iter_85_5 ~= iter_85_3.id then
						var_85_4[#var_85_4 + 1] = iter_85_5

						if var_85_5 < self:getStrengthenExpected(iter_85_3.id, (self:getComponentMaterialExp(var_85_4))) then
							var_85_3 = true

							return true
						end
					end
				end
			end
		end
	end

	return var_85_3
end

function var_0_0:getFastStrengthenInfo(arg_86_1, arg_86_2)
	arg_86_2 = arg_86_2 or {}

	local bag_manager = require("controller.bag_manager")
	local filter_config_manager = require("controller.filter_config_manager")

	if playermodel.component[arg_86_1] then
		local var_86_2 = filter_config_manager:getDefaultFilterData(filter_config_manager.COMPONENT_STRENGTHEN)

		if not var_86_2.filterConfig.use then
			var_86_2.filterConfig.use = {}

			table.insert(var_86_2.filterConfig.use, false)

			var_86_2.filterConfig.lock = {}

			table.insert(var_86_2.filterConfig.lock, false)
		end

		var_86_2.sortOrder = 0
		var_86_2.sortType = 1

		local var_86_3 = {}

		for iter_86_0, iter_86_1 in pairs((bag_manager.create():getBagData(var_86_2))) do
			if item_data[playermodel.items[iter_86_1].itemid].equip_quality ~= 3 and item_data[playermodel.items[iter_86_1].itemid].equip_quality ~= 4 or playermodel.items[iter_86_1].component_attr and playermodel.items[iter_86_1].component_attr.use then
				-- block empty
			else
				var_86_3[#var_86_3 + 1] = iter_86_1
			end
		end

		local var_86_4 = arg_86_2.ownComponentList or var_86_3
		local var_86_5 = arg_86_2.ownGold or playermodel.gold
		local var_86_6 = {}
		local var_86_7 = false

		for iter_86_2, iter_86_3 in pairs(playermodel.component[arg_86_1]) do
			var_86_6[iter_86_3.id] = var_86_6[iter_86_3.id] or {
				costGold = 0,
				selectComponentList = {},
				lastLv = playermodel.items[iter_86_3.id].component_attr.extra,
				curLv = playermodel.items[iter_86_3.id].component_attr.extra,
				pos = iter_86_3.pos
			}

			local var_86_8 = var_86_6[iter_86_3.id].curLv

			if not playermodel.items[iter_86_3.id].component_attr.exp then
				-- block empty
			end

			local var_86_10 = 0

			while var_86_8 < self:getMaxLevel(playermodel.items[iter_86_3.id].itemid) do
				local var_86_11 = false
				local var_86_12 = false

				if self:getComponetLevelUpNeedExp(iter_86_3.id, var_86_8) then
					if next(var_86_4) then
						local var_86_13 = false

						while next(var_86_4) do
							table.insert(var_86_6[iter_86_3.id].selectComponentList, table.remove(var_86_4, #var_86_4))

							local var_86_14, var_86_15, var_86_16 = self:getStrengthenExpected(iter_86_3.id, (self:getComponentMaterialExp(var_86_6[iter_86_3.id].selectComponentList)))

							if var_86_5 < var_86_16 then
								table.insert(var_86_4, table.remove(var_86_6[iter_86_3.id].selectComponentList, #var_86_6[iter_86_3.id].selectComponentList))

								var_86_11 = true

								break
							else
								var_86_10 = var_86_16

								if var_86_8 < var_86_14 then
									var_86_8 = var_86_14
									var_86_13 = true

									break
								end
							end
						end

						var_86_12 = not var_86_13
					else
						break
					end
				else
					local var_86_18 = var_0_14[var_0_6[playermodel.items[iter_86_3.id].itemid].equip_quality][var_0_6[playermodel.items[iter_86_3.id].itemid].level][var_86_8].unit_exp_cost_gold

					if var_86_5 < var_0_14[var_0_6[playermodel.items[iter_86_3.id].itemid].equip_quality][var_0_6[playermodel.items[iter_86_3.id].itemid].level][var_86_8].unit_exp_cost_gold then
						break
					else
						var_86_8 = var_86_8 + 1
						var_86_10 = var_86_10 + var_86_18
					end
				end

				if var_86_11 or var_86_12 then
					break
				end
			end

			if var_86_10 > 0 then
				var_86_5 = var_86_5 - var_86_10
				var_86_6[iter_86_3.id].costGold = var_86_6[iter_86_3.id].costGold + var_86_10
			end

			var_86_6[iter_86_3.id].lastLv = var_86_8
		end

		for iter_86_4, iter_86_5 in pairs(var_86_6) do
			if iter_86_5.lastLv > iter_86_5.curLv or iter_86_5.costGold > 0 then
				var_86_7 = true

				break
			end
		end

		if var_86_7 then
			UpdataTableData(arg_86_2, {
				ownGold = var_86_5
			})

			return {
				ownData = arg_86_2,
				componentInfo = var_86_6
			}
		else
			return {
				ownData = arg_86_2,
				componentInfo = var_86_6
			}
		end
	end

	return nil
end

function var_0_0:equipComponentOnekey(arg_87_1, arg_87_2)
	local model_data = require("data.model_data")
	local item_manager = require("controller.item_manager")
	local var_87_2 = {}

	for iter_87_0, iter_87_1 in pairs(playermodel.haveServant) do
		if iter_87_1 and playermodel.component[iter_87_0] and next(playermodel.component[iter_87_0]) then
			for iter_87_2, iter_87_3 in pairs(playermodel.component[iter_87_0]) do
				var_87_2[iter_87_3.id] = true
			end
		end
	end

	local var_87_3 = {}
	local var_87_4 = {}

	for iter_87_4, iter_87_5 in pairs(playermodel.items) do
		if var_0_6[iter_87_5.itemid] and var_0_6[iter_87_5.itemid].bag_item_type and var_0_6[iter_87_5.itemid].bag_item_type == kITEM_COMPONENT and not var_87_2[iter_87_4] then
			local var_87_5 = self:getComponentAttrsInfo(iter_87_5.entityid)

			var_87_5.entityid = iter_87_5.entityid
			var_87_3[iter_87_5.entityid] = {
				suitId = iter_87_5.component_attr.effect,
				mainAttrId = var_87_5.main_attr_num
			}
			var_87_4[iter_87_5.component_attr.effect] = var_87_4[iter_87_5.component_attr.effect] or {}
			var_87_4[iter_87_5.component_attr.effect][var_87_5.main_attr_num] = var_87_4[iter_87_5.component_attr.effect][var_87_5.main_attr_num] or {}

			table.insert(var_87_4[iter_87_5.component_attr.effect][var_87_5.main_attr_num], var_87_5)
		end
	end

	if not next(var_87_4) then
		if arg_87_2 then
			arg_87_2({
				no_component = true
			})
		end

		return
	end

	local var_87_6 = string.split(require("controller.GlobalConstantsManager"):getInstance():getValueById(8), "|")
	local var_87_7 = {}

	for iter_87_6 = 1, #var_87_6 do
		local var_87_8 = string.split(var_87_6[iter_87_6], "&")
		local var_87_9 = string.split(var_87_8[2], "#")
		local var_87_10 = string.split(var_87_8[3], "#")
		local var_87_11 = string.split(var_87_8[4], "#")

		var_87_7[var_87_8[1]] = {}
		var_87_7[var_87_8[1]].suits = {}
		var_87_7[var_87_8[1]].damageType = {
			{},
			{}
		}

		for iter_87_7 = 1, #var_87_9 do
			var_87_7[var_87_8[1]].suits[#var_87_7[var_87_8[1]].suits + 1] = tonumber(var_87_9[iter_87_7])
		end

		for iter_87_8 = 1, #var_87_10 do
			var_87_7[var_87_8[1]].damageType[1][#var_87_7[var_87_8[1]].damageType[1] + 1] = tonumber(var_87_10[iter_87_8])
		end

		for iter_87_9 = 1, #var_87_11 do
			var_87_7[var_87_8[1]].damageType[2][#var_87_7[var_87_8[1]].damageType[2] + 1] = tonumber(var_87_11[iter_87_9])
		end
	end

	local var_87_12 = {}
	local var_87_13 = arg_87_1

	if arg_87_1 then
		var_87_12[var_87_13] = var_87_12[var_87_13] or {}
		var_87_12[var_87_13].servantid = var_87_13

		local var_87_14 = {}

		if playermodel.component[var_87_13] then
			for iter_87_10, iter_87_11 in pairs(playermodel.component[var_87_13]) do
				var_87_14[iter_87_11.pos] = true
			end
		end

		for iter_87_12 = 1, 3 do
			if not var_87_14[iter_87_12] and var_87_7[model_data[servant_data[var_87_13].modelid].career] then
				var_87_12[var_87_13].componentList = var_87_12[var_87_13].componentList or {}

				local var_87_15 = var_87_7[model_data[servant_data[var_87_13].modelid].career].damageType[model_data[servant_data[var_87_13].modelid].damage_type] or var_87_7[model_data[servant_data[var_87_13].modelid].career].damageType[1]
				local var_87_16 = false

				for iter_87_13 = 1, #var_87_7[model_data[servant_data[var_87_13].modelid].career].suits do
					if var_87_16 then
						break
					end

					for iter_87_14 = 1, #var_87_15 do
						if var_87_16 then
							break
						end

						if var_87_4[var_87_7[model_data[servant_data[var_87_13].modelid].career].suits[iter_87_13]] and var_87_4[var_87_7[model_data[servant_data[var_87_13].modelid].career].suits[iter_87_13]][var_87_15[iter_87_14]] then
							local var_87_17 = 0
							local var_87_18 = false

							for iter_87_15, iter_87_16 in pairs(var_87_4[var_87_7[model_data[servant_data[var_87_13].modelid].career].suits[iter_87_13]][var_87_15[iter_87_14]]) do
								if not iter_87_16.value or not iter_87_16.pos then
									-- block empty
								end

								if not var_87_2[iter_87_16.entityid] and var_87_17 < iter_87_16.value and iter_87_16.pos == iter_87_12 then
									var_87_17 = iter_87_16.value
									var_87_12[var_87_13].componentList[iter_87_12] = {
										entityid = iter_87_16.entityid,
										pos = iter_87_12
									}
									var_87_18 = true
								end
							end

							if var_87_18 then
								var_87_2[var_87_12[var_87_13].componentList[iter_87_12].entityid] = true
								var_87_16 = true
							end
						end
					end
				end
			end
		end
	end

	local var_87_20 = var_87_12
	local var_87_21 = {}

	for iter_87_17, iter_87_18 in pairs(var_87_12) do
		table.insert(var_87_21, clone(iter_87_18))

		if iter_87_18.componentList then
			var_87_21[#var_87_21].componentList = {}

			for iter_87_19, iter_87_20 in pairs(iter_87_18.componentList) do
				table.insert(var_87_21[#var_87_21].componentList, iter_87_20)
			end
		end
	end

	network:rpc("servant_equip_one_key", {
		list = var_87_21
	}, function(arg_88_0)
		if arg_88_0.result == 1 then
			local var_88_0 = false

			for iter_88_0 = 1, #arg_88_0.list do
				if arg_88_0.list[iter_88_0].componentResult then
					for iter_88_1 = 1, #arg_88_0.list[iter_88_0].componentResult do
						if arg_88_0.list[iter_88_0].componentResult[iter_88_1].result == 1 then
							var_88_0 = true

							if var_87_20[arg_88_0.list[iter_88_0].servantid].componentList and var_87_20[arg_88_0.list[iter_88_0].servantid].componentList[arg_88_0.list[iter_88_0].componentResult[iter_88_1].pos] then
								playermodel.component[arg_88_0.list[iter_88_0].servantid] = playermodel.component[arg_88_0.list[iter_88_0].servantid] or {}
								playermodel.items[var_87_20[arg_88_0.list[iter_88_0].servantid].componentList[arg_88_0.list[iter_88_0].componentResult[iter_88_1].pos].entityid].component_attr.use = arg_88_0.list[iter_88_0].servantid

								item_manager:remove_bag_weight(playermodel.items[var_87_20[arg_88_0.list[iter_88_0].servantid].componentList[arg_88_0.list[iter_88_0].componentResult[iter_88_1].pos].entityid].itemid, 1)

								playermodel.component[arg_88_0.list[iter_88_0].servantid][arg_88_0.list[iter_88_0].componentResult[iter_88_1].pos] = {
									pos = arg_88_0.list[iter_88_0].componentResult[iter_88_1].pos,
									id = var_87_20[arg_88_0.list[iter_88_0].servantid].componentList[arg_88_0.list[iter_88_0].componentResult[iter_88_1].pos].entityid
								}
							end
						end
					end

					if var_88_0 then
						if playermodel:isSoulInFight(arg_88_0.list[iter_88_0].servantid) then
							FightManager.registerPlayerChangeComponent()
							cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
						end

						AlertManager:check_component_update(false)
					end
				end
			end

			arg_88_0.bChangeParts = var_88_0
		end

		if arg_87_2 then
			arg_87_2(arg_88_0)
		end
	end)
end

return var_0_0
