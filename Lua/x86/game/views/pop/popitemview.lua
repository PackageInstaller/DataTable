local var_0_0 = class("PopItemView", ReduxView)
local var_0_1 = {
	[6013] = 2,
	[113907] = 1
}
local var_0_2 = {
	[ItemConst.ITEM_SUB_TYPE.HERO_CHIP_GIFT] = "RANDOM_ITEM_CONTENT"
}

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/ProphintspopUI"
end

function var_0_0.OnCtor(arg_2_0, ...)
	local var_2_0, var_2_1 = gameContext:GetLastHistoryAndParams()

	if string.char(string.byte(var_2_0)) == "/" then
		var_2_0 = string.sub(var_2_0, 2)
	end

	arg_2_0.lastRecord_ = var_2_0

	OperationRecorder.Record(arg_2_0.lastRecord_, "PopItemView")
end

function var_0_0.UIParent(arg_3_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddListeners()
end

function var_0_0.GetItemID(arg_5_0)
	return (ItemTools.GetTemplateItemID(arg_5_0.itemInfo_.id))
end

function var_0_0.GetItemNum(arg_6_0)
	return arg_6_0.itemInfo_.num
end

function var_0_0.GetItemTimeValid(arg_7_0)
	return arg_7_0.itemInfo_.timeValid
end

function var_0_0.InitData(arg_8_0)
	if arg_8_0.routeName_ == "popItem2" then
		arg_8_0.itemInfo_ = arg_8_0.params_.popItemSecondViewInfo
	else
		arg_8_0.itemInfo_ = arg_8_0.params_.popItemInfo
	end

	arg_8_0.extraInfo_ = arg_8_0.params_.extraInfo or {}
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:InitData()
	arg_9_0:InitController()
	arg_9_0:RefreshItemShow()
	arg_9_0:RefreshContent()
	arg_9_0:RefreshCount()
	arg_9_0:RefreshOwnedTotalCount()
	arg_9_0:RefreshViewBtn()
end

function var_0_0.InitController(arg_10_0)
	arg_10_0.viewController:SetSelectedState("state0")
	arg_10_0.useController:SetSelectedState("state0")
	arg_10_0.starController:SetSelectedState("state0")
	arg_10_0.soureceDesControllerController:SetSelectedState("notshow")
	arg_10_0.probabilityController:SetSelectedState("notshow")
	arg_10_0.showItemListController:SetSelectedState("hide")
	arg_10_0.tabControllerController:SetSelectedState("none")
	arg_10_0:CustomInitUI()
end

function var_0_0.RefreshViewBtn(arg_11_0)
	local var_11_0 = ItemCfg[arg_11_0.itemInfo_.id]

	if var_11_0.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT and not arg_11_0.extraInfo_.isSettlement or var_11_0.type == ItemConst.ITEM_TYPE.STICKER_BG or var_11_0.type == ItemConst.ITEM_TYPE.STICKER_FG then
		arg_11_0.viewController:SetSelectedState("state1")
	else
		arg_11_0.viewController:SetSelectedState(var_0_1[arg_11_0.itemInfo_.id] and "state1" or "state0")
	end
end

function var_0_0.OnMaterialUpdate(arg_12_0, arg_12_1)
	if arg_12_1 == arg_12_0:GetItemID() then
		arg_12_0:RefreshCount()
	end
end

function var_0_0.RefreshLableContent(arg_13_0)
	if DormFurnitureTools:CheckFurShowExtendLable(arg_13_0:GetItemID()) then
		arg_13_0.lableList = DormTools:GetFurLable(arg_13_0:GetItemID()) or {}

		arg_13_0.labelScroll_:StartScroll(#arg_13_0.lableList)
	end
end

function var_0_0.indexLableItem(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2:RefreshUI(arg_14_0:GetItemID(), arg_14_0.lableList[arg_14_1])
end

function var_0_0.indexSoureceItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2:RefreshUI(arg_15_0:GetItemID(), arg_15_0.sourceList[arg_15_1])

	if arg_15_0.OnJumpCallback then
		arg_15_2:SetJumpCallback(handler(arg_15_0, arg_15_0.OnJumpCallback))
	end
end

function var_0_0.OnExit(arg_16_0)
	arg_16_0:DestroyDynamic()
	arg_16_0:RemoveListeners()
	var_0_0.super.OnExit(arg_16_0)
end

function var_0_0.Dispose(arg_17_0)
	if arg_17_0.commonItemView_ then
		arg_17_0.commonItemView_:Dispose()

		arg_17_0.commonItemView_ = nil
	end

	arg_17_0.maskBtn_ = nil
	arg_17_0.nameText_ = nil
	arg_17_0.countentText_ = nil
	arg_17_0.sourceBtn_ = nil
	arg_17_0.sourceBtnGo_ = nil
	arg_17_0.operatePanel_ = nil
	arg_17_0.useBtn_ = nil
	arg_17_0.cntPanel_ = nil
	arg_17_0.cntText_ = nil
	arg_17_0.commonItem_ = nil
	arg_17_0.sourcePanel_ = nil
	arg_17_0.infoBtn_ = nil
	arg_17_0.sourceParent_ = nil
	arg_17_0.unlockItem_ = nil
	arg_17_0.lockItem_ = nil
	arg_17_0.invalidItem_ = nil

	if arg_17_0.sourceScroll_ then
		arg_17_0.sourceScroll_:Dispose()
	end

	if arg_17_0.itemListScroll_ then
		arg_17_0.itemListScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_17_0)
end

function var_0_0.InitUI(arg_18_0)
	arg_18_0:BindCfgUI()

	arg_18_0.infoController = arg_18_0.prophintspopuiControllerexcollection_:GetController("tab")
	arg_18_0.timeController = arg_18_0.prophintspopuiControllerexcollection_:GetController("time")
	arg_18_0.equipController = arg_18_0.prophintspopuiControllerexcollection_:GetController("equip")
	arg_18_0.groupController = arg_18_0.prophintspopuiControllerexcollection_:GetController("group")
	arg_18_0.viewController = arg_18_0.prophintspopuiControllerexcollection_:GetController("view")
	arg_18_0.useController = arg_18_0.prophintspopuiControllerexcollection_:GetController("Use")
	arg_18_0.bgController = arg_18_0.prophintspopuiControllerexcollection_:GetController("bg")
	arg_18_0.starController = arg_18_0.prophintspopuiControllerexcollection_:GetController("star")
	arg_18_0.tabControllerController = arg_18_0.prophintspopuiControllerexcollection_:GetController("tab")
	arg_18_0.btnShowControllerController = arg_18_0.prophintspopuiControllerexcollection_:GetController("isShowBtn")
	arg_18_0.soureceDesControllerController = arg_18_0.prophintspopuiControllerexcollection_:GetController("soureceDes")
	arg_18_0.probabilityController = arg_18_0.prophintspopuiControllerexcollection_:GetController("probability")
	arg_18_0.showItemListController = arg_18_0.prophintspopuiControllerexcollection_:GetController("showItemList")
	arg_18_0.useNumTriggerListener_ = arg_18_0.useNumSlider_.gameObject.transform:GetComponent(typeof(EventTriggerListener))
	arg_18_0.sourceList = {}
	arg_18_0.sourceScroll_ = LuaList.New(handler(arg_18_0, arg_18_0.indexSoureceItem), arg_18_0.accessUilist_, PopsoureceItem)
	arg_18_0.itemListScroll_ = LuaList.New(handler(arg_18_0, arg_18_0.indexItem), arg_18_0.itemUiList_, CommonRecommendItemView)
end

function var_0_0.indexItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.showItemList[arg_19_1][1]
	local var_19_1 = arg_19_0.showItemList[arg_19_1][2]
	local var_19_2 = clone(ItemTemplateData)

	var_19_2.id = var_19_0
	var_19_2.number = var_19_1

	function var_19_2.clickFun()
		JumpTools.OpenPageByJump("popItem2", {
			popItemSecondViewInfo = var_19_2
		})
	end

	arg_19_2:SetData(var_19_2)
	arg_19_2:RefreshRecommend()
end

function var_0_0.CheckIsMeetShowItemList(arg_21_0, arg_21_1)
	if arg_21_1 == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM or arg_21_1 == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_MULT or arg_21_1 == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_ONE or arg_21_1 == ItemConst.ITEM_SUB_TYPE.HERO_OPTIONAL_MULTI or arg_21_1 == ItemConst.ITEM_SUB_TYPE.OPTIONAL_ITEM_LIMIT_TIME or arg_21_1 == ItemConst.ITEM_SUB_TYPE.HERO_CHIP_GIFT or arg_21_1 == ItemConst.ITEM_SUB_TYPE.Hero_OPTIONAL_IMMEDIATELY_USE then
		return true
	end

	return false
end

function var_0_0.UpdateItemList(arg_22_0)
	local var_22_0 = ItemCfg[arg_22_0:GetItemID()]

	if var_22_0 and var_22_0.type == ItemConst.ITEM_TYPE.GIFT and arg_22_0:CheckIsMeetShowItemList(var_22_0.sub_type) then
		local var_22_1 = var_22_0.param

		if var_22_1 and #var_22_1 > 0 then
			arg_22_0.showItemList = var_22_1

			arg_22_0.showItemListController:SetSelectedState("show")

			arg_22_0.subNameTxt_.text = GetTips(var_0_2[var_22_0.sub_type] or "OPTIONAL_ITEM_CONTENT")

			arg_22_0.itemListScroll_:StartScroll(#arg_22_0.showItemList)
		end
	else
		arg_22_0.showItemListController:SetSelectedState("hide")
	end
end

function var_0_0.CustomInitUI(arg_23_0)
	arg_23_0.tabControllerController:SetSelectedState("descripe")
	arg_23_0.btnShowControllerController:SetSelectedState("hide")
end

function var_0_0.AddListeners(arg_24_0)
	arg_24_0:AddBtnListener(arg_24_0.maskBtn_, nil, function()
		arg_24_0:Back()
	end)
	arg_24_0:AddBtnListener(arg_24_0.viewBtn_, nil, function()
		local var_26_0 = ItemCfg[arg_24_0.itemInfo_.id]

		if var_26_0.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			JumpTools.OpenPageByJump("/showServantView", {
				state = "onlydetail",
				id = arg_24_0.itemInfo_.id
			})
		elseif var_26_0.type == ItemConst.ITEM_TYPE.STICKER_BG or var_26_0.type == ItemConst.ITEM_TYPE.STICKER_FG then
			local var_26_1 = ProfileDecorateItemCfg[arg_24_0.itemInfo_.id]

			if var_26_1 then
				JumpTools.OpenPageByJump("customStickerPreviewPop", {
					suit = false,
					cfg = var_26_1
				})
			end
		elseif var_0_1[arg_24_0.itemInfo_.id] == 1 then
			local var_26_2 = SkinCfg[arg_24_0.itemInfo_.id]

			arg_24_0:Go("/heroSkin", {
				isDlc = false,
				showOnly = true,
				heroID = var_26_2.hero,
				skinID = arg_24_0.itemInfo_.id
			})
		elseif var_0_1[arg_24_0.itemInfo_.id] == 2 then
			local var_26_3 = CustomCenterTools.GetMatchSkinByScene(arg_24_0.itemInfo_.id)
			local var_26_4 = SkinCfg[var_26_3]

			arg_24_0:Go("/heroSkin", {
				isDlc = true,
				showOnly = true,
				heroID = var_26_4.hero,
				skinID = var_26_3
			})
		end
	end)
end

function var_0_0.RemoveListeners(arg_27_0)
	return
end

function var_0_0.RefreshContent(arg_28_0)
	local var_28_0 = ItemCfg[arg_28_0:GetItemID()]
	local var_28_1 = arg_28_0.itemInfo_

	arg_28_0.nameText_.text = ItemTools.getItemName(var_28_0.id)
	arg_28_0.countentText_.text = ItemTools.getItemDesc(var_28_0.id)

	local var_28_2 = ItemTools.GetItemExpiredTimeByInfo(var_28_1)

	if var_28_2 == nil or var_28_2 == 0 then
		arg_28_0.timeController:SetSelectedState("no")
	else
		local var_28_3 = ItemTools.GetItemExpiredTimeByInfo(var_28_1)

		arg_28_0.timeController:SetSelectedState("yes")

		arg_28_0.timeLabel_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(var_28_3, "!%Y/%m/%d %H:%M"))
	end

	arg_28_0:UpdateItemList()
end

local function var_0_3(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1 or {}

	var_29_0.id = var_29_0.id or arg_29_0.id
	var_29_0.number = var_29_0.num or arg_29_0.num
	var_29_0.timeValid = var_29_0.timeValid or arg_29_0.timeValid

	return var_29_0
end

function var_0_0.CheckIsDynamic(arg_30_0)
	local var_30_0 = arg_30_0:GetItemID()

	if ProfileDecorateItemCfg[var_30_0] and ProfileDecorateItemCfg[var_30_0].type == 2 then
		return true
	elseif ChatBubbleCfg[var_30_0] and ChatBubbleCfg[var_30_0].type == 2 then
		return true
	end

	return false
end

function var_0_0.RefreshDynamicItem(arg_31_0)
	local var_31_0 = arg_31_0:GetItemID()

	if not isNil(arg_31_0.dynamicObj_) then
		arg_31_0:DestroyDynamic()
	end

	local var_31_1
	local var_31_2

	if ProfileDecorateItemCfg[var_31_0] and ProfileDecorateItemCfg[var_31_0].type == 2 then
		SetActive(arg_31_0.dynamicBubbleContent_.gameObject, false)
		SetActive(arg_31_0.dynamicNormalContent_.gameObject, true)

		var_31_2 = tonumber(ProfileDecorateItemCfg[var_31_0].resource)

		if ProfileDecorateItemCfg[var_31_0].item_type == 2 then
			var_31_1 = DynamicPortraitPool.GetInstance():GetHead(var_31_2, arg_31_0.dynamicNormalContent_)
		elseif ProfileDecorateItemCfg[var_31_0].item_type == 3 then
			var_31_1 = DynamicPortraitPool.GetInstance():GetFrame(var_31_2, arg_31_0.dynamicNormalContent_)
		elseif ProfileDecorateItemCfg[var_31_0].item_type == 1 then
			var_31_1 = DynamicPortraitPool.GetInstance():GetCardBg(var_31_2, arg_31_0.dynamicNormalContent_)
			var_31_1.transform.anchoredPosition = Vector3.New(-40, 0, 0)
		end
	elseif ChatBubbleCfg[var_31_0] and ChatBubbleCfg[var_31_0].type == 2 then
		SetActive(arg_31_0.dynamicBubbleContent_.gameObject, true)
		SetActive(arg_31_0.dynamicNormalContent_.gameObject, false)

		var_31_2 = tonumber(ChatBubbleCfg[var_31_0].image1)
		var_31_1 = DynamicPortraitPool.GetInstance():GetBubble(var_31_2, arg_31_0.dynamicBubbleContent_)
		arg_31_0.dynamicBubbleImg_.color = LuaHelper.StringToColor("#" .. ChatBubbleCfg[var_31_0].color2)

		arg_31_0.dynamicBubbleImg_.transform:SetAsLastSibling()
	end

	arg_31_0.dynamicImageID_ = var_31_2
	arg_31_0.dynamicName_ = var_31_0
	arg_31_0.dynamicObj_ = var_31_1
end

function var_0_0.RefreshItemShow(arg_32_0)
	if arg_32_0:CheckIsDynamic() then
		SetActive(arg_32_0.commonItem_, false)
		SetActive(arg_32_0.dynamicContent_.gameObject, true)
		arg_32_0:RefreshDynamicItem()
		arg_32_0:RefreshCommonItem()
	else
		SetActive(arg_32_0.commonItem_, true)
		SetActive(arg_32_0.dynamicContent_.gameObject, false)
		arg_32_0:DestroyDynamic()
		arg_32_0:RefreshCommonItem()
	end
end

function var_0_0.DestroyDynamic(arg_33_0)
	if not isNil(arg_33_0.dynamicObj_) then
		if ProfileDecorateItemCfg[arg_33_0.dynamicName_] then
			if ProfileDecorateItemCfg[arg_33_0.dynamicName_].item_type == 2 then
				DynamicPortraitPool.GetInstance():ReturnHead(arg_33_0.dynamicImageID_, arg_33_0.dynamicObj_)
			elseif ProfileDecorateItemCfg[arg_33_0.dynamicName_].item_type == 3 then
				DynamicPortraitPool.GetInstance():ReturnFrame(arg_33_0.dynamicImageID_, arg_33_0.dynamicObj_)
			elseif ProfileDecorateItemCfg[arg_33_0.dynamicName_].item_type == 1 then
				DynamicPortraitPool.GetInstance():ReturnCardBg(arg_33_0.dynamicImageID_, arg_33_0.dynamicObj_)
			end
		elseif ChatBubbleCfg[arg_33_0.dynamicName_] then
			DynamicPortraitPool.GetInstance():ReturnBubble(arg_33_0.dynamicImageID_, arg_33_0.dynamicObj_)
		end
	end

	arg_33_0.dynamicImageID_ = nil
	arg_33_0.dynamicName_ = nil
	arg_33_0.dynamicObj_ = nil
end

function var_0_0.RefreshCommonItem(arg_34_0, arg_34_1)
	if not arg_34_0.commonItemView_ then
		arg_34_0.commonItemView_ = CommonItemView.New(arg_34_0.commonItem_)
	end

	arg_34_0.itemInfo_.animatorType = ItemConst.ITEM_ANIMATOR_TYPE.NULL

	arg_34_0.commonItemView_:SetData(arg_34_0.itemInfo_)
	arg_34_0.commonItemView_:RefreshBottomRightText(true)
	arg_34_0.commonItemView_.rareController_:SetSelectedState("off")
	arg_34_0:UpdateIcon()

	local var_34_0 = ItemCfg[arg_34_0:GetItemID()]

	if var_34_0 and ItemConst.ITEM_TYPE.HERO == var_34_0.type then
		-- block empty
	end

	local var_34_1 = ItemCfg[arg_34_0.itemInfo_.id]

	if var_34_1 then
		local var_34_2 = var_34_1.display_rare or 0

		arg_34_0.bgController:SetSelectedState("state" .. tostring(var_34_2))
	end
end

function var_0_0.UpdateIcon(arg_35_0)
	arg_35_0.itemImg_.sprite = ItemTools.getItemSprite(arg_35_0:GetItemID())
end

function var_0_0.SetCommonItem(arg_36_0, arg_36_1)
	arg_36_0.itemInfo_.num = arg_36_1

	arg_36_0:RefreshItemShow()
end

function var_0_0.RefreshCount(arg_37_0)
	local var_37_0 = arg_37_0:GetItemID()
	local var_37_1 = arg_37_0.itemInfo_
	local var_37_2

	if arg_37_0.extraInfo_.overrideShowTotalCnt then
		var_37_2 = arg_37_0.extraInfo_.overrideShowTotalCnt
	elseif arg_37_0.extraInfo_.onlyShowCntByItemInfo then
		var_37_2 = var_37_1.number or 0
	elseif arg_37_0.extraInfo_.showTotalCntIgnoreTimeValid then
		var_37_2 = ItemTools.getItemTotalNumIgnoreTimeValid(var_37_0)
	else
		local var_37_3 = ItemTools.GetItemExpiredTimeByInfo(var_37_1)

		var_37_2 = ItemTools.getItemNum(var_37_0, var_37_3)

		if not MaterialData:IsItemHaveServeTick(arg_37_0.itemInfo_.id) then
			var_37_2 = ItemTools.getItemNum(var_37_0)
		end
	end

	arg_37_0.cntText_.text = NumberTools.RetractNumberForWindBar(var_37_2)
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

function var_0_0.ShouldHideOwnedTotalCount(arg_39_0)
	local var_39_0 = ItemCfg[arg_39_0:GetItemID()]
	local var_39_1 = var_39_0.type
	local var_39_2 = var_39_0.sub_type

	return nullable(var_0_5, var_39_1, var_39_2) or false
end

function var_0_0.RefreshOwnedTotalCount(arg_40_0)
	local var_40_0 = arg_40_0.itemInfo_ and arg_40_0.itemInfo_.isHideNum_ or false

	var_40_0 = var_40_0 or arg_40_0:GetIsHideCurrency(arg_40_0:GetItemID())

	if arg_40_0:ShouldHideOwnedTotalCount() or var_40_0 then
		SetActive(arg_40_0.cntPanel_, false)
	else
		SetActive(arg_40_0.cntPanel_, true)
	end
end

function var_0_0.GetIsHideCurrency(arg_41_0, arg_41_1)
	if arg_41_0.hideCurrencyList == nil then
		arg_41_0.hideCurrencyList = {}

		for iter_41_0, iter_41_1 in pairs(CurrencyIdMapCfg) do
			if iter_41_1.hide_number == 1 then
				table.insert(arg_41_0.hideCurrencyList, iter_41_1.item_id)
			end
		end
	end

	return table.indexof(arg_41_0.hideCurrencyList, arg_41_1)
end

function var_0_0.ShowInfo(arg_42_0)
	arg_42_0.tabControllerController:SetSelectedState("descripe")
end

function var_0_0.OnExitInput(arg_43_0)
	arg_43_0:Back()

	return true
end

return var_0_0
