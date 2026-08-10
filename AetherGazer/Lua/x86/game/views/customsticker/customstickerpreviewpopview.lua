local var_0_0 = class("CustomStickerPreviewPopView", ReduxView)
local var_0_1 = 10

function var_0_0.UIName(arg_1_0)
	return "Widget/System/UserInfor/sticker_new/StickerPreviewUI"
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

	arg_4_0.curPreviewCfg_ = nil
	arg_4_0.curPreviewSuit_ = false
	arg_4_0.curDynamicFg_ = nil
	arg_4_0.curDynamicBg_ = nil
	arg_4_0.curDynamicSuit_ = nil
	arg_4_0.suitShowController_ = arg_4_0.mainControllerEx_:GetController("suitShow")
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.retBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	arg_7_0.curPreviewCfg_ = arg_7_0.params_.cfg
	arg_7_0.curPreviewSuit_ = arg_7_0.params_.suit or false

	if arg_7_0.curPreviewCfg_ then
		arg_7_0:UpdateView()
	end
end

function var_0_0.UpdateView(arg_8_0)
	arg_8_0:DestroyDynamicGo()

	arg_8_0.bgStaticImg_.enabled = false
	arg_8_0.fgStaticImg_.enabled = false

	if arg_8_0.curPreviewSuit_ then
		arg_8_0.suitShowController_:SetSelectedState("true")

		arg_8_0.curDynamicSuit_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Sticker/Suititem_" .. arg_8_0.curPreviewCfg_.resource), arg_8_0.suitDynamicTrs_)
		arg_8_0.descText_.text = arg_8_0.curPreviewCfg_.desc
		arg_8_0.nameText_.text = arg_8_0.curPreviewCfg_.name
	else
		arg_8_0.suitShowController_:SetSelectedState("false")

		if arg_8_0.curPreviewCfg_.item_type == 4 then
			if arg_8_0.curPreviewCfg_.type == 1 then
				arg_8_0.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_" .. arg_8_0.curPreviewCfg_.resource
				arg_8_0.bgStaticImg_.enabled = true
			elseif arg_8_0.curPreviewCfg_.type == 2 then
				arg_8_0.curDynamicBg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Bg/Bgitem_" .. arg_8_0.curPreviewCfg_.resource), arg_8_0.bgDynamicTrs_)
				arg_8_0.bgStaticImg_.enabled = false
			end
		elseif arg_8_0.curPreviewCfg_.item_type == 6 then
			arg_8_0.bgStaticImg_.spriteAsync = "TextureConfig/Sticker/Background_l/Stickerbg_l_4002"
			arg_8_0.bgStaticImg_.enabled = true

			if arg_8_0.curPreviewCfg_.type == 1 then
				arg_8_0.fgStaticImg_.spriteAsync = "TextureConfig/Sticker/Foreground_l/Stickerfg_l_" .. arg_8_0.curPreviewCfg_.resource
				arg_8_0.fgStaticImg_.enabled = true
			elseif arg_8_0.curPreviewCfg_.type == 2 then
				arg_8_0.curDynamicFg_ = Object.Instantiate(Asset.Load("Widget/System/UserInfor/sticker_new/dynamicitem/Foreground/Foregrounditem_" .. arg_8_0.curPreviewCfg_.resource), arg_8_0.fgDynamicTrs_)
				arg_8_0.fgStaticImg_.enabled = false
			end
		end

		arg_8_0.descText_.text = ItemTools.getItemDesc(arg_8_0.curPreviewCfg_.id)
		arg_8_0.nameText_.text = ItemTools.getItemName(arg_8_0.curPreviewCfg_.id)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.layoutTrs_)
end

function var_0_0.DestroyDynamicGo(arg_9_0)
	if arg_9_0.curDynamicFg_ then
		Object.Destroy(arg_9_0.curDynamicFg_)

		arg_9_0.curDynamicFg_ = nil
	end

	if arg_9_0.curDynamicBg_ then
		Object.Destroy(arg_9_0.curDynamicBg_)

		arg_9_0.curDynamicBg_ = nil
	end

	if arg_9_0.curDynamicSuit_ then
		Object.Destroy(arg_9_0.curDynamicSuit_)

		arg_9_0.curDynamicSuit_ = nil
	end
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:DestroyDynamicGo()
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
