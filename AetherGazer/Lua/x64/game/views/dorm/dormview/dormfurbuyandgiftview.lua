local var_0_0 = class("DormFurBuyAndGiftView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormFurnitureInfoPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()

	arg_3_0.heroScroll = LuaList.New(handler(arg_3_0, arg_3_0.indexHeroList), arg_3_0.uilistGo_, DormCharacterItem)
	arg_3_0.canBuyController = arg_3_0.btn_okControllerexcollection_:GetController("default0")
	arg_3_0.stateController = ControllerUtil.GetController(arg_3_0.transform_, "state")
	arg_3_0.giveController = ControllerUtil.GetController(arg_3_0.transform_, "given")
	arg_3_0.commonItem_ = CommonItemView.New(arg_3_0.commonitemGo_1)
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.OnEnter(arg_5_0)
	if arg_5_0.params_.isBack then
		arg_5_0:RegisterEvents()

		return
	end

	arg_5_0.furID = arg_5_0.params_.furID
	arg_5_0.furCfg = BackHomeFurniture[arg_5_0.furID]
	arg_5_0.state = arg_5_0.params_.state
	arg_5_0.params_.state = nil
	arg_5_0.needNum = arg_5_0.params_.needNum or 100
	arg_5_0.params_.needNum = nil
	arg_5_0.num = arg_5_0.params_.defaultNum
	arg_5_0.roomID = DormData:GetCurrectSceneID()

	arg_5_0:RegisterEvents()
end

function var_0_0.OnExit(arg_6_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:RefreshView()
	arg_7_0:RefreshBar()
end

function var_0_0.RefreshBar(arg_8_0)
	if arg_8_0.state == "gift" then
		manager.windowBar:HideBar()
	elseif arg_8_0.state == "buy" then
		manager.windowBar:SwitchBar({
			CurrencyConst.CURRENCY_TYPE_DORM_GOLD,
			CurrencyConst.CURRENCY_TYPE_DIAMOND
		})
		manager.windowBar:SetAsLastSibling()
	end
end

function var_0_0.RefreshView(arg_9_0)
	arg_9_0:RefreshFurInfo()

	local var_9_0 = BackHomeFurniture[arg_9_0.furID]

	if arg_9_0.state == "gift" then
		arg_9_0.giveController:SetSelectedState("false")
		arg_9_0.stateController:SetSelectedState("gift")

		arg_9_0.buyDesc.text = GetTips("DORM_CAN_GITF_NUM")
	elseif arg_9_0.state == "buy" then
		arg_9_0.stateController:SetSelectedState("buy")

		if var_9_0.is_give ~= DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			arg_9_0.giveController:SetSelectedState("true")

			arg_9_0.buyDesc.text = GetTips("DORM_CAN_BUY_NUM")
		else
			arg_9_0.giveController:SetSelectedState("false")

			arg_9_0.buyDesc.text = GetTips("DORM_CAN_BUY_AND_GITF_NUM")
		end
	end

	if var_9_0.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
		arg_9_0:RefreshHeroList()
		arg_9_0:RefreshGiftDesc()
	end

	arg_9_0:RefreshBuyNum()

	if arg_9_0.state == "gift" then
		-- block empty
	elseif arg_9_0.state == "buy" then
		if var_9_0.is_give ~= DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			arg_9_0:RefreshCantGiftFurInfo()
		end

		arg_9_0:RefreshCurrencyItemList()

		local var_9_1 = DormitoryData:GetBuyFurCurrencyID()
		local var_9_2 = 1
		local var_9_3 = var_9_1 == DormConst.DORM_CURRENCY_ID and 1 or 2

		arg_9_0:SelectCurrencyItemList(var_9_3)
	end
end

function var_0_0.RegisterEvents(arg_10_0)
	arg_10_0:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function()
		JumpTools.Back()
	end)
	arg_10_0:RegistEventListener(SHOP_BUY_SUCCESS, function()
		DormitoryData:SetBuyFurCurrencyID(arg_10_0.curItmeID)

		if arg_10_0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
			local var_12_0 = HeroRecordCfg.get_id_list_by_hero_id[arg_10_0.selHeroID][1]
			local var_12_1 = {
				[arg_10_0.furID] = arg_10_0.progressSlr_.value
			}

			if var_12_0 then
				DormAction:GiftFurToHero(var_12_0, var_12_1)
			end
		else
			JumpTools.Back()
		end
	end)
end

function var_0_0.RefreshFurInfo(arg_13_0)
	local var_13_0 = DormData:GetFurNumInfo(arg_13_0.furID).num

	arg_13_0.commonItem_:SetData({
		id = arg_13_0.furID
	})

	arg_13_0.holdNum.text = tostring(var_13_0)
	arg_13_0.titletextText_.text = ItemTools.getItemName(arg_13_0.furID)
end

function var_0_0.SelectCurrencyItemList(arg_14_0, arg_14_1)
	arg_14_0["item" .. arg_14_1].isOn = true

	if arg_14_1 == 1 then
		arg_14_0.curItmeID = DormConst.DORM_CURRENCY_ID
	elseif arg_14_1 == 2 then
		arg_14_0.curItmeID = 1
	end

	arg_14_0.singleCost, arg_14_0.goodID = arg_14_0:GetLowPriceByFurID(arg_14_0.furID, arg_14_0.curItmeID)
	arg_14_0.chooseIconImg_.sprite = ItemTools.getItemSprite(arg_14_0.curItmeID)

	arg_14_0:SetfurNum(arg_14_0.num or 1)
	arg_14_0:RefreshCost()
end

function var_0_0.RefreshHeroList(arg_15_0)
	arg_15_0.heroList = {}

	local var_15_0 = DormData:GetCurrectSceneID()

	if BackHomeCfg[var_15_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_15_1 = DormitoryData:GetArchiveIDViaRoomID(var_15_0)[1]
		local var_15_2 = DormData:GetHeroInfo(var_15_1):GetHeroId()

		table.insert(arg_15_0.heroList, var_15_2)
	else
		local var_15_3 = DormData:GetHeroInfoList()

		for iter_15_0, iter_15_1 in pairs(var_15_3) do
			local var_15_4 = DormData:GetHeroInfo(iter_15_0):GetHeroId()

			table.insert(arg_15_0.heroList, var_15_4)
		end
	end

	CommonTools.UniversalSortEx(arg_15_0.heroList, {
		ascend = true,
		map = function(arg_16_0)
			if arg_15_0.state == "gift" then
				local var_16_0 = DormData:GetHeroArchiveID(arg_16_0)

				if DormRoomTools:GetDormIDViaArchive(var_16_0) then
					if DormData:GetHeroTemplateInfo(arg_16_0):GetCanGiftNum(arg_15_0.furID) > 0 then
						return 1
					else
						return 2
					end
				else
					return 3
				end
			elseif arg_15_0.state == "buy" then
				local var_16_1 = DormData:GetHeroArchiveID(arg_16_0)

				if DormRoomTools:GetDormIDViaArchive(var_16_1) then
					if DormData:GetHeroTemplateInfo(arg_16_0):GetCanBuyAndGiftNum(arg_15_0.furID) > 0 then
						return 1
					else
						return 2
					end
				else
					return 3
				end
			end
		end
	})

	arg_15_0.selHeroID = arg_15_0.heroList[1]

	arg_15_0.heroScroll:StartScroll(#arg_15_0.heroList)

	if #arg_15_0.heroList > 0 then
		arg_15_0.heroScroll:ScrollToIndex(1, false, false)
	end
end

function var_0_0.RefreshCurrencyItemList(arg_17_0)
	local var_17_0 = DormConst.DORM_CURRENCY_ID
	local var_17_1 = 1

	arg_17_0.cur1Text.text = ItemTools.getItemName(var_17_0)
	arg_17_0.cur1icon.sprite = ItemTools.getItemSprite(var_17_0)
	arg_17_0.cur2Text.text = ItemTools.getItemName(var_17_1)
	arg_17_0.cur2icon.sprite = ItemTools.getItemSprite(var_17_1)
end

function var_0_0.RefreshBuyNum(arg_18_0)
	if arg_18_0.selHeroID then
		local var_18_0 = DormData:GetHeroTemplateInfo(arg_18_0.selHeroID)
		local var_18_1 = var_18_0:GetGiftNum(arg_18_0.furID)
		local var_18_2 = var_18_0:GetRoomID()
		local var_18_3 = var_18_0:GetCanGiftNum(arg_18_0.furID)
		local var_18_4 = BackHomeFurniture[arg_18_0.furID].give_max

		if arg_18_0.state == "gift" then
			if var_18_2 then
				arg_18_0.furNumMax = math.min(arg_18_0.needNum, var_18_3)
				arg_18_0.progressSlr_.maxValue = arg_18_0.furNumMax

				arg_18_0:SetfurNum(arg_18_0.furNumMax)
			else
				arg_18_0.furNumMax = 0
				arg_18_0.progressSlr_.maxValue = arg_18_0.furNumMax

				arg_18_0:SetfurNum(0)
			end
		elseif arg_18_0.state == "buy" then
			if var_18_2 then
				arg_18_0.furNumMax = math.min(arg_18_0.needNum, var_18_4 - var_18_1)
				arg_18_0.progressSlr_.maxValue = arg_18_0.furNumMax

				arg_18_0:SetfurNum(arg_18_0.furNumMax)
			else
				arg_18_0.furNumMax = 0
				arg_18_0.progressSlr_.maxValue = arg_18_0.furNumMax

				arg_18_0:SetfurNum(arg_18_0.furNumMax)
			end
		end
	else
		if arg_18_0.state == "buy" and arg_18_0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
			arg_18_0.furNumMax = arg_18_0.needNum
		else
			arg_18_0.furNumMax = 0
		end

		arg_18_0.progressSlr_.maxValue = arg_18_0.furNumMax

		arg_18_0:SetfurNum(arg_18_0.furNumMax)
	end
end

function var_0_0.RefreshGiftDesc(arg_19_0)
	local var_19_0 = DormData:GetHeroArchiveID(arg_19_0.selHeroID)
	local var_19_1 = HeroRecordCfg[var_19_0].name

	arg_19_0.descText.text = string.format(GetTips("DORM_FURNITURE_GIFT_CONFIRM"), ItemTools.getItemName(arg_19_0.furID), GetI18NText(var_19_1))
end

function var_0_0.RefreshCantGiftFurInfo(arg_20_0)
	arg_20_0.furTypeDesc.text = DormTools:GetFurGiftTypeDesc(arg_20_0.furID)

	local var_20_0 = ""
	local var_20_1 = BackHomeFurniture[arg_20_0.furID].scene_id

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		var_20_0 = var_20_0 .. DormTools:GetRoomTypeName(iter_20_1) .. " "
	end

	arg_20_0.sceneDesc.text = var_20_0
	arg_20_0.giftMaxText.text = ""
	arg_20_0.comfortDesc.text = tostring(BackHomeFurniture[arg_20_0.furID].dorm_exp)
	arg_20_0.furDesc.text = ItemTools.getItemDesc(arg_20_0.furID)
end

function var_0_0.SetfurNum(arg_21_0, arg_21_1)
	arg_21_1 = math.min(arg_21_1, arg_21_0.furNumMax)
	arg_21_0.num = arg_21_1
	arg_21_0.numText_.text = arg_21_1 .. "/" .. arg_21_0.furNumMax
	arg_21_0.progressSlr_.value = arg_21_1

	local var_21_0 = arg_21_1 * BackHomeFurniture[arg_21_0.furID].dorm_exp
	local var_21_1 = DormData:GetHeroArchiveID(arg_21_0.selHeroID)
	local var_21_2 = DormRoomTools:GetDormIDViaArchive(var_21_1)

	if var_21_2 then
		local var_21_3 = DormitoryData:GetDormExp(var_21_2)

		arg_21_0.comfortText_.text = GetTips("DORM_FATIGUE_INFO") .. var_21_3 .. string.format("<color=#0089E2>+%d</color>", var_21_0)
	else
		arg_21_0.comfortText_.text = GetTips("DORM_FATIGUE_INFO") .. string.format("<color=#0089E2>+%d</color>", var_21_0)
	end

	if arg_21_0.state == "buy" then
		arg_21_0:RefreshCost()
	elseif arg_21_0.state == "gift" then
		local var_21_4 = DormData:GetHeroArchiveID(arg_21_0.selHeroID)
		local var_21_5 = DormRoomTools:GetDormIDViaArchive(var_21_4)

		if (arg_21_0.selHeroID and var_21_5 or arg_21_0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT) and arg_21_0.num and arg_21_0.num > 0 and arg_21_0.furNumMax > 0 then
			arg_21_0.canBuyController:SetSelectedState("on")
		else
			arg_21_0.canBuyController:SetSelectedState("off")
		end
	end
end

function var_0_0.RefreshCost(arg_22_0)
	local var_22_0 = 0

	if arg_22_0.singleCost then
		var_22_0 = arg_22_0.singleCost * (arg_22_0.num or 0)
	end

	local var_22_1 = 0

	if arg_22_0.curItmeID then
		var_22_1 = ItemTools.getItemNum(arg_22_0.curItmeID)
	end

	local var_22_2 = DormData:GetHeroArchiveID(arg_22_0.selHeroID)
	local var_22_3 = DormRoomTools:GetDormIDViaArchive(var_22_2)

	if (arg_22_0.selHeroID and var_22_3 or arg_22_0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT) and var_22_0 <= var_22_1 and arg_22_0.num and arg_22_0.num > 0 and arg_22_0.furNumMax > 0 then
		arg_22_0.canBuyController:SetSelectedState("on")

		arg_22_0.curNumText_.text = tostring(var_22_0)
	else
		arg_22_0.canBuyController:SetSelectedState("off")

		arg_22_0.curNumText_.text = "<color=#FF0000>" .. var_22_0 .. "</color>"
	end
end

function var_0_0.GetLowPriceByFurID(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = getGoodListByGiveID(arg_23_1)
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		if getShopCfg(iter_23_1).cost_id == arg_23_2 then
			table.insert(var_23_1, iter_23_1)
		end
	end

	local var_23_2
	local var_23_3

	for iter_23_2, iter_23_3 in ipairs(var_23_1) do
		local var_23_4 = getShopCfg(iter_23_3).shop_id

		var_23_3 = var_23_3 or ShopTools.GetPrice(iter_23_3, var_23_4)

		if var_23_3 >= ShopTools.GetPrice(iter_23_3, var_23_4) then
			var_23_2 = iter_23_3
		end

		math.min(ShopTools.GetPrice(iter_23_3, var_23_4), var_23_3)
	end

	return var_23_3, var_23_2
end

function var_0_0.OnExit(arg_24_0)
	arg_24_0.selHeroID = nil

	arg_24_0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function var_0_0.AddUIListener(arg_25_0)
	arg_25_0:AddPressingByTimeListener(arg_25_0.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if arg_25_0.furID and arg_25_0.progressSlr_.value > 0 then
			local var_26_0 = arg_25_0.progressSlr_.value - 1

			arg_25_0:SetfurNum(var_26_0)

			return true
		end

		return false
	end)
	arg_25_0:AddPressingByTimeListener(arg_25_0.addNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if arg_25_0.furID and arg_25_0.progressSlr_.value < arg_25_0.furNumMax then
			local var_27_0 = arg_25_0.progressSlr_.value + 1

			arg_25_0:SetfurNum(var_27_0)

			return true
		end

		return false
	end)
	arg_25_0:AddToggleListener(arg_25_0.progressSlr_, function()
		if arg_25_0.furID then
			arg_25_0:SetfurNum(arg_25_0.progressSlr_.value)
		end
	end)
	arg_25_0:AddBtnListener(arg_25_0.confirmBtn_, nil, function()
		arg_25_0:ClickShowTips()

		if arg_25_0.state == "buy" then
			if arg_25_0.furCfg.is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
				if arg_25_0.progressSlr_.value > 0 and arg_25_0.goodID then
					if arg_25_0.curItmeID == 1 then
						ShowMessageBox({
							isTop = true,
							content = GetTips("DORM_BUY_FURNITURE_BY_DIAMOND"),
							OkCallback = function()
								ShopAction.BuyItem({
									{
										goodID = arg_25_0.goodID,
										buyNum = arg_25_0.progressSlr_.value
									}
								})
							end,
							CancelCallback = function()
								return
							end
						})
					else
						ShopAction.BuyItem({
							{
								goodID = arg_25_0.goodID,
								buyNum = arg_25_0.progressSlr_.value
							}
						})
					end
				end
			else
				local var_29_0 = DormData:GetHeroArchiveID(arg_25_0.selHeroID)
				local var_29_1 = DormRoomTools:GetDormIDViaArchive(var_29_0)

				if arg_25_0.selHeroID and arg_25_0.progressSlr_.value > 0 and arg_25_0.goodID and var_29_1 then
					if arg_25_0.curItmeID == 1 then
						ShowMessageBox({
							isTop = true,
							content = GetTips("DORM_BUY_FURNITURE_BY_DIAMOND"),
							OkCallback = function()
								ShopAction.BuyItem({
									{
										goodID = arg_25_0.goodID,
										buyNum = arg_25_0.progressSlr_.value
									}
								})
							end,
							CancelCallback = function()
								return
							end
						})
					else
						ShopAction.BuyItem({
							{
								goodID = arg_25_0.goodID,
								buyNum = arg_25_0.progressSlr_.value
							}
						})
					end
				end
			end
		elseif arg_25_0.state == "gift" and arg_25_0.selHeroID and arg_25_0.progressSlr_.value > 0 and arg_25_0.furID then
			local var_29_2 = HeroRecordCfg.get_id_list_by_hero_id[arg_25_0.selHeroID][1]
			local var_29_3 = {
				[arg_25_0.furID] = arg_25_0.progressSlr_.value
			}

			if var_29_2 then
				DormAction:GiftFurToHero(var_29_2, var_29_3)
			end
		end
	end)
	arg_25_0:AddBtnListener(arg_25_0.bgMaskBtn_, nil, function()
		JumpTools.Back()
	end)

	for iter_25_0 = 1, 2 do
		arg_25_0:AddToggleListener(arg_25_0["item" .. iter_25_0], function(arg_35_0)
			if arg_35_0 then
				arg_25_0:SelectCurrencyItemList(iter_25_0)
			end
		end)
	end

	arg_25_0:AddBtnListener(arg_25_0.btnviewBtn_, nil, function()
		if BackHomeDataManager:IsInDormSystem() then
			local var_36_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")

			if not var_36_0 then
				manager.ui:SetMainCameraCom("CinemachineBrain", true)

				var_36_0 = manager.ui.mainCamera:GetComponent("CinemachineBrain")
			end

			local var_36_1 = var_36_0.m_DefaultBlend

			var_36_0.m_DefaultBlend = DanceGameController.cut

			JumpTools.OpenPageByJump("/furniturePreview", {
				furID = arg_25_0.furID,
				cacheBlend = var_36_1
			})
		else
			JumpTools.OpenPageByJump("/furniturePreviewWithEntity", {
				furID = arg_25_0.furID
			})
		end
	end)
end

function var_0_0.indexHeroList(arg_37_0, arg_37_1, arg_37_2)
	arg_37_2:SetCanClickAndState(true, nil)
	arg_37_2:ShowMaskCallBack(function(arg_38_0)
		local var_38_0 = DormData:GetHeroArchiveID(arg_38_0)

		if not DormRoomTools:GetDormIDViaArchive(var_38_0) then
			return true
		else
			if DormData:GetHeroTemplateInfo(arg_38_0):GetGiftNum(arg_37_0.furID) >= BackHomeFurniture[arg_37_0.furID].give_max then
				return true
			end

			return false
		end
	end)
	arg_37_2:SetOnPointerDown(function(arg_39_0)
		if arg_39_0 and BackHomeHeroCfg[arg_39_0] then
			arg_37_0.selHeroID = arg_39_0

			arg_37_0.heroScroll:Refresh()
			arg_37_0:RefreshBuyNum()
			arg_37_0:RefreshGiftDesc()

			local var_39_0 = DormData:GetHeroArchiveID(arg_39_0)

			if not DormRoomTools:GetDormIDViaArchive(var_39_0) then
				ShowTips(GetTips("DORM_HERO_ROOM_LOCKED"))

				return
			elseif DormData:GetHeroTemplateInfo(arg_39_0):GetGiftNum(arg_37_0.furID) >= BackHomeFurniture[arg_37_0.furID].give_max then
				ShowTips(GetTips("DORM_GIFT_MAX_TIPS"))
			end
		end
	end)
	arg_37_2:SelCallBack(function(arg_40_0, arg_40_1, arg_40_2)
		if arg_40_0 == arg_40_1 then
			arg_40_2:SetSelectedState("select")
		else
			arg_40_2:SetSelectedState("normal")
		end
	end)
	arg_37_2:RefreshUI(arg_37_0.heroList[arg_37_1], arg_37_0.selHeroID)
end

function var_0_0.ClickShowTips(arg_41_0)
	if arg_41_0.selHeroID then
		local var_41_0 = DormData:GetHeroArchiveID(arg_41_0.selHeroID)

		if not DormRoomTools:GetDormIDViaArchive(var_41_0) then
			ShowTips(GetTips("DORM_HERO_ROOM_LOCKED"))

			return false
		elseif DormData:GetHeroTemplateInfo(arg_41_0.selHeroID):GetGiftNum(arg_41_0.furID) >= BackHomeFurniture[arg_41_0.furID].give_max then
			ShowTips(GetTips("DORM_GIFT_MAX_TIPS"))

			return false
		end

		return true
	end
end

function var_0_0.OnBeginDragHeroItem(arg_42_0, arg_42_1)
	arg_42_0.scrollex:OnBeginDrag(arg_42_1)
end

function var_0_0.OnDragHeroItem(arg_43_0, arg_43_1)
	arg_43_0.scrollex:OnDrag(arg_43_1)
end

function var_0_0.OnEndDragHeroItem(arg_44_0, arg_44_1)
	arg_44_0.scrollex:OnEndDrag(arg_44_1)
end

function var_0_0.Dispose(arg_45_0)
	if arg_45_0.heroScroll then
		arg_45_0.heroScroll:Dispose()
	end

	if arg_45_0.commonItem_ then
		arg_45_0.commonItem_:Dispose()
	end

	var_0_0.super.Dispose(arg_45_0)
end

return var_0_0
