local var_0_0 = class("IslandCharacterAgency", import(".IslandBaseAgency"))

var_0_0.ADD_SHIP = "IslandCharacterAgency:ADD_SHIP"
var_0_0.SHIP_LEVEL_UP = "IslandCharacterAgency:SHIP_LEVEL_UP"
var_0_0.SHIP_GET_STATE = "IslandCharacterAgency:SHIP_GET_STATE"
var_0_0.CHANGE_CHARACTER_DRESS = "IslandCharacterAgency:CHANGE_CHARACTER_DRESS"
var_0_0.SHIP_SKILL_STATE_CHANGE = "IslandCharacterAgency:SHIP_SKILL_STATE_CHANGE"
var_0_0.NPC_CONFIG_ID = 1

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.inviteList = {}
	arg_1_0.ships = {}

	local var_1_0 = arg_1_1.ship_sys.invite_list or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.inviteList, iter_1_1)
	end

	local var_1_1 = arg_1_1.ship_sys.ship_list or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		local var_1_2 = IslandShip.New(iter_1_3)

		arg_1_0.ships[var_1_2.id] = var_1_2
	end

	local var_1_3 = IslandNpcShip.New({
		id = var_0_0.NPC_CONFIG_ID
	})

	arg_1_0.ships[var_1_3.id] = var_1_3
	arg_1_0.hasDressData = {}

	local var_1_4 = arg_1_1.ship_sys.had_dress or {}

	for iter_1_4, iter_1_5 in ipairs(var_1_4) do
		arg_1_0.hasDressData[iter_1_5.id] = IslandOwnedDressItem.New(iter_1_5)
	end

	arg_1_0.read_list = arg_1_1.ship_sys.read_list
	arg_1_0.shipSkinDic = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.ship_sys.skin_list) do
		local var_1_5 = arg_1_0.shipSkinDic[iter_1_7.ship_id] or {}

		for iter_1_8, iter_1_9 in ipairs(iter_1_7.skin_list) do
			table.insert(var_1_5, IslandShipSkin.New(iter_1_9))
		end

		arg_1_0.shipSkinDic[iter_1_7.ship_id] = var_1_5
	end

	arg_1_0.shipWearDressData = {}

	local var_1_6 = arg_1_1.ship_sys.wear_list or {}

	for iter_1_10, iter_1_11 in ipairs(var_1_6) do
		local var_1_7 = arg_1_0.shipWearDressData[iter_1_11.ship_id] or {}

		table.insert(var_1_7, IslandShipDressItem.New(iter_1_11))

		arg_1_0.shipWearDressData[iter_1_11.ship_id] = var_1_7
	end

	arg_1_0.gameViewIDList = {}

	for iter_1_12, iter_1_13 in ipairs(arg_1_1.ship_sys.game_ship_list) do
		arg_1_0.gameViewIDList[iter_1_13.game_type] = iter_1_13.ship_id
	end

	return
end

function var_0_0.SetMiniGameShipViewId(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameViewIDList[arg_2_1] = arg_2_2

	return
end

function var_0_0.GetViewGameShipViewId(arg_3_0, arg_3_1)
	return arg_3_0.gameViewIDList[arg_3_1]
end

function var_0_0.CanFollowPlayer(arg_4_0, arg_4_1)
	if not arg_4_0.ships[arg_4_1] then
		return false
	end

	local var_4_1 = var_4_0:GetCantFollowTaskIdList()
	local var_4_2 = false

	if #var_4_1 > 0 then
		local var_4_3 = arg_4_0:GetHost():GetTaskAgency()

		var_4_2 = _.any(var_4_1, function(arg_5_0)
			return var_4_3:GetTask(arg_5_0) ~= nil
		end)
	end

	return var_4_0:GetState() == IslandShip.STATE_NORMAL and not var_4_2
end

function var_0_0.GetInviteList(arg_6_0)
	return arg_6_0.inviteList
end

function var_0_0.AddInvite(arg_7_0, arg_7_1)
	table.insert(arg_7_0.inviteList, arg_7_1)

	return
end

function var_0_0.HasInvite(arg_8_0, arg_8_1)
	return _.any(arg_8_0.inviteList, function(arg_9_0)
		return arg_8_1 == arg_9_0
	end)
end

function var_0_0.RemoveInvite(arg_10_0, arg_10_1)
	table.removebyvalue(arg_10_0.inviteList, arg_10_1)

	return
end

function var_0_0.GetShips(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.ships) do
		if iter_11_1.id ~= var_0_0.NPC_CONFIG_ID then
			table.insert({}, iter_11_1)
		end
	end

	return {}
end

function var_0_0.GetShipsContainNpc(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.ships) do
		table.insert({}, iter_12_1)
	end

	return {}
end

function var_0_0.AddShip(arg_13_0, arg_13_1)
	arg_13_0.ships[arg_13_1.id] = arg_13_1

	arg_13_0:DispatchEvent(var_0_0.ADD_SHIP, arg_13_1)

	return
end

function var_0_0.GetShipById(arg_14_0, arg_14_1)
	return arg_14_0.ships[arg_14_1]
end

function var_0_0.GetUnlockOrCanUnlockShipConfigIds(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(pg.island_chara_template.all) do
		if iter_15_1 ~= var_0_0.NPC_CONFIG_ID and (arg_15_0.ships[iter_15_1] or arg_15_0:HasInvite(iter_15_1)) then
			table.insert({}, iter_15_1)
		end
	end

	table.sort({}, CompareFuncs({
		function(arg_16_0)
			return arg_15_0.ships[arg_16_0] and 0 or 1
		end,
		function(arg_17_0)
			return arg_17_0
		end
	}))

	return {}
end

function var_0_0.GetUnlockOrCanUnlockShipConfigIdsContainNpc(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(pg.island_chara_template.all) do
		if arg_18_0.ships[iter_18_1] or arg_18_0:HasInvite(iter_18_1) then
			table.insert({}, iter_18_1)
		end
	end

	table.sort({}, CompareFuncs({
		function(arg_19_0)
			return arg_18_0.ships[arg_19_0] and 0 or 1
		end,
		function(arg_20_0)
			return arg_20_0
		end
	}))

	return {}
end

function var_0_0.GetAllSkinCnt(arg_21_0)
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(arg_21_0.shipSkinDic) do
		var_21_0 = var_21_0 + #iter_21_1
	end

	return var_21_0
end

function var_0_0.GetOwnSkinListByShipId(arg_22_0, arg_22_1)
	return arg_22_0.shipSkinDic[arg_22_1] or {}
end

function var_0_0.AddSkin(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.shipSkinDic[pg.island_skin_template[arg_23_1].ship_group] or {}

	table.insert(var_23_0, IslandShipSkin.New({
		color_id = 0,
		id = arg_23_1,
		color_list = {}
	}))

	arg_23_0.shipSkinDic[pg.island_skin_template[arg_23_1].ship_group] = var_23_0

	return
end

function var_0_0.AddSkinColor(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0.shipSkinDic[arg_24_1] or {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1.id == arg_24_2 then
			iter_24_1:AddSkinColor(arg_24_3)
		end
	end

	return
end

function var_0_0.GetCurrentSkinColorByShipId(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0.shipSkinDic[arg_25_1] or {}

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if iter_25_1.id == arg_25_2 then
			return iter_25_1.color_id
		end
	end

	return 0
end

function var_0_0.GetAllOwnDressDic(arg_26_0)
	return arg_26_0.hasDressData
end

function var_0_0.GetDiffDressCnt(arg_27_0)
	return #underscore.keys(arg_27_0.hasDressData)
end

function var_0_0.GetDiffDressCntByType(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in pairs(arg_28_0.hasDressData) do
		if pg.island_dress_template[iter_28_0].type == arg_28_1 and not table.contains({}, iter_28_0) then
			table.insert({}, iter_28_0)
		end
	end

	return #{}
end

function var_0_0.ExistDressId(arg_29_0, arg_29_1)
	return arg_29_0.hasDressData[arg_29_1] ~= nil
end

function var_0_0.GetDressIdRealCount(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:GetOwnDressCountByDressId()

	for iter_30_0, iter_30_1 in pairs(arg_30_0.shipWearDressData) do
		for iter_30_2, iter_30_3 in ipairs(iter_30_1) do
			if iter_30_3.dress_id == arg_30_1 then
				var_30_0 = var_30_0 + 1
			end
		end
	end

	return var_30_0
end

function var_0_0.GetOwnDressCountByDressId(arg_31_0, arg_31_1)
	if arg_31_0.hasDressData[arg_31_1] then
		return arg_31_0.hasDressData[arg_31_1].num or 0
	end
end

function var_0_0.AddDressItem(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if not arg_32_0.hasDressData[arg_32_1] then
		arg_32_0.hasDressData[arg_32_1] = IslandOwnedDressItem.New({
			id = arg_32_1,
			num = arg_32_2,
			read = arg_32_3 and 0 or 1
		})
	else
		arg_32_0.hasDressData[arg_32_1].num = arg_32_0.hasDressData[arg_32_1].num + arg_32_2

		if arg_32_3 then
			arg_32_0.hasDressData[arg_32_1].read = 1
		end
	end

	return
end

function var_0_0.ReduceDressItem(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0.hasDressData[arg_33_1] then
		return
	end

	arg_33_0.hasDressData[arg_33_1].num = arg_33_0.hasDressData[arg_33_1].num - arg_33_2

	return
end

function var_0_0.CheckSkinIsOwned(arg_34_0, arg_34_1)
	if arg_34_1 == 0 then
		return true
	end

	for iter_34_0, iter_34_1 in pairs(arg_34_0:GetOwnSkinListByShipId(pg.island_skin_template[arg_34_1].ship_group)) do
		if iter_34_1.id == arg_34_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetSkinData(arg_35_0, arg_35_1)
	if arg_35_1 == 0 then
		return nil
	end

	for iter_35_0, iter_35_1 in pairs(arg_35_0:GetOwnSkinListByShipId(pg.island_skin_template[arg_35_1].ship_group)) do
		if iter_35_1.id == arg_35_1 then
			return iter_35_1
		end
	end

	return nil
end

function var_0_0.SetSkinCurrentColor(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 == 0 then
		return
	end

	local var_36_0 = arg_36_0:GetSkinData(arg_36_1)

	if var_36_0 then
		var_36_0:SetCurrentColor(arg_36_2)
	end

	return
end

function var_0_0.GetSkinCurrentColor(arg_37_0, arg_37_1)
	if arg_37_1 == 0 then
		return 0
	end

	local var_37_0 = arg_37_0:GetSkinData(arg_37_1)

	if var_37_0 then
		return var_37_0:GetCurrentColor()
	end

	return 0
end

function var_0_0.CheckSkinColorIsOwned(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0:GetSkinData(arg_38_1)

	if not var_38_0 then
		return false
	end

	return var_38_0:CheckColorOwned(arg_38_2)
end

function var_0_0.GetHasDressData(arg_39_0, arg_39_1)
	return arg_39_0.hasDressData[arg_39_1]
end

function var_0_0.SetDressHasRead(arg_40_0, arg_40_1)
	if not arg_40_0.hasDressData[arg_40_1] then
		return
	end

	arg_40_0.hasDressData[arg_40_1].read = 1

	return
end

function var_0_0.CheckRedDotByDressType(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in pairs(arg_41_0.hasDressData) do
		if iter_41_1:getConfigTable().type == arg_41_1 and iter_41_1.read == 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetCurDressIdByShipId(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = arg_42_0.shipWearDressData[arg_42_1] or {}

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if iter_42_1:getConfigTable().type == arg_42_2 then
			return iter_42_1
		end
	end

	return nil
end

function var_0_0.DischargeDressOnShip(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_0.shipWearDressData[arg_43_1] or {}
	local var_43_1 = -1

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if iter_43_1.dress_id == arg_43_2 then
			var_43_1 = iter_43_0
		end
	end

	if var_43_1 ~= -1 then
		table.remove(var_43_0, var_43_1)
	end

	arg_43_0.shipWearDressData[arg_43_1] = var_43_0

	return
end

function var_0_0.ChargeDressOnShip(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = arg_44_0.shipWearDressData[arg_44_1] or {}

	table.insert(var_44_0, IslandShipDressItem.New({
		ship_id = arg_44_1,
		dress_id = arg_44_2
	}))

	arg_44_0.shipWearDressData[arg_44_1] = var_44_0

	return
end

function var_0_0.GetShipHoldedDressDic(arg_45_0)
	return arg_45_0.shipWearDressData
end

function var_0_0.ResetShipSkillUsed(arg_46_0)
	for iter_46_0, iter_46_1 in pairs(arg_46_0.ships) do
		iter_46_1:GetSkill():UpdateUsedToday(false)
	end

	return
end

return var_0_0
