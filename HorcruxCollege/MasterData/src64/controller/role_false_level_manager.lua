local var_0_0 = {}
local network = require("network.network")
local playermodel = require("model.playermodel")
local core_manager = require("controller.core_manager")
local item_manager = require("controller.item_manager")
local activity_manager = require("controller.activity_manager")
local item_data = require("data.item_data")
local afk_level_slot_data = require("data.afk_level_slot_data")
local servant_up_star_limit_data = require("data.servant_up_star_limit_data")
local afk_level_levelup_data = require("data.afk_level_levelup_data")
local servant_level_data = require("data.servant_level_data")
local afk_level_const_data = require("data.afk_level_const_data")
local core_data = require("data.core_data")
local levelmode_data = require("data.levelmode_data")
local role_false_level_data = require("data.role.role_false_level_data")
local time_check_manager = require("controller.time_check_manager")
local explore_manager = require("controller.explore_manager")

function var_0_0.get_afklevel_data(arg_1_0)
	network:rpc("get_afklevel_data", nil, function(arg_2_0)
		arg_1_0.afkLevel = arg_2_0.lv
		arg_1_0.servantList = arg_2_0.slots
		arg_1_0.use_servant = arg_2_0.use_servant

		if arg_1_0.afkLevel >= 300 and arg_2_0.wait_trans and arg_2_0.wait_trans == 1 then
			arg_1_0:afklevel_trans()
		else
			activity_manager:fireEvent(activity_manager.activityEventId.AFKLEVEL_DATA_UPDATE)
		end
	end)
end

function var_0_0.afklevel_trans(arg_3_0)
	network:rpc("afklevel_trans", nil, function(arg_4_0)
		if arg_4_0.result == 1 then
			arg_3_0.servantList = arg_4_0.slots

			activity_manager:fireEvent(activity_manager.activityEventId.AFKLEVEL_DATA_UPDATE)
		end
	end)
end

function var_0_0:afklevel_levelup()
	if not self.afkLevel then
		return
	end

	if not afk_level_levelup_data[self.afkLevel + 1] then
		global_ShowBlockWords(L_AFKLEVEL_LEVELUP_RESULT[3])

		return
	end

	for iter_5_0, iter_5_1 in ipairs((self:getCurAfkLevelNeeditem())) do
		if iter_5_1.itemid == "costIntensitemNum" then
			if iter_5_1.num > playermodel.strengthpoint then
				global_ShowBlockWords(L_LAB_STOP_RECIPE[3])

				return
			end
		elseif not item_manager:isHaveEnoughItem(iter_5_1.itemid, iter_5_1.num) then
			global_ShowBlockWords(string.format(L_COMMON_WARNING.Used_Up, item_data[iter_5_1.itemid].name))

			return
		end
	end

	network:rpc("afklevel_levelup", nil, function(arg_6_0)
		if arg_6_0.result == 1 then
			self.afkLevel = arg_6_0.lv

			if arg_6_0.consumes then
				for iter_6_0, iter_6_1 in ipairs(arg_6_0.consumes) do
					item_manager:deleteItem(iter_6_1.entityid, iter_6_1.num)
				end
			end

			for iter_6_2, iter_6_3 in pairs(playermodel.cores) do
				if iter_6_3.afk_lv then
					playermodel.cores[iter_6_2].afk_lv = self.afkLevel
				end
			end

			playermodel.strengthpoint = tonumber(arg_6_0.strengthpoint)

			activity_manager:fireEvent(activity_manager.activityEventId.AFKLEVEL_DATA_UPDATE)
		else
			global_ShowBlockWords(L_AFKLEVEL_LEVELUP_RESULT[arg_6_0.result])
		end
	end)
end

function var_0_0:afklevel_clear_cd(arg_7_1)
	LayerManager:pushInLayer("PopDoLayer", {
		labels = {
			title = L_AFKLEVEL_CLEAR_CD_DO.title,
			des = string.format(L_AFKLEVEL_CLEAR_CD_DO.des, afk_level_const_data.clear_cd_diamond.value * math.ceil((self.servantList[arg_7_1].cd - time_check_manager:getCurTime()) / 3600)),
			button = L_BATTLEPASS_BUY.button
		},
		surecallback = function()
			network:rpc("afklevel_clear_cd", {
				idx = arg_7_1
			}, function(arg_9_0)
				if arg_9_0.result == 1 then
					self.servantList[arg_7_1] = arg_9_0.slot
					playermodel.diamond = playermodel.diamond - arg_9_0.cost_diamond

					global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
					activity_manager:fireEvent(activity_manager.activityEventId.AFKLEVEL_DATA_UPDATE)
				elseif arg_9_0.result == 4 then
					LayerManager:pushInLayer("PopGoBuyDiamond", {
						is_need_pop_layer = 0
					})
				else
					global_ShowBlockWords(L_AFKLEVEL_CLEAR_CD_REWULT[arg_9_0.result])
				end
			end)
		end
	})
end

function var_0_0.afklevel_servant_up(arg_10_0, arg_10_1, arg_10_2)
	network:rpc("afklevel_servant_up", {
		idx = arg_10_1,
		servantid = arg_10_2
	}, function(arg_11_0)
		if arg_11_0.result == 1 then
			arg_10_0.servantList[arg_10_1] = arg_11_0.slot
			playermodel.cores[arg_10_2].afk_lv = arg_10_0.afkLevel

			activity_manager:fireEvent(activity_manager.activityEventId.AFKLEVEL_DATA_UPDATE)
		else
			global_ShowBlockWords(L_AFKLEVEL_SERVANT_UP[arg_11_0.result])
		end
	end)
end

function var_0_0.afklevel_servant_down(arg_12_0, arg_12_1)
	network:rpc("afklevel_servant_down", {
		idx = arg_12_1
	}, function(arg_13_0)
		if arg_13_0.result == 1 then
			playermodel.cores[arg_12_0.servantList[arg_12_1].sid].afk_lv = nil
			arg_12_0.servantList[arg_12_1] = arg_13_0.slot
			playermodel.diamond = playermodel.diamond - arg_13_0.cost_diamond

			global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
			activity_manager:fireEvent(activity_manager.activityEventId.AFKLEVEL_DATA_UPDATE)
		elseif arg_13_0.result == 4 then
			LayerManager:pushInLayer("PopGoBuyDiamond", {
				is_need_pop_layer = 0
			})
		else
			global_ShowBlockWords(L_AFKLEVEL_SERVANT_DOWN[arg_13_0.result])
		end
	end)
end

function var_0_0:afklevel_unlock_slot()
	LayerManager:pushInLayer("PopDoLayer", {
		labels = {
			title = L_AFKLEVEL_UNLOCK_SLOT_DO.title,
			des = string.format(L_AFKLEVEL_UNLOCK_SLOT_DO.des, (self:getAfklevelUnlockSlotCost())),
			button = L_BATTLEPASS_BUY.button
		},
		surecallback = function()
			network:rpc("afklevel_unlock_slot", nil, function(arg_16_0)
				if arg_16_0.result == 1 then
					self.servantList = arg_16_0.slots
					playermodel.diamond = playermodel.diamond - arg_16_0.cost_diamond

					global_update_gold_stone_diamond(nil, nil, playermodel.diamond)
					activity_manager:fireEvent(activity_manager.activityEventId.AFKLEVEL_DATA_UPDATE)
				elseif arg_16_0.result == 3 then
					LayerManager:pushInLayer("PopGoBuyDiamond", {
						is_need_pop_layer = 0
					})
				else
					global_ShowBlockWords(L_AFKLEVEL_UNLOCK_SLOT_REWULT[arg_16_0.result])
				end
			end)
		end
	})
end

function var_0_0:getAfklevelUnlockSlotCost()
	for iter_17_0 = 1, #afk_level_slot_data do
		if not self.servantList[iter_17_0] then
			return afk_level_slot_data[iter_17_0].diamond
		end
	end
end

function var_0_0:getCurAfkLevel()
	if not self.afkLevel then
		local var_18_0 = 0

		for iter_18_0, iter_18_1 in pairs(playermodel.cores) do
			var_18_0 = math.max(iter_18_1.afk_lv or 0, var_18_0)
		end

		return var_18_0
	end

	return self.afkLevel
end

function var_0_0.getMaxLevelServantList(arg_19_0)
	local var_19_0 = {}

	for iter_19_0, iter_19_1 in pairs(playermodel.cores) do
		table.insert(var_19_0, {
			servantid = iter_19_0,
			level = core_manager:getCoreLv(iter_19_0)
		})
	end

	table.sort(var_19_0, function(arg_20_0, arg_20_1)
		return arg_20_0.level > arg_20_1.level
	end)

	local var_19_1 = {}

	for iter_19_2 = 1, 5 do
		if var_19_0[iter_19_2] then
			var_19_1[iter_19_2] = var_19_0[iter_19_2]
		end
	end

	return var_19_1
end

function var_0_0:getCurAfkLevelNeedContractAttr()
	for iter_21_0 = 2, #servant_up_star_limit_data do
		if self.afkLevel + 1 <= servant_up_star_limit_data[iter_21_0].lv then
			return servant_up_star_limit_data[iter_21_0].star
		end
	end

	return servant_up_star_limit_data[#servant_up_star_limit_data].star
end

function var_0_0:getCurAfkLevelNeeditem()
	local var_22_0 = {}

	while afk_level_levelup_data[self.afkLevel]["material_" .. 1] do
		table.insert(var_22_0, {
			itemid = afk_level_levelup_data[self.afkLevel]["material_" .. 1],
			num = afk_level_levelup_data[self.afkLevel]["material_num_" .. 1]
		})
	end

	local var_22_2 = servant_level_data[self.afkLevel].consume_intensitem_number

	if servant_level_data[self.afkLevel].consume_intensitem_number > 0 then
		table.insert(var_22_0, {
			itemid = "costIntensitemNum",
			num = var_22_2
		})
	end

	return var_22_0
end

function var_0_0:getAfkLevelServantList()
	local var_23_0 = {}

	for iter_23_0 = 1, #afk_level_slot_data do
		var_23_0[iter_23_0] = self.servantList[iter_23_0] and self.servantList[iter_23_0] or afk_level_slot_data[iter_23_0]
	end

	return var_23_0
end

function var_0_0:getAfkLevelLockServants()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(self.servantList) do
		if iter_24_1.sid then
			var_24_0[iter_24_1.sid] = true
		end
	end

	if self.afkLevel >= 300 then
		return var_24_0
	end

	for iter_24_2, iter_24_3 in ipairs((self:getBeforeServantList())) do
		var_24_0[iter_24_3.servantid] = true
	end

	return var_24_0
end

function var_0_0:getServantNum()
	local var_25_0 = 0

	for iter_25_0 = 1, #self.servantList do
		if self.servantList[iter_25_0].sid then
			var_25_0 = var_25_0 + 1
		end
	end

	return #self.servantList, var_25_0
end

function var_0_0:updateSoulsAfkLevel()
	if self.afkLevel and self.afkLevel > 300 then
		return
	end

	local var_26_0 = {}
	local var_26_1 = 0

	for iter_26_0, iter_26_1 in pairs(playermodel.cores) do
		local var_26_3 = {
			servantid = iter_26_0
		}

		var_26_3.level = iter_26_1.level or 0

		table.insert(var_26_0, var_26_3)

		if iter_26_1.afk_lv then
			var_26_1 = iter_26_1.afk_lv
		end
	end

	table.sort(var_26_0, function(arg_27_0, arg_27_1)
		return arg_27_0.level > arg_27_1.level
	end)

	if var_26_0[5] then
		local var_26_4 = var_26_0[5].level or var_26_0[#var_26_0].level

		if var_26_4 == var_26_1 then
			return
		end

		if var_26_4 <= 300 then
			for iter_26_2, iter_26_3 in pairs(playermodel.cores) do
				if iter_26_3.afk_lv then
					playermodel.cores[iter_26_2].afk_lv = var_26_4
				end
			end
		end
	end
end

function var_0_0.restartGameClear(arg_28_0)
	arg_28_0.afkLevel = nil
	arg_28_0.servantList = nil
end

function var_0_0:isRoleFalseLevelMember(arg_29_1, arg_29_2, arg_29_3)
	if config._DEVELOP_MODE == "FIGHTDEV" then
		return
	end

	print(self:isPseudoLevel(arg_29_2, arg_29_3), arg_29_2, arg_29_3)

	if self:isPseudoLevel(arg_29_2, arg_29_3) then
		return true
	end

	if not arg_29_1 then
		return
	end

	if playermodel.cores[arg_29_1].afk_lv then
		return true
	end

	local var_29_0 = {}
	local var_29_1 = time_check_manager:getCurTime()

	for iter_29_0, iter_29_1 in pairs(role_false_level_data) do
		if var_29_1 > os.time(parse_time(iter_29_1.starttime)) and var_29_1 < os.time(parse_time(iter_29_1.finishtime)) then
			var_29_0[iter_29_1.id] = true
		end
	end

	return var_29_0[arg_29_1]
end

function var_0_0:getRoleFalseAttrInfoByAllRole(arg_30_1, arg_30_2, arg_30_3)
	local var_30_0
	local var_30_1
	local var_30_2 = playermodel.cores[arg_30_1].coreid

	if self:isPseudoLevel(arg_30_2, arg_30_3) then
		local var_30_3 = self:getPseudoLevelData(arg_30_1, arg_30_2, arg_30_3)

		var_30_2 = var_30_3.coreid
		var_30_1 = math.max(var_30_3.level, playermodel.cores[arg_30_1].afk_lv or 0)
		var_30_0 = var_30_3.rank
	elseif not self:isPseudoLevel(arg_30_2, arg_30_3) and playermodel.cores[arg_30_1].afk_lv then
		local var_30_4 = self:getPseudoLevelData(arg_30_1, arg_30_2, arg_30_3)

		var_30_2 = var_30_4.coreid
		var_30_1 = playermodel.cores[arg_30_1].afk_lv
		var_30_0 = var_30_4.rank
	else
		for iter_30_0, iter_30_1 in pairs(playermodel.cores) do
			local var_30_5 = iter_30_1.level or 0

			if not var_30_1 then
				var_30_1 = iter_30_1.afk_lv or var_30_5
			elseif var_30_1 < (iter_30_1.afk_lv or var_30_5) then
				var_30_1 = iter_30_1.afk_lv or var_30_5
			end
		end

		var_30_0 = require("controller.core_manager"):getServantCoreRank(arg_30_1)
	end

	return var_30_0, var_30_1 or 0, var_30_2, 0
end

function var_0_0:isFalseLevelRoleInHangup()
	local var_31_0 = false

	for iter_31_0, iter_31_1 in pairs(playermodel.curSoul) do
		if iter_31_1.fight_girl and iter_31_1.classtype == 1 and self:isRoleFalseLevelMember(iter_31_1.fight_girl) then
			var_31_0 = true
		end
	end

	return var_31_0
end

function var_0_0.getPseudoLevelData(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if arg_32_3 then
		if DeviceManager:getChannelID() == "palmpi" and not levelmode_data[arg_32_3].preset_level then
			hx_print("Warning: false level levelModeData[" .. arg_32_3 .. "].preset_level is nil!!!", CONSOLE_COLOR_YELLO)
		end

		local var_32_1

		if not levelmode_data[arg_32_3].preset_level then
			var_32_1 = {
				coreid = playermodel.cores[arg_32_1].coreid
			}
		end
	end

	var_32_1.level = math.max(require("controller.core_manager"):getCoreLv(arg_32_1), 300)
	var_32_1.rank = core_data[playermodel.cores[arg_32_1].coreid].rank

	return var_32_1
end

function var_0_0.isPseudoLevel(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_2 then
		if levelmode_data[arg_33_2].preset_level then
			return levelmode_data[arg_33_2].preset_level > 0
		end
	elseif arg_33_1 then
		if REAL_ROLE_LEVEL_TYPES[arg_33_1] then
			return false
		elseif arg_33_1 == FIGHTTYPE_EXPLORE and not explore_manager:isOfferExplore() then
			return false
		elseif arg_33_1 == FIGHTTYPE_ROGUEEXPLORE then
			return true
		else
			return true
		end
	end

	return false
end

function var_0_0.getCurMaxAfkLevel(arg_34_0)
	for iter_34_0 = 300, 10000 do
		if not afk_level_levelup_data[data] then
			return iter_34_0
		end
	end
end

function var_0_0:checkAlert()
	local alert_manager = require("controller.alert_manager")

	if RoleDefault:getInstance():getIntegerForKey("MaxafkLevel", 0) < self:getCurMaxAfkLevel() then
		alert_manager:register_alert(ALERT_AFK_LEVEL)
	else
		alert_manager:unregister_alert(ALERT_AFK_LEVEL)
	end
end

function var_0_0:getBeforeServantList()
	if not self.use_servant then
		return self:getMaxLevelServantList()
	end

	local var_36_0 = {}

	for iter_36_0, iter_36_1 in ipairs(self.use_servant) do
		table.insert(var_36_0, {
			servantid = iter_36_1,
			level = core_manager:getCoreLv(iter_36_1)
		})
	end

	return var_36_0
end

function var_0_0:setBeforeServantList(arg_37_1, arg_37_2)
	local var_37_0 = clone(self.use_servant)

	if not var_37_0 then
		var_37_0 = {}

		for iter_37_0, iter_37_1 in ipairs((self:getMaxLevelServantList())) do
			table.insert(var_37_0, iter_37_1.servantid)
		end
	end

	if #var_37_0 ~= 5 then
		global_ShowBlockWords("协调台上阵不满五个")

		return
	end

	if self.afkLevel >= 300 then
		global_ShowBlockWords("协调等级超过300级了")
	end

	var_37_0[arg_37_1] = arg_37_2

	network:rpc("afklevel_choose", {
		servantids = var_37_0
	}, function(arg_38_0)
		if arg_38_0.result == 1 then
			self.afkLevel = arg_38_0.lv
			self.servantList = arg_38_0.slots
			self.use_servant = arg_38_0.use_servant

			activity_manager:fireEvent(activity_manager.activityEventId.AFKLEVEL_DATA_UPDATE)
		elseif arg_38_0.result == 2 then
			global_ShowBlockWords("上阵出错了")
		elseif arg_38_0.result == 3 then
			global_ShowBlockWords("上阵出错了")
		elseif arg_38_0.result == 4 then
			global_ShowBlockWords("有学员在下面的列表中")
		end
	end)
end

return var_0_0
