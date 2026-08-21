local var_0_0 = class("DormSuitFurBgView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormSuitPreviewBgUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
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
	manager.windowBar:HideBar()

	arg_6_0.suitID = arg_6_0.params_.suitID
	arg_6_0.shopID = arg_6_0.params_.shopID

	arg_6_0:RefreshView()
	arg_6_0:RegisterEvents()
end

function var_0_0.OnExit(arg_7_0)
	manager.windowBar:HideBar()
	arg_7_0:RemoveAllEventListener()
end

function var_0_0.AddUIListener(arg_8_0)
	arg_8_0:AddBtnListenerScale(arg_8_0.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
end

function var_0_0.RefreshView(arg_10_0)
	arg_10_0:RefreshFurInfoList()
end

function var_0_0.OnTop(arg_11_0)
	arg_11_0.scrollHelper_:Refresh()
end

function var_0_0.RegisterEvents(arg_12_0)
	arg_12_0:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function(arg_13_0)
		if arg_12_0.selIndex then
			local var_13_0 = arg_12_0.scrollHelper_:GetItemByIndex(arg_12_0.selIndex)

			if var_13_0 == nil then
				return
			end

			if arg_12_0.suitID then
				var_13_0:RefreshUI(arg_12_0.furInfoList[arg_12_0.selIndex], nil, DormEnum.FurItemType.SuitFurShow, nil, arg_12_0.selIndex)
			end
		end
	end)
end

function var_0_0.RefreshFurInfoList(arg_14_0)
	local var_14_0 = BackHomeSuitCfg[arg_14_0.suitID]

	if #var_14_0.scene_id == 1 and var_14_0.scene_id[1] == DormConst.BACKHOME_TYPE.PublicDorm then
		arg_14_0.imageImg_.sprite = DormTools.GetShopStyleHallImage(arg_14_0.shopID)
	else
		arg_14_0.imageImg_.sprite = DormTools.GetShopStyleImage(arg_14_0.shopID)
	end

	arg_14_0.furInfoList = {}

	if arg_14_0.suitID then
		local var_14_1 = BackHomeSuitCfg[arg_14_0.suitID].suit_num

		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			local var_14_2 = {
				furID = iter_14_1[1],
				suitID = arg_14_0.suitID
			}

			table.insert(arg_14_0.furInfoList, var_14_2)
		end

		arg_14_0.scrollHelper_:StartScroll(#arg_14_0.furInfoList)

		arg_14_0.suitName.text = ItemCfg[arg_14_0.suitID].name or ""
	end
end

function var_0_0.indexItem(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0.suitID then
		arg_15_2:RefreshUI(arg_15_0.furInfoList[arg_15_1], nil, DormEnum.FurItemType.SuitFurShow, nil, arg_15_1)
	end

	arg_15_2:OnClickBtn(function(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
		local var_16_0 = DormData:GetFurNumInfo(arg_16_0)

		arg_15_0.selIndex = arg_16_1

		local var_16_1 = 0

		if arg_16_3 == "enough" then
			if var_16_0 then
				var_16_1 = var_16_0.num
			end

			ShowPopItem(POP_ITEM, {
				arg_16_0,
				var_16_1
			})
		elseif arg_16_3 == "canGift" then
			JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
				state = "gift",
				furID = arg_16_0,
				needNum = arg_16_4,
				defaultNum = arg_16_4
			})
		elseif arg_16_3 == "noEnough" then
			local var_16_2 = {}
			local var_16_3 = ShopListCfg[ShopConst.SHOP_ID.FURNITURE_SHOP].display_group

			for iter_16_0, iter_16_1 in ipairs(ShopListCfg.all) do
				if ShopListCfg[iter_16_1].display_group == var_16_3 then
					table.insert(var_16_2, iter_16_1)
				end
			end

			local var_16_4 = getGoodListByGiveID(arg_16_0)
			local var_16_5 = false
			local var_16_6

			for iter_16_2, iter_16_3 in ipairs(var_16_4) do
				for iter_16_4, iter_16_5 in ipairs(var_16_2) do
					if ShopTools.IsGoodCanBuy(iter_16_5, iter_16_3) then
						var_16_5 = true

						local var_16_7 = iter_16_3

						break
					end
				end
			end

			if var_16_5 then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "buy",
					furID = arg_16_0,
					needNum = arg_16_4,
					defaultNum = arg_16_4
				})
			else
				ShowPopItem(POP_ITEM, {
					arg_16_0,
					var_16_1
				})
			end
		end
	end)
	arg_15_2:GrayCallBack(function(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
		arg_15_0.selIndex = arg_17_1

		JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
			state = "gift",
			furID = arg_17_0,
			needNum = arg_17_4,
			defaultNum = arg_17_4
		})
	end)
end

function var_0_0.Dispose(arg_18_0)
	if arg_18_0.scrollHelper_ then
		arg_18_0.scrollHelper_:Dispose()
	end

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
