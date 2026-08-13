ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleDataFunction
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleAttr
local var_0_4 = var_0.Battle.BattleConst.EquipmentType
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle

class = var_0_10008
var_0_6.BattlePlayerUnit = var_0_10008("BattlePlayerUnit", var_0.Battle.BattleUnit)
var_0.Battle.BattlePlayerUnit.__name = "BattlePlayerUnit"

local var_0_7 = var_0.Battle.BattlePlayerUnit

function var_0_7.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._type = var_0.UnitType.PLAYER_UNIT

	return
end

function var_0_7.Retreat(arg_2_0)
	var_0_7.super.Retreat(arg_2_0)
	arg_2_0:SetDeathReason(var_0.UnitDeathReason.LEAVE)
	arg_2_0:DeacActionClear()

	local var_2_0 = arg_2_0._battleProxy

	var_1.ShutdownPlayerUnit(var_2_0, arg_2_0:GetUniqueID())

	local var_2_1 = arg_2_0._battleProxy

	var_1.KillUnit(var_2_1, arg_2_0:GetUniqueID())

	return
end

function var_0_7.DeadActionEvent(arg_3_0)
	arg_3_0:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.WILL_DIE, {}))
	arg_3_0:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.SHUT_DOWN_PLAYER, {}))

	local var_3_0 = arg_3_0._unitState

	var_1.ChangeState(var_3_0, var_0.Battle.UnitState.STATE_DEAD)

	return
end

function var_0_7.IsSpectre(arg_4_0)
	local var_4_0
	local var_4_1 = var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY

	if arg_4_0:GetAttr()[var_4_1] ~= nil then
		var_4_0 = arg_4_0:GetAttrByName(var_4_1)
	else
		var_4_0 = var_0_5.PLAYER_DEFAULT
	end

	return var_4_0 <= var_0_5.SPECTRE_UNIT_TYPE, var_4_0
end

function var_0_7.InitCurrentHP(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.SetCurrentHP

	math = var_1_10004

	var_5_1(var_5_0, var_1_10004.ceil(arg_5_0:GetMaxHP() * arg_5_1))
	arg_5_0:TriggerBuff(var_0.BuffEffectType.ON_HP_RATIO_UPDATE, {})

	return
end

function var_0_7.SetSkinId(arg_6_0, arg_6_1)
	arg_6_0._skinId = arg_6_1

	return
end

function var_0_7.GetSkinID(arg_7_0)
	return arg_7_0._skinId
end

function var_0_7.GetDefaultSkinID(arg_8_0)
	return arg_8_0._tmpData.skin_id
end

function var_0_7.ActionKeyOffsetUseable(arg_9_0)
	return arg_9_0._skinData.spine_action_offset
end

function var_0_7.GetShipName(arg_10_0)
	local var_10_0

	if not arg_10_0._shipName then
		var_10_0 = arg_10_0._tmpData.name
	end

	return var_10_0
end

function var_0_7.SetShipName(arg_11_0, arg_11_1)
	arg_11_0._shipName = arg_11_1

	return
end

function var_0_7.SetTemplate(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	var_0_7.super.SetTemplate(arg_12_0, arg_12_1)

	arg_12_0._tmpData = var_0_1.GetPlayerShipTmpDataFromID(arg_12_0._tmpID)

	arg_12_0:configWeaponQueueParallel()
	arg_12_0:overrideWeaponInfo()
	arg_12_0:overrideSkin(arg_12_0._skinId, true)
	arg_12_0:InitCldComponent()

	arg_12_2.armorType = arg_12_0._tmpData.armor_type
	arg_12_2.scale = arg_12_0._tmpData.scale

	arg_12_0:setAttrFromOutBattle(arg_12_2, arg_12_3)
	var_0_3.InitDOTAttr(arg_12_0._attr, arg_12_0._tmpData)

	arg_12_0._personality = var_0_1.GetShipPersonality(2)
	ipairs = var_4

	for iter_12_0, iter_12_1 in var_4(arg_12_0._tmpData.tag_list) do
		arg_12_0:AddLabelTag(iter_12_1)
	end

	arg_12_0:setStandardLabelTag()

	return
end

function var_0_7.overrideSkin(arg_13_0, arg_13_1, arg_13_2)
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

	_ = var_4

	var_4.each(var_13_0, function(arg_14_0)
		arg_13_0._tmpData[arg_14_0] = arg_13_0._skinData[arg_14_0]

		return
	end)

	return
end

function var_0_7.overrideWeaponInfo(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0._overrideBaseInfo then
		arg_15_0._tmpData.base_list = arg_15_0._overrideBaseInfo
	end

	if arg_15_0._overridePreloadInfo then
		arg_15_0._tmpData.preload_count = arg_15_0._overridePreloadInfo
	end

	return
end

function var_0_7.SetWeaponInfo(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._overrideBaseInfo = arg_16_1
	arg_16_0._overridePreloadInfo = arg_16_2

	return
end

function var_0_7.SetRarity(arg_17_0, arg_17_1)
	arg_17_0._rarity = arg_17_1

	return
end

function var_0_7.SetIntimacy(arg_18_0, arg_18_1)
	arg_18_0._intimacy = arg_18_1

	return
end

function var_0_7.setWeapon(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0._tmpData.default_equip_list
	local var_19_1 = arg_19_0._tmpData.base_list
	local var_19_2 = arg_19_0._proficiencyList
	local var_19_3 = arg_19_0._tmpData.preload_count

	ipairs = var_1_10006

	for iter_19_0, iter_19_1 in var_1_10006(arg_19_1) do
		if iter_19_1 and iter_19_1.skin and iter_19_1.skin ~= 0 then
			Equipment = var_1_10011

			if var_1_10011.IsOrbitSkin(iter_19_1.skin) then
				if not arg_19_0._orbitSkinIDList then
					var_1_10011 = {}
				end

				arg_19_0._orbitSkinIDList = var_1_10011
				table = var_1_10011

				var_1_10011.insert(arg_19_0._orbitSkinIDList, iter_19_1.skin)
			end
		end

		Ship = var_1_10011

		if iter_19_0 <= var_1_10011.WEAPON_COUNT then
			var_1_10011 = var_19_2[iter_19_0]

			local var_19_4 = var_19_3[iter_19_0]

			local function var_19_5(arg_20_0, arg_20_1, arg_20_2)
				local var_20_0 = var_19_1[iter_19_0]

				for iter_20_0 = 1, var_20_0 do
					local var_20_1 = arg_19_0
					local var_20_2 = var_8.AddWeapon(var_20_1, arg_20_0, arg_20_1, arg_20_2, var_1_10011, iter_19_0)
					local var_20_3 = var_8.GetTemplateData(var_20_2).type

					if iter_20_0 <= var_19_4 and (var_20_3 == var_0_4.POINT_HIT_AND_LOCK or var_20_3 == var_0_4.MANUAL_MISSILE or var_20_3 == var_0_4.MANUAL_METEOR or var_20_3 == var_0_4.MANUAL_TORPEDO or var_20_3 == var_0_4.DISPOSABLE_TORPEDO) then
						var_8:SetModifyInitialCD()
					end

					if iter_19_1.equipment then
						var_8:SetSrcEquipmentID(iter_19_1.equipment.id)
					end
				end

				return
			end

			if iter_19_1.equipment then
				local var_19_6 = #iter_19_1.equipment.weapon_id

				if 0 < var_19_6 then
					local var_19_7 = iter_19_1.equipment.weapon_id

					ipairs = var_15

					for iter_19_2, iter_19_3 in var_15(var_19_7) do
						local var_19_8 = var_0_1.GetWeaponPropertyDataFromID(iter_19_3).type

						if var_0_5.EQUIPMENT_ACTIVE_LIMITED_BY_TYPE[var_19_8] then
							table = var_1_10022

							if var_1_10022.contains(var_21, arg_19_0._tmpData.type) then
								if iter_19_3 and iter_19_3 ~= -1 then
									var_19_5(iter_19_3, iter_19_1.equipment.label, iter_19_1.skin)
								end
							end
						end
					end

					goto label_19_0
				end
			end

			do
				local var_19_9 = var_19_0[iter_19_0]
				local var_19_10 = var_0_1.GetWeaponDataFromID(var_19_9)

				var_19_5(var_19_9, var_19_10.label)
			end

			::label_19_0::
		end
	end

	local var_19_11 = #var_19_0
	local var_19_12 = arg_19_0._tmpData.fix_equip_list

	ipairs = var_8

	for iter_19_4, iter_19_5 in var_8(var_19_12) do
		if iter_19_5 and iter_19_5 ~= -1 then
			local var_19_13

			if not var_19_2[iter_19_4 + var_19_11] then
				var_19_13 = 1
			end

			local var_19_14 = arg_19_0:AddWeapon(iter_19_5, nil, nil, var_19_13, iter_19_4 + var_19_11)

			var_14.SetFixedFlag(var_19_14)
		end
	end

	local var_19_15 = arg_19_0

	if arg_19_0.CanDoAntiSub(var_19_15) then
		local var_19_16 = {}

		Ship = var_19_15

		for iter_19_6 = var_19_15.WEAPON_COUNT + 1, #arg_19_1 do
			if arg_19_1[iter_19_6] and var_13.equipment and #var_13.equipment.weapon_id > 0 then
				var_19_16[#var_19_16 + 1] = var_13.equipment.weapon_id[1]
			end
		end

		ipairs = var_9

		for iter_19_7, iter_19_8 in var_9(arg_19_0._tmpData.depth_charge_list) do
			var_19_16[#var_19_16 + 1] = iter_19_8
		end

		local var_19_17 = 20
		local var_19_18 = 1

		ipairs = var_11

		for iter_19_9, iter_19_10 in var_11(var_19_16) do
			local var_19_19 = var_0_1.CreateWeaponUnit(iter_19_10, arg_19_0, var_19_18, var_19_17)

			arg_19_0:AddAutoWeapon(var_19_19)
		end
	end

	return
end

function var_0_7.SetPriorityWeaponSkin(arg_21_0, arg_21_1)
	if not arg_21_0._priorityWeaponSkinID then
		arg_21_0._priorityWeaponSkinID = arg_21_1
	end

	return
end

function var_0_7.GetPriorityWeaponSkin(arg_22_0)
	return arg_22_0._priorityWeaponSkinID
end

function var_0_7.AddWeapon(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
	local var_23_0 = var_0_1.CreateWeaponUnit(arg_23_1, arg_23_0, arg_23_4, arg_23_5)

	arg_23_0._totalWeapon[#arg_23_0._totalWeapon + 1] = var_23_0

	if arg_23_2 then
		var_23_0:SetEquipmentLabel(arg_23_2)
	end

	if var_23_0:GetTemplateData().type == var_0_4.POINT_HIT_AND_LOCK or var_8 == var_0_4.MANUAL_METEOR or var_8 == var_0_4.MANUAL_MISSILE or var_8 == var_0_4.POINT_AIR_STRIKE then
		arg_23_0._chargeList[#arg_23_0._chargeList + 1] = var_23_0

		local var_23_1 = arg_23_0._weaponQueue

		var_9.AppendChargeWeapon(var_23_1, var_23_0)
	elseif var_8 == var_0_4.MANUAL_TORPEDO or var_8 == var_0_4.DISPOSABLE_TORPEDO or var_8 == var_0_4.MANUAL_AAMISSILE then
		arg_23_0._manualTorpedoList[#arg_23_0._manualTorpedoList + 1] = var_23_0

		local var_23_2 = arg_23_0._weaponQueue

		var_9.AppendManualTorpedo(var_23_2, var_23_0)
	elseif var_8 == var_0_4.STRIKE_AIRCRAFT then
		-- block empty
	elseif var_8 == var_0_4.FLEET_ANTI_AIR then
		arg_23_0:AddFleetAntiAirWeapon(var_23_0)
	elseif var_8 == var_0_4.FLEET_RANGE_ANTI_AIR then
		arg_23_0:AddFleetRangeAntiAirWeapon(var_23_0)
	else
		arg_23_0:AddAutoWeapon(var_23_0)
	end

	if var_8 == var_0_4.STRIKE_AIRCRAFT then
		arg_23_0._hiveList[#arg_23_0._hiveList + 1] = var_23_0
	end

	if var_8 == var_0_4.ANTI_AIR then
		arg_23_0._AAList[#arg_23_0._AAList + 1] = var_23_0
	end

	if arg_23_3 and arg_23_3 ~= 0 then
		var_23_0:SetSkinData(arg_23_3)
		arg_23_0:SetPriorityWeaponSkin(arg_23_3)
	end

	return var_23_0
end

function var_0_7.RemoveWeapon(arg_24_0, arg_24_1)
	local var_24_0 = var_0_1.GetWeaponPropertyDataFromID(arg_24_1).type
	local var_24_1

	if var_24_0 == var_0_4.STRIKE_AIRCRAFT then
		ipairs = var_4

		for iter_24_0, iter_24_1 in var_4(arg_24_0._hiveList) do
			if iter_24_1:GetWeaponId() == arg_24_1 then
				var_24_1 = iter_24_1
				table = var_1_10009

				var_1_10009.remove(arg_24_0._hiveList, iter_24_0)

				break
			end
		end
	elseif var_24_0 == var_0_4.POINT_HIT_AND_LOCK or var_24_0 == var_0_4.MANUAL_METEOR or var_24_0 == var_0_4.MANUAL_MISSILE then
		-- block empty
	elseif var_24_0 == var_0_4.MANUAL_TORPEDO then
		ipairs = var_4

		for iter_24_2, iter_24_3 in var_4(arg_24_0._manualTorpedoList) do
			if iter_24_3:GetWeaponId() == arg_24_1 then
				var_24_1 = iter_24_3
				table = var_1_10009

				var_1_10009.remove(arg_24_0._manualTorpedoList, iter_24_2)

				local var_24_2 = arg_24_0._weaponQueue

				var_1_10009.RemoveManualTorpedo(var_24_2, iter_24_3)

				break
			end
		end
	elseif var_24_0 == var_0_4.FLEET_ANTI_AIR then
		ipairs = var_4

		for iter_24_4, iter_24_5 in var_4(arg_24_0._fleetAAList) do
			if iter_24_5:GetWeaponId() == arg_24_1 then
				arg_24_0:RemoveFleetAntiAirWeapon(iter_24_5)

				break
			end
		end
	else
		ipairs = var_4

		for iter_24_6, iter_24_7 in var_4(arg_24_0._autoWeaponList) do
			if iter_24_7:GetWeaponId() == arg_24_1 then
				local var_24_3 = iter_24_7

				var_24_1.Clear(var_24_3)
				arg_24_0:RemoveAutoWeapon(var_24_1)

				break
			end
		end
	end

	if var_24_1 then
		ipairs = var_4

		for iter_24_8, iter_24_9 in var_4(arg_24_0._totalWeapon) do
			if iter_24_9 == var_24_1 then
				table = var_1_10009

				var_1_10009.remove(arg_24_0._totalWeapon, iter_24_8)

				break
			end
		end
	end

	return var_24_1
end

function var_0_7.RemoveWeaponByLabel(arg_25_0, arg_25_1)
	local var_25_0

	ipairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(arg_25_0._totalWeapon) do
		local var_25_1 = true

		ipairs = var_1_10009

		for iter_25_2, iter_25_3 in var_1_10009(arg_25_1) do
			local var_25_2 = iter_25_1
			local var_25_3 = iter_25_1.GetEquipmentLabel(var_25_2)

			if var_25_1 then
				table = var_25_2
				var_25_1 = var_25_2.contains(var_25_3, iter_25_3)
			end
		end

		if var_25_1 then
			var_25_0 = iter_25_1
			table = var_1_10009

			var_1_10009.remove(arg_25_0._totalWeapon, iter_25_0)
		end
	end

	if not var_25_0 then
		return
	end

	if var_25_0:GetType() == var_0_4.STRIKE_AIRCRAFT then
		ipairs = var_4

		for iter_25_4, iter_25_5 in var_4(arg_25_0._hiveList) do
			if var_25_0 == iter_25_5 then
				table = var_1_10009

				var_1_10009.remove(arg_25_0._hiveList, iter_25_4)

				break
			end
		end
	elseif var_3 == var_0_4.POINT_HIT_AND_LOCK or var_3 == var_0_4.MANUAL_METEOR or var_3 == var_0_4.MANUAL_MISSILE then
		-- block empty
	elseif var_3 == var_0_4.MANUAL_TORPEDO then
		ipairs = var_4

		for iter_25_6, iter_25_7 in var_4(arg_25_0._manualTorpedoList) do
			if var_25_0 == iter_25_7 then
				table = var_1_10009

				var_1_10009.remove(arg_25_0._manualTorpedoList, iter_25_6)

				local var_25_4 = arg_25_0._weaponQueue

				var_1_10009.RemoveManualTorpedo(var_25_4, iter_25_7)

				break
			end
		end
	elseif var_3 == var_0_4.FLEET_ANTI_AIR then
		ipairs = var_4

		for iter_25_8, iter_25_9 in var_4(arg_25_0._fleetAAList) do
			if var_25_0 == iter_25_9 then
				arg_25_0:RemoveFleetAntiAirWeapon(iter_25_9)

				break
			end
		end
	elseif var_3 == var_0_4.INTERCEPT_AIRCRAFT then
		ipairs = var_4

		for iter_25_10, iter_25_11 in var_4(arg_25_0._autoWeaponList) do
			if var_25_0 == iter_25_11 then
				arg_25_0:RemoveAutoWeapon(var_25_0)

				break
			end
		end
	else
		ipairs = var_4

		for iter_25_12, iter_25_13 in var_4(arg_25_0._autoWeaponList) do
			if var_25_0 == iter_25_13 then
				arg_25_0:RemoveAutoWeapon(var_25_0)

				break
			end
		end
	end

	return var_25_0
end

function var_0_7.AddFleetAntiAirWeapon(arg_26_0, arg_26_1)
	arg_26_0._fleetAAList[#arg_26_0._fleetAAList + 1] = arg_26_1

	if arg_26_0._fleet then
		local var_26_0 = arg_26_0._fleet

		if var_2.GetFleetAntiAirWeapon(var_26_0) then
			local var_26_1 = arg_26_0._fleet
			local var_26_2 = var_2.GetFleetAntiAirWeapon(var_26_1)

			var_2.FlushCrewUnit(var_26_2, arg_26_0)
		end
	end

	return
end

function var_0_7.RemoveFleetAntiAirWeapon(arg_27_0, arg_27_1)
	ipairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0._fleetAAList) do
		if iter_27_1 == arg_27_1 then
			table = var_1_10007

			var_1_10007.remove(arg_27_0._fleetAAList, iter_27_0)

			return
		end
	end

	local var_27_0 = arg_27_0._fleet
	local var_27_1 = var_2.GetFleetAntiAirWeapon(var_27_0)

	var_2.FlushCrewUnit(var_27_1, arg_27_0)

	return
end

function var_0_7.AddFleetRangeAntiAirWeapon(arg_28_0, arg_28_1)
	arg_28_0._fleetRangeAAList[#arg_28_0._fleetRangeAAList + 1] = arg_28_1

	return
end

function var_0_7.RemoveFleetRangeAntiAirWeapon(arg_29_0, arg_29_1)
	ipairs = var_1_10002

	for iter_29_0, iter_29_1 in var_1_10002(arg_29_0._fleetRangeAAList) do
		if iter_29_1 == arg_29_1 then
			table = var_1_10007

			var_1_10007.remove(arg_29_0._fleetRangeAAList, iter_29_0)

			return
		end
	end

	return
end

function var_0_7.ShiftWeapon(arg_30_0, arg_30_1)
	return
end

function var_0_7.GetManualWeaponParallel(arg_31_0)
	return arg_31_0._tmpData.parallel_max
end

function var_0_7.CeaseAllWeapon(arg_32_0, arg_32_1)
	if arg_32_1 then
		ipairs = var_1_10002

		for iter_32_0, iter_32_1 in var_1_10002(arg_32_0._totalWeapon) do
			iter_32_1:Cease()
		end

		local var_32_0 = arg_32_0._buffList

		pairs = var_3

		for iter_32_2, iter_32_3 in var_3(var_32_0) do
			iter_32_3:Interrupt()
		end
	end

	var_0_7.super.CeaseAllWeapon(arg_32_0, arg_32_1)

	return
end

function var_0_7.LeaderSetting(arg_33_0)
	local var_33_0 = arg_33_0:GetIntimacy()

	if var_0_1.GetWords(arg_33_0:GetSkinID(), "hp_warning", var_33_0) and var_2 ~= "" then
		arg_33_0._warningValue = var_0_5.WARNING_HP_RATE * arg_33_0:GetMaxHP()
	end

	return
end

function var_0_7.UpdateHP(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = var_0_7.super.UpdateHP(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_3

	if arg_34_0._warningValue and arg_34_0._currentHP < arg_34_0._warningValue then
		isHeal = var_6

		if not var_6 then
			arg_34_0._warningValue = nil

			local var_34_1 = arg_34_0:GetIntimacy()
			local var_34_2 = "hp_warning"

			var_34_3 = var_0_1.GetWords(arg_34_0:GetSkinID(), var_34_2, var_34_1)

			arg_34_0:DispatchVoice(var_34_2)
			arg_34_0:DispatchChat(var_34_3, 2.5, var_34_2)
		end
	end

	if arg_34_0._mainUnitWarningValue and arg_34_0._currentHP < arg_34_0._mainUnitWarningValue and arg_34_0._currentHP > 0 then
		isHeal = var_6

		if not var_6 then
			arg_34_0._mainUnitWarningValue = nil
			pg = var_6

			local var_34_4 = var_6.TipsMgr.GetInstance()
			local var_34_5 = var_6.ShowTips

			i18n = var_34_3

			var_34_5(var_34_4, var_34_3("battle_main_emergent", arg_34_0:GetShipName()))
		end
	end

	return var_34_0
end

function var_0_7.SetMainFleetUnit(arg_35_0)
	var_0_7.super.SetMainFleetUnit(arg_35_0)

	if arg_35_0._IFF == var_0_5.FRIENDLY_CODE then
		arg_35_0._mainUnitWarningValue = var_0_5.WARNING_HP_RATE_MAIN * arg_35_0:GetMaxHP()
	end

	return
end

function var_0_7.UpdatePrecastMoveLimit(arg_36_0)
	return
end

function var_0_7.setStandardLabelTag(arg_37_0)
	var_0_7.super.setStandardLabelTag(arg_37_0)

	local var_37_0 = #arg_37_0:GetManualWeaponParallel()

	while var_37_0 > 0 do
		if var_1[var_37_0] > 1 then
			print = var_3

			var_3(var_0.PARALLEL_LABEL_TAG[var_37_0])
			arg_37_0:AddLabelTag(var_0.PARALLEL_LABEL_TAG[var_37_0])
		end

		var_37_0 = var_37_0 - 1
	end

	return
end

function var_0_7.ConfigBubbleFX(arg_38_0)
	arg_38_0._bubbleFX = var_0_5.PLAYER_SUB_BUBBLE_FX

	local var_38_0 = arg_38_0._oxyState

	var_1.SetBubbleTemplate(var_38_0, var_0_5.PLAYER_SUB_BUBBLE_INIT, var_0_5.PLAYER_SUB_BUBBLE_INTERVAL)

	return
end

function var_0_7.OxyConsume(arg_39_0)
	var_0_7.super.OxyConsume(arg_39_0)

	if arg_39_0._currentOxy <= 0 then
		local var_39_0 = arg_39_0._fleet

		var_1.ChangeSubmarineState(var_39_0, var_0.Battle.OxyState.STATE_FREE_FLOAT, true)
	end

	return
end

function var_0_7.SetFormationIndex(arg_40_0, arg_40_1)
	arg_40_0._formationIndex = arg_40_1

	return
end

function var_0_7.setAttrFromOutBattle(arg_41_0, arg_41_1, arg_41_2)
	var_0_3.SetPlayerAttrFromOutBattle(arg_41_0, arg_41_1, arg_41_2)

	return
end

function var_0_7.SetFleetVO(arg_42_0, arg_42_1)
	arg_42_0._fleet = arg_42_1

	local var_42_0 = arg_42_0._fleet

	arg_42_0._subRaidLine, arg_42_0._subRetreatLine = var_2.GetSubmarineBaseLine(var_42_0)

	return
end

function var_0_7.GetTemplate(arg_43_0)
	return arg_43_0._tmpData
end

function var_0_7.GetGroupID(arg_44_0)
	local var_44_0 = arg_44_0:GetTemplateID()

	return var_0_1.GetPlayerShipModelFromID(var_44_0).group_type
end

function var_0_7.GetRarity(arg_45_0)
	local var_45_0

	if not arg_45_0._rarity then
		var_45_0 = arg_45_0._tmpData.rarity
	end

	return var_45_0
end

function var_0_7.GetIntimacy(arg_46_0)
	local var_46_0

	if not arg_46_0._intimacy then
		var_46_0 = 0
	end

	return var_46_0
end

function var_0_7.GetAutoPilotPreference(arg_47_0)
	return arg_47_0._personality
end

function var_0_7.GetFleetVO(arg_48_0)
	return arg_48_0._fleet
end

function var_0_7.InitCldComponent(arg_49_0)
	var_0_7.super.InitCldComponent(arg_49_0)

	local var_49_0 = {
		type = var_0.CldType.SHIP,
		IFF = arg_49_0:GetIFF(),
		UID = arg_49_0:GetUniqueID(),
		Mass = var_0.CldMass.L2
	}
	local var_49_1 = arg_49_0._cldComponent

	var_2.SetCldData(var_49_1, var_49_0)

	return
end

function var_0_7.AddPointAirStrike(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = arg_50_0:AddWeapon(arg_50_1, {}, nil, 1, -1)
	local var_50_1 = arg_50_0:GetFleetVO()
	local var_50_2 = var_5.GetChargeWeaponVO(var_50_1)

	var_5.AppendWeapon(var_50_2, var_50_0)

	if arg_50_3 then
		var_50_0:OverHeat()
		var_50_0:EnterCoolDown()
	end

	local var_50_3 = arg_50_0:GetFleetVO()
	local var_50_4 = var_5.GetChargeWeaponVO(var_50_3)

	var_5.DispatchCountChange(var_50_4)
	arg_50_0:DispatchEvent(var_0.Event.New(var_0.Battle.BattleUnitEvent.CREATE_POINT_AIR_STRIKE, {
		weapon = var_50_0
	}))

	return var_50_0
end

return
