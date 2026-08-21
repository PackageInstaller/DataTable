local var_0_0 = class("DormHeroSkinItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.stateController = ControllerUtil.GetController(arg_2_0.transform_, "name")
	arg_2_0.selectController = ControllerUtil.GetController(arg_2_0.transform_, "select")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0.onClickCom_ = arg_3_0:FindCom("OnClickDownListener")

	arg_3_0.onClickCom_.onValueChanged:AddListener(function()
		if arg_3_0.hasFlag then
			if arg_3_0.clickFunc then
				arg_3_0.clickFunc(arg_3_0.skinID)
			end
		else
			ShowTips(string.format(GetTips("DORM_HERO_SKIN_NULL"), SkinCfg[arg_3_0.skinID].name))
		end
	end)
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.skinID = arg_5_1
	arg_5_0.iconImg_.sprite = DormHeroTools.GetBackHomeHeroSkinIcon(arg_5_1)
	arg_5_0.skinName.text = SkinCfg[arg_5_1].name

	arg_5_0.selectController:SetSelectedState("normal")

	if DormHeroTools:isUnlock(arg_5_0.skinID) then
		arg_5_0.hasFlag = true

		if DormData:GetHeroTemplateInfo(arg_5_2):GetHeroCurSkinID(arg_5_2) == arg_5_0.skinID then
			arg_5_0.stateController:SetSelectedState("using")
		else
			arg_5_0.stateController:SetSelectedState("normal")
		end

		if arg_5_1 == arg_5_3 then
			arg_5_0.selectController:SetSelectedState("select")
		end
	else
		arg_5_0.hasFlag = false

		arg_5_0.stateController:SetSelectedState("lock")
	end
end

function var_0_0.RegisterClickCallBack(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0.clickFunc = arg_6_1
	end
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.onClickCom_.onValueChanged:RemoveAllListeners()
	var_0_0.super.Dispose(arg_7_0)
end

return var_0_0
