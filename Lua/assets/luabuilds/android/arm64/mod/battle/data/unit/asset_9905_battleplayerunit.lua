ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local var_0_3 = ys.Battle.BattleAttr
local var_0_4 = ys.Battle.BattleConst
local var_0_5 = ys.Battle.BattleConst.EquipmentType
local var_0_6 = ys.Battle.BattleConfig

ys.Battle.BattlePlayerUnit = class("BattlePlayerUnit", ys.Battle.BattleUnit)
ys.Battle.BattlePlayerUnit.__name = "BattlePlayerUnit"

local var_0_7 = ys.Battle.BattlePlayerUnit

function ys.Battle.BattlePlayerUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._type = var_0_4.UnitType.PLAYER_UNIT

	return
end

function ys.Battle.BattlePlayerUnit:Retreat()
	var_0_7.super.Retreat(self)
	self:SetDeathReason(var_0_4.UnitDeathReason.LEAVE)
	self:DeacActionClear()
	self._battleProxy:ShutdownPlayerUnit(self:GetUniqueID())
	self._battleProxy:KillUnit(self:GetUniqueID())

	return
end

function ys.Battle.BattlePlayerUnit:DeadActionEvent()
	self:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.WILL_DIE, {}))
	self:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.SHUT_DOWN_PLAYER, {}))
	self._unitState:ChangeState(var_0_0.Battle.UnitState.STATE_DEAD)

	return
end

function ys.Battle.BattlePlayerUnit:IsSpectre()
	local var_4_0 = self:GetAttr()[var_0_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY] ~= nil and self:GetAttrByName(var_0_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY) or var_0_6.PLAYER_DEFAULT

	return var_4_0 <= var_0_6.SPECTRE_UNIT_TYPE, var_4_0
end

function ys.Battle.BattlePlayerUnit:InitCurrentHP(arg_5_1)
	self:SetCurrentHP(math.ceil(self:GetMaxHP() * arg_5_1))
	self:TriggerBuff(var_0_4.BuffEffectType.ON_HP_RATIO_UPDATE, {})

	return
end

function ys.Battle.BattlePlayerUnit.SetSkinId(arg_6_0, arg_6_1)
	arg_6_0._skinId = arg_6_1

	return
end

function ys.Battle.BattlePlayerUnit:GetSkinID()
	return self._skinId
end

function ys.Battle.BattlePlayerUnit:GetDefaultSkinID()
	return self._tmpData.skin_id
end

function ys.Battle.BattlePlayerUnit:ActionKeyOffsetUseable()
	return self._skinData.spine_action_offset
end

function ys.Battle.BattlePlayerUnit:GetShipName()
	return self._shipName or self._tmpData.name
end

function ys.Battle.BattlePlayerUnit.SetShipName(arg_11_0, arg_11_1)
	arg_11_0._shipName = arg_11_1

	return
end

function ys.Battle.BattlePlayerUnit:SetTemplate(arg_12_1, arg_12_2, arg_12_3)
	var_0_7.super.SetTemplate(self, arg_12_1)

	self._tmpData = var_0_1.GetPlayerShipTmpDataFromID(self._tmpID)

	self:configWeaponQueueParallel()
	self:overrideWeaponInfo()
	self:overrideSkin(self._skinId, true)
	self:InitCldComponent()

	arg_12_2.armorType = self._tmpData.armor_type
	arg_12_2.scale = self._tmpData.scale

	self:setAttrFromOutBattle(arg_12_2, arg_12_3)
	var_0_3.InitDOTAttr(self._attr, self._tmpData)

	self._personality = var_0_1.GetShipPersonality(2)

	for iter_12_0, iter_12_1 in ipairs(self._tmpData.tag_list) do
		self:AddLabelTag(iter_12_1)
	end

	self:setStandardLabelTag()

	return
end

function ys.Battle.BattlePlayerUnit.overrideSkin(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._skinData = var_0_1.GetPlayerShipSkinDataFromID(arg_13_1)

	local var_13_0 = {
		"prefab",
		"fx_container",
		"bound_bone",
		"smoke"
	}

	if arg_13_2 then
		var_13_0[#var_13_0 + 1] = "painting"
	end

	_.each(var_13_0, function(arg_14_0)
		arg_13_0._tmpData[arg_14_0] = arg_13_0._skinData[arg_14_0]

		return
	end)

	return
end

function ys.Battle.BattlePlayerUnit:overrideWeaponInfo(arg_15_1, arg_15_2)
	if self._overrideBaseInfo then
		self._tmpData.base_list = self._overrideBaseInfo
	end

	if self._overridePreloadInfo then
		self._tmpData.preload_count = self._overridePreloadInfo
	end

	return
end

function ys.Battle.BattlePlayerUnit.SetWeaponInfo(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._overrideBaseInfo = arg_16_1
	arg_16_0._overridePreloadInfo = arg_16_2

	return
end

function ys.Battle.BattlePlayerUnit.SetRarity(arg_17_0, arg_17_1)
	arg_17_0._rarity = arg_17_1

	return
end

function ys.Battle.BattlePlayerUnit.SetIntimacy(arg_18_0, arg_18_1)
	arg_18_0._intimacy = arg_18_1

	return
end

function ys.Battle.BattlePlayerUnit:setWeapon(arg_19_1)
	local var_19_0 = self._tmpData.base_list

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		if iter_19_1 and iter_19_1.skin and iter_19_1.skin ~= 0 and Equipment.IsOrbitSkin(iter_19_1.skin) then
			self._orbitSkinIDList = self._orbitSkinIDList or {}

			table.insert(self._orbitSkinIDList, iter_19_1.skin)
		end

		if iter_19_0 <= Ship.WEAPON_COUNT then
			local var_19_1 = self._proficiencyList[iter_19_0]
			local var_19_2 = self._tmpData.preload_count[iter_19_0]

			local function var_19_3(arg_20_0, arg_20_1, arg_20_2)
				for iter_20_0 = 1, var_19_0[iter_19_0] do
					local var_20_0 = self:AddWeapon(arg_20_0, arg_20_1, arg_20_2, var_19_1, iter_19_0)
					local var_20_1 = var_20_0:GetTemplateData().type

					if iter_20_0 <= var_19_2 and (var_20_1 == var_0_5.POINT_HIT_AND_LOCK or var_20_1 == var_0_5.MANUAL_MISSILE or var_20_1 == var_0_5.MANUAL_METEOR or var_20_1 == var_0_5.MANUAL_TORPEDO or var_20_1 == var_0_5.DISPOSABLE_TORPEDO) then
						var_20_0:SetModifyInitialCD()
					end

					if iter_19_1.equipment then
						var_20_0:SetSrcEquipmentID(iter_19_1.equipment.id)
					end
				end

				return
			end

			if iter_19_1.equipment and #iter_19_1.equipment.weapon_id > 0 then
				for iter_19_2, iter_19_3 in ipairs(iter_19_1.equipment.weapon_id) do
					local var_19_4 = var_0_6.EQUIPMENT_ACTIVE_LIMITED_BY_TYPE[var_0_1.GetWeaponPropertyDataFromID(iter_19_3).type]

					if (not var_19_4 or table.contains(var_19_4, self._tmpData.type)) and iter_19_3 and iter_19_3 ~= -1 then
						var_19_3(iter_19_3, iter_19_1.equipment.label, iter_19_1.skin)
					end
				end
			else
				var_19_3(self._tmpData.default_equip_list[iter_19_0], var_0_1.GetWeaponDataFromID(self._tmpData.default_equip_list[iter_19_0]).label)
			end
		end
	end

	for iter_19_4, iter_19_5 in ipairs(self._tmpData.fix_equip_list) do
		if iter_19_5 and iter_19_5 ~= -1 then
			self:AddWeapon(iter_19_5, nil, nil, self._proficiencyList[iter_19_4 + #self._tmpData.default_equip_list] or 1, iter_19_4 + #self._tmpData.default_equip_list):SetFixedFlag()
		end
	end

	if self:CanDoAntiSub() then
		local var_19_7 = {}

		for iter_19_6 = Ship.WEAPON_COUNT + 1, #arg_19_1 do
			if arg_19_1[iter_19_6] and arg_19_1[iter_19_6].equipment and #arg_19_1[iter_19_6].equipment.weapon_id > 0 then
				var_19_7[#var_19_7 + 1] = arg_19_1[iter_19_6].equipment.weapon_id[1]
			end
		end

		for iter_19_7, iter_19_8 in ipairs(self._tmpData.depth_charge_list) do
			var_19_7[#var_19_7 + 1] = iter_19_8
		end

		for iter_19_9, iter_19_10 in ipairs(var_19_7) do
			self:AddAutoWeapon((var_0_1.CreateWeaponUnit(iter_19_10, self, 1, 20)))
		end
	end

	return
end

function ys.Battle.BattlePlayerUnit:SetPriorityWeaponSkin(arg_21_1)
	self._priorityWeaponSkinID = self._priorityWeaponSkinID or arg_21_1

	return
end

function ys.Battle.BattlePlayerUnit:GetPriorityWeaponSkin()
	return self._priorityWeaponSkinID
end

function ys.Battle.BattlePlayerUnit:AddWeapon(arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
	local var_23_0 = var_0_1.CreateWeaponUnit(arg_23_1, self, arg_23_4, arg_23_5)

	self._totalWeapon[#self._totalWeapon + 1] = var_23_0

	if arg_23_2 then
		var_23_0:SetEquipmentLabel(arg_23_2)
	end

	local var_23_1 = var_23_0:GetTemplateData().type

	if var_23_1 == var_0_5.POINT_HIT_AND_LOCK or var_23_1 == var_0_5.MANUAL_METEOR or var_23_1 == var_0_5.MANUAL_MISSILE or var_23_1 == var_0_5.POINT_AIR_STRIKE then
		self._chargeList[#self._chargeList + 1] = var_23_0

		self._weaponQueue:AppendChargeWeapon(var_23_0)
	elseif var_23_1 == var_0_5.MANUAL_TORPEDO or var_23_1 == var_0_5.DISPOSABLE_TORPEDO or var_23_1 == var_0_5.MANUAL_AAMISSILE then
		self._manualTorpedoList[#self._manualTorpedoList + 1] = var_23_0

		self._weaponQueue:AppendManualTorpedo(var_23_0)
	elseif var_23_1 == var_0_5.STRIKE_AIRCRAFT then
		-- block empty
	elseif var_23_1 == var_0_5.FLEET_ANTI_AIR then
		self:AddFleetAntiAirWeapon(var_23_0)
	elseif var_23_1 == var_0_5.FLEET_RANGE_ANTI_AIR then
		self:AddFleetRangeAntiAirWeapon(var_23_0)
	else
		self:AddAutoWeapon(var_23_0)
	end

	if var_23_1 == var_0_5.STRIKE_AIRCRAFT then
		self._hiveList[#self._hiveList + 1] = var_23_0
	end

	if var_23_1 == var_0_5.ANTI_AIR then
		self._AAList[#self._AAList + 1] = var_23_0
	end

	if arg_23_3 and arg_23_3 ~= 0 then
		var_23_0:SetSkinData(arg_23_3)
		self:SetPriorityWeaponSkin(arg_23_3)
	end

	return var_23_0
end

function ys.Battle.BattlePlayerUnit:RemoveWeapon(arg_24_1)
	local var_24_0 = var_0_1.GetWeaponPropertyDataFromID(arg_24_1).type
	local var_24_1

	if var_24_0 == var_0_5.STRIKE_AIRCRAFT then
		for iter_24_0, iter_24_1 in ipairs(self._hiveList) do
			if iter_24_1:GetWeaponId() == arg_24_1 then
				var_24_1 = iter_24_1

				table.remove(self._hiveList, iter_24_0)

				break
			end
		end
	elseif var_24_0 == var_0_5.POINT_HIT_AND_LOCK or var_24_0 == var_0_5.MANUAL_METEOR or var_24_0 == var_0_5.MANUAL_MISSILE then
		-- block empty
	elseif var_24_0 == var_0_5.MANUAL_TORPEDO then
		for iter_24_2, iter_24_3 in ipairs(self._manualTorpedoList) do
			if iter_24_3:GetWeaponId() == arg_24_1 then
				var_24_1 = iter_24_3

				table.remove(self._manualTorpedoList, iter_24_2)
				self._weaponQueue:RemoveManualTorpedo(iter_24_3)

				break
			end
		end
	elseif var_24_0 == var_0_5.FLEET_ANTI_AIR then
		for iter_24_4, iter_24_5 in ipairs(self._fleetAAList) do
			if iter_24_5:GetWeaponId() == arg_24_1 then
				self:RemoveFleetAntiAirWeapon(iter_24_5)

				break
			end
		end
	else
		for iter_24_6, iter_24_7 in ipairs(self._autoWeaponList) do
			if iter_24_7:GetWeaponId() == arg_24_1 then
				var_24_1 = iter_24_7

				iter_24_7:Clear()
				self:RemoveAutoWeapon(var_24_1)

				break
			end
		end
	end

	if var_24_1 then
		for iter_24_8, iter_24_9 in ipairs(self._totalWeapon) do
			if iter_24_9 == var_24_1 then
				table.remove(self._totalWeapon, iter_24_8)

				break
			end
		end
	end

	return var_24_1
end

function ys.Battle.BattlePlayerUnit:RemoveWeaponByLabel(arg_25_1)
	local var_25_0

	for iter_25_0, iter_25_1 in ipairs(self._totalWeapon) do
		local var_25_1 = true

		for iter_25_2, iter_25_3 in ipairs(arg_25_1) do
			var_25_1 = var_25_1 and table.contains(iter_25_1:GetEquipmentLabel(), iter_25_3)
		end

		if var_25_1 then
			var_25_0 = iter_25_1

			table.remove(self._totalWeapon, iter_25_0)
		end
	end

	if not var_25_0 then
		return
	end

	local var_25_2 = var_25_0:GetType()

	if var_25_2 == var_0_5.STRIKE_AIRCRAFT then
		for iter_25_4, iter_25_5 in ipairs(self._hiveList) do
			if var_25_0 == iter_25_5 then
				table.remove(self._hiveList, iter_25_4)

				break
			end
		end
	elseif var_25_2 == var_0_5.POINT_HIT_AND_LOCK or var_25_2 == var_0_5.MANUAL_METEOR or var_25_2 == var_0_5.MANUAL_MISSILE then
		-- block empty
	elseif var_25_2 == var_0_5.MANUAL_TORPEDO then
		for iter_25_6, iter_25_7 in ipairs(self._manualTorpedoList) do
			if var_25_0 == iter_25_7 then
				table.remove(self._manualTorpedoList, iter_25_6)
				self._weaponQueue:RemoveManualTorpedo(iter_25_7)

				break
			end
		end
	elseif var_25_2 == var_0_5.FLEET_ANTI_AIR then
		for iter_25_8, iter_25_9 in ipairs(self._fleetAAList) do
			if var_25_0 == iter_25_9 then
				self:RemoveFleetAntiAirWeapon(iter_25_9)

				break
			end
		end
	elseif var_25_2 == var_0_5.INTERCEPT_AIRCRAFT then
		for iter_25_10, iter_25_11 in ipairs(self._autoWeaponList) do
			if var_25_0 == iter_25_11 then
				self:RemoveAutoWeapon(var_25_0)

				break
			end
		end
	else
		for iter_25_12, iter_25_13 in ipairs(self._autoWeaponList) do
			if var_25_0 == iter_25_13 then
				self:RemoveAutoWeapon(var_25_0)

				break
			end
		end
	end

	return var_25_0
end

function ys.Battle.BattlePlayerUnit:AddFleetAntiAirWeapon(arg_26_1)
	self._fleetAAList[#self._fleetAAList + 1] = arg_26_1

	if self._fleet and self._fleet:GetFleetAntiAirWeapon() then
		self._fleet:GetFleetAntiAirWeapon():FlushCrewUnit(self)
	end

	return
end

function ys.Battle.BattlePlayerUnit:RemoveFleetAntiAirWeapon(arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(self._fleetAAList) do
		if iter_27_1 == arg_27_1 then
			table.remove(self._fleetAAList, iter_27_0)

			return
		end
	end

	self._fleet:GetFleetAntiAirWeapon():FlushCrewUnit(self)

	return
end

function ys.Battle.BattlePlayerUnit:AddFleetRangeAntiAirWeapon(arg_28_1)
	self._fleetRangeAAList[#self._fleetRangeAAList + 1] = arg_28_1

	return
end

function ys.Battle.BattlePlayerUnit:RemoveFleetRangeAntiAirWeapon(arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(self._fleetRangeAAList) do
		if iter_29_1 == arg_29_1 then
			table.remove(self._fleetRangeAAList, iter_29_0)

			return
		end
	end

	return
end

function ys.Battle.BattlePlayerUnit.ShiftWeapon(arg_30_0, arg_30_1)
	return
end

function ys.Battle.BattlePlayerUnit:GetManualWeaponParallel()
	return self._tmpData.parallel_max
end

function ys.Battle.BattlePlayerUnit:CeaseAllWeapon(arg_32_1)
	if arg_32_1 then
		for iter_32_0, iter_32_1 in ipairs(self._totalWeapon) do
			iter_32_1:Cease()
		end

		for iter_32_2, iter_32_3 in pairs(self._buffList) do
			iter_32_3:Interrupt()
		end
	end

	var_0_7.super.CeaseAllWeapon(self, arg_32_1)

	return
end

function ys.Battle.BattlePlayerUnit:LeaderSetting()
	local var_33_0 = var_0_1.GetWords(self:GetSkinID(), "hp_warning", (self:GetIntimacy()))

	if var_33_0 and var_33_0 ~= "" then
		self._warningValue = var_0_6.WARNING_HP_RATE * self:GetMaxHP()
	end

	return
end

function ys.Battle.BattlePlayerUnit:UpdateHP(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	if self._warningValue and self._currentHP < self._warningValue and not isHeal then
		self._warningValue = nil

		self:DispatchVoice("hp_warning")
		self:DispatchChat(var_0_1.GetWords(self:GetSkinID(), "hp_warning", (self:GetIntimacy())), 2.5, "hp_warning")
	end

	if self._mainUnitWarningValue and self._currentHP < self._mainUnitWarningValue and self._currentHP > 0 and not isHeal then
		self._mainUnitWarningValue = nil

		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_main_emergent", self:GetShipName()))
	end

	return (var_0_7.super.UpdateHP(self, arg_34_1, arg_34_2, arg_34_3, arg_34_4))
end

function ys.Battle.BattlePlayerUnit:SetMainFleetUnit()
	var_0_7.super.SetMainFleetUnit(self)

	if self._IFF == var_0_6.FRIENDLY_CODE then
		self._mainUnitWarningValue = var_0_6.WARNING_HP_RATE_MAIN * self:GetMaxHP()
	end

	return
end

function ys.Battle.BattlePlayerUnit.UpdatePrecastMoveLimit(arg_36_0)
	return
end

function ys.Battle.BattlePlayerUnit:setStandardLabelTag()
	var_0_7.super.setStandardLabelTag(self)

	local var_37_0 = self:GetManualWeaponParallel()

	while #var_37_0 > 0 do
		if var_37_0[#var_37_0] > 1 then
			print(var_0_4.PARALLEL_LABEL_TAG[#var_37_0])
			self:AddLabelTag(var_0_4.PARALLEL_LABEL_TAG[#var_37_0])
		end
	end

	return
end

function ys.Battle.BattlePlayerUnit:ConfigBubbleFX()
	self._bubbleFX = var_0_6.PLAYER_SUB_BUBBLE_FX

	self._oxyState:SetBubbleTemplate(var_0_6.PLAYER_SUB_BUBBLE_INIT, var_0_6.PLAYER_SUB_BUBBLE_INTERVAL)

	return
end

function ys.Battle.BattlePlayerUnit:OxyConsume()
	var_0_7.super.OxyConsume(self)

	if self._currentOxy <= 0 then
		self._fleet:ChangeSubmarineState(var_0_0.Battle.OxyState.STATE_FREE_FLOAT, true)
	end

	return
end

function ys.Battle.BattlePlayerUnit.SetFormationIndex(arg_40_0, arg_40_1)
	arg_40_0._formationIndex = arg_40_1

	return
end

function ys.Battle.BattlePlayerUnit.setAttrFromOutBattle(arg_41_0, arg_41_1, arg_41_2)
	var_0_3.SetPlayerAttrFromOutBattle(arg_41_0, arg_41_1, arg_41_2)

	return
end

function ys.Battle.BattlePlayerUnit:SetFleetVO(arg_42_1)
	self._fleet = arg_42_1
	self._subRaidLine, self._subRetreatLine = self._fleet:GetSubmarineBaseLine()

	return
end

function ys.Battle.BattlePlayerUnit:GetTemplate()
	return self._tmpData
end

function ys.Battle.BattlePlayerUnit:GetGroupID()
	return var_0_1.GetPlayerShipModelFromID((self:GetTemplateID())).group_type
end

function ys.Battle.BattlePlayerUnit:GetRarity()
	return self._rarity or self._tmpData.rarity
end

function ys.Battle.BattlePlayerUnit:GetIntimacy()
	return self._intimacy or 0
end

function ys.Battle.BattlePlayerUnit:GetAutoPilotPreference()
	return self._personality
end

function ys.Battle.BattlePlayerUnit:GetFleetVO()
	return self._fleet
end

function ys.Battle.BattlePlayerUnit:InitCldComponent()
	var_0_7.super.InitCldComponent(self)
	self._cldComponent:SetCldData({
		type = var_0_4.CldType.SHIP,
		IFF = self:GetIFF(),
		UID = self:GetUniqueID(),
		Mass = var_0_4.CldMass.L2
	})

	return
end

function ys.Battle.BattlePlayerUnit:AddPointAirStrike(arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = self:AddWeapon(arg_50_1, {}, nil, 1, -1)

	self:GetFleetVO():GetChargeWeaponVO():AppendWeapon(var_50_0)

	if arg_50_3 then
		var_50_0:OverHeat()
		var_50_0:EnterCoolDown()
	end

	self:GetFleetVO():GetChargeWeaponVO():DispatchCountChange()
	self:DispatchEvent(var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CREATE_POINT_AIR_STRIKE, {
		weapon = var_50_0
	}))

	return var_50_0
end

return
