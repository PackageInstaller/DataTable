local var_0_0 = class("ShelfSetGoodsView", ReduxView)

local function var_0_1()
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in SimBusinessGame.EnumerateShelves() do
		table.insert(var_1_0, {
			idx = iter_1_0,
			eid = iter_1_1
		})
	end

	table.sort(var_1_0, function(arg_2_0, arg_2_1)
		return arg_2_0.idx < arg_2_1.idx
	end)

	return var_1_0
end

local function var_0_2(arg_3_0, arg_3_1)
	local var_3_0 = #arg_3_0

	return arg_3_0[(arg_3_1 - 1) % var_3_0 + 1]
end

function var_0_0.UIName(arg_4_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SetGoodsUI"
end

function var_0_0.UIParent(arg_5_0)
	return manager.ui.uiMain.transform
end

local var_0_3 = class("ShelfSetGoodsView.ShelfSetGoodsItem", SimBusinessGoodsItem)

function var_0_3.Init(arg_6_0)
	var_0_3.super.Init(arg_6_0)

	arg_6_0.highlightController = arg_6_0.controllerExCollection_:GetController("award")
end

function var_0_3.AddUIListener(arg_7_0)
	var_0_3.super.AddUIListener(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.showDetailBtn_, nil, function()
		manager.notify:CallFirstUpdateFunc("OnShowGoodsDetail", arg_7_0.id)
	end)
end

function var_0_3.SetHighlighted(arg_9_0, arg_9_1)
	arg_9_0.highlightController:SetSelectedState(arg_9_1 and "on" or "off")
end

function var_0_0.Init(arg_10_0)
	arg_10_0:BindCfgUI()

	arg_10_0.infoPanel = {}
	arg_10_0.showGoodsDetailController = arg_10_0.controllers_:GetController("goodsDetail")

	arg_10_0:BindCfgUI(arg_10_0.infoPanel_, arg_10_0.infoPanel)

	arg_10_0.shelfItem = SimBusinessShelfItem.New(arg_10_0.infoPanel.shelfItemObj_)
	arg_10_0.goodsList = LuaList.New(handler(arg_10_0, arg_10_0.RenderGoods), arg_10_0.infoPanel.goodsList_.gameObject, var_0_3)
	arg_10_0.goodsPanel = SimBusinessGoodPage.New(arg_10_0.goodsInfo_)

	arg_10_0:AddUIListener()
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0.goodsList:Dispose()
	arg_11_0.shelfItem:Dispose()
	arg_11_0.goodsPanel:Dispose()
	var_0_0.super.Dispose(arg_11_0)
end

function var_0_0.OnEnter(arg_12_0)
	arg_12_0.cacheSortedShelfList = var_0_1()

	arg_12_0:FocusOnShelf(arg_12_0.params_.eid)
	arg_12_0:RegisterEvents()
end

function var_0_0.OnExit(arg_13_0)
	arg_13_0:RemoveAllEventListener()
	arg_13_0:FocusOnShelf(nil)

	arg_13_0.cacheSortedShelfList = nil
end

function var_0_0.OnTop(arg_14_0)
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function var_0_0.OnBehind(arg_15_0)
	manager.windowBar:HideBar()
end

function var_0_0.OnEventRefreshView(arg_16_0)
	arg_16_0.goodsList:Refresh()
end

function var_0_0.AddUIListener(arg_17_0)
	arg_17_0:AddToggleListener(arg_17_0.infoPanel.batchOpToggle_, function(arg_18_0)
		if arg_18_0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("SIM_BUSINESS_BATCH_SET_GOODS_TIPS"),
				CancelCallback = function()
					arg_17_0.infoPanel.batchOpToggle_:SetIsOnWithoutNotify(false)
					arg_17_0.infoPanel.batchOpToggle_:UpdateControllerValue()
				end
			})
		end
	end)
	arg_17_0:AddBtnListenerScale(arg_17_0.prevBtn_, nil, function()
		arg_17_0:FocusOnShelf(arg_17_0:FindPrevShelf())
	end)
	arg_17_0:AddBtnListenerScale(arg_17_0.nextBtn_, nil, function()
		arg_17_0:FocusOnShelf(arg_17_0:FindNextShelf())
	end)

	arg_17_0.emptyArea_.onPointerClick = LuaHelper.EventTriggerAction1(function(arg_22_0, arg_22_1)
		if arg_17_0.showGoodsDetailController:GetSelectedState() == "show" then
			arg_17_0.goodsPanel:RefreshView(0)
			arg_17_0.goodsList:Refresh()
			arg_17_0.showGoodsDetailController:SetSelectedState("hide")
		else
			local var_22_0 = arg_22_1.position
			local var_22_1 = UnityEngine.Camera.main:ScreenPointToRay(var_22_0)
			local var_22_2 = UnityEngine.Physics.RaycastAll(var_22_1)

			for iter_22_0 = 0, var_22_2.Length - 1 do
				local var_22_3 = var_22_2[iter_22_0].transform:GetComponent("ShelfTrigger")

				if var_22_3 then
					var_22_3:OnPointerClick(arg_22_1)

					return
				end
			end

			JumpTools.Back()
		end
	end)

	arg_17_0:SetListener(arg_17_0.emptyArea_)
end

function var_0_0.RegisterEvents(arg_23_0)
	arg_23_0:RegistEventListener("ON_FURNITURE_CLICKED", handler(arg_23_0, arg_23_0.FocusOnShelf))
end

local function var_0_4(arg_24_0, arg_24_1)
	if arg_24_0 and Dorm.DormEntityManager.IsValidEntityID(arg_24_0) then
		Dorm.DormEntityManager.SetHighlighted(arg_24_0, arg_24_1)
	end
end

function var_0_0.FocusOnShelf(arg_25_0, arg_25_1)
	if arg_25_1 == arg_25_0.focus then
		return
	end

	if arg_25_0.dirty then
		local var_25_0 = SimBusinessGame.CalcShelfLayout()
		local var_25_1 = SimBusinessTools.GetCurEditStage()

		SimBusinessAction.SaveShelfDeployment(var_25_0, var_25_1)

		arg_25_0.dirty = nil
	end

	var_0_4(arg_25_0.focus, false)

	arg_25_0.focus = arg_25_1

	var_0_4(arg_25_1, true)

	arg_25_0.itemList = SimBusinessTools.GetFilteredGoodsList(handler(arg_25_0, arg_25_0.FilterShelfAcceptGoods))

	arg_25_0.goodsList:StartScroll(#arg_25_0.itemList)
	arg_25_0:RefreshPanel()
end

function var_0_0.FindPrevShelf(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.cacheSortedShelfList) do
		if iter_26_1.eid == arg_26_0.focus then
			return var_0_2(arg_26_0.cacheSortedShelfList, iter_26_0 - 1).eid
		end
	end
end

function var_0_0.FindNextShelf(arg_27_0)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0.cacheSortedShelfList) do
		if iter_27_1.eid == arg_27_0.focus then
			return var_0_2(arg_27_0.cacheSortedShelfList, iter_27_0 + 1).eid
		end
	end
end

function var_0_0.RefreshPanel(arg_28_0)
	if arg_28_0.focus then
		local var_28_0 = DormUtils.GetEntityData(arg_28_0.focus)
		local var_28_1 = var_28_0.cfgID
		local var_28_2 = var_28_0.goods

		arg_28_0:RefreshInfo(var_28_1, var_28_2)
		arg_28_0:RefreshGoodsList(var_28_2)
	end
end

function var_0_0.FilterShelfAcceptGoods(arg_29_0, arg_29_1)
	if arg_29_0.focus then
		local var_29_0 = DormUtils.GetEntityData(arg_29_0.focus).cfgID
		local var_29_1 = SimBusinessGoodsCfg[arg_29_1]

		for iter_29_0, iter_29_1 in ipairs(SimBusinessShelfCfg[var_29_0].sell_type) do
			if iter_29_1 == var_29_1.type then
				local var_29_2, var_29_3 = SimBusinessTools.GetGoodLockState(arg_29_1)

				return not var_29_2 or var_29_3 ~= SimBusinessTools.State.LOCK_BY_LEVEL
			end
		end
	end

	return false
end

function var_0_0.RefreshInfo(arg_30_0, arg_30_1, arg_30_2)
	arg_30_0.shelfID = arg_30_1

	arg_30_0.shelfItem:RefreshData(arg_30_1)

	local var_30_0 = SimBusinessShelfCfg[arg_30_1]

	arg_30_0.infoPanel.name_.text = var_30_0.name
	arg_30_0.infoPanel.level_.text = SimBusinessTools.GetShelfLevelText(arg_30_1)

	local var_30_1 = SimBusinessConst.OrientationType[var_30_0.sell_direction]

	arg_30_0.infoPanel.sellDirType_.text = GetTips(var_30_1)
	arg_30_0.infoPanel.sellAbility_.text = SimBusinessTools.GetSellAbilityText(arg_30_1, arg_30_2)
end

local function var_0_5(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
		if iter_31_1 == arg_31_0 then
			return arg_31_0
		end
	end

	return nil
end

function var_0_0.RefreshGoodsList(arg_32_0, arg_32_1)
	arg_32_1 = var_0_5(arg_32_1, arg_32_0.itemList)
	arg_32_0.dirty = arg_32_0.goods ~= arg_32_1
	arg_32_0.goods = arg_32_1

	arg_32_0.goodsList:Refresh()
end

function var_0_0.RenderGoods(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0.itemList[arg_33_1]

	arg_33_2:RefreshData(var_33_0)
	arg_33_2:RefreshSelect(arg_33_0.goods == var_33_0)
	arg_33_2:SetHighlighted(arg_33_0.goodsPanel.id == var_33_0)
	arg_33_2:UseDefaultClick()
end

function var_0_0.OnGoodsItemClick(arg_34_0, arg_34_1)
	local var_34_0, var_34_1 = SimBusinessTools.GetGoodLockState(arg_34_1)

	if var_34_0 then
		SimBusinessAction.UnlockGoods({
			arg_34_1
		})
	else
		if arg_34_0.goods == arg_34_1 then
			arg_34_1 = nil
		end

		arg_34_0:RefreshGoodsList(arg_34_1)

		if arg_34_0.infoPanel.batchOpToggle_.isOn then
			SimBusinessGame.GetInstance():BatchSetShelfGoods(arg_34_0.shelfID, arg_34_1)
		else
			SimBusinessGame.GetInstance():SetShelfGoods(arg_34_0.focus, arg_34_1)
		end

		arg_34_0:RefreshInfo(arg_34_0.shelfID, arg_34_1)

		arg_34_0.dirty = true
	end
end

function var_0_0.OnShowGoodsDetail(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0.goodsPanel.id ~= arg_35_1

	if var_35_0 then
		arg_35_0.goodsPanel:RefreshView(arg_35_1)
	else
		arg_35_0.goodsPanel:RefreshView(0)
	end

	arg_35_0.showGoodsDetailController:SetSelectedState(var_35_0 and "show" or "hide")
	arg_35_0.goodsList:Refresh()
end

return var_0_0
