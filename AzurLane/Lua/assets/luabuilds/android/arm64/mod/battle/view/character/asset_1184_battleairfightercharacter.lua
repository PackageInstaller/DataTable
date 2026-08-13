ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleAirFighterUnit
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleAirFighterCharacter = var_0_10004("BattleAirFighterCharacter", var_0.Battle.BattleAircraftCharacter)
var_0.Battle.BattleAirFighterCharacter.__name = "BattleAirFighterCharacter"

local var_0_4 = var_0.Battle.BattleAirFighterCharacter

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	Vector3 = var_1
	arg_1_0._scaleVector = var_1(1, 1, 1)

	return
end

function var_0_4.SetUnitData(arg_2_0, arg_2_1)
	arg_2_0._unitData = arg_2_1

	arg_2_0:AddUnitEvent()
	arg_2_1:SetUnVisitable()

	return
end

function var_0_4.AddModel(arg_3_0, arg_3_1)
	arg_3_0:SetGO(arg_3_1)
	arg_3_0:SetBoneList()

	local var_3_0 = arg_3_0._unitData

	var_2.ActiveCldBox(var_3_0)

	return
end

function var_0_4.Update(arg_4_0)
	arg_4_0:UpdateMatrix()
	arg_4_0:UpdateUIComponentPosition()
	arg_4_0:UpdateHPPop()
	arg_4_0:UpdateHPPopContainerPosition()
	arg_4_0:UpdateHPBarPosition()
	arg_4_0:UpdatePosition()
	arg_4_0:UpdateHpBar()

	local var_4_0 = arg_4_0._unitData

	if var_1.GetStrikeState(var_4_0) == var_0_2.STRIKE_STATE_DOWN or var_1 == var_0_2.STRIKE_STATE_ATTACK or var_1 == var_0_2.STRIKE_STATE_UP then
		arg_4_0:UpdateShadow()
	end

	return
end

function var_0_4.AddUnitEvent(arg_5_0)
	var_0_4.super.AddUnitEvent(arg_5_0)

	local var_5_0 = arg_5_0._unitData

	var_1.RegisterEventListener(var_5_0, arg_5_0, var_0_1.AIR_STRIKE_STATE_CHANGE, arg_5_0.onStrikeStateChange)

	return
end

function var_0_4.RemoveUnitEvent(arg_6_0)
	var_0_4.super.RemoveUnitEvent(arg_6_0)

	local var_6_0 = arg_6_0._unitData

	var_1.UnregisterEventListener(var_6_0, arg_6_0, var_0_1.AIR_STRIKE_STATE_CHANGE)

	return
end

function var_0_4.onStrikeStateChange(arg_7_0)
	local var_7_0 = arg_7_0._unitData

	if var_1.GetStrikeState(var_7_0) == var_0_2.STRIKE_STATE_FLY then
		local var_7_1 = arg_7_0._unitData
		local var_7_2 = 12 / (var_2.GetFormationIndex(var_7_1) + 3) + 1
		local var_7_3 = arg_7_0._unitData
		local var_7_4 = var_7_2 * var_3.GetSize(var_7_3)
		local var_7_5 = arg_7_0._scaleVector

		var_3.Set(var_7_5, var_7_4, var_7_4, var_7_4)

		arg_7_0._tf.localScale = arg_7_0._scaleVector

		local var_7_6 = arg_7_0._shadow

		var_3.SetActive(var_7_6, false)
	elseif var_1 == var_0_2.STRIKE_STATE_BACK then
		local var_7_7 = arg_7_0._unitData
		local var_7_8 = var_2.GetSize(var_7_7)
		local var_7_9 = arg_7_0._scaleVector

		var_3.Set(var_7_9, -var_7_8, var_7_8, var_7_8)

		arg_7_0._tf.localScale = arg_7_0._scaleVector

		local var_7_10 = arg_7_0._HPBar

		var_3.SetActive(var_7_10, true)

		local var_7_11 = arg_7_0._shadow

		var_3.SetActive(var_7_11, true)
	elseif var_1 == var_0_2.STRIKE_STATE_DOWN then
		-- block empty
	elseif var_1 == var_0_2.STRIKE_STATE_ATTACK then
		-- block empty
	elseif var_1 == var_0_2.STRIKE_STATE_UP then
		-- block empty
	elseif var_1 == var_0_2.STRIKE_STATE_FREE then
		-- block empty
	elseif var_1 == var_0_2.STRIKE_STATE_BACKWARD then
		local var_7_12 = arg_7_0._unitData
		local var_7_13 = var_2.GetSize(var_7_12)
		local var_7_14 = arg_7_0._scaleVector

		var_3.Set(var_7_14, var_7_13, var_7_13, var_7_13)

		arg_7_0._tf.localScale = arg_7_0._scaleVector
	end

	return
end

return
