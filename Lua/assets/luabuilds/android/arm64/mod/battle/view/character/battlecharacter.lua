ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleBuffEvent
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local var_0_5 = ys.Battle.BattleResourceManager
local var_0_6 = ys.Battle.BattleFormulas
local BattleCharacter = class("BattleCharacter", ys.Battle.BattleSceneObject)

ys.Battle.BattleCharacter = BattleCharacter
BattleCharacter.__name = "BattleCharacter"

local var_0_8 = Vector2(-1200, -1200)
local var_0_9 = Vector3.New(0.3, -1.8, 0)

BattleCharacter.AIM_OFFSET = Vector3.New(0, -3.5, 0)

function BattleCharacter:Ctor()
	BattleCharacter.super.Ctor(self)
	self:Init()

	return
end

function BattleCharacter:Init()
	var_0_0.EventListener.AttachEventListener(self)
	self:InitBulletFactory()
	self:InitEffectView()

	self._tagFXList = {}
	self._cacheFXList = {}
	self._allFX = {}
	self._bulletCache = {}
	self._weaponRegisterList = {}
	self._characterPos = Vector3.zero
	self._orbitCount = 0
	self._orbitList = {}
	self._orbitSpineOrderOffset = 0
	self._orbitActionCacheList = {}
	self._orbitSpeedUpdateList = {}
	self._orbitActionUpdateList = {}
	self._inViewArea = false
	self._alwaysHideArrow = false
	self._hideHP = false
	self._referenceVector = Vector3.zero
	self._referenceVectorCache = Vector3.zero
	self._referenceVectorTemp = Vector3.zero
	self._referenceUpdateFlag = false
	self._referenceVectorBorn = nil
	self._hpBarPos = Vector3.zero
	self._arrowVector = Vector3.zero
	self._arrowAngleVector = Vector3.zero
	self._blinkDict = {}
	self._coverSpineHPBarOffset = 0
	self._shaderType = nil
	self._color = nil
	self._actionIndex = nil

	return
end

function BattleCharacter:InitBulletFactory()
	self._bulletFactoryList = var_0_0.Battle.BattleBulletFactory.GetFactoryList()

	return
end

function BattleCharacter:SetUnitData(arg_4_1)
	self._unitData = arg_4_1

	self:AddUnitEvent()

	return
end

function BattleCharacter:SetBoneList()
	self._boneList = {}
	self._remoteBoneTable = {}
	self._bonePosTable = nil
	self._posMatrix = nil

	local var_5_0 = self:GetInitScale()

	for iter_5_0, iter_5_1 in pairs(self._unitData:GetTemplate().bound_bone) do
		if iter_5_0 ~= "remote" then
			self:insertBondList(iter_5_0, iter_5_1)
		end
	end

	for iter_5_2, iter_5_3 in pairs(var_0_4.CommonBone) do
		self:insertBondList(iter_5_2, iter_5_3)
	end

	return
end

function BattleCharacter:insertBondList(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(arg_6_2) do
		if type(iter_6_1) == "table" then
			local var_6_0 = {}

			var_6_0[#var_6_0 + 1] = Vector3(iter_6_1[1], iter_6_1[2], iter_6_1[3])
			self._boneList[arg_6_1] = var_6_0
		end
	end

	return
end

function BattleCharacter:SpawnBullet(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._bulletFactoryList[arg_7_1:GetTemplate().type]:CreateBullet(self._tf, arg_7_1, arg_7_4 or self._unitData:GetRemoteBoundBone(arg_7_2) or self:GetBonePos(arg_7_2), arg_7_3, self._unitData:GetDirection())

	return
end

function BattleCharacter:GetBonePos(arg_8_1)
	local var_8_0 = self._boneList[arg_8_1]

	if self._boneList[arg_8_1] == nil or #var_8_0 == 0 then
		for iter_8_0, iter_8_1 in pairs(self._boneList) do
			var_8_0 = iter_8_1

			break
		end
	end

	local var_8_1

	if not self._posMatrix then
		var_8_1 = self._tf.localToWorldMatrix
		self._posMatrix = self._tf.localToWorldMatrix
		self._bonePosTable = {}
	else
		var_8_1 = self._posMatrix
	end

	local var_8_2 = self._bonePosTable[arg_8_1]

	if self._bonePosTable[arg_8_1] == nil then
		var_8_2 = {}

		for iter_8_2, iter_8_3 in ipairs(var_8_0) do
			var_8_2[#var_8_2 + 1] = var_8_1:MultiplyPoint3x4(iter_8_3)
		end

		self._bonePosTable[arg_8_1] = var_8_2
	end

	if #var_8_2 == 1 then
		return var_8_2[1]
	else
		return var_8_2[math.floor(math.Random(0, #var_8_2)) + 1]
	end

	return
end

function BattleCharacter:GetBoneList()
	return self._boneList
end

function BattleCharacter:AddFXOffsets(arg_10_1, arg_10_2)
	self._FXAttachPoint = arg_10_1
	self._FXOffset = arg_10_2

	return
end

function BattleCharacter:GetFXOffsets(arg_11_1)
	arg_11_1 = arg_11_1 or 1

	return self._FXOffset[arg_11_1]
end

function BattleCharacter:GetAttachPoint()
	return self._FXAttachPoint
end

function BattleCharacter:GetSpecificFXScale()
	return {}
end

function BattleCharacter:PlayFX(arg_14_1)
	pg.EffectMgr.GetInstance():PlayBattleEffect(self:GetFactory():GetFXPool():GetFX(arg_14_1), self:GetPosition(), true)

	return
end

function BattleCharacter:AddFX(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = self:GetFactory():GetFXPool():GetCharacterFX(arg_15_1, self, not arg_15_2, function(arg_16_0)
		if arg_15_4 then
			arg_15_4()
		end

		self._allFX[arg_16_0] = nil

		return
	end, arg_15_3)

	if arg_15_2 then
		local var_15_1 = self._cacheFXList[arg_15_1] or {}

		table.insert(var_15_1, var_15_0)

		self._cacheFXList[arg_15_1] = var_15_1
	end

	self._allFX[var_15_0] = true

	return var_15_0
end

function BattleCharacter:RemoveFX(arg_17_1)
	if self._allFX and self._allFX[arg_17_1] then
		self._allFX[arg_17_1] = nil

		var_0_5.GetInstance():DestroyOb(arg_17_1)
	end

	return
end

function BattleCharacter:RemoveCacheFX(arg_18_1)
	if self._cacheFXList[arg_18_1] ~= nil and #self._cacheFXList[arg_18_1] > 0 then
		local var_18_0 = table.remove(self._cacheFXList[arg_18_1])

		self._allFX[var_18_0] = nil

		var_0_5.GetInstance():DestroyOb(var_18_0)
	end

	return
end

function BattleCharacter:AddWaveFX(arg_19_1)
	self._waveFX = self:AddFX(arg_19_1)

	return
end

function BattleCharacter:RemoveWaveFX()
	if not self._waveFX then
		return
	end

	self:RemoveFX(self._waveFX)

	return
end

function BattleCharacter:onAddBuffClock(arg_21_1)
	if arg_21_1.Data.isActive then
		if not self._buffClock then
			self._factory:MakeBuffClock(self)
		end

		self._buffClock:Casting(arg_21_1.Data)
	else
		self._buffClock:Interrupt(arg_21_1.Data)
	end

	return
end

function BattleCharacter:AddBlink(arg_22_1, arg_22_2, arg_22_3, arg_22_4, arg_22_5, arg_22_6, arg_22_7)
	if self._unitData:GetDiveInvisible() then
		return nil
	end

	if not self._unitData:GetExposed() then
		return nil
	end

	arg_22_4 = arg_22_4 or 0.1
	arg_22_5 = arg_22_5 or 0.1
	arg_22_6 = arg_22_6 or false
	arg_22_7 = arg_22_7 or 0.18

	local var_22_0 = SpineAnim.CharBlink(self._go, arg_22_1, arg_22_2, arg_22_3, arg_22_7, arg_22_4, arg_22_5, arg_22_6)

	if not arg_22_6 then
		self._blinkDict[var_22_0] = {
			r = arg_22_1,
			g = arg_22_2,
			b = arg_22_3,
			a = arg_22_7,
			peroid = arg_22_4,
			duration = arg_22_5
		}
	end

	return var_22_0
end

function BattleCharacter:RemoveBlink(arg_23_1)
	self._blinkDict[arg_23_1] = nil

	SpineAnim.RemoveBlink(self._go, arg_23_1)

	return
end

function BattleCharacter:AddShaderColor(arg_24_1)
	if not self._unitData:GetExposed() then
		return
	end

	arg_24_1 = arg_24_1 or Color.New(0, 0, 0, 0)

	SpineAnim.AddShaderColor(self._go, arg_24_1)

	return
end

function BattleCharacter:GetPosition()
	return self._characterPos
end

function BattleCharacter:GetUnitData()
	return self._unitData
end

function BattleCharacter:GetDestroyFXID()
	return self:GetUnitData():GetTemplate().bomb_fx
end

function BattleCharacter:GetOffsetPos()
	return (BuildVector3(self._unitData:GetTemplate().position_offset))
end

function BattleCharacter:GetReferenceVector(arg_29_1)
	if arg_29_1 == nil then
		return self._referenceVector
	else
		self._referenceVectorTemp:Set(self._characterPos.x, self._characterPos.y, self._characterPos.z)
		self._referenceVectorTemp:Sub(arg_29_1)
		var_0_0.Battle.BattleVariable.CameraPosToUICameraByRef(self._referenceVectorTemp)

		self._referenceVectorTemp.z = 2

		return self._referenceVectorTemp
	end

	return
end

function BattleCharacter:GetInitScale()
	return self._unitData:GetAttrByName("modelScale")
end

function BattleCharacter:AddUnitEvent()
	self._unitData:RegisterEventListener(self, var_0_1.SPAWN_CACHE_BULLET, self.onSpawnCacheBullet)
	self._unitData:RegisterEventListener(self, var_0_1.CREATE_TEMPORARY_WEAPON, self.onNewWeapon)
	self._unitData:RegisterEventListener(self, var_0_1.POP_UP, self.onPopup)
	self._unitData:RegisterEventListener(self, var_0_1.VOICE, self.onVoice)
	self._unitData:RegisterEventListener(self, var_0_1.PLAY_FX, self.onPlayFX)
	self._unitData:RegisterEventListener(self, var_0_1.REMOVE_WEAPON, self.onRemoveWeapon)
	self._unitData:RegisterEventListener(self, var_0_1.ADD_BLINK, self.onBlink)
	self._unitData:RegisterEventListener(self, var_0_1.SUBMARINE_VISIBLE, self.onUpdateDiveInvisible)
	self._unitData:RegisterEventListener(self, var_0_1.SUBMARINE_DETECTED, self.onDetected)
	self._unitData:RegisterEventListener(self, var_0_1.SUBMARINE_FORCE_DETECTED, self.onForceDetected)
	self._unitData:RegisterEventListener(self, var_0_1.BLIND_VISIBLE, self.onUpdateBlindInvisible)
	self._unitData:RegisterEventListener(self, var_0_1.BLIND_EXPOSE, self.onBlindExposed)
	self._unitData:RegisterEventListener(self, var_0_1.INIT_ANIT_SUB_VIGILANCE, self.onInitVigilantState)
	self._unitData:RegisterEventListener(self, var_0_1.INIT_CLOAK, self.onInitCloak)
	self._unitData:RegisterEventListener(self, var_0_1.UPDATE_CLOAK_CONFIG, self.onUpdateCloakConfig)
	self._unitData:RegisterEventListener(self, var_0_1.UPDATE_CLOAK_LOCK, self.onUpdateCloakLock)
	self._unitData:RegisterEventListener(self, var_0_1.INIT_AIMBIAS, self.onInitAimBias)
	self._unitData:RegisterEventListener(self, var_0_1.UPDATE_AIMBIAS_LOCK, self.onUpdateAimBiasLock)
	self._unitData:RegisterEventListener(self, var_0_1.HOST_AIMBIAS, self.onHostAimBias)
	self._unitData:RegisterEventListener(self, var_0_1.REMOVE_AIMBIAS, self.onRemoveAimBias)
	self._unitData:RegisterEventListener(self, var_0_1.HIDE_WAVE_FX, self.RemoveWaveFX)
	self._unitData:RegisterEventListener(self, var_0_1.ADD_BUFF_CLOCK, self.onAddBuffClock)
	self._unitData:RegisterEventListener(self, var_0_1.SWITCH_SPINE, self.onSwitchSpine)
	self._unitData:RegisterEventListener(self, var_0_1.SWITCH_SHADER, self.onSwitchShader)
	self._unitData:RegisterEventListener(self, var_0_1.UPDATE_SCORE, self.onUpdateScore)
	self._unitData:RegisterEventListener(self, var_0_2.BUFF_EFFECT_CHNAGE_SIZE, self.onChangeSize)
	self._unitData:RegisterEventListener(self, var_0_2.BUFF_EFFECT_NEW_WEAPON, self.onNewWeapon)
	self._unitData:RegisterEventListener(self, var_0_2.BUFF_EFFECT_RECOIL_SHIELD, self.onRecoilShield)

	for iter_31_0, iter_31_1 in ipairs((self._unitData:GetAutoWeapons())) do
		self:RegisterWeaponListener(iter_31_1)
	end

	self._effectOb:SetUnitDataEvent(self._unitData)

	return
end

function BattleCharacter:RemoveUnitEvent()
	self._unitData:UnregisterEventListener(self, var_0_1.UPDATE_HP)
	self._unitData:UnregisterEventListener(self, var_0_1.CREATE_TEMPORARY_WEAPON)
	self._unitData:UnregisterEventListener(self, var_0_1.CHANGE_ACTION)
	self._unitData:UnregisterEventListener(self, var_0_1.SPAWN_CACHE_BULLET)
	self._unitData:UnregisterEventListener(self, var_0_1.POP_UP)
	self._unitData:UnregisterEventListener(self, var_0_1.VOICE)
	self._unitData:UnregisterEventListener(self, var_0_1.PLAY_FX)
	self._unitData:UnregisterEventListener(self, var_0_1.REMOVE_WEAPON)
	self._unitData:UnregisterEventListener(self, var_0_1.ADD_BLINK)
	self._unitData:UnregisterEventListener(self, var_0_1.SUBMARINE_VISIBLE)
	self._unitData:UnregisterEventListener(self, var_0_1.SUBMARINE_DETECTED)
	self._unitData:UnregisterEventListener(self, var_0_1.SUBMARINE_FORCE_DETECTED)
	self._unitData:UnregisterEventListener(self, var_0_1.BLIND_VISIBLE)
	self._unitData:UnregisterEventListener(self, var_0_1.BLIND_EXPOSE)
	self._unitData:UnregisterEventListener(self, var_0_1.UPDATE_SCORE)
	self._unitData:UnregisterEventListener(self, var_0_1.CHANGE_ANTI_SUB_VIGILANCE)
	self._unitData:UnregisterEventListener(self, var_0_1.INIT_ANIT_SUB_VIGILANCE)
	self._unitData:UnregisterEventListener(self, var_0_1.ANTI_SUB_VIGILANCE_SONAR_CHECK)
	self._unitData:UnregisterEventListener(self, var_0_1.UPDATE_CLOAK_CONFIG)
	self._unitData:UnregisterEventListener(self, var_0_1.UPDATE_CLOAK_LOCK)
	self._unitData:UnregisterEventListener(self, var_0_1.INIT_CLOAK)
	self._unitData:UnregisterEventListener(self, var_0_1.HOST_AIMBIAS)
	self._unitData:UnregisterEventListener(self, var_0_1.UPDATE_AIMBIAS_LOCK)
	self._unitData:UnregisterEventListener(self, var_0_1.INIT_AIMBIAS)
	self._unitData:UnregisterEventListener(self, var_0_1.REMOVE_AIMBIAS)
	self._unitData:UnregisterEventListener(self, var_0_1.ADD_BUFF_CLOCK)
	self._unitData:UnregisterEventListener(self, var_0_1.SWITCH_SPINE)
	self._unitData:UnregisterEventListener(self, var_0_1.SWITCH_SHADER)
	self._unitData:UnregisterEventListener(self, var_0_2.BUFF_EFFECT_CHNAGE_SIZE)
	self._unitData:UnregisterEventListener(self, var_0_2.BUFF_EFFECT_NEW_WEAPON)
	self._unitData:UnregisterEventListener(self, var_0_2.BUFF_EFFECT_RECOIL_SHIELD)

	for iter_32_0, iter_32_1 in pairs(self._weaponRegisterList) do
		self:UnregisterWeaponListener(iter_32_0)
	end

	return
end

function BattleCharacter:Update()
	local var_33_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	self._bonePosSet = nil

	self:UpdateUIComponentPosition()
	self:UpdateHPPop()
	self:UpdateAniEffect(var_33_0)
	self:UpdateTagEffect(var_33_0)

	if self._referenceUpdateFlag then
		self:UpdateHPBarPosition()
		self:UpdateHPPopContainerPosition()
	end

	self:UpdateChatPosition()
	self:UpdateHpBar()
	self:updateSomkeFX()
	self:UpdateAimBiasBar()
	self:UpdateShieldBar()
	self:UpdateBuffClock()
	self:UpdateOrbit()

	return
end

function BattleCharacter:RegisterWeaponListener(arg_34_1)
	if self._weaponRegisterList[arg_34_1] then
		return
	end

	arg_34_1:RegisterEventListener(self, var_0_1.CREATE_BULLET, self.onCreateBullet)
	arg_34_1:RegisterEventListener(self, var_0_1.FIRE, self.onCannonFire)

	self._weaponRegisterList[arg_34_1] = true

	return
end

function BattleCharacter:UnregisterWeaponListener(arg_35_1)
	self._weaponRegisterList[arg_35_1] = nil

	arg_35_1:UnregisterEventListener(self, var_0_1.CREATE_BULLET)
	arg_35_1:UnregisterEventListener(self, var_0_1.FIRE)

	return
end

function BattleCharacter:onCreateBullet(arg_36_1)
	self:SpawnBullet(arg_36_1.Data.bullet, arg_36_1.Data.spawnBound, arg_36_1.Data.fireFxID, arg_36_1.Data.position)

	return
end

function BattleCharacter:onCannonFire(arg_37_1)
	local var_37_0 = arg_37_1.Data.target
	local var_37_1 = arg_37_1.Data.actionIndex
	local var_37_2

	if not arg_37_1.Data.actionIndex then
		var_37_1 = "attack"
	end

	if not self._unitData:NeedWeaponCache() then
		var_37_2 = self._cacheWeapon ~= nil
	else
		self._cacheWeapon = {}
		var_37_2 = true

		self._unitData:StateChange(var_0_0.Battle.UnitState.STATE_ATTACK, var_37_1)
	end

	if var_37_2 == true then
		self._cacheWeapon[#self._cacheWeapon + 1] = {
			weapon = arg_37_1.Dispatcher,
			target = var_37_0,
			weapon = arg_37_1.Dispatcher,
			target = var_37_0
		}
	else
		arg_37_1.Dispatcher:DoAttack(var_37_0)
	end

	return
end

function BattleCharacter:onSpawnCacheBullet()
	if self._cacheWeapon then
		for iter_38_0, iter_38_1 in ipairs(self._cacheWeapon) do
			iter_38_1.weapon:DoAttack(iter_38_1.target)

			if not self._unitData:IsAlive() then
				break
			end
		end

		self._cacheWeapon = nil
	end

	return
end

function BattleCharacter:onNewWeapon(arg_39_1)
	self:RegisterWeaponListener(arg_39_1.Data.weapon)

	return
end

function BattleCharacter:onPopup(arg_40_1)
	self:SetPopup(arg_40_1.Data.content, arg_40_1.Data.duration, arg_40_1.Data.key)

	return
end

function BattleCharacter:onVoice(arg_41_1)
	self:Voice(arg_41_1.Data.content, arg_41_1.Data.key)

	return
end

function BattleCharacter:onPlayFX(arg_42_1)
	if arg_42_1.Data.notAttach then
		self:PlayFX(arg_42_1.Data.fxName)
	else
		self:AddFX(arg_42_1.Data.fxName)
	end

	return
end

function BattleCharacter:onRemoveWeapon(arg_43_1)
	if self._cacheWeapon then
		for iter_43_0, iter_43_1 in ipairs(self._cacheWeapon) do
			if iter_43_1.weapon == arg_43_1.Data.weapon then
				table.remove(self._cacheWeapon, iter_43_0)

				break
			end
		end
	end

	self:UnregisterWeaponListener(arg_43_1.Data.weapon)

	return
end

function BattleCharacter:onBlink(arg_44_1)
	self:AddBlink(arg_44_1.Data.blink.red, arg_44_1.Data.blink.green, arg_44_1.Data.blink.blue, arg_44_1.Data.blink.peroid, arg_44_1.Data.blink.duration, true, arg_44_1.Data.blink.alpha)

	return
end

function BattleCharacter:onUpdateDiveInvisible(arg_45_1)
	self:UpdateDiveInvisible()

	return
end

function BattleCharacter:UpdateDiveInvisible(arg_46_1)
	if not self._go then
		return
	end

	local var_46_0 = not self._unitData:GetForceExpose() and self._unitData:GetDiveInvisible()
	local var_46_1 = self._unitData:GetIFF() == var_0_4.FOE_CODE

	if var_46_0 then
		self:updateInvisible(var_46_0, var_46_1 and "GRID_TRANSPARENT" or "SEMI_TRANSPARENT", (self:GetFactory():GetDivingFilterColor()))

		if not arg_46_1 and var_46_1 then
			self:spineSemiTransparentFade(0, 0.7, 0)
		end
	else
		self:updateInvisible(var_46_0)

		if not var_46_1 then
			self:AddShaderColor()
		end
	end

	if var_46_1 then
		self:updateComponentVisible()
	end

	return
end

function BattleCharacter:onUpdateBlindInvisible(arg_47_1)
	self:UpdateBlindInvisible()

	return
end

function BattleCharacter:UpdateBlindInvisible()
	self:GetTf():GetComponent(typeof(Renderer)).enabled = self._unitData:GetExposed()

	self:updateComponentVisible()

	return
end

function BattleCharacter:updateInvisible(arg_49_1, arg_49_2, arg_49_3)
	if arg_49_1 then
		self:SwitchShader(arg_49_2, arg_49_3)
		self._animator:ChangeRenderQueue(2999)
	else
		self:SwitchShader("COLORED_ALPHA")
		self._animator:ChangeRenderQueue(3000)
	end

	if self._waveFX then
		SetActive(self._waveFX.transform, not arg_49_1)
	end

	return
end

function BattleCharacter:onDetected(arg_50_1)
	if not self._go then
		return
	end

	if self._unitData:GetDiveDetected() and self._unitData:GetIFF() == var_0_4.FOE_CODE then
		self._shockFX = self:AddFX("shock", true, true)
	else
		self:RemoveCacheFX("shock")
	end

	if self._unitData:GetIFF() == var_0_4.FOE_CODE then
		self:UpdateCharacterDetected()
	end

	self:updateComponentVisible()

	return
end

function BattleCharacter:UpdateCharacterDetected()
	if self._unitData:GetIFF() == var_0_4.FRIENDLY_CODE or self._unitData:GetDiveDetected() then
		self:spineSemiTransparentFade(0, 0.7, var_0_4.SUB_FADE_IN_DURATION)
	else
		self:spineSemiTransparentFade(0.7, 0, var_0_4.SUB_FADE_OUT_DURATION)
	end

	return
end

function BattleCharacter:onForceDetected(arg_52_1)
	self:UpdateCharacterForceDetected()

	return
end

function BattleCharacter:UpdateCharacterForceDetected()
	if self._unitData:GetIFF() == var_0_4.FOE_CODE and self._unitData:GetForceExpose() then
		self:spineSemiTransparentFade(0, 0.7, var_0_4.SUB_FADE_IN_DURATION)
		self:updateComponentVisible()
	end

	return
end

function BattleCharacter:onBlindExposed(arg_54_1)
	self:GetTf():GetComponent(typeof(Renderer)).enabled = self._unitData:GetExposed()

	self:updateComponentVisible()

	return
end

function BattleCharacter:updateComponentVisible()
	local var_55_0 = self._unitData:GetIFF() ~= var_0_4.FOE_CODE and self._unitData:GetAttrByName(var_0_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY) > var_0_4.FUSION_ELEMENT_UNIT_TYPE or self._unitData:GetForceExpose() or self._unitData:GetExposed() and (not self._unitData:GetDiveInvisible() or not not self._unitData:GetDiveDetected())

	SetActive(self._arrowBarTf, var_55_0)
	SetActive(self._HPBarTf, var_55_0)
	SetActive(self._FXAttachPoint, var_55_0)
	SetActive(self._hpPopContainerTF, var_55_0)

	if self._hpCloakBar then
		self._hpCloakBar:SetActive(var_55_0)
	end

	if self._cloakBar then
		self._cloakBar:SetActive(var_55_0)
	end

	if self._aimBiarBar then
		self._aimBiarBar:SetActive(var_55_0)
	end

	if self._shieldBar then
		self._shieldBar:SetActive(var_55_0)
	end

	return
end

function BattleCharacter:updateComponentDiveInvisible()
	local var_56_2 = not not (self._unitData:GetDiveDetected() and self._unitData:GetIFF() == var_0_4.FOE_CODE or not self._unitData:GetDiveInvisible())

	SetActive(self._arrowBarTf, (self._unitData:GetDiveDetected() and self._unitData:GetIFF() == var_0_4.FOE_CODE or not self._unitData:GetDiveInvisible()) and true or false)
	SetActive(self._HPBarTf, var_56_2)
	SetActive(self._FXAttachPoint, var_56_2)

	return
end

function BattleCharacter:updateComponentBlindInvisible()
	local var_57_0 = self._unitData:GetExposed()

	self:GetTf():GetComponent(typeof(Renderer)).enabled = var_57_0

	SetActive(self._arrowBarTf, var_57_0)
	SetActive(self._HPBarTf, var_57_0)
	SetActive(self._FXAttachPoint, var_57_0)

	return
end

function BattleCharacter:spineSemiTransparentFade(arg_58_1, arg_58_2, arg_58_3)
	LeanTween.cancel(self._go)
	onDelayTick(function()
		if not self._go then
			return
		end

		arg_58_3 = arg_58_3 or 0

		SpineAnim.ShaderTransparentFade(self._go, arg_58_2, arg_58_1, arg_58_3, "_Invisible")

		return
	end, 0.06)

	return
end

function BattleCharacter:onInitVigilantState(arg_60_1)
	self._factory:MakeVigilantBar(self)

	range = arg_60_1.Data.sonarRange * 0.5

	local var_60_0 = self:AddFX("AntiSubArea", true).transform

	var_60_0.localScale = Vector3(range, 0, range)

	self._unitData:RegisterEventListener(self, var_0_1.CHANGE_ANTI_SUB_VIGILANCE, self.onVigilantStateChange)
	self._unitData:RegisterEventListener(self, var_0_1.ANTI_SUB_VIGILANCE_SONAR_CHECK, function()
		local var_61_0 = var_60_0:Find("Quad"):GetComponent(typeof(Animator))

		var_61_0.enabled = true

		var_61_0:Play("antiSubZoom", -1, 0)

		return
	end)

	return
end

function BattleCharacter:onVigilantStateChange(arg_62_1)
	self:updateVigilantMark()

	return
end

function BattleCharacter:updateVigilantMark()
	if self._vigilantBar then
		self._vigilantBar:UpdateVigilantMark()
	end

	return
end

function BattleCharacter:OnActionChange(arg_64_1)
	self:PlayAction(arg_64_1.Data.actionType)

	return
end

function BattleCharacter:PlayAction(arg_65_1)
	local var_65_0 = arg_65_1
	local var_65_1 = false

	if self._skeleton then
		var_65_0, var_65_1 = SpineAnimUtil.GetCharAnimDirect(self._skeleton, math.sign(self._modelScale.x), var_65_0)
	end

	if var_65_1 then
		self:setLocalScale(Vector3(math.abs(self._modelScale.x), self._modelScale.y, self._modelScale.z), true)
	end

	self._animator:SetAction(var_65_0, 0, var_0_3.ActionLoop[arg_65_1])

	self._actionIndex = arg_65_1

	if arg_65_1 == var_0_3.ActionName.VICTORY or arg_65_1 == var_0_3.ActionName.VICTORY_SWIM then
		self._effectOb:ClearEffect()
	end

	if #self._orbitActionUpdateList > 0 then
		for iter_65_0, iter_65_1 in ipairs(self._orbitActionUpdateList) do
			local var_65_2 = false

			for iter_65_2, iter_65_3 in ipairs(iter_65_1.change.condition.param) do
				if string.find(arg_65_1, iter_65_3) then
					var_65_2 = true

					break
				end
			end

			if var_65_2 then
				self:changeOrbitAction(iter_65_1.orbit, iter_65_1.change)

				break
			end
		end
	end

	return
end

function BattleCharacter:SetAnimaSpeed(arg_66_1)
	self._skeleton = self._skeleton or self:GetTf():GetComponent("SkeletonAnimation")
	arg_66_1 = arg_66_1 or 1
	self._skeleton.timeScale = arg_66_1

	return
end

function BattleCharacter:UpdatePosition()
	if not self._go then
		return
	end

	local var_67_0 = self._unitData:GetPosition()

	if self._unitData:GetSpeed() == Vector3.zero and self._characterPos == var_67_0 then
		return
	end

	self._characterPos = var_67_0
	self._tf.localPosition = self:getCharacterPos()

	return
end

function BattleCharacter:getCharacterPos()
	return self._characterPos
end

function BattleCharacter:UpdateMatrix()
	self._bonePosTable = nil
	self._posMatrix = nil

	return
end

function BattleCharacter:UpdateUIComponentPosition()
	local var_70_0 = self._unitData:GetPosition()

	self._referenceVector:Set(var_70_0.x, var_70_0.y, var_70_0.z)
	var_0_0.Battle.BattleVariable.CameraPosToUICameraByRef(self._referenceVector)

	self._referenceVector.z = 10
	self._referenceUpdateFlag = not self._referenceVector:Equals(self._referenceVectorCache)

	if self._referenceUpdateFlag then
		self._referenceVectorCache:Copy(self._referenceVector)
	end

	return
end

function BattleCharacter:UpdateHPPopContainerPosition()
	self._hpPopContainerTF.position = self._referenceVector

	return
end

function BattleCharacter:UpdateHPBarPosition()
	if not self._hideHP then
		self._hpBarPos:Copy(self._referenceVector):Add(self._hpBarOffset)

		self._HPBarTf.position = self._hpBarPos
	end

	return
end

function BattleCharacter:SetBarHidden(arg_73_1, arg_73_2)
	self._alwaysHideArrow = arg_73_1
	self._hideHP = arg_73_2

	if self._arrowBar then
		if self._alwaysHideArrow then
			self._arrowBarTf.anchoredPosition = var_0_8
		else
			self._arrowBarTf.position = self._arrowVector
		end
	end

	return
end

function BattleCharacter:UpdateCastClockPosition()
	self._castClock:UpdateCastClockPosition(self._referenceVector)

	return
end

function BattleCharacter:UpdateBarrierClockPosition()
	self._barrierClock:UpdateBarrierClockPosition(self._referenceVector)

	return
end

function BattleCharacter:SetArrowPoint()
	self._arrowVector:Set()

	self._cameraUtil = var_0_0.Battle.BattleCameraUtil.GetInstance()
	self._arrowCenterPos = self._cameraUtil:GetArrowCenterPos()

	return
end

local var_0_10 = Vector3(-1, 1, 1)
local var_0_11 = Vector3(1, 1, 1)

function BattleCharacter:UpdateArrowBarPosition()
	local var_77_0 = self._cameraUtil:GetCharacterArrowBarPosition(self._referenceVector, self._arrowVector)

	if not var_77_0 then
		if not self._inViewArea then
			self._inViewArea = true
			self._arrowBarTf.anchoredPosition = var_0_8
		end
	else
		local var_77_1 = self._unitData:GetBornPosition()

		if var_77_1 and var_77_1 ~= self._unitData:GetPosition() then
			var_77_0 = self._cameraUtil:GetCharacterArrowBarPosition(self._referenceVectorBorn, self._arrowVector)
		end

		self._arrowVector = var_77_0
		self._inViewArea = false

		if not self._alwaysHideArrow then
			self._arrowBarTf.position = self._arrowVector
			self._arrowBarTf.localScale = self._arrowVector.x > 0 and var_0_10 or var_0_11
		end
	end

	return
end

function BattleCharacter:UpdateArrowBarRotation()
	if self._inViewArea then
		return
	end

	self._arrowAngleVector.z = math.rad2Deg * math.atan2(self._arrowVector.y - self._arrowCenterPos.y, self._arrowVector.x - self._arrowCenterPos.x)
	self._arrowBarTf.eulerAngles = self._arrowAngleVector

	return
end

function BattleCharacter:UpdateChatPosition()
	if not self._popGO then
		return
	end

	self._popTF.position = self._inViewArea and self:GetReferenceVector() or self._arrowVector + var_0_9

	return
end

function BattleCharacter:Dispose()
	if self._popGO then
		LeanTween.cancel(self._popGO)
	end

	if self._popNumBundle then
		self._hpPopContainerTF = nil

		self._popNumBundle:Clear()

		self._popNumBundle = nil
	end

	self._popNumPool = nil

	Object.Destroy(self._popGO)

	if self._voicePlaybackInfo then
		self._voicePlaybackInfo:PlaybackStop()
	end

	if self._cloakBar then
		self._cloakBar:Dispose()

		self._cloakBar = nil
		self._cloakBarTf = nil
	end

	if self._aimBiarBar then
		self._aimBiarBar:Dispose()

		self._aimBiarBar = nil
	end

	if self._shieldBar then
		self._shieldBar:Dispose()

		self._shieldBar = nil
	end

	if self._buffClock then
		self._buffClock:Dispose()

		self._buffClock = nil
	end

	self._voicePlaybackInfo = nil
	self._popGO = nil
	self._popTF = nil
	self._cacheWeapon = nil

	for iter_80_0, iter_80_1 in pairs(self._allFX) do
		var_0_5.GetInstance():DestroyOb(iter_80_0)
	end

	for iter_80_2, iter_80_3 in pairs(self._orbitList) do
		var_0_5.GetInstance():DestroyOb(iter_80_2)
	end

	self._orbitList = nil
	self._orbitActionCacheList = nil
	self._orbitSpeedUpdateList = nil
	self._orbitActionUpdateList = nil

	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._voiceTimer)

	self._voiceTimer = nil

	self._effectOb:RemoveUnitEvent(self._unitData)
	self._effectOb:Dispose()

	self._HPProgressBar = nil
	self._HPProgress = nil

	self._factory:GetHPBarPool():DestroyObj(self._HPBar)

	self._HPBar = nil
	self._HPBarTf = nil
	self._arrowBar = nil
	self._arrowBarTf = nil

	if self._animator then
		self._animator:ClearOverrideMaterial()

		self._animator = nil
	end

	self._skeleton = nil
	self._posMatrix = nil
	self._shockFX = nil
	self._waveFX = nil

	self:RemoveUnitEvent()
	var_0_0.EventListener.DetachEventListener(self)

	self._bulletFactoryList = nil

	for iter_80_4, iter_80_5 in pairs(self._tagFXList) do
		iter_80_5:Dispose()
	end

	self._tagFXList = nil
	self._weaponRegisterList = nil

	BattleCharacter.super.Dispose(self)

	return
end

function BattleCharacter:AddModel(arg_81_1)
	self:SetGO(arg_81_1)

	self._hpBarOffset = Vector3(0, self._unitData:GetBoxSize().y, 0)
	self._animator = self:GetTf():GetComponent(typeof(SpineAnim))
	self._skeleton = self:GetTf():GetComponent("SkeletonAnimation")

	if self._animator then
		self._animator:Start()
	end

	self:SetBoneList()
	self:UpdateMatrix()
	self._unitData:ActiveCldBox()

	local var_81_0 = self:GetInitScale()

	self:setLocalScale(Vector3(var_81_0 * self._unitData:GetDirection(), var_81_0, var_81_0))

	local var_81_1 = self._unitData:GetOxyState()

	if var_81_1 and var_81_1:GetCurrentDiveState() == var_0_0.Battle.BattleConst.OXY_STATE.DIVE then
		self:PlayAction(var_0_0.Battle.BattleConst.ActionName.DIVE)
	else
		self:PlayAction(var_0_0.Battle.BattleConst.ActionName.MOVE)
	end

	self._animator:SetActionCallBack(function(arg_82_0)
		if arg_82_0 == "finish" then
			self:OnAnimatorEnd()
		elseif arg_82_0 == "action" then
			self:OnAnimatorTrigger()
		else
			self:changeOrbitListVisible(arg_82_0)
		end

		return
	end)
	self._unitData:RegisterEventListener(self, var_0_1.CHANGE_ACTION, self.OnActionChange)

	return
end

function BattleCharacter:changeOrbitListVisible(arg_83_1)
	local var_83_0

	if arg_83_1 == "skin_on" then
		var_83_0 = true
	elseif arg_83_1 == "skin_off" then
		var_83_0 = false
	else
		return
	end

	if self._orbitList then
		for iter_83_0, iter_83_1 in pairs(self._orbitList) do
			SetActive(iter_83_0, var_83_0)
		end
	end

	return
end

function BattleCharacter:SwitchModel(arg_84_1, arg_84_2)
	self:SetGO(arg_84_1)

	self._animator = self:GetTf():GetComponent(typeof(SpineAnim))
	self._skeleton = self:GetTf():GetComponent("SkeletonAnimation")

	if self._animator then
		self._animator:Start()
	end

	self:SetBoneList()

	self._tf.position = self._unitData:GetPosition()

	self:UpdateMatrix()

	self._hpBarOffset.y = self._hpBarOffset.y + self._coverSpineHPBarOffset

	self:UpdateHPBarPosition()

	local var_84_0 = self:GetInitScale()

	self:setLocalScale(Vector3(var_84_0 * self._unitData:GetDirection(), var_84_0, var_84_0))
	self._animator:SetActionCallBack(function(arg_85_0)
		if arg_85_0 == "finish" then
			self:OnAnimatorEnd()
		elseif arg_85_0 == "action" then
			self:OnAnimatorTrigger()
		else
			self:changeAttachLListVisible(arg_85_0)
		end

		return
	end)
	self:SwitchShader(self._shaderType, self._color)

	local var_84_1 = {}
	local var_84_2 = {}

	for iter_84_0, iter_84_1 in pairs(self._blinkDict) do
		local var_84_3 = SpineAnim.CharBlink(self._go, iter_84_1.r, iter_84_1.g, iter_84_1.b, iter_84_1.a, iter_84_1.peroid, iter_84_1.duration, false)

		var_84_1[var_84_3] = iter_84_1
		var_84_2[iter_84_0] = var_84_3
	end

	self._blinkDict = var_84_1

	self:PlayAction(self._actionIndex)

	if not arg_84_2 then
		for iter_84_2, iter_84_3 in pairs(self._orbitList) do
			SpineAnim.AddFollower(iter_84_3.boundBone, self._tf, iter_84_2.transform):GetComponent("Spine.Unity.BoneFollower").followBoneRotation = false
		end
	end

	self._effectOb:SwitchOwner(self, var_84_2)
	self._FXAttachPoint.transform:SetParent(self:GetTf(), false)
	var_0_5.GetInstance():DestroyOb(self._go)

	return
end

function BattleCharacter:AddOrbit(arg_86_1, arg_86_2, arg_86_3)
	local var_86_0 = arg_86_2.orbit_combat_bound[1]
	local var_86_1

	if arg_86_3 then
		var_86_0 = arg_86_3 .. "_" .. var_86_0
		var_86_1 = arg_86_2.orbit_hidden_action
	end

	arg_86_1.transform.localPosition = Vector3(arg_86_2.orbit_combat_bound[2][1], arg_86_2.orbit_combat_bound[2][2], arg_86_2.orbit_combat_bound[2][3])

	local var_86_2 = SpineAnim.AddFollower(var_86_0, self._tf, arg_86_1.transform):GetComponent("Spine.Unity.BoneFollower")

	if arg_86_2.orbit_rotate then
		var_86_2.followBoneRotation = true
		arg_86_1.transform.localEulerAngles = Vector3(arg_86_1.transform.localEulerAngles.x, arg_86_1.transform.localEulerAngles.y, arg_86_1.transform.localEulerAngles.z - 90)
	else
		var_86_2.followBoneRotation = false
	end

	self._orbitList[arg_86_1] = {
		hiddenAction = var_86_1,
		boundBone = var_86_0,
		offset = self._orbitSpineOrderOffset
	}

	if arg_86_2.orbit_combat_anima_change.default then
		self:changeOrbitAction(arg_86_1, arg_86_2.orbit_combat_anima_change.default)

		for iter_86_0, iter_86_1 in ipairs(arg_86_2.orbit_combat_anima_change.change) do
			if iter_86_1.condition.type == 1 then
				table.insert(self._orbitSpeedUpdateList, {
					orbit = arg_86_1,
					change = Clone(iter_86_1)
				})
			elseif iter_86_1.condition.type == 2 then
				table.insert(self._orbitActionUpdateList, {
					orbit = arg_86_1,
					change = Clone(iter_86_1)
				})
			end
		end
	end

	self._orbitSpineOrderOffset = self._orbitSpineOrderOffset + BattleCharacter.getMaxZSort(arg_86_1)

	self:sortOrbitZOrder()

	return
end

function BattleCharacter:sortOrbitZOrder()
	for iter_87_0, iter_87_1 in pairs(self._orbitList) do
		local var_87_0 = BattleCharacter.getMaxZSort(iter_87_0)

		eachChild(iter_87_0, function(arg_88_0)
			if arg_88_0 and arg_88_0:GetComponent("MeshRenderer") then
				local var_88_0 = arg_88_0:GetComponent("MeshRenderer").sortingOrder

				if var_88_0 > 0 then
					arg_88_0:GetComponent("MeshRenderer").sortingOrder = self._orbitSpineOrderOffset - iter_87_1.offset - var_87_0 + var_88_0
				end
			end

			return
		end)
	end

	return
end

function BattleCharacter:getMaxZSort()
	local var_89_0 = 0

	eachChild(self, function(arg_90_0)
		if arg_90_0 and arg_90_0:GetComponent("MeshRenderer") then
			var_89_0 = math.max(var_89_0, arg_90_0:GetComponent("MeshRenderer").sortingOrder)
		end

		return
	end)

	return 0
end

function BattleCharacter:changeOrbitAction(arg_91_1, arg_91_2)
	for iter_91_0, iter_91_1 in ipairs(arg_91_2) do
		local var_91_0 = arg_91_1.transform:Find(iter_91_1.node)

		if var_91_0 then
			SetActive(var_91_0, iter_91_1.active)

			if iter_91_1.active and self._orbitActionCacheList[var_91_0] ~= iter_91_1.activate then
				var_91_0:GetComponent(typeof(Animator)):SetBool("activate", iter_91_1.activate)

				self._orbitActionCacheList[var_91_0] = iter_91_1.activate
			end
		end
	end

	return
end

function BattleCharacter:UpdateOrbit()
	if #self._orbitSpeedUpdateList <= 0 then
		return
	end

	local var_92_0 = self._unitData:GetSpeed():Magnitude()

	for iter_92_0, iter_92_1 in pairs(self._orbitSpeedUpdateList) do
		local var_92_1 = true

		for iter_92_2, iter_92_3 in ipairs(iter_92_1.change.condition.param) do
			var_92_1 = var_0_6.simpleCompare(iter_92_3, var_92_0) and var_92_1
		end

		if var_92_1 then
			self:changeOrbitAction(iter_92_1.orbit, iter_92_1.change)
		end
	end

	return
end

function BattleCharacter:AddSmokeFXs(arg_93_1)
	self._smokeList = arg_93_1

	self:updateSomkeFX()

	return
end

function BattleCharacter:AddShadow(arg_94_1)
	self._shadow = arg_94_1

	return
end

function BattleCharacter:AddHPBar(arg_95_1)
	self._HPBar = arg_95_1
	self._HPBarTf = arg_95_1.transform
	self._HPProgressBar = self._HPBarTf:Find("blood")
	self._HPProgress = self._HPProgressBar:GetComponent(typeof(Image))

	self._unitData:RegisterEventListener(self, var_0_1.UPDATE_HP, self.OnUpdateHP)

	self._HPBarTf.position = self._referenceVector + self._hpBarOffset

	return
end

function BattleCharacter:AddUIComponentContainer(arg_96_1)
	self:UpdateUIComponentPosition()

	return
end

function BattleCharacter:AddPopNumPool(arg_97_1)
	self._popNumPool = arg_97_1
	self._hpPopIndex_put = 1
	self._hpPopIndex_get = 1
	self._hpPopCount = 0
	self._hpPopCatch = {}
	self._popNumBundle = self._popNumPool:GetBundle(self._unitData:GetUnitType())
	self._hpPopContainerTF = self._popNumBundle:GetContainer().transform

	return
end

function BattleCharacter:AddArrowBar(arg_98_1)
	self._arrowBar = arg_98_1
	self._arrowBarTf = arg_98_1.transform

	self:SetArrowPoint()

	return
end

function BattleCharacter:AddCastClock(arg_99_1)
	SetActive(arg_99_1.transform, false)

	self._castClock = var_0_0.Battle.BattleCastBar.New(arg_99_1.transform)

	self:UpdateCastClockPosition()

	return
end

function BattleCharacter:AddBuffClock(arg_100_1)
	SetActive(arg_100_1.transform, false)

	self._buffClock = var_0_0.Battle.BattleBuffClock.New(arg_100_1.transform)

	return
end

function BattleCharacter:AddBarrierClock(arg_101_1)
	SetActive(arg_101_1.transform, false)

	self._barrierClock = var_0_0.Battle.BattleBarrierBar.New(arg_101_1.transform)

	self:UpdateBarrierClockPosition()

	return
end

function BattleCharacter:AddVigilantBar(arg_102_1)
	self._vigilantBar = var_0_0.Battle.BattleVigilantBar.New(arg_102_1.transform)

	self._vigilantBar:ConfigVigilant(self._unitData:GetAntiSubState())
	self._vigilantBar:UpdateVigilantProgress()
	self:updateVigilantMark()

	return
end

function BattleCharacter:UpdateVigilantBarPosition()
	self._vigilantBar:UpdateVigilantBarPosition(self._hpBarPos)

	return
end

function BattleCharacter:AddCloakBar(arg_104_1)
	self._cloakBarTf = arg_104_1.transform
	self._cloakBar = var_0_0.Battle.BattleCloakBar.New(self._cloakBarTf)

	self._cloakBar:ConfigCloak(self._unitData:GetCloak())
	self._cloakBar:UpdateCloakProgress()

	return
end

function BattleCharacter:UpdateCloakBarPosition(arg_105_1)
	if self._inViewArea then
		self._cloakBarTf.anchoredPosition = var_0_8
	else
		self._cloakBar:UpdateCloarBarPosition(self._arrowVector)
	end

	return
end

function BattleCharacter:onInitCloak(arg_106_1)
	self._factory:MakeCloakBar(self)

	return
end

function BattleCharacter:onUpdateCloakConfig(arg_107_1)
	self._cloakBar:UpdateCloakConfig()

	return
end

function BattleCharacter:onUpdateCloakLock(arg_108_1)
	self._cloakBar:UpdateCloakLock()

	return
end

function BattleCharacter:IsDoubleChar()
	if self._skeleton then
		if self._skeleton.skeleton:FindBoneIndex("char1_face") >= 0 and self._skeleton.skeleton:FindBoneIndex("char2_face") >= 0 then
			return true
		end
	end

	return false
end

function BattleCharacter:AddAimBiasBar(arg_110_1)
	self._aimBiarBarTF = arg_110_1
	self._aimBiarBar = var_0_0.Battle.BattleAimbiasBar.New(arg_110_1)

	self._aimBiarBar:ConfigAimBias(self._unitData:GetAimBias())
	self._aimBiarBar:UpdateAimBiasProgress()

	return
end

function BattleCharacter:UpdateAimBiasBar()
	if self._aimBiarBar then
		self._aimBiarBar:UpdateAimBiasProgress()
	end

	return
end

function BattleCharacter:AddShieldBar(arg_112_1)
	self._shieldBarTF = arg_112_1
	self._shieldBar = var_0_0.Battle.BattleRecoilShieldBar.New(self._shieldBarTF)

	self:configShieldBuffBar()
	self._shieldBar:UpdateRecoilShieldProgress()

	return
end

function BattleCharacter:UpdateShieldBar()
	if self._shieldBar then
		self._shieldBar:UpdateRecoilShieldProgress()
	end

	return
end

function BattleCharacter:onRecoilShield(arg_114_1)
	if not self._shieldBar then
		self._factory:MakeShieldBar(self)
	else
		self:configShieldBuffBar()
	end

	return
end

function BattleCharacter:configShieldBuffBar()
	local var_115_0

	for iter_115_0, iter_115_1 in pairs((self._unitData:GetBuffList())) do
		for iter_115_2, iter_115_3 in ipairs((iter_115_1:GetEffectList())) do
			if iter_115_3.__name == var_0_0.Battle.BattleBuffRecoilShield.__name then
				var_115_0 = iter_115_3

				break
			end
		end
	end

	self._shieldBar:ConfigShieldBuff(var_115_0)

	return
end

function BattleCharacter:UpdateBuffClock()
	if self._buffClock and self._buffClock:IsActive() then
		self._buffClock:UpdateCastClockPosition(self._referenceVector)
		self._buffClock:UpdateCastClock()
	end

	return
end

function BattleCharacter:onUpdateAimBiasLock(arg_117_1)
	self._aimBiarBar:UpdateLockStateView()

	return
end

function BattleCharacter:onInitAimBias(arg_118_1)
	if self._unitData:GetAimBias():GetHost() == self._unitData then
		self._factory:MakeAimBiasBar(self)
	end

	return
end

function BattleCharacter:onHostAimBias(arg_119_1)
	self._factory:MakeAimBiasBar(self)

	return
end

function BattleCharacter:onRemoveAimBias(arg_120_1)
	self._aimBiarBar:SetActive(false)
	self._aimBiarBar:Dispose()

	self._aimBiarBar = nil
	self._aimBiarBarTF = nil

	return
end

function BattleCharacter:AddAimBiasFogFX()
	local var_121_0 = self._unitData:GetTemplate().fog_fx

	if var_121_0 and var_121_0 ~= "" then
		self._fogFx = self:AddFX(var_121_0)
	end

	return
end

function BattleCharacter:OnUpdateHP(arg_122_1)
	self:_DealHPPop(arg_122_1.Data)

	return
end

function BattleCharacter:_DealHPPop(arg_123_1)
	if self._hpPopIndex_put == self._hpPopIndex_get and self._hpPopCount == 0 then
		self:_PlayHPPop(arg_123_1)

		self._hpPopCount = 1
	elseif self._unitData:IsAlive() then
		self._hpPopCatch[self._hpPopIndex_put] = arg_123_1
		self._hpPopIndex_put = self._hpPopIndex_put + 1
	else
		self:_PlayHPPop(arg_123_1)
	end

	return
end

function BattleCharacter:UpdateHPPop()
	if self._hpPopIndex_put == self._hpPopIndex_get then
		return
	else
		self._hpPopCount = self._hpPopCount + 1

		if self:_CalcHPPopCount() <= self._hpPopCount then
			self:_PlayHPPop(self._hpPopCatch[self._hpPopIndex_get])

			self._hpPopCatch[self._hpPopIndex_get] = nil
			self._hpPopIndex_get = self._hpPopIndex_get + 1
			self._hpPopCount = 0
		end
	end

	return
end

function BattleCharacter:_PlayHPPop(arg_125_1)
	if self._popNumBundle:IsScorePop() then
		return
	end

	local var_125_0 = arg_125_1.posOffset or Vector3.zero
	local var_125_1 = self._popNumBundle:GetPop(arg_125_1.isHeal, arg_125_1.isCri, arg_125_1.isMiss, arg_125_1.dHP, arg_125_1.font)

	var_125_1:SetReferenceCharacter(self, var_125_0)
	var_125_1:Play()

	return
end

function BattleCharacter:_CalcHPPopCount()
	if self._hpPopIndex_put - self._hpPopIndex_get > 5 then
		return 1
	else
		return 5
	end

	return
end

function BattleCharacter:onUpdateScore(arg_127_1)
	local var_127_0 = self._popNumBundle:GetScorePop(arg_127_1.Data.score)

	var_127_0:SetReferenceCharacter(self, Vector3.zero)
	var_127_0:Play()

	return
end

function BattleCharacter:UpdateHpBar()
	local var_128_0 = self._unitData:GetCurrentHP()

	if self._HPProgress and self._cacheHP ~= var_128_0 then
		self._HPProgress.fillAmount = self._unitData:GetHPRate()
		self._cacheHP = var_128_0
	end

	return
end

function BattleCharacter:onChangeSize(arg_129_1)
	self:doChangeSize(arg_129_1)

	return
end

function BattleCharacter:updateSomkeFX()
	local var_130_0 = self._unitData:GetHPRate()

	for iter_130_0, iter_130_1 in ipairs(self._smokeList) do
		if var_130_0 < iter_130_1.rate then
			if iter_130_1.active == false then
				iter_130_1.active = true

				for iter_130_2, iter_130_3 in pairs(iter_130_1.smokes) do
					if iter_130_2.unInitialize then
						local var_130_1 = self:AddFX(iter_130_2.resID)

						var_130_1.transform.localPosition = iter_130_2.pos
						iter_130_1.smokes[iter_130_2] = var_130_1

						SetActive(var_130_1, true)

						iter_130_2.unInitialize = false
					else
						SetActive(iter_130_3, true)
					end
				end
			end
		elseif iter_130_1.active == true then
			iter_130_1.active = false

			for iter_130_4, iter_130_5 in pairs(iter_130_1.smokes) do
				if iter_130_4.unInitialize then
					-- block empty
				else
					SetActive(iter_130_5, false)
				end
			end
		end
	end

	return
end

function BattleCharacter:doChangeSize(arg_131_1)
	local var_131_0 = self._unitData:GetAttrByName("modelScale")

	self:setLocalScale(Vector3(var_131_0 * self._unitData:GetDirection(), var_131_0, var_131_0))

	return
end

function BattleCharacter:InitEffectView()
	self._effectOb = var_0_0.Battle.BattleEffectComponent.New(self)

	return
end

function BattleCharacter:UpdateAniEffect(arg_133_1)
	self._effectOb:Update(arg_133_1)

	return
end

function BattleCharacter:UpdateTagEffect(arg_134_1)
	local var_134_0 = self._unitData:GetBoxSize().y * 0.5

	for iter_134_0, iter_134_1 in pairs(self._tagFXList) do
		iter_134_1:Update(arg_134_1)
		iter_134_1:SetPosition(self._referenceVector + Vector3(0, var_134_0, 0))
	end

	return
end

function BattleCharacter:SetPopup(arg_135_1, arg_135_2, arg_135_3)
	if self._voiceTimer then
		if self._voiceKey == arg_135_3 then
			self._voiceKey = nil
		else
			return
		end
	end

	if self._popGO then
		LeanTween.cancel(self._popGO)

		local var_135_0 = self._popGO.transform:GetComponent(typeof(Animation))

		if var_135_0 then
			var_135_0:Play("popup_out")
			self._popGO:GetComponent("DftAniEvent"):SetEndEvent(function(arg_136_0)
				self.ChatPopAnimation(self._popGO, arg_135_2)

				return
			end)
		else
			LeanTween.cancel(self._popGO)
			LeanTween.scale(rtf(self._popGO.gameObject), Vector3.New(0, 0, 1), 0.1):setEase(LeanTweenType.easeInBack):setOnComplete(System.Action(function()
				self.ChatPop(self._popGO, arg_135_2)

				return
			end))
		end
	else
		self._popGO = self._factory:MakePopup()
		self._popTF = self._popGO.transform

		if self._popGO.transform:GetComponent(typeof(Animation)) then
			self.ChatPopAnimation(self._popGO, arg_135_2)
		else
			self._popTF.localScale = Vector3(0, 0, 0)

			self.ChatPop(self._popGO, arg_135_2)
		end
	end

	BattleCharacter.setChatText(self._popGO, arg_135_1)
	SetActive(self._popGO, true)

	return
end

function BattleCharacter:ChatPopAnimation(arg_138_1)
	local var_138_0 = self.transform:GetComponent(typeof(Animation))

	var_138_0:Play("popup_in")
	LeanTween.delayedCall(self.gameObject, arg_138_1, System.Action(function()
		var_138_0:Play("popup_out")
		self:GetComponent("DftAniEvent"):SetEndEvent(function(arg_140_0)
			SetActive(self, false)

			return
		end)

		return
	end))

	return
end

function BattleCharacter:ChatPop(arg_141_1)
	arg_141_1 = arg_141_1 or 2.5

	LeanTween.scale(rtf(self.gameObject), Vector3.New(1, 1, 1), 0.3):setEase(LeanTweenType.easeOutBack):setOnComplete(System.Action(function()
		LeanTween.scale(rtf(self.gameObject), Vector3.New(0, 0, 1), 0.3):setEase(LeanTweenType.easeInBack):setDelay(arg_141_1):setOnComplete(System.Action(function()
			SetActive(self, false)

			return
		end))

		return
	end))

	return
end

function BattleCharacter:setChatText(arg_144_1)
	local var_144_0 = findTF(self, "Text"):GetComponent(typeof(Text))

	var_144_0.text = arg_144_1
	var_144_0.alignment = #var_144_0.text > CHAT_POP_STR_LEN and TextAnchor.MiddleLeft or TextAnchor.MiddleCenter

	return
end

function BattleCharacter:Voice(arg_145_1, arg_145_2)
	if self._voiceTimer then
		return
	end

	pg.CriMgr.GetInstance():PlayMultipleSound_V3(arg_145_1, function(arg_146_0)
		if arg_146_0 then
			self._voiceKey = arg_145_2
			self._voicePlaybackInfo = arg_146_0
			self._voiceTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 0, self._voicePlaybackInfo:GetLength() * 0.001, function()
				pg.TimeMgr.GetInstance():RemoveBattleTimer(self._voiceTimer)

				self._voiceTimer = nil
				self._voiceKey = nil
				self._voicePlaybackInfo = nil

				return
			end)
		end

		return
	end)

	return
end

function BattleCharacter:setLocalScale(arg_148_1, arg_148_2)
	self._tf.localScale = arg_148_1

	if not arg_148_2 then
		self._modelScale = arg_148_1
	end

	return
end

function BattleCharacter:SonarAcitve(arg_149_1)
	return
end

function BattleCharacter:SwitchShader(arg_150_1, arg_150_2, arg_150_3)
	LeanTween.cancel(self._go)

	arg_150_2 = arg_150_2 or Color.New(0, 0, 0, 0)

	if arg_150_1 then
		self._animator:ShiftShader(var_0_5.GetInstance():GetShader(arg_150_1), arg_150_2)

		if arg_150_3 then
			self:spineSemiTransparentFade(0, arg_150_3.invisible, 0)
		end
	end

	self._shaderType = arg_150_1
	self._color = arg_150_2

	return
end

function BattleCharacter:PauseActionAnimation(arg_151_1)
	self._animator:GetAnimationState().TimeScale = arg_151_1 and 0 or 1

	return
end

function BattleCharacter:GetFactory()
	return self._factory
end

function BattleCharacter:SetFactory(arg_153_1)
	self._factory = arg_153_1

	return
end

function BattleCharacter:onSwitchSpine(arg_154_1)
	self._coverSpineHPBarOffset = arg_154_1.Data.HPBarOffset or 0

	self:SwitchSpine(arg_154_1.Data.skin)

	return
end

function BattleCharacter:SwitchSpine(arg_155_1)
	for iter_155_0, iter_155_1 in pairs(self._blinkDict) do
		SpineAnim.RemoveBlink(self._go, iter_155_0)
	end

	self._factory:SwitchCharacterSpine(self, arg_155_1)

	return
end

function BattleCharacter:onSwitchShader(arg_156_1)
	self:SwitchShader(arg_156_1.Data.shader, arg_156_1.Data.color, arg_156_1.Data.args)

	return
end

return
