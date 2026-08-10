local var_0_0 = class("DormHeroGiftView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/BackHouseUI/Dorm/DormGiftFurnitureUI"
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

	arg_5_0.giftScroll = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, FurnitureItem)
	arg_5_0.multiGiftScroll_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItemMulti), arg_5_0.uilistGo2_, FurnitureItemMulti)
	arg_5_0.fullController = ControllerUtil.GetController(arg_5_0.transform_, "state")
	arg_5_0.btnState = arg_5_0.btn_okControllerexcollection_:GetController("default0")
	arg_5_0.multiModeController_ = arg_5_0.controllerEx_:GetController("selMode")
	arg_5_0.multiBtnController_ = arg_5_0.modeControllerEx_:GetController("multiMode")
end

function var_0_0.OnEnter(arg_6_0)
	arg_6_0.selFurList_ = {}
	arg_6_0.archiveID = arg_6_0.params_.archiveID
	arg_6_0.heroInfo = DormData:GetHeroInfoList()[arg_6_0.archiveID]

	arg_6_0:RegisterEvents()

	arg_6_0.multiModeFlag_ = false

	arg_6_0:RefreshMultiMode()
	arg_6_0:RefreshHeroGiftList()
	arg_6_0:ResetView()

	if not arg_6_0.heroInfo then
		Debug.LogError("未找到对应角色档案信息")
	end

	if arg_6_0.params_.heroEID then
		arg_6_0.heroEID = arg_6_0.params_.heroEID
	end
end

function var_0_0.OnExit(arg_7_0)
	arg_7_0.heroEID = nil
	arg_7_0.selFurID = nil
	arg_7_0.itemIndex = nil

	arg_7_0:RemoveAllEventListener()
end

function var_0_0.indexItem(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0.selFurID

	arg_8_2:RefreshUI(arg_8_0.dataList_[arg_8_1], var_8_0, DormEnum.FurItemType.Gift, arg_8_0.archiveID, arg_8_1)
	arg_8_2:OnClickBtn(function(arg_9_0, arg_9_1)
		if var_8_0 == arg_9_0 then
			return
		end

		arg_8_0.selFurList_ = {}
		arg_8_0.selFurID = arg_9_0
		arg_8_0.itemIndex = arg_9_1

		arg_8_0:RefreshSlider()
		arg_8_0.giftScroll:Refresh()
	end)
end

function var_0_0.indexItemMulti(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0

	for iter_10_0, iter_10_1 in pairs(arg_10_0.selFurList_) do
		if iter_10_0 == arg_10_0.dataList_[arg_10_1] then
			var_10_0 = iter_10_0

			break
		end
	end

	arg_10_2:RefreshUI(arg_10_0.dataList_[arg_10_1], var_10_0, DormEnum.FurItemType.Gift, arg_10_0.archiveID, arg_10_1)

	local var_10_1 = DormData:GetHeroInfo(arg_10_0.archiveID):GetCanGiftNum(arg_10_0.dataList_[arg_10_1])

	arg_10_2:RefreshCntText(arg_10_0.selFurList_[var_10_0] or 0, var_10_0 == arg_10_0.selFurID, var_10_1 > 0)
	arg_10_2:OnClickBtn(function(arg_11_0, arg_11_1)
		if arg_10_0.selFurID == arg_11_0 then
			return
		end

		arg_10_0.selFurID = arg_11_0
		arg_10_0.itemIndex = arg_11_1

		if arg_10_0.selFurList_[arg_11_0] == nil or arg_10_0.selFurList_[arg_11_0] == 0 then
			arg_10_0.selFurList_[arg_11_0] = 1
		end

		arg_10_0:RefreshSlider()
		arg_10_0.multiGiftScroll_:Refresh()
	end)
	arg_10_2:OnCancelDown(function(arg_12_0, arg_12_1)
		arg_10_0.selFurList_[arg_12_0] = 0

		arg_10_0:RefreshSlider()
		arg_10_0.multiGiftScroll_:Refresh()
	end)
end

function var_0_0.RefreshSlider(arg_13_0)
	local var_13_0 = arg_13_0.selFurID

	if not var_13_0 then
		return
	end

	local var_13_1 = arg_13_0.heroInfo:GetCanGiftNum(var_13_0)

	if var_13_1 <= 0 then
		arg_13_0.fullController:SetSelectedState("false")

		arg_13_0.fullText.text = GetTips("DORM_GIFT_MAX_TIPS")
		arg_13_0.selFurList_[var_13_0] = 0

		arg_13_0:RefreshOkBtnState()
	else
		local var_13_2 = 1

		if arg_13_0.multiModeFlag_ then
			var_13_2 = arg_13_0.selFurList_[var_13_0] or 1
		end

		arg_13_0.selFurList_[var_13_0] = var_13_2

		arg_13_0:SetfurNum(var_13_2)

		arg_13_0.furNumMax = math.max(var_13_1, 1)
		arg_13_0.progressSlr_.maxValue = arg_13_0.furNumMax

		arg_13_0.fullController:SetSelectedState("true")
	end
end

function var_0_0.RefreshOkBtnState(arg_14_0)
	if arg_14_0:CanGifting() then
		arg_14_0.btnState:SetSelectedState("on")
	else
		arg_14_0.btnState:SetSelectedState("off")
	end
end

function var_0_0.CanGifting(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.selFurList_) do
		if iter_15_1 > 0 then
			return true
		end
	end

	return false
end

function var_0_0.RegisterEvents(arg_16_0)
	arg_16_0:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function()
		arg_16_0.selFurList_ = {}

		if arg_16_0.multiModeFlag_ then
			arg_16_0.selFurList_[arg_16_0.selFurID] = 0
		end

		arg_16_0:RefreshHeroGiftList()
		arg_16_0:ResetView(arg_16_0.multiModeFlag_)
	end)
	arg_16_0:RegistEventListener(DORM_PRIVATE_LEVEL_UP, function()
		ShowTips(GetTips("DORM_LEVEL_UP_TIPS"))
	end)
end

function var_0_0.AddUIListener(arg_19_0)
	arg_19_0:AddBtnListenerScale(arg_19_0.giftBtn_, nil, function()
		if table.length(arg_19_0.selFurList_) > 0 then
			DormAction:GiftFurToHero(arg_19_0.archiveID, arg_19_0.selFurList_, arg_19_0.heroEID)
		end
	end)
	arg_19_0:AddBtnListenerScale(arg_19_0.cancelBtn_, nil, function()
		JumpTools.Back()
	end)
	arg_19_0:AddToggleListener(arg_19_0.progressSlr_, function()
		if arg_19_0.multiModeFlag_ == false and arg_19_0.progressSlr_.value < 1 then
			arg_19_0.progressSlr_.value = 1
		elseif arg_19_0.multiModeFlag_ and arg_19_0.progressSlr_.value <= 0 then
			arg_19_0.progressSlr_.value = 0
		end

		if arg_19_0.selFurID then
			arg_19_0:SetfurNum(arg_19_0.progressSlr_.value)
		end
	end)
	arg_19_0:AddPressingByTimeListener(arg_19_0.reduceNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if arg_19_0.multiModeFlag_ == false and arg_19_0.selFurID and arg_19_0.progressSlr_.value > 1 then
			local var_23_0 = arg_19_0.progressSlr_.value - 1

			arg_19_0:SetfurNum(var_23_0)

			return true
		elseif arg_19_0.multiModeFlag_ and arg_19_0.selFurID and arg_19_0.progressSlr_.value > 0 then
			local var_23_1 = arg_19_0.progressSlr_.value - 1

			arg_19_0:SetfurNum(var_23_1)

			return true
		end

		return false
	end)
	arg_19_0:AddPressingByTimeListener(arg_19_0.addNumBtn_.gameObject, 3, 0.5, 0.5, function()
		if arg_19_0.selFurID and arg_19_0.progressSlr_.value < arg_19_0.furNumMax then
			local var_24_0 = arg_19_0.progressSlr_.value + 1

			arg_19_0:SetfurNum(var_24_0)

			return true
		end

		return false
	end)
	arg_19_0:AddBtnListenerScale(arg_19_0.modeBtn_, nil, function()
		local var_25_0 = 0

		for iter_25_0, iter_25_1 in pairs(arg_19_0.selFurList_) do
			if iter_25_1 > 0 then
				var_25_0 = var_25_0 + 1
			end
		end

		if var_25_0 >= 2 then
			ShowMessageBox({
				content = GetTips("DORM_GIFT_MODE_SWITCH"),
				OkCallback = function()
					arg_19_0:ClickSwitchMode()
				end,
				CancelCallback = function()
					return
				end
			})
		else
			arg_19_0:ClickSwitchMode()
		end
	end)
end

function var_0_0.ClickSwitchMode(arg_28_0)
	arg_28_0.multiModeFlag_ = not arg_28_0.multiModeFlag_

	arg_28_0:RefreshMultiMode()
	arg_28_0:RefreshHeroGiftList()
end

function var_0_0.RefreshMultiMode(arg_29_0)
	arg_29_0.selFurList_ = {}

	if arg_29_0.selFurID then
		arg_29_0.selFurList_[arg_29_0.selFurID] = 1
	end

	if arg_29_0.multiModeFlag_ then
		arg_29_0.multiModeController_:SetSelectedState("multiple")
		arg_29_0.multiBtnController_:SetSelectedState("on")
	else
		arg_29_0.multiModeController_:SetSelectedState("single")
		arg_29_0.multiBtnController_:SetSelectedState("off")
	end

	arg_29_0:RefreshSlider()
end

function var_0_0.SetfurNum(arg_30_0, arg_30_1)
	arg_30_0.numText_.text = arg_30_1
	arg_30_0.progressSlr_.value = arg_30_1

	if multiModeFlag_ then
		arg_30_0.reduceNumBtn_.interactable = arg_30_1 >= 1
	else
		arg_30_0.reduceNumBtn_.interactable = arg_30_1 > 1
	end

	arg_30_0.addNumBtn_.interactable = arg_30_1 < arg_30_0.progressSlr_.maxValue
	arg_30_0.selFurList_[arg_30_0.selFurID] = arg_30_1

	if arg_30_0.multiModeFlag_ then
		arg_30_0.multiGiftScroll_:Refresh()
	end

	arg_30_0:RefreshOkBtnState()
end

function var_0_0.RefreshHeroGiftList(arg_31_0)
	arg_31_0.dataList_ = {}

	local var_31_0 = DormData:GetFurnitureInfoList()

	for iter_31_0, iter_31_1 in pairs(var_31_0) do
		if BackHomeFurniture[iter_31_0].is_give == 1 and iter_31_1.num > iter_31_1.give_num then
			table.insert(arg_31_0.dataList_, iter_31_0)
		end
	end

	CommonTools.UniversalSortEx(arg_31_0.dataList_, {
		map = function(arg_32_0)
			if DormData:GetHeroInfo(arg_31_0.archiveID):GetCanGiftNum(arg_32_0) == 0 then
				return 1
			else
				return 2
			end
		end
	}, {
		ascend = true,
		map = function(arg_33_0)
			return arg_33_0
		end
	})

	if not arg_31_0.selFurID and #arg_31_0.dataList_ > 0 then
		arg_31_0.selFurID = arg_31_0.dataList_[1]
	end

	if arg_31_0.multiModeFlag_ == false then
		arg_31_0.giftScroll:StartScroll(#arg_31_0.dataList_)

		if arg_31_0.itemIndex then
			arg_31_0.giftScroll:ScrollToIndex(arg_31_0.itemIndex, true, false)
		end

		if #arg_31_0.dataList_ == 0 then
			arg_31_0.listText.text = ""

			arg_31_0.fullController:SetSelectedState("false")
			arg_31_0.btnState:SetSelectedState("off")
		end
	else
		arg_31_0.multiGiftScroll_:StartScroll(#arg_31_0.dataList_)

		if arg_31_0.itemIndex then
			arg_31_0.multiGiftScroll_:ScrollToIndex(arg_31_0.itemIndex, true, false)
		end

		if #arg_31_0.dataList_ == 0 then
			arg_31_0.listText.text = ""

			arg_31_0.fullController:SetSelectedState("false")
			arg_31_0.btnState:SetSelectedState("off")
		end
	end
end

function var_0_0.ResetView(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0.selFurID

	if var_34_0 then
		local var_34_1 = false

		for iter_34_0, iter_34_1 in ipairs(arg_34_0.dataList_) do
			if iter_34_1 == var_34_0 then
				var_34_1 = true

				break
			end
		end

		if not var_34_1 then
			arg_34_0.fullController:SetSelectedState("false")
			arg_34_0.btnState:SetSelectedState("off")

			arg_34_0.fullText.text = ""

			return
		end

		local var_34_2 = arg_34_0.heroInfo:GetCanGiftNum(arg_34_0.selFurID)

		if var_34_2 <= 0 then
			arg_34_0.fullController:SetSelectedState("false")
			arg_34_0.btnState:SetSelectedState("off")

			arg_34_0.fullText.text = GetTips("DORM_GIFT_MAX_TIPS")
		else
			arg_34_0.progressSlr_.minValue = 0
			arg_34_0.furNumMax = var_34_2
			arg_34_0.progressSlr_.maxValue = arg_34_0.furNumMax

			arg_34_0.fullController:SetSelectedState("true")
			arg_34_0.btnState:SetSelectedState("on")

			if arg_34_1 then
				arg_34_0:SetfurNum(0)
			else
				arg_34_0:SetfurNum(1)
			end
		end
	else
		arg_34_0.fullController:SetSelectedState("false")
		arg_34_0.btnState:SetSelectedState("off")

		arg_34_0.fullText.text = ""
	end
end

function var_0_0.Dispose(arg_35_0)
	if arg_35_0.giftScroll then
		arg_35_0.giftScroll:Dispose()
	end

	if arg_35_0.multiGiftScroll_ then
		arg_35_0.multiGiftScroll_:Dispose()
	end

	var_0_0.super.Dispose(arg_35_0)
end

return var_0_0
