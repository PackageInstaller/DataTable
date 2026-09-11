local PopItemView = class("PopItemView", ReduxView)
local var_0_1 = {
	[6013] = 2,
	[113907] = 1
}
local var_0_2 = {
	[ItemConst.ITEM_SUB_TYPE.HERO_CHIP_GIFT] = "RANDOM_ITEM_CONTENT"
}

function PopItemView:UIName()
	return "Widget/Common/Pop/ProphintspopUI"
end

function PopItemView:OnCtor(...)
	local var_2_0, var_2_1 = gameContext:GetLastHistoryAndParams()

	if string.char(string.byte(var_2_0)) == "/" then
		var_2_0 = string.sub(var_2_0, 2)
	end

	self.lastRecord_ = var_2_0

	OperationRecorder.Record(self.lastRecord_, "PopItemView")
end

function PopItemView:UIParent()
	return manager.ui.uiPop.transform
end

function PopItemView:Init()
	self:InitUI()
	self:AddListeners()
end

function PopItemView:GetItemID()
	return (ItemTools.GetTemplateItemID(self.itemInfo_.id))
end

function PopItemView:GetItemNum()
	return self.itemInfo_.num
end

function PopItemView:GetItemTimeValid()
	return self.itemInfo_.timeValid
end

function PopItemView:InitData()
	self.itemInfo_ = self.routeName_ == "popItem2" and self.params_.popItemSecondViewInfo or self.params_.popItemInfo
	self.extraInfo_ = self.params_.extraInfo or {}
end

function PopItemView:OnEnter()
	self:InitData()
	self:InitController()
	self:RefreshItemShow()
	self:RefreshContent()
	self:RefreshCount()
	self:RefreshOwnedTotalCount()
	self:RefreshViewBtn()
end

function PopItemView:InitController()
	self.viewController:SetSelectedState("state0")
	self.useController:SetSelectedState("state0")
	self.starController:SetSelectedState("state0")
	self.soureceDesControllerController:SetSelectedState("notshow")
	self.probabilityController:SetSelectedState("notshow")
	self.showItemListController:SetSelectedState("hide")
	self.tabControllerController:SetSelectedState("none")
	self:CustomInitUI()
end

function PopItemView:RefreshViewBtn()
	if ItemCfg[self.itemInfo_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT and not self.extraInfo_.isSettlement or ItemCfg[self.itemInfo_.id].type == ItemConst.ITEM_TYPE.STICKER_BG or ItemCfg[self.itemInfo_.id].type == ItemConst.ITEM_TYPE.STICKER_FG then
		self.viewController:SetSelectedState("state1")
	else
		self.viewController:SetSelectedState(var_0_1[self.itemInfo_.id] and "state1" or "state0")
	end
end

function PopItemView:OnMaterialUpdate(arg_12_1)
	if arg_12_1 == self:GetItemID() then
		self:RefreshCount()
	end
end

function PopItemView:RefreshLableContent()
	if DormFurnitureTools:CheckFurShowExtendLable(self:GetItemID()) then
		self.lableList = DormTools:GetFurLable(self:GetItemID()) or {}

		self.labelScroll_:StartScroll(#self.lableList)
	end
end

function PopItemView:indexLableItem(arg_14_1, arg_14_2)
	arg_14_2:RefreshUI(self:GetItemID(), self.lableList[arg_14_1])
end

function PopItemView:indexSoureceItem(arg_15_1, arg_15_2)
	arg_15_2:RefreshUI(self:GetItemID(), self.sourceList[arg_15_1])

	if self.OnJumpCallback then
		arg_15_2:SetJumpCallback(handler(self, self.OnJumpCallback))
	end
end

function PopItemView:OnExit()
	self:DestroyDynamic()
	self:RemoveListeners()
	PopItemView.super.OnExit(self)
end

function PopItemView:Dispose()
	if self.commonItemView_ then
		self.commonItemView_:Dispose()

		self.commonItemView_ = nil
	end

	self.maskBtn_ = nil
	self.nameText_ = nil
	self.countentText_ = nil
	self.sourceBtn_ = nil
	self.sourceBtnGo_ = nil
	self.operatePanel_ = nil
	self.useBtn_ = nil
	self.cntPanel_ = nil
	self.cntText_ = nil
	self.commonItem_ = nil
	self.sourcePanel_ = nil
	self.infoBtn_ = nil
	self.sourceParent_ = nil
	self.unlockItem_ = nil
	self.lockItem_ = nil
	self.invalidItem_ = nil

	if self.sourceScroll_ then
		self.sourceScroll_:Dispose()
	end

	if self.itemListScroll_ then
		self.itemListScroll_:Dispose()
	end

	PopItemView.super.Dispose(self)
end

function PopItemView:InitUI()
	self:BindCfgUI()

	self.infoController = self.prophintspopuiControllerexcollection_:GetController("tab")
	self.timeController = self.prophintspopuiControllerexcollection_:GetController("time")
	self.equipController = self.prophintspopuiControllerexcollection_:GetController("equip")
	self.groupController = self.prophintspopuiControllerexcollection_:GetController("group")
	self.viewController = self.prophintspopuiControllerexcollection_:GetController("view")
	self.useController = self.prophintspopuiControllerexcollection_:GetController("Use")
	self.bgController = self.prophintspopuiControllerexcollection_:GetController("bg")
	self.starController = self.prophintspopuiControllerexcollection_:GetController("star")
	self.tabControllerController = self.prophintspopuiControllerexcollection_:GetController("tab")
	self.btnShowControllerController = self.prophintspopuiControllerexcollection_:GetController("isShowBtn")
	self.soureceDesControllerController = self.prophintspopuiControllerexcollection_:GetController("soureceDes")
	self.probabilityController = self.prophintspopuiControllerexcollection_:GetController("probability")
	self.showItemListController = self.prophintspopuiControllerexcollection_:GetController("showItemList")
	self.useNumTriggerListener_ = self.useNumSlider_.gameObject.transform:GetComponent(typeof(EventTriggerListener))
	self.sourceList = {}
	self.sourceScroll_ = LuaList.New(handler(self, self.indexSoureceItem), self.accessUilist_, PopsoureceItem)
	self.itemListScroll_ = LuaList.New(handler(self, self.indexItem), self.itemUiList_, CommonRecommendItemView)
end

function PopItemView:indexItem(arg_19_1, arg_19_2)
	local var_19_0 = clone(ItemTemplateData)

	var_19_0.id = self.showItemList[arg_19_1][1]
	var_19_0.number = self.showItemList[arg_19_1][2]

	function var_19_0.clickFun()
		JumpTools.OpenPageByJump("popItem2", {
			popItemSecondViewInfo = var_19_0
		})
	end

	arg_19_2:SetData(var_19_0)
	arg_19_2:RefreshRecommend()
end

function PopItemView:CheckIsMeetShowItemList(arg_21_1)
	if arg_21_1 == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or arg_21_1 == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT or arg_21_1 == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE or arg_21_1 == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_MULTI or arg_21_1 == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_LIMIT_TIME or arg_21_1 == ItemConst.ITEM_SUB_TYPE.HERO_CHIP_GIFT or arg_21_1 == ItemConst.ITEM_SUB_TYPE.Hero_OPTIONAL_IMMEDIATELY_USE then
		return true
	end

	return false
end

function PopItemView:UpdateItemList()
	local var_22_0 = ItemCfg[self:GetItemID()]

	if var_22_0 and var_22_0.type == ItemConst.ITEM_TYPE.GIFT and self:CheckIsMeetShowItemList(var_22_0.sub_type) then
		if var_22_0.param and #var_22_0.param > 0 then
			self.showItemList = var_22_0.param

			self.showItemListController:SetSelectedState("show")

			self.subNameTxt_.text = GetTips(var_0_2[var_22_0.sub_type] or "OPTIONAL_ITEM_CONTENT")

			self.itemListScroll_:StartScroll(#self.showItemList)
		end
	else
		self.showItemListController:SetSelectedState("hide")
	end
end

function PopItemView:CustomInitUI()
	self.tabControllerController:SetSelectedState("descripe")
	self.btnShowControllerController:SetSelectedState("hide")
end

function PopItemView:AddListeners()
	self:AddBtnListener(self.maskBtn_, nil, function()
		self:Back()
	end)
	self:AddBtnListener(self.viewBtn_, nil, function()
		if ItemCfg[self.itemInfo_.id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			JumpTools.OpenPageByJump("/showServantView", {
				state = "onlydetail",
				id = self.itemInfo_.id
			})
		elseif ItemCfg[self.itemInfo_.id].type == ItemConst.ITEM_TYPE.STICKER_BG or ItemCfg[self.itemInfo_.id].type == ItemConst.ITEM_TYPE.STICKER_FG then
			local var_26_0 = ProfileDecorateItemCfg[self.itemInfo_.id]

			if ProfileDecorateItemCfg[self.itemInfo_.id] then
				JumpTools.OpenPageByJump("customStickerPreviewPop", {
					suit = false,
					cfg = var_26_0
				})
			end
		elseif var_0_1[self.itemInfo_.id] == 1 then
			self:Go("/heroSkin", {
				isDlc = false,
				showOnly = true,
				heroID = SkinCfg[self.itemInfo_.id].hero,
				skinID = self.itemInfo_.id
			})
		elseif var_0_1[self.itemInfo_.id] == 2 then
			local var_26_1 = CustomCenterTools.GetMatchSkinByScene(self.itemInfo_.id)

			self:Go("/heroSkin", {
				isDlc = true,
				showOnly = true,
				heroID = SkinCfg[var_26_1].hero,
				skinID = var_26_1
			})
		end
	end)
end

function PopItemView:RemoveListeners()
	return
end

function PopItemView:RefreshContent()
	local var_28_0 = ItemCfg[self:GetItemID()]

	self.nameText_.text = ItemTools.getItemName(var_28_0.id)
	self.countentText_.text = ItemTools.getItemDesc(var_28_0.id)

	local var_28_1 = ItemTools.GetItemExpiredTimeByInfo(self.itemInfo_)

	if var_28_1 == nil or var_28_1 == 0 then
		self.timeController:SetSelectedState("no")
	else
		local var_28_2 = ItemTools.GetItemExpiredTimeByInfo(self.itemInfo_)

		self.timeController:SetSelectedState("yes")

		self.timeLabel_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(var_28_2, "!%Y/%m/%d %H:%M"))
	end

	self:UpdateItemList()
end

function PopItemView:CheckIsDynamic()
	local var_30_0 = self:GetItemID()

	if ProfileDecorateItemCfg[var_30_0] and ProfileDecorateItemCfg[var_30_0].type == 2 then
		return true
	elseif ChatBubbleCfg[var_30_0] and ChatBubbleCfg[var_30_0].type == 2 then
		return true
	end

	return false
end

function PopItemView:RefreshDynamicItem()
	local var_31_0 = self:GetItemID()

	if not isNil(self.dynamicObj_) then
		self:DestroyDynamic()
	end

	local var_31_1
	local var_31_2

	if ProfileDecorateItemCfg[var_31_0] and ProfileDecorateItemCfg[var_31_0].type == 2 then
		SetActive(self.dynamicBubbleContent_.gameObject, false)
		SetActive(self.dynamicNormalContent_.gameObject, true)

		var_31_2 = tonumber(ProfileDecorateItemCfg[var_31_0].resource)

		if ProfileDecorateItemCfg[var_31_0].item_type == 2 then
			var_31_1 = DynamicPortraitPool.GetInstance():GetHead(var_31_2, self.dynamicNormalContent_)
		elseif ProfileDecorateItemCfg[var_31_0].item_type == 3 then
			var_31_1 = DynamicPortraitPool.GetInstance():GetFrame(var_31_2, self.dynamicNormalContent_)
		elseif ProfileDecorateItemCfg[var_31_0].item_type == 1 then
			var_31_1 = DynamicPortraitPool.GetInstance():GetCardBg(var_31_2, self.dynamicNormalContent_)
			var_31_1.transform.anchoredPosition = Vector3.New(-40, 0, 0)
		end
	elseif ChatBubbleCfg[var_31_0] and ChatBubbleCfg[var_31_0].type == 2 then
		SetActive(self.dynamicBubbleContent_.gameObject, true)
		SetActive(self.dynamicNormalContent_.gameObject, false)

		var_31_2 = tonumber(ChatBubbleCfg[var_31_0].image1)
		var_31_1 = DynamicPortraitPool.GetInstance():GetBubble(var_31_2, self.dynamicBubbleContent_)
		self.dynamicBubbleImg_.color = LuaHelper.StringToColor("#" .. ChatBubbleCfg[var_31_0].color2)

		self.dynamicBubbleImg_.transform:SetAsLastSibling()
	end

	self.dynamicImageID_ = var_31_2
	self.dynamicName_ = var_31_0
	self.dynamicObj_ = var_31_1
end

function PopItemView:RefreshItemShow()
	if self:CheckIsDynamic() then
		SetActive(self.commonItem_, false)
		SetActive(self.dynamicContent_.gameObject, true)
		self:RefreshDynamicItem()
		self:RefreshCommonItem()
	else
		SetActive(self.commonItem_, true)
		SetActive(self.dynamicContent_.gameObject, false)
		self:DestroyDynamic()
		self:RefreshCommonItem()
	end
end

function PopItemView:DestroyDynamic()
	if not isNil(self.dynamicObj_) then
		if ProfileDecorateItemCfg[self.dynamicName_] then
			if ProfileDecorateItemCfg[self.dynamicName_].item_type == 2 then
				DynamicPortraitPool.GetInstance():ReturnHead(self.dynamicImageID_, self.dynamicObj_)
			elseif ProfileDecorateItemCfg[self.dynamicName_].item_type == 3 then
				DynamicPortraitPool.GetInstance():ReturnFrame(self.dynamicImageID_, self.dynamicObj_)
			elseif ProfileDecorateItemCfg[self.dynamicName_].item_type == 1 then
				DynamicPortraitPool.GetInstance():ReturnCardBg(self.dynamicImageID_, self.dynamicObj_)
			end
		elseif ChatBubbleCfg[self.dynamicName_] then
			DynamicPortraitPool.GetInstance():ReturnBubble(self.dynamicImageID_, self.dynamicObj_)
		end
	end

	self.dynamicImageID_ = nil
	self.dynamicName_ = nil
	self.dynamicObj_ = nil
end

function PopItemView:RefreshCommonItem(arg_34_1)
	self.commonItemView_ = self.commonItemView_ or CommonItemView.New(self.commonItem_)
	self.itemInfo_.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL

	self.commonItemView_:SetData(self.itemInfo_)
	self.commonItemView_:RefreshBottomRightText(true)
	self.commonItemView_.rareController_:SetSelectedState("off")
	self:UpdateIcon()

	local var_34_0 = ItemCfg[self:GetItemID()]

	if var_34_0 and ItemConst.ITEM_TYPE.HERO == var_34_0.type then
		-- block empty
	end

	if ItemCfg[self.itemInfo_.id] then
		self.bgController:SetSelectedState("state" .. tostring(ItemCfg[self.itemInfo_.id].display_rare or 0))
	end
end

function PopItemView:UpdateIcon()
	self.itemImg_.sprite = ItemTools.getItemSprite(self:GetItemID())
end

function PopItemView:SetCommonItem(arg_36_1)
	self.itemInfo_.num = arg_36_1

	self:RefreshItemShow()
end

function PopItemView:RefreshCount()
	local var_37_0 = self:GetItemID()
	local var_37_1

	if self.extraInfo_.overrideShowTotalCnt then
		var_37_1 = self.extraInfo_.overrideShowTotalCnt
	elseif self.extraInfo_.onlyShowCntByItemInfo then
		var_37_1 = self.itemInfo_.number or 0
	elseif self.extraInfo_.showTotalCntIgnoreTimeValid then
		var_37_1 = ItemTools.getItemTotalNumIgnoreTimeValid(var_37_0)
	else
		var_37_1 = ItemTools.getItemNum(var_37_0, (ItemTools.GetItemExpiredTimeByInfo(self.itemInfo_)))

		if not MaterialData:IsItemHaveServeTick(self.itemInfo_.id) then
			var_37_1 = ItemTools.getItemNum(var_37_0)
		end
	end

	self.cntText_.text = NumberTools.RetractNumberForWindBar(var_37_1)
end

local var_0_4 = setmetatable({}, {
	__index = function()
		return true
	end
})
local var_0_5 = {
	[ItemConst.ITEM_TYPE.HERO] = var_0_4,
	[ItemConst.ITEM_TYPE.HERO_SKIN] = var_0_4,
	[ItemConst.ITEM_TYPE.PORTRAIT] = var_0_4,
	[ItemConst.ITEM_TYPE.FRAME] = var_0_4,
	[ItemConst.ITEM_TYPE.STICKER] = var_0_4,
	[ItemConst.ITEM_TYPE.STICKER_BG] = var_0_4,
	[ItemConst.ITEM_TYPE.SCENE] = var_0_4,
	[ItemConst.ITEM_TYPE.TAG] = var_0_4,
	[ItemConst.ITEM_TYPE.CARD_BG] = var_0_4,
	[ItemConst.ITEM_TYPE.FURNITURE_SUIT] = var_0_4,
	[ItemConst.ITEM_TYPE.CHAT_BUBBLE] = var_0_4,
	[ItemConst.ITEM_TYPE.CLUB_COMMON] = var_0_4,
	[ItemConst.ITEM_TYPE.GIFT] = {
		[ItemConst.ITEM_SUB_TYPE.EQUIP_PIECE] = true,
		[ItemConst.ITEM_SUB_TYPE.EQUIP_PIECE_UP] = true,
		[ItemConst.ITEM_SUB_TYPE.DROP_ITEM] = true,
		[ItemConst.ITEM_SUB_TYPE.FUKUBUKURO] = true
	},
	[ItemConst.ITEM_TYPE.MATERIAL] = {
		[ItemConst.ITEM_SUB_TYPE.NYA_SUMMER_PUB_ITEM] = true
	}
}

function PopItemView:ShouldHideOwnedTotalCount()
	local var_39_0 = ItemCfg[self:GetItemID()]

	return nullable(var_0_5, var_39_0.type, var_39_0.sub_type) or false
end

function PopItemView:RefreshOwnedTotalCount()
	local var_40_0

	if self.itemInfo_ then
		var_40_0 = self.itemInfo_.isHideNum_ or false
	end

	var_40_0 = var_40_0 or self:GetIsHideCurrency(self:GetItemID())

	if self:ShouldHideOwnedTotalCount() or var_40_0 then
		SetActive(self.cntPanel_, false)
	else
		SetActive(self.cntPanel_, true)
	end
end

function PopItemView:GetIsHideCurrency(arg_41_1)
	if self.hideCurrencyList == nil then
		self.hideCurrencyList = {}

		for iter_41_0, iter_41_1 in pairs(CurrencyIdMapCfg) do
			if iter_41_1.hide_number == 1 then
				table.insert(self.hideCurrencyList, iter_41_1.item_id)
			end
		end
	end

	return table.indexof(self.hideCurrencyList, arg_41_1)
end

function PopItemView:ShowInfo()
	self.tabControllerController:SetSelectedState("descripe")
end

function PopItemView:OnExitInput()
	self:Back()

	return true
end

return PopItemView
