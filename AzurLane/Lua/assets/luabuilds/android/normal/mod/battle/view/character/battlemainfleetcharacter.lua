ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleMainFleetCharacter", var_0.Battle.BattlePlayerCharacter)

var_0.Battle.BattleMainFleetCharacter = var_0_3
var_0_3.__name = "BattleMainFleetCharacter"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.Update(arg_2_0)
	var_0_3.super.Update(arg_2_0)
	arg_2_0:UpdateArrowBarPosition()

	return
end

function var_0_3.AddArrowBar(arg_3_0, arg_3_1)
	var_0_3.super.AddArrowBar(arg_3_0, arg_3_1)

	LoadSprite = var_2

	local var_3_0 = "qicon/"
	local var_3_1 = arg_3_0._unitData
	local var_3_2

	if not var_2(var_3_0 .. var_4.GetTemplate(var_3_1).painting) then
		LoadSprite = var_3_2
		var_3_2 = var_3_2("heroicon/unknown")
	end

	setImageSprite = var_3
	findTF = var_4

	var_3(var_4(arg_3_0._arrowBar, "icon"), var_3_2)

	return
end

function var_0_3.UpdateHPBarPosition(arg_4_0)
	if not arg_4_0._inViewArea then
		var_0_3.super.UpdateHPBarPosition(arg_4_0)
	end

	return
end

function var_0_3.GetReferenceVector(arg_5_0, arg_5_1)
	if not arg_5_0._inViewArea then
		return var_0_3.super.GetReferenceVector(arg_5_0, arg_5_1)
	else
		return arg_5_0._arrowVector
	end

	return
end

return
