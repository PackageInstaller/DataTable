local var_0_0 = class("DormPartSuitInfoPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormFurnitureSuitInfoPopUI"
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

	arg_5_0.scrollHelper_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, FurnitureItem)
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.suitID = arg_6_0.params_.suitID

	arg_6_0:RefreshView()
end

function var_0_0.OnTop(arg_7_0)
	if arg_7_0.scrollHelper_ then
		arg_7_0.scrollHelper_:Refresh()
	end
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListenerScale(arg_9_0.getAllBtn_, nil, function()
		JumpTools.OpenPageByJump("dormSuitGetFurListView", {
			furEidList = arg_9_0.canStorageList,
			callBack = handler(arg_9_0, function()
				arg_9_0:RefreshFurInfoList()
				arg_9_0:RefreshCanRestorageState()
			end)
		})
	end)
	arg_9_0:AddBtnListener(arg_9_0.bgmaskBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.RefreshView(arg_13_0)
	arg_13_0:RefreshSuitInfo()
	arg_13_0:RefreshCanRestorageState()
	arg_13_0:RefreshFurInfoList()
end

function var_0_0.RefreshCanRestorageState(arg_14_0)
	local var_14_0, var_14_1 = arg_14_0:CheckCanRecycleFur()

	arg_14_0.canStorageFlag = var_14_0

	if not var_14_0 then
		arg_14_0.canStorageList = nil
	else
		arg_14_0.canStorageList = var_14_1
	end
end

function var_0_0.RefreshSuitInfo(arg_15_0)
	if ItemCfg[arg_15_0.suitID] then
		arg_15_0.suitName.text = ItemTools.getItemName(arg_15_0.suitID)
		arg_15_0.furNum.text = DormSuitData:GetSuitNeedTotalFurNumList(arg_15_0.suitID)

		local var_15_0 = BackHomeSuitCfg[arg_15_0.suitID].suit_num
		local var_15_1 = 0

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			var_15_1 = var_15_1 + BackHomeFurniture[iter_15_1[1]].dorm_exp * iter_15_1[2]
		end

		arg_15_0.comfortNum.text = var_15_1
		arg_15_0.suitImg.sprite = DormSuitTools:GetSuitHighDefinitionIcon(arg_15_0.suitID)
	end
end

function var_0_0.RefreshFurInfoList(arg_16_0)
	local var_16_0 = DormSuitData:GetNeedUseFurNumInfoBySuitID(arg_16_0.suitID)

	arg_16_0.furInfoList = {}

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_1 = {
			furID = iter_16_1[1],
			suitID = arg_16_0.suitID
		}

		table.insert(arg_16_0.furInfoList, var_16_1)
	end

	arg_16_0.scrollHelper_:StartScroll(#arg_16_0.furInfoList)
end

function var_0_0.indexItem(arg_17_0, arg_17_1, arg_17_2)
	arg_17_2:RefreshUI(arg_17_0.furInfoList[arg_17_1], nil, DormEnum.FurItemType.SuitFurShow, nil, arg_17_1)
	arg_17_2:OnClickBtn(function(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
		local var_18_0 = DormData:GetFurNumInfo(arg_18_0)
		local var_18_1 = 0

		if arg_18_3 == "enough" then
			if var_18_0 then
				var_18_1 = var_18_0.num
			end

			ShowPopItem(POP_ITEM, {
				arg_18_0,
				var_18_1
			})
		elseif arg_18_3 == "canGift" then
			JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
				state = "gift",
				furID = arg_18_0,
				needNum = arg_18_4,
				defaultNum = arg_18_4
			})
		elseif arg_18_3 == "noEnough" then
			local var_18_2 = {}
			local var_18_3 = ShopListCfg[ShopConst.SHOP_ID.FURNITURE_SHOP].display_group

			for iter_18_0, iter_18_1 in ipairs(ShopListCfg.all) do
				if ShopListCfg[iter_18_1].display_group == var_18_3 then
					table.insert(var_18_2, iter_18_1)
				end
			end

			local var_18_4 = getGoodListByGiveID(arg_18_0)
			local var_18_5 = false
			local var_18_6

			for iter_18_2, iter_18_3 in ipairs(var_18_4) do
				for iter_18_4, iter_18_5 in ipairs(var_18_2) do
					if ShopTools.IsGoodCanBuy(iter_18_5, iter_18_3) then
						var_18_5 = true

						local var_18_7 = iter_18_3

						break
					end
				end
			end

			if var_18_5 then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "buy",
					furID = arg_18_0,
					needNum = arg_18_4,
					defaultNum = arg_18_4
				})
			else
				ShowPopItem(POP_ITEM, {
					arg_18_0,
					var_18_1
				})
			end
		end
	end)
	arg_17_2:GrayCallBack(function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		local var_19_0 = DormData:GetFurNumInfo(arg_19_0)
		local var_19_1 = 0

		if arg_19_3 == "enough" then
			if var_19_0 then
				var_19_1 = var_19_0.num
			end

			ShowPopItem(POP_ITEM, {
				arg_19_0,
				var_19_1
			})
		elseif arg_19_3 == "canGift" then
			JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
				state = "gift",
				furID = arg_19_0,
				needNum = arg_19_4,
				defaultNum = arg_19_4
			})
		elseif arg_19_3 == "noEnough" then
			local var_19_2 = {}
			local var_19_3 = ShopListCfg[ShopConst.SHOP_ID.DORM_SHOP].display_group

			for iter_19_0, iter_19_1 in ipairs(ShopListCfg.all) do
				if ShopListCfg[iter_19_1].display_group == var_19_3 then
					table.insert(var_19_2, iter_19_1)
				end
			end

			local var_19_4 = getGoodListByGiveID(arg_19_0)
			local var_19_5 = false
			local var_19_6

			for iter_19_2, iter_19_3 in ipairs(var_19_4) do
				for iter_19_4, iter_19_5 in ipairs(var_19_2) do
					if ShopTools.IsGoodCanBuy(iter_19_5, iter_19_3) then
						var_19_5 = true

						local var_19_7 = iter_19_3

						break
					end
				end
			end

			if var_19_5 then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "buy",
					furID = arg_19_0,
					needNum = arg_19_4,
					defaultNum = arg_19_4
				})
			else
				ShowPopItem(POP_ITEM, {
					arg_19_0,
					var_19_1
				})
			end
		end
	end)
end

function var_0_0.CheckCanRecycleFur(arg_20_0)
	local var_20_0 = DormSuitData:GetSuitFurInfo(arg_20_0.suitID)
	local var_20_1 = {}
	local var_20_2 = DormData:GetCurrectSceneID()

	if var_20_0 then
		local var_20_3 = var_20_0.suit_num
		local var_20_4 = DormData:GetCurrectSceneID()

		for iter_20_0, iter_20_1 in ipairs(var_20_3) do
			local var_20_5 = iter_20_1[1]
			local var_20_6 = DormSuitData:GetFurNeedNumBySuitID(arg_20_0.suitID, var_20_5)
			local var_20_7 = math.min(DormFurEditStateData:GetCanUseFurNumInRoom(var_20_2, var_20_5), var_20_6)
			local var_20_8 = math.min(DormRoomTools:GetHasPlaceFurInfoByRoom(var_20_4, var_20_5) + DormFurEditStateData:GetCacheFurNum(var_20_5), var_20_6)

			if var_20_7 < var_20_6 and var_20_8 > 0 then
				local var_20_9 = {
					furID = var_20_5,
					num = math.min(var_20_6 - var_20_7, var_20_8)
				}

				table.insert(var_20_1, var_20_9)
			end
		end
	end

	local var_20_10 = {}
	local var_20_11 = false

	for iter_20_2, iter_20_3 in ipairs(var_20_1) do
		local var_20_12 = DormLuaBridge.GetCanRestoreFur(iter_20_3.furID, iter_20_3.num)

		if var_20_12.Length > 0 then
			var_20_10[iter_20_3.furID] = {}
			var_20_10[iter_20_3.furID] = var_20_12
			var_20_11 = true
		end
	end

	return var_20_11, var_20_10
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.scrollHelper_ then
		arg_21_0.scrollHelper_:Dispose()
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
