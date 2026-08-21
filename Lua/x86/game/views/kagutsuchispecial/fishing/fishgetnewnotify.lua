local var_0_0 = class("FishGetNewNotify", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingSuccessPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.detail = FishCollectionDetailItem.New(arg_3_0.detailPanel_)

	arg_3_0.detail:SetClickOnMask(handler(arg_3_0, arg_3_0.CloseNotify))
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = arg_4_0.params_.fishID

	arg_4_0.closeCallback = arg_4_0.params_.callback

	arg_4_0.detail:SetData(var_4_0)

	arg_4_0.staminaRecover_.text = string.format("+%d", arg_4_0.params_.staminaRecover or 0)
	arg_4_0.title_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_GET", arg_4_0.detail.name)
	arg_4_0.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Fishing/FishPortrait/" .. HanafudaCardCfg[var_4_0].picture_name)

	local var_4_1 = CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id

	arg_4_0.staminaIcon_.sprite = ItemTools.getItemLittleSprite(var_4_1)
end

function var_0_0.CloseNotify(arg_5_0)
	JumpTools.Back()

	if arg_5_0.closeCallback then
		arg_5_0.closeCallback()
	end
end

return var_0_0
