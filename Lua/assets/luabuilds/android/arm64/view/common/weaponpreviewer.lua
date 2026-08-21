local var_0_0 = class("WeaponPreviewer")
local var_0_1 = Vector3(0, 1, 40)
local var_0_2 = Vector3(40, 1, 40)
local var_0_3 = Vector3(30, 0, 0)
local var_0_4 = Vector3(0.1, 0.1, 0.1)
local var_0_5 = Vector3(330, 0, 0)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.rawImage = arg_1_1

	setActive(arg_1_0.rawImage, false)

	arg_1_0.seaCameraGO = GameObject.Find("BarrageCamera")
	arg_1_0.seaCamera = arg_1_0.seaCameraGO:GetComponent(typeof(Camera))
	arg_1_0.seaCamera.targetTexture = arg_1_0.rawImage.texture
	arg_1_0.seaCamera.enabled = true
	arg_1_0.displayFireFX = true
	arg_1_0.displayHitFX = false

	return
end

function var_0_0.configUI(arg_2_0, arg_2_1)
	arg_2_0.healTF = arg_2_1

	setActive(arg_2_0.healTF, false)
	arg_2_0.healTF:GetComponent("DftAniEvent"):SetEndEvent(function()
		setActive(arg_2_0.healTF, false)
		setText(arg_2_0.healTF:Find("text"), "")

		return
	end)

	return
end

function var_0_0.setDisplayWeapon(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.weaponIds = arg_4_1
	arg_4_0.equipSkinId = arg_4_2 or 0

	arg_4_0:onWeaponUpdate()

	return
end

function var_0_0.SetFXMode(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.displayFireFX = arg_5_1
	arg_5_0.displayHitFX = arg_5_2

	return
end

function var_0_0.load(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	assert(not arg_6_0.loading and not arg_6_0.loaded, "load function can be called only once.")

	arg_6_0.loading = true
	arg_6_0.shipVO = arg_6_2

	ys.Battle.BattleVariable.Init(true)
	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_6_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_6_0:Init()
	var_6_0:AddPreloadResource(var_6_0.GetMapResource(arg_6_1))
	var_6_0:AddPreloadResource(var_6_0.GetDisplayCommonResource())

	if arg_6_0.equipSkinId > 0 then
		var_6_0:AddPreloadResource(var_6_0.GetEquipSkinPreviewRes(arg_6_0.equipSkinId))
	end

	var_6_0:AddPreloadResource(var_6_0.GetShipResource(arg_6_2.configId, arg_6_2.skinId), false)

	if arg_6_2:getShipType() ~= ShipType.WeiXiu then
		for iter_6_0, iter_6_1 in ipairs(arg_6_3) do
			if iter_6_1 ~= 0 then
				for iter_6_2, iter_6_3 in ipairs(ys.Battle.BattleDataFunction.GetWeaponDataFromID(iter_6_1).weapon_id) do
					var_6_0:AddPreloadResource(var_6_0.GetWeaponResource(iter_6_3))
				end
			end
		end
	end

	var_6_0:StartPreload(function()
		arg_6_0.seaView = ys.Battle.BattleMap.New(arg_6_1)

		local function var_7_0(arg_8_0)
			arg_6_0.loading = false
			arg_6_0.loaded = true

			pg.UIMgr.GetInstance():LoadingOff()

			arg_6_0.seaCharacter = arg_8_0

			local var_8_0 = arg_6_2:getConfig("scale") / 50

			arg_8_0.transform.localScale = Vector3(var_8_0, var_8_0, var_8_0)
			arg_8_0.transform.localPosition = var_0_1
			arg_8_0.transform.localEulerAngles = var_0_3
			arg_6_0.seaAnimator = arg_8_0.transform:GetComponent("SpineAnim")
			arg_6_0.skeletonAnimation = arg_8_0.transform:GetComponent("SkeletonAnimation")
			arg_6_0.characterAction = ys.Battle.BattleConst.ActionName.MOVE

			arg_6_0:setSeaAction(arg_6_0.characterAction, 0, true)

			arg_6_0.seaFXList = {}
			arg_6_0._FXAttachPoint = GameObject()

			arg_6_0._FXAttachPoint.transform:SetParent(arg_8_0.transform, false)

			arg_6_0._FXAttachPoint.transform.localPosition = Vector3.zero
			arg_6_0._FXAttachPoint.transform.localEulerAngles = var_0_5

			for iter_8_0, iter_8_1 in ipairs(ys.Battle.BattleConst.FXContainerIndex) do
				({})[iter_8_0] = Vector3(pg.ship_skin_template[arg_6_2.skinId].fx_container[iter_8_0][1], pg.ship_skin_template[arg_6_2.skinId].fx_container[iter_8_0][2], pg.ship_skin_template[arg_6_2.skinId].fx_container[iter_8_0][3])
			end

			arg_6_0._FXOffset = {}

			if arg_6_0.equipSkinId > 0 then
				arg_6_0:attachOrbit()
			end

			local var_8_1 = ys.Battle.BattleFXPool.GetInstance()

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_8_1:GetCharacterFX("movewave", arg_6_0), Vector3.zero, true)

			arg_6_0.seaFXPool = var_8_1

			if arg_6_2:getShipType() ~= ShipType.WeiXiu then
				arg_6_0.boneList = {}

				for iter_8_2, iter_8_3 in pairs(pg.ship_skin_template[arg_6_2.skinId].bound_bone) do
					for iter_8_4, iter_8_5 in ipairs(iter_8_3) do
						if type(iter_8_5) == "table" then
							({})[#{} + 1] = Vector3(iter_8_5[1], iter_8_5[2], iter_8_5[3])
						else
							({})[#{} + 1] = Vector3.zero
						end
					end

					arg_6_0.boneList[iter_8_2] = arg_8_0.transform.localToWorldMatrix:MultiplyPoint3x4(({})[1])
				end

				arg_6_0:SeaUpdate()
			end

			setActive(arg_6_0.rawImage, true)
			pg.TimeMgr.GetInstance():ResumeBattleTimer()
			arg_6_0:onWeaponUpdate()
			arg_6_4()

			return
		end

		var_6_0:InstCharacter(arg_6_2:getPrefab(), function(arg_9_0)
			var_7_0(arg_9_0)

			return
		end)

		return
	end, nil)
	pg.UIMgr.GetInstance():LoadingOn()

	return
end

function var_0_0.attachOrbit(arg_10_0)
	local var_10_0 = pg.equip_skin_template[arg_10_0.equipSkinId]

	if pg.equip_skin_template[arg_10_0.equipSkinId].orbit_combat ~= "" then
		arg_10_0.orbitList = {}

		ResourceMgr.Inst:getAssetAsync(ys.Battle.BattleResourceManager.GetOrbitPath(pg.equip_skin_template[arg_10_0.equipSkinId].orbit_combat), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_11_0)
			if arg_10_0.seaCharacter then
				local var_11_0 = Object.Instantiate(arg_11_0)

				table.insert(arg_10_0.orbitList, var_11_0)

				var_11_0.transform.localPosition = Vector3(var_10_0.orbit_combat_bound[2][1], var_10_0.orbit_combat_bound[2][2], var_10_0.orbit_combat_bound[2][3])

				local var_11_1 = SpineAnim.AddFollower(var_10_0.orbit_combat_bound[1], arg_10_0.seaCharacter.transform, var_11_0.transform):GetComponent("Spine.Unity.BoneFollower")

				if var_10_0.orbit_rotate then
					var_11_1.followBoneRotation = true
					var_11_0.transform.localEulerAngles = Vector3(var_11_0.transform.localEulerAngles.x, var_11_0.transform.localEulerAngles.y, var_11_0.transform.localEulerAngles.z - 90)
				else
					var_11_1.followBoneRotation = false
				end
			end

			return
		end), true, true)
	end

	return
end

function var_0_0.setSeaAction(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0.seaAnimator then
		arg_12_0.seaAnimator:SetAction(SpineAnimUtil.GetCharAnimDirect(arg_12_0.skeletonAnimation, 1, arg_12_1), 0, arg_12_3)
	end

	return
end

function var_0_0.playShipAnims(arg_13_0)
	if arg_13_0.loaded and arg_13_0.seaAnimator then
		local var_13_0 = {
			"attack",
			"victory",
			"dead"
		}

		local function var_13_1(arg_14_0)
			if arg_13_0.seaAnimator then
				arg_13_0.seaAnimator:SetActionCallBack(nil)
			end

			arg_13_0:setSeaAction(var_13_0[arg_14_0], 0, false)
			arg_13_0.seaAnimator:SetActionCallBack(function(arg_15_0)
				if arg_15_0 == "finish" then
					arg_13_0.seaAnimator:SetActionCallBack(nil)
					arg_13_0:setSeaAction("stand", 0, false)
				end

				return
			end)

			return
		end

		if arg_13_0.palyAnimTimer then
			arg_13_0.palyAnimTimer:Stop()

			arg_13_0.palyAnimTimer = nil
		end

		arg_13_0.palyAnimTimer = Timer.New(function()
			var_13_1(math.random(1, #var_13_0))

			return
		end, 5, -1)

		arg_13_0.palyAnimTimer:Start()
		arg_13_0.palyAnimTimer.func()
	end

	return
end

function var_0_0.onWeaponUpdate(arg_17_0)
	if arg_17_0.loaded and arg_17_0.weaponIds then
		if arg_17_0.seaAnimator then
			arg_17_0.seaAnimator:SetActionCallBack(nil)
		end

		if #arg_17_0.weaponIds == 0 and arg_17_0.playRandomAnims then
			if arg_17_0._fireTimer then
				arg_17_0._fireTimer:Stop()
			end

			if arg_17_0._delayTimer then
				arg_17_0._delayTimer:Stop()
			end

			if arg_17_0.shipVO:getShipType() ~= ShipType.WeiXiu then
				var_17_0()
			elseif arg_17_0.buffTimer then
				pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_17_0.buffTimer)

				arg_17_0.buffTimer = nil
			end

			arg_17_0:playShipAnims()
		elseif arg_17_0.shipVO:getShipType() ~= ShipType.WeiXiu then
			var_17_0()
			arg_17_0:MakeWeapon(arg_17_0.weaponIds)
			arg_17_0:SeaFire()
		else
			local var_17_1 = arg_17_0.weaponIds[1]

			if arg_17_0.weaponIds[1] then
				local var_17_2 = Equipment.getConfigData(var_17_1).skill_id[1]

				arg_17_0:MakeBuff(var_17_2 and var_17_2[1])
			end
		end
	end

	return
end

function var_0_0.SeaFire(arg_19_0)
	local var_19_0 = 1

	if arg_19_0._fireTimer then
		arg_19_0._delayTimer:Stop()
		arg_19_0._fireTimer:Stop()
		arg_19_0._fireTimer:Start()
	else
		arg_19_0._fireTimer = pg.TimeMgr.GetInstance():AddBattleTimer("barrageFireTimer", -1, 1.5, function()
			local var_20_0 = arg_19_0.weaponList[var_19_0]

			if arg_19_0.weaponList[var_19_0] then
				local function var_20_1()
					for iter_21_0, iter_21_1 in ipairs(var_20_0.emitterList) do
						iter_21_1:Ready()
					end

					for iter_21_2, iter_21_3 in ipairs(var_20_0.emitterList) do
						iter_21_3:Fire(nil, 1, 0)
					end

					local var_21_0 = var_20_0.tmpData.fire_fx

					if arg_19_0.equipSkinId > 0 then
						local var_21_1, var_21_2, var_21_3, var_21_4, var_21_5, var_21_6 = ys.Battle.BattleDataFunction.GetEquipSkin(arg_19_0.equipSkinId)

						if var_21_5 ~= "" then
							var_21_0 = var_21_5
						end
					end

					if var_21_0 and var_21_0 ~= "" and arg_19_0.displayFireFX then
						arg_19_0.seaFXPool:GetCharacterFX(var_21_0, arg_19_0, true, function()
							return
						end)
					end

					var_19_0 = var_19_0 + 1

					return
				end

				if arg_19_0.weaponList[var_19_0].tmpData.action_index ~= "" then
					arg_19_0.characterAction = arg_19_0.weaponList[var_19_0].tmpData.action_index

					arg_19_0:setSeaAction(arg_19_0.characterAction, 0, false)
					arg_19_0.seaAnimator:SetActionCallBack(function(arg_23_0)
						if arg_23_0 == "action" then
							var_20_1()
						end

						return
					end)
				else
					(function()
						for iter_21_0, iter_21_1 in ipairs(var_20_0.emitterList) do
							iter_21_1:Ready()
						end

						for iter_21_2, iter_21_3 in ipairs(var_20_0.emitterList) do
							iter_21_3:Fire(nil, 1, 0)
						end

						local var_21_0 = var_20_0.tmpData.fire_fx

						if arg_19_0.equipSkinId > 0 then
							local var_21_1, var_21_2, var_21_3, var_21_4, var_21_5, var_21_6 = ys.Battle.BattleDataFunction.GetEquipSkin(arg_19_0.equipSkinId)

							if var_21_5 ~= "" then
								var_21_0 = var_21_5
							end
						end

						if var_21_0 and var_21_0 ~= "" and arg_19_0.displayFireFX then
							arg_19_0.seaFXPool:GetCharacterFX(var_21_0, arg_19_0, true, function()
								return
							end)
						end

						var_19_0 = var_19_0 + 1

						return
					end)()
				end
			elseif arg_19_0.characterAction ~= ys.Battle.BattleConst.ActionName.MOVE then
				arg_19_0.characterAction = ys.Battle.BattleConst.ActionName.MOVE

				arg_19_0:setSeaAction(arg_19_0.characterAction, 0, true)

				var_19_0 = 1

				arg_19_0._fireTimer:Pause()
				arg_19_0._delayTimer:Start()
			end

			return
		end)
		arg_19_0._delayTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, 3, function()
			arg_19_0._delayTimer:Stop()
			arg_19_0._fireTimer:Resume()

			return
		end, nil, true)
	end

	return
end

function var_0_0.MakeBuff(arg_25_0, arg_25_1)
	local var_25_0 = getSkillConfig(arg_25_1)
	local var_25_1 = pg.skillCfg["skill_" .. var_25_0.effect_list[1].arg_list.skill_id]

	if arg_25_0.buffTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(arg_25_0.buffTimer)

		arg_25_0.buffTimer = nil
	end

	arg_25_0.buffTimer = pg.TimeMgr.GetInstance():AddBattleTimer("buffTimer", -1, var_25_0.effect_list[1].arg_list.time, function()
		setActive(arg_25_0.healTF, true)
		setText(arg_25_0.healTF:Find("text"), var_25_1.effect_list[1].arg_list.number)

		return
	end)

	return
end

function var_0_0.MakeWeapon(arg_27_0, arg_27_1)
	arg_27_0.weaponList = {}
	arg_27_0.bulletList = {}
	arg_27_0.aircraftList = {}

	local var_27_0 = 0

	for iter_27_0, iter_27_1 in ipairs(arg_27_1) do
		for iter_27_2, iter_27_3 in ipairs(Equipment.getConfigData(iter_27_1).weapon_id) do
			if iter_27_3 <= 0 then
				break
			end

			var_27_0 = var_27_0 + 1

			local var_27_1 = ys.Battle.BattleDataFunction.GetWeaponPropertyDataFromID(iter_27_3)

			if var_27_1.type == ys.Battle.BattleConst.EquipmentType.MAIN_CANNON or var_27_1.type == ys.Battle.BattleConst.EquipmentType.SUB_CANNON or var_27_1.type == ys.Battle.BattleConst.EquipmentType.TORPEDO or var_27_1.type == ys.Battle.BattleConst.EquipmentType.MANUAL_TORPEDO or var_27_1.type == ys.Battle.BattleConst.EquipmentType.POINT_HIT_AND_LOCK then
				if type(var_27_1.barrage_ID) == "table" then
					arg_27_0.weaponList[var_27_0] = {
						tmpData = var_27_1,
						emitterList = {}
					}

					for iter_27_4, iter_27_5 in ipairs(var_27_1.barrage_ID) do
						arg_27_0.weaponList[var_27_0].emitterList[iter_27_4] = arg_27_0:createEmitterCannon(iter_27_5, var_27_1.bullet_ID[iter_27_4], var_27_1.spawn_bound)
					end
				end
			elseif var_27_1.type == ys.Battle.BattleConst.EquipmentType.PREVIEW_ARICRAFT and type(var_27_1.barrage_ID) == "table" then
				arg_27_0.weaponList[var_27_0] = {
					tmpData = var_27_1,
					emitterList = {}
				}

				for iter_27_6, iter_27_7 in ipairs(var_27_1.barrage_ID) do
					arg_27_0.weaponList[var_27_0].emitterList[iter_27_6] = arg_27_0:createEmitterAir(iter_27_7, var_27_1.bullet_ID[iter_27_6], var_27_1.spawn_bound)
				end
			end
		end
	end

	return
end

function var_0_0.getEmitterHost(arg_28_0)
	if not arg_28_0._emitterHost then
		arg_28_0._emitterHost = ys.Battle.BattlePlayerUnit.New(1, ys.Battle.BattleConfig.FRIENDLY_CODE)

		arg_28_0._emitterHost:SetSkinId(arg_28_0.shipVO.skinId)
		arg_28_0._emitterHost:SetTemplate(arg_28_0.shipVO.configId, {
			speed = 0
		})
	end

	return arg_28_0._emitterHost
end

function var_0_0.createEmitterCannon(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0:getEmitterHost()

	return (ys.Battle.BattleBulletEmitter.New(function(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
		local var_30_0 = ys.Battle.BattleDataFunction.CreateBattleBulletData(arg_29_2, arg_29_2, var_29_0, nil, var_0_2)

		var_30_0:SetOffsetPriority(arg_30_3)
		var_30_0:SetShiftInfo(arg_30_0, arg_30_1)
		var_30_0:SetRotateInfo(nil, 0, arg_30_2)

		if arg_29_0.equipSkinId > 0 then
			local var_30_1 = pg.equip_skin_template[arg_29_0.equipSkinId]
			local var_30_2, var_30_3, var_30_4, var_30_5, var_30_6, var_30_7 = ys.Battle.BattleDataFunction.GetEquipSkin(arg_29_0.equipSkinId)
			local var_30_8 = var_30_0:GetType()

			if var_30_8 == ys.Battle.BattleConst.BulletType.CANNON or var_30_8 == ys.Battle.BattleConst.BulletType.BOMB then
				if _.any(EquipType.CannonEquipTypes, function(arg_31_0)
					return table.contains(var_30_1.equip_type, arg_31_0)
				end) then
					var_30_0:SetModleID(var_30_2)
				elseif var_30_3 and #var_30_3 > 0 then
					var_30_0:SetModleID(var_30_3, nil, var_30_7)
				elseif var_30_5 and #var_30_5 > 0 then
					var_30_0:SetModleID(var_30_5, nil, var_30_7)
				end
			elseif var_30_8 == ys.Battle.BattleConst.BulletType.TORPEDO then
				if table.contains(pg.equip_skin_template[arg_29_0.equipSkinId].equip_type, EquipType.Torpedo) then
					var_30_0:SetModleID(var_30_2)
				elseif var_30_4 and #var_30_4 > 0 then
					var_30_0:SetModleID(var_30_4, nil, var_30_7)
				end
			end
		end

		local var_30_10 = var_30_0:GetType()
		local var_30_11 = var_30_10 == ys.Battle.BattleConst.BulletType.CANNON and ys.Battle.BattleCannonBullet.New() or var_30_10 == ys.Battle.BattleConst.BulletType.BOMB and ys.Battle.BattleBombBullet.New() or var_30_10 == ys.Battle.BattleConst.BulletType.TORPEDO and ys.Battle.BattleTorpedoBullet.New() or ys.Battle.BattleBullet.New()

		var_30_11:SetBulletData(var_30_0)

		local function var_30_12(arg_32_0)
			var_30_11:AddModel(arg_32_0)
			var_30_11:AddRotateScript()

			local var_32_0 = tf(arg_32_0)

			if var_32_0.parent then
				var_32_0.parent = nil
			end

			local var_32_1 = var_32_0:Find("bullet_random")

			if var_32_1 and var_32_1:GetComponent(typeof(SpineAnim)) then
				var_32_1:GetComponent(typeof(SpineAnim)):SetAction(tostring(math.random(3)), 0, false)
			end

			var_30_11:SetSpawn(arg_29_0.boneList[arg_29_3])

			if arg_29_0.bulletList then
				table.insert(arg_29_0.bulletList, var_30_11)

				if arg_29_0.equipSkinId > 0 then
					local var_32_2 = pg.equip_skin_template[arg_29_0.equipSkinId]
					local var_32_3 = var_30_0:GetType()

					if var_32_3 == ys.Battle.BattleConst.BulletType.CANNON then
						if _.any(EquipType.CannonEquipTypes, function(arg_33_0)
							return table.contains(var_32_2.equip_type, arg_33_0)
						end) and pg.equip_skin_template[arg_29_0.equipSkinId].preview_hit_distance > 0 then
							arg_29_0:AddSelfDestroyBullet(var_30_11, pg.equip_skin_template[arg_29_0.equipSkinId].preview_hit_distance)
						end
					elseif var_32_3 == ys.Battle.BattleConst.BulletType.TORPEDO and table.contains(pg.equip_skin_template[arg_29_0.equipSkinId].equip_type, EquipType.Torpedo) and pg.equip_skin_template[arg_29_0.equipSkinId].preview_hit_distance > 0 then
						arg_29_0:AddSelfDestroyBullet(var_30_11, pg.equip_skin_template[arg_29_0.equipSkinId].preview_hit_distance)
					end
				end
			end

			return
		end

		ys.Battle.BattleResourceManager.GetInstance():InstBullet(var_30_11:GetModleID(), function(arg_34_0)
			var_30_12(arg_34_0)

			return
		end)

		return
	end, function()
		return
	end, arg_29_1))
end

function var_0_0.createEmitterAir(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	return (ys.Battle.BattleBulletEmitter.New(function(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
		local var_37_0 = {
			id = arg_36_2
		}
		local var_37_1 = pg.aircraft_template[arg_36_2]

		;({
			id = arg_36_2
		}).tmpData = pg.aircraft_template[arg_36_2]

		local var_37_2 = Vector3(math.cos(math.deg2Rad * arg_37_2), 0, math.sin(math.deg2Rad * arg_37_2))

		local function var_37_3(arg_38_0)
			local var_38_0 = var_0_1 + Vector3(var_37_1.position_offset[1] + arg_37_0, var_37_1.position_offset[2], var_37_1.position_offset[3] + arg_37_1)

			arg_38_0.transform.localPosition = var_38_0
			arg_38_0.transform.localScale = var_0_4
			var_37_0.obj = arg_38_0
			var_37_0.tf = arg_38_0.transform
			var_37_0.pos = var_38_0
			var_37_0.baseVelocity = ys.Battle.BattleFormulas.ConvertAircraftSpeed(var_37_0.tmpData.speed)
			var_37_0.speed = var_37_2 * var_37_0.baseVelocity
			var_37_0.speedZ = (math.random() - 0.5) * 0.5
			var_37_0.targetZ = var_0_1.z

			if arg_36_0.aircraftList then
				table.insert(arg_36_0.aircraftList, var_37_0)
			end

			return
		end

		local var_37_4 = pg.aircraft_template[arg_36_2].model_ID

		if arg_36_0.equipSkinId > 0 and table.contains(pg.equip_skin_template[arg_36_0.equipSkinId].equip_type, EquipType.AirProtoEquipTypes[pg.aircraft_template[arg_36_2].type]) then
			var_37_4 = ys.Battle.BattleDataFunction.GetEquipSkin(arg_36_0.equipSkinId)
		end

		ys.Battle.BattleResourceManager.GetInstance():InstAirCharacter(var_37_4, function(arg_39_0)
			var_37_3(arg_39_0)

			return
		end)

		return
	end, function()
		return
	end, arg_36_1))
end

function var_0_0.AddSelfDestroyBullet(arg_41_0, arg_41_1, arg_41_2)
	if not arg_41_0.displayHitFX then
		return
	end

	table.insert(arg_41_0.UpdateHandlers, function(arg_42_0)
		local var_42_0 = table.indexof(arg_41_0.bulletList, arg_41_1)

		if not var_42_0 then
			arg_42_0()

			return
		end

		local var_42_1 = arg_41_1:GetBulletData()

		if var_42_1:GetCurrentDistance() < arg_41_2 then
			return
		end

		arg_41_0:RemoveBullet(var_42_0, true)
		arg_42_0()

		return
	end)

	return
end

function var_0_0.RemoveBullet(arg_43_0, arg_43_1, arg_43_2)
	Object.Destroy(arg_43_0.bulletList[arg_43_1]._go)
	table.remove(arg_43_0.bulletList, arg_43_1)

	if arg_43_2 then
		local var_43_0 = arg_43_0.bulletList[arg_43_1]:GetMissFXID()

		if arg_43_0.equipSkinId > 0 then
			if pg.equip_skin_template[arg_43_0.equipSkinId].hit_fx_name ~= "" then
				var_43_0 = pg.equip_skin_template[arg_43_0.equipSkinId].hit_fx_name
			end
		end

		if var_43_0 and var_43_0 ~= "" then
			local var_43_1, var_43_2 = arg_43_0.seaFXPool:GetFX(var_43_0)

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_43_1, arg_43_0.bulletList[arg_43_1]:GetPosition() + var_43_2, true)
		end
	end

	return
end

function var_0_0.SeaUpdate(arg_44_0)
	local var_44_0 = 0
	local var_44_1 = -20
	local var_44_2 = 60
	local var_44_3 = 0
	local var_44_4 = 60
	local var_44_5 = ys.Battle.BattleConfig
	local var_44_6 = ys.Battle.BattleConst

	pg.TimeMgr.GetInstance():AddBattleTimer("barrageUpdateTimer", -1, 0.033, function()
		for iter_45_0 = #arg_44_0.bulletList, 1, -1 do
			local var_45_0 = arg_44_0.bulletList[iter_45_0]._bulletData:GetSpeed()()
			local var_45_1 = arg_44_0.bulletList[iter_45_0]:GetPosition()

			if var_45_1.x > var_44_2 and var_45_0.x > 0 or var_45_1.z < var_44_3 and var_45_0.z < 0 then
				arg_44_0:RemoveBullet(iter_45_0, false)
			elseif var_45_1.x < var_44_1 and var_45_0.x < 0 and arg_44_0.bulletList[iter_45_0]:GetType() ~= var_44_6.BulletType.BOMB then
				arg_44_0:RemoveBullet(iter_45_0, false)
			else
				local var_45_2 = pg.TimeMgr.GetInstance()

				arg_44_0.bulletList[iter_45_0]._bulletData:Update((var_45_2:GetCombatTime()))
				arg_44_0.bulletList[iter_45_0]:Update(var_44_0)

				if var_45_1.z > var_44_4 and var_45_0.z > 0 or arg_44_0.bulletList[iter_45_0]._bulletData:IsOutRange(var_44_0) then
					arg_44_0:RemoveBullet(iter_45_0, true)
				end
			end
		end

		for iter_45_1, iter_45_2 in ipairs(arg_44_0.aircraftList) do
			local var_45_3 = iter_45_2.pos + iter_45_2.speed

			if (iter_45_2.pos + iter_45_2.speed).y < var_44_5.AircraftHeight + 5 then
				iter_45_2.speed.y = math.max(0.4, 1 - var_45_3.y / var_44_5.AircraftHeight)

				local var_45_4 = math.min(1, var_45_3.y / var_44_5.AircraftHeight)

				iter_45_2.tf.localScale = Vector3(var_45_4, var_45_4, var_45_4)
			end

			iter_45_2.speed.z = iter_45_2.baseVelocity * iter_45_2.speedZ

			if iter_45_2.targetZ - var_45_3.z > iter_45_2.baseVelocity then
				iter_45_2.speed.z = iter_45_2.baseVelocity * 0.5
			elseif iter_45_2.targetZ - var_45_3.z < -iter_45_2.baseVelocity then
				iter_45_2.speed.z = -iter_45_2.baseVelocity * 0.5
			else
				iter_45_2.targetZ = var_0_1.z + var_0_1.z * (math.random() - 0.5) * 0.6
			end

			if var_45_3.x > var_44_2 or var_45_3.x < var_44_1 then
				Object.Destroy(iter_45_2.obj)
				table.remove(arg_44_0.aircraftList, iter_45_1)
			else
				iter_45_2.tf.localPosition = var_45_3
				iter_45_2.pos = var_45_3
			end
		end

		for iter_45_3 = #arg_44_0.UpdateHandlers, 1, -1 do
			arg_44_0.UpdateHandlers[iter_45_3](function()
				table.remove(arg_44_0.UpdateHandlers, iter_45_3)

				return
			end)
		end

		var_44_0 = var_44_0 + 1

		return
	end)

	return
end

function var_0_0.GetFXOffsets(arg_47_0, arg_47_1)
	arg_47_1 = arg_47_1 or 1

	return arg_47_0._FXOffset[arg_47_1]
end

function var_0_0.GetAttachPoint(arg_48_0)
	return arg_48_0._FXAttachPoint
end

function var_0_0.GetGO(arg_49_0)
	return arg_49_0.seaCharacter
end

function var_0_0.GetSpecificFXScale(arg_50_0)
	return {}
end

function var_0_0.clear(arg_51_0)
	pg.TimeMgr.GetInstance():RemoveAllBattleTimer()

	arg_51_0._emitterHost = nil

	if arg_51_0.seaCharacter then
		Destroy(arg_51_0.seaCharacter)

		arg_51_0.seaCharacter = nil
	end

	if arg_51_0.aircraftList then
		for iter_51_0, iter_51_1 in ipairs(arg_51_0.aircraftList) do
			Destroy(iter_51_1.obj)
		end

		arg_51_0.aircraftList = nil
	end

	if arg_51_0.seaView then
		arg_51_0.seaView:Dispose()

		arg_51_0.seaView = nil
	end

	if arg_51_0.weaponList then
		for iter_51_2, iter_51_3 in ipairs(arg_51_0.weaponList) do
			for iter_51_4, iter_51_5 in ipairs(iter_51_3.emitterList) do
				iter_51_5:Destroy()
			end
		end

		arg_51_0.weaponList = nil
	end

	if arg_51_0.bulletList then
		for iter_51_6, iter_51_7 in ipairs(arg_51_0.bulletList) do
			Destroy(iter_51_7._go)
		end

		arg_51_0.bulletList = nil
	end

	if arg_51_0.orbitList then
		for iter_51_8, iter_51_9 in ipairs(arg_51_0.orbitList) do
			Destroy(iter_51_9)
		end

		arg_51_0.orbitList = nil
	end

	if arg_51_0.seaFXPool then
		arg_51_0.seaFXPool:Clear()

		arg_51_0.seaFXPool = nil
	end

	if arg_51_0.seaFXContainersPool then
		arg_51_0.seaFXContainersPool:Clear()

		arg_51_0.seaFXContainersPool = nil
	end

	ys.Battle.BattleResourceManager.GetInstance():Clear()

	arg_51_0.seaCamera.enabled = false
	arg_51_0.seaCameraGO = nil
	arg_51_0.seaCamera = nil
	arg_51_0.loading = false
	arg_51_0.loaded = false

	if arg_51_0.palyAnimTimer then
		arg_51_0.palyAnimTimer:Stop()

		arg_51_0.palyAnimTimer = nil
	end

	return
end

return var_0_0
