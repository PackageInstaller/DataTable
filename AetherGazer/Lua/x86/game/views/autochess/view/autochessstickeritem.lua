local var_0_0 = class("AutoChessStickerItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
end

function var_0_0.SetData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id_ = arg_2_1
	arg_2_0.clickCb_ = arg_2_3

	local var_2_0 = ChatStickerCfg[arg_2_1]

	if not var_2_0 then
		return
	end

	arg_2_0:RefreshLock(arg_2_2)
	arg_2_0:DestroySticker()

	if var_2_0.type == 1 then
		arg_2_0.imageIcon_.sprite = getSpriteViaConfig("ChatSticker", var_2_0.icon)
		arg_2_0.imageIcon_.enabled = true
	else
		arg_2_0.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_2_0.icon), arg_2_0.dynamicTf_)
		arg_2_0.imageIcon_.enabled = false
	end
end

function var_0_0.Dispose(arg_3_0)
	arg_3_0:DestroySticker()
	var_0_0.super.Dispose(arg_3_0)
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buttonItem_, nil, function()
		if not arg_4_0.clickCb_ then
			return
		end

		arg_4_0.clickCb_(arg_4_0.id_)
	end)
end

function var_0_0.RefreshLock(arg_6_0, arg_6_1)
	arg_6_0.isLock_ = arg_6_1

	arg_6_0.lockController_:SetSelectedState(tostring(arg_6_1))
end

function var_0_0.DestroySticker(arg_7_0)
	if arg_7_0.dynamicStickerGo_ then
		Object.Destroy(arg_7_0.dynamicStickerGo_)

		arg_7_0.dynamicStickerGo_ = nil
	end
end

return var_0_0
