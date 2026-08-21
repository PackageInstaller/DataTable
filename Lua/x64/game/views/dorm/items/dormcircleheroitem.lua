local var_0_0 = class("DormCircleHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.heroBtn_, nil, function()
		if arg_4_0.clickFunc then
			arg_4_0.clickFunc(arg_4_0.heroID)
		end
	end)
end

function var_0_0.SetClickCallBack(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.clickFunc = arg_6_1
	end
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		arg_7_0.heroID = arg_7_1
		arg_7_0.imageImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_7_1)
	end

	if HeroTools.GetHeroIsUnlock(arg_7_1) then
		if arg_7_0.heroID == arg_7_2 then
			arg_7_0.stateController:SetSelectedState("select")
		else
			arg_7_0.stateController:SetSelectedState("normal")
		end
	else
		arg_7_0.stateController:SetSelectedState("mask")
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
	Object.Destroy(arg_8_0.gameObject_)
end

return var_0_0
