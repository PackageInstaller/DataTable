local var_0_0 = class("CustomStickerItem", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:BindCfgUI()
	arg_1_0:AddListeners()

	arg_1_0.controller_ = ControllerUtil.GetController(arg_1_0.transform_, "select")
	arg_1_0.lockController_ = ControllerUtil.GetController(arg_1_0.transform_, "lock")
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	local var_2_0 = ChatStickerCfg[arg_2_1]

	arg_2_0.isLock_ = false

	if var_2_0.free == 0 then
		arg_2_0.isLock_ = ChatStickerData:IsLockSticker(arg_2_1)
	end

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

	arg_2_0:RefreshSelectState()
	arg_2_0:DestroySticker()

	if var_2_0.type == 1 then
		arg_2_0.icon_.sprite = getSpriteViaConfig("ChatSticker", var_2_0.icon)
		arg_2_0.icon_.enabled = true
	else
		arg_2_0.dynamicStickerGo_ = Object.Instantiate(Asset.Load(var_2_0.icon), arg_2_0.dynamicTf_)
		arg_2_0.icon_.enabled = false
	end
end

function var_0_0.Dispose(arg_3_0)
	var_0_0.super.Dispose(arg_3_0)
	arg_3_0:DestroySticker()
end

function var_0_0.AddListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.button_, nil, function()
		local var_5_0 = GameSetting.chat_sticker_custom_max_cnt.value[1]
		local var_5_1 = ChatStickerData:GetCustomStickerUIList()

		if not table.keyof(var_5_1, arg_4_0.id_) and var_5_0 <= #var_5_1 then
			ShowTips("CHAT_CUSTOM_STICKER_LIMIT_EXCEEDED")

			return
		end

		if arg_4_0.isLock_ then
			if arg_4_0.descSource_ == "" then
				ShowTips("CHAT_DYNAMIC_STICKER_LOCK")
			else
				ShowTips(arg_4_0.descSource_)
			end

			return
		end

		ChatStickerData:ChangeCustomStickerUIList(arg_4_0.id_)
		arg_4_0:RefreshSelectState()
		manager.notify:Invoke(CHAT_CUSTOM_STICKER_CHANGED)
	end)
end

function var_0_0.RefreshSelectState(arg_6_0)
	local var_6_0 = ChatStickerData:GetCustomStickerUIList()

	if table.keyof(var_6_0, arg_6_0.id_) then
		arg_6_0.controller_:SetSelectedState("true")
	else
		arg_6_0.controller_:SetSelectedState("false")
	end
end

function var_0_0.DestroySticker(arg_7_0)
	if arg_7_0.dynamicStickerGo_ then
		Object.Destroy(arg_7_0.dynamicStickerGo_)

		arg_7_0.dynamicStickerGo_ = nil
	end
end

return var_0_0
