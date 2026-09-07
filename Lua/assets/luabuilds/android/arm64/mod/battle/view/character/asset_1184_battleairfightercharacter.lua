ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = ys.Battle.BattleAirFighterUnit

ys.Battle.BattleAirFighterCharacter = class("BattleAirFighterCharacter", ys.Battle.BattleAircraftCharacter)
ys.Battle.BattleAirFighterCharacter.__name = "BattleAirFighterCharacter"

local var_0_2 = ys.Battle.BattleAirFighterCharacter

function ys.Battle.BattleAirFighterCharacter.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	arg_1_0._scaleVector = Vector3(1, 1, 1)

	return
end

function ys.Battle.BattleAirFighterCharacter:SetUnitData(arg_2_1)
	self._unitData = arg_2_1

	self:AddUnitEvent()
	arg_2_1:SetUnVisitable()

	return
end

function ys.Battle.BattleAirFighterCharacter:AddModel(arg_3_1)
	self:SetGO(arg_3_1)
	self:SetBoneList()
	self._unitData:ActiveCldBox()

	return
end

function ys.Battle.BattleAirFighterCharacter:Update()
	self:UpdateMatrix()
	self:UpdateUIComponentPosition()
	self:UpdateHPPop()
	self:UpdateHPPopContainerPosition()
	self:UpdateHPBarPosition()
	self:UpdatePosition()
	self:UpdateHpBar()

	local var_4_0 = self._unitData:GetStrikeState()

	if var_4_0 == var_0_1.STRIKE_STATE_DOWN or var_4_0 == var_0_1.STRIKE_STATE_ATTACK or var_4_0 == var_0_1.STRIKE_STATE_UP then
		self:UpdateShadow()
	end

	return
end

function ys.Battle.BattleAirFighterCharacter:AddUnitEvent()
	var_0_2.super.AddUnitEvent(self)
	self._unitData:RegisterEventListener(self, var_0_0.AIR_STRIKE_STATE_CHANGE, self.onStrikeStateChange)

	return
end

function ys.Battle.BattleAirFighterCharacter:RemoveUnitEvent()
	var_0_2.super.RemoveUnitEvent(self)
	self._unitData:UnregisterEventListener(self, var_0_0.AIR_STRIKE_STATE_CHANGE)

	return
end

function ys.Battle.BattleAirFighterCharacter:onStrikeStateChange()
	local var_7_0 = self._unitData:GetStrikeState()

	if var_7_0 == var_0_1.STRIKE_STATE_FLY then
		local var_7_1 = (12 / (self._unitData:GetFormationIndex() + 3) + 1) * self._unitData:GetSize()

		self._scaleVector:Set(var_7_1, var_7_1, var_7_1)

		self._tf.localScale = self._scaleVector

		self._shadow:SetActive(false)
	elseif var_7_0 == var_0_1.STRIKE_STATE_BACK then
		local var_7_2 = self._unitData:GetSize()

		self._scaleVector:Set(-var_7_2, var_7_2, var_7_2)

		self._tf.localScale = self._scaleVector

		self._HPBar:SetActive(true)
		self._shadow:SetActive(true)
	elseif var_7_0 == var_0_1.STRIKE_STATE_DOWN then
		-- block empty
	elseif var_7_0 == var_0_1.STRIKE_STATE_ATTACK then
		-- block empty
	elseif var_7_0 == var_0_1.STRIKE_STATE_UP then
		-- block empty
	elseif var_7_0 == var_0_1.STRIKE_STATE_FREE then
		-- block empty
	elseif var_7_0 == var_0_1.STRIKE_STATE_BACKWARD then
		local var_7_3 = self._unitData:GetSize()

		self._scaleVector:Set(var_7_3, var_7_3, var_7_3)

		self._tf.localScale = self._scaleVector
	end

	return
end

return
