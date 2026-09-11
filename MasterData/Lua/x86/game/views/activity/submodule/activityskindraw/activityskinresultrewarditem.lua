local ActivitySkinResultRewardItem = class("ActivitySkinResultRewardItem", ReduxView)

function ActivitySkinResultRewardItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinResultRewardItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinResultRewardItem:InitUI()
	self:BindCfgUI()

	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.switchCon_ = ControllerUtil.GetController(self.transform_, "switch")
	self.numCon_ = ControllerUtil.GetController(self.transform_, "num")

	if self.controllerEx_ then
		self.giftController_ = self.controllerEx_:GetController("gift")
	end

	self.commonItem_ = CommonItemView.New(self.commonItemGo_)
end

function ActivitySkinResultRewardItem:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ShowPopItem(POP_ITEM, {
			self.itemID_
		})
	end)
end

function ActivitySkinResultRewardItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.id_ = arg_6_1
	self.cfg_ = ActivityLimitedDrawPoolCfg[arg_6_1]

	local var_6_0 = self.cfg_.reward[1]

	self.itemID_ = self.cfg_.reward[1][1]

	local var_6_1 = ItemCfg[self.itemID_]

	if ActivitySkinDrawTools.GetIsSkinGift(self.itemID_) then
		self.itemID_ = var_6_1.param[1][1]
		self.freeGiftID_ = var_6_1.param[2][1]
		self.freeGiftNum_ = var_6_1.param[2][2]
		var_6_1 = ItemCfg[self.itemID_]
	else
		self.freeGiftID_ = nil
		self.freeGiftNum_ = nil
	end

	local var_6_2 = var_6_1.type == ItemConst.ITEM_TYPE.HERO_SKIN

	if var_6_1.type == ItemConst.ITEM_TYPE.HERO_SKIN or var_6_1.type == ItemConst.ITEM_TYPE.SCENE then
		self.typeCon_:SetSelectedState("special")
	end

	local var_6_3

	do
		self.typeCon_:SetSelectedState(self.cfg_.minimum_guarantee == 2 and 3 or 2)

		var_6_3 = GetI18NText(ItemTools.getItemName(self.itemID_))
	end

	self.num_.text = GetI18NText("x" .. var_6_0[2])
	self.name_.text = var_6_3

	SetActive(self.role_.gameObject, var_6_2)
	SetActive(self.icon_.gameObject, not var_6_2)

	if var_6_2 then
		self.role_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. self.itemID_)
	else
		self.icon_.sprite = ItemTools.getItemSprite(self.itemID_)
	end

	if arg_6_3 and ItemCfg[self.itemID_].num_exchange_item then
		self.switchCon_:SetSelectedState("on")

		self.replaceNameText_.text = var_6_3

		self.numCon_:SetSelectedState("false")

		local var_6_4 = clone(ItemTemplateData)

		var_6_4.id = ItemCfg[self.itemID_].num_exchange_item[1][1]
		var_6_4.number = ItemCfg[self.itemID_].num_exchange_item[1][2]

		self.commonItem_:SetData(var_6_4)
	elseif self.freeGiftID_ then
		self.numCon_:SetSelectedState("false")
		self.switchCon_:SetSelectedState("on")

		if self.giftController_ then
			self.giftController_:SetSelectedState("on")
		end

		self.replaceNameText_.text = var_6_3

		local var_6_5 = clone(ItemTemplateData)

		var_6_5.id = self.freeGiftID_
		var_6_5.number = self.freeGiftNum_

		self.commonItem_:SetData(var_6_5)
	else
		self.numCon_:SetSelectedState("true")
		self.switchCon_:SetSelectedState("off")

		if self.giftController_ then
			self.giftController_:SetSelectedState("off")
		end
	end
end

function ActivitySkinResultRewardItem:OnExit()
	return
end

function ActivitySkinResultRewardItem:Dispose()
	self:RemoveAllListeners()
	self.commonItem_:Dispose()
	self.super.Dispose(self)
end

return ActivitySkinResultRewardItem
