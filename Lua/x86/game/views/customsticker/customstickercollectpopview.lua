local var_0_0 = class("CustomStickerCollectPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/sticker_new/StickerPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.curStickerID_ = 0
	arg_4_0.curStickerCfg_ = nil
	arg_4_0.groundState_ = false
	arg_4_0.dynamicSt_ = false
	arg_4_0.curDynamicGo_ = nil
	arg_4_0.groundController_ = arg_4_0.mainControllerEx_:GetController("ground")
	arg_4_0.lockController_ = arg_4_0.mainControllerEx_:GetController("lock")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.previewBtn_, nil, function()
		if arg_5_0.groundState_ then
			JumpTools.OpenPageByJump("customStickerPreviewPop", {
				suit = false,
				cfg = arg_5_0.curStickerCfg_
			})
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.retBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.curStickerID_ = arg_8_0.params_.stickerID or GameSetting.sticker_background_default.value[1]
	arg_8_0.curStickerCfg_ = ProfileDecorateItemCfg[arg_8_0.curStickerID_]
	arg_8_0.groundState_ = arg_8_0.curStickerCfg_.item_type == 4 or arg_8_0.curStickerCfg_.item_type == 6
	arg_8_0.dynamicSt_ = arg_8_0.curStickerCfg_.type == 2 and arg_8_0.curStickerCfg_.item_type == 5

	local var_8_0 = ItemCfg[arg_8_0.curStickerID_]

	arg_8_0.nameText_.text = ItemTools.getItemName(arg_8_0.curStickerID_)
	arg_8_0.archiveText_.text = ItemTools.getItemDesc(arg_8_0.curStickerID_)

	local var_8_1 = false

	if arg_8_0.curStickerCfg_.item_type == 5 then
		var_8_1 = PlayerData:GetSticker(arg_8_0.curStickerID_).lock
	elseif arg_8_0.curStickerCfg_.item_type == 4 then
		var_8_1 = PlayerData:GetStickerBg(arg_8_0.curStickerID_).lock
	elseif arg_8_0.curStickerCfg_.item_type == 6 then
		var_8_1 = PlayerData:GetStickerFg(arg_8_0.curStickerID_).lock
	end

	if var_8_1 and not string.isNullOrEmpty(var_8_0.desc_source) then
		arg_8_0.lockController_:SetSelectedState("true")

		arg_8_0.sourceText_.text = GetI18NText(var_8_0.desc_source)
	else
		arg_8_0.lockController_:SetSelectedState("false")
	end

	arg_8_0:DestroyDynamicGo()

	if arg_8_0.groundState_ then
		arg_8_0.groundController_:SetSelectedState("ground")

		if arg_8_0.curStickerCfg_.item_type == 4 then
			arg_8_0.groundImg_.spriteAsync = "TextureConfig/Sticker/Background_m/Stickerbg_m_" .. arg_8_0.curStickerCfg_.resource
		elseif arg_8_0.curStickerCfg_.item_type == 6 then
			arg_8_0.groundImg_.spriteAsync = "TextureConfig/Sticker/Foreground_m/Stickerfg_m_" .. arg_8_0.curStickerCfg_.resource
		end
	else
		arg_8_0.groundController_:SetSelectedState("sticker")

		if arg_8_0.dynamicSt_ then
			arg_8_0.curDynamicGo_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Sticker/Stickeritem_" .. arg_8_0.curStickerCfg_.resource), arg_8_0.stickerImg_.transform)
			arg_8_0.stickerImg_.enabled = false
		else
			arg_8_0.stickerImg_.spriteAsync = "TextureConfig/Sticker/Sticker/" .. arg_8_0.curStickerCfg_.resource
			arg_8_0.stickerImg_.enabled = true
		end
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.txtTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.txtTrs_)
end

function var_0_0.DestroyDynamicGo(arg_9_0)
	if arg_9_0.curDynamicGo_ then
		Object.Destroy(arg_9_0.curDynamicGo_)

		arg_9_0.curDynamicGo_ = nil
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
