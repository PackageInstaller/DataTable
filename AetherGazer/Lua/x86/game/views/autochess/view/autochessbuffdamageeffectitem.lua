local var_0_0 = class("AutoChessHeroUpgradePopItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.motionCom_ = arg_2_0.gameObject_:GetComponent("UIParabolaMotion")
	arg_2_0.dirController_ = arg_2_0.controllerEx_:GetController("dir")
	arg_2_0.isFree = true
end

function var_0_0.SetActive(arg_3_0, arg_3_1)
	SetActive(arg_3_0.gameObject_, arg_3_1)
end

function var_0_0.SetDir(arg_4_0, arg_4_1)
	arg_4_0.dirController_:SetSelectedState(arg_4_1 and "left" or "right")
end

function var_0_0.SetIsFree(arg_5_0, arg_5_1)
	arg_5_0.isFree = arg_5_1

	arg_5_0:SetActive(not arg_5_1)

	if arg_5_1 then
		LuaForUtil.SetTrailRendererClear(arg_5_0.leftTrail_)
		LuaForUtil.SetTrailRendererClear(arg_5_0.rightTrail_)
	end
end

function var_0_0.GetIsFree(arg_6_0)
	return arg_6_0.isFree
end

return var_0_0
