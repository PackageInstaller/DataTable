local var_0_0 = class("StickerTemplateItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.stateCon_ = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFunc_ then
			arg_4_0.clickFunc_()
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.id_ = arg_7_1
	arg_7_0.bgID_ = arg_7_2
	arg_7_0.bg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Sticker/stickerBtn/Sticker_bg_" .. arg_7_0.bgID_)
	arg_7_0.template_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Sticker/stickerBtn/Sticker_button_" .. arg_7_0.id_)
end

function var_0_0.SetState(arg_8_0, arg_8_1)
	arg_8_0.stateCon_:SetSelectedState(arg_8_1)
end

function var_0_0.SetSelected(arg_9_0, arg_9_1)
	arg_9_0.selectCon_:SetSelectedState(arg_9_1 and "on" or "off")
end

function var_0_0.RegistClickFunc(arg_10_0, arg_10_1)
	arg_10_0.clickFunc_ = arg_10_1
end

function var_0_0.OnExit(arg_11_0)
	return
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
