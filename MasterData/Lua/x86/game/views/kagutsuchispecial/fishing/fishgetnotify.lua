local FishGetNotify = class("FishGetNotify", ReduxView)

function FishGetNotify:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingUpPopUI"
end

function FishGetNotify:UIParent()
	return manager.ui.uiPop.transform
end

function FishGetNotify:Init()
	self:BindCfgUI()
	self:AddBtnListener(self.closeBtn_, nil, JumpTools.Back)

	self.cardItem = HanafudaCardView.New(self.card_)
end

function FishGetNotify:OnEnter()
	local var_4_0 = self.params_.fishID
	local var_4_1 = self.params_.lastRarity
	local var_4_2 = HanafudaCardCfg[self.params_.fishID]
	local var_4_3 = RareFishCfg[HanafudaCardCfg[self.params_.fishID].desc]
	local var_4_4 = KagutsuchiFishingEventData:GetRarity(self.params_.fishID)
	local var_4_5, var_4_6 = KagutsuchiFishingEventData:GetNextRarity(self.params_.fishID)

	self.tips_.text = var_4_5 and GetTipsF("ACTIVITY_KAGUTSUCHI_CARD_LEVEL_UP", var_4_6, var_4_3.name, var_4_5.name) or ""

	self.cardItem:SetData(1, {
		id = var_4_0,
		race = var_4_2.race,
		desc = var_4_2.desc,
		placeType = HanafudaData.CARD_PLACE_TYPE.COLLECTION,
		rarity = var_4_4.order
	})
	self.cardItem:RefreshUI(0)

	if var_4_1 ~= var_4_4 then
		self.title_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_CARD_LEVEL_UP", var_4_3.name)
		self.prevRarityImg_.sprite = getSprite("Atlas/Common", "star_" .. var_4_1.order)

		self.upgrade_:Play("upgrade")

		if var_4_4 == KagutsuchiFishingEventData.EnumFishRarity.S then
			manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_uptos", "")
		else
			manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_uptoa", "")
		end
	else
		self.title_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_GET", var_4_3.name)
		self.prevRarityImg_.sprite = self.cardItem.rarityImg_.sprite

		self.upgrade_:Play("wait")
	end
end

function FishGetNotify:Dispose()
	FishGetNotify.super.Dispose(self)
	self.cardItem:Dispose()
end

return FishGetNotify
