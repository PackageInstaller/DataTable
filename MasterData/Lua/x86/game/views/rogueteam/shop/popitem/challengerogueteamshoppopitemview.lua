local ChallengeRogueTeamShopPopItemView = class("ChallengeRogueTeamShopPopItemView", ReduxView)

function ChallengeRogueTeamShopPopItemView:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:BindCfgUI()
	self:AddListeners()

	self.itemList_ = {}
	self.itemView_ = ChallengeRogueTeamTreasureItem.New(self.itemGo_, 1)
	self.costController_ = self.controllerEx_:GetController("cost")
end

function ChallengeRogueTeamShopPopItemView:Dispose()
	self.itemView_:Dispose()

	self.itemView_ = nil

	ChallengeRogueTeamShopPopItemView.super.Dispose(self)
end

function ChallengeRogueTeamShopPopItemView:AddListeners()
	self:AddBtnListener(self.closeBtn_, nil, function()
		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED)
	end)
end

function ChallengeRogueTeamShopPopItemView:SetData(arg_5_1)
	self.itemData_ = arg_5_1

	self:RefreshUI()
end

function ChallengeRogueTeamShopPopItemView:RefreshUI()
	self.costImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetAttributeIconPath(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD))

	local var_6_0 = math.ceil(ChallengeRogueTeamTools.GetShopItemDefaultPrice(self.itemData_.id, self.itemData_.rare) * self.itemData_.discount / 100)

	self.priceText_.text = var_6_0

	if ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD) < var_6_0 then
		self.costController_:SetSelectedState("sufficient")
	else
		self.costController_:SetSelectedState("Insufficient")
	end

	self.itemData_.descRaycastFlag = true
	self.itemData_.needShowCampFlag = true

	self.itemView_:SetData(self.itemData_)
	self.itemView_:SelectTreasure(1)
end

return ChallengeRogueTeamShopPopItemView
