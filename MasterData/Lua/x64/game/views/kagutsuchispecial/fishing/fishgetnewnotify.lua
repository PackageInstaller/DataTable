local FishGetNewNotify = class("FishGetNewNotify", ReduxView)

function FishGetNewNotify:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingSuccessPopUI"
end

function FishGetNewNotify:UIParent()
	return manager.ui.uiPop.transform
end

function FishGetNewNotify:Init()
	self:BindCfgUI()

	self.detail = FishCollectionDetailItem.New(self.detailPanel_)

	self.detail:SetClickOnMask(handler(self, self.CloseNotify))
end

function FishGetNewNotify:OnEnter()
	self.closeCallback = self.params_.callback

	self.detail:SetData(self.params_.fishID)

	self.staminaRecover_.text = string.format("+%d", self.params_.staminaRecover or 0)
	self.title_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_GET", self.detail.name)
	self.icon_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Fishing/FishPortrait/" .. HanafudaCardCfg[self.params_.fishID].picture_name)
	self.staminaIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
end

function FishGetNewNotify:CloseNotify()
	JumpTools.Back()

	if self.closeCallback then
		self.closeCallback()
	end
end

return FishGetNewNotify
