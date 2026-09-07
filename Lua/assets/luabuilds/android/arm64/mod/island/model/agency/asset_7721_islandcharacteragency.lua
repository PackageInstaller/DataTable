local IslandCharacterAgency = class("IslandCharacterAgency", import(".IslandBaseAgency"))

IslandCharacterAgency.ADD_SHIP = "IslandCharacterAgency:ADD_SHIP"
IslandCharacterAgency.SHIP_LEVEL_UP = "IslandCharacterAgency:SHIP_LEVEL_UP"
IslandCharacterAgency.SHIP_GET_STATE = "IslandCharacterAgency:SHIP_GET_STATE"
IslandCharacterAgency.CHANGE_CHARACTER_DRESS = "IslandCharacterAgency:CHANGE_CHARACTER_DRESS"
IslandCharacterAgency.SHIP_SKILL_STATE_CHANGE = "IslandCharacterAgency:SHIP_SKILL_STATE_CHANGE"
IslandCharacterAgency.NPC_CONFIG_ID = 1

function IslandCharacterAgency:OnInit(arg_1_1)
	self.inviteList = {}
	self.ships = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.ship_sys.invite_list or {}) do
		table.insert(self.inviteList, iter_1_1)
	end

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.ship_sys.ship_list or {}) do
		local var_1_0 = IslandShip.New(iter_1_3)

		self.ships[var_1_0.id] = var_1_0
	end

	local var_1_1 = IslandNpcShip.New({
		id = IslandCharacterAgency.NPC_CONFIG_ID
	})

	self.ships[var_1_1.id] = var_1_1
	self.hasDressData = {}

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.ship_sys.had_dress or {}) do
		self.hasDressData[iter_1_5.id] = IslandOwnedDressItem.New(iter_1_5)
	end

	self.read_list = arg_1_1.ship_sys.read_list
	self.shipSkinDic = {}

	for iter_1_6, iter_1_7 in ipairs(arg_1_1.ship_sys.skin_list) do
		local var_1_2 = self.shipSkinDic[iter_1_7.ship_id] or {}

		for iter_1_8, iter_1_9 in ipairs(iter_1_7.skin_list) do
			table.insert(var_1_2, IslandShipSkin.New(iter_1_9))
		end

		self.shipSkinDic[iter_1_7.ship_id] = var_1_2
	end

	self.shipWearDressData = {}

	for iter_1_10, iter_1_11 in ipairs(arg_1_1.ship_sys.wear_list or {}) do
		local var_1_3 = self.shipWearDressData[iter_1_11.ship_id] or {}

		table.insert(var_1_3, IslandShipDressItem.New(iter_1_11))

		self.shipWearDressData[iter_1_11.ship_id] = var_1_3
	end

	self.gameViewIDList = {}

	for iter_1_12, iter_1_13 in ipairs(arg_1_1.ship_sys.game_ship_list) do
		self.gameViewIDList[iter_1_13.game_type] = iter_1_13.ship_id
	end

	return
end

function IslandCharacterAgency:SetMiniGameShipViewId(arg_2_1, arg_2_2)
	self.gameViewIDList[arg_2_1] = arg_2_2

	return
end

function IslandCharacterAgency:GetViewGameShipViewId(arg_3_1)
	return self.gameViewIDList[arg_3_1]
end

function IslandCharacterAgency:CanFollowPlayer(arg_4_1)
	local var_4_0 = self.ships[arg_4_1]

	if not self.ships[arg_4_1] then
		return false
	end

	local var_4_1 = var_4_0:GetCantFollowTaskIdList()
	local var_4_2 = false

	if #var_4_1 > 0 then
		local var_4_3 = self:GetHost():GetTaskAgency()

		var_4_2 = _.any(var_4_1, function(arg_5_0)
			return var_4_3:GetTask(arg_5_0) ~= nil
		end)
	end

	return var_4_0:GetState() == IslandShip.STATE_NORMAL and not var_4_2
end

function IslandCharacterAgency:GetInviteList()
	return self.inviteList
end

function IslandCharacterAgency:AddInvite(arg_7_1)
	table.insert(self.inviteList, arg_7_1)

	return
end

function IslandCharacterAgency:HasInvite(arg_8_1)
	return _.any(self.inviteList, function(arg_9_0)
		return arg_8_1 == arg_9_0
	end)
end

function IslandCharacterAgency:RemoveInvite(arg_10_1)
	table.removebyvalue(self.inviteList, arg_10_1)

	return
end

function IslandCharacterAgency:GetShips()
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in pairs(self.ships) do
		if iter_11_1.id ~= IslandCharacterAgency.NPC_CONFIG_ID then
			table.insert(var_11_0, iter_11_1)
		end
	end

	return var_11_0
end

function IslandCharacterAgency:GetShipsContainNpc()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.ships) do
		table.insert(var_12_0, iter_12_1)
	end

	return var_12_0
end

function IslandCharacterAgency:AddShip(arg_13_1)
	self.ships[arg_13_1.id] = arg_13_1

	self:DispatchEvent(IslandCharacterAgency.ADD_SHIP, arg_13_1)

	return
end

function IslandCharacterAgency:GetShipById(arg_14_1)
	return self.ships[arg_14_1]
end

function IslandCharacterAgency:GetUnlockOrCanUnlockShipConfigIds()
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(pg.island_chara_template.all) do
		if iter_15_1 ~= IslandCharacterAgency.NPC_CONFIG_ID and (self.ships[iter_15_1] or self:HasInvite(iter_15_1)) then
			table.insert(var_15_0, iter_15_1)
		end
	end

	table.sort(var_15_0, CompareFuncs({
		function(arg_16_0)
			return self.ships[arg_16_0] and 0 or 1
		end,
		function(arg_17_0)
			return arg_17_0
		end
	}))

	return var_15_0
end

function IslandCharacterAgency:GetUnlockOrCanUnlockShipConfigIdsContainNpc()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(pg.island_chara_template.all) do
		if self.ships[iter_18_1] or self:HasInvite(iter_18_1) then
			table.insert(var_18_0, iter_18_1)
		end
	end

	table.sort(var_18_0, CompareFuncs({
		function(arg_19_0)
			return self.ships[arg_19_0] and 0 or 1
		end,
		function(arg_20_0)
			return arg_20_0
		end
	}))

	return var_18_0
end

function IslandCharacterAgency:GetAllSkinCnt()
	local var_21_0 = 0

	for iter_21_0, iter_21_1 in pairs(self.shipSkinDic) do
		var_21_0 = var_21_0 + #iter_21_1
	end

	return var_21_0
end

function IslandCharacterAgency:GetOwnSkinListByShipId(arg_22_1)
	return self.shipSkinDic[arg_22_1] or {}
end

function IslandCharacterAgency:AddSkin(arg_23_1)
	local var_23_0 = self.shipSkinDic[pg.island_skin_template[arg_23_1].ship_group] or {}

	table.insert(var_23_0, IslandShipSkin.New({
		color_id = 0,
		id = arg_23_1,
		color_list = {}
	}))

	self.shipSkinDic[pg.island_skin_template[arg_23_1].ship_group] = var_23_0

	return
end

function IslandCharacterAgency:AddSkinColor(arg_24_1, arg_24_2, arg_24_3)
	for iter_24_0, iter_24_1 in ipairs(self.shipSkinDic[arg_24_1] or {}) do
		if iter_24_1.id == arg_24_2 then
			iter_24_1:AddSkinColor(arg_24_3)
		end
	end

	return
end

function IslandCharacterAgency:GetCurrentSkinColorByShipId(arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in ipairs(self.shipSkinDic[arg_25_1] or {}) do
		if iter_25_1.id == arg_25_2 then
			return iter_25_1.color_id
		end
	end

	return 0
end

function IslandCharacterAgency:GetAllOwnDressDic()
	return self.hasDressData
end

function IslandCharacterAgency:GetDiffDressCnt()
	return #underscore.keys(self.hasDressData)
end

function IslandCharacterAgency:GetDiffDressCntByType(arg_28_1)
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(self.hasDressData) do
		if pg.island_dress_template[iter_28_0].type == arg_28_1 and not table.contains(var_28_0, iter_28_0) then
			table.insert(var_28_0, iter_28_0)
		end
	end

	return #var_28_0
end

function IslandCharacterAgency:ExistDressId(arg_29_1)
	return self.hasDressData[arg_29_1] ~= nil
end

function IslandCharacterAgency:GetDressIdRealCount(arg_30_1)
	local var_30_0 = self:GetOwnDressCountByDressId()

	for iter_30_0, iter_30_1 in pairs(self.shipWearDressData) do
		for iter_30_2, iter_30_3 in ipairs(iter_30_1) do
			if iter_30_3.dress_id == arg_30_1 then
				var_30_0 = var_30_0 + 1
			end
		end
	end

	return var_30_0
end

function IslandCharacterAgency:GetOwnDressCountByDressId(arg_31_1)
	return (self.hasDressData[arg_31_1] or nil) and (self.hasDressData[arg_31_1].num or 0)
end

function IslandCharacterAgency:AddDressItem(arg_32_1, arg_32_2, arg_32_3)
	if not self.hasDressData[arg_32_1] then
		self.hasDressData[arg_32_1] = IslandOwnedDressItem.New({
			id = arg_32_1,
			num = arg_32_2,
			read = arg_32_3 and 0 or 1
		})
	else
		self.hasDressData[arg_32_1].num = self.hasDressData[arg_32_1].num + arg_32_2

		if arg_32_3 then
			self.hasDressData[arg_32_1].read = 1
		end
	end

	return
end

function IslandCharacterAgency:ReduceDressItem(arg_33_1, arg_33_2)
	if not self.hasDressData[arg_33_1] then
		return
	end

	self.hasDressData[arg_33_1].num = self.hasDressData[arg_33_1].num - arg_33_2

	return
end

function IslandCharacterAgency:CheckSkinIsOwned(arg_34_1)
	if arg_34_1 == 0 then
		return true
	end

	for iter_34_0, iter_34_1 in pairs(self:GetOwnSkinListByShipId(pg.island_skin_template[arg_34_1].ship_group)) do
		if iter_34_1.id == arg_34_1 then
			return true
		end
	end

	return false
end

function IslandCharacterAgency:GetSkinData(arg_35_1)
	if arg_35_1 == 0 then
		return nil
	end

	for iter_35_0, iter_35_1 in pairs(self:GetOwnSkinListByShipId(pg.island_skin_template[arg_35_1].ship_group)) do
		if iter_35_1.id == arg_35_1 then
			return iter_35_1
		end
	end

	return nil
end

function IslandCharacterAgency:SetSkinCurrentColor(arg_36_1, arg_36_2)
	if arg_36_1 == 0 then
		return
	end

	local var_36_0 = self:GetSkinData(arg_36_1)

	if var_36_0 then
		var_36_0:SetCurrentColor(arg_36_2)
	end

	return
end

function IslandCharacterAgency:GetSkinCurrentColor(arg_37_1)
	if arg_37_1 == 0 then
		return 0
	end

	local var_37_0 = self:GetSkinData(arg_37_1)

	if var_37_0 then
		return var_37_0:GetCurrentColor()
	end

	return 0
end

function IslandCharacterAgency:CheckSkinColorIsOwned(arg_38_1, arg_38_2)
	local var_38_0 = self:GetSkinData(arg_38_1)

	if not var_38_0 then
		return false
	end

	return var_38_0:CheckColorOwned(arg_38_2)
end

function IslandCharacterAgency:GetHasDressData(arg_39_1)
	return self.hasDressData[arg_39_1]
end

function IslandCharacterAgency:SetDressHasRead(arg_40_1)
	if not self.hasDressData[arg_40_1] then
		return
	end

	self.hasDressData[arg_40_1].read = 1

	return
end

function IslandCharacterAgency:CheckRedDotByDressType(arg_41_1)
	for iter_41_0, iter_41_1 in pairs(self.hasDressData) do
		if iter_41_1:getConfigTable().type == arg_41_1 and iter_41_1.read == 0 then
			return true
		end
	end

	return false
end

function IslandCharacterAgency:GetCurDressIdByShipId(arg_42_1, arg_42_2)
	for iter_42_0, iter_42_1 in ipairs(self.shipWearDressData[arg_42_1] or {}) do
		if iter_42_1:getConfigTable().type == arg_42_2 then
			return iter_42_1
		end
	end

	return nil
end

function IslandCharacterAgency:DischargeDressOnShip(arg_43_1, arg_43_2)
	local var_43_0 = self.shipWearDressData[arg_43_1] or {}
	local var_43_1 = -1

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if iter_43_1.dress_id == arg_43_2 then
			var_43_1 = iter_43_0
		end
	end

	if var_43_1 ~= -1 then
		table.remove(var_43_0, var_43_1)
	end

	self.shipWearDressData[arg_43_1] = var_43_0

	return
end

function IslandCharacterAgency:ChargeDressOnShip(arg_44_1, arg_44_2)
	local var_44_0 = self.shipWearDressData[arg_44_1] or {}

	table.insert(var_44_0, IslandShipDressItem.New({
		ship_id = arg_44_1,
		dress_id = arg_44_2
	}))

	self.shipWearDressData[arg_44_1] = var_44_0

	return
end

function IslandCharacterAgency:GetShipHoldedDressDic()
	return self.shipWearDressData
end

function IslandCharacterAgency:ResetShipSkillUsed()
	for iter_46_0, iter_46_1 in pairs(self.ships) do
		iter_46_1:GetSkill():UpdateUsedToday(false)
	end

	return
end

return IslandCharacterAgency
