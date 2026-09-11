local FishCollectionDetailItem = class("FishCollectionDetailItem", BaseView)

function FishCollectionDetailItem:Ctor(arg_1_1)
	FishCollectionDetailItem.super.Ctor(self)

	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function FishCollectionDetailItem:Init()
	self:BindCfgUI()

	if self.card_ then
		self.cardItem = HanafudaCardView.New(self.card_)
	end

	self:AddBtnListener(self.detailMaskBtn_, nil, function()
		if self.clickOnMaskFunc then
			self.clickOnMaskFunc()
		end
	end)

	self.controller = ControllerUtil.GetController(self.transform_, "rarity")
end

function FishCollectionDetailItem:Dispose()
	FishCollectionDetailItem.super.Dispose(self)

	if self.cardItem then
		self.cardItem:Dispose()
	end
end

function FishCollectionDetailItem:SetData(arg_5_1)
	local var_5_0 = RareFishCfg[HanafudaCardCfg[arg_5_1].desc]

	self.name = RareFishCfg[HanafudaCardCfg[arg_5_1].desc].name
	self.name_.text = self.name

	local var_5_1 = KagutsuchiFishingEventData:GetRarity(arg_5_1)

	if self.cardItem then
		self.cardItem:SetData(1, {
			id = arg_5_1,
			race = HanafudaCardCfg[arg_5_1].race,
			desc = HanafudaCardCfg[arg_5_1].desc,
			placeType = HanafudaData.CARD_PLACE_TYPE.COLLECTION,
			rarity = var_5_1.order
		})
	end

	self.descText_.text = var_5_1 == KagutsuchiFishingEventData.EnumFishRarity.B and GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_CARD_UNLOCK_TIPS", var_5_0.name) or var_5_0.desc
	self.descText2_.text = var_5_0.talk

	if self.controller then
		local var_5_2, var_5_3 = KagutsuchiFishingEventData:GetNextRarity(arg_5_1)

		self.controller:SetSelectedState(var_5_1.name)

		self.tips_.text = var_5_2 and GetTipsF("ACTIVITY_KAGUTSUCHI_CARD_LEVEL_UP", var_5_3, var_5_0.name, var_5_2.name) or ""
	end
end

function FishCollectionDetailItem:SetClickOnMask(arg_6_1)
	self.clickOnMaskFunc = arg_6_1
end

return FishCollectionDetailItem
