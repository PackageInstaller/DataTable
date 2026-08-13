class = var_0_10000

local var_0_0 = "IslandCharacterAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.ADD_SHIP = "IslandCharacterAgency:ADD_SHIP"
var_0_1.SHIP_LEVEL_UP = "IslandCharacterAgency:SHIP_LEVEL_UP"
var_0_1.SHIP_GET_STATE = "IslandCharacterAgency:SHIP_GET_STATE"
var_0_1.CHANGE_CHARACTER_DRESS = "IslandCharacterAgency:CHANGE_CHARACTER_DRESS"
var_0_1.SHIP_SKILL_STATE_CHANGE = "IslandCharacterAgency:SHIP_SKILL_STATE_CHANGE"
var_0_1.NPC_CONFIG_ID = 1

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.inviteList = {}
	arg_1_0.ships = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.ship_sys.invite_list then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.inviteList, iter_1_1)
	end

	ipairs = var_2

	local var_1_1

	if not arg_1_1.ship_sys.ship_list then
		var_1_1 = {}
	end

	for iter_1_2, iter_1_3 in var_2(var_1_1) do
		IslandShip = var_1_10007
		var_1_10007 = var_1_10007.New(iter_1_3)
		arg_1_0.ships[var_1_10007.id] = var_1_10007
	end

	IslandNpcShip = var_2

	local var_1_2 = var_2.New({
		id = var_0_1.NPC_CONFIG_ID
	})

	arg_1_0.ships[var_1_2.id] = var_1_2
	arg_1_0.hasDressData = {}
	ipairs = var_3

	local var_1_3

	if not arg_1_1.ship_sys.had_dress then
		var_1_3 = {}
	end

	for iter_1_4, iter_1_5 in var_3(var_1_3) do
		local var_1_4 = arg_1_0.hasDressData
		local var_1_5 = iter_1_5.id

		IslandOwnedDressItem = var_1_10010
		var_1_4[var_1_5] = var_1_10010.New(iter_1_5)
	end

	arg_1_0.read_list = arg_1_1.ship_sys.read_list
	arg_1_0.shipSkinDic = {}
	ipairs = var_3

	for iter_1_6, iter_1_7 in var_3(arg_1_1.ship_sys.skin_list) do
		local var_1_6

		if not arg_1_0.shipSkinDic[iter_1_7.ship_id] then
			var_1_6 = {}
		end

		ipairs = var_9

		for iter_1_8, iter_1_9 in var_9(iter_1_7.skin_list) do
			table = var_1_10014
			var_1_10014 = var_1_10014.insert

			local var_1_7 = var_1_6

			IslandShipSkin = var_1_10016

			var_1_10014(var_1_7, var_1_10016.New(iter_1_9))
		end

		arg_1_0.shipSkinDic[iter_1_7.ship_id] = var_1_6
	end

	arg_1_0.shipWearDressData = {}
	ipairs = var_3

	local var_1_8

	if not arg_1_1.ship_sys.wear_list then
		var_1_8 = {}
	end

	for iter_1_10, iter_1_11 in var_3(var_1_8) do
		local var_1_9

		if not arg_1_0.shipWearDressData[iter_1_11.ship_id] then
			var_1_9 = {}
		end

		table = var_9

		local var_1_10 = var_9.insert
		local var_1_11 = var_1_9

		IslandShipDressItem = var_1_10011

		var_1_10(var_1_11, var_1_10011.New(iter_1_11))

		arg_1_0.shipWearDressData[iter_1_11.ship_id] = var_1_9
	end

	arg_1_0.gameViewIDList = {}
	ipairs = var_3

	for iter_1_12, iter_1_13 in var_3(arg_1_1.ship_sys.game_ship_list) do
		arg_1_0.gameViewIDList[iter_1_13.game_type] = iter_1_13.ship_id
	end

	return
end

function var_0_1.SetMiniGameShipViewId(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.gameViewIDList[arg_2_1] = arg_2_2

	return
end

function var_0_1.GetViewGameShipViewId(arg_3_0, arg_3_1)
	return arg_3_0.gameViewIDList[arg_3_1]
end

function var_0_1.CanFollowPlayer(arg_4_0, arg_4_1)
	if not arg_4_0.ships[arg_4_1] then
		return false
	end

	local var_4_0 = var_2:GetCantFollowTaskIdList()
	local var_4_1 = false

	if #var_4_0 > 0 then
		local var_4_2 = arg_4_0:GetHost()
		local var_4_3 = var_5.GetTaskAgency(var_4_2)

		_ = var_4_2
		var_4_1 = var_4_2.any(var_4_0, function(arg_5_0)
			local var_5_0 = var_4_3

			return var_1.GetTask(var_5_0, arg_5_0) ~= nil
		end)
	end

	local var_4_4 = var_2
	local var_4_5 = var_2.GetState(var_4_4)

	IslandShip = var_4_4

	return var_4_5 == var_4_4.STATE_NORMAL and not var_4_1
end

function var_0_1.GetInviteList(arg_6_0)
	return arg_6_0.inviteList
end

function var_0_1.AddInvite(arg_7_0, arg_7_1)
	table = var_1_10002

	var_1_10002.insert(arg_7_0.inviteList, arg_7_1)

	return
end

function var_0_1.HasInvite(arg_8_0, arg_8_1)
	_ = var_1_10002

	return var_1_10002.any(arg_8_0.inviteList, function(arg_9_0)
		return arg_8_1 == arg_9_0
	end)
end

function var_0_1.RemoveInvite(arg_10_0, arg_10_1)
	table = var_1_10002

	var_1_10002.removebyvalue(arg_10_0.inviteList, arg_10_1)

	return
end

function var_0_1.GetShips(arg_11_0)
	local var_11_0 = {}

	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.ships) do
		if iter_11_1.id ~= var_0_1.NPC_CONFIG_ID then
			table = var_7

			var_7.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function var_0_1.GetShipsContainNpc(arg_12_0)
	local var_12_0 = {}

	pairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.ships) do
		table = var_1_10007

		var_1_10007.insert(var_12_0, iter_12_1)
	end

	return var_12_0
end

function var_0_1.AddShip(arg_13_0, arg_13_1)
	arg_13_0.ships[arg_13_1.id] = arg_13_1

	arg_13_0:DispatchEvent(var_0_1.ADD_SHIP, arg_13_1)

	return
end

function var_0_1.GetShipById(arg_14_0, arg_14_1)
	return arg_14_0.ships[arg_14_1]
end

function var_0_1.GetUnlockOrCanUnlockShipConfigIds(arg_15_0)
	local var_15_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_15_0, iter_15_1 in var_1_10002(var_1_10003.island_chara_template.all) do
		if iter_15_1 ~= var_0_1.NPC_CONFIG_ID and (arg_15_0.ships[iter_15_1] or arg_15_0:HasInvite(iter_15_1)) then
			table = var_7

			var_7.insert(var_15_0, iter_15_1)
		end
	end

	table = var_2

	local var_15_1 = var_2.sort
	local var_15_2 = var_15_0

	CompareFuncs = var_4

	var_15_1(var_15_2, var_4({
		function(arg_16_0)
			return arg_15_0.ships[arg_16_0] and 0 or 1
		end,
		function(arg_17_0)
			return arg_17_0
		end
	}))

	return var_15_0
end

function var_0_1.GetUnlockOrCanUnlockShipConfigIdsContainNpc(arg_18_0)
	local var_18_0 = {}

	ipairs = var_1_10002
	pg = var_1_10003

	for iter_18_0, iter_18_1 in var_1_10002(var_1_10003.island_chara_template.all) do
		if arg_18_0.ships[iter_18_1] or arg_18_0:HasInvite(iter_18_1) then
			table = var_7

			var_7.insert(var_18_0, iter_18_1)
		end
	end

	table = var_2

	local var_18_1 = var_2.sort
	local var_18_2 = var_18_0

	CompareFuncs = var_4

	var_18_1(var_18_2, var_4({
		function(arg_19_0)
			return arg_18_0.ships[arg_19_0] and 0 or 1
		end,
		function(arg_20_0)
			return arg_20_0
		end
	}))

	return var_18_0
end

function var_0_1.GetAllSkinCnt(arg_21_0)
	local var_21_0 = 0

	pairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0.shipSkinDic) do
		var_21_0 = var_21_0 + #iter_21_1
	end

	return var_21_0
end

function var_0_1.GetOwnSkinListByShipId(arg_22_0, arg_22_1)
	local var_22_0

	if not arg_22_0.shipSkinDic[arg_22_1] then
		var_22_0 = {}
	end

	return var_22_0
end

function var_0_1.AddSkin(arg_23_0, arg_23_1)
	pg = var_1_10002

	local var_23_0 = var_1_10002.island_skin_template[arg_23_1].ship_group
	local var_23_1

	if not arg_23_0.shipSkinDic[var_23_0] then
		var_23_1 = {}
	end

	table = var_1_10004

	local var_23_2 = var_1_10004.insert
	local var_23_3 = var_23_1

	IslandShipSkin = var_1_10006

	var_23_2(var_23_3, var_1_10006.New({
		color_id = 0,
		id = arg_23_1,
		color_list = {}
	}))

	arg_23_0.shipSkinDic[var_23_0] = var_23_1

	return
end

function var_0_1.AddSkinColor(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0

	if not arg_24_0.shipSkinDic[arg_24_1] then
		var_24_0 = {}
	end

	ipairs = var_1_10005

	for iter_24_0, iter_24_1 in var_1_10005(var_24_0) do
		if iter_24_1.id == arg_24_2 then
			iter_24_1:AddSkinColor(arg_24_3)
		end
	end

	return
end

function var_0_1.GetCurrentSkinColorByShipId(arg_25_0, arg_25_1, arg_25_2)
	ipairs = var_1_10003

	local var_25_0

	if not arg_25_0.shipSkinDic[arg_25_1] then
		var_25_0 = {}
	end

	for iter_25_0, iter_25_1 in var_1_10003(var_25_0) do
		if iter_25_1.id == arg_25_2 then
			return iter_25_1.color_id
		end
	end

	return 0
end

function var_0_1.GetAllOwnDressDic(arg_26_0)
	return arg_26_0.hasDressData
end

function var_0_1.GetDiffDressCnt(arg_27_0)
	underscore = var_1_10001

	return #var_1_10001.keys(arg_27_0.hasDressData)
end

function var_0_1.GetDiffDressCntByType(arg_28_0, arg_28_1)
	local var_28_0 = {}

	pairs = var_1_10003

	for iter_28_0, iter_28_1 in var_1_10003(arg_28_0.hasDressData) do
		pg = var_1_10008

		if var_1_10008.island_dress_template[iter_28_0].type == arg_28_1 then
			table = var_1_10008

			if not var_1_10008.contains(var_28_0, iter_28_0) then
				table = var_1_10008

				var_1_10008.insert(var_28_0, iter_28_0)
			end
		end
	end

	return #var_28_0
end

function var_0_1.ExistDressId(arg_29_0, arg_29_1)
	return arg_29_0.hasDressData[arg_29_1] ~= nil
end

function var_0_1.GetDressIdRealCount(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.GetOwnDressCountByDressId(var_30_0)

	pairs = var_30_0

	for iter_30_0, iter_30_1 in var_30_0(arg_30_0.shipWearDressData) do
		ipairs = var_1_10008

		for iter_30_2, iter_30_3 in var_1_10008(iter_30_1) do
			if iter_30_3.dress_id == arg_30_1 then
				var_30_1 = var_30_1 + 1
			end
		end
	end

	return var_30_1
end

function var_0_1.GetOwnDressCountByDressId(arg_31_0, arg_31_1)
	local var_31_0

	if not arg_31_0.hasDressData[arg_31_1] or not arg_31_0.hasDressData[arg_31_1].num then
		var_31_0 = 0
	end

	return var_31_0
end

function var_0_1.AddDressItem(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if not arg_32_0.hasDressData[arg_32_1] then
		local var_32_0 = arg_32_3 and 0 or 1
		local var_32_1 = arg_32_0.hasDressData

		IslandOwnedDressItem = var_1_10006
		var_32_1[arg_32_1] = var_1_10006.New({
			id = arg_32_1,
			num = arg_32_2,
			read = var_32_0
		})
	else
		arg_32_0.hasDressData[arg_32_1].num = arg_32_0.hasDressData[arg_32_1].num + arg_32_2

		if arg_32_3 then
			arg_32_0.hasDressData[arg_32_1].read = 1
		end
	end

	return
end

function var_0_1.ReduceDressItem(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0.hasDressData[arg_33_1] then
		return
	end

	arg_33_0.hasDressData[arg_33_1].num = arg_33_0.hasDressData[arg_33_1].num - arg_33_2

	return
end

function var_0_1.CheckSkinIsOwned(arg_34_0, arg_34_1)
	if arg_34_1 == 0 then
		return true
	end

	pg = var_1_10002

	local var_34_0 = var_1_10002.island_skin_template[arg_34_1].ship_group

	pairs = var_1_10003

	for iter_34_0, iter_34_1 in var_1_10003(arg_34_0:GetOwnSkinListByShipId(var_34_0)) do
		if iter_34_1.id == arg_34_1 then
			return true
		end
	end

	return false
end

function var_0_1.GetSkinData(arg_35_0, arg_35_1)
	if arg_35_1 == 0 then
		return nil
	end

	pg = var_1_10002

	local var_35_0 = var_1_10002.island_skin_template[arg_35_1].ship_group

	pairs = var_1_10003

	for iter_35_0, iter_35_1 in var_1_10003(arg_35_0:GetOwnSkinListByShipId(var_35_0)) do
		if iter_35_1.id == arg_35_1 then
			return iter_35_1
		end
	end

	return nil
end

function var_0_1.SetSkinCurrentColor(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 == 0 then
		return
	end

	if arg_36_0:GetSkinData(arg_36_1) then
		var_3:SetCurrentColor(arg_36_2)
	end

	return
end

function var_0_1.GetSkinCurrentColor(arg_37_0, arg_37_1)
	if arg_37_1 == 0 then
		return 0
	end

	if arg_37_0:GetSkinData(arg_37_1) then
		return var_2:GetCurrentColor()
	end

	return 0
end

function var_0_1.CheckSkinColorIsOwned(arg_38_0, arg_38_1, arg_38_2)
	if not arg_38_0:GetSkinData(arg_38_1) then
		return false
	end

	return var_3:CheckColorOwned(arg_38_2)
end

function var_0_1.GetHasDressData(arg_39_0, arg_39_1)
	return arg_39_0.hasDressData[arg_39_1]
end

function var_0_1.SetDressHasRead(arg_40_0, arg_40_1)
	if not arg_40_0.hasDressData[arg_40_1] then
		return
	end

	arg_40_0.hasDressData[arg_40_1].read = 1

	return
end

function var_0_1.CheckRedDotByDressType(arg_41_0, arg_41_1)
	pairs = var_1_10002

	for iter_41_0, iter_41_1 in var_1_10002(arg_41_0.hasDressData) do
		if iter_41_1:getConfigTable().type == arg_41_1 and iter_41_1.read == 0 then
			return true
		end
	end

	return false
end

function var_0_1.GetCurDressIdByShipId(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0

	if not arg_42_0.shipWearDressData[arg_42_1] then
		var_42_0 = {}
	end

	ipairs = var_1_10004

	for iter_42_0, iter_42_1 in var_1_10004(var_42_0) do
		if iter_42_1:getConfigTable().type == arg_42_2 then
			return iter_42_1
		end
	end

	return nil
end

function var_0_1.DischargeDressOnShip(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0

	if not arg_43_0.shipWearDressData[arg_43_1] then
		var_43_0 = {}
	end

	local var_43_1 = -1

	ipairs = var_1_10005

	for iter_43_0, iter_43_1 in var_1_10005(var_43_0) do
		if iter_43_1.dress_id == arg_43_2 then
			var_43_1 = iter_43_0
		end
	end

	if var_43_1 ~= -1 then
		table = var_5

		var_5.remove(var_43_0, var_43_1)
	end

	arg_43_0.shipWearDressData[arg_43_1] = var_43_0

	return
end

function var_0_1.ChargeDressOnShip(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0

	if not arg_44_0.shipWearDressData[arg_44_1] then
		var_44_0 = {}
	end

	table = var_1_10004

	local var_44_1 = var_1_10004.insert
	local var_44_2 = var_44_0

	IslandShipDressItem = var_1_10006

	var_44_1(var_44_2, var_1_10006.New({
		ship_id = arg_44_1,
		dress_id = arg_44_2
	}))

	arg_44_0.shipWearDressData[arg_44_1] = var_44_0

	return
end

function var_0_1.GetShipHoldedDressDic(arg_45_0)
	return arg_45_0.shipWearDressData
end

function var_0_1.ResetShipSkillUsed(arg_46_0)
	pairs = var_1_10001

	for iter_46_0, iter_46_1 in var_1_10001(arg_46_0.ships) do
		local var_46_0 = iter_46_1:GetSkill()

		var_6.UpdateUsedToday(var_46_0, false)
	end

	return
end

return var_0_1
