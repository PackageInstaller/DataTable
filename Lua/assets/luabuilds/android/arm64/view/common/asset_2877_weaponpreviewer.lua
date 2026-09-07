local WeaponPreviewer = class("WeaponPreviewer")
local var_0_1 = Vector3(0, 1, 40)
local var_0_2 = Vector3(40, 1, 40)
local var_0_3 = Vector3(30, 0, 0)
local var_0_4 = Vector3(0.1, 0.1, 0.1)
local var_0_5 = Vector3(330, 0, 0)

function WeaponPreviewer:Ctor(arg_1_1)
	self.rawImage = arg_1_1

	setActive(self.rawImage, false)

	self.seaCameraGO = GameObject.Find("BarrageCamera")
	self.seaCamera = self.seaCameraGO:GetComponent(typeof(Camera))
	self.seaCamera.targetTexture = self.rawImage.texture
	self.seaCamera.enabled = true
	self.displayFireFX = true
	self.displayHitFX = false

	return
end

function WeaponPreviewer:configUI(arg_2_1)
	self.healTF = arg_2_1

	setActive(self.healTF, false)
	self.healTF:GetComponent("DftAniEvent"):SetEndEvent(function()
		setActive(self.healTF, false)
		setText(self.healTF:Find("text"), "")

		return
	end)

	return
end

function WeaponPreviewer:setDisplayWeapon(arg_4_1, arg_4_2, arg_4_3)
	self.weaponIds = arg_4_1
	self.equipSkinId = arg_4_2 or 0

	self:onWeaponUpdate()

	return
end

function WeaponPreviewer:SetFXMode(arg_5_1, arg_5_2)
	self.displayFireFX = arg_5_1
	self.displayHitFX = arg_5_2

	return
end

function WeaponPreviewer:load(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	assert(not self.loading and not self.loaded, "load function can be called only once.")

	self.loading = true
	self.shipVO = arg_6_2

	ys.Battle.BattleVariable.Init(true)
	ys.Battle.BattleFXPool.GetInstance():Init()

	local var_6_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_6_0:Init()
	var_6_0:AddPreloadResource(var_6_0.GetMapResource(arg_6_1))
	var_6_0:AddPreloadResource(var_6_0.GetDisplayCommonResource())

	if self.equipSkinId > 0 then
		var_6_0:AddPreloadResource(var_6_0.GetEquipSkinPreviewRes(self.equipSkinId))
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
		self.seaView = ys.Battle.BattleMap.New(arg_6_1)

		local function var_7_0(arg_8_0)
			self.loading = false
			self.loaded = true

			pg.UIMgr.GetInstance():LoadingOff()

			self.seaCharacter = arg_8_0

			local var_8_0 = arg_6_2:getConfig("scale") / 50

			arg_8_0.transform.localScale = Vector3(var_8_0, var_8_0, var_8_0)
			arg_8_0.transform.localPosition = var_0_1
			arg_8_0.transform.localEulerAngles = var_0_3
			self.seaAnimator = arg_8_0.transform:GetComponent("SpineAnim")
			self.skeletonAnimation = arg_8_0.transform:GetComponent("SkeletonAnimation")
			self.characterAction = ys.Battle.BattleConst.ActionName.MOVE

			self:setSeaAction(self.characterAction, 0, true)

			self.seaFXList = {}
			self._FXAttachPoint = GameObject()

			self._FXAttachPoint.transform:SetParent(arg_8_0.transform, false)

			self._FXAttachPoint.transform.localPosition = Vector3.zero
			self._FXAttachPoint.transform.localEulerAngles = var_0_5

			local var_8_1 = {}

			for iter_8_0, iter_8_1 in ipairs(ys.Battle.BattleConst.FXContainerIndex) do
				var_8_1[iter_8_0] = Vector3(pg.ship_skin_template[arg_6_2.skinId].fx_container[iter_8_0][1], pg.ship_skin_template[arg_6_2.skinId].fx_container[iter_8_0][2], pg.ship_skin_template[arg_6_2.skinId].fx_container[iter_8_0][3])
			end

			self._FXOffset = var_8_1

			if self.equipSkinId > 0 then
				self:attachOrbit()
			end

			local var_8_2 = ys.Battle.BattleFXPool.GetInstance()

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_8_2:GetCharacterFX("movewave", self), Vector3.zero, true)

			self.seaFXPool = var_8_2

			if arg_6_2:getShipType() ~= ShipType.WeiXiu then
				self.boneList = {}

				for iter_8_2, iter_8_3 in pairs(pg.ship_skin_template[arg_6_2.skinId].bound_bone) do
					local var_8_3 = {}

					for iter_8_4, iter_8_5 in ipairs(iter_8_3) do
						var_8_3[#var_8_3 + 1] = type(iter_8_5) == "table" and Vector3(iter_8_5[1], iter_8_5[2], iter_8_5[3]) or Vector3.zero
					end

					self.boneList[iter_8_2] = arg_8_0.transform.localToWorldMatrix:MultiplyPoint3x4(var_8_3[1])
				end

				self:SeaUpdate()
			end

			setActive(self.rawImage, true)
			pg.TimeMgr.GetInstance():ResumeBattleTimer()
			self:onWeaponUpdate()
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

function WeaponPreviewer:attachOrbit()
	local var_10_0 = pg.equip_skin_template[self.equipSkinId]

	if pg.equip_skin_template[self.equipSkinId].orbit_combat ~= "" then
		self.orbitList = {}

		ResourceMgr.Inst:getAssetAsync(ys.Battle.BattleResourceManager.GetOrbitPath(pg.equip_skin_template[self.equipSkinId].orbit_combat), "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_11_0)
			if self.seaCharacter then
				local var_11_0 = Object.Instantiate(arg_11_0)

				table.insert(self.orbitList, var_11_0)

				var_11_0.transform.localPosition = Vector3(var_10_0.orbit_combat_bound[2][1], var_10_0.orbit_combat_bound[2][2], var_10_0.orbit_combat_bound[2][3])

				local var_11_1 = SpineAnim.AddFollower(var_10_0.orbit_combat_bound[1], self.seaCharacter.transform, var_11_0.transform):GetComponent("Spine.Unity.BoneFollower")

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

function WeaponPreviewer:setSeaAction(arg_12_1, arg_12_2, arg_12_3)
	if self.seaAnimator then
		self.seaAnimator:SetAction(SpineAnimUtil.GetCharAnimDirect(self.skeletonAnimation, 1, arg_12_1), 0, arg_12_3)
	end

	return
end

function WeaponPreviewer:playShipAnims()
	if self.loaded and self.seaAnimator then
		local var_13_0 = {
			"attack",
			"victory",
			"dead"
		}

		local function var_13_1(arg_14_0)
			if self.seaAnimator then
				self.seaAnimator:SetActionCallBack(nil)
			end

			self:setSeaAction(var_13_0[arg_14_0], 0, false)
			self.seaAnimator:SetActionCallBack(function(arg_15_0)
				if arg_15_0 == "finish" then
					self.seaAnimator:SetActionCallBack(nil)
					self:setSeaAction("stand", 0, false)
				end

				return
			end)

			return
		end

		if self.palyAnimTimer then
			self.palyAnimTimer:Stop()

			self.palyAnimTimer = nil
		end

		self.palyAnimTimer = Timer.New(function()
			var_13_1(math.random(1, #var_13_0))

			return
		end, 5, -1)

		self.palyAnimTimer:Start()
		self.palyAnimTimer.func()
	end

	return
end

function WeaponPreviewer:onWeaponUpdate()
	if self.loaded and self.weaponIds then
		if self.seaAnimator then
			self.seaAnimator:SetActionCallBack(nil)
		end

		local function var_17_0()
			for iter_18_0, iter_18_1 in pairs(self.weaponList or {}) do
				for iter_18_2, iter_18_3 in pairs(iter_18_1.emitterList or {}) do
					iter_18_3:Destroy()
				end
			end

			for iter_18_4, iter_18_5 in ipairs(self.bulletList or {}) do
				Object.Destroy(iter_18_5._go)
			end

			for iter_18_6, iter_18_7 in pairs(self.aircraftList or {}) do
				Object.Destroy(iter_18_7.obj)
			end

			self.bulletList = {}
			self.aircraftList = {}
			self.UpdateHandlers = {}

			return
		end

		if #self.weaponIds == 0 and self.playRandomAnims then
			if self._fireTimer then
				self._fireTimer:Stop()
			end

			if self._delayTimer then
				self._delayTimer:Stop()
			end

			if self.shipVO:getShipType() ~= ShipType.WeiXiu then
				var_17_0()
			elseif self.buffTimer then
				pg.TimeMgr.GetInstance():RemoveBattleTimer(self.buffTimer)

				self.buffTimer = nil
			end

			self:playShipAnims()
		elseif self.shipVO:getShipType() ~= ShipType.WeiXiu then
			var_17_0()
			self:MakeWeapon(self.weaponIds)
			self:SeaFire()
		elseif self.weaponIds[1] then
			local var_17_1 = Equipment.getConfigData(self.weaponIds[1]).skill_id[1]

			self:MakeBuff(var_17_1 and var_17_1[1])
		end
	end

	return
end

function WeaponPreviewer:SeaFire()
	local var_19_0 = 1

	if self._fireTimer then
		self._delayTimer:Stop()
		self._fireTimer:Stop()
		self._fireTimer:Start()
	else
		self._fireTimer = pg.TimeMgr.GetInstance():AddBattleTimer("barrageFireTimer", -1, 1.5, function()
			local var_20_0 = self.weaponList[var_19_0]

			if self.weaponList[var_19_0] then
				local function var_20_1()
					for iter_21_0, iter_21_1 in ipairs(var_20_0.emitterList) do
						iter_21_1:Ready()
					end

					for iter_21_2, iter_21_3 in ipairs(var_20_0.emitterList) do
						iter_21_3:Fire(nil, 1, 0)
					end

					local var_21_0 = var_20_0.tmpData.fire_fx

					if self.equipSkinId > 0 then
						local var_21_1, var_21_2, var_21_3, var_21_4, var_21_5, var_21_6 = ys.Battle.BattleDataFunction.GetEquipSkin(self.equipSkinId)

						if var_21_5 ~= "" then
							var_21_0 = var_21_5
						end
					end

					if var_21_0 and var_21_0 ~= "" and self.displayFireFX then
						self.seaFXPool:GetCharacterFX(var_21_0, self, true, function()
							return
						end)
					end

					var_19_0 = var_19_0 + 1

					return
				end

				if self.weaponList[var_19_0].tmpData.action_index ~= "" then
					self.characterAction = self.weaponList[var_19_0].tmpData.action_index

					self:setSeaAction(self.characterAction, 0, false)
					self.seaAnimator:SetActionCallBack(function(arg_23_0)
						if arg_23_0 == "action" then
							var_20_1()
						end

						return
					end)
				else
					var_20_1()
				end
			elseif self.characterAction ~= ys.Battle.BattleConst.ActionName.MOVE then
				self.characterAction = ys.Battle.BattleConst.ActionName.MOVE

				self:setSeaAction(self.characterAction, 0, true)

				var_19_0 = 1

				self._fireTimer:Pause()
				self._delayTimer:Start()
			end

			return
		end)
		self._delayTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", -1, 3, function()
			self._delayTimer:Stop()
			self._fireTimer:Resume()

			return
		end, nil, true)
	end

	return
end

function WeaponPreviewer:MakeBuff(arg_25_1)
	local var_25_0 = getSkillConfig(arg_25_1)
	local var_25_1 = pg.skillCfg["skill_" .. var_25_0.effect_list[1].arg_list.skill_id]

	if self.buffTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self.buffTimer)

		self.buffTimer = nil
	end

	self.buffTimer = pg.TimeMgr.GetInstance():AddBattleTimer("buffTimer", -1, var_25_0.effect_list[1].arg_list.time, function()
		setActive(self.healTF, true)
		setText(self.healTF:Find("text"), var_25_1.effect_list[1].arg_list.number)

		return
	end)

	return
end

function WeaponPreviewer:MakeWeapon(arg_27_1)
	self.weaponList = {}
	self.bulletList = {}
	self.aircraftList = {}

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
					self.weaponList[var_27_0] = {
						tmpData = var_27_1,
						emitterList = {}
					}

					for iter_27_4, iter_27_5 in ipairs(var_27_1.barrage_ID) do
						self.weaponList[var_27_0].emitterList[iter_27_4] = self:createEmitterCannon(iter_27_5, var_27_1.bullet_ID[iter_27_4], var_27_1.spawn_bound)
					end
				end
			elseif var_27_1.type == ys.Battle.BattleConst.EquipmentType.PREVIEW_ARICRAFT and type(var_27_1.barrage_ID) == "table" then
				self.weaponList[var_27_0] = {
					tmpData = var_27_1,
					emitterList = {}
				}

				for iter_27_6, iter_27_7 in ipairs(var_27_1.barrage_ID) do
					self.weaponList[var_27_0].emitterList[iter_27_6] = self:createEmitterAir(iter_27_7, var_27_1.bullet_ID[iter_27_6], var_27_1.spawn_bound)
				end
			end
		end
	end

	return
end

function WeaponPreviewer:getEmitterHost()
	if not self._emitterHost then
		self._emitterHost = ys.Battle.BattlePlayerUnit.New(1, ys.Battle.BattleConfig.FRIENDLY_CODE)

		self._emitterHost:SetSkinId(self.shipVO.skinId)
		self._emitterHost:SetTemplate(self.shipVO.configId, {
			speed = 0
		})
	end

	return self._emitterHost
end

function WeaponPreviewer:createEmitterCannon(arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = self:getEmitterHost()

	return (ys.Battle.BattleBulletEmitter.New(function(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
		local var_30_0 = ys.Battle.BattleDataFunction.CreateBattleBulletData(arg_29_2, arg_29_2, var_29_0, nil, var_0_2)

		var_30_0:SetOffsetPriority(arg_30_3)
		var_30_0:SetShiftInfo(arg_30_0, arg_30_1)
		var_30_0:SetRotateInfo(nil, 0, arg_30_2)

		if self.equipSkinId > 0 then
			local var_30_1 = pg.equip_skin_template[self.equipSkinId]
			local var_30_2, var_30_3, var_30_4, var_30_5, var_30_6, var_30_7 = ys.Battle.BattleDataFunction.GetEquipSkin(self.equipSkinId)
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
				if table.contains(pg.equip_skin_template[self.equipSkinId].equip_type, EquipType.Torpedo) then
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

			var_30_11:SetSpawn(self.boneList[arg_29_3])

			if self.bulletList then
				table.insert(self.bulletList, var_30_11)

				if self.equipSkinId > 0 then
					local var_32_2 = pg.equip_skin_template[self.equipSkinId]
					local var_32_3 = var_30_0:GetType()

					if var_32_3 == ys.Battle.BattleConst.BulletType.CANNON then
						if _.any(EquipType.CannonEquipTypes, function(arg_33_0)
							return table.contains(var_32_2.equip_type, arg_33_0)
						end) and pg.equip_skin_template[self.equipSkinId].preview_hit_distance > 0 then
							self:AddSelfDestroyBullet(var_30_11, pg.equip_skin_template[self.equipSkinId].preview_hit_distance)
						end
					elseif var_32_3 == ys.Battle.BattleConst.BulletType.TORPEDO and table.contains(pg.equip_skin_template[self.equipSkinId].equip_type, EquipType.Torpedo) and pg.equip_skin_template[self.equipSkinId].preview_hit_distance > 0 then
						self:AddSelfDestroyBullet(var_30_11, pg.equip_skin_template[self.equipSkinId].preview_hit_distance)
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

function WeaponPreviewer:createEmitterAir(arg_36_1, arg_36_2, arg_36_3)
	return (ys.Battle.BattleBulletEmitter.New(function(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
		local var_37_0 = {
			id = arg_36_2
		}
		local var_37_1 = pg.aircraft_template[arg_36_2]

		var_37_0.tmpData = pg.aircraft_template[arg_36_2]

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

			if self.aircraftList then
				table.insert(self.aircraftList, var_37_0)
			end

			return
		end

		ys.Battle.BattleResourceManager.GetInstance():InstAirCharacter((self.equipSkinId > 0 and table.contains(pg.equip_skin_template[self.equipSkinId].equip_type, EquipType.AirProtoEquipTypes[pg.aircraft_template[arg_36_2].type]) or nil) and ys.Battle.BattleDataFunction.GetEquipSkin(self.equipSkinId), function(arg_39_0)
			var_37_3(arg_39_0)

			return
		end)

		return
	end, function()
		return
	end, arg_36_1))
end

function WeaponPreviewer:AddSelfDestroyBullet(arg_41_1, arg_41_2)
	if not self.displayHitFX then
		return
	end

	table.insert(self.UpdateHandlers, function(arg_42_0)
		local var_42_0 = table.indexof(self.bulletList, arg_41_1)

		if not var_42_0 then
			arg_42_0()

			return
		end

		if arg_41_1:GetBulletData():GetCurrentDistance() < arg_41_2 then
			return
		end

		self:RemoveBullet(var_42_0, true)
		arg_42_0()

		return
	end)

	return
end

function WeaponPreviewer:RemoveBullet(arg_43_1, arg_43_2)
	Object.Destroy(self.bulletList[arg_43_1]._go)
	table.remove(self.bulletList, arg_43_1)

	if arg_43_2 then
		local var_43_0 = self.bulletList[arg_43_1]:GetMissFXID()

		if self.equipSkinId > 0 then
			if pg.equip_skin_template[self.equipSkinId].hit_fx_name ~= "" then
				var_43_0 = pg.equip_skin_template[self.equipSkinId].hit_fx_name
			end
		end

		if var_43_0 and var_43_0 ~= "" then
			local var_43_1, var_43_2 = self.seaFXPool:GetFX(var_43_0)

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_43_1, self.bulletList[arg_43_1]:GetPosition() + var_43_2, true)
		end
	end

	return
end

function WeaponPreviewer:SeaUpdate()
	local var_44_0 = 0
	local var_44_1 = -20
	local var_44_2 = 60
	local var_44_3 = 0
	local var_44_4 = 60
	local var_44_5 = ys.Battle.BattleConfig
	local var_44_6 = ys.Battle.BattleConst

	pg.TimeMgr.GetInstance():AddBattleTimer("barrageUpdateTimer", -1, 0.033, function()
		for iter_45_0 = #self.bulletList, 1, -1 do
			local var_45_0 = self.bulletList[iter_45_0]._bulletData:GetSpeed()()
			local var_45_1 = self.bulletList[iter_45_0]:GetPosition()

			if var_45_1.x > var_44_2 and var_45_0.x > 0 or var_45_1.z < var_44_3 and var_45_0.z < 0 then
				self:RemoveBullet(iter_45_0, false)
			elseif var_45_1.x < var_44_1 and var_45_0.x < 0 and self.bulletList[iter_45_0]:GetType() ~= var_44_6.BulletType.BOMB then
				self:RemoveBullet(iter_45_0, false)
			else
				self.bulletList[iter_45_0]._bulletData:Update((pg.TimeMgr.GetInstance():GetCombatTime()))
				self.bulletList[iter_45_0]:Update(var_44_0)

				if var_45_1.z > var_44_4 and var_45_0.z > 0 or self.bulletList[iter_45_0]._bulletData:IsOutRange(var_44_0) then
					self:RemoveBullet(iter_45_0, true)
				end
			end
		end

		for iter_45_1, iter_45_2 in ipairs(self.aircraftList) do
			local var_45_2 = iter_45_2.pos + iter_45_2.speed

			if (iter_45_2.pos + iter_45_2.speed).y < var_44_5.AircraftHeight + 5 then
				iter_45_2.speed.y = math.max(0.4, 1 - var_45_2.y / var_44_5.AircraftHeight)

				local var_45_3 = math.min(1, var_45_2.y / var_44_5.AircraftHeight)

				iter_45_2.tf.localScale = Vector3(var_45_3, var_45_3, var_45_3)
			end

			iter_45_2.speed.z = iter_45_2.baseVelocity * iter_45_2.speedZ

			if iter_45_2.targetZ - var_45_2.z > iter_45_2.baseVelocity then
				iter_45_2.speed.z = iter_45_2.baseVelocity * 0.5
			elseif iter_45_2.targetZ - var_45_2.z < -iter_45_2.baseVelocity then
				iter_45_2.speed.z = -iter_45_2.baseVelocity * 0.5
			else
				iter_45_2.targetZ = var_0_1.z + var_0_1.z * (math.random() - 0.5) * 0.6
			end

			if var_45_2.x > var_44_2 or var_45_2.x < var_44_1 then
				Object.Destroy(iter_45_2.obj)
				table.remove(self.aircraftList, iter_45_1)
			else
				iter_45_2.tf.localPosition = var_45_2
				iter_45_2.pos = var_45_2
			end
		end

		for iter_45_3 = #self.UpdateHandlers, 1, -1 do
			self.UpdateHandlers[iter_45_3](function()
				table.remove(self.UpdateHandlers, iter_45_3)

				return
			end)
		end

		var_44_0 = var_44_0 + 1

		return
	end)

	return
end

function WeaponPreviewer:GetFXOffsets(arg_47_1)
	arg_47_1 = arg_47_1 or 1

	return self._FXOffset[arg_47_1]
end

function WeaponPreviewer:GetAttachPoint()
	return self._FXAttachPoint
end

function WeaponPreviewer:GetGO()
	return self.seaCharacter
end

function WeaponPreviewer:GetSpecificFXScale()
	return {}
end

function WeaponPreviewer:clear()
	pg.TimeMgr.GetInstance():RemoveAllBattleTimer()

	self._emitterHost = nil

	if self.seaCharacter then
		Destroy(self.seaCharacter)

		self.seaCharacter = nil
	end

	if self.aircraftList then
		for iter_51_0, iter_51_1 in ipairs(self.aircraftList) do
			Destroy(iter_51_1.obj)
		end

		self.aircraftList = nil
	end

	if self.seaView then
		self.seaView:Dispose()

		self.seaView = nil
	end

	if self.weaponList then
		for iter_51_2, iter_51_3 in ipairs(self.weaponList) do
			for iter_51_4, iter_51_5 in ipairs(iter_51_3.emitterList) do
				iter_51_5:Destroy()
			end
		end

		self.weaponList = nil
	end

	if self.bulletList then
		for iter_51_6, iter_51_7 in ipairs(self.bulletList) do
			Destroy(iter_51_7._go)
		end

		self.bulletList = nil
	end

	if self.orbitList then
		for iter_51_8, iter_51_9 in ipairs(self.orbitList) do
			Destroy(iter_51_9)
		end

		self.orbitList = nil
	end

	if self.seaFXPool then
		self.seaFXPool:Clear()

		self.seaFXPool = nil
	end

	if self.seaFXContainersPool then
		self.seaFXContainersPool:Clear()

		self.seaFXContainersPool = nil
	end

	ys.Battle.BattleResourceManager.GetInstance():Clear()

	self.seaCamera.enabled = false
	self.seaCameraGO = nil
	self.seaCamera = nil
	self.loading = false
	self.loaded = false

	if self.palyAnimTimer then
		self.palyAnimTimer:Stop()

		self.palyAnimTimer = nil
	end

	return
end

return WeaponPreviewer
