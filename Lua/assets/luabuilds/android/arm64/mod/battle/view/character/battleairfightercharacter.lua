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

function ys.Battle.BattleAirFighterCharacter.SetUnitData(arg_2_0, arg_2_1)
	arg_2_0._unitData = arg_2_1

	arg_2_0:AddUnitEvent()
	arg_2_1:SetUnVisitable()

	return
end

function ys.Battle.BattleAirFighterCharacter.AddModel(arg_3_0, arg_3_1)
	arg_3_0:SetGO(arg_3_1)
	arg_3_0:SetBoneList()
	arg_3_0._unitData:ActiveCldBox()

	return
end

function ys.Battle.BattleAirFighterCharacter.Update(arg_4_0)
	arg_4_0:UpdateMatrix()
	arg_4_0:UpdateUIComponentPosition()
	arg_4_0:UpdateHPPop()
	arg_4_0:UpdateHPPopContainerPosition()
	arg_4_0:UpdateHPBarPosition()
	arg_4_0:UpdatePosition()
	arg_4_0:UpdateHpBar()

	local var_4_0 = arg_4_0._unitData:GetStrikeState()

	if var_4_0 == var_0_1.STRIKE_STATE_DOWN or var_4_0 == var_0_1.STRIKE_STATE_ATTACK or var_4_0 == var_0_1.STRIKE_STATE_UP then
		arg_4_0:UpdateShadow()
	end

	return
end

function ys.Battle.BattleAirFighterCharacter.AddUnitEvent(arg_5_0)
	var_0_2.super.AddUnitEvent(arg_5_0)
	arg_5_0._unitData:RegisterEventListener(arg_5_0, var_0_0.AIR_STRIKE_STATE_CHANGE, arg_5_0.onStrikeStateChange)

	return
end

function ys.Battle.BattleAirFighterCharacter.RemoveUnitEvent(arg_6_0)
	var_0_2.super.RemoveUnitEvent(arg_6_0)
	arg_6_0._unitData:UnregisterEventListener(arg_6_0, var_0_0.AIR_STRIKE_STATE_CHANGE)

	return
end

function ys.Battle.BattleAirFighterCharacter.onStrikeStateChange(arg_7_0)
	local var_7_0 = arg_7_0._unitData:GetStrikeState()

	if var_7_0 == var_0_1.STRIKE_STATE_FLY then
		local var_7_1 = (12 / (arg_7_0._unitData:GetFormationIndex() + 3) + 1) * arg_7_0._unitData:GetSize()

		arg_7_0._scaleVector:Set(var_7_1, var_7_1, var_7_1)

		arg_7_0._tf.localScale = arg_7_0._scaleVector

		arg_7_0._shadow:SetActive(false)
	elseif var_7_0 == var_0_1.STRIKE_STATE_BACK then
		local var_7_2 = arg_7_0._unitData:GetSize()

		arg_7_0._scaleVector:Set(-var_7_2, var_7_2, var_7_2)

		arg_7_0._tf.localScale = arg_7_0._scaleVector

		arg_7_0._HPBar:SetActive(true)
		arg_7_0._shadow:SetActive(true)
	elseif var_7_0 == var_0_1.STRIKE_STATE_DOWN then
		-- block empty
	elseif var_7_0 == var_0_1.STRIKE_STATE_ATTACK then
		-- block empty
	elseif var_7_0 == var_0_1.STRIKE_STATE_UP then
		-- block empty
	elseif var_7_0 == var_0_1.STRIKE_STATE_FREE then
		-- block empty
	elseif var_7_0 == var_0_1.STRIKE_STATE_BACKWARD then
		local var_7_3 = arg_7_0._unitData:GetSize()

		arg_7_0._scaleVector:Set(var_7_3, var_7_3, var_7_3)

		arg_7_0._tf.localScale = arg_7_0._scaleVector
	end

	return
end

return
