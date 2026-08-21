module("frameworkext.unit.component.UnitCompLive2D", package.seeall)

local var_0_0 = class("UnitCompLive2D", UnitComponentBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._prefabUrl = nil
	arg_1_0._prefabLoader = PrefabLoader.Get(arg_1_1.go)
	arg_1_0._prefabGO = nil
	arg_1_0._isFlipX = 1
end

function var_0_0.setDirection(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1

	if arg_2_0._isFlipX == var_2_0 then
		return
	end

	arg_2_0._isFlipX = var_2_0

	if arg_2_0._prefabGO and not goutil.isNil(arg_2_0._prefabGO) then
		local var_2_1, var_2_2, var_2_3 = Astral.TransformUtil.GetLocalScale(arg_2_0._prefabGO.transform, 0, 0, 0)

		Astral.TransformUtil.SetLocalScale(arg_2_0._prefabGO.transform, var_2_1 * arg_2_0._isFlipX, var_2_2, var_2_3)
	end
end

function var_0_0.setBody(arg_3_0, arg_3_1)
	if arg_3_0._prefabUrl == arg_3_1 then
		return
	end

	arg_3_0:clear()

	if not arg_3_1 then
		return
	end

	arg_3_0._prefabUrl = arg_3_1

	arg_3_0._prefabLoader:load(arg_3_1, arg_3_0._onBodyLoaded, arg_3_0, false)
end

function var_0_0.getInst(arg_4_0)
	return arg_4_0._prefabGO
end

function var_0_0._onBodyLoaded(arg_5_0, arg_5_1)
	arg_5_0._prefabGO = arg_5_0._prefabLoader:getInst()

	arg_5_0._unit:dispatchInnerEvent(UnitActionType.LiveLoaded, arg_5_0)
end

function var_0_0.clear(arg_6_0)
	arg_6_0._prefabLoader:clear()

	arg_6_0._prefabGO = nil
	arg_6_0._prefabUrl = nil
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0._prefabGO = nil
	arg_7_0._prefabLoader = nil
	arg_7_0._prefabUrl = nil
end

return var_0_0
