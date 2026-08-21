local var_0_0 = class("ShopBuyView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Common/Pop/showpopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.useNumTriggerListener_ = arg_5_0.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	arg_5_0.bgController = arg_5_0.controller_:GetController("bg")
	arg_5_0.groupController = arg_5_0.controller_:GetController("group")
	arg_5_0.timeController = arg_5_0.controller_:GetController("time")
	arg_5_0.viewController = arg_5_0.controller_:GetController("view")
	arg_5_0.starController = arg_5_0.controller_:GetController("star")
	arg_5_0.ndtabController = arg_5_0.controller_:GetController("ndtab")
	arg_5_0.consumeController = arg_5_0.controller_:GetController("consume")
	arg_5_0.furnitureController = arg_5_0.controller_:GetController("Furniture")
	arg_5_0.furnitureViewController = arg_5_0.controller_:GetController("viewBtn")
	arg_5_0.furnitureShopController = arg_5_0.controller_:GetController("btnView")
	arg_5_0.commonItem1 = CommonItemView.New(arg_5_0.revertItemGo_)
	arg_5_0.commonItem2 = CommonItemView.New(arg_5_0.revertedItemGo_)
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListener(arg_6_0.tipGo_, nil, function()
		local var_7_0 = ItemCfg[arg_6_0.shopCfg.give_id].type

		if var_7_0 == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			JumpTools.OpenPageByJump("/showServantView", {
				state = "onlydetail",
				id = arg_6_0.shopCfg.give_id
			})
			OperationRecorder.Record("ShopItemView", "ExplaintBut")
		elseif var_7_0 == ItemConst.ITEM_TYPE.EQUIP then
			ShowPopItem(POP_SOURCE_ITEM, {
				arg_6_0.shopCfg.give_id,
				1
			}, nil)
			OperationRecorder.Record("ShopItemView", "ExplaintBut")
		elseif var_7_0 == ItemConst.ITEM_TYPE.SCENE then
			JumpTools.OpenPageByJump("/skinDlcShow", {
				goodId = arg_6_0.goodID
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.furnitureViewBtn_, nil, function()
		if BackHomeDataManager:IsInDormSystem() then
			local var_8_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")

			if not var_8_0 then
				local var_8_1 = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))

				var_8_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")
			end

			local var_8_2 = var_8_0.m_DefaultBlend

			var_8_0.m_DefaultBlend = DanceGameController.cut

			JumpTools.OpenPageByJump("/furniturePreview", {
				furID = arg_6_0.shopCfg.give_id,
				cacheBlend = var_8_2
			})
		else
			JumpTools.OpenPageByJump("/furniturePreviewWithEntity", {
				furID = arg_6_0.shopCfg.give_id
			})
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.furnitureShopBtn_, nil, function()
		local var_9_0 = ItemCfg[arg_6_0.shopCfg.give_id]
		local var_9_1 = arg_6_0.shopCfg.give_id

		if var_9_0.type == ItemConst.ITEM_TYPE.DORM_FURNITURE then
			if BackHomeDataManager:IsInDormSystem() then
				local var_9_2 = manager.ui.mainCamera:GetComponent("CinemachineBrain")

				if not var_9_2 then
					local var_9_3 = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))

					var_9_2 = manager.ui.mainCamera:GetComponent("CinemachineBrain")
				end

				local var_9_4 = var_9_2.m_DefaultBlend

				var_9_2.m_DefaultBlend = DanceGameController.cut

				JumpTools.OpenPageByJump("/furniturePreview", {
					furID = var_9_1,
					cacheBlend = var_9_4
				})
			else
				JumpTools.OpenPageByJump("/furniturePreviewWithEntity", {
					furID = var_9_1
				})
			end
		elseif var_9_0.type == ItemConst.ITEM_TYPE.FURNITURE_SUIT then
			local var_9_5, var_9_6 = DormSuitData:CheckIsSuit(var_9_1)
			local var_9_7 = DormData:GetCurrectSceneID()

			if var_9_6 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
				JumpTools.OpenPageByJump("/dormSuitFurBgView", {
					suitID = var_9_1,
					shopID = arg_6_0.shopId
				})
			elseif var_9_6 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
				JumpTools.OpenPageByJump("dormPartSuitInfoPopView", {
					suitID = var_9_1
				})
			end
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.bgBtn_, nil, function()
		arg_6_0:Back()
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.addBtn_.gameObject, 3, 0.5, 0.2, function()
		arg_6_0.selectNum_ = math.min(arg_6_0.selectNum_ + 1, arg_6_0:GetMaxBuyNum())

		arg_6_0:RefreshNum()

		arg_6_0.useNumSlider_.value = arg_6_0.selectNum_
	end)
	arg_6_0:AddPressingByTimeListener(arg_6_0.delBtn_.gameObject, 3, 0.5, 0.2, function()
		arg_6_0.selectNum_ = math.max(arg_6_0.selectNum_ - 1, 1)

		arg_6_0:RefreshNum()

		arg_6_0.useNumSlider_.value = arg_6_0.selectNum_
	end)
	arg_6_0:AddBtnListener(arg_6_0.maxBtn_, nil, function()
		arg_6_0.selectNum_ = arg_6_0:GetMaxBuyNum()
		arg_6_0.useNumSlider_.value = arg_6_0:GetMaxBuyNum()
	end)
	arg_6_0.useNumSlider_.onValueChanged:AddListener(function()
		arg_6_0.selectNum_ = arg_6_0.useNumSlider_.value
		arg_6_0.selectNum_ = Mathf.Clamp(arg_6_0.selectNum_, 1, arg_6_0:GetMaxBuyNum())
		arg_6_0.useNumSlider_.value = arg_6_0.selectNum_

		arg_6_0:RefreshNum()
	end)
	arg_6_0.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		arg_6_0:RefreshNum()

		arg_6_0.useNumSlider_.value = arg_6_0.selectNum_

		OperationRecorder.Record("shop", "shop_number_slide")
	end))
	arg_6_0:AddBtnListener(arg_6_0.okBtn_, nil, function()
		local var_16_0 = arg_6_0.goodInfo
		local var_16_1 = arg_6_0.shopCfg
		local var_16_2 = ShopListCfg[var_16_1.shop_id]
		local var_16_3, var_16_4 = ShopTools.IsShopSuspended(var_16_1.shop_id)

		if var_16_3 then
			ShowTips(var_16_4)

			return
		end

		local var_16_5 = ItemCfg[var_16_1.give_id]

		if var_16_5.type == ItemConst.ITEM_TYPE.HERO_PIECE or var_16_5.type == ItemConst.ITEM_TYPE.HERO then
			local var_16_6 = var_16_5.id % 10000
			local var_16_7 = HeroData:GetHeroOmegaNeedPiece(var_16_6)

			if var_16_1.shop_id == ShopConst.SHOP_ID.REPORT_SHOP and var_16_7 <= 0 then
				ShowTips("OMEGA_ENOUGH_TIP")

				return
			end

			if not _G.SkipTip.ShopOmega and var_16_7 < arg_6_0.selectNum_ then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("SHOP_OMEGA_CONFIRMATION"),
					OkCallback = function()
						_G.SkipTip.ShopOmega = arg_6_0.ShopOmega_

						ShopAction.BuyItem({
							{
								goodID = var_16_0.id,
								buyNum = arg_6_0.selectNum_
							}
						})
					end,
					ToggleCallback = function(arg_18_0)
						arg_6_0.ShopOmega_ = arg_18_0
					end
				})

				return
			end
		end

		local var_16_8 = SettingData:GetRemindSettingData()
		local var_16_9 = var_16_1.cost_id

		if not _G.SkipTip.SkipDiamondBuyItemTip and var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id and var_16_8.diamond_buy_item_reminder == 1 or not _G.SkipTip.SkipCoreEquipBuyItemTip and var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id and var_16_8.core_equip_buy_item_reminder == 1 or not _G.SkipTip.SkipInfoBadageTopBuyItemTip and var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id and var_16_8.info_badge_top_buy_item_reminder == 1 or not _G.SkipTip.SkipBossChangeSBuyItemTip and var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id and var_16_8.boss_challenge_s_buy_item_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), ItemTools.getItemName(var_16_9), arg_6_0.cost_, ItemTools.getItemName(var_16_5.id), arg_6_0.selectNum_),
				OkCallback = function()
					if var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id then
						_G.SkipTip.SkipDiamondBuyItemTip = arg_6_0.SkipDiamondBuyItemTip_
					elseif var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id then
						_G.SkipTip.SkipCoreEquipBuyItemTip = arg_6_0.SkipCoreEquipBuyItemTip_
					elseif var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id then
						_G.SkipTip.SkipInfoBadageTopBuyItemTip = arg_6_0.SkipInfoBadageTopBuyItemTip_
					elseif var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id then
						_G.SkipTip.SkipBossChangeSBuyItemTip = arg_6_0.SkipBossChangeSBuyItemTip_
					end

					ShopAction.BuyItem({
						{
							goodID = var_16_0.id,
							buyNum = arg_6_0.selectNum_
						}
					})
				end,
				ToggleCallback = function(arg_20_0)
					if var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id then
						arg_6_0.SkipDiamondBuyItemTip_ = arg_20_0
					elseif var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id then
						arg_6_0.SkipCoreEquipBuyItemTip_ = arg_20_0
					elseif var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id then
						arg_6_0.SkipInfoBadageTopBuyItemTip_ = arg_20_0
					elseif var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id then
						arg_6_0.SkipBossChangeSBuyItemTip_ = arg_20_0
					end
				end
			})
		elseif var_16_9 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), ItemTools.getItemName(var_16_9), arg_6_0.cost_, ItemTools.getItemName(var_16_5.id), arg_6_0.selectNum_),
				OkCallback = function()
					ShopAction.BuyItem({
						{
							goodID = var_16_0.id,
							buyNum = arg_6_0.selectNum_
						}
					})
				end
			})
		elseif var_16_5.type == ItemConst.ITEM_TYPE.SCENE and HomeSceneSettingCfg[var_16_5.param[1]].limit_display == 0 then
			local var_16_10 = true
			local var_16_11

			for iter_16_0, iter_16_1 in ipairs(SkinSceneActionCfg.all) do
				local var_16_12 = SkinSceneActionCfg[iter_16_1]

				if var_16_12.special_scene_id == var_16_5.param[1] then
					var_16_11 = var_16_12.skin_id

					if ShopTools.HaveSkin(var_16_11) or HeroTools.CanChangeSkin(var_16_11) then
						var_16_10 = true

						break
					end

					var_16_10 = false

					break
				end
			end

			if var_16_10 then
				ShopAction.BuyItem({
					{
						goodID = var_16_0.id,
						buyNum = arg_6_0.selectNum_
					}
				})
			else
				local var_16_13 = SkinCfg[var_16_11]

				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTipsF("BUY_SCENE_NOT_HAVE_HERO_SKIN_CONFIRM", GetI18NText(var_16_13.name), ItemTools.getItemName(var_16_5.id)),
					OkCallback = function()
						ShopAction.BuyItem({
							{
								goodID = var_16_0.id,
								buyNum = arg_6_0.selectNum_
							}
						})
					end
				})
			end
		else
			ShopAction.BuyItem({
				{
					goodID = var_16_0.id,
					buyNum = arg_6_0.selectNum_
				}
			})
		end
	end)
end

function var_0_0.OnShopBuyResult(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_1 == 0 then
		local var_23_0 = getShopCfg(arg_23_2)
		local var_23_1 = var_23_0.give_id
		local var_23_2 = var_23_0.give
		local var_23_3 = ItemCfg[var_23_1].type

		arg_23_0:Back()

		if var_23_3 == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					num = 1,
					id = var_23_1
				}
			})
		elseif var_23_3 == ItemConst.ITEM_TYPE.EQUIP and EquipData:GetEquipBagFull() then
			showEquipSendMail(nil)
			EquipAction.EquipBagFull(false)
		end
	end
end

function var_0_0.AddEventListeners(arg_24_0)
	arg_24_0:RegistEventListener(SHOP_LIST_UPDATE, function(arg_25_0)
		if arg_25_0 == 0 or arg_24_0.shopId == arg_25_0 then
			arg_24_0:RefreshUI()
			arg_24_0:UpdateBarByGoodId()
		end
	end)
	arg_24_0:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_26_0)
		arg_24_0:RefreshUI()
		arg_24_0:UpdateBarByGoodId()
	end)
	arg_24_0:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_27_0, arg_27_1)
		if arg_24_0.shopId ~= arg_27_0 then
			return
		end

		arg_24_0:RefreshUI()
		arg_24_0:UpdateBarByGoodId()
	end)
end

function var_0_0.RefreshUI(arg_28_0)
	arg_28_0.useNumSlider_.minValue = 0
	arg_28_0.useNumSlider_.maxValue = arg_28_0:GetMaxBuyNum()

	arg_28_0.groupController:SetSelectedState("false")

	local var_28_0 = arg_28_0.shopCfg
	local var_28_1 = ItemCfg[var_28_0.give_id]

	SetActive(arg_28_0.heroIcon_, false)
	SetActive(arg_28_0.commonIconGo_, true)
	SetActive(arg_28_0.ownGo_, ShopTools.CheckGoodsOwen(arg_28_0.goodID))

	if var_28_1.type == ItemConst.ITEM_TYPE.EQUIP or var_28_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_28_0.starController:SetSelectedState(var_28_1.rare)
	elseif var_28_1.type == ItemConst.ITEM_TYPE.HERO then
		arg_28_0.starController:SetSelectedState("0")
		arg_28_0.groupController:SetSelectedState("true")

		arg_28_0.campIcon_.sprite = HeroTools.GetHeroRaceIcon(var_28_0.give_id)
		arg_28_0.itemIcon_.sprite = ItemTools.getItemSprite(var_28_0.give_id)

		SetActive(arg_28_0.heroIcon_, true)
		SetActive(arg_28_0.commonIconGo_, false)
	else
		arg_28_0.starController:SetSelectedState("0")
	end

	arg_28_0.bgController:SetSelectedState(tostring(var_28_1.display_rare))
	arg_28_0.ndtabController:SetSelectedState("off")
	arg_28_0.viewController:SetSelectedState(tostring(var_28_1.type == ItemConst.ITEM_TYPE.EQUIP or var_28_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT or var_28_1.type == ItemConst.ITEM_TYPE.SCENE))

	local var_28_2 = not manager.windowBar:GetWhereTag() == "qworld"

	if var_28_1.type == ItemConst.ITEM_TYPE.DORM_FURNITURE and var_28_2 then
		arg_28_0.furnitureViewController:SetSelectedState("on")
	else
		arg_28_0.furnitureViewController:SetSelectedState("off")

		local var_28_3 = manager.windowBar:GetWhereTag() == "dorm"

		if (var_28_1.type == ItemConst.ITEM_TYPE.DORM_FURNITURE or var_28_1.type == ItemConst.ITEM_TYPE.FURNITURE_SUIT) and var_28_3 then
			arg_28_0.furnitureShopController:SetSelectedState("on")
		else
			arg_28_0.furnitureShopController:SetSelectedState("off")
		end
	end

	if var_28_1.type == ItemConst.ITEM_TYPE.EQUIP then
		arg_28_0.haveNumText_.text = NumberTools.RetractNumber(#EquipTools.GetEquipListByEquipid(var_28_0.give_id))
	elseif var_28_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		arg_28_0.haveNumText_.text = NumberTools.RetractNumber(#(WeaponServantData:GetWeaponServantById(var_28_0.give_id) or {}))
	else
		arg_28_0.haveNumText_.text = NumberTools.RetractNumber(ItemTools.getItemNum(var_28_0.give_id))
	end

	arg_28_0.commonIcon_.sprite = ItemTools.getItemSprite(var_28_0.give_id)
	arg_28_0.discountTxt_.text = ShopTools.GetDiscountLabel(arg_28_0.goodID)

	local var_28_4, var_28_5, var_28_6 = ShopTools.IsOnDiscountArea(arg_28_0.goodID)

	if var_28_4 and var_28_6 then
		arg_28_0.ndtabController:SetSelectedState("discount")
	end

	if arg_28_0.shopCfg.tag == ShopConst.TAGS.NEW then
		arg_28_0.ndtabController:SetSelectedState("new")
	end

	if var_28_4 and var_28_6 and arg_28_0.shopCfg.tag == ShopConst.TAGS.NEW then
		arg_28_0.ndtabController:SetSelectedState("all")
	end

	arg_28_0.nameText_.text = ItemTools.getItemName(var_28_1.id)
	arg_28_0.descText_.text = ItemTools.getItemDesc(var_28_1.id)

	arg_28_0:RefreshNum()

	arg_28_0.useNumSlider_.value = arg_28_0.selectNum_
	arg_28_0.costIcon_.sprite = ItemTools.getItemLittleSprite(var_28_0.cost_id)

	SetActive(arg_28_0.limitGo_, arg_28_0:IsLimit())

	if arg_28_0:IsLimit() then
		if arg_28_0.shopCfg.shop_refresh == 1 then
			arg_28_0.limitText_.text = GetTips(ShopConst.SHOP_LIMIT_TEXT[var_28_0.refresh_cycle]) .. arg_28_0:GetRestNum() .. "/" .. arg_28_0:GetLimitNum()
		else
			arg_28_0.limitText_.text = GetTips("PURCHASE_LIMIT") .. arg_28_0:GetRestNum() .. "/" .. arg_28_0:GetLimitNum()
		end
	end
end

function var_0_0.UpdateDormLabel(arg_29_0)
	if BackHomeFurniture[arg_29_0.shopCfg.give_id] then
		local var_29_0 = ""
		local var_29_1 = BackHomeFurniture[arg_29_0.shopCfg.give_id].scene_id

		for iter_29_0, iter_29_1 in ipairs(var_29_1) do
			var_29_0 = var_29_0 .. DormTools:GetRoomTypeName(iter_29_1) .. " "
		end

		arg_29_0.dormRangeTxt_.text = var_29_0
		arg_29_0.dormLimitTxt_.text = DormTools:GetFurGiftMaxDesc(arg_29_0.shopCfg.give_id)
		arg_29_0.comfortableTxt_.text = DormTools:GetFurComfortDesc(arg_29_0.shopCfg.give_id)
		arg_29_0.dormTypeTxt_.text = DormTools:GetFurGiftTypeDesc(arg_29_0.shopCfg.give_id)
	else
		arg_29_0.dormTypeTxt_.text = ""
		arg_29_0.dormRangeTxt_.text = ""
		arg_29_0.dormLimitTxt_.text = ""
		arg_29_0.comfortableTxt_.text = ""
	end
end

function var_0_0.GetLabelList(arg_30_0, arg_30_1)
	if BackHomeFurniture[arg_30_1] then
		return DormTools:GetFurLable(arg_30_1)
	end
end

function var_0_0.RefreshRevert(arg_31_0)
	local var_31_0, var_31_1 = ShopTools.rewertReward(arg_31_0.goodID, arg_31_0.selectNum_)
	local var_31_2 = arg_31_0.shopCfg.give_id

	if #var_31_1 ~= 0 then
		arg_31_0.furnitureController:SetSelectedState("transformation")
	elseif DormFurnitureTools:CheckFurShowExtendLable(var_31_2) then
		arg_31_0.furnitureController:SetSelectedState("true")
		arg_31_0:UpdateDormLabel()
	else
		arg_31_0.furnitureController:SetSelectedState("false")
	end

	if #var_31_1 ~= 0 then
		CommonTools.SetCommonData(arg_31_0.commonItem1, {
			id = var_31_0[1].id,
			number = var_31_0[1].num,
			clickFun = function()
				ShowPopItem(POP_ITEM, {
					id = var_31_0[1].id,
					number = var_31_0[1].num
				})
			end
		})
		CommonTools.SetCommonData(arg_31_0.commonItem2, {
			id = var_31_1[1].id,
			number = var_31_1[1].num,
			clickFun = function()
				ShowPopItem(POP_ITEM, {
					id = var_31_1[1].id,
					number = var_31_1[1].num
				})
			end
		})
	end
end

function var_0_0.RefreshNum(arg_34_0)
	arg_34_0.useNumText_.text = GetTips("DORM_CAN_BUY_NUM") .. "：" .. arg_34_0.selectNum_

	arg_34_0:RefreshRevert()

	local var_34_0, var_34_1 = ShopTools.GetPrice(arg_34_0.goodInfo.id)

	if var_34_0 == 0 then
		arg_34_0.consumeController:SetSelectedState("free")
	else
		arg_34_0.originPriceTxt_.text = var_34_1 * arg_34_0.selectNum_

		arg_34_0.consumeController:SetSelectedState(var_34_1 == var_34_0 and "normal" or "discount")
	end

	arg_34_0.cost_ = var_34_0 * arg_34_0.selectNum_
	arg_34_0.totalCostText_.text = arg_34_0.cost_

	if ItemTools.getItemNum(arg_34_0.shopCfg.cost_id) < arg_34_0.cost_ then
		arg_34_0.totalCostText_.text = "<color=#FF000B>" .. arg_34_0.cost_ .. "</color>"
	end

	local var_34_2 = arg_34_0:GetMaxBuyNum()

	arg_34_0.addBtn_.interactable = var_34_2 > arg_34_0.selectNum_
	arg_34_0.delBtn_.interactable = arg_34_0.selectNum_ > 1
end

function var_0_0.GetLimitNum(arg_35_0)
	if arg_35_0.shopCfg.limit_num and arg_35_0.shopCfg.limit_num ~= -1 then
		return arg_35_0.shopCfg.limit_num
	end

	return -1
end

function var_0_0.GetRestNum(arg_36_0)
	if arg_36_0:IsLimit() then
		return arg_36_0:GetLimitNum() - arg_36_0.goodInfo.buyTime
	end

	return -1
end

function var_0_0.IsLimit(arg_37_0)
	if arg_37_0.shopCfg.limit_num and arg_37_0.shopCfg.limit_num ~= -1 then
		return true
	end

	return false
end

function var_0_0.GetMaxBuyNum(arg_38_0)
	local var_38_0 = arg_38_0.shopCfg
	local var_38_1 = ShopTools.GetPrice(arg_38_0.goodInfo.id)
	local var_38_2 = ItemCfg[var_38_0.give_id]
	local var_38_3 = -1

	if var_38_0.limit_num and var_38_0.limit_num ~= -1 then
		var_38_3 = var_38_0.limit_num - arg_38_0.goodInfo.buyTime

		local var_38_4 = ItemTools.getItemNum(arg_38_0.shopCfg.cost_id)
		local var_38_5 = math.max(math.floor(var_38_4 / var_38_1), 1)

		return math.min(var_38_3, var_38_5)
	end

	local var_38_6 = 99999

	if var_38_2.type == ItemConst.ITEM_TYPE.HERO_PIECE and var_38_0.shop_id == ShopConst.SHOP_ID.REPORT_SHOP then
		local var_38_7 = var_38_2.id - 10000
		local var_38_8 = HeroData:GetHeroOmegaNeedPiece(var_38_7)

		var_38_3 = math.max(var_38_8, 1)
	end

	local var_38_9 = ItemTools.getItemNum(arg_38_0.shopCfg.cost_id)
	local var_38_10 = math.max(math.floor(var_38_9 / var_38_1), 1)

	if var_38_3 < var_38_10 and var_38_3 ~= -1 then
		return var_38_3
	else
		return var_38_10 < 1 and 1 or var_38_10
	end
end

function var_0_0.Init(arg_39_0)
	arg_39_0:InitUI()
	arg_39_0:AddUIListener()
end

function var_0_0.OnTop(arg_40_0)
	arg_40_0:RefreshUI()
	arg_40_0:UpdateBarByGoodId()
	manager.windowBar:SetAsLastSibling()
end

function var_0_0.OnEnter(arg_41_0)
	arg_41_0.goodInfo = arg_41_0.params_.goodInfo
	arg_41_0.shopId = arg_41_0.goodInfo.shopId
	arg_41_0.goodID = arg_41_0.goodInfo.id
	arg_41_0.shopCfg = getShopCfg(arg_41_0.goodInfo.id)
	arg_41_0.useNumSlider_.value = 1
	arg_41_0.selectNum_ = 1

	arg_41_0:AddEventListeners()
end

function var_0_0.UpdateBarByGoodId(arg_42_0)
	local var_42_0 = {}

	if arg_42_0.shopCfg.cost_id then
		table.insert(var_42_0, arg_42_0.shopCfg.cost_id)
	end

	manager.windowBar:SwitchBar(var_42_0)

	for iter_42_0 = 1, #var_42_0 do
		manager.windowBar:SetBarCanAdd(var_42_0[iter_42_0], ShopConst.ADD_CURRENCY[var_42_0[iter_42_0]] == true)
	end
end

function var_0_0.Dispose(arg_43_0)
	arg_43_0.useNumSlider_.onValueChanged:RemoveAllListeners()
	arg_43_0.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	arg_43_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_43_0)
	arg_43_0.commonItem1:Dispose()

	arg_43_0.commonItem1 = nil

	arg_43_0.commonItem2:Dispose()

	arg_43_0.commonItem2 = nil
end

function var_0_0.OnExitInput(arg_44_0)
	JumpTools.Back()

	return true
end

return var_0_0
