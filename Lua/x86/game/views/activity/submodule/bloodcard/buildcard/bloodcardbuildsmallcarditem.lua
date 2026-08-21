local var_0_0 = class("BloodCardBuildSmallCardItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.stateController_ = arg_2_0.controller_:GetController("state")
	arg_2_0.goldController_ = arg_2_0.controller_:GetController("gold")
end

function var_0_0.AddUIListener(arg_3_0)
	return
end

function var_0_0.RefreshUI(arg_4_0)
	arg_4_0.goldController_:SetSelectedState(tostring(arg_4_0.cfg_.kind == BloodCardConst.CARD_KIND.GOLD))
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.index_ = arg_5_1
	arg_5_0.id_ = arg_5_2
	arg_5_0.cfg_ = BloodCardGameCardCfg[arg_5_2]
	arg_5_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/VersionUI/CORGUI_Com/CORGUI_3_10_BloodCardUI/" .. arg_5_0.cfg_.illustration)

	arg_5_0:RefreshUI()
end

function var_0_0.SetClickCallBack(arg_6_0, arg_6_1)
	arg_6_0.clickCallBack = arg_6_1
end

function var_0_0.SetState(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.stateController_:SetSelectedState(arg_7_1)

	arg_7_0.numberText_.text = "+" .. arg_7_2
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
