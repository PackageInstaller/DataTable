local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local item_manager = require("controller.item_manager")
local total_skill_data = require("data.total_skill_data")
local item_data = require("data.item_data")
local major_factor_data = require("data.major_factor_data")
local servant_data = require("data.servant_data")
local core_data = require("data.core_data")
local unique_weapon_data = require("data.unique_weapon_data")

function var_0_0.getWeaponModelid(arg_1_0, arg_1_1)
	print("getWeaponModelid is deprecated!!!!")
end

function var_0_0.getDefaultWeaponModelid(arg_2_0, arg_2_1)
	print("getDefaultWeaponModelid is deprecated!!!!")
end

function var_0_0.decode_weapon_config(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return nil
	end

	if type(arg_3_1) == "table" then
		return arg_3_1
	end

	if type(arg_3_1) ~= "string" then
		return nil
	end

	local var_3_0 = {
		exp = 0,
		nowStars = 0,
		level = 0
	}

	for iter_3_0, iter_3_1 in arg_3_1:gmatch("([^&]+)=([^&]+)") do
		var_3_0[iter_3_0] = tonumber(iter_3_1)
	end

	return var_3_0
end

function var_0_0:initWeaponInfowithItemid(arg_4_1, arg_4_2)
	local var_4_0 = {}
	local var_4_1 = self:getWeaponAddMainAttr(arg_4_1, arg_4_2.level or self:getWeaponMaxLevelByItemid(arg_4_1), {
		{
			{
				attrtype = item_data[arg_4_1].main_attr,
				value = item_data[arg_4_1].value
			}
		}
	})

	if not item_data[arg_4_1][string.format("sub%s_value%s", arg_4_2.nowStars, 1)] then
		-- block empty
	end

	local var_4_4 = {}

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			local var_4_6 = true

			for iter_4_4, iter_4_5 in pairs(var_4_4) do
				if iter_4_5.attrtype == iter_4_3.attrtype then
					var_4_4[iter_4_4].value = var_4_4[iter_4_4].value + iter_4_3.value
					var_4_6 = false
				end
			end

			if var_4_6 then
				table.insert(var_4_4, {
					attrtype = iter_4_3.attrtype,
					value = iter_4_3.value
				})
			end
		end
	end

	var_4_0.mainAttr = {}

	for iter_4_6, iter_4_7 in pairs(var_4_4) do
		local var_4_7 = ATTR_TRANS_FAC[iter_4_7.attrtype]
		local var_4_8

		if not ATTR_TRANS_FAC[iter_4_7.attrtype] then
			var_4_7 = 1
			var_4_8 = {
				key = iter_4_7.attrtype
			}
		end

		var_4_8.value = FIGHT_ATTR_INFO[iter_4_7.attrtype] .. " + " .. FIGHT_ATTR_FORMAT[iter_4_7.attrtype](iter_4_7.value * var_4_7)

		table.insert(var_4_0.mainAttr, var_4_8)
	end

	var_4_0.subAttr = {}

	for iter_4_8, iter_4_9 in pairs((self:getWeaponAddSubAttr(arg_4_1, arg_4_2.nowStars))) do
		table.insert(var_4_0.subAttr, {
			key = iter_4_9.attrtype,
			value = FIGHT_ATTR_INFO[iter_4_9.attrtype] .. " + " .. FIGHT_ATTR_FORMAT[iter_4_9.attrtype](iter_4_9.value)
		})
	end

	return var_4_0
end

function var_0_0.getMonsterWeaponConfig(arg_5_0, arg_5_1)
	local var_5_1 = {}
	local var_5_2 = require("data.monster_weapon_data")[arg_5_1.weaponid]

	if not var_5_2 then
		return
	end

	var_5_1.XP = nil
	var_5_1.passiveSkill = var_5_2.skill
	var_5_1.attr = {
		mainattr = var_5_2.main_attr,
		value = (require("data.weapon_strengthen" .. var_5_2.equip_quality .. "_data")[arg_5_1.weaponLevel].all_value + var_5_2.value) * FIGHT_ATTR_TRANS_FAC[var_5_2.main_attr]
	}

	return var_5_1
end

function var_0_0.getWeaponAddMainAttr(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = {}

	if arg_6_3 and next(arg_6_3) then
		for iter_6_0, iter_6_1 in pairs(arg_6_3) do
			table.insert(var_6_0, iter_6_1)
		end
	end

	local var_6_1 = 1

	while var_6_1 <= arg_6_2 do
		local var_6_2 = {}

		while item_data[arg_6_1]["lv" .. var_6_1 .. "_attr" .. 1] do
			table.insert(var_6_2, {
				attrtype = item_data[arg_6_1]["lv" .. var_6_1 .. "_attr" .. 1],
				value = item_data[arg_6_1]["lv" .. var_6_1 .. "_attr" .. 1 .. "_value"]
			})
		end

		table.insert(var_6_0, var_6_2)

		var_6_1 = var_6_1 + 1
	end

	return var_6_0
end

function var_0_0.getWeaponAddSubAttr(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = {}

	for iter_7_0 = arg_7_3 or 0, arg_7_2 do
		local var_7_1 = 1
		local var_7_2 = string.format("sub%s_attr%s", iter_7_0, 1)

		while item_data[arg_7_1][var_7_2] do
			local var_7_3 = item_data[arg_7_1][var_7_2]

			if var_7_0[item_data[arg_7_1][var_7_2]] then
				var_7_0[var_7_3] = var_7_0[var_7_3] + item_data[arg_7_1][var_7_2 .. "_value"] or item_data[arg_7_1][var_7_2 .. "_value"]
			end

			var_7_1 = var_7_1 + 1
			var_7_2 = string.format("sub%s_attr%s", iter_7_0, var_7_1)
		end
	end

	local var_7_4 = {}

	for iter_7_1, iter_7_2 in pairs(var_7_0) do
		local var_7_6 = {
			attrtype = iter_7_1
		}

		var_7_6.value = iter_7_2 * (ATTR_TRANS_FAC[iter_7_1] or 1)

		table.insert(var_7_4, var_7_6)
	end

	return var_7_4
end

function var_0_0:getWeaponConfig(arg_8_1, arg_8_2, arg_8_3)
	local var_8_1 = {}

	if not arg_8_1 then
		return {}
	end

	local var_8_2 = item_data[arg_8_1.itemid]

	arg_8_2 = arg_8_2 or var_8_2.servant and (playermodel.skill1Level[var_8_2.servant] or 0) or 0

	if not arg_8_3 then
		if arg_8_1.weapon_attr.use then
			if playermodel.haveServant[arg_8_1.weapon_attr.use] then
				arg_8_3 = require("controller.core_manager"):getServantCoreRank(arg_8_1.weapon_attr.use)
			end
		else
			arg_8_3 = 10
		end
	end

	var_8_1.XP = nil
	var_8_1.passiveSkill = var_8_2.skill
	var_8_1.skill1 = var_8_2["skill1" .. "_" .. arg_8_2]
	var_8_1.behavior = var_8_2.behavior
	var_8_1.spinecfg = var_8_2.spinecfg

	assert(var_8_2.value, "weapn no value is " .. arg_8_1.itemid)

	var_8_1.main_attr = self:getWeaponAddMainAttr(arg_8_1.itemid, arg_8_1.weapon_attr.level < arg_8_1.weapon_attr.level and arg_8_1.weapon_attr.level or arg_8_1.weapon_attr.level)

	local var_8_3 = {
		attrtype = var_8_2.main_attr
	}

	var_8_3.value = var_8_2.value * (ATTR_TRANS_FAC[var_8_2.main_attr] or 1)
	var_8_1.base_attr = var_8_3
	var_8_1.sub_attr = self:getWeaponAddSubAttr(arg_8_1.itemid, arg_8_1.weapon_attr.nowStars)

	return var_8_1
end

function var_0_0.getWeponCurMaxLevel(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return WEAPON_SERVANT_LIMIT[0].limit
	end

	return WEAPON_SERVANT_LIMIT[arg_9_1].limit
end

function var_0_0.isServantPatrolUse(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in pairs(playermodel.weaponId) do
		if iter_10_1 == arg_10_1 then
			return require("controller.array_manager"):isServantPatrolNow(iter_10_0)
		end
	end

	return false
end

function var_0_0.replaceRoleWeapon(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 and not playermodel.items[arg_11_2] then
		if arg_11_3 then
			arg_11_3(2)
		end

		return
	end

	if not playermodel.haveServant[arg_11_1] then
		if arg_11_3 then
			arg_11_3(3)
		end

		return
	end

	network:rpc("replace_role_weapon", {
		servantid = arg_11_1,
		entityid = arg_11_2
	}, function(arg_12_0)
		if arg_12_0.result == 1 then
			local var_12_0

			if playermodel.weaponId[arg_11_1] then
				var_12_0 = playermodel.weaponId[arg_11_1]
				playermodel.items[playermodel.weaponId[arg_11_1]].weapon_attr.use = nil
			end

			local var_12_1

			if arg_11_2 then
				if playermodel.items[arg_11_2].weapon_attr.use then
					var_12_1 = playermodel.items[arg_11_2].weapon_attr.use
					playermodel.weaponId[playermodel.items[arg_11_2].weapon_attr.use] = nil
				end

				playermodel.items[arg_11_2].weapon_attr.use = arg_11_1
			end

			playermodel.weaponId[arg_11_1] = arg_11_2

			if playermodel:isSoulInFight(arg_11_1) or playermodel:isSoulInFight(var_12_1) then
				FightManager.registerPlayerChangeWeaponSkill()
				cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))
			end

			require("controller.alert_manager"):check_weapon_update(var_12_0 ~= nil)
			AnalyticManager.replace_role_weapon({
				servantid = arg_11_1
			})
			sendNotification("ReplaceRoleWeaponSucceeded", {
				servantId = arg_11_1
			})
		elseif arg_12_0.result == 2 then
			cclog("武器不存在")
		elseif arg_12_0.result == 3 then
			cclog("魂姬未解锁")
		elseif arg_12_0.result == 4 then
			cclog("魂姬与武器不匹配")
		elseif arg_12_0.result == 5 then
			global_ShowBlockWords(L_WEAPON_CANNOT_Unload)
		end

		if arg_11_3 then
			arg_11_3(arg_12_0.result)
		end
	end)
end

function var_0_0.getResetLevelReturnedItems(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if playermodel.weaponId[arg_13_1] then
		local var_13_1 = 0
		local var_13_2 = {}

		for iter_13_0 = 1, playermodel.items[playermodel.weaponId[arg_13_1]].weapon_attr.level do
			var_13_1 = var_13_1 + item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_cost"] or 0

			if item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_material1"] then
				while item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_material" .. 1] do
					var_13_2[item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_material" .. 1]] = var_13_2[item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_material" .. 1]] or {
						itemNum = 0,
						itemid = item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_material" .. 1],
						itemName = item_data[item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_material" .. 1]].name
					}
					var_13_2[item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_material" .. 1]].itemNum = var_13_2[item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_material" .. 1]].itemNum + item_data[playermodel.items[playermodel.weaponId[arg_13_1]].itemid]["lv" .. iter_13_0 .. "_material" .. 1 .. "_num"]
				end
			end
		end

		var_13_0.costgold = var_13_1
		var_13_0.costItems = var_13_2
	end

	return var_13_0
end

function var_0_0:strengthenWeapon(arg_14_1, arg_14_2, arg_14_3)
	if not playermodel.items[arg_14_1] then
		return
	end

	local var_14_0 = playermodel.items[arg_14_1]
	local var_14_2 = playermodel.items[arg_14_1].weapon_attr.level

	if playermodel.items[arg_14_1].weapon_attr.level >= self:getWeaponMaxLevel(arg_14_1) then
		if arg_14_3 then
			arg_14_3(5)
		end

		return
	end

	if (item_data[var_14_0.itemid]["lv" .. playermodel.items[arg_14_1].weapon_attr.level + 1 .. "_cost"] or 100) > playermodel.gold then
		if arg_14_3 then
			arg_14_3(4)
		end

		return
	end

	if playermodel.items[arg_14_1].weapon_attr.level >= self:getWeponCurMaxLevel((require("controller.core_manager"):getServantCoreRank(item_data[var_14_0.itemid].servant))) then
		if arg_14_3 then
			arg_14_3(7)
		end

		return
	end

	local var_14_3 = var_14_0.weapon_attr.level

	network:rpc("strengthen_weapon", {
		entityid = arg_14_1
	}, function(arg_15_0)
		if arg_15_0.result == 1 then
			playermodel.items[arg_14_1].weapon_attr.level = arg_15_0.level
			playermodel.gold = playermodel.gold - arg_15_0.costgold

			global_update_gold_stone_diamond(playermodel.gold, nil, nil)

			if arg_15_0.level > var_14_3 then
				for iter_15_0, iter_15_1 in pairs(playermodel.curSoul) do
					if iter_15_1.classtype == 1 and arg_14_1 == playermodel.weaponId[iter_15_1.fight_girl] then
						FightManager.registerPlayerChangeWeaponSkill()
						cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))

						break
					end
				end
			end

			if item_data[var_14_0.itemid]["lv" .. var_14_2 + 1 .. "_material1"] then
				while item_data[var_14_0.itemid]["lv" .. var_14_2 + 1 .. "_material" .. 1] do
					item_manager:deleteItem(item_data[var_14_0.itemid]["lv" .. var_14_2 + 1 .. "_material" .. 1], item_data[var_14_0.itemid]["lv" .. var_14_2 + 1 .. "_material" .. 1 .. "_num"])
				end
			end

			require("controller.alert_manager"):check_weapon_update()
			AnalyticManager.strengthen_weapon({
				weaponid = playermodel.items[arg_14_1].itemid,
				level = arg_15_0.level
			})
			sendNotification("StrengthenWeaponSucceeded", {
				weaponId = arg_14_1,
				level = arg_15_0.level
			})
		elseif arg_15_0.result == 2 then
			cclog("需要先突破~")
		elseif arg_15_0.result == 3 then
			cclog("材料不足")
		elseif arg_15_0.result == 4 then
			cclog(L_GOLD_LACK)
		elseif arg_15_0.result == 5 then
			cclog("已满级")
		elseif arg_15_0.result == 6 then
			cclog("消耗物品与武器类别不匹配")
		end

		print("msg.result==", arg_15_0.result)

		if arg_14_3 then
			arg_14_3(arg_15_0.result)
		end
	end)
end

function var_0_0.batchStrengthenWeapons(arg_16_0, arg_16_1, arg_16_2)
	network:rpc("batch_strength_weapons", {
		target_info = arg_16_1
	}, function(arg_17_0)
		if arg_17_0.result == 1 then
			local var_17_0 = {}

			for iter_17_0, iter_17_1 in pairs(arg_16_1) do
				playermodel.items[iter_17_1.entityid].weapon_attr.level = iter_17_1.target_lv
				var_17_0[iter_17_1.entityid] = true
			end

			if arg_17_0.costgold then
				playermodel.gold = playermodel.gold - arg_17_0.costgold

				global_update_gold_stone_diamond(playermodel.gold, nil, nil)
			end

			if arg_17_0.costitems then
				for iter_17_2, iter_17_3 in pairs(arg_17_0.costitems) do
					item_manager:deleteItem(iter_17_3.itemid, iter_17_3.num)
				end
			end

			for iter_17_4, iter_17_5 in pairs(playermodel.curSoul) do
				if iter_17_5.classtype == 1 and var_17_0[playermodel.weaponId[iter_17_5.fight_girl]] then
					FightManager.registerPlayerChangeWeaponSkill()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))

					break
				end
			end

			AnalyticManager.strengthWeaponSuccess(arg_17_0.costgold)
		elseif arg_17_0.result == 2 then
			cclog("有不存在的物品")
		elseif arg_17_0.result == 3 then
			cclog("目标强化等级不存在")
		elseif arg_17_0.result == 4 then
			cclog("目标强化等级小于当前等级")
		elseif arg_17_0.result == 5 then
			cclog(L_GOLD_LACK)
		elseif arg_17_0.result == 6 then
			cclog("消耗物品不足")
		end

		if arg_16_2 then
			arg_16_2(arg_17_0.result)
		end
	end)
end

function var_0_0.UpgradeWeapon(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	print(dump(arg_18_2))

	if not playermodel.items[arg_18_1] then
		return
	end

	local var_18_0 = playermodel.items[arg_18_1]

	for iter_18_0, iter_18_1 in pairs(arg_18_2) do
		if var_18_0.itemid ~= playermodel.items[iter_18_1].itemid then
			if arg_18_3 then
				arg_18_3(3)
			end

			return
		end
	end

	local var_18_2 = #arg_18_2
	local var_18_3 = item_data[playermodel.items[arg_18_1].itemid]["upgrade_need_num" .. var_18_0.weapon_attr.nowStars + 1]

	if item_data[playermodel.items[arg_18_1].itemid]["upgrade_need_num" .. var_18_0.weapon_attr.nowStars + 1] and item_data[playermodel.items[arg_18_1].itemid]["upgrade_need_num" .. var_18_0.weapon_attr.nowStars + 1] > #arg_18_2 + item_manager:getItemNumber(ALMIGHTY_WEAPON) then
		global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[6])

		if arg_18_3 then
			arg_18_3(6)
		end

		return
	end

	if var_18_0.weapon_attr.nowStars == TOTAL_WEAPON_MAXSTARS then
		if arg_18_3 then
			arg_18_3(5)
		end

		return
	end

	network:rpc("upgrade_weapon", {
		entityid = arg_18_1,
		cost_entityids = arg_18_2
	}, function(arg_19_0)
		if arg_19_0.result == 1 then
			playermodel.items[arg_18_1].weapon_attr.nowStars = arg_19_0.nowStars

			for iter_19_0, iter_19_1 in pairs(arg_18_2) do
				item_manager:deleteItem(iter_19_1)
			end

			if var_18_3 > var_18_2 then
				item_manager:deleteItem(ALMIGHTY_WEAPON, var_18_3 - var_18_2)
			end

			for iter_19_2, iter_19_3 in pairs(playermodel.curSoul) do
				if iter_19_3.classtype == 1 and arg_18_1 == playermodel.weaponId[iter_19_3.fight_girl] then
					FightManager.registerPlayerChangeWeaponSkill()
					cc.Director:getInstance():getEventDispatcher():dispatchEvent(cc.EventCustom:new("syncFightPower"))

					break
				end
			end

			if arg_19_0.items then
				local var_19_0 = {}

				for iter_19_4, iter_19_5 in pairs(arg_19_0.items) do
					table.insert(var_19_0, {
						dropid = iter_19_5.itemid,
						entityid = iter_19_5.entityid,
						dropNum = item_manager:setItemByServerItem(iter_19_5)
					})
					LayerManager:pushInLayer("PopPurchaseResultLayer", {
						items = var_19_0
					})
				end
			end

			require("controller.alert_manager"):check_weapon_update(false)
			AnalyticManager.upgrade_weapon({
				weaponid = playermodel.items[arg_18_1].itemid,
				now_stars = arg_19_0.nowStars,
				level = playermodel.items[arg_18_1].weapon_attr.level,
				use_almight_num = math.max(0, var_18_3 - var_18_2)
			})
			sendNotification("UpgradeWeaponSucceeded", {
				entityId = arg_18_1
			})
		elseif arg_19_0.result == 2 then
			cclog("升星物品不存在")
		elseif arg_19_0.result == 3 then
			cclog("升星物品不匹配")
		elseif arg_19_0.result == 4 then
			cclog("不因该会有返回值为4的情况了啊~")
		elseif arg_19_0.result == 5 then
			cclog("已满星")
		elseif arg_19_0.result == 6 then
			global_ShowBlockWords(L_WEAPON_UPGRADE_FAIL[6])
		end

		if arg_18_3 then
			arg_18_3(arg_19_0.result)
		end
	end)
end

function var_0_0.BreadownkWeapon(arg_20_0, arg_20_1, arg_20_2)
	network:rpc("break_down_weapon", {
		items = arg_20_1
	}, function(arg_21_0)
		if arg_21_0.result == 1 then
			for iter_21_0, iter_21_1 in pairs(arg_20_1) do
				item_manager:deleteItem(iter_21_1)
			end

			for iter_21_2, iter_21_3 in pairs(arg_21_0.dropitems) do
				iter_21_3.dropNum = item_manager:setItemByServerItem(iter_21_3)
			end

			if arg_21_0.gold then
				local var_21_0 = checkint(arg_21_0.gold)

				arg_21_0.add_gold = var_21_0 - playermodel.gold
				playermodel.gold = var_21_0
			end

			require("controller.alert_manager"):check_weapon_update(false)
			AnalyticManager.sellItemInBag(arg_21_0.add_gold)
		end

		if arg_20_2 then
			arg_20_2(arg_21_0)
		end
	end)
end

function var_0_0.isNeedBreakthrough(arg_22_0, arg_22_1)
	return false
end

function var_0_0.filterSortWeapons(arg_23_0, arg_23_1)
	local var_23_0
	local var_23_1
	local var_23_2
	local var_23_3
	local var_23_4

	if arg_23_1.major and next(arg_23_1.major) ~= nil then
		var_23_2 = {}

		for iter_23_0, iter_23_1 in pairs(arg_23_1.major) do
			var_23_2[iter_23_1] = true
		end
	end

	if arg_23_1.maxStars and next(arg_23_1.maxStars) ~= nil then
		var_23_0 = {}

		for iter_23_2, iter_23_3 in pairs(arg_23_1.maxStars) do
			var_23_0[iter_23_3] = true
		end
	end

	if arg_23_1.nowStars and next(arg_23_1.nowStars) ~= nil then
		var_23_1 = {}

		for iter_23_4, iter_23_5 in pairs(arg_23_1.nowStars) do
			var_23_1[iter_23_5] = true
		end
	end

	local var_23_5 = {
		two = 2,
		five = 5,
		three = 3,
		one = 1,
		four = 4,
		six = 6
	}

	if arg_23_1.quality and next(arg_23_1.quality) ~= nil then
		var_23_3 = {}

		for iter_23_6, iter_23_7 in pairs(arg_23_1.quality) do
			var_23_3[var_23_5[iter_23_7]] = true
		end
	end

	if arg_23_1.selected and next(arg_23_1.selected) ~= nil then
		var_23_4 = {}

		for iter_23_8, iter_23_9 in pairs(arg_23_1.selected) do
			var_23_4[iter_23_9] = true
		end
	end

	local var_23_6 = {}

	for iter_23_10, iter_23_11 in pairs(playermodel.items) do
		if item_data[iter_23_11.itemid].bag_item_type == kITEM_WEAPON and (not arg_23_1.itemid or arg_23_1.itemid == iter_23_11.itemid) and (not item_data[iter_23_11.itemid].servant or not arg_23_1.servantid or arg_23_1.servantid and arg_23_1.servantid == item_data[iter_23_11.itemid].servant) and (not iter_23_11.weapon_attr.use or arg_23_1.isFilterUsed) and (not iter_23_11.weapon_attr.lock or arg_23_1.isFilterLocked) and (not var_23_2 or var_23_2[item_data[iter_23_11.itemid].major] or not item_data[iter_23_11.itemid].major) then
			if var_23_0 then
				if var_23_0[iter_23_11.weapon_attr.maxStars or TOTAL_WEAPON_MAXSTARS] then
					if (not var_23_1 or var_23_1[iter_23_11.weapon_attr.nowStars]) and (not var_23_4 or not var_23_4[iter_23_11.entityid]) and (not var_23_3 or var_23_3[item_data[iter_23_11.itemid].equip_quality]) then
						if arg_23_1.removed then
							if arg_23_1.removed ~= iter_23_11.entityid then
								local var_23_9 = {
									entityid = iter_23_10,
									quality = item_data[iter_23_11.itemid].equip_quality,
									nowStars = iter_23_11.weapon_attr.nowStars
								}

								var_23_9.maxStars = iter_23_11.weapon_attr.maxStars or TOTAL_WEAPON_MAXSTARS
								var_23_9.level = iter_23_11.weapon_attr.level
								var_23_9.major = item_data[iter_23_11.itemid].major

								table.insert(var_23_6, var_23_9)
							end
						end
					end
				end
			end
		end
	end

	local var_23_10 = {
		{
			str = "quality",
			weight = 4
		},
		{
			str = "level",
			weight = 3
		},
		{
			str = "maxStars",
			weight = 2
		},
		{
			str = "nowStars",
			weight = 1
		},
		{
			str = "major",
			weight = 10
		}
	}

	if arg_23_1.sortType then
		for iter_23_12, iter_23_13 in pairs(var_23_10) do
			if iter_23_13.str == arg_23_1.sortType then
				iter_23_13.weight = iter_23_13.weight + 5
			end
		end

		table.sort(var_23_10, function(arg_24_0, arg_24_1)
			return arg_24_0.weight > arg_24_1.weight
		end)
	end

	if arg_23_1.orderType == 0 then
		table.sort(var_23_6, function(arg_25_0, arg_25_1)
			while 1 <= #var_23_10 do
				if 1 == #var_23_10 then
					return arg_25_0[var_23_10[1].str] < arg_25_1[var_23_10[1].str]
				elseif arg_25_0[var_23_10[1].str] ~= arg_25_1[var_23_10[1].str] then
					if var_23_10[1].str == "major" then
						return (arg_25_0[var_23_10[1].str] or 0) < (arg_25_1[var_23_10[1].str] or 1)
					else
						return (arg_25_0[var_23_10[1].str] or 0) < (arg_25_1[var_23_10[1].str] or -1)
					end
				end
			end
		end)
	elseif arg_23_1.orderType == 1 then
		table.sort(var_23_6, function(arg_26_0, arg_26_1)
			while 1 <= #var_23_10 do
				if 1 == #var_23_10 then
					return arg_26_0[var_23_10[1].str] > arg_26_1[var_23_10[1].str]
				elseif arg_26_0[var_23_10[1].str] ~= arg_26_1[var_23_10[1].str] then
					if var_23_10[1].str == "major" then
						return (arg_26_0[var_23_10[1].str] or 0) < (arg_26_1[var_23_10[1].str] or 1)
					else
						return (arg_26_1[var_23_10[1].str] or -1) < (arg_26_0[var_23_10[1].str] or 0)
					end
				end
			end
		end)
	end

	local var_23_11 = {}

	for iter_23_14, iter_23_15 in ipairs(var_23_6) do
		var_23_11[iter_23_14] = iter_23_15.entityid
	end

	return var_23_11
end

function var_0_0.lockWeapon(arg_27_0, arg_27_1, arg_27_2)
	network:rpc("lock_item", {
		locktype = playermodel.items[arg_27_1].weapon_attr.lock and 1 or 2,
		entityid = arg_27_1
	}, function(arg_28_0)
		if arg_28_0.result == 1 then
			playermodel.items[arg_27_1].weapon_attr.lock = arg_28_0.lock

			if arg_27_2 then
				arg_27_2(arg_28_0.lock)
			end
		else
			l2Log("lock fail")
		end
	end)
end

function var_0_0.getWeaponEasyInfowithEntityid(arg_29_0, arg_29_1)
	return var_0_0:getWeaponInfowithEntityid(arg_29_1, nil, true)
end

function var_0_0:getWeaponInfowithEntityid(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0 = playermodel.items[arg_30_1]
	local var_30_2 = self:getWeaponConfig(playermodel.items[arg_30_1])
	local var_30_3 = {}
	local var_30_4 = require("controller.core_manager"):getServantCoreRank(arg_30_2)
	local var_30_5 = playermodel.items[arg_30_1].weapon_attr.level < playermodel.items[arg_30_1].weapon_attr.level and playermodel.items[arg_30_1].weapon_attr.level or var_30_0.weapon_attr.level
	local var_30_6 = {
		{
			{
				attrtype = item_data[playermodel.items[arg_30_1].itemid].main_attr,
				value = item_data[playermodel.items[arg_30_1].itemid].value
			}
		},
		{
			{
				value = 0,
				attrtype = item_data[playermodel.items[arg_30_1].itemid].lv1_attr1
			}
		}
	}
	local var_30_10

	if item_data[playermodel.items[arg_30_1].itemid]["lv" .. var_30_5 + 1 .. "_attr1"] then
		local var_30_7 = {}
		local var_30_8 = 1

		while item_data[var_30_0.itemid]["lv" .. var_30_5 + 1 .. "_attr" .. var_30_8] do
			table.insert(var_30_7, {
				value = 0,
				attrtype = item_data[var_30_0.itemid]["lv" .. var_30_5 + 1 .. "_attr" .. var_30_8]
			})

			var_30_8 = var_30_8 + 1
		end

		table.insert(var_30_6, var_30_7)

		var_30_10 = {}
	end

	for iter_30_0, iter_30_1 in pairs((self:getWeaponAddMainAttr(var_30_0.itemid, var_30_5, var_30_6))) do
		for iter_30_2, iter_30_3 in pairs(iter_30_1) do
			local var_30_11 = true

			for iter_30_4, iter_30_5 in pairs(var_30_10) do
				if iter_30_5.attrtype == iter_30_3.attrtype then
					var_30_10[iter_30_4].value = var_30_10[iter_30_4].value + iter_30_3.value
					var_30_11 = false
				end
			end

			if var_30_11 then
				table.insert(var_30_10, {
					attrtype = iter_30_3.attrtype,
					value = iter_30_3.value
				})
			end
		end
	end

	var_30_3.mainAttr = {}

	for iter_30_6, iter_30_7 in pairs(var_30_10) do
		local var_30_12 = ATTR_TRANS_FAC[iter_30_7.attrtype]
		local var_30_13

		if not ATTR_TRANS_FAC[iter_30_7.attrtype] then
			var_30_12 = 1
			var_30_13 = {
				key = iter_30_7.attrtype
			}
		end

		var_30_13.value = FIGHT_ATTR_INFO[iter_30_7.attrtype] .. " + " .. FIGHT_ATTR_FORMAT(iter_30_7.attrtype, iter_30_7.value * var_30_12)

		table.insert(var_30_3.mainAttr, var_30_13)
	end

	var_30_3.subAttr = {
		key = var_30_2.sub_attr.attrtype,
		value = FIGHT_ATTR_INFO[var_30_2.sub_attr.attrtype] .. " + " .. FIGHT_ATTR_FORMAT(var_30_2.sub_attr.attrtype, var_30_2.sub_attr.value)
	}

	return var_30_3
end

function var_0_0.decode_component_config(arg_31_0, arg_31_1)
	if not arg_31_1 then
		return nil
	end

	if type(arg_31_1) == "table" then
		return {
			maxStars = arg_31_1.maxStars,
			nowStars = arg_31_1.nowStars
		}
	end

	if type(arg_31_1) ~= "string" then
		return nil
	end

	local var_31_0 = {}

	for iter_31_0, iter_31_1 in arg_31_1:gmatch("([^&]+)=([^&]+)") do
		if iter_31_0 == "maxStars" or iter_31_0 == "nowStars" then
			var_31_0[iter_31_0] = tonumber(iter_31_1)
		end
	end

	return var_31_0
end

function var_0_0:getNextLevelAttrValue(arg_32_1)
	local var_32_1 = self:getWeaponAddMainAttr(playermodel.items[arg_32_1].itemid, self:getWeaponMaxLevel(arg_32_1))

	if playermodel.items[arg_32_1].weapon_attr.level >= self:getWeaponMaxLevel(arg_32_1) then
		return
	end

	local var_32_2 = var_32_1[playermodel.items[arg_32_1].weapon_attr.level + 1][1].attrtype
	local var_32_3 = 0

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		if playermodel.items[arg_32_1].weapon_attr.level < iter_32_0 then
			break
		end

		for iter_32_2, iter_32_3 in pairs(iter_32_1) do
			if iter_32_3.attrtype == var_32_2 then
				var_32_3 = var_32_3 + iter_32_3.value
			end
		end
	end

	return var_32_2, (FIGHT_ATTR_FORMAT[var_32_2]((var_32_3 + var_32_1[playermodel.items[arg_32_1].weapon_attr.level + 1][1].value) * (ATTR_TRANS_FAC[var_32_2] or 1)))
end

function var_0_0:getNextStarAttrValue(arg_33_1)
	if playermodel.items[arg_33_1].weapon_attr.nowStars >= item_data[playermodel.items[arg_33_1].itemid].max_star then
		return
	end

	return self:getWeaponAddSubAttr(playermodel.items[arg_33_1].itemid, playermodel.items[arg_33_1].weapon_attr.nowStars + 1, playermodel.items[arg_33_1].weapon_attr.nowStars)
end

function var_0_0.checkIsCanUpgrade(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return false
	end

	local var_34_0 = playermodel.items[arg_34_1]
	local var_34_1

	if playermodel.items[arg_34_1].weapon_attr.nowStars >= item_data[playermodel.items[arg_34_1].itemid].max_star then
		do return false end

		var_34_1 = {}
	end

	for iter_34_0, iter_34_1 in pairs((item_manager:getItemByItemId(var_34_0.itemid))) do
		if iter_34_1 ~= arg_34_1 and playermodel.items[iter_34_1].weapon_attr.nowStars == 0 and not playermodel.items[iter_34_1].weapon_attr.use and not playermodel.items[iter_34_1].weapon_attr.used then
			table.insert(var_34_1, iter_34_1)
		end
	end

	local var_34_2 = item_data[playermodel.items[arg_34_1].itemid]["upgrade_need_num" .. var_34_0.weapon_attr.nowStars + 1] or 1

	if item_data[playermodel.items[arg_34_1].itemid].max_star >= 5 then
		return var_34_2 <= #var_34_1 + item_manager:getItemNumber(ALMIGHTY_WEAPON)
	end

	return var_34_2 <= #var_34_1
end

function var_0_0.checkIsCanReplaceBetter(arg_35_0, arg_35_1)
	local var_35_0 = {
		isFilterLocked = true,
		sortType = "quality",
		orderType = 1,
		maxStars = {},
		nowStars = {},
		quality = {},
		servantid = arg_35_1
	}
	local var_35_1

	if playermodel.items[playermodel.weaponId[arg_35_1]] then
		var_35_1 = item_data[playermodel.items[playermodel.weaponId[arg_35_1]].itemid].equip_quality or 0

		if var_35_1 >= 6 then
			return false
		end
	end

	local var_35_2 = {
		"one",
		"two",
		"three",
		"four",
		"five",
		"six"
	}

	for iter_35_0 = var_35_1 + 1, 6 do
		table.insert(var_35_0.quality, var_35_2[iter_35_0])
	end

	local var_35_3 = item_manager:filterSortItems(20, var_35_0)

	return var_35_3 ~= nil and var_35_3[1] ~= nil
end

function var_0_0:isTipsStrengWeapon(arg_36_1)
	if not playermodel.weaponId[arg_36_1] then
		return false
	end

	if var_0_0:checkIsCanReplaceBetter(arg_36_1) then
		return false
	end

	local var_36_0 = playermodel.items[playermodel.weaponId[arg_36_1]]

	if (item_data[playermodel.items[playermodel.weaponId[arg_36_1]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_36_1]].weapon_attr.level + 1 .. "_cost"] or 100) > playermodel.gold then
		return false
	end

	if playermodel.items[playermodel.weaponId[arg_36_1]].weapon_attr.level >= self:getWeaponMaxLevel(playermodel.weaponId[arg_36_1]) then
		return false
	end

	if playermodel.items[playermodel.weaponId[arg_36_1]].weapon_attr.level >= self:getWeponCurMaxLevel((require("controller.core_manager"):getServantCoreRank(arg_36_1))) then
		return false
	end

	if item_data[var_36_0.itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_36_1]].weapon_attr.level + 1 .. "_material1"] then
		while item_data[var_36_0.itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_36_1]].weapon_attr.level + 1 .. "_material" .. 1] do
			if item_data[var_36_0.itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_36_1]].weapon_attr.level + 1 .. "_material" .. 1 .. "_num"] > item_manager:getItemNumber(item_data[var_36_0.itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_36_1]].weapon_attr.level + 1 .. "_material" .. 1]) then
				return false
			end
		end
	end

	return true
end

function var_0_0.getWeaponMaxLevel(arg_37_0, arg_37_1)
	local var_37_0 = 0

	while item_data[playermodel.items[arg_37_1].itemid]["lv" .. var_37_0 + 1 .. "_cost"] do
		var_37_0 = var_37_0 + 1
	end

	return var_37_0
end

function var_0_0.getWeaponMaxLevelByItemid(arg_38_0, arg_38_1)
	local var_38_0 = 0

	while item_data[arg_38_1]["lv" .. var_38_0 + 1 .. "_cost"] do
		var_38_0 = var_38_0 + 1
	end

	return var_38_0
end

function var_0_0.createMaxWeaponData(arg_39_0, arg_39_1)
	local var_39_0 = servant_data[arg_39_1].recommend_weapon2

	return {
		exp = 1,
		itemid = servant_data[arg_39_1].recommend_weapon2,
		maxStars = TOTAL_WEAPON_MAXSTARS,
		nowStars = TOTAL_WEAPON_MAXSTARS,
		level = (function()
			local var_40_0 = 0

			while item_data[var_39_0]["lv" .. var_40_0 + 1 .. "_cost"] do
				var_40_0 = var_40_0 + 1
			end

			return var_40_0
		end)()
	}
end

function var_0_0:createMaxFightWeaponData(arg_41_1)
	local var_41_0 = self:createMaxWeaponData(arg_41_1)

	return {
		itemid = var_41_0.itemid,
		weapon_attr = {
			exp = var_41_0.exp,
			level = var_41_0.level,
			nowStars = var_41_0.nowStars
		}
	}
end

function var_0_0.getWeaponUpToLevelCost(arg_42_0, arg_42_1, arg_42_2)
	return
end

function var_0_0.getWeaponUpGradeMaterialList(arg_43_0, arg_43_1)
	return
end

function var_0_0.up_weapon_quality(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	return
end

function var_0_0.nextQualityWeaponIsUnique(arg_45_0, arg_45_1)
	return
end

function var_0_0.getNextQualityWeaponId(arg_46_0, arg_46_1)
	return
end

function var_0_0.getNextQualityUniqueWeapons(arg_47_0, arg_47_1)
	return
end

function var_0_0.getUpWeaponQualityMaterial(arg_48_0, arg_48_1)
	return
end

function var_0_0.isTipsUpWeaponQuality(arg_49_0, arg_49_1)
	return false
end

function var_0_0.checkUpWeaponQuality(arg_50_0, arg_50_1, arg_50_2)
	return
end

function var_0_0:isMaxLevelByServantid(arg_51_1)
	return (playermodel.weaponId[arg_51_1] or nil) and playermodel.items[playermodel.weaponId[arg_51_1]].weapon_attr.level >= self:getWeponCurMaxLevel((require("controller.core_manager"):getServantCoreRank(arg_51_1)))
end

function var_0_0.isActiveWeaponByServantid(arg_52_0, arg_52_1)
	return not not (playermodel.weaponId[arg_52_1] and playermodel.items[playermodel.weaponId[arg_52_1]])
end

function var_0_0:isLargeMaxLevelByServantid(arg_53_1)
	local var_53_0 = false

	if playermodel.weaponId[arg_53_1] then
		local core_manager = require("controller.core_manager")

		var_53_0 = playermodel.items[playermodel.weaponId[arg_53_1]].weapon_attr.level >= self:getWeponCurMaxLevel(100)
	end

	return var_53_0
end

function var_0_0:canFastStrengthen(arg_54_1)
	if not playermodel.items[playermodel.weaponId[arg_54_1]] then
		if self:checkIsCanReplaceBetter(arg_54_1) then
			return true
		else
			return false
		end
	elseif playermodel.items[playermodel.weaponId[arg_54_1]].weapon_attr.level < self:getWeponCurMaxLevel((require("controller.core_manager"):getServantCoreRank(arg_54_1))) then
		if (item_data[playermodel.items[playermodel.weaponId[arg_54_1]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_54_1]].weapon_attr.level + 1 .. "_cost"] or 0) > playermodel.gold then
			return false
		end

		local var_54_2 = 1

		while item_data[playermodel.items[playermodel.weaponId[arg_54_1]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_54_1]].weapon_attr.level + 1 .. "_material" .. var_54_2] do
			if item_data[playermodel.items[playermodel.weaponId[arg_54_1]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_54_1]].weapon_attr.level + 1 .. "_material" .. var_54_2 .. "_num"] > item_manager:getItemNumber(item_data[playermodel.items[playermodel.weaponId[arg_54_1]].itemid]["lv" .. playermodel.items[playermodel.weaponId[arg_54_1]].weapon_attr.level + 1 .. "_material" .. var_54_2]) then
				return false
			end

			var_54_2 = var_54_2 + 1
		end

		return true
	else
		return false
	end
end

function var_0_0:getLargeMaxWeaponLevel()
	return (self:getWeponCurMaxLevel(100))
end

function var_0_0:getFastStrengthenInfo(arg_56_1, arg_56_2)
	arg_56_2 = arg_56_2 or {}

	local core_manager = require("controller.core_manager")

	if playermodel.items[playermodel.weaponId[arg_56_1]] then
		local var_56_1 = playermodel.items[playermodel.weaponId[arg_56_1]].itemid
		local var_56_2 = core_manager:getServantCoreRank(arg_56_1)
		local var_56_3 = core_manager:getServantCoreRank(arg_56_1)
		local var_56_4 = playermodel.items[playermodel.weaponId[arg_56_1]].weapon_attr.level
		local var_56_5 = self:getWeponCurMaxLevel(var_56_3)
		local var_56_6 = self:getLargeMaxWeaponLevel()
		local var_56_7 = playermodel.items[playermodel.weaponId[arg_56_1]].weapon_attr.level + 1
		local var_56_8 = arg_56_2.ownMaterial or {}
		local var_56_9 = arg_56_2.ownGold or playermodel.gold
		local var_56_10 = {
			costGold = 0,
			material = {}
		}
		local var_56_11 = {
			costGold = 0,
			material = {}
		}

		local function var_56_13()
			for iter_57_0, iter_57_1 in pairs((core_manager:getBreakOutCostMaterial(arg_56_1, var_56_3 + 1))) do
				var_56_8[iter_57_1.itemid] = var_56_8[iter_57_1.itemid] or {
					num = item_manager:getItemNumber(iter_57_1.itemid)
				}

				if iter_57_1.num > var_56_8[iter_57_1.itemid].num then
					return false
				end
			end

			if core_manager:getBreakOutCostGold(arg_56_1, var_56_3 + 1) > var_56_9 then
				return false
			end

			return true
		end

		local function var_56_14()
			while item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1] do
				var_56_8[item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1]] = var_56_8[item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1]] or {
					num = item_manager:getItemNumber(item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1])
				}

				if item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1 .. "_num"] > var_56_8[item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1]].num then
					return false
				end
			end

			if (item_data[var_56_1]["lv" .. var_56_7 .. "_cost"] or 0) > var_56_9 then
				return false
			end

			return true
		end

		while (function()
			if var_56_7 < var_56_5 then
				return true
			elseif var_56_5 == var_56_6 then
				return false
			else
				return true
			end
		end)() do
			if var_56_7 < var_56_5 then
				if var_56_14() then
					local var_56_15 = item_data[var_56_1]["lv" .. var_56_7 .. "_cost"] or 0

					var_56_9 = var_56_9 - var_56_15
					var_56_10.costGold = var_56_10.costGold + var_56_15

					while item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1] do
						var_56_8[item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1]].num = var_56_8[item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1]].num - item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1 .. "_num"]
						var_56_10.material[item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1]] = var_56_10.material[item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1]] or {
							num = 0
						}
						var_56_10.material[item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1]].num = var_56_10.material[item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1]].num + item_data[var_56_1]["lv" .. var_56_7 .. "_material" .. 1 .. "_num"]
					end

					var_56_7 = var_56_7 + 1
				else
					break
				end
			elseif var_56_5 == var_56_6 then
				break
			elseif var_56_13() then
				var_56_11.costGold = var_56_11.costGold + core_manager:getBreakOutCostGold(arg_56_1, var_56_3 + 1)

				for iter_56_0, iter_56_1 in pairs((core_manager:getBreakOutCostMaterial(arg_56_1, var_56_3 + 1))) do
					var_56_8[iter_56_1.itemid].num = var_56_8[iter_56_1.itemid].num - iter_56_1.num
					var_56_11.material[iter_56_1.itemid] = var_56_11.material[iter_56_1.itemid] or {
						num = 0
					}
					var_56_11.material[iter_56_1.itemid].num = var_56_11.material[iter_56_1.itemid].num + iter_56_1.num
				end

				var_56_3 = var_56_3 + 1
				var_56_5 = self:getWeponCurMaxLevel(var_56_3)
			else
				break
			end
		end

		if (var_56_7 - var_56_4 > 1 or var_56_2 < var_56_3 or nil) and true then
			UpdataTableData(arg_56_2, {
				ownMaterial = var_56_8,
				ownGold = var_56_9
			})

			return {
				ownData = arg_56_2,
				weaponCost = var_56_10,
				breakOutCost = var_56_11,
				lastWeaponLv = var_56_7,
				curWeaponLv = var_56_4,
				lastBreakOutRank = var_56_3,
				curBreakOutRank = var_56_2,
				weaponItemid = var_56_1
			}
		else
			return {
				ownData = arg_56_2,
				lastWeaponLv = var_56_4,
				curWeaponLv = var_56_4,
				lastBreakOutRank = var_56_2,
				curBreakOutRank = var_56_2,
				weaponItemid = var_56_1
			}
		end
	end

	return nil
end

return var_0_0
