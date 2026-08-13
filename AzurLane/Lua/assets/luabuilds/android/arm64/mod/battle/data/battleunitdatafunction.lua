ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle.BattleAttr

pg = var_0_10004

local var_0_4 = var_0_10004.ship_data_statistics

pg = var_0_10005

local var_0_5 = var_0_10005.ship_data_template

pg = var_0_10006

local var_0_6 = var_0_10006.ship_skin_template

pg = var_0_10007

local var_0_7 = var_0_10007.enemy_data_statistics

pg = var_0_10008

local var_0_8 = var_0_10008.weapon_property

pg = var_0_10009

local var_0_9 = var_0_10009.formation_template

pg = var_0_10010

local var_0_10 = var_0_10010.auto_pilot_template

pg = var_0_10011

local var_0_11 = var_0_10011.aircraft_template

pg = var_0_10012

local var_0_12 = var_0_10012.ship_skin_words

pg = var_0_10013

local var_0_13 = var_0_10013.equip_data_statistics

pg = var_0_10014

local var_0_14 = var_0_10014.equip_data_template

pg = var_0_10015

local var_0_15 = var_0_10015.spweapon_data_statistics

pg = var_0_10016

local var_0_16 = var_0_10016.enemy_data_skill

pg = var_0_10017

local var_0_17 = var_0_10017.ship_data_personality

pg = var_0_10018

local var_0_18 = var_0_10018.enemy_data_by_type

pg = var_0_10019

local var_0_19 = var_0_10019.ship_data_by_type

pg = var_0_10020

local var_0_20 = var_0_10020.ship_level

pg = var_0_10021

local var_0_21 = var_0_10021.skill_data_template

pg = var_0_10022

local var_0_22 = var_0_10022.ship_data_trans

pg = var_0_10023

local var_0_23 = var_0_10023.battle_environment_behaviour_template

pg = var_0_10024

local var_0_24 = var_0_10024.equip_skin_template

pg = var_0_10025

local var_0_25 = var_0_10025.activity_template

pg = var_0_10026

local var_0_26 = var_0_10026.activity_event_worldboss

pg = var_0_10027

local var_0_27 = var_0_10027.world_joint_boss_template

pg = var_0_10028

local var_0_28 = var_0_10028.world_boss_level

pg = var_0_10029

local var_0_29 = var_0_10029.guild_boss_event

pg = var_0_10030

local var_0_30 = var_0_10030.ship_strengthen_meta

pg = var_0_10031

local var_0_31 = var_0_10031.map_data

pg = var_0_10032

local var_0_32 = var_0_10032.strategy_data_template
local var_0_33 = var_0.Battle
local var_0_34

if not var_0.Battle.BattleDataFunction then
	var_0_34 = {}
end

var_0_33.BattleDataFunction = var_0_34

local var_0_35 = var_0.Battle.BattleDataFunction

function var_0_35.CreateBattleUnitData(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9, arg_1_10, arg_1_11, arg_1_12)
	local var_1_0
	local var_1_1

	if arg_1_1 == var_0_1.UnitType.PLAYER_UNIT then
		local var_1_2 = var_0.Battle.BattlePlayerUnit.New(arg_1_0, arg_1_2)

		var_1_0.SetSkinId(var_1_2, arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)

		Ship = var_15
		var_1_1 = var_15.WEAPON_COUNT
	elseif arg_1_1 == var_0_1.UnitType.SUB_UNIT then
		local var_1_3 = var_0.Battle.BattleSubUnit.New(arg_1_0, arg_1_2)

		var_1_0.SetSkinId(var_1_3, arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)

		Ship = var_15
		var_1_1 = var_15.WEAPON_COUNT
	elseif arg_1_1 == var_0_1.UnitType.ENEMY_UNIT then
		local var_1_4 = var_0.Battle.BattleEnemyUnit.New(arg_1_0, arg_1_2)

		var_1_0.SetOverrideLevel(var_1_4, arg_1_11)
	elseif arg_1_1 == var_0_1.UnitType.MINION_UNIT then
		var_1_0 = var_0.Battle.BattleMinionUnit.New(arg_1_0, arg_1_2)
	elseif arg_1_1 == var_0_1.UnitType.BOSS_UNIT then
		local var_1_5 = var_0.Battle.BattleBossUnit.New(arg_1_0, arg_1_2)

		var_1_0.SetOverrideLevel(var_1_5, arg_1_11)
	elseif arg_1_1 == var_0_1.UnitType.CONST_UNIT then
		local var_1_6 = var_0.Battle.BattleConstPlayerUnit.New(arg_1_0, arg_1_2)

		var_1_0.SetSkinId(var_1_6, arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)

		Ship = var_15
		var_1_1 = var_15.WEAPON_COUNT
	elseif arg_1_1 == var_0_1.UnitType.CARDPUZZLE_PLAYER_UNIT then
		local var_1_7 = var_0.Battle.BattleCardPuzzlePlayerUnit.New(arg_1_0, arg_1_2)

		var_1_0.SetSkinId(var_1_7, arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)
	elseif arg_1_1 == var_0_1.UnitType.SUPPORT_UNIT then
		local var_1_8 = var_0.Battle.BattleSupportUnit.New(arg_1_0, arg_1_2)

		var_1_0.SetSkinId(var_1_8, arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)
	end

	var_1_0:SetTemplate(arg_1_3, arg_1_6, arg_1_7)

	if arg_1_1 == var_0_1.UnitType.MINION_UNIT then
		var_1_0:SetMaster(arg_1_12)
		var_1_0:InheritMasterAttr()
	end

	local var_1_9 = {}

	if arg_1_1 == var_0_1.UnitType.ENEMY_UNIT or arg_1_1 == var_0_1.UnitType.MINION_UNIT or arg_1_1 == var_0_1.UnitType.BOSS_UNIT then
		ipairs = var_16

		for iter_1_0, iter_1_1 in var_16(arg_1_5) do
			var_1_9[#var_1_9 + 1] = {
				equipment = {
					weapon_id = {
						iter_1_1.id
					}
				}
			}
		end
	else
		ipairs = var_16

		for iter_1_2, iter_1_3 in var_16(arg_1_5) do
			if not iter_1_3.id then
				var_1_9[#var_1_9 + 1] = {
					equipment = false,
					torpedoAmmo = 0,
					skin = iter_1_3.skin
				}

				goto label_1_0
			end

			if iter_1_3.equipmentInfo then
				do
					local var_1_10 = iter_1_3.equipmentInfo
					local var_1_11

					if not var_21.getConfig(var_1_10, "torpedo_ammo") then
						var_1_11 = 0
					end

					if not var_1_1 or iter_1_2 <= var_1_1 or #var_0_35.GetWeaponDataFromID(iter_1_3.id).weapon_id then
						local var_1_12 = var_0_35.GetWeaponDataFromID(iter_1_3.id)

						var_1_9[#var_1_9 + 1] = {
							equipment = var_1_12,
							skin = iter_1_3.skin,
							torpedoAmmo = var_1_11
						}
					else
						var_1_9[#var_1_9 + 1] = {
							equipment = false,
							skin = iter_1_3.skin,
							torpedoAmmo = var_1_11
						}
					end
				end

				::label_1_0::
			end
		end
	end

	var_1_0:SetProficiencyList(arg_1_8)
	var_1_0:SetEquipment(var_1_9)

	return var_1_0
end

function var_0_35.InitUnitSkill(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if not arg_2_0.skills then
		var_2_0 = {}
	end

	pairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(var_2_0) do
		local var_2_1 = var_0.Battle.BattleBuffUnit.New(iter_2_1.id, iter_2_1.level, arg_2_1)

		arg_2_1:AddBuff(var_2_1)
	end

	return
end

function var_0_35.GetEquipSkill(arg_3_0, arg_3_1)
	Ship = var_1_10002

	local var_3_0 = var_1_10002.WEAPON_COUNT
	local var_3_1 = {}

	ipairs = var_1_10004

	for iter_3_0, iter_3_1 in var_1_10004(arg_3_0) do
		if iter_3_1.id then
			local var_3_2

			if var_0_35.GetWeaponDataFromID(var_9) then
				ipairs = var_1_10012

				for iter_3_2, iter_3_3 in var_1_10012(var_11.skill_id) do
					local var_3_3

					if not arg_3_1 or not var_0_35.SkillTranform(arg_3_1, iter_3_3[1]) then
						var_3_3 = iter_3_3[1]
					end

					local var_3_4

					if not iter_3_3[2] then
						var_3_4 = 1
					end

					local var_3_5 = {
						buffID = var_3_3,
						buffLV = var_3_4
					}

					table = var_1_10020

					var_1_10020.insert(var_3_1, var_3_5)
				end

				ipairs = var_1_10012

				for iter_3_4, iter_3_5 in var_1_10012(var_11.hidden_skill_id) do
					local var_3_6

					if not arg_3_1 or not var_0_35.SkillTranform(arg_3_1, iter_3_5[1]) then
						var_3_6 = iter_3_5[1]
					end

					local var_3_7

					if not iter_3_5[2] then
						var_3_7 = 1
					end

					local var_3_8 = {
						buffID = var_3_6,
						buffLV = var_3_7
					}

					table = var_1_10020

					var_1_10020.insert(var_3_1, var_3_8)
				end
			end
		end
	end

	return var_3_1
end

function var_0_35.AttachWeather(arg_4_0, arg_4_1)
	table = var_1_10002

	if var_1_10002.contains(arg_4_1, var_0_1.WEATHER.NIGHT) then
		local var_4_0 = arg_4_0
		local var_4_1 = arg_4_0.GetTemplate(var_4_0).type

		if arg_4_0:GetFleetVO() then
			local var_4_2 = arg_4_0:GetFleetVO()

			table = var_4_0

			local var_4_3 = var_4_0.contains

			ShipType = var_1_10006

			local var_4_4

			if var_4_3(var_1_10006.VanguardShipType, var_4_1) then
				var_4_4 = var_4_2

				local var_4_5 = var_4_2.GetFleetBias(var_4_4)
				local var_4_6 = var_4.GetCrewCount(var_4_5) + 1

				var_4:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_SCOUT[var_4_6])
				var_4:AppendCrew(arg_4_0)
			else
				table = var_4

				local var_4_7 = var_4.contains

				ShipType = var_4_4

				local var_4_8

				if var_4_7(var_4_4.MainShipType, var_4_1) then
					var_4_8 = var_4_2

					var_4_2.AttachCloak(var_4_8, arg_4_0)
				else
					table = var_4

					local var_4_9 = var_4.contains

					ShipType = var_4_8

					if var_4_9(var_4_8.SubShipType, var_4_1) then
						local var_4_10 = var_0.Battle.BattleUnitAimBiasComponent.New()

						var_4.ConfigRangeFormula(var_4_10, var_0.Battle.BattleFormulas.CalculateMaxAimBiasRangeSub, var_0.Battle.BattleFormulas.CalculateBiasDecay)
						var_4:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_SUB)
						var_4:AppendCrew(arg_4_0)
						var_4:Active(var_4.STATE_ACTIVITING)
					end
				end
			end
		elseif arg_4_0:GetUnitType() == var_0_1.UnitType.ENEMY_UNIT or arg_4_0:GetUnitType() == var_0_1.UnitType.MINION_UNIT or arg_4_0:GetUnitType() == var_0_1.UnitType.BOSS_UNIT then
			local var_4_11 = var_0.Battle.BattleUnitAimBiasComponent.New()

			var_3.ConfigRangeFormula(var_4_11, var_0.Battle.BattleFormulas.CalculateMaxAimBiasRangeMonster, var_0.Battle.BattleFormulas.CalculateBiasDecayMonster)

			table = var_4

			local var_4_12 = var_4.contains

			ShipType = var_4_11

			if var_4_12(var_4_11.SubShipType, var_4_1) then
				var_3:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_SUB)
			else
				var_3:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_MONSTER)
			end

			var_3:AppendCrew(arg_4_0)
			var_3:SetHostile()
			var_3:Active(var_3.STATE_SUMMON_SICKNESS)
		end
	end

	return
end

function var_0_35.AttachSmoke(arg_5_0)
	if arg_5_0:GetUnitType() == var_0_1.UnitType.ENEMY_UNIT or var_1 == var_0_1.UnitType.BOSS_UNIT then
		if arg_5_0:GetAimBias() then
			local var_5_0 = arg_5_0:GetAimBias()

			if var_2.GetCurrentState(var_5_0) == var_2.STATE_SKILL_EXPOSE then
				var_2:SomkeExitResume()
			elseif var_3 == var_2.STATE_ACTIVITING or var_3 == var_2.STATE_TOTAL_EXPOSE then
				var_2:SmokeRecover()
			end
		else
			local var_5_1 = var_0.Battle.BattleUnitAimBiasComponent.New()

			var_2.ConfigRangeFormula(var_5_1, var_0.Battle.BattleFormulas.CalculateMaxAimBiasRangeMonster, var_0.Battle.BattleFormulas.CalculateBiasDecayMonsterInSmoke)

			table = var_3

			local var_5_2 = var_3.contains

			ShipType = var_5_1

			local var_5_3 = var_5_1.SubShipType

			shipType = var_6

			if var_5_2(var_5_3, var_6) then
				var_2:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_SUB)
			else
				var_2:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_MONSTER)
			end

			var_2:AppendCrew(arg_5_0)
			var_2:SetHostile()
			var_2:Active(var_2.STATE_ACTIVITING)
		end
	end

	return
end

function var_0_35.InitEquipSkill(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = var_0_35.GetEquipSkill(arg_6_0, arg_6_2)

	ipairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(var_6_0) do
		local var_6_1 = var_0.Battle.BattleBuffUnit.New(iter_6_1.buffID, iter_6_1.buffLV, arg_6_1)

		arg_6_1:AddBuff(var_6_1)
	end

	return
end

function var_0_35.InitCommanderSkill(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0 = arg_7_0 or {}

	local var_7_0 = var_0.Battle.BattleState.GetInstance()
	local var_7_1 = var_3.GetBattleType(var_7_0)

	pairs = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10004(arg_7_0) do
		local var_7_2 = var_0.Battle.BattleDataFunction.GetBuffTemplate(iter_7_1.id, iter_7_1.level).limit
		local var_7_3 = false

		if var_7_2 then
			ipairs = var_11

			for iter_7_2, iter_7_3 in var_11(var_7_2) do
				if var_7_1 == iter_7_3 then
					var_7_3 = true

					break
				end
			end
		end

		if not var_7_3 then
			local var_7_4 = var_0.Battle.BattleBuffUnit.New(iter_7_1.id, iter_7_1.level, arg_7_1)

			var_11.SetCommander(var_7_4, iter_7_1.commander)
			arg_7_1:AddBuff(var_11)
		end
	end

	return
end

function var_0_35.CreateWeaponUnit(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_3 = arg_8_3 or -1

	local var_8_0 = arg_8_1:GetUnitType()
	local var_8_1
	local var_8_2 = var_0_35.GetWeaponPropertyDataFromID(arg_8_0)

	assert = var_1_10008

	var_1_10008(var_8_2 ~= nil, "找不到武器配置：id = " .. arg_8_0)

	if (arg_8_4 or var_8_2.type) == var_0_1.EquipmentType.MAIN_CANNON then
		var_8_1 = var_0.Battle.BattleWeaponUnit.New()
	elseif var_8 == var_0_1.EquipmentType.SUB_CANNON then
		var_8_1 = var_0.Battle.BattleWeaponUnit.New()
	elseif var_8 == var_0_1.EquipmentType.TORPEDO then
		var_8_1 = var_0.Battle.BattleTorpedoUnit.New()
	elseif var_8 == var_0_1.EquipmentType.MANUAL_TORPEDO then
		var_8_1 = var_0.Battle.BattleManualTorpedoUnit.New()
	elseif var_8 == var_0_1.EquipmentType.ANTI_AIR then
		var_8_1 = var_0.Battle.BattleAntiAirUnit.New()
	elseif var_8 == var_0_1.EquipmentType.FLEET_ANTI_AIR or var_8 == var_0_1.EquipmentType.FLEET_RANGE_ANTI_AIR then
		var_8_1 = var_0.Battle.BattleWeaponUnit.New()
	elseif var_8 == var_0_1.EquipmentType.INTERCEPT_AIRCRAFT or var_8 == var_0_1.EquipmentType.STRIKE_AIRCRAFT then
		if var_8_0 == var_0_1.UnitType.SUPPORT_UNIT then
			var_8_1 = var_0.Battle.BattleSupportHiveUnit.New()
		else
			var_8_1 = var_0.Battle.BattleHiveUnit.New()
		end
	elseif var_8 == var_0_1.EquipmentType.SPECIAL then
		var_8_1 = var_0.Battle.BattleSpecialWeapon.New()
	elseif var_8 == var_0_1.EquipmentType.ANTI_SEA then
		var_8_1 = var_0.Battle.BattleDirectHitWeaponUnit.New()
	elseif var_8 == var_0_1.EquipmentType.HAMMER_HEAD then
		var_8_1 = var_0.Battle.BattleHammerHeadWeaponUnit.New()
	elseif var_8 == var_0_1.EquipmentType.BOMBER_PRE_CAST_ALERT then
		var_8_1 = var_0.Battle.BattleBombWeaponUnit.New()
	elseif var_8 == var_0_1.EquipmentType.POINT_HIT_AND_LOCK or var_8 == var_0_1.EquipmentType.MANUAL_MISSILE or var_8 == var_0_1.EquipmentType.MANUAL_METEOR then
		var_8_1 = var_0.Battle.BattlePointHitWeaponUnit.New()
	elseif var_8 == var_0_1.EquipmentType.POINT_AIR_STRIKE then
		var_8_1 = var_0.Battle.BattlePointAirStrikeUnit.New()
	elseif var_8 == var_0_1.EquipmentType.BEAM then
		var_8_1 = var_0.Battle.BattleLaserUnit.New()
	elseif var_8 == var_0_1.EquipmentType.DEPTH_CHARGE then
		var_8_1 = var_0.Battle.BattleDepthChargeUnit.New()
	elseif var_8 == var_0_1.EquipmentType.REPEATER_ANTI_AIR then
		var_8_1 = var_0.Battle.BattleRepeaterAntiAirUnit.New()
	elseif var_8 == var_0_1.EquipmentType.DISPOSABLE_TORPEDO then
		var_8_1 = var_0.Battle.BattleDisposableTorpedoUnit.New()
	elseif var_8 == var_0_1.EquipmentType.SPACE_LASER then
		var_8_1 = var_0.Battle.BattleSpaceLaserWeaponUnit.New()
	elseif var_8 == var_0_1.EquipmentType.MISSILE then
		var_8_1 = var_0.Battle.BattleMissileWeaponUnit.New()
	elseif var_8 == var_0_1.EquipmentType.MANUAL_AAMISSILE then
		var_8_1 = var_0.Battle.BattleManualAAMissileUnit.New()
	elseif var_8 == var_0_1.EquipmentType.AUTO_MISSILE then
		var_8_1 = var_0.Battle.BattleAutoMissileUnit.New()
	end

	assert = var_9

	var_9(var_8_1 ~= nil, "创建武器失败，不存在该类型的武器：id = " .. arg_8_0)
	var_8_1:SetPotentialFactor(arg_8_2)
	var_8_1:SetEquipmentIndex(arg_8_3)
	var_8_1:SetTemplateData(var_8_2)
	var_8_1:SetHostData(arg_8_1)

	if var_8_0 == var_0_1.UnitType.PLAYER_UNIT then
		if var_8_2.auto_aftercast > 0 then
			var_8_1:OverrideGCD(var_8_2.auto_aftercast)
		end
	elseif var_8_0 == var_0_1.UnitType.ENEMY_UNIT or var_0_1.UnitType.BOSS_UNIT then
		var_8_1:HostOnEnemy()
	end

	if var_8_2.type == var_0_1.EquipmentType.INTERCEPT_AIRCRAFT or var_8_2.type == var_0_1.EquipmentType.STRIKE_AIRCRAFT then
		var_8_1:EnterCoolDown()
	end

	return var_8_1
end

function var_0_35.CreateAircraftUnit(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0
	local var_9_1 = var_0_35.GetAircraftTmpDataFromID(arg_9_1)

	assert = var_1_10006

	var_1_10006(var_9_1 ~= nil, "找不到飞机配置：id = " .. arg_9_1)

	type = var_1_10006

	if var_1_10006(var_9_1.funnel_behavior) == "table" then
		if var_9_1.funnel_behavior.hover_range then
			var_9_0 = var_0.Battle.BattelUAVUnit.New(arg_9_0)
		elseif var_9_1.funnel_behavior.AI then
			var_9_0 = var_0.Battle.BattlePatternFunnelUnit.New(arg_9_0)
		else
			var_9_0 = var_0.Battle.BattleFunnelUnit.New(arg_9_0)
		end
	else
		var_9_0 = var_0.Battle.BattleAircraftUnit.New(arg_9_0)
	end

	var_9_0:SetMotherUnit(arg_9_2)
	var_9_0:SetWeanponPotential(arg_9_3)
	var_9_0:SetTemplate(var_9_1)

	return var_9_0
end

function var_0_35.CreateAllInStrike(arg_10_0)
	local var_10_0 = arg_10_0:GetTemplateID()
	local var_10_1 = var_0_35.GetPlayerShipModelFromID(var_10_0)
	local var_10_2 = 0
	local var_10_3 = {}

	ipairs = var_1_10005

	for iter_10_0, iter_10_1 in var_1_10005(var_10_1.airassist_time) do
		local var_10_4 = var_0.Battle.BattleAllInStrike.New(iter_10_1)

		var_10.SetHost(var_10_4, arg_10_0)

		var_10_3[iter_10_0] = var_10
	end

	return var_10_3
end

function var_0_35.ExpandAllinStrike(arg_11_0)
	local var_11_0 = arg_11_0:GetTemplateID()

	if #var_0_35.GetPlayerShipModelFromID(var_11_0).airassist_time > 0 then
		local var_11_1 = var_3[#var_3]
		local var_11_2 = var_0.Battle.BattleAllInStrike.New(var_11_1)

		var_5.SetHost(var_11_2, arg_11_0)

		local var_11_3 = arg_11_0:GetFleetVO()
		local var_11_4 = var_6.GetAirAssistVO(var_11_3)

		var_6.AppendWeapon(var_11_4, var_5)
		var_5:OverHeat()

		local var_11_5 = arg_11_0:GetAirAssistQueue()

		var_6.AppendWeapon(var_11_5, var_5)

		var_6[#arg_11_0:GetAirAssistList() + 1] = var_5
	end

	return
end

function var_0_35.CreateAirFighterUnit(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1 = var_0_35.GetAircraftTmpDataFromID(arg_12_1.templateID)
	local var_12_2 = var_0.Battle.BattleAirFighterUnit.New(arg_12_0)

	var_2.SetWeaponTemplateID(var_12_2, arg_12_1.weaponID)
	var_2:SetBackwardWeaponID(arg_12_1.backwardWeaponID)
	var_2:SetTemplate(var_12_1)

	return var_2
end

function var_0_35.GetPlayerShipTmpDataFromID(arg_13_0)
	assert = var_1_10001

	var_1_10001(var_0_4[arg_13_0] ~= nil, ">>ship_data_statistics<< 找不到玩家船只配置：id = " .. arg_13_0)

	Clone = var_1_10001

	return var_1_10001(var_0_4[arg_13_0])
end

function var_0_35.GetPlayerShipModelFromID(arg_14_0)
	assert = var_1_10001

	var_1_10001(var_0_5[arg_14_0] ~= nil, ">>ship_data_template<< 找不到玩家船只模组配置：id = " .. arg_14_0)

	return var_0_5[arg_14_0]
end

function var_0_35.GetPlayerShipSkinDataFromID(arg_15_0)
	assert = var_1_10001

	var_1_10001(var_0_6[arg_15_0] ~= nil, ">>ship_skin_template<< 找不到舰娘皮肤配置：id = " .. arg_15_0)

	return var_0_6[arg_15_0]
end

function var_0_35.GetShipTypeTmp(arg_16_0)
	assert = var_1_10001

	var_1_10001(var_0_19[arg_16_0] ~= nil, ">>ship_data_by_type<< 找不到舰船类型配置：id = " .. arg_16_0)

	return var_0_19[arg_16_0]
end

function var_0_35.GetMonsterTmpDataFromID(arg_17_0)
	assert = var_1_10001

	var_1_10001(var_0_7[arg_17_0] ~= nil, ">>enemy_data_statistics<< 找不到敌方船只配置：id = " .. arg_17_0)

	return var_0_7[arg_17_0]
end

function var_0_35.GetAircraftTmpDataFromID(arg_18_0)
	assert = var_1_10001

	var_1_10001(var_0_11[arg_18_0] ~= nil, ">>aircraft_template<< 找不到飞机配置：id = " .. arg_18_0)

	return var_0_11[arg_18_0]
end

function var_0_35.GetWeaponDataFromID(arg_19_0)
	Equipment = var_1_10001

	if arg_19_0 ~= var_1_10001.EQUIPMENT_STATE_EMPTY then
		Equipment = var_1

		if arg_19_0 ~= var_1.EQUIPMENT_STATE_LOCK then
			assert = var_1

			var_1(var_0_13[arg_19_0] ~= nil, ">>equip_data_statistics<< 找不到武器类装备配置：id = " .. arg_19_0)
		end
	end

	return var_0_13[arg_19_0]
end

function var_0_35.GetEquipDataTemplate(arg_20_0)
	assert = var_1_10001

	var_1_10001(var_0_14[arg_20_0] ~= nil, ">>equip_data_template<< 找不到武器装备模板：id = " .. arg_20_0)

	return var_0_14[arg_20_0]
end

function var_0_35.GetSpWeaponDataFromID(arg_21_0)
	assert = var_1_10001

	var_1_10001(var_0_15[arg_21_0] ~= nil, ">>spweapon_data_statistics<< 找不到特殊兵装配置：id = " .. arg_21_0)

	return var_0_15[arg_21_0]
end

function var_0_35.GetWeaponPropertyDataFromID(arg_22_0)
	assert = var_1_10001

	var_1_10001(var_0_8[arg_22_0] ~= nil, ">>weapon_property<< 找不到武器行为配置：id = " .. arg_22_0)

	return var_0_8[arg_22_0]
end

function var_0_35.GetFormationTmpDataFromID(arg_23_0)
	assert = var_1_10001

	var_1_10001(var_0_9[arg_23_0] ~= nil, ">>formation_template<<找不到阵型配置：id = " .. arg_23_0)

	return var_0_9[arg_23_0]
end

function var_0_35.GetAITmpDataFromID(arg_24_0)
	assert = var_1_10001

	var_1_10001(var_0_10[arg_24_0] ~= nil, ">>auto_pilot_template<< 找不到移动ai配置：id = " .. arg_24_0)

	return var_0_10[arg_24_0]
end

function var_0_35.GetShipPersonality(arg_25_0)
	assert = var_1_10001

	var_1_10001(var_0_17[arg_25_0] ~= nil, ">>shipPersonality<< 找不到性格配置：id = " .. arg_25_0)

	return var_0_17[arg_25_0]
end

function var_0_35.GetEnemyTypeDataByType(arg_26_0)
	assert = var_1_10001

	var_1_10001(var_0_18[arg_26_0] ~= nil, ">>enemy_data_by_type<< 找不到怪物类型：type = " .. arg_26_0)

	return var_0_18[arg_26_0]
end

function var_0_35.GetArenaBuffByShipType(arg_27_0)
	return var_0_35.GetShipTypeTmp(arg_27_0).arena_buff
end

function var_0_35.GetPlayerUnitDurabilityExtraAddition(arg_28_0, arg_28_1)
	SYSTEM_DUEL = var_1_10002

	if arg_28_0 == var_1_10002 then
		assert = var_1_10002

		var_1_10002(var_0_20[arg_28_1] ~= nil, ">>ship_level<< 找不到等级配置：level = " .. arg_28_1)

		return var_0_20[arg_28_1].arena_durability_ratio, var_0_20[arg_28_1].arena_durability_add
	else
		return 1, 0
	end

	return
end

function var_0_35.GetSkillDataTemplate(arg_29_0)
	return var_0_21[arg_29_0]
end

function var_0_35.GetShipTransformDataTemplate(arg_30_0)
	local var_30_0 = var_0_35.GetPlayerShipModelFromID(arg_30_0)

	return var_0_22[var_30_0.group_type]
end

function var_0_35.GetShipMetaFromDataTemplate(arg_31_0)
	local var_31_0 = var_0_35.GetPlayerShipModelFromID(arg_31_0)

	return var_0_30[var_31_0.group_type]
end

function var_0_35.GetEquipSkinDataFromID(arg_32_0)
	assert = var_1_10001

	var_1_10001(var_0_24[arg_32_0] ~= nil, ">>equip_skin_template<< 找不到装备皮肤配置：id = " .. arg_32_0)

	return var_0_24[arg_32_0]
end

function var_0_35.GetEquipSkin(arg_33_0)
	assert = var_1_10001

	var_1_10001(var_0_24[arg_33_0] ~= nil, ">>equip_skin_template<< 找不到装备皮肤配置：id = " .. arg_33_0)

	return var_0_24[arg_33_0].bullet_name, var_1.derivate_bullet, var_1.derivate_torpedo, var_1.derivate_boom, var_1.fire_fx_name, var_1.hit_fx_name
end

function var_0_35.GetEquipSkinSFX(arg_34_0)
	assert = var_1_10001

	var_1_10001(var_0_24[arg_34_0] ~= nil, ">>equip_skin_template<< 找不到装备皮肤配置：id = " .. arg_34_0)

	return var_0_24[arg_34_0].hit_sfx, var_1.miss_sfx
end

function var_0_35.GetSpecificGuildBossEnemyList(arg_35_0, arg_35_1)
	local var_35_0 = var_0_29[arg_35_0].expedition_id
	local var_35_1 = {}

	if var_35_0[1] == arg_35_1 then
		var_35_1 = var_35_0[2]
	end

	return var_35_1
end

function var_0_35.GetSpecificEnemyList(arg_36_0, arg_36_1)
	local var_36_0 = var_0_25[arg_36_0]
	local var_36_1 = var_0_26[var_36_0.config_id].ex_expedition_enemy
	local var_36_2

	ipairs = var_1_10006

	for iter_36_0, iter_36_1 in var_1_10006(var_36_1) do
		if iter_36_1[1] == arg_36_1 then
			var_36_2 = iter_36_1[2]

			break
		end
	end

	return var_36_2
end

function var_0_35.GetMetaBossTemplate(arg_37_0)
	return var_0_27[arg_37_0]
end

function var_0_35.GetMetaBossLevelTemplate(arg_38_0, arg_38_1)
	local var_38_0 = var_0_35.GetMetaBossTemplate(arg_38_0).boss_level_id + (arg_38_1 - 1)

	return var_0_28[var_38_0]
end

function var_0_35.GetSpecificWorldJointEnemyList(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = var_0_35.GetMetaBossLevelTemplate(arg_39_1, arg_39_2)

	return {
		var_39_0.enemy_id
	}
end

function var_0_35.IncreaseAttributes(arg_40_0, arg_40_1, arg_40_2)
	ipairs = var_1_10003

	for iter_40_0, iter_40_1 in var_1_10003(arg_40_2) do
		if iter_40_1[arg_40_1] ~= nil then
			type = var_8

			if var_8(iter_40_1[arg_40_1]) == "number" then
				arg_40_0 = arg_40_0 + iter_40_1[arg_40_1]
			end
		end
	end

	return
end

function var_0_35.CreateAirFighterWeaponUnit(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0
	local var_41_1 = var_0_35.GetWeaponPropertyDataFromID(arg_41_0)

	assert = var_1_10006

	var_1_10006(var_41_1 ~= nil, "找不到武器配置：id = " .. arg_41_0)

	if var_41_1.type == var_0_1.EquipmentType.MAIN_CANNON then
		var_41_0 = var_0.Battle.BattleWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.SUB_CANNON then
		var_41_0 = var_0.Battle.BattleWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.TORPEDO then
		var_41_0 = var_0.Battle.BattleTorpedoUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.ANTI_AIR then
		var_41_0 = var_0.Battle.BattleAntiAirUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.ANTI_SEA then
		var_41_0 = var_0.Battle.BattleDirectHitWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.HAMMER_HEAD then
		var_41_0 = var_0.Battle.BattleHammerHeadWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.BOMBER_PRE_CAST_ALERT then
		var_41_0 = var_0.Battle.BattleBombWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.DEPTH_CHARGE then
		var_41_0 = var_0.Battle.BattleDepthChargeUnit.New()
	end

	assert = var_6

	var_6(var_41_0 ~= nil, "创建武器失败，不存在该类型的武器：id = " .. arg_41_0)
	var_41_0:SetPotentialFactor(arg_41_3)

	Clone = var_6

	local var_41_2 = var_6(var_41_1)

	var_41_2.spawn_bound = "weapon"

	var_41_0:SetTemplateData(var_41_2)
	var_41_0:SetHostData(arg_41_1, arg_41_2)

	return var_41_0
end

function var_0_35.GetWords(arg_42_0, arg_42_1, arg_42_2)
	ShipWordHelper = var_1_10003

	local var_42_0, var_42_1, var_42_2 = var_1_10003.GetWordAndCV(arg_42_0, arg_42_1, 1, true, arg_42_2)

	return var_42_2
end

function var_0_35.SkillTranform(arg_43_0, arg_43_1)
	if not var_0_35.GetSkillDataTemplate(arg_43_1) then
		return arg_43_1
	end

	if var_2.system_transform[arg_43_0] == nil then
		return arg_43_1
	else
		return var_3[arg_43_0]
	end

	return
end

function var_0_35.GenerateHiddenBuff(arg_44_0)
	local var_44_0 = var_0_35.GetPlayerShipModelFromID(arg_44_0).hide_buff_list
	local var_44_1 = {}

	ipairs = var_3

	for iter_44_0, iter_44_1 in var_3(var_44_0) do
		local var_44_2 = {}

		var_44_2.level = 1
		var_44_2.id = iter_44_1
		var_44_1[iter_44_1] = var_44_2
	end

	return var_44_1
end

function var_0_35.GetDivingFilter(arg_45_0)
	return var_0_31[arg_45_0].diving_filter
end

function var_0_35.GeneratePlayerSubmarinPhase(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = arg_46_0 - arg_46_2

	return {
		{
			index = 0,
			switchType = 3,
			switchTo = 1,
			switchParam = var_46_0
		},
		{
			switchType = 5,
			dive = "STATE_RAID",
			switchTo = 2,
			index = 1,
			switchParam = 0
		},
		{
			switchType = 1,
			dive = "STATE_FLOAT",
			switchTo = 3,
			index = 2,
			switchParam = arg_46_4
		},
		{
			switchType = 4,
			dive = "STATE_RETREAT",
			switchTo = 4,
			index = 3,
			switchParam = arg_46_1
		},
		{
			index = 4,
			retreat = true
		}
	}
end

function var_0_35.GetEnvironmentBehaviour(arg_47_0)
	assert = var_1_10001

	var_1_10001(var_0_23[arg_47_0] ~= nil, ">>battle_environment_behaviour_template<< 找不到环境行为配置：id = " .. arg_47_0)

	return var_0_23[arg_47_0]
end

function var_0_35.AttachUltimateBonus(arg_48_0)
	local var_48_0 = arg_48_0:GetTemplateID()

	Ship = var_1_10002

	if not var_1_10002.IsMaxStarByTmpID(var_48_0) then
		return
	end

	local var_48_1 = var_0_35.GetPlayerShipModelFromID(var_48_0).specific_type

	ipairs = var_4

	for iter_48_0, iter_48_1 in var_4(var_48_1) do
		ShipType = var_1_10009

		if iter_48_1 == var_1_10009.SpecificTypeTable.gunner then
			var_0_3.SetCurrent(arg_48_0, "barrageCounterMod", var_0_1.UltimateBonus.GunnerCountMod)
		else
			ShipType = var_1_10009

			if iter_48_1 == var_1_10009.SpecificTypeTable.torpedo then
				var_1_10009 = var_0.Battle.BattleBuffUnit.New(var_0_1.UltimateBonus.TorpedoBarrageBuff)

				arg_48_0:AddBuff(var_1_10009)
			else
				ShipType = var_1_10009

				if iter_48_1 == var_1_10009.SpecificTypeTable.auxiliary then
					var_0_35.AuxBoost(arg_48_0)
				end
			end
		end
	end

	return
end

function var_0_35.AuxBoost(arg_49_0)
	local var_49_0 = arg_49_0:GetEquipment()

	ipairs = var_1_10002

	for iter_49_0, iter_49_1 in var_1_10002(var_49_0) do
		if iter_49_1 and iter_49_1.equipment then
			table = var_7

			local var_49_1 = var_7.contains

			EquipType = var_1_10009

			if var_49_1(var_1_10009.DeviceEquipTypes, iter_49_1.equipment.type) then
				local var_49_2 = iter_49_1.equipment

				for iter_49_2 = 1, 3 do
					if var_49_2["attribute_" .. iter_49_2] then
						local var_49_3 = var_49_2["value_" .. iter_49_2]

						AttributeType = var_14

						local var_49_4 = var_14.ConvertBattleAttrName(var_49_2[var_12])
						local var_49_5 = var_0_3.GetBase(arg_49_0, var_49_4) + var_49_3 * var_0_1.UltimateBonus.AuxBoostValue

						var_0_3.SetCurrent(arg_49_0, var_49_4, var_49_5)
						var_0_3.SetBaseAttr(arg_49_0)
					end
				end
			end
		end
	end

	return
end

function var_0_35.GetSLGStrategyBuffByCombatBuffID(arg_50_0)
	ipairs = var_1_10001

	for iter_50_0, iter_50_1 in var_1_10001(var_0_32.all) do
		if iter_50_1 == arg_50_0 then
			return var_0_32[arg_50_0]
		end
	end

	return
end

return
