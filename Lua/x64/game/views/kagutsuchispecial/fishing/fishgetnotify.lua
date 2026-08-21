local var_0_0 = class("FishGetNotify", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingUpPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(arg_3_0.closeBtn_, nil, JumpTools.Back)

	arg_3_0.cardItem = HanafudaCardView.New(arg_3_0.card_)
end

function var_0_0.OnEnter(arg_4_0)
	local var_4_0 = arg_4_0.params_.fishID
	local var_4_1 = arg_4_0.params_.lastRarity
	local var_4_2 = HanafudaCardCfg[var_4_0]
	local var_4_3 = RareFishCfg[var_4_2.desc]
	local var_4_4 = KagutsuchiFishingEventData:GetRarity(var_4_0)
	local var_4_5, var_4_6 = KagutsuchiFishingEventData:GetNextRarity(var_4_0)

	arg_4_0.tips_.text = var_4_5 and GetTipsF("ACTIVITY_KAGUTSUCHI_CARD_LEVEL_UP", var_4_6, var_4_3.name, var_4_5.name) or ""

	local var_4_7 = {
		id = var_4_0,
		race = var_4_2.race,
		desc = var_4_2.desc,
		placeType = HanafudaData.CARD_PLACE_TYPE.COLLECTION,
		rarity = var_4_4.order
	}

	arg_4_0.cardItem:SetData(1, var_4_7)
	arg_4_0.cardItem:RefreshUI(0)

	if var_4_1 ~= var_4_4 then
		arg_4_0.title_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_CARD_LEVEL_UP", var_4_3.name)
		arg_4_0.prevRarityImg_.sprite = getSprite("Atlas/Common", "star_" .. var_4_1.order)

		arg_4_0.upgrade_:Play("upgrade")

		if var_4_4 == KagutsuchiFishingEventData.EnumFishRarity.S then
			manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_uptos", "")
		else
			manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_uptoa", "")
		end
	else
		arg_4_0.title_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_GET", var_4_3.name)
		arg_4_0.prevRarityImg_.sprite = arg_4_0.cardItem.rarityImg_.sprite

		arg_4_0.upgrade_:Play("wait")
	end
end

function var_0_0.Dispose(arg_5_0)
	var_0_0.super.Dispose(arg_5_0)
	arg_5_0.cardItem:Dispose()
end

return var_0_0
