ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleConfig
local var_0_3 = ys.Battle.BattleAttr
local var_0_4 = pg.ship_data_statistics
local var_0_5 = pg.ship_data_template
local var_0_6 = pg.ship_skin_template
local var_0_7 = pg.enemy_data_statistics
local var_0_8 = pg.weapon_property
local var_0_9 = pg.formation_template
local var_0_10 = pg.auto_pilot_template
local var_0_11 = pg.aircraft_template
local var_0_13 = pg.equip_data_statistics
local var_0_14 = pg.equip_data_template
local var_0_15 = pg.spweapon_data_statistics
local var_0_17 = pg.ship_data_personality
local var_0_18 = pg.enemy_data_by_type
local var_0_19 = pg.ship_data_by_type
local var_0_20 = pg.ship_level
local var_0_21 = pg.skill_data_template
local var_0_22 = pg.ship_data_trans
local var_0_23 = pg.battle_environment_behaviour_template
local var_0_24 = pg.equip_skin_template
local var_0_25 = pg.activity_template
local var_0_26 = pg.activity_event_worldboss
local var_0_27 = pg.world_joint_boss_template
local var_0_28 = pg.world_boss_level
local var_0_29 = pg.guild_boss_event
local var_0_30 = pg.ship_strengthen_meta
local var_0_31 = pg.map_data
local var_0_32 = pg.strategy_data_template

ys.Battle.BattleDataFunction = ys.Battle.BattleDataFunction or {}

local var_0_33 = ys.Battle.BattleDataFunction

function ys.Battle.BattleDataFunction.CreateBattleUnitData(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9, arg_1_10, arg_1_11, arg_1_12)
	local var_1_0
	local var_1_1

	if arg_1_1 == var_0_1.UnitType.PLAYER_UNIT then
		var_1_0 = var_0_0.Battle.BattlePlayerUnit.New(arg_1_0, arg_1_2)

		var_1_0:SetSkinId(arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)

		var_1_1 = Ship.WEAPON_COUNT
	elseif arg_1_1 == var_0_1.UnitType.SUB_UNIT then
		var_1_0 = var_0_0.Battle.BattleSubUnit.New(arg_1_0, arg_1_2)

		var_1_0:SetSkinId(arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)

		var_1_1 = Ship.WEAPON_COUNT
	elseif arg_1_1 == var_0_1.UnitType.ENEMY_UNIT then
		var_1_0 = var_0_0.Battle.BattleEnemyUnit.New(arg_1_0, arg_1_2)

		var_1_0:SetOverrideLevel(arg_1_11)
	elseif arg_1_1 == var_0_1.UnitType.MINION_UNIT then
		var_1_0 = var_0_0.Battle.BattleMinionUnit.New(arg_1_0, arg_1_2)
	elseif arg_1_1 == var_0_1.UnitType.BOSS_UNIT then
		var_1_0 = var_0_0.Battle.BattleBossUnit.New(arg_1_0, arg_1_2)

		var_1_0:SetOverrideLevel(arg_1_11)
	elseif arg_1_1 == var_0_1.UnitType.CONST_UNIT then
		var_1_0 = var_0_0.Battle.BattleConstPlayerUnit.New(arg_1_0, arg_1_2)

		var_1_0:SetSkinId(arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)

		var_1_1 = Ship.WEAPON_COUNT
	elseif arg_1_1 == var_0_1.UnitType.CARDPUZZLE_PLAYER_UNIT then
		var_1_0 = var_0_0.Battle.BattleCardPuzzlePlayerUnit.New(arg_1_0, arg_1_2)

		var_1_0:SetSkinId(arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)
	elseif arg_1_1 == var_0_1.UnitType.SUPPORT_UNIT then
		var_1_0 = var_0_0.Battle.BattleSupportUnit.New(arg_1_0, arg_1_2)

		var_1_0:SetSkinId(arg_1_4)
		var_1_0:SetWeaponInfo(arg_1_9, arg_1_10)
	end

	var_1_0:SetTemplate(arg_1_3, arg_1_6, arg_1_7)

	if arg_1_1 == var_0_1.UnitType.MINION_UNIT then
		var_1_0:SetMaster(arg_1_12)
		var_1_0:InheritMasterAttr()
	end

	local var_1_2 = {}

	if arg_1_1 == var_0_1.UnitType.ENEMY_UNIT or arg_1_1 == var_0_1.UnitType.MINION_UNIT or arg_1_1 == var_0_1.UnitType.BOSS_UNIT then
		for iter_1_0, iter_1_1 in ipairs(arg_1_5) do
			var_1_2[#var_1_2 + 1] = {
				equipment = {
					weapon_id = {
						iter_1_1.id
					}
				}
			}
		end
	else
		for iter_1_2, iter_1_3 in ipairs(arg_1_5) do
			local var_1_3 = iter_1_3.equipmentInfo and iter_1_3.equipmentInfo:getConfig("torpedo_ammo") or 0

			if not iter_1_3.id then
				var_1_2[#var_1_2 + 1] = {
					equipment = false,
					torpedoAmmo = 0,
					skin = iter_1_3.skin
				}

				goto label_1_0
			end

			::label_1_0::

			if var_1_1 and iter_1_2 > var_1_1 then
				if #var_0_33.GetWeaponDataFromID(iter_1_3.id).weapon_id then
					({}).equipment = var_0_33.GetWeaponDataFromID(iter_1_3.id)
					;({}).skin = iter_1_3.skin
					;({}).torpedoAmmo = var_1_3
					var_1_2[#var_1_2 + 1] = {}
				else
					var_1_2[#var_1_2 + 1] = {
						equipment = false,
						skin = iter_1_3.skin,
						torpedoAmmo = var_1_3
					}
				end
			end
		end
	end

	var_1_0:SetProficiencyList(arg_1_8)
	var_1_0:SetEquipment(var_1_2)

	return var_1_0
end

function ys.Battle.BattleDataFunction.InitUnitSkill(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0.skills or {}

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		arg_2_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(iter_2_1.id, iter_2_1.level, arg_2_1)))
	end

	return
end

function ys.Battle.BattleDataFunction.GetEquipSkill(arg_3_0, arg_3_1)
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0) do
		if iter_3_1.id then
			local var_3_3 = var_0_33.GetWeaponDataFromID(iter_3_1.id)

			if var_3_3 then
				for iter_3_2, iter_3_3 in ipairs(var_3_3.skill_id) do
					local var_3_4 = arg_3_1 and var_0_33.SkillTranform(arg_3_1, iter_3_3[1]) or iter_3_3[1]
					local var_3_5 = iter_3_3[2]
					local var_3_6

					if not iter_3_3[2] then
						var_3_5 = 1
						var_3_6 = var_3_1
					end

					table.insert(var_3_1, {
						buffID = var_3_4,
						buffLV = var_3_5
					})
				end

				for iter_3_4, iter_3_5 in ipairs(var_3_3.hidden_skill_id) do
					local var_3_7 = arg_3_1 and var_0_33.SkillTranform(arg_3_1, iter_3_5[1]) or iter_3_5[1]
					local var_3_8 = iter_3_5[2]
					local var_3_9

					if not iter_3_5[2] then
						var_3_8 = 1
						var_3_9 = var_3_1
					end

					table.insert(var_3_1, {
						buffID = var_3_7,
						buffLV = var_3_8
					})
				end
			end
		end
	end

	return var_3_1
end

function ys.Battle.BattleDataFunction.AttachWeather(arg_4_0, arg_4_1)
	if table.contains(arg_4_1, var_0_1.WEATHER.NIGHT) then
		local var_4_0 = arg_4_0:GetTemplate().type

		if arg_4_0:GetFleetVO() then
			local var_4_1 = arg_4_0:GetFleetVO()

			if table.contains(ShipType.VanguardShipType, var_4_0) then
				local var_4_2 = var_4_1:GetFleetBias()

				var_4_2:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_SCOUT[var_4_2:GetCrewCount() + 1])
				var_4_2:AppendCrew(arg_4_0)
			elseif table.contains(ShipType.MainShipType, var_4_0) then
				var_4_1:AttachCloak(arg_4_0)
			elseif table.contains(ShipType.SubShipType, var_4_0) then
				local var_4_3 = var_0_0.Battle.BattleUnitAimBiasComponent.New()

				var_4_3:ConfigRangeFormula(var_0_0.Battle.BattleFormulas.CalculateMaxAimBiasRangeSub, var_0_0.Battle.BattleFormulas.CalculateBiasDecay)
				var_4_3:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_SUB)
				var_4_3:AppendCrew(arg_4_0)
				var_4_3:Active(var_4_3.STATE_ACTIVITING)
			end
		elseif arg_4_0:GetUnitType() == var_0_1.UnitType.ENEMY_UNIT or arg_4_0:GetUnitType() == var_0_1.UnitType.MINION_UNIT or arg_4_0:GetUnitType() == var_0_1.UnitType.BOSS_UNIT then
			local var_4_4 = var_0_0.Battle.BattleUnitAimBiasComponent.New()

			var_4_4:ConfigRangeFormula(var_0_0.Battle.BattleFormulas.CalculateMaxAimBiasRangeMonster, var_0_0.Battle.BattleFormulas.CalculateBiasDecayMonster)

			if table.contains(ShipType.SubShipType, var_4_0) then
				var_4_4:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_SUB)
			else
				var_4_4:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_MONSTER)
			end

			var_4_4:AppendCrew(arg_4_0)
			var_4_4:SetHostile()
			var_4_4:Active(var_4_4.STATE_SUMMON_SICKNESS)
		end
	end

	return
end

function ys.Battle.BattleDataFunction.AttachSmoke(arg_5_0)
	local var_5_0 = arg_5_0:GetUnitType()

	if var_5_0 == var_0_1.UnitType.ENEMY_UNIT or var_5_0 == var_0_1.UnitType.BOSS_UNIT then
		if arg_5_0:GetAimBias() then
			local var_5_1 = arg_5_0:GetAimBias()
			local var_5_2 = var_5_1:GetCurrentState()

			if var_5_2 == var_5_1.STATE_SKILL_EXPOSE then
				var_5_1:SomkeExitResume()
			elseif var_5_2 == var_5_1.STATE_ACTIVITING or var_5_2 == var_5_1.STATE_TOTAL_EXPOSE then
				var_5_1:SmokeRecover()
			end
		else
			local var_5_3 = var_0_0.Battle.BattleUnitAimBiasComponent.New()

			var_5_3:ConfigRangeFormula(var_0_0.Battle.BattleFormulas.CalculateMaxAimBiasRangeMonster, var_0_0.Battle.BattleFormulas.CalculateBiasDecayMonsterInSmoke)

			if table.contains(ShipType.SubShipType, shipType) then
				var_5_3:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_SUB)
			else
				var_5_3:ConfigMinRange(var_0_2.AIM_BIAS_MIN_RANGE_MONSTER)
			end

			var_5_3:AppendCrew(arg_5_0)
			var_5_3:SetHostile()
			var_5_3:Active(var_5_3.STATE_ACTIVITING)
		end
	end

	return
end

function ys.Battle.BattleDataFunction.InitEquipSkill(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs((var_0_33.GetEquipSkill(arg_6_0, arg_6_2))) do
		arg_6_1:AddBuff((var_0_0.Battle.BattleBuffUnit.New(iter_6_1.buffID, iter_6_1.buffLV, arg_6_1)))
	end

	return
end

function ys.Battle.BattleDataFunction.InitCommanderSkill(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0 = arg_7_0 or {}

	local var_7_0 = var_0_0.Battle.BattleState.GetInstance():GetBattleType()

	for iter_7_0, iter_7_1 in pairs(arg_7_0) do
		local var_7_1 = var_0_0.Battle.BattleDataFunction.GetBuffTemplate(iter_7_1.id, iter_7_1.level).limit
		local var_7_2 = false

		if var_7_1 then
			for iter_7_2, iter_7_3 in ipairs(var_7_1) do
				if var_7_0 == iter_7_3 then
					var_7_2 = true

					break
				end
			end
		end

		if not var_7_2 then
			local var_7_3 = var_0_0.Battle.BattleBuffUnit.New(iter_7_1.id, iter_7_1.level, arg_7_1)

			var_7_3:SetCommander(iter_7_1.commander)
			arg_7_1:AddBuff(var_7_3)
		end
	end

	return
end

function ys.Battle.BattleDataFunction.CreateWeaponUnit(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_3 = arg_8_3 or -1

	local var_8_0 = arg_8_1:GetUnitType()
	local var_8_1
	local var_8_2 = var_0_33.GetWeaponPropertyDataFromID(arg_8_0)

	assert(var_8_2 ~= nil, "找不到武器配置：id = " .. arg_8_0)

	local var_8_3 = arg_8_4 or var_8_2.type

	if (arg_8_4 or var_8_2.type) == var_0_1.EquipmentType.MAIN_CANNON then
		var_8_1 = var_0_0.Battle.BattleWeaponUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.SUB_CANNON then
		var_8_1 = var_0_0.Battle.BattleWeaponUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.TORPEDO then
		var_8_1 = var_0_0.Battle.BattleTorpedoUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.MANUAL_TORPEDO then
		var_8_1 = var_0_0.Battle.BattleManualTorpedoUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.ANTI_AIR then
		var_8_1 = var_0_0.Battle.BattleAntiAirUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.FLEET_ANTI_AIR or var_8_3 == var_0_1.EquipmentType.FLEET_RANGE_ANTI_AIR then
		var_8_1 = var_0_0.Battle.BattleWeaponUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.INTERCEPT_AIRCRAFT or var_8_3 == var_0_1.EquipmentType.STRIKE_AIRCRAFT then
		var_8_1 = var_8_0 == var_0_1.UnitType.SUPPORT_UNIT and var_0_0.Battle.BattleSupportHiveUnit.New() or var_0_0.Battle.BattleHiveUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.SPECIAL then
		var_8_1 = var_0_0.Battle.BattleSpecialWeapon.New()
	elseif var_8_3 == var_0_1.EquipmentType.ANTI_SEA then
		var_8_1 = var_0_0.Battle.BattleDirectHitWeaponUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.HAMMER_HEAD then
		var_8_1 = var_0_0.Battle.BattleHammerHeadWeaponUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.BOMBER_PRE_CAST_ALERT then
		var_8_1 = var_0_0.Battle.BattleBombWeaponUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.POINT_HIT_AND_LOCK or var_8_3 == var_0_1.EquipmentType.MANUAL_MISSILE or var_8_3 == var_0_1.EquipmentType.MANUAL_METEOR then
		var_8_1 = var_0_0.Battle.BattlePointHitWeaponUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.POINT_AIR_STRIKE then
		var_8_1 = var_0_0.Battle.BattlePointAirStrikeUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.BEAM then
		var_8_1 = var_0_0.Battle.BattleLaserUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.DEPTH_CHARGE then
		var_8_1 = var_0_0.Battle.BattleDepthChargeUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.REPEATER_ANTI_AIR then
		var_8_1 = var_0_0.Battle.BattleRepeaterAntiAirUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.DISPOSABLE_TORPEDO then
		var_8_1 = var_0_0.Battle.BattleDisposableTorpedoUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.SPACE_LASER then
		var_8_1 = var_0_0.Battle.BattleSpaceLaserWeaponUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.MISSILE then
		var_8_1 = var_0_0.Battle.BattleMissileWeaponUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.MANUAL_AAMISSILE then
		var_8_1 = var_0_0.Battle.BattleManualAAMissileUnit.New()
	elseif var_8_3 == var_0_1.EquipmentType.AUTO_MISSILE then
		var_8_1 = var_0_0.Battle.BattleAutoMissileUnit.New()
	end

	assert(var_8_1 ~= nil, "创建武器失败，不存在该类型的武器：id = " .. arg_8_0)
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

function ys.Battle.BattleDataFunction.CreateAircraftUnit(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0
	local var_9_1 = var_0_33.GetAircraftTmpDataFromID(arg_9_1)

	assert(var_9_1 ~= nil, "找不到飞机配置：id = " .. arg_9_1)

	var_9_0 = type(var_9_1.funnel_behavior) == "table" and (var_9_1.funnel_behavior.hover_range and var_0_0.Battle.BattelUAVUnit.New(arg_9_0) or var_9_1.funnel_behavior.AI and var_0_0.Battle.BattlePatternFunnelUnit.New(arg_9_0) or var_0_0.Battle.BattleFunnelUnit.New(arg_9_0)) or var_0_0.Battle.BattleAircraftUnit.New(arg_9_0)

	var_9_0:SetMotherUnit(arg_9_2)
	var_9_0:SetWeanponPotential(arg_9_3)
	var_9_0:SetTemplate(var_9_1)

	return var_9_0
end

function ys.Battle.BattleDataFunction.CreateAllInStrike(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(var_0_33.GetPlayerShipModelFromID((arg_10_0:GetTemplateID())).airassist_time) do
		local var_10_1 = var_0_0.Battle.BattleAllInStrike.New(iter_10_1)

		var_10_1:SetHost(arg_10_0)

		;({})[iter_10_0] = var_10_1
	end

	return {}
end

function ys.Battle.BattleDataFunction.ExpandAllinStrike(arg_11_0)
	local var_11_0 = var_0_33.GetPlayerShipModelFromID((arg_11_0:GetTemplateID())).airassist_time

	if #var_11_0 > 0 then
		local var_11_1 = var_0_0.Battle.BattleAllInStrike.New(var_11_0[#var_11_0])

		var_11_1:SetHost(arg_11_0)
		arg_11_0:GetFleetVO():GetAirAssistVO():AppendWeapon(var_11_1)
		var_11_1:OverHeat()
		arg_11_0:GetAirAssistQueue():AppendWeapon(var_11_1)

		local var_11_2 = arg_11_0:GetAirAssistList()

		var_11_2[#var_11_2 + 1] = var_11_1
	end

	return
end

function ys.Battle.BattleDataFunction.CreateAirFighterUnit(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0.Battle.BattleAirFighterUnit.New(arg_12_0)

	;(nil):SetWeaponTemplateID(arg_12_1.weaponID)
	var_12_0:SetBackwardWeaponID(arg_12_1.backwardWeaponID)
	var_12_0:SetTemplate((var_0_33.GetAircraftTmpDataFromID(arg_12_1.templateID)))

	return var_12_0
end

function ys.Battle.BattleDataFunction.GetPlayerShipTmpDataFromID(arg_13_0)
	assert(var_0_4[arg_13_0] ~= nil, ">>ship_data_statistics<< 找不到玩家船只配置：id = " .. arg_13_0)

	return Clone(var_0_4[arg_13_0])
end

function ys.Battle.BattleDataFunction.GetPlayerShipModelFromID(arg_14_0)
	assert(var_0_5[arg_14_0] ~= nil, ">>ship_data_template<< 找不到玩家船只模组配置：id = " .. arg_14_0)

	return var_0_5[arg_14_0]
end

function ys.Battle.BattleDataFunction.GetPlayerShipSkinDataFromID(arg_15_0)
	assert(var_0_6[arg_15_0] ~= nil, ">>ship_skin_template<< 找不到舰娘皮肤配置：id = " .. arg_15_0)

	return var_0_6[arg_15_0]
end

function ys.Battle.BattleDataFunction.GetShipTypeTmp(arg_16_0)
	assert(var_0_19[arg_16_0] ~= nil, ">>ship_data_by_type<< 找不到舰船类型配置：id = " .. arg_16_0)

	return var_0_19[arg_16_0]
end

function ys.Battle.BattleDataFunction.GetMonsterTmpDataFromID(arg_17_0)
	assert(var_0_7[arg_17_0] ~= nil, ">>enemy_data_statistics<< 找不到敌方船只配置：id = " .. arg_17_0)

	return var_0_7[arg_17_0]
end

function ys.Battle.BattleDataFunction.GetAircraftTmpDataFromID(arg_18_0)
	assert(var_0_11[arg_18_0] ~= nil, ">>aircraft_template<< 找不到飞机配置：id = " .. arg_18_0)

	return var_0_11[arg_18_0]
end

function ys.Battle.BattleDataFunction.GetWeaponDataFromID(arg_19_0)
	if arg_19_0 ~= Equipment.EQUIPMENT_STATE_EMPTY and arg_19_0 ~= Equipment.EQUIPMENT_STATE_LOCK then
		assert(var_0_13[arg_19_0] ~= nil, ">>equip_data_statistics<< 找不到武器类装备配置：id = " .. arg_19_0)
	end

	return var_0_13[arg_19_0]
end

function ys.Battle.BattleDataFunction.GetEquipDataTemplate(arg_20_0)
	assert(var_0_14[arg_20_0] ~= nil, ">>equip_data_template<< 找不到武器装备模板：id = " .. arg_20_0)

	return var_0_14[arg_20_0]
end

function ys.Battle.BattleDataFunction.GetSpWeaponDataFromID(arg_21_0)
	assert(var_0_15[arg_21_0] ~= nil, ">>spweapon_data_statistics<< 找不到特殊兵装配置：id = " .. arg_21_0)

	return var_0_15[arg_21_0]
end

function ys.Battle.BattleDataFunction.GetWeaponPropertyDataFromID(arg_22_0)
	assert(var_0_8[arg_22_0] ~= nil, ">>weapon_property<< 找不到武器行为配置：id = " .. arg_22_0)

	return var_0_8[arg_22_0]
end

function ys.Battle.BattleDataFunction.GetFormationTmpDataFromID(arg_23_0)
	assert(var_0_9[arg_23_0] ~= nil, ">>formation_template<<找不到阵型配置：id = " .. arg_23_0)

	return var_0_9[arg_23_0]
end

function ys.Battle.BattleDataFunction.GetAITmpDataFromID(arg_24_0)
	assert(var_0_10[arg_24_0] ~= nil, ">>auto_pilot_template<< 找不到移动ai配置：id = " .. arg_24_0)

	return var_0_10[arg_24_0]
end

function ys.Battle.BattleDataFunction.GetShipPersonality(arg_25_0)
	assert(var_0_17[arg_25_0] ~= nil, ">>shipPersonality<< 找不到性格配置：id = " .. arg_25_0)

	return var_0_17[arg_25_0]
end

function ys.Battle.BattleDataFunction.GetEnemyTypeDataByType(arg_26_0)
	assert(var_0_18[arg_26_0] ~= nil, ">>enemy_data_by_type<< 找不到怪物类型：type = " .. arg_26_0)

	return var_0_18[arg_26_0]
end

function ys.Battle.BattleDataFunction.GetArenaBuffByShipType(arg_27_0)
	return var_0_33.GetShipTypeTmp(arg_27_0).arena_buff
end

function ys.Battle.BattleDataFunction.GetPlayerUnitDurabilityExtraAddition(arg_28_0, arg_28_1)
	if arg_28_0 == SYSTEM_DUEL then
		assert(var_0_20[arg_28_1] ~= nil, ">>ship_level<< 找不到等级配置：level = " .. arg_28_1)

		return var_0_20[arg_28_1].arena_durability_ratio, var_0_20[arg_28_1].arena_durability_add
	else
		return 1, 0
	end

	return
end

function ys.Battle.BattleDataFunction.GetSkillDataTemplate(arg_29_0)
	return var_0_21[arg_29_0]
end

function ys.Battle.BattleDataFunction.GetShipTransformDataTemplate(arg_30_0)
	return var_0_22[var_0_33.GetPlayerShipModelFromID(arg_30_0).group_type]
end

function ys.Battle.BattleDataFunction.GetShipMetaFromDataTemplate(arg_31_0)
	return var_0_30[var_0_33.GetPlayerShipModelFromID(arg_31_0).group_type]
end

function ys.Battle.BattleDataFunction.GetEquipSkinDataFromID(arg_32_0)
	assert(var_0_24[arg_32_0] ~= nil, ">>equip_skin_template<< 找不到装备皮肤配置：id = " .. arg_32_0)

	return var_0_24[arg_32_0]
end

function ys.Battle.BattleDataFunction.GetEquipSkin(arg_33_0)
	assert(var_0_24[arg_33_0] ~= nil, ">>equip_skin_template<< 找不到装备皮肤配置：id = " .. arg_33_0)

	return var_0_24[arg_33_0].bullet_name, var_0_24[arg_33_0].derivate_bullet, var_0_24[arg_33_0].derivate_torpedo, var_0_24[arg_33_0].derivate_boom, var_0_24[arg_33_0].fire_fx_name, var_0_24[arg_33_0].hit_fx_name
end

function ys.Battle.BattleDataFunction.GetEquipSkinSFX(arg_34_0)
	assert(var_0_24[arg_34_0] ~= nil, ">>equip_skin_template<< 找不到装备皮肤配置：id = " .. arg_34_0)

	return var_0_24[arg_34_0].hit_sfx, var_0_24[arg_34_0].miss_sfx
end

function ys.Battle.BattleDataFunction.GetSpecificGuildBossEnemyList(arg_35_0, arg_35_1)
	local var_35_0 = {}

	if var_0_29[arg_35_0].expedition_id[1] == arg_35_1 then
		var_35_0 = var_0_29[arg_35_0].expedition_id[2]
	end

	return var_35_0
end

function ys.Battle.BattleDataFunction.GetSpecificEnemyList(arg_36_0, arg_36_1)
	local var_36_0

	for iter_36_0, iter_36_1 in ipairs(var_0_26[var_0_25[arg_36_0].config_id].ex_expedition_enemy) do
		if iter_36_1[1] == arg_36_1 then
			var_36_0 = iter_36_1[2]

			break
		end
	end

	return var_36_0
end

function ys.Battle.BattleDataFunction.GetMetaBossTemplate(arg_37_0)
	return var_0_27[arg_37_0]
end

function ys.Battle.BattleDataFunction.GetMetaBossLevelTemplate(arg_38_0, arg_38_1)
	return var_0_28[var_0_33.GetMetaBossTemplate(arg_38_0).boss_level_id + (arg_38_1 - 1)]
end

function ys.Battle.BattleDataFunction.GetSpecificWorldJointEnemyList(arg_39_0, arg_39_1, arg_39_2)
	return {
		var_0_33.GetMetaBossLevelTemplate(arg_39_1, arg_39_2).enemy_id
	}
end

function ys.Battle.BattleDataFunction.IncreaseAttributes(arg_40_0, arg_40_1, arg_40_2)
	for iter_40_0, iter_40_1 in ipairs(arg_40_2) do
		if iter_40_1[arg_40_1] ~= nil and type(iter_40_1[arg_40_1]) == "number" then
			arg_40_0 = arg_40_0 + iter_40_1[arg_40_1]
		end
	end

	return
end

function ys.Battle.BattleDataFunction.CreateAirFighterWeaponUnit(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	local var_41_0
	local var_41_1 = var_0_33.GetWeaponPropertyDataFromID(arg_41_0)

	assert(var_41_1 ~= nil, "找不到武器配置：id = " .. arg_41_0)

	if var_41_1.type == var_0_1.EquipmentType.MAIN_CANNON then
		var_41_0 = var_0_0.Battle.BattleWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.SUB_CANNON then
		var_41_0 = var_0_0.Battle.BattleWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.TORPEDO then
		var_41_0 = var_0_0.Battle.BattleTorpedoUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.ANTI_AIR then
		var_41_0 = var_0_0.Battle.BattleAntiAirUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.ANTI_SEA then
		var_41_0 = var_0_0.Battle.BattleDirectHitWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.HAMMER_HEAD then
		var_41_0 = var_0_0.Battle.BattleHammerHeadWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.BOMBER_PRE_CAST_ALERT then
		var_41_0 = var_0_0.Battle.BattleBombWeaponUnit.New()
	elseif var_41_1.type == var_0_1.EquipmentType.DEPTH_CHARGE then
		var_41_0 = var_0_0.Battle.BattleDepthChargeUnit.New()
	end

	assert(var_41_0 ~= nil, "创建武器失败，不存在该类型的武器：id = " .. arg_41_0)
	var_41_0:SetPotentialFactor(arg_41_3)

	local var_41_2 = Clone(var_41_1)

	var_41_2.spawn_bound = "weapon"

	var_41_0:SetTemplateData(var_41_2)
	var_41_0:SetHostData(arg_41_1, arg_41_2)

	return var_41_0
end

function ys.Battle.BattleDataFunction.GetWords(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0, var_42_1, var_42_2 = ShipWordHelper.GetWordAndCV(arg_42_0, arg_42_1, 1, true, arg_42_2)

	return var_42_2
end

function ys.Battle.BattleDataFunction.SkillTranform(arg_43_0, arg_43_1)
	local var_43_0 = var_0_33.GetSkillDataTemplate(arg_43_1)

	if not var_43_0 then
		return arg_43_1
	end

	local var_43_1 = var_43_0.system_transform

	if var_43_0.system_transform[arg_43_0] == nil then
		return arg_43_1
	else
		return var_43_1[arg_43_0]
	end

	return
end

function ys.Battle.BattleDataFunction.GenerateHiddenBuff(arg_44_0)
	for iter_44_0, iter_44_1 in ipairs(var_0_33.GetPlayerShipModelFromID(arg_44_0).hide_buff_list) do
		({}).level = 1
		;({}).id = iter_44_1
		;({})[iter_44_1] = {}
	end

	return {}
end

function ys.Battle.BattleDataFunction.GetDivingFilter(arg_45_0)
	return var_0_31[arg_45_0].diving_filter
end

function ys.Battle.BattleDataFunction.GeneratePlayerSubmarinPhase(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	return {
		{
			index = 0,
			switchType = 3,
			switchTo = 1,
			switchParam = arg_46_0 - arg_46_2
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

function ys.Battle.BattleDataFunction.GetEnvironmentBehaviour(arg_47_0)
	assert(var_0_23[arg_47_0] ~= nil, ">>battle_environment_behaviour_template<< 找不到环境行为配置：id = " .. arg_47_0)

	return var_0_23[arg_47_0]
end

function ys.Battle.BattleDataFunction.AttachUltimateBonus(arg_48_0)
	local var_48_0 = arg_48_0:GetTemplateID()

	if not Ship.IsMaxStarByTmpID(var_48_0) then
		return
	end

	for iter_48_0, iter_48_1 in ipairs(var_0_33.GetPlayerShipModelFromID(var_48_0).specific_type) do
		if iter_48_1 == ShipType.SpecificTypeTable.gunner then
			var_0_3.SetCurrent(arg_48_0, "barrageCounterMod", var_0_1.UltimateBonus.GunnerCountMod)
		elseif iter_48_1 == ShipType.SpecificTypeTable.torpedo then
			arg_48_0:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_0_1.UltimateBonus.TorpedoBarrageBuff)))
		elseif iter_48_1 == ShipType.SpecificTypeTable.auxiliary then
			var_0_33.AuxBoost(arg_48_0)
		end
	end

	return
end

function ys.Battle.BattleDataFunction.AuxBoost(arg_49_0)
	for iter_49_0, iter_49_1 in ipairs((arg_49_0:GetEquipment())) do
		if iter_49_1 and iter_49_1.equipment and table.contains(EquipType.DeviceEquipTypes, iter_49_1.equipment.type) then
			for iter_49_2 = 1, 3 do
				if iter_49_1.equipment["attribute_" .. iter_49_2] then
					local var_49_0 = AttributeType.ConvertBattleAttrName(iter_49_1.equipment["attribute_" .. iter_49_2])

					var_0_3.SetCurrent(arg_49_0, var_49_0, var_0_3.GetBase(arg_49_0, var_49_0) + iter_49_1.equipment["value_" .. iter_49_2] * var_0_1.UltimateBonus.AuxBoostValue)
					var_0_3.SetBaseAttr(arg_49_0)
				end
			end
		end
	end

	return
end

function ys.Battle.BattleDataFunction.GetSLGStrategyBuffByCombatBuffID(arg_50_0)
	for iter_50_0, iter_50_1 in ipairs(var_0_32.all) do
		if iter_50_1 == arg_50_0 then
			return var_0_32[arg_50_0]
		end
	end

	return
end

return
