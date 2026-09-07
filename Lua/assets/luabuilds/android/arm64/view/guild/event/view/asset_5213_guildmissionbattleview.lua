local GuildMissionBattleView = class("GuildMissionBattleView")
local var_0_1 = Vector3(40, -3, 40)
local var_0_2 = 10
local var_0_3 = 1028
local var_0_4 = Vector3(80, -3, 40)

local function var_0_5(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(ys.Battle.BattleConst.FXContainerIndex) do
		var_1_1[iter_1_0] = Vector3(arg_1_0[iter_1_0][1], arg_1_0[iter_1_0][2], arg_1_0[iter_1_0][3])
	end

	var_1_0._FXOffset = var_1_1
	var_1_0._FXAttachPoint = GameObject()

	function var_1_0:GetFXOffsets(arg_2_1)
		arg_2_1 = arg_2_1 or 1

		return self._FXOffset[arg_2_1]
	end

	function var_1_0:GetAttachPoint()
		return self._FXAttachPoint
	end

	function var_1_0:GetGO()
		return self._go
	end

	function var_1_0:SetGo(arg_5_1)
		assert(arg_5_1)

		self._go = arg_5_1

		self._FXAttachPoint.transform:SetParent(arg_5_1.transform, false)

		self._FXAttachPoint.transform.localPosition = Vector3.zero
		self._FXAttachPoint.transform.localEulerAngles = Vector3(330, 0, 0)

		return
	end

	function var_1_0.GetSpecificFXScale(arg_6_0)
		return {}
	end

	return var_1_0
end

function GuildMissionBattleView:Ctor(arg_7_1)
	self.rawImage = arg_7_1

	setActive(self.rawImage, false)

	self.seaCameraGO = GameObject.Find("BarrageCamera")
	self.seaCamera = self.seaCameraGO:GetComponent(typeof(Camera))

	self.rawImage.texture:Release()

	self.rawImage.texture.width = 1920
	self.rawImage.texture.height = 1080

	self.rawImage.texture:Create()

	self.seaCamera.targetTexture = self.rawImage.texture
	self.seaCamera.enabled = true

	return
end

function GuildMissionBattleView:configUI(arg_8_1, arg_8_2)
	self.nameTF = arg_8_2
	self.healTF = arg_8_1

	setActive(self.healTF, false)
	self.healTF:GetComponent("DftAniEvent"):SetEndEvent(function()
		setActive(self.healTF, false)
		setText(self.healTF:Find("text"), "")

		return
	end)

	return
end

function GuildMissionBattleView:load(arg_10_1, arg_10_2)
	ys.Battle.BattleVariable.Init(true)

	local var_10_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_10_0:Init()
	var_10_0:AddPreloadResource(var_10_0.GetMapResource(arg_10_1))
	var_10_0:StartPreload(function()
		pg.UIMgr.GetInstance():LoadingOff()

		self.seaView = ys.Battle.BattleMap.New(arg_10_1)

		setActive(self.rawImage, true)

		GameObject.Find("scenes").transform.position = Vector3(0, -26, 0)

		var_10_0:Clear()

		if arg_10_2 then
			onNextTick(arg_10_2)
		end

		return
	end, nil)
	pg.UIMgr.GetInstance():LoadingOn()

	return
end

function GuildMissionBattleView:LoadShip(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if not arg_12_1 then
		arg_12_4()

		return
	end

	if self.shipVO then
		arg_12_4()

		return
	end

	self.unitList = {}
	self.bulletUnitList = {}
	self.shipVO = arg_12_1
	self.equipSkinId = 0
	self.weaponIds = arg_12_2

	ys.Battle.BattleFXPool.GetInstance():Init()

	self._cldSystem = ys.Battle.BattleCldSystem.New(self)

	local var_12_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_12_0:Init()
	var_12_0:AddPreloadResource(var_12_0.GetDisplayCommonResource())

	if self.equipSkinId > 0 then
		var_12_0:AddPreloadResource(var_12_0.GetEquipSkinPreviewRes(self.equipSkinId))
	end

	var_12_0:AddPreloadResource(var_12_0.GetCharacterPath(pg.enemy_data_statistics[var_0_2].prefab), false)
	var_12_0:AddPreloadResource(var_12_0.GetCharacterPath(pg.enemy_data_statistics[var_0_3].prefab), false)
	var_12_0:AddPreloadResource(var_12_0.GetShipResource(arg_12_1.configId, arg_12_1.skinId), false)

	if arg_12_1:getShipType() ~= ShipType.WeiXiu then
		for iter_12_0, iter_12_1 in ipairs(arg_12_2) do
			if iter_12_1 ~= 0 then
				for iter_12_2, iter_12_3 in ipairs(ys.Battle.BattleDataFunction.GetWeaponDataFromID(iter_12_1).weapon_id) do
					var_12_0:AddPreloadResource(var_12_0.GetWeaponResource(iter_12_3))
				end
			end
		end
	end

	var_12_0:StartPreload(function()
		local function var_13_0(arg_14_0)
			self.seaCharacter = arg_14_0

			local var_14_0 = arg_12_1:getConfig("scale") / 50

			arg_14_0.transform.localScale = Vector3(var_14_0 - 0.4, var_14_0, var_14_0)
			arg_14_0.transform.localPosition = self:GetCharacterOffset()
			arg_14_0.transform.localEulerAngles = Vector3(30, 0, 0)
			self.seaAnimator = arg_14_0.transform:GetComponent("SpineAnim")
			self.characterAction = ys.Battle.BattleConst.ActionName.MOVE

			self.seaAnimator:SetAction(self.characterAction, 0, true)

			local var_14_1 = cloneTplTo(self.nameTF, arg_14_0)

			var_14_1.localPosition = Vector3(0, -0.35, -1)

			setText(var_14_1:Find("Text"), arg_12_3)

			local var_14_2 = var_0_5(pg.ship_skin_template[arg_12_1.skinId].fx_container)

			var_14_2:SetGo(arg_14_0)

			local var_14_3 = ys.Battle.BattleFXPool.GetInstance()

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_14_3:GetCharacterFX("movewave", var_14_2), Vector3(0, 0, 0), true)

			self.seaFXPool = var_14_3

			if arg_12_1:getShipType() ~= ShipType.WeiXiu then
				self.boneList = {}

				for iter_14_0, iter_14_1 in pairs(pg.ship_skin_template[arg_12_1.skinId].bound_bone) do
					local var_14_4 = {}

					for iter_14_2, iter_14_3 in ipairs(iter_14_1) do
						var_14_4[#var_14_4 + 1] = type(iter_14_3) == "table" and Vector3(iter_14_3[1], iter_14_3[2], iter_14_3[3]) or Vector3.zero
					end

					self.boneList[iter_14_0] = var_14_4[1]
				end
			end

			LeanTween.value(arg_14_0, -20, 0, 2):setOnUpdate(System.Action_float(function(arg_15_0)
				arg_14_0.transform.position = Vector3(arg_15_0, arg_14_0.transform.position.y, arg_14_0.transform.position.z)

				return
			end))

			return
		end

		seriesAsync({
			function(arg_16_0)
				var_12_0:InstCharacter(arg_12_1:getPrefab(), function(arg_17_0)
					var_13_0(arg_17_0)
					arg_16_0()

					return
				end)

				return
			end,
			function(arg_18_0)
				self:CreateMonster(arg_18_0)

				return
			end,
			function(arg_19_0)
				self:CreateItemBox(arg_19_0)

				return
			end
		}, function()
			self.loaded = true

			pg.TimeMgr.GetInstance():ResumeBattleTimer()

			if arg_12_1:getShipType() ~= ShipType.WeiXiu then
				self:onWeaponUpdate()
				self:SeaUpdate()
			end

			if arg_12_4 then
				arg_12_4()
			end

			return
		end)

		return
	end, nil)

	return
end

function GuildMissionBattleView:StartMoveOtherShips(arg_21_1)
	local function var_21_0(arg_22_0, arg_22_1)
		local var_22_0 = arg_22_0.transform.localPosition

		LeanTween.value(arg_22_0, arg_22_0.transform.localPosition.x, 80, (math.random(5, 8))):setOnUpdate(System.Action_float(function(arg_23_0)
			arg_22_0.transform.localPosition = Vector3(arg_23_0, var_22_0.y, var_22_0.z)

			return
		end)):setOnComplete(System.Action(arg_22_1)):setDelay((math.random(0, 5)))

		return
	end

	local var_21_1 = {}

	for iter_21_0, iter_21_1 in ipairs(self.otherShipGos) do
		table.insert(var_21_1, function(arg_24_0)
			var_21_0(iter_21_1, arg_24_0)

			return
		end)
	end

	parallelAsync(var_21_1, arg_21_1)

	return
end

function GuildMissionBattleView:PlayOtherShipAnim(arg_25_1, arg_25_2)
	if not self.loaded then
		return
	end

	self.otherShipGos = {}

	local var_25_0 = ys.Battle.BattleResourceManager.GetInstance()

	var_25_0:Init()
	var_25_0:AddPreloadResource(var_25_0.GetDisplayCommonResource())

	local function var_25_1(arg_26_0, arg_26_1, arg_26_2)
		arg_26_2.transform.localScale = Vector3(pg.ship_data_statistics[arg_26_0.id].scale / 50 - 0.4, pg.ship_data_statistics[arg_26_0.id].scale / 50, pg.ship_data_statistics[arg_26_0.id].scale / 50)
		arg_26_2.transform.localPosition = Vector3(-20, 0, arg_26_1)
		arg_26_2.transform.localEulerAngles = Vector3(30, 0, 0)

		arg_26_2.transform:GetComponent("SpineAnim"):SetAction(ys.Battle.BattleConst.ActionName.MOVE, 0, true)

		local var_26_0 = cloneTplTo(self.nameTF, arg_26_2)

		var_26_0.localPosition = Vector3(0, -0.35, -1)

		setText(var_26_0:Find("Text"), arg_26_0.name)

		local var_26_1 = var_0_5(pg.ship_skin_template[arg_26_0.skin].fx_container)

		var_26_1:SetGo(arg_26_2)
		pg.EffectMgr.GetInstance():PlayBattleEffect(ys.Battle.BattleFXPool.GetInstance():GetCharacterFX("movewave", var_26_1), Vector3(0, 0, 0), true)
		table.insert(self.otherShipGos, arg_26_2)

		return
	end

	local var_25_2 = {}
	local var_25_3 = {
		math.random(43, 48),
		math.random(49, 53)
	}

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		var_25_0:AddPreloadResource(var_25_0.GetShipResource(iter_25_1.id, iter_25_1.skin), false)
		table.insert(var_25_2, function(arg_27_0)
			assert(pg.ship_skin_template[iter_25_1.skin], iter_25_1.skin)
			var_25_0:InstCharacter(pg.ship_skin_template[iter_25_1.skin].prefab, function(arg_28_0)
				var_25_1(iter_25_1, var_25_3[iter_25_0], arg_28_0)
				arg_27_0()

				return
			end)

			return
		end)
	end

	local function var_25_4()
		for iter_29_0, iter_29_1 in ipairs(self.otherShipGos) do
			Destroy(iter_29_1)
		end

		self.otherShipGos = nil

		arg_25_2()

		return
	end

	var_25_0:StartPreload(function()
		seriesAsync(var_25_2, function()
			self:StartMoveOtherShips(var_25_4)

			return
		end)

		return
	end, nil)

	return
end

function GuildMissionBattleView:PlayAttackAnim()
	self.isFinish = nil

	local function var_32_0()
		if not self.animTimer then
			return
		end

		self.animTimer:Stop()

		self.animTimer = nil

		return
	end

	seriesAsync({
		function(arg_34_0)
			var_32_0()
			self.seaEmenyAnimator:SetAction("move", 0, true)

			local var_34_0 = self.seaEmeny.transform

			self.seaEmeny.transform.localPosition = var_0_1 + Vector3(40, 0, 0)

			setActive(self.seaEmeny, true)

			self.animTimer = Timer.New(function()
				var_34_0.localPosition = Vector3.Lerp(var_34_0.localPosition, var_0_1, Time.deltaTime * 3)

				if Vector3.Distance(var_0_1, var_34_0.localPosition) <= 1 then
					arg_34_0()
				end

				return
			end, 0.033, -1)

			self.animTimer:Start()

			return
		end,
		function(arg_36_0)
			var_32_0()

			if self.shipVO:getShipType() ~= ShipType.WeiXiu then
				self:SeaFire()
			end

			self.animTimer = Timer.New(arg_36_0, 3, 1)

			self.animTimer:Start()

			return
		end,
		function(arg_37_0)
			var_32_0()

			if not self.isFinish then
				self:HandleBulletHit(nil, self.unitList[1])
			end

			self.seaAnimator:SetActionCallBack(function(arg_38_0)
				if arg_38_0 == "finish" then
					self.seaAnimator:SetAction("move", 0, true)
					self.seaAnimator:SetActionCallBack(nil)
					arg_37_0()
				end

				return
			end)
			self.seaAnimator:SetAction("victory", 0, true)

			return
		end
	})

	return
end

function GuildMissionBattleView:PlayItemAnim()
	local function var_39_0()
		if not self.animTimer then
			return
		end

		self.animTimer:Stop()

		self.animTimer = nil

		return
	end

	var_39_0()
	seriesAsync({
		function(arg_41_0)
			self.seaItemBoxAnimator:SetAction("move", 0, true)
			setActive(self.seaItemBox, true)

			local var_41_0 = self.seaItemBox.transform

			self.seaItemBox.transform.localPosition = var_0_4
			self.animTimer = Timer.New(function()
				var_41_0.localPosition = Vector3.Lerp(var_41_0.localPosition, var_0_1, Time.deltaTime * 3)

				if Vector3.Distance(var_0_1, var_41_0.localPosition) <= 1 then
					arg_41_0()
				end

				return
			end, 0.033, -1)

			self.animTimer:Start()

			return
		end,
		function(arg_43_0)
			var_39_0()
			self.seaAnimator:SetActionCallBack(function(arg_44_0)
				if arg_44_0 == "finish" then
					self.seaAnimator:SetAction("move", 0, true)
					self.seaAnimator:SetActionCallBack(nil)
					arg_43_0()
				end

				return
			end)
			self.seaAnimator:SetAction("victory", 0, true)

			return
		end
	})

	return
end

function GuildMissionBattleView:CreateMonster(arg_45_1)
	local var_45_0 = ys.Battle.BattleDataFunction.CreateBattleUnitData(1, ys.Battle.BattleConst.UnitType.ENEMY_UNIT, -1, var_0_2, nil, {}, nil, nil, false, 1, 1, nil, nil, 1)

	var_45_0:SetPosition(var_0_1)
	var_45_0:ActiveCldBox()
	self._cldSystem:InitShipCld(var_45_0)

	local var_45_1 = var_0_5(var_45_0:GetTemplate().fx_container)

	ys.Battle.BattleResourceManager.GetInstance():InstCharacter(var_45_0:GetTemplate().prefab, function(arg_46_0)
		var_45_1:SetGo(arg_46_0)

		local var_46_0 = var_45_0:GetTemplate().scale / 50

		arg_46_0.transform.localScale = Vector3(var_46_0, var_46_0, var_46_0)
		arg_46_0.transform.localPosition = var_0_1
		arg_46_0.transform.localEulerAngles = Vector3(30, 0, 0)

		pg.EffectMgr.GetInstance():PlayBattleEffect(ys.Battle.BattleFXPool.GetInstance():GetCharacterFX(var_45_0:GetTemplate().wave_fx, var_45_1), Vector3(0, 0, 0), true)

		self.seaEmeny = arg_46_0
		self.seaEmenyAnimator = arg_46_0.transform:GetComponent("SpineAnim")

		setActive(arg_46_0, false)
		arg_45_1()

		return
	end)

	self.unitList[1] = var_45_0

	return
end

function GuildMissionBattleView:CreateItemBox(arg_47_1)
	local var_47_0 = pg.enemy_data_statistics[var_0_3]

	ys.Battle.BattleResourceManager.GetInstance():InstCharacter(pg.enemy_data_statistics[var_0_3].prefab, function(arg_48_0)
		arg_48_0.transform.localScale = Vector3(var_47_0.scale / 50, var_47_0.scale / 50, var_47_0.scale / 50)
		arg_48_0.transform.localPosition = var_0_4
		arg_48_0.transform.localEulerAngles = Vector3(30, 0, 0)
		self.seaItemBox = arg_48_0
		self.seaItemBoxAnimator = arg_48_0.transform:GetComponent("SpineAnim")

		setActive(arg_48_0, false)
		arg_47_1()

		return
	end)

	return
end

function GuildMissionBattleView:playShipAnims()
	if self.loaded and self.seaAnimator then
		local var_49_0 = {
			"attack",
			"victory",
			"dead"
		}

		local function var_49_1(arg_50_0)
			if self.seaAnimator then
				self.seaAnimator:SetActionCallBack(nil)
			end

			self.seaAnimator:SetAction(var_49_0[arg_50_0], 0, false)
			self.seaAnimator:SetActionCallBack(function(arg_51_0)
				if arg_51_0 == "finish" then
					self.seaAnimator:SetActionCallBack(nil)
					self.seaAnimator:SetAction("stand", 0, false)
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
			var_49_1(math.random(1, #var_49_0))

			return
		end, 5, -1)

		self.palyAnimTimer:Start()
		self.palyAnimTimer.func()
	end

	return
end

function GuildMissionBattleView:onWeaponUpdate()
	if self.loaded and self.weaponIds then
		if self.seaAnimator then
			self.seaAnimator:SetActionCallBack(nil)
		end

		local function var_53_0()
			for iter_54_0, iter_54_1 in pairs(self.weaponList or {}) do
				for iter_54_2, iter_54_3 in pairs(iter_54_1.emitterList or {}) do
					iter_54_3:Destroy()
				end
			end

			for iter_54_4, iter_54_5 in ipairs(self.bulletList or {}) do
				Object.Destroy(iter_54_5._go)
			end

			for iter_54_6, iter_54_7 in pairs(self.aircraftList or {}) do
				Object.Destroy(iter_54_7.obj)
			end

			self.bulletList = {}
			self.aircraftList = {}

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
				var_53_0()
			elseif self.buffTimer then
				pg.TimeMgr.GetInstance():RemoveBattleTimer(self.buffTimer)

				self.buffTimer = nil
			end

			self:playShipAnims()
		elseif self.shipVO:getShipType() ~= ShipType.WeiXiu then
			var_53_0()
			self:MakeWeapon(self.weaponIds)
		elseif self.weaponIds[1] then
			self:MakeBuff(Equipment.getConfigData(self.weaponIds[1]).skill_id[1])
		end
	end

	return
end

function GuildMissionBattleView:SeaFire()
	local var_55_0 = 1

	local function var_55_2()
		local var_56_0 = self.weaponList[var_55_0]

		if self.weaponList[var_55_0] then
			local function var_56_1()
				for iter_57_0, iter_57_1 in ipairs(var_56_0.emitterList) do
					iter_57_1:Ready()
				end

				for iter_57_2, iter_57_3 in ipairs(var_56_0.emitterList) do
					iter_57_3:Fire(nil, 1, 0)
				end

				var_55_0 = var_55_0 + 1

				return
			end

			if var_56_0.tmpData.action_index ~= "" then
				self.characterAction = var_56_0.tmpData.action_index

				self.seaAnimator:SetAction(self.characterAction, 0, false)
				self.seaAnimator:SetActionCallBack(function(arg_58_0)
					if arg_58_0 == "action" then
						var_56_1()
					end

					return
				end)
			else
				var_56_1()
			end

			if var_56_0.tmpData.type == ys.Battle.BattleConst.EquipmentType.PREVIEW_ARICRAFT then
				self.timer = Timer.New(var_55_2, 1.5, 1)

				self.timer:Start()
			end
		elseif self.characterAction ~= ys.Battle.BattleConst.ActionName.MOVE then
			self.characterAction = ys.Battle.BattleConst.ActionName.MOVE

			self.seaAnimator:SetAction(self.characterAction, 0, true)

			var_55_0 = 1
		end

		return
	end

	;(nil)()

	return
end

function GuildMissionBattleView:MakeBuff(arg_59_1)
	local var_59_0 = getSkillConfig(arg_59_1)
	local var_59_1 = pg.skillCfg["skill_" .. var_59_0.effect_list[1].arg_list.skill_id]

	if self.buffTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self.buffTimer)

		self.buffTimer = nil
	end

	self.buffTimer = pg.TimeMgr.GetInstance():AddBattleTimer("buffTimer", -1, var_59_0.effect_list[1].arg_list.time, function()
		setActive(self.healTF, true)
		setText(self.healTF:Find("text"), var_59_1.effect_list[1].arg_list.number)

		return
	end)

	return
end

function GuildMissionBattleView:MakeWeapon(arg_61_1)
	self.weaponList = {}
	self.bulletList = {}
	self.aircraftList = {}

	local var_61_0 = 0

	for iter_61_0, iter_61_1 in ipairs(arg_61_1) do
		for iter_61_2, iter_61_3 in ipairs(Equipment.getConfigData(iter_61_1).weapon_id) do
			if iter_61_3 <= 0 then
				break
			end

			var_61_0 = var_61_0 + 1

			local var_61_1 = ys.Battle.BattleDataFunction.GetWeaponPropertyDataFromID(iter_61_3)

			if var_61_1.type == ys.Battle.BattleConst.EquipmentType.MAIN_CANNON or var_61_1.type == ys.Battle.BattleConst.EquipmentType.SUB_CANNON or var_61_1.type == ys.Battle.BattleConst.EquipmentType.TORPEDO or var_61_1.type == ys.Battle.BattleConst.EquipmentType.MANUAL_TORPEDO or var_61_1.type == ys.Battle.BattleConst.EquipmentType.POINT_HIT_AND_LOCK then
				if type(var_61_1.barrage_ID) == "table" then
					self.weaponList[var_61_0] = {
						tmpData = var_61_1,
						emitterList = {}
					}

					for iter_61_4, iter_61_5 in ipairs(var_61_1.barrage_ID) do
						self.weaponList[var_61_0].emitterList[iter_61_4] = self:createEmitterCannon(iter_61_5, var_61_1.bullet_ID[iter_61_4], var_61_1.spawn_bound)
					end
				end
			elseif var_61_1.type == ys.Battle.BattleConst.EquipmentType.PREVIEW_ARICRAFT and type(var_61_1.barrage_ID) == "table" then
				self.weaponList[var_61_0] = {
					tmpData = var_61_1,
					emitterList = {}
				}

				for iter_61_6, iter_61_7 in ipairs(var_61_1.barrage_ID) do
					self.weaponList[var_61_0].emitterList[iter_61_6] = self:createEmitterAir(iter_61_7, var_61_1.bullet_ID[iter_61_6], var_61_1.spawn_bound)
				end
			end
		end
	end

	return
end

function GuildMissionBattleView:createEmitterCannon(arg_62_1, arg_62_2, arg_62_3)
	return (ys.Battle.BattleBulletEmitter.New(function(arg_63_0, arg_63_1, arg_63_2, arg_63_3, arg_63_4)
		local var_63_0 = ys.Battle.BattlePlayerUnit.New(1, ys.Battle.BattleConfig.FRIENDLY_CODE)

		var_63_0:SetSkinId(self.shipVO.skinId)
		var_63_0:SetTemplate(self.shipVO.configId, {
			speed = 0
		})

		local var_63_1, var_63_2 = ys.Battle.BattleDataFunction.CreateBattleBulletData(arg_62_2, arg_62_2, var_63_0, nil, self:GetCharacterOffset() + Vector3(40, 0, 0))

		if var_63_2 then
			self._cldSystem:InitBulletCld(var_63_1)
		end

		var_63_1:SetOffsetPriority(arg_63_3)
		var_63_1:SetShiftInfo(arg_63_0, arg_63_1)
		var_63_1:SetRotateInfo(nil, 0, arg_63_2)

		if self.equipSkinId > 0 then
			local var_63_3 = pg.equip_skin_template[self.equipSkinId]
			local var_63_4, var_63_5, var_63_6, var_63_7 = ys.Battle.BattleDataFunction.GetEquipSkin(self.equipSkinId)
			local var_63_8 = var_63_1:GetType()

			if var_63_8 == ys.Battle.BattleConst.BulletType.CANNON or var_63_8 == ys.Battle.BattleConst.BulletType.BOMB then
				if _.any({
					EquipType.CannonQuZhu,
					EquipType.CannonQingXun,
					EquipType.CannonZhongXun,
					EquipType.CannonZhanlie,
					EquipType.CannonZhongXun2
				}, function(arg_64_0)
					return table.contains(var_63_3.equip_type, arg_64_0)
				end) then
					var_63_1:SetModleID(var_63_4)
				elseif var_63_5 and #var_63_5 > 0 then
					var_63_1:SetModleID(var_63_5)
				elseif var_63_7 and #var_63_7 > 0 then
					var_63_1:SetModleID(var_63_7)
				end
			elseif var_63_8 == ys.Battle.BattleConst.BulletType.TORPEDO then
				if table.contains(pg.equip_skin_template[self.equipSkinId].equip_type, EquipType.Torpedo) then
					var_63_1:SetModleID(var_63_4)
				elseif var_63_6 and #var_63_6 > 0 then
					var_63_1:SetModleID(var_63_6)
				end
			end
		end

		local var_63_10 = var_63_1:GetType()
		local var_63_11 = var_63_10 == ys.Battle.BattleConst.BulletType.CANNON and ys.Battle.BattleCannonBullet.New() or var_63_10 == ys.Battle.BattleConst.BulletType.BOMB and ys.Battle.BattleBombBullet.New() or var_63_10 == ys.Battle.BattleConst.BulletType.TORPEDO and ys.Battle.BattleTorpedoBullet.New() or ys.Battle.BattleBullet.New()

		var_63_11:SetBulletData(var_63_1)
		table.insert(self.bulletUnitList, var_63_1)

		local function var_63_12(arg_65_0)
			var_63_11:SetGO(arg_65_0)
			var_63_11:AddRotateScript()

			if tf(arg_65_0).parent then
				tf(arg_65_0).parent = nil
			end

			var_63_11:SetSpawn(self:GetCharacterOffset() + (self.boneList[arg_62_3] or Vector3.zero))

			if self.bulletList then
				table.insert(self.bulletList, var_63_11)
			end

			return
		end

		ys.Battle.BattleResourceManager.GetInstance():InstBullet(var_63_11:GetModleID(), function(arg_66_0)
			var_63_12(arg_66_0)

			return
		end)

		return
	end, function()
		return
	end, arg_62_1))
end

function GuildMissionBattleView:createEmitterAir(arg_68_1, arg_68_2, arg_68_3)
	return (ys.Battle.BattleBulletEmitter.New(function(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
		local var_69_0 = {
			id = arg_68_2
		}
		local var_69_1 = pg.aircraft_template[arg_68_2]

		var_69_0.tmpData = pg.aircraft_template[arg_68_2]

		local var_69_2 = Vector3(math.cos(math.deg2Rad * arg_69_2), 0, math.sin(math.deg2Rad * arg_69_2))

		local function var_69_3(arg_70_0)
			local var_70_0 = self:GetCharacterOffset()
			local var_70_1 = var_70_0 + Vector3(var_69_1.position_offset[1] + arg_69_0, var_69_1.position_offset[2], var_69_1.position_offset[3] + arg_69_1)

			arg_70_0.transform.localPosition = var_70_1
			arg_70_0.transform.localScale = Vector3(0.1, 0.1, 0.1)
			var_69_0.obj = arg_70_0
			var_69_0.tf = arg_70_0.transform
			var_69_0.pos = var_70_1
			var_69_0.baseVelocity = ys.Battle.BattleFormulas.ConvertAircraftSpeed(var_69_0.tmpData.speed)
			var_69_0.speed = var_69_2 * var_69_0.baseVelocity
			var_69_0.speedZ = (math.random() - 0.5) * 0.5
			var_69_0.targetZ = var_70_0.z

			if self.aircraftList then
				table.insert(self.aircraftList, var_69_0)
			end

			return
		end

		ys.Battle.BattleResourceManager.GetInstance():InstAirCharacter((self.equipSkinId > 0 and table.contains(pg.equip_skin_template[self.equipSkinId].equip_type, ({
			EquipType.FighterAircraft,
			EquipType.TorpedoAircraft,
			EquipType.BomberAircraft
		})[pg.aircraft_template[arg_68_2].type]) or nil) and ys.Battle.BattleDataFunction.GetEquipSkin(self.equipSkinId), function(arg_71_0)
			var_69_3(arg_71_0)

			return
		end)

		return
	end, function()
		return
	end, arg_68_1))
end

function GuildMissionBattleView:RemoveBullet(arg_73_1, arg_73_2)
	table.remove(self.bulletUnitList, arg_73_1)
	Object.Destroy(self.bulletList[arg_73_1]._go)
	table.remove(self.bulletList, arg_73_1)

	if arg_73_2 then
		local var_73_0 = self.bulletList[arg_73_1]:GetMissFXID()

		if var_73_0 and var_73_0 ~= "" then
			local var_73_1, var_73_2 = self.seaFXPool:GetFX(var_73_0)

			pg.EffectMgr.GetInstance():PlayBattleEffect(var_73_1, self.bulletList[arg_73_1]:GetPosition() + var_73_2, true)
		end
	end

	return
end

function GuildMissionBattleView:SeaUpdate()
	if not self.bulletList then
		return
	end

	local var_74_0 = 0
	local var_74_1 = -20
	local var_74_2 = 60
	local var_74_3 = 0
	local var_74_4 = 60
	local var_74_5 = ys.Battle.BattleConfig
	local var_74_6 = ys.Battle.BattleConst

	pg.TimeMgr.GetInstance():AddBattleTimer("barrageUpdateTimer", -1, 0.033, function()
		for iter_75_0 = #self.bulletUnitList, 1, -1 do
			self._cldSystem:UpdateBulletCld(self.bulletUnitList[iter_75_0])
		end

		for iter_75_1 = #self.bulletList, 1, -1 do
			local var_75_0 = self.bulletList[iter_75_1]._bulletData:GetSpeed()()
			local var_75_1 = self.bulletList[iter_75_1]:GetPosition()

			if var_75_1.x > var_74_2 and var_75_0.x > 0 or var_75_1.z < var_74_3 and var_75_0.z < 0 then
				self:RemoveBullet(iter_75_1, false)
			elseif var_75_1.x < var_74_1 and var_75_0.x < 0 and self.bulletList[iter_75_1]:GetType() ~= var_74_6.BulletType.BOMB then
				self:RemoveBullet(iter_75_1, false)
			else
				self.bulletList[iter_75_1]._bulletData:Update((pg.TimeMgr.GetInstance():GetCombatTime()))
				self.bulletList[iter_75_1]:Update(var_74_0)

				if var_75_1.z > var_74_4 and var_75_0.z > 0 or self.bulletList[iter_75_1]._bulletData:IsOutRange(var_74_0) then
					self:RemoveBullet(iter_75_1, true)
				end
			end
		end

		for iter_75_2, iter_75_3 in ipairs(self.aircraftList) do
			local var_75_2 = iter_75_3.pos + iter_75_3.speed

			if (iter_75_3.pos + iter_75_3.speed).y < var_74_5.AircraftHeight + 5 then
				iter_75_3.speed.y = math.max(0.4, 1 - var_75_2.y / var_74_5.AircraftHeight)

				local var_75_3 = math.min(1, var_75_2.y / var_74_5.AircraftHeight)

				iter_75_3.tf.localScale = Vector3(var_75_3, var_75_3, var_75_3)
			end

			iter_75_3.speed.z = iter_75_3.baseVelocity * iter_75_3.speedZ

			if iter_75_3.targetZ - var_75_2.z > iter_75_3.baseVelocity then
				iter_75_3.speed.z = iter_75_3.baseVelocity * 0.5
			elseif iter_75_3.targetZ - var_75_2.z < -iter_75_3.baseVelocity then
				iter_75_3.speed.z = -iter_75_3.baseVelocity * 0.5
			else
				local var_75_4 = self:GetCharacterOffset()

				iter_75_3.targetZ = var_75_4.z + var_75_4.z * (math.random() - 0.5) * 0.6
			end

			if var_75_2.x > var_74_2 or var_75_2.x < var_74_1 then
				Object.Destroy(iter_75_3.obj)
				table.remove(self.aircraftList, iter_75_2)
			else
				iter_75_3.tf.localPosition = var_75_2
				iter_75_3.pos = var_75_2
			end
		end

		var_74_0 = var_74_0 + 1

		return
	end)

	return
end

function GuildMissionBattleView:GetCharacterOffset()
	return Vector3(0, -3, 40)
end

function GuildMissionBattleView:GetTotalBounds()
	local var_77_0 = {
		-70,
		20,
		90,
		70
	}

	return var_77_0[2] + var_77_0[4], var_77_0[2], var_77_0[1], var_77_0[1] + var_77_0[3]
end

function GuildMissionBattleView:HandleShipCrashDecelerate()
	return
end

function GuildMissionBattleView:HandleShipCrashDecelerate()
	return
end

function GuildMissionBattleView:HandleShipCrashDamageList()
	return
end

function GuildMissionBattleView:HandleBulletHit(arg_81_1, arg_81_2)
	for iter_81_0 = #self.bulletUnitList, 1, -1 do
		if self.bulletUnitList[iter_81_0] == arg_81_1 then
			self:RemoveBullet(iter_81_0, true)
		end
	end

	if not self.isFinish then
		self.isFinish = true

		setActive(self.seaEmeny, false)

		local var_81_0, var_81_1 = ys.Battle.BattleFXPool.GetInstance():GetFX("Bomb")

		pg.EffectMgr.GetInstance():PlayBattleEffect(var_81_0, var_81_1:Add(arg_81_2:GetPosition()), true)
	end

	return
end

function GuildMissionBattleView:HandleWallHitByBullet()
	return
end

function GuildMissionBattleView:GetUnitList()
	return self.unitList
end

function GuildMissionBattleView:GetAircraftList()
	return {}
end

function GuildMissionBattleView:GetBulletList()
	return self.bulletUnitList
end

function GuildMissionBattleView:GetAOEList()
	return {}
end

function GuildMissionBattleView:GetFriendlyCode()
	return 1
end

function GuildMissionBattleView:GetFoeCode()
	return -1
end

function GuildMissionBattleView:clear()
	if self.animTimer then
		self.animTimer:Stop()

		self.animTimer = nil
	end

	if self._cldSystem then
		self._cldSystem:Dispose()
	end

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	pg.TimeMgr.GetInstance():RemoveAllBattleTimer()

	if self.seaCharacter then
		Destroy(self.seaCharacter)

		self.seaCharacter = nil
	end

	if self.otherShipGos then
		for iter_89_0, iter_89_1 in ipairs(self.otherShipGos) do
			Destroy(iter_89_1)
		end

		self.otherShipGos = nil
	end

	if self.aircraftList then
		for iter_89_2, iter_89_3 in ipairs(self.aircraftList) do
			Destroy(iter_89_3.obj)
		end

		self.aircraftList = nil
	end

	if self.seaView then
		self.seaView:Dispose()

		self.seaView = nil
	end

	if self.weaponList then
		for iter_89_4, iter_89_5 in ipairs(self.weaponList) do
			for iter_89_6, iter_89_7 in ipairs(iter_89_5.emitterList) do
				iter_89_7:Destroy()
			end
		end

		self.weaponList = nil
	end

	if self.bulletList then
		for iter_89_8, iter_89_9 in ipairs(self.bulletList) do
			Destroy(iter_89_9._go)
		end

		self.bulletList = nil
	end

	if self.seaFXPool then
		self.seaFXPool:Clear()

		self.seaFXPool = nil
	end

	if self.seaEmeny then
		Destroy(self.seaEmeny)

		self.seaEmeny = nil
	end

	if self.seaItemBox then
		Destroy(self.seaItemBox)

		self.seaItemBox = nil
	end

	if self.seaFXContainersPool then
		self.seaFXContainersPool:Clear()

		self.seaFXContainersPool = nil
	end

	ys.Battle.BattleResourceManager.GetInstance():Clear()

	self.seaCamera.enabled = false
	self.seaCameraGO = nil
	self.seaCamera = nil
	self.loaded = false

	if self.palyAnimTimer then
		self.palyAnimTimer:Stop()

		self.palyAnimTimer = nil
	end

	return
end

return GuildMissionBattleView
