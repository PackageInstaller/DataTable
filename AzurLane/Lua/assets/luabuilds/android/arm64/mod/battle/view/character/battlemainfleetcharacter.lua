ys = ys or {}

local var_0_2 = class("BattleMainFleetCharacter", ys.Battle.BattlePlayerCharacter)

ys.Battle.BattleMainFleetCharacter = var_0_2
var_0_2.__name = "BattleMainFleetCharacter"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.Update(arg_2_0)
	var_0_2.super.Update(arg_2_0)
	arg_2_0:UpdateArrowBarPosition()

	return
end

function var_0_2.AddArrowBar(arg_3_0, arg_3_1)
	var_0_2.super.AddArrowBar(arg_3_0, arg_3_1)

	local var_3_0 = LoadSprite("qicon/" .. arg_3_0._unitData:GetTemplate().painting) or LoadSprite("heroicon/unknown")

	setImageSprite(findTF(arg_3_0._arrowBar, "icon"), var_3_0)

	return
end

function var_0_2.UpdateHPBarPosition(arg_4_0)
	if not arg_4_0._inViewArea then
		var_0_2.super.UpdateHPBarPosition(arg_4_0)
	end

	return
end

function var_0_2.GetReferenceVector(arg_5_0, arg_5_1)
	if not arg_5_0._inViewArea then
		return var_0_2.super.GetReferenceVector(arg_5_0, arg_5_1)
	else
		return arg_5_0._arrowVector
	end

	return
end

return
