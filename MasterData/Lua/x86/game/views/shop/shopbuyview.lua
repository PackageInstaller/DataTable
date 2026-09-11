local ShopBuyView = class("ShopBuyView", ReduxView)

function ShopBuyView:UIName()
	return "Widget/Common/Pop/showpopUI"
end

function ShopBuyView:UIParent()
	return manager.ui.uiPop.transform
end

function ShopBuyView:OnCtor()
	return
end

function ShopBuyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ShopBuyView:InitUI()
	self:BindCfgUI()

	self.useNumTriggerListener_ = self.useNumSliderGo_.transform:GetComponent(typeof(EventTriggerListener))
	self.bgController = self.controller_:GetController("bg")
	self.groupController = self.controller_:GetController("group")
	self.timeController = self.controller_:GetController("time")
	self.viewController = self.controller_:GetController("view")
	self.starController = self.controller_:GetController("star")
	self.ndtabController = self.controller_:GetController("ndtab")
	self.consumeController = self.controller_:GetController("consume")
	self.furnitureController = self.controller_:GetController("Furniture")
	self.furnitureViewController = self.controller_:GetController("viewBtn")
	self.furnitureShopController = self.controller_:GetController("btnView")
	self.commonItem1 = CommonItemView.New(self.revertItemGo_)
	self.commonItem2 = CommonItemView.New(self.revertedItemGo_)
end

function ShopBuyView:AddUIListener()
	self:AddBtnListener(self.tipGo_, nil, function()
		if ItemCfg[self.shopCfg.give_id].type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
			JumpTools.OpenPageByJump("/showServantView", {
				state = "onlydetail",
				id = self.shopCfg.give_id
			})
			OperationRecorder.Record("ShopItemView", "ExplaintBut")
		elseif ItemCfg[self.shopCfg.give_id].type == ItemConst.ITEM_TYPE.EQUIP then
			ShowPopItem(POP_SOURCE_ITEM, {
				self.shopCfg.give_id,
				1
			}, nil)
			OperationRecorder.Record("ShopItemView", "ExplaintBut")
		elseif ItemCfg[self.shopCfg.give_id].type == ItemConst.ITEM_TYPE.SCENE then
			JumpTools.OpenPageByJump("/skinDlcShow", {
				goodId = self.goodID
			})
		end
	end)
	self:AddBtnListener(self.furnitureViewBtn_, nil, function()
		if BackHomeDataManager:IsInDormSystem() then
			local var_8_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")

			if not var_8_0 then
				local var_8_1 = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))

				var_8_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")
			end

			local var_8_2 = var_8_0.m_DefaultBlend

			var_8_0.m_DefaultBlend = DanceGameController.cut

			JumpTools.OpenPageByJump("/furniturePreview", {
				furID = self.shopCfg.give_id,
				cacheBlend = var_8_2
			})
		else
			JumpTools.OpenPageByJump("/furniturePreviewWithEntity", {
				furID = self.shopCfg.give_id
			})
		end
	end)
	self:AddBtnListener(self.furnitureShopBtn_, nil, function()
		if ItemCfg[self.shopCfg.give_id].type == ItemConst.ITEM_TYPE.DORM_FURNITURE then
			if BackHomeDataManager:IsInDormSystem() then
				local var_9_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")

				if not var_9_0 then
					local var_9_1 = manager.ui:AddMainCameraCom(typeof(CinemachineBrain))

					var_9_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")
				end

				local var_9_2 = var_9_0.m_DefaultBlend

				var_9_0.m_DefaultBlend = DanceGameController.cut

				JumpTools.OpenPageByJump("/furniturePreview", {
					furID = self.shopCfg.give_id,
					cacheBlend = var_9_2
				})
			else
				JumpTools.OpenPageByJump("/furniturePreviewWithEntity", {
					furID = self.shopCfg.give_id
				})
			end
		elseif ItemCfg[self.shopCfg.give_id].type == ItemConst.ITEM_TYPE.FURNITURE_SUIT then
			local var_9_3, var_9_4 = DormSuitData:CheckIsSuit(self.shopCfg.give_id)
			local var_9_5 = DormData:GetCurrectSceneID()

			if var_9_4 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
				JumpTools.OpenPageByJump("/dormSuitFurBgView", {
					suitID = self.shopCfg.give_id,
					shopID = self.shopId
				})
			elseif var_9_4 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
				JumpTools.OpenPageByJump("dormPartSuitInfoPopView", {
					suitID = self.shopCfg.give_id
				})
			end
		end
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
	self:AddPressingByTimeListener(self.addBtn_.gameObject, 3, 0.5, 0.2, function()
		self.selectNum_ = math.min(self.selectNum_ + 1, self:GetMaxBuyNum())

		self:RefreshNum()

		self.useNumSlider_.value = self.selectNum_
	end)
	self:AddPressingByTimeListener(self.delBtn_.gameObject, 3, 0.5, 0.2, function()
		self.selectNum_ = math.max(self.selectNum_ - 1, 1)

		self:RefreshNum()

		self.useNumSlider_.value = self.selectNum_
	end)
	self:AddBtnListener(self.maxBtn_, nil, function()
		self.selectNum_ = self:GetMaxBuyNum()
		self.useNumSlider_.value = self:GetMaxBuyNum()
	end)
	self.useNumSlider_.onValueChanged:AddListener(function()
		self.selectNum_ = self.useNumSlider_.value
		self.selectNum_ = Mathf.Clamp(self.selectNum_, 1, self:GetMaxBuyNum())
		self.useNumSlider_.value = self.selectNum_

		self:RefreshNum()
	end)
	self.useNumTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(function(arg_15_0, arg_15_1)
		self:RefreshNum()

		self.useNumSlider_.value = self.selectNum_

		OperationRecorder.Record("shop", "shop_number_slide")
	end))
	self:AddBtnListener(self.okBtn_, nil, function()
		local var_16_0 = self.goodInfo
		local var_16_1 = self.shopCfg
		local var_16_3, var_16_4 = ShopTools.IsShopSuspended(self.shopCfg.shop_id)

		if var_16_3 then
			ShowTips(var_16_4)

			return
		end

		local var_16_5 = ItemCfg[var_16_1.give_id]

		if ItemCfg[var_16_1.give_id].type == ItemConst.ITEM_TYPE.HERO_PIECE or var_16_5.type == ItemConst.ITEM_TYPE.HERO then
			local var_16_6 = HeroData:GetHeroOmegaNeedPiece(var_16_5.id % 10000)

			if var_16_1.shop_id == ShopConst.SHOP_ID.REPORT_SHOP and var_16_6 <= 0 then
				ShowTips("OMEGA_ENOUGH_TIP")

				return
			end

			if not _G.SkipTip.ShopOmega and var_16_6 < self.selectNum_ then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("SHOP_OMEGA_CONFIRMATION"),
					OkCallback = function()
						_G.SkipTip.ShopOmega = self.ShopOmega_

						ShopAction.BuyItem({
							{
								goodID = var_16_0.id,
								buyNum = self.selectNum_
							}
						})
					end,
					ToggleCallback = function(arg_18_0)
						self.ShopOmega_ = arg_18_0
					end
				})

				return
			end
		end

		local var_16_7 = SettingData:GetRemindSettingData()
		local var_16_8 = var_16_1.cost_id

		if not _G.SkipTip.SkipDiamondBuyItemTip and var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id and var_16_7.diamond_buy_item_reminder == 1 or not _G.SkipTip.SkipCoreEquipBuyItemTip and var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id and var_16_7.core_equip_buy_item_reminder == 1 or not _G.SkipTip.SkipInfoBadageTopBuyItemTip and var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id and var_16_7.info_badge_top_buy_item_reminder == 1 or not _G.SkipTip.SkipBossChangeSBuyItemTip and var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id and var_16_7.boss_challenge_s_buy_item_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), ItemTools.getItemName(var_16_8), self.cost_, ItemTools.getItemName(var_16_5.id), self.selectNum_),
				OkCallback = function()
					if var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id then
						_G.SkipTip.SkipDiamondBuyItemTip = self.SkipDiamondBuyItemTip_
					elseif var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id then
						_G.SkipTip.SkipCoreEquipBuyItemTip = self.SkipCoreEquipBuyItemTip_
					elseif var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id then
						_G.SkipTip.SkipInfoBadageTopBuyItemTip = self.SkipInfoBadageTopBuyItemTip_
					elseif var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id then
						_G.SkipTip.SkipBossChangeSBuyItemTip = self.SkipBossChangeSBuyItemTip_
					end

					ShopAction.BuyItem({
						{
							goodID = var_16_0.id,
							buyNum = self.selectNum_
						}
					})
				end,
				ToggleCallback = function(arg_20_0)
					if var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_DIAMOND.item_id then
						self.SkipDiamondBuyItemTip_ = arg_20_0
					elseif var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_SIX_STAR_EQUIP_RESOLVE.item_id then
						self.SkipCoreEquipBuyItemTip_ = arg_20_0
					elseif var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_INFO_BADGE_TOP.item_id then
						self.SkipInfoBadageTopBuyItemTip_ = arg_20_0
					elseif var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_BOSS_CHALLENGE_S.item_id then
						self.SkipBossChangeSBuyItemTip_ = arg_20_0
					end
				end
			})
		elseif var_16_8 == CurrencyIdMapCfg.CURRENCY_TYPE_RECHARGE_DIAMOND_FREE.item_id then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("SHOP_SECONDARY_CONFIRMATION"), ItemTools.getItemName(var_16_8), self.cost_, ItemTools.getItemName(var_16_5.id), self.selectNum_),
				OkCallback = function()
					ShopAction.BuyItem({
						{
							goodID = var_16_0.id,
							buyNum = self.selectNum_
						}
					})
				end
			})
		elseif var_16_5.type == ItemConst.ITEM_TYPE.SCENE and HomeSceneSettingCfg[var_16_5.param[1]].limit_display == 0 then
			local var_16_9 = true
			local var_16_10

			for iter_16_0, iter_16_1 in ipairs(SkinSceneActionCfg.all) do
				if SkinSceneActionCfg[iter_16_1].special_scene_id == var_16_5.param[1] then
					var_16_10 = SkinSceneActionCfg[iter_16_1].skin_id

					if ShopTools.HaveSkin(SkinSceneActionCfg[iter_16_1].skin_id) or HeroTools.CanChangeSkin(var_16_10) then
						var_16_9 = true

						break
					end

					var_16_9 = false

					break
				end
			end

			if var_16_9 then
				ShopAction.BuyItem({
					{
						goodID = var_16_0.id,
						buyNum = self.selectNum_
					}
				})
			else
				local var_16_11 = {
					title = GetTips("PROMPT")
				}

				var_16_11.content = GetTipsF("BUY_SCENE_NOT_HAVE_HERO_SKIN_CONFIRM", GetI18NText(SkinCfg[var_16_10].name), ItemTools.getItemName(var_16_5.id))

				function var_16_11.OkCallback()
					ShopAction.BuyItem({
						{
							goodID = var_16_0.id,
							buyNum = self.selectNum_
						}
					})
				end

				ShowMessageBox(var_16_11)
			end
		else
			ShopAction.BuyItem({
				{
					goodID = var_16_0.id,
					buyNum = self.selectNum_
				}
			})
		end
	end)
end

function ShopBuyView:OnShopBuyResult(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	if arg_23_1 == 0 then
		local var_23_0 = getShopCfg(arg_23_2)

		self:Back()

		if ItemCfg[var_23_0.give_id].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			getReward({
				{
					num = 1,
					id = var_23_0.give_id
				}
			})
		elseif ItemCfg[var_23_0.give_id].type == ItemConst.ITEM_TYPE.EQUIP and EquipData:GetEquipBagFull() then
			showEquipSendMail(nil)
			EquipAction.EquipBagFull(false)
		end
	end
end

function ShopBuyView:AddEventListeners()
	self:RegistEventListener(SHOP_LIST_UPDATE, function(arg_25_0)
		if arg_25_0 == 0 or self.shopId == arg_25_0 then
			self:RefreshUI()
			self:UpdateBarByGoodId()
		end
	end)
	self:RegistEventListener(SHOP_REFRESH_ALL_SHOP, function(arg_26_0)
		self:RefreshUI()
		self:UpdateBarByGoodId()
	end)
	self:RegistEventListener(SHOP_ITEM_UPDATE, function(arg_27_0, arg_27_1)
		if self.shopId ~= arg_27_0 then
			return
		end

		self:RefreshUI()
		self:UpdateBarByGoodId()
	end)
end

function ShopBuyView:RefreshUI()
	self.useNumSlider_.minValue = 0
	self.useNumSlider_.maxValue = self:GetMaxBuyNum()

	self.groupController:SetSelectedState("false")

	local var_28_0 = self.shopCfg
	local var_28_1 = ItemCfg[self.shopCfg.give_id]

	SetActive(self.heroIcon_, false)
	SetActive(self.commonIconGo_, true)
	SetActive(self.ownGo_, ShopTools.CheckGoodsOwen(self.goodID))

	if var_28_1.type == ItemConst.ITEM_TYPE.EQUIP or var_28_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT then
		self.starController:SetSelectedState(var_28_1.rare)
	elseif var_28_1.type == ItemConst.ITEM_TYPE.HERO then
		self.starController:SetSelectedState("0")
		self.groupController:SetSelectedState("true")

		self.campIcon_.sprite = HeroTools.GetHeroRaceIcon(var_28_0.give_id)
		self.itemIcon_.sprite = ItemTools.getItemSprite(var_28_0.give_id)

		SetActive(self.heroIcon_, true)
		SetActive(self.commonIconGo_, false)
	else
		self.starController:SetSelectedState("0")
	end

	self.bgController:SetSelectedState(tostring(var_28_1.display_rare))
	self.ndtabController:SetSelectedState("off")
	self.viewController:SetSelectedState(tostring(var_28_1.type == ItemConst.ITEM_TYPE.EQUIP or var_28_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT or var_28_1.type == ItemConst.ITEM_TYPE.SCENE))

	if var_28_1.type == ItemConst.ITEM_TYPE.DORM_FURNITURE and not manager.windowBar:GetWhereTag() == "qworld" then
		self.furnitureViewController:SetSelectedState("on")
	else
		self.furnitureViewController:SetSelectedState("off")

		if (var_28_1.type == ItemConst.ITEM_TYPE.DORM_FURNITURE or var_28_1.type == ItemConst.ITEM_TYPE.FURNITURE_SUIT) and manager.windowBar:GetWhereTag() == "dorm" then
			self.furnitureShopController:SetSelectedState("on")
		else
			self.furnitureShopController:SetSelectedState("off")
		end
	end

	self.haveNumText_.text = var_28_1.type == ItemConst.ITEM_TYPE.EQUIP and NumberTools.RetractNumber(#EquipTools.GetEquipListByEquipid(var_28_0.give_id)) or var_28_1.type == ItemConst.ITEM_TYPE.WEAPON_SERVANT and NumberTools.RetractNumber(#(WeaponServantData:GetWeaponServantById(var_28_0.give_id) or {})) or NumberTools.RetractNumber(ItemTools.getItemNum(var_28_0.give_id))
	self.commonIcon_.sprite = ItemTools.getItemSprite(var_28_0.give_id)
	self.discountTxt_.text = ShopTools.GetDiscountLabel(self.goodID)

	local var_28_2, var_28_3, var_28_4 = ShopTools.IsOnDiscountArea(self.goodID)

	if var_28_2 and var_28_4 then
		self.ndtabController:SetSelectedState("discount")
	end

	if self.shopCfg.tag == ShopConst.TAGS.NEW then
		self.ndtabController:SetSelectedState("new")
	end

	if var_28_2 and var_28_4 and self.shopCfg.tag == ShopConst.TAGS.NEW then
		self.ndtabController:SetSelectedState("all")
	end

	self.nameText_.text = ItemTools.getItemName(var_28_1.id)
	self.descText_.text = ItemTools.getItemDesc(var_28_1.id)

	self:RefreshNum()

	self.useNumSlider_.value = self.selectNum_
	self.costIcon_.sprite = ItemTools.getItemLittleSprite(var_28_0.cost_id)

	SetActive(self.limitGo_, self:IsLimit())

	if self:IsLimit() then
		self.limitText_.text = self.shopCfg.shop_refresh == 1 and GetTips(ShopConst.SHOP_LIMIT_TEXT[var_28_0.refresh_cycle]) .. self:GetRestNum() .. "/" .. self:GetLimitNum() or GetTips("PURCHASE_LIMIT") .. self:GetRestNum() .. "/" .. self:GetLimitNum()
	end
end

function ShopBuyView:UpdateDormLabel()
	if BackHomeFurniture[self.shopCfg.give_id] then
		local var_29_0 = ""

		for iter_29_0, iter_29_1 in ipairs(BackHomeFurniture[self.shopCfg.give_id].scene_id) do
			var_29_0 = var_29_0 .. DormTools:GetRoomTypeName(iter_29_1) .. " "
		end

		self.dormRangeTxt_.text = var_29_0
		self.dormLimitTxt_.text = DormTools:GetFurGiftMaxDesc(self.shopCfg.give_id)
		self.comfortableTxt_.text = DormTools:GetFurComfortDesc(self.shopCfg.give_id)
		self.dormTypeTxt_.text = DormTools:GetFurGiftTypeDesc(self.shopCfg.give_id)
	else
		self.dormTypeTxt_.text = ""
		self.dormRangeTxt_.text = ""
		self.dormLimitTxt_.text = ""
		self.comfortableTxt_.text = ""
	end
end

function ShopBuyView:GetLabelList(arg_30_1)
	if BackHomeFurniture[arg_30_1] then
		return DormTools:GetFurLable(arg_30_1)
	end
end

function ShopBuyView:RefreshRevert()
	local var_31_0, var_31_1 = ShopTools.rewertReward(self.goodID, self.selectNum_)

	if #var_31_1 ~= 0 then
		self.furnitureController:SetSelectedState("transformation")
	elseif DormFurnitureTools:CheckFurShowExtendLable(self.shopCfg.give_id) then
		self.furnitureController:SetSelectedState("true")
		self:UpdateDormLabel()
	else
		self.furnitureController:SetSelectedState("false")
	end

	if #var_31_1 ~= 0 then
		CommonTools.SetCommonData(self.commonItem1, {
			id = var_31_0[1].id,
			number = var_31_0[1].num,
			clickFun = function()
				ShowPopItem(POP_ITEM, {
					id = var_31_0[1].id,
					number = var_31_0[1].num
				})
			end
		})
		CommonTools.SetCommonData(self.commonItem2, {
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

function ShopBuyView:RefreshNum()
	self.useNumText_.text = GetTips("DORM_CAN_BUY_NUM") .. "：" .. self.selectNum_

	self:RefreshRevert()

	local var_34_0, var_34_1 = ShopTools.GetPrice(self.goodInfo.id)

	if var_34_0 == 0 then
		self.consumeController:SetSelectedState("free")
	else
		self.originPriceTxt_.text = var_34_1 * self.selectNum_

		self.consumeController:SetSelectedState(var_34_1 == var_34_0 and "normal" or "discount")
	end

	self.cost_ = var_34_0 * self.selectNum_
	self.totalCostText_.text = self.cost_

	local var_34_2

	if ItemTools.getItemNum(self.shopCfg.cost_id) < self.cost_ then
		self.totalCostText_.text = "<color=#FF000B>" .. self.cost_ .. "</color>"
		var_34_2 = self.addBtn_
	end

	var_34_2.interactable = self:GetMaxBuyNum() > self.selectNum_
	self.delBtn_.interactable = self.selectNum_ > 1
end

function ShopBuyView:GetLimitNum()
	if self.shopCfg.limit_num and self.shopCfg.limit_num ~= -1 then
		return self.shopCfg.limit_num
	end

	return -1
end

function ShopBuyView:GetRestNum()
	if self:IsLimit() then
		return self:GetLimitNum() - self.goodInfo.buyTime
	end

	return -1
end

function ShopBuyView:IsLimit()
	if self.shopCfg.limit_num and self.shopCfg.limit_num ~= -1 then
		return true
	end

	return false
end

function ShopBuyView:GetMaxBuyNum()
	local var_38_0 = ShopTools.GetPrice(self.goodInfo.id)
	local var_38_1 = -1

	if self.shopCfg.limit_num and self.shopCfg.limit_num ~= -1 then
		var_38_1 = self.shopCfg.limit_num - self.goodInfo.buyTime

		return math.min(self.shopCfg.limit_num - self.goodInfo.buyTime, (math.max(math.floor(ItemTools.getItemNum(self.shopCfg.cost_id) / var_38_0), 1)))
	end

	if ItemCfg[self.shopCfg.give_id].type == ItemConst.ITEM_TYPE.HERO_PIECE and self.shopCfg.shop_id == ShopConst.SHOP_ID.REPORT_SHOP then
		var_38_1 = math.max(HeroData:GetHeroOmegaNeedPiece(ItemCfg[self.shopCfg.give_id].id - 10000), 1)
	end

	local var_38_3 = math.max(math.floor(ItemTools.getItemNum(self.shopCfg.cost_id) / var_38_0), 1)

	if var_38_1 < var_38_3 and var_38_1 ~= -1 then
		return var_38_1
	else
		return var_38_3 < 1 and 1 or var_38_3
	end
end

function ShopBuyView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ShopBuyView:OnTop()
	self:RefreshUI()
	self:UpdateBarByGoodId()
	manager.windowBar:SetAsLastSibling()
end

function ShopBuyView:OnEnter()
	self.goodInfo = self.params_.goodInfo
	self.shopId = self.goodInfo.shopId
	self.goodID = self.goodInfo.id
	self.shopCfg = getShopCfg(self.goodInfo.id)
	self.useNumSlider_.value = 1
	self.selectNum_ = 1

	self:AddEventListeners()
end

function ShopBuyView:UpdateBarByGoodId()
	local var_42_0 = {}

	if self.shopCfg.cost_id then
		table.insert(var_42_0, self.shopCfg.cost_id)
	end

	manager.windowBar:SwitchBar(var_42_0)

	for iter_42_0 = 1, #var_42_0 do
		manager.windowBar:SetBarCanAdd(var_42_0[iter_42_0], ShopConst.ADD_CURRENCY[var_42_0[iter_42_0]] == true)
	end
end

function ShopBuyView:Dispose()
	self.useNumSlider_.onValueChanged:RemoveAllListeners()
	self.useNumTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	self:RemoveAllListeners()
	ShopBuyView.super.Dispose(self)
	self.commonItem1:Dispose()

	self.commonItem1 = nil

	self.commonItem2:Dispose()

	self.commonItem2 = nil
end

function ShopBuyView:OnExitInput()
	JumpTools.Back()

	return true
end

return ShopBuyView
