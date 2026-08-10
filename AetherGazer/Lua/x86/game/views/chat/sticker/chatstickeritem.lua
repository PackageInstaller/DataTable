local var_0_0 = class("ChatStickerItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
end

function var_0_0.RefreshData(arg_2_0, arg_2_1)
	local var_2_0 = ChatStickerCfg[arg_2_1]

	if not var_2_0 then
		return
	end

	arg_2_0.isLock_ = var_2_0.free == 0 and ChatStickerData:IsLockSticker(arg_2_1) or false

	if arg_2_0.isLock_ then
		arg_2_0.lockController_:SetSelectedState("true")
	else
		arg_2_0.lockController_:SetSelectedState("false")
	end

	if arg_2_0.id_ == arg_2_1 then
		return
	end

	arg_2_0.id_ = arg_2_1

	if SettingData:GetCurrentLanguage() == "zh_cn" then
		arg_2_0.descSource_ = var_2_0.desc_source
	else
		arg_2_0.descSource_ = var_2_0.desc_source_1
	end

	arg_2_0:DestroySticker()

	if var_2_0.type == 1 then
		arg_2_0.imageIcon_.sprite = getSpriteViaConfig("ChatSticker", var_2_0.icon)
		arg_2_0.imageIcon_.enabled = true
	else
		arg_2_0.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_2_0.icon), arg_2_0.dynamicTf_)
		arg_2_0.imageIcon_.enabled = false
	end
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.buttonItem_, nil, function()
		if arg_3_0.id_ == 0 then
			ChatStickerData:InitStickerUIList()
			JumpTools.OpenPageByJump("chatCustomSticker")

			return
		end

		if arg_3_0.isLock_ then
			if arg_3_0.descSource_ == "" then
				ShowTips("CHAT_DYNAMIC_STICKER_LOCK")
			else
				ShowTips(arg_3_0.descSource_)
			end

			return
		end

		manager.notify:Invoke(CHAT_SEND_STICKER, arg_3_0.id_)
	end)
end

function var_0_0.DestroySticker(arg_5_0)
	if arg_5_0.dynamicStickerGo_ then
		Object.Destroy(arg_5_0.dynamicStickerGo_)

		arg_5_0.dynamicStickerGo_ = nil
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
	arg_6_0:DestroySticker()

	arg_6_0.transform_ = nil
	arg_6_0.gameObject_ = nil
end

return var_0_0
