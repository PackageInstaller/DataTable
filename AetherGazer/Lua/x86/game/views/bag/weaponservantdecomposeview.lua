local var_0_0 = class("WeaponServantDecomposeView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Bag/SplitServantUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0.rewardIndex_ = 0
	arg_3_0.rewardItems_ = {}

	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.servantDetailView_ = WeaponServantMainDetailModule.New(arg_4_0.servantDetailGo_)

	arg_4_0.servantDetailView_:SwitchBtnStyle(4)

	arg_4_0.servantItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexServantItem), arg_4_0.uiListGo_, CommonItemView)
	arg_4_0.returnItemList_ = LuaList.New(handler(arg_4_0, arg_4_0.indexRewardItem), arg_4_0.returnItemListGo_, CommonItemView)
	arg_4_0.previewController_ = arg_4_0.controllerEx_:GetController("preview")
	arg_4_0.emptyController_ = arg_4_0.controllerEx_:GetController("empty")
	arg_4_0.btnController_ = arg_4_0.controllerEx_:GetController("btnState")
	arg_4_0.orderController_ = arg_4_0.orderCon_:GetController("sort")
	arg_4_0.filterController_ = arg_4_0.filterCon_:GetController("color")
	arg_4_0.starToggle_ = {}

	for iter_4_0 = 3, 4 do
		arg_4_0.starToggle_[iter_4_0] = arg_4_0["toggle_" .. iter_4_0]
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btnShowFilter_, nil, function()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.Decompose_Servant_Filter_List
		})
	end)
	arg_5_0:AddToggleListener(arg_5_0.dropDown_, function(arg_7_0)
		arg_5_0.priority_ = arg_7_0 == 0 and 1 or 0

		arg_5_0:RefreshData()
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnOrder_, nil, function()
		local var_8_0 = arg_5_0.order_ == 0

		arg_5_0.order_ = var_8_0 and 1 or 0

		arg_5_0.orderController_:SetSelectedState(var_8_0 and "up" or "down")
		arg_5_0:RefreshData()
	end)

	for iter_5_0 = 3, 4 do
		arg_5_0:AddToggleListener(arg_5_0.starToggle_[iter_5_0], function(arg_9_0)
			arg_5_0:QuickSelectServant(iter_5_0, arg_9_0)
		end)
	end

	arg_5_0:AddBtnListener(arg_5_0.btnShowPreview_, nil, function()
		arg_5_0:RefreshRewardItem()
		arg_5_0.previewController_:SetSelectedState("show")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnPreviewMask_, nil, function()
		arg_5_0.previewController_:SetSelectedState("hide")
	end)
	arg_5_0:AddBtnListener(arg_5_0.btnConfirm_, nil, function()
		if arg_5_0.currentSelectNum_ > 0 then
			arg_5_0:RefreshRewardItem()
			JumpTools.OpenPageByJump("decomposeConfirmPop", {
				type = "servant",
				itemList = arg_5_0.usedServantList_,
				returnList = arg_5_0.rewardList_
			})
		end
	end)
end

function var_0_0.OnEnter(arg_13_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR
	})

	arg_13_0.refreshSelectIndex_ = 1
	arg_13_0.usedServantList_ = {}
	arg_13_0.currentSelectNum_ = 0
	arg_13_0.priority_ = 1
	arg_13_0.order_ = 1

	arg_13_0:Render()
	arg_13_0:RenderFilterBtn()
	arg_13_0.filterController_:SetSelectedState("normal")
	arg_13_0.previewController_:SetSelectedState("hide")
	arg_13_0:RegistEventListener(COMMON_FILTER_OK, handler(arg_13_0, arg_13_0.OnFilterChange))
end

function var_0_0.Render(arg_14_0)
	arg_14_0:RefreshData()
end

function var_0_0.RefreshData(arg_15_0)
	local var_15_0 = ServantTools.GetWeaponShowData(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id, {
		hideEquip = true,
		hideLock = true,
		hideStar = {
			5
		}
	})

	arg_15_0.itemList_ = ServantTools:GetServantList(nil, var_15_0, nil, arg_15_0.priority_, arg_15_0.order_)
	arg_15_0.totalNum_ = #arg_15_0.itemList_
	arg_15_0.selectNum_.text = string.format("%s/%s", arg_15_0.currentSelectNum_, arg_15_0.totalNum_)

	arg_15_0.servantItemList_:StartScroll(#arg_15_0.itemList_)
	arg_15_0.emptyController_:SetSelectedState(#arg_15_0.itemList_ > 0 and "show" or "hide")
end

function var_0_0.RefreshRightInfo(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2

	if arg_16_0.selectedItem_ then
		arg_16_0.selectedItem_:RefreshSelectState2(false)
	end

	arg_16_1:RefreshSelectState2(true)

	arg_16_0.selectedItem_ = arg_16_1

	arg_16_0.servantDetailView_:OnRenderServant(var_16_0)
	SetActive(arg_16_0.servantDetailView_.lockBtn_.gameObject, false)
end

function var_0_0.RefreshRewardItem(arg_17_0)
	if next(arg_17_0.usedServantList_) ~= nil then
		arg_17_0.rewardList_ = ServantTools.GetServantDecomposeRewardItem(arg_17_0.usedServantList_)
	else
		arg_17_0.rewardList_ = {}
	end

	arg_17_0.returnItemList_:StartScroll(#arg_17_0.rewardList_)
end

function var_0_0.indexServantItem(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = clone(ItemTemplateData)
	local var_18_1 = arg_18_0.itemList_[arg_18_1]

	var_18_0.id = var_18_1.id
	var_18_0.uid = var_18_1.uid
	var_18_0.addLevel = WeaponServantData:GetServantDataByUID(var_18_1.uid).stage

	function var_18_0.clickFun(arg_19_0)
		local var_19_0 = arg_19_0.uid

		arg_18_0:RefreshRightInfo(arg_18_2, var_18_1)

		if arg_18_0.usedServantList_[var_19_0] then
			arg_18_2:RefreshSelectState(false)

			arg_18_0.usedServantList_[var_19_0] = nil
			arg_18_0.currentSelectNum_ = arg_18_0.currentSelectNum_ - 1

			arg_18_0:CheckToggleState(var_18_1)
		else
			arg_18_2:RefreshSelectState(true)

			arg_18_0.usedServantList_[var_19_0] = var_18_1
			arg_18_0.currentSelectNum_ = arg_18_0.currentSelectNum_ + 1
		end

		arg_18_0.btnController_:SetSelectedState(arg_18_0.currentSelectNum_ > 0 and "split" or "grey")

		arg_18_0.selectNum_.text = string.format("%s/%s", arg_18_0.currentSelectNum_, arg_18_0.totalNum_)
	end

	arg_18_2:SetData(var_18_0)

	local var_18_2 = arg_18_0.usedServantList_[var_18_1.uid] ~= nil

	arg_18_2:RefreshSelectState(var_18_2)

	if arg_18_0.refreshSelectIndex_ == arg_18_1 then
		arg_18_0:RefreshRightInfo(arg_18_2, var_18_1)
	end
end

function var_0_0.indexRewardItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = clone(ItemTemplateData)
	local var_20_1 = arg_20_0.rewardList_[arg_20_1]

	var_20_0.id = var_20_1.id
	var_20_0.number = var_20_1.number

	arg_20_2:SetData(var_20_0)
end

function var_0_0.CheckToggleState(arg_21_0, arg_21_1)
	local var_21_0 = ItemCfg[arg_21_1.id].display_rare

	if not arg_21_0.usedServantList_[arg_21_1.uid] and arg_21_0.starToggle_[var_21_0].isOn then
		arg_21_0.unSelectItem_ = arg_21_1
		arg_21_0.starToggle_[var_21_0].isOn = false
	end
end

function var_0_0.QuickSelectServant(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.itemList_) do
			local var_22_0 = WeaponServantCfg[iter_22_1.id].starlevel
			local var_22_1 = iter_22_1.stage

			if var_22_0 == arg_22_1 and var_22_1 == 1 then
				if arg_22_0.usedServantList_[iter_22_1.uid] == nil then
					arg_22_0.currentSelectNum_ = arg_22_0.currentSelectNum_ + 1
				end

				arg_22_0.usedServantList_[iter_22_1.uid] = iter_22_1
			end
		end
	elseif arg_22_0.unSelectItem_ then
		arg_22_0.usedServantList_[arg_22_0.unSelectItem_.uid] = nil
		arg_22_0.unSelectItem_ = nil
	else
		for iter_22_2, iter_22_3 in pairs(arg_22_0.usedServantList_) do
			if WeaponServantCfg[iter_22_3.id].starlevel == arg_22_1 then
				arg_22_0.usedServantList_[iter_22_2] = nil
				arg_22_0.currentSelectNum_ = arg_22_0.currentSelectNum_ - 1
			end
		end
	end

	arg_22_0:RefreshSelect()
end

function var_0_0.RefreshSelect(arg_23_0)
	for iter_23_0, iter_23_1 in pairs(arg_23_0.servantItemList_:GetItemList()) do
		local var_23_0 = iter_23_1:GetData()
		local var_23_1 = arg_23_0.usedServantList_[var_23_0.uid] ~= nil

		iter_23_1:RefreshSelectState(var_23_1)
	end

	arg_23_0.selectNum_.text = string.format("%s/%s", arg_23_0.currentSelectNum_, arg_23_0.totalNum_)

	arg_23_0.btnController_:SetSelectedState(arg_23_0.currentSelectNum_ > 0 and "split" or "grey")
end

function var_0_0.OnServantDecomposeResult(arg_24_0, arg_24_1, arg_24_2)
	getReward2(mergeReward2(arg_24_1.return_list))

	arg_24_0.refreshSelectIndex_ = 1

	arg_24_0:ClearSelect()
	arg_24_0:Render()
end

function var_0_0.ClearSelect(arg_25_0)
	arg_25_0.usedServantList_ = {}
	arg_25_0.currentSelectNum_ = 0

	arg_25_0.btnController_:SetSelectedState("grey")

	for iter_25_0, iter_25_1 in pairs(arg_25_0.starToggle_) do
		iter_25_1.isOn = false
	end
end

function var_0_0.OnFilterChange(arg_26_0)
	arg_26_0:ClearSelect()
	arg_26_0:Render()
	arg_26_0:RenderFilterBtn()
end

function var_0_0.RenderFilterBtn(arg_27_0)
	if CommonFilterData:AtLeastOneChoose(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id) then
		arg_27_0.filterController_:SetSelectedState("orange")
	else
		arg_27_0.filterController_:SetSelectedState("normal")
	end
end

function var_0_0.OnExit(arg_28_0)
	CommonFilterData:ClearFilter(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id)

	for iter_28_0, iter_28_1 in pairs(arg_28_0.starToggle_) do
		iter_28_1.isOn = false
	end

	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_29_0)
	arg_29_0:RemoveAllListeners()
	arg_29_0.servantItemList_:Dispose()
	arg_29_0.returnItemList_:Dispose()
	arg_29_0.servantDetailView_:Dispose()
	var_0_0.super.Dispose(arg_29_0)
end

return var_0_0
