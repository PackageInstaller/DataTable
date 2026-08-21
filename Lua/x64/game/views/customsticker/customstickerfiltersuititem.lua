local var_0_0 = class("CustomStickerFilterSuitItem", ReduxView)

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

	arg_3_0.selectController_ = arg_3_0.mainControllerEx_:GetController("select")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.mainBtn_, nil, function()
		if arg_4_0.click_ then
			arg_4_0.click_()
		end
	end)
end

function var_0_0.SetData(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.click_ = arg_6_2

	local var_6_0 = StickerSuitCfg[arg_6_1]

	arg_6_0.mainImg_.spriteAsync = "TextureConfig/Sticker/Suit_s/Suit_s_" .. var_6_0.resource
	arg_6_0.nameText_.text = var_6_0.name
end

function var_0_0.Select(arg_7_0, arg_7_1)
	if arg_7_1 then
		arg_7_0.selectController_:SetSelectedState("true")
	else
		arg_7_0.selectController_:SetSelectedState("false")
	end
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
