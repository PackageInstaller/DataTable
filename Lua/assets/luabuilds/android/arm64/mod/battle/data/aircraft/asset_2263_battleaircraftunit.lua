ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_4 = ys.Battle.BattleVariable
local var_0_5 = ys.Battle.BattleDataFunction
local BattleAircraftUnit = class("BattleAircraftUnit")

ys.Battle.BattleAircraftUnit = BattleAircraftUnit
BattleAircraftUnit.__name = "BattleAircraftUnit"
BattleAircraftUnit.STATE_CREATE = "Create"
BattleAircraftUnit.STATE_ATTACK = "Attack"
BattleAircraftUnit.STATE_DESTORY = "Destory"
BattleAircraftUnit.HEIGHT = ys.Battle.BattleConfig.AircraftHeight + 5

function BattleAircraftUnit:Ctor(arg_1_1)
	var_0_0.EventDispatcher.AttachEventDispatcher(self)

	self._uniqueID = arg_1_1
	self._speedExemptKey = "air_" .. arg_1_1
	self._dir = var_0_0.Battle.BattleConst.UnitDir.RIGHT
	self._type = var_0_2.UnitType.AIRCRAFT_UNIT
	self._currentState = self.STATE_CREATE
	self._distanceBackup = {}
	self._battleProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	self._frame = 0
	self._weaponPotential = 1

	self:Init()

	return
end

function BattleAircraftUnit:SetBound(arg_2_1, arg_2_2)
	self._top = arg_2_1
	self._bottom = arg_2_2
	self._speedZ = self._tmpData.spawn_brownian == -1 and 0 or (math.random() - 0.5) * 0.5

	self:SetTargetZ()

	return
end

function BattleAircraftUnit:SetViewBoundData(arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	self._cameraTop = arg_3_1 + 3
	self._cameraBottom = arg_3_2 - 23
	self._cameraLeft = arg_3_3 - 3
	self._cameraRight = arg_3_4 + 10

	return
end

function BattleAircraftUnit:Update(arg_4_1)
	self._pos:Add(self._speed)
	self:UpdateSpeed()
	self:UpdateWeapon()

	return
end

function BattleAircraftUnit:ActiveCldBox()
	self._cldComponent:SetActive(true)

	return
end

function BattleAircraftUnit:DeactiveCldBox()
	self._cldComponent:SetActive(false)

	return
end

function BattleAircraftUnit:SetCldBoxImmune(arg_7_1)
	self._cldComponent:SetImmuneCLD(arg_7_1)

	return
end

function BattleAircraftUnit:Init()
	self._aliveState = true
	self._speed = Vector3.zero
	self._pos = Vector3.zero
	self._undefeated = false
	self._labelTagList = {}

	return
end

function BattleAircraftUnit:Clear()
	if self._createTimer then
		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._createTimer)

		self._createTimer = nil
	end

	self:ShutdownWeapon()

	self._distanceBackup = {}

	return
end

function BattleAircraftUnit:SetWeaponPreCastBound()
	return
end

function BattleAircraftUnit:EnterGCD()
	return
end

function BattleAircraftUnit:CreateWeapon()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(self._tmpData.weapon_ID) do
		var_12_0[iter_12_0] = var_0_0.Battle.BattleDataFunction.CreateAirFighterWeaponUnit(iter_12_1, self, iter_12_0, self._weaponPotential)
	end

	return var_12_0
end

function BattleAircraftUnit:ShutdownWeapon()
	for iter_13_0, iter_13_1 in ipairs(self:GetWeapon()) do
		iter_13_1:Clear()
	end

	return
end

function BattleAircraftUnit:UpdateWeapon()
	if self._currentState == self.STATE_ATTACK then
		for iter_14_0, iter_14_1 in ipairs(self:GetWeapon()) do
			iter_14_1:Update()
		end
	end

	return
end

function BattleAircraftUnit:SetStrikePoint(arg_15_1)
	self._strikePoint = arg_15_1

	self:SetPosition(Vector3(self._pos.x, self._pos.y, arg_15_1.z))

	return
end

function BattleAircraftUnit:GetStrikePoint()
	return self._strikePoint
end

function BattleAircraftUnit:GetWeapon()
	return self._weapon
end

function BattleAircraftUnit:GetCurrentHP()
	return self._currentHP
end

function BattleAircraftUnit:GetMaxHP()
	return var_0_0.Battle.BattleAttr.GetCurrent(self, "maxHP")
end

function BattleAircraftUnit:IsUndefeated()
	return self._undefeated
end

function BattleAircraftUnit:IsAlive()
	return self._aliveState
end

function BattleAircraftUnit:IsCease()
	return false
end

function BattleAircraftUnit:GetOxyState()
	return nil
end

function BattleAircraftUnit:IsBoss()
	return nil
end

function BattleAircraftUnit:HandleDamageToDeath()
	self:UpdateHP(-self._currentHP, {
		isMiss = false,
		isCri = false,
		isHeal = false
	})

	return
end

function BattleAircraftUnit:UpdateHP(arg_26_1, arg_26_2)
	self._currentHP = self._currentHP + arg_26_1

	local var_26_0 = self:GetMaxHP()

	if var_26_0 < self._currentHP then
		self._currentHP = var_26_0
	end

	if self._currentHP < 0 then
		self._currentHP = 0
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_AIR_CRAFT_HP, {
		dHP = arg_26_1,
		isMiss = arg_26_2.isMiss,
		isCri = arg_26_2.isCri,
		isHeal = arg_26_2.isHeal
	}))

	if self._currentHP <= 0 and self:IsAlive() then
		self:onDead()
	end

	return arg_26_1
end

function BattleAircraftUnit:onDead()
	self._currentState = self.STATE_DESTORY
	self._aliveState = false

	return
end

function BattleAircraftUnit:UpdateSpeed()
	local var_28_0 = self._velocity * self:GetSpeedRatio()

	self._speed:Copy(self._speedDir)
	self._speed:Mul(var_28_0)

	local var_28_1 = self:GetPosition()

	if var_28_1.y < BattleAircraftUnit.HEIGHT then
		self._speed.y = math.max(0.4, 1 - var_28_1.y / var_0_3.AircraftHeight)
	end

	self._speed.z = var_28_0 * self._speedZ

	if self._tmpData.spawn_brownian == 1 then
		if var_28_0 < self._targetZ - var_28_1.z then
			self._speed.z = var_28_0 * 0.5
		elseif self._targetZ - var_28_1.z < -var_28_0 then
			self._speed.z = -var_28_0 * 0.5
		else
			self:SetTargetZ()
		end
	end

	return
end

function BattleAircraftUnit:OutBound()
	self._undefeated = true

	self:onDead()

	return
end

function BattleAircraftUnit:GetSize()
	if self._currentState == self.STATE_CREATE then
		return Mathf.Clamp(self:GetPosition().y / BattleAircraftUnit.HEIGHT, 0.1, self._scale)
	else
		return self._scale
	end

	return
end

function BattleAircraftUnit:SetTemplate(arg_31_1)
	self._tmpData = arg_31_1

	self:InitCldComponent()
	var_0_0.Battle.BattleAttr.SetAircraftAttFromTemp(self)

	self._currentHP = self:GetMaxHP()
	self._weapon = self:CreateWeapon()
	self._modelID = arg_31_1.model_ID
	self._velocity = var_0_0.Battle.BattleFormulas.ConvertAircraftSpeed(arg_31_1.speed + self:GetAttrByName("aircraftBooster"))
	self._scale = arg_31_1.scale or 1

	return
end

function BattleAircraftUnit:SetWeanponPotential(arg_32_1)
	self._weaponPotential = arg_32_1

	return
end

function BattleAircraftUnit:SetTargetZ()
	self._targetZ = (self._bottom + self._top) * 0.5 + (self._top - self._bottom) * (math.random() - 0.5) * 0.6

	return
end

function BattleAircraftUnit:SetMotherUnit(arg_34_1)
	self._motherUnit = arg_34_1

	local var_34_0 = self._motherUnit:GetIFF()

	self:SetIFF(var_34_0)
	self:SetAttr(arg_34_1)

	local var_34_1 = self._motherUnit:GetWeaponBoundBone()

	if var_34_1.remote then
		local var_34_2 = Vector3(var_34_1.remote[1], var_34_1.remote[2], var_34_1.remote[3])

		var_34_2.x = var_34_2.x * var_34_0

		local var_34_3 = self._battleProxy:GetStageInfo().mainUnitPosition

		self:SetPosition((var_34_3 and var_34_3[var_34_0] and var_34_3[var_34_0][1] or var_0_3.MAIN_UNIT_POS[var_34_0][1]) + var_34_2)
	else
		self:SetPosition(self._motherUnit:GetPosition())
	end

	if arg_34_1:GetIFF() == var_0_3.FRIENDLY_CODE then
		self._dir = var_0_2.UnitDir.RIGHT
		self._isPlayerAircraft = true
	else
		self._dir = var_0_2.UnitDir.LEFT
	end

	return
end

function BattleAircraftUnit:GetLabelTag()
	return self._labelTagList
end

function BattleAircraftUnit:AddLabelTag(arg_36_1)
	table.insert(self._labelTagList, arg_36_1)

	local var_36_0 = self:GetAttrByName("labelTag")

	var_36_0[arg_36_1] = (var_36_0[arg_36_1] or 0) + 1

	return
end

function BattleAircraftUnit:ContainsLabelTag(arg_37_1)
	if self._labelTagList == nil then
		return false
	end

	for iter_37_0, iter_37_1 in ipairs(arg_37_1) do
		if table.contains(self._labelTagList, iter_37_1) then
			return true
		end
	end

	return false
end

function BattleAircraftUnit:SetIFF(arg_38_1)
	self._IFF = arg_38_1

	return
end

function BattleAircraftUnit:SetPosition(arg_39_1)
	self._pos:Set(arg_39_1.x, arg_39_1.y, arg_39_1.z)

	return
end

function BattleAircraftUnit:IsOutViewBound()
	local var_40_0 = self:GetPosition()

	if var_40_0.x > self._cameraRight or var_40_0.z > self._cameraTop or var_40_0.z < self._cameraBottom then
		return true
	end

	return
end

function BattleAircraftUnit:GetDistance(arg_41_1)
	if self._frame ~= self._battleProxy.FrameIndex then
		self._distanceBackup = {}
		self._frame = self._battleProxy.FrameIndex
	end

	local var_41_0 = self._distanceBackup[arg_41_1]

	if self._distanceBackup[arg_41_1] == nil then
		var_41_0 = Vector3.Distance(pg.Tool.FilterY(self:GetPosition()), pg.Tool.FilterY(arg_41_1:GetPosition()))
		self._distanceBackup[arg_41_1] = var_41_0

		arg_41_1:backupDistance(self, var_41_0)
	end

	return var_41_0
end

function BattleAircraftUnit:backupDistance(arg_42_1, arg_42_2)
	if self._frame ~= self._battleProxy.FrameIndex then
		self._distanceBackup = {}
		self._frame = self._battleProxy.FrameIndex
	end

	self._distanceBackup[arg_42_1] = arg_42_2

	return
end

function BattleAircraftUnit:GetSkinID()
	return self._modelID
end

function BattleAircraftUnit:SetSkinID(arg_44_1)
	self._skinID = arg_44_1
	self._modelID = var_0_5.GetEquipSkin(self._skinID)

	for iter_44_0, iter_44_1 in ipairs(self._weapon) do
		iter_44_1:SetDerivateSkin(arg_44_1)
	end

	return
end

function BattleAircraftUnit:SetSkinData(arg_45_1)
	return
end

function BattleAircraftUnit:SetAttr(arg_46_1)
	var_0_0.Battle.BattleAttr.SetAircraftAttFromMother(self, arg_46_1)

	return
end

function BattleAircraftUnit:GetAttr()
	return var_0_0.Battle.BattleAttr.GetAttr(self)
end

function BattleAircraftUnit:GetAttrByName(arg_48_1)
	return var_0_0.Battle.BattleAttr.GetCurrent(self, arg_48_1)
end

function BattleAircraftUnit:GetMotherUnit()
	return self._motherUnit
end

function BattleAircraftUnit:GetUniqueID()
	return self._uniqueID
end

function BattleAircraftUnit:GetIFF()
	return self._IFF
end

function BattleAircraftUnit:GetCurrentState()
	return self._currentState
end

function BattleAircraftUnit:GetVelocity()
	return self._velocity
end

function BattleAircraftUnit:GetSpeed()
	return self._speed
end

function BattleAircraftUnit:GetPosition()
	return self._pos
end

function BattleAircraftUnit:GetBornPosition()
	return nil
end

function BattleAircraftUnit:GetCLDZCenterPosition()
	return Vector3(self._pos.x, self._pos.y, self._pos.z + self:GetBoxSize().z)
end

function BattleAircraftUnit:GetBeenAimedPosition()
	local var_58_0 = self:GetTemplate().aim_offset
	local var_58_1 = self:GetCLDZCenterPosition()

	if not var_58_0 then
		return var_58_1
	end

	return Vector3(var_58_1.x + var_58_0[1], var_58_1.y + var_58_0[2], var_58_1.z + var_58_0[3])
end

function BattleAircraftUnit:GetDirection()
	return self._dir
end

function BattleAircraftUnit:GetTemplate()
	return self._tmpData
end

function BattleAircraftUnit:GetTemplateID()
	return self._tmpData.id
end

function BattleAircraftUnit:GetUnitType()
	return self._type
end

function BattleAircraftUnit:GetHPRate()
	return self._currentHP / self:GetMaxHP()
end

function BattleAircraftUnit:GetBoxSize()
	return self._cldComponent:GetCldBoxSize()
end

function BattleAircraftUnit:GetSpeedRatio()
	return var_0_4.GetSpeedRatio(self:GetSpeedExemptKey(), self._IFF)
end

function BattleAircraftUnit:GetSpeedExemptKey()
	return self._speedExemptKey
end

function BattleAircraftUnit:IsPlayerAircraft()
	return self._isPlayerAircraft
end

function BattleAircraftUnit:IsShowHPBar()
	return false
end

function BattleAircraftUnit:SetUnVisitable()
	var_0_0.Battle.BattleAttr.UnVisitable(self)

	return
end

function BattleAircraftUnit:SetVisitable()
	var_0_0.Battle.BattleAttr.Visitable(self)

	return
end

function BattleAircraftUnit:IsVisitable()
	return var_0_0.Battle.BattleAttr.IsVisitable(self)
end

function BattleAircraftUnit:OverrideDeadFX(arg_72_1)
	self._deadFX = arg_72_1

	return
end

function BattleAircraftUnit:GetDeadFX()
	return self._deadFX
end

BattleAircraftUnit.AIRCRAFT_TRIGGER = {
	ys.Battle.BattleConst.BuffEffectType.ON_BULLET_COLLIDE_BEFORE,
	ys.Battle.BattleConst.BuffEffectType.ON_BOMB_BULLET_BANG,
	ys.Battle.BattleConst.BuffEffectType.ON_TORPEDO_BULLET_BANG
}

function BattleAircraftUnit:TriggerBuff(arg_74_1, arg_74_2)
	if table.contains(BattleAircraftUnit.AIRCRAFT_TRIGGER, arg_74_1) and self._motherUnit and self._motherUnit:IsAlive() then
		self._motherUnit:TriggerBuff(arg_74_1, arg_74_2)
	end

	return
end

function BattleAircraftUnit:AddCreateTimer(arg_75_1, arg_75_2)
	self._currentState = self.STATE_CREATE
	self._speedDir = arg_75_1
	arg_75_2 = arg_75_2 or 1.5
	self._createTimer = pg.TimeMgr.GetInstance():AddBattleTimer("AddCreateTimer", 0, arg_75_2, function()
		self._currentState = self.STATE_ATTACK
		self._speedDir = Vector3(self._dir, 0, 0)

		pg.TimeMgr.GetInstance():RemoveBattleTimer(self._createTimer)

		self._createTimer = nil

		return
	end)

	return
end

function BattleAircraftUnit:Dispose()
	var_0_0.EventDispatcher.DetachEventDispatcher(self)

	return
end

function BattleAircraftUnit:InitCldComponent()
	local var_78_0 = self:GetTemplate().cld_box
	local var_78_1 = self:GetTemplate().cld_offset
	local var_78_2 = var_78_1[1]

	if self:GetDirection() == var_0_0.Battle.BattleConst.UnitDir.LEFT then
		var_78_2 = var_78_2 * -1
	end

	self._cldComponent = var_0_0.Battle.BattleCubeCldComponent.New(var_78_0[1], var_78_0[2], var_78_0[3], var_78_2, var_78_1[3])

	self._cldComponent:SetCldData({
		type = var_0_2.CldType.AIRCRAFT,
		IFF = self:GetIFF(),
		UID = self:GetUniqueID()
	})

	return
end

function BattleAircraftUnit:GetCldBox()
	return self._cldComponent:GetCldBox(self:GetPosition())
end

function BattleAircraftUnit:GetCldData()
	return self._cldComponent:GetCldData()
end

function BattleAircraftUnit:AddBuff()
	return
end

function BattleAircraftUnit:SetBuffStack()
	return
end

function BattleAircraftUnit:RemoveBuff()
	return
end

function BattleAircraftUnit:CloakExpose()
	return
end

function BattleAircraftUnit:GetCurrentOxyState()
	return nil
end

function BattleAircraftUnit:RemoveRemoteBoundBone()
	return
end

function BattleAircraftUnit:SetRemoteBoundBone()
	return
end

function BattleAircraftUnit:GetRemoteBoundBone()
	return
end

return
