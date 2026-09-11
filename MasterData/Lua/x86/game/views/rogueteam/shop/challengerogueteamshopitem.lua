local ChallengeRogueTeamShopItem = class("ChallengeRogueTeamShopItem", ReduxView)

function ChallengeRogueTeamShopItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	self.transform_ = self.gameObject_.transform
	self.index_ = arg_1_4
	self.type_ = arg_1_3

	self:BindCfgUI()
	self:AddListeners()

	self.stateController_ = self.controllerEx_:GetController("state")
	self.discountController_ = self.controllerEx_:GetController("price")
	self.isNewController_ = self.controllerEx_:GetController("collect")
	self.bgController_ = self.controllerEx_:GetController("bg")
	self.qualityController_ = self.controllerEx_:GetController("quality")
	self.sufficientController_ = self.controllerEx_:GetController("sufficient")

	SetActive(self.gameObject_, true)
end

function ChallengeRogueTeamShopItem:Dispose()
	ChallengeRogueTeamShopItem.super.Dispose(self)
	Object.Destroy(self.gameObject_)

	self.transform_ = nil
	self.gameObject_ = nil
end

function ChallengeRogueTeamShopItem:AddListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.data_ == nil then
			return
		end

		if self.data_.buyTimes <= 0 then
			return
		end

		manager.notify:Invoke(CHALLENGE_ROGUE_TEAM_SHOP_ITEM_SELECTED, self.data_)
	end)
end

function ChallengeRogueTeamShopItem:SetData(arg_5_1)
	self.data_ = arg_5_1

	if arg_5_1 == nil then
		if (self.type_ == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE and ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_SELL_TREASURE_MAX_CNT) or ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.SHOP_SELL_RELIC_MAX_CNT)) >= self.index_ then
			self.stateController_:SetSelectedState("soldout")
			self.isNewController_:SetSelectedState("off")
			self.bgController_:SetSelectedState("off")
			self.discountController_:SetSelectedState("off")
		else
			self.stateController_:SetSelectedState("lock")
			self.isNewController_:SetSelectedState("off")
			self.discountController_:SetSelectedState("off")
			self.bgController_:SetSelectedState("off")
		end

		return
	end

	local var_5_1 = arg_5_1.id

	if arg_5_1.buyTimes <= 0 then
		self.stateController_:SetSelectedState("owned")
		self.isNewController_:SetSelectedState("off")
		self.bgController_:SetSelectedState("off")
		self.discountController_:SetSelectedState("off")
	else
		self.stateController_:SetSelectedState("normal")
	end

	local var_5_2 = RogueTeamItemCfg[var_5_1]

	self.nameText_.text = RogueTeamItemCfg[var_5_1].name

	local var_5_3 = ChallengeRogueTeamTools.GetShopItemDefaultPrice(var_5_1, arg_5_1.rare)
	local var_5_4 = math.ceil(var_5_3 * arg_5_1.discount / 100)

	if arg_5_1.discount == 100 then
		self.discountController_:SetSelectedState("off")
	else
		self.discountController_:SetSelectedState("on")

		self.discountText_.text = string.format("%.01f%s", arg_5_1.discount / 10, GetTips("LABEL_DISCOUNT"))
		self.originPriceText_.text = var_5_3
	end

	if var_5_4 > ChallengeRogueTeamTools.GetWindowBarText(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD) then
		self.sufficientController_:SetSelectedState("false")
	else
		self.sufficientController_:SetSelectedState("true")
	end

	self.priceText_.text = var_5_4
	self.costImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetAttributeIconPath(ChallengeRogueTeamConst.ATTRIBUTE_ENUM.GOLD))
	self.iconImage_.sprite = pureGetSpriteWithoutAtlas(ChallengeRogueTeamTools.GetItemIcon(var_5_1))

	if arg_5_1.isNew then
		self.isNewController_:SetSelectedState("on")
	else
		self.isNewController_:SetSelectedState("off")
	end

	if var_5_2.type == ChallengeRogueTeamConst.ITEM_TYPE.TREASURE then
		self.qualityController_:SetSelectedIndex(arg_5_1.rare)
		self.bgController_:SetSelectedState("on")
	else
		self.qualityController_:SetSelectedIndex(0)
		self.bgController_:SetSelectedState("off")
	end
end

return ChallengeRogueTeamShopItem
