local var_0_0 = class("ChatStickerCategoryItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.id_ = arg_1_3

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	local var_1_0 = ChatStickerCategoryCfg[arg_1_3]

	arg_1_0.icon_.sprite = getSpriteViaConfig("ChatSticker", var_1_0.icon)
	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "select")

	if not arg_1_0.controller_ then
		arg_1_0.controller_ = arg_1_0.itemControllerEx_:GetController("select")
	end
end

function var_0_0.OnEnter(arg_2_0)
	return
end

function var_0_0.OnExit(arg_3_0)
	return
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)
	Object.Destroy(arg_4_0.gameObject_)

	arg_4_0.transform_ = nil
	arg_4_0.gameObject_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.button_, nil, function()
		manager.notify:Invoke(CHAT_CHANGE_STICKER_CATEGORY, arg_5_0.id_)
	end)
end

function var_0_0.RefreshSelectID(arg_7_0, arg_7_1)
	if arg_7_0.id_ == arg_7_1 then
		arg_7_0.controller_:SetSelectedState("true")
	else
		arg_7_0.controller_:SetSelectedState("false")
	end
end

return var_0_0
