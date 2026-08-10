local var_0_0 = class("NorseSurpriseGiftMachineItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.stateCtrl = arg_2_0.transform_:GetComponent("ControllerExCollection"):GetController("state")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0:UpdateView(arg_5_1)
end

function var_0_0.UpdateView(arg_6_0, arg_6_1)
	arg_6_0.heroId = arg_6_1

	local var_6_0 = HeroCfg[arg_6_1].race
	local var_6_1 = arg_6_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_6_1).id

	arg_6_0.raceImage_.sprite = HeroTools.GetHeroRaceIcon(arg_6_0.heroId)
	arg_6_0.iconImage_.sprite = HeroTools.GetHeadSprite(arg_6_0.heroId)
end

function var_0_0.SetState(arg_7_0, arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if arg_7_0.heroId == iter_7_1 then
			arg_7_0.stateCtrl:SetSelectedState("heart")

			break
		end
	end

	arg_7_0.stateCtrl:SetSelectedState(heartState)

	if arg_7_2 and arg_7_2 > 0 then
		if arg_7_2 == arg_7_0.heroId then
			arg_7_0.stateCtrl:SetSelectedState("receive")
		else
			arg_7_0.stateCtrl:SetSelectedState("notreceive")
		end
	else
		arg_7_0.stateCtrl:SetSelectedIndex(0)
	end
end

function var_0_0.ResetState(arg_8_0)
	arg_8_0.stateCtrl:SetSelectedIndex(0)
end

function var_0_0.PlayAnim(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.anim_:Play("NorseSurpriseGiftMachineUI_item")
		arg_9_0.animZhuanhua_:Play("CommonItem_zhuanhua")
	else
		arg_9_0.anim_:Play("New State")
		arg_9_0.animZhuanhua_:Play("New State")
		SetActive(arg_9_0.animZhuanhua_.gameObject, false)
	end
end

function var_0_0.OnEnter(arg_10_0)
	arg_10_0.stateCtrl:SetSelectedIndex(0)
end

function var_0_0.OnExit(arg_11_0)
	var_0_0.super.OnExit(arg_11_0)
end

function var_0_0.Dispose(arg_12_0)
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
