ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleUnitEvent

ys.Battle.BattleAircraftCharacter = class("BattleAircraftCharacter", ys.Battle.BattleCharacter)
ys.Battle.BattleAircraftCharacter.__name = "BattleAircraftCharacter"

local var_0_2 = ys.Battle.BattleAircraftCharacter

function ys.Battle.BattleAircraftCharacter:Ctor()
	var_0_2.super.Ctor(self)

	self._hpBarOffset = Vector3(0, 1.6, 0)

	self:SetYShakeMin()
	self:SetYShakeMax()

	self.shadowScale = Vector3.one
	self.shadowPos = Vector3.zero

	return
end

function ys.Battle.BattleAircraftCharacter:SetUnitData(arg_2_1)
	self._unitData = arg_2_1

	self:AddUnitEvent()

	return
end

function ys.Battle.BattleAircraftCharacter:InitWeapon()
	self._weapon = self._unitData:GetWeapon()

	for iter_3_0, iter_3_1 in ipairs(self._weapon) do
		iter_3_1:RegisterEventListener(self, var_0_1.CREATE_BULLET, self.onCreateBullet)
	end

	return
end

function ys.Battle.BattleAircraftCharacter:GetModleID()
	return self._unitData:GetSkinID()
end

function ys.Battle.BattleAircraftCharacter.GetInitScale(arg_5_0)
	return 1
end

function ys.Battle.BattleAircraftCharacter.AddUnitEvent(arg_6_0)
	return
end

function ys.Battle.BattleAircraftCharacter:RemoveUnitEvent()
	for iter_7_0, iter_7_1 in ipairs(self._weapon) do
		iter_7_1:UnregisterEventListener(self, var_0_1.CREATE_BULLET)
	end

	if self._unitData:GetIFF() == var_0_0.Battle.BattleConfig.FOE_CODE then
		self._unitData:UnregisterEventListener(self, var_0_1.UPDATE_AIR_CRAFT_HP)
	end

	return
end

function ys.Battle.BattleAircraftCharacter.PlayAction(arg_8_0)
	return
end

function ys.Battle.BattleAircraftCharacter:Update()
	self:UpdateMatrix()
	self:UpdateDirection()
	self:UpdateUIComponentPosition()
	self:UpdateShadow()
	self:UpdatePosition()

	if self._unitData:GetIFF() == var_0_0.Battle.BattleConfig.FOE_CODE then
		self:UpdateHPPop()
		self:UpdateHPPopContainerPosition()
		self:UpdateHPBarPosition()
		self:UpdateHpBar()
	end

	return
end

function ys.Battle.BattleAircraftCharacter:UpdatePosition()
	if not self._unitData:IsOutViewBound() then
		self._tf.localPosition = self._unitData:GetPosition()
	end

	self._characterPos = self._unitData:GetPosition()

	return
end

function ys.Battle.BattleAircraftCharacter:UpdateDirection()
	if self._unitData:GetCurrentState() ~= self._unitData.STATE_CREATE then
		return
	end

	local var_11_0 = self._unitData:GetSize()

	if self._unitData:GetDirection() == var_0_0.Battle.BattleConst.UnitDir.RIGHT then
		self._tf.localScale = Vector3(var_11_0, var_11_0, var_11_0)
	elseif self._unitData:GetDirection() == var_0_0.Battle.BattleConst.UnitDir.LEFT then
		self._tf.localScale = Vector3(-var_11_0, var_11_0, var_11_0)
	end

	return
end

function ys.Battle.BattleAircraftCharacter:UpdateHPBarPosition()
	self._hpBarPos:Copy(self._referenceVector):Add(self._hpBarOffset)

	self._HPBarTf.position = self._hpBarPos

	return
end

function ys.Battle.BattleAircraftCharacter:UpdateShadow()
	if self._shadow and self._unitData:GetCurrentState() == self._unitData.STATE_CREATE then
		local var_13_0 = self._unitData:GetPosition()
		local var_13_1 = math.min(4, math.max(2, 4 - 4 * var_13_0.y / var_0_0.Battle.BattleConfig.AircraftHeight))

		self.shadowScale.x, self.shadowScale.z = var_13_1, var_13_1
		self._shadowTF.localScale = self.shadowScale
		self.shadowPos.x, self.shadowPos.z = var_13_0.x, var_13_0.z
		self._shadowTF.position = self.shadowPos
	end

	return
end

function ys.Battle.BattleAircraftCharacter:GetYShake()
	self._YShakeCurrent = self._YShakeCurrent or 0
	self._YShakeDir = self._YShakeDir or 1
	self._YShakeCurrent = self._YShakeCurrent + 0.1 * self._YShakeDir

	if self._YShakeCurrent > self._YShakeMax and self._YShakeDir == 1 then
		self._YShakeDir = -1

		self:SetYShakeMin()
	elseif self._YShakeCurrent < self._YShakeMin and self._YShakeDir == -1 then
		self._YShakeDir = 1

		self:SetYShakeMax()
	end

	return self._YShakeCurrent
end

function ys.Battle.BattleAircraftCharacter.SetYShakeMin(arg_15_0)
	arg_15_0._YShakeMin = -1 - 2 * math.random()

	return
end

function ys.Battle.BattleAircraftCharacter.SetYShakeMax(arg_16_0)
	arg_16_0._YShakeMax = 1 + 2 * math.random()

	return
end

function ys.Battle.BattleAircraftCharacter:AddModel(arg_17_1)
	self:SetGO(arg_17_1)

	self._hpBarOffset = Vector3(0, self._unitData:GetBoxSize().y, 0)

	self:SetBoneList()

	self._tf.position = self._unitData:GetPosition()

	self:UpdateMatrix()
	self._unitData:ActiveCldBox()

	return
end

function ys.Battle.BattleAircraftCharacter:AddShadow(arg_18_1)
	self._shadow = self:GetTf():Find("model/shadow").gameObject
	self._shadowTF = self._shadow.transform

	return
end

function ys.Battle.BattleAircraftCharacter:AddHPBar(arg_19_1)
	self._HPBar = arg_19_1
	self._HPBarTf = arg_19_1.transform
	self._HPProgress = self._HPBarTf:Find("blood"):GetComponent(typeof(Image))

	arg_19_1:SetActive(true)
	self._unitData:RegisterEventListener(self, var_0_1.UPDATE_AIR_CRAFT_HP, self.OnUpdateHP)
	self:UpdateHpBar()

	return
end

function ys.Battle.BattleAircraftCharacter.updateSomkeFX(arg_20_0)
	return
end

return
