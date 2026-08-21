local var_0_0 = class("ShelfEditView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_DormEditstatusUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitShelfEditModeDropdown()

	arg_4_0.scrollHelper_ = LuaList.New(handler(arg_4_0, arg_4_0.indexItem), arg_4_0.uiList_.gameObject, ShelfEditItem)
	arg_4_0.descController = ControllerUtil.GetController(arg_4_0.transform_, "desc")
	arg_4_0.quickEditController = ControllerUtil.GetController(arg_4_0.transform_, "quickEdit")
	arg_4_0.costIcon_.sprite = ItemTools.getItemSprite(SimBusinessData:GetSimBusinessFundItemID())
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListenerScale(arg_5_0.cancelBtn_, nil, var_0_0.Cancel)
	arg_5_0:AddBtnListenerScale(arg_5_0.saveBtn_, nil, function()
		var_0_0.Save(JumpTools.Back, nil)
	end)
	arg_5_0:AddBtnListenerScale(arg_5_0.resetBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_EDIT_CLEAN"),
			OkCallback = function()
				SimBusinessGame.GetInstance():ClearAllGoodsShelves()

				if SimBusinessTools.GetFlag("quickEditShelf") then
					SimBusinessData:CleanupEditCache()
				end

				arg_5_0:RefreshView(true)
				SimBusinessGame.GetInstance():UpdatePreviewPath()
			end
		})
	end)
	arg_5_0:AddToggleListener(arg_5_0.modeDropdown_, function(arg_9_0)
		if arg_9_0 ~= 0 then
			var_0_0.Save(function()
				SimBusinessTools.SetFlag("quickEditShelf", true)
				arg_5_0.quickEditController:SetSelectedState("true")
			end, function()
				arg_5_0.modeDropdown_:SetValueWithoutNotify(0)
				arg_5_0.modeDropdown_:RefreshShownValue()
				SimBusinessTools.SetFlag("quickEditShelf", false)
				arg_5_0.quickEditController:SetSelectedState("false")
			end)
		else
			SimBusinessData:CacheExisingShelvesBeforeEdit()
			SimBusinessTools.SetFlag("quickEditShelf", false)
			arg_5_0.quickEditController:SetSelectedState("false")
		end
	end)
end

function var_0_0.RegisterEvents(arg_12_0)
	arg_12_0:RegistEventListener("ON_FURNITURE_CLICKED", function(arg_13_0)
		local var_13_0 = DormUtils.GetEntityData(arg_13_0).cfgID

		JumpTools.OpenPageByJump("/activitySummerSimBusinessMoveShelf", {
			itemID = var_13_0,
			eid = arg_13_0
		})
	end)
	arg_12_0:RegistEventListener("ON_SIM_BUSINESS_PREVIEW_PATH_UPDATE", function()
		arg_12_0.pathLenText_.text = GetTipsF("SIM_BUSINESS_ROAD_LENGTH", SimBusinessTools.GetPreviewPathLength())
	end)
	arg_12_0:RegistEventListener(CURRENCY_UPDATE, function(arg_15_0)
		if arg_15_0 == SimBusinessData:GetSimBusinessFundItemID() then
			arg_12_0.scrollHelper_:Refresh()
		end
	end)
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.descController:SetSelectedState("false")

	if not arg_16_0.params_.isBack then
		SimBusinessData:CacheExisingShelvesBeforeEdit()
	end

	arg_16_0:UpdateCostDelta()
	arg_16_0:BindRedPoint()
	arg_16_0:RegisterEvents()
end

function var_0_0.OnExit(arg_17_0)
	arg_17_0:UnBindRedPoint()
	arg_17_0:RemoveAllEventListener()
end

function var_0_0.OnTop(arg_18_0)
	arg_18_0.pathLenText_.text = GetTipsF("SIM_BUSINESS_ROAD_LENGTH", SimBusinessTools.GetPreviewPathLength())

	arg_18_0:RefreshModeDropdown()
	SimBusinessTools.SwitchBarWithFund({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if SimBusinessMgr.instance.IsCalculatingPreviewPath then
			return
		end

		if SimBusinessTools.GetFlag("quickEditShelf") then
			var_0_0.Save(JumpTools.Back, nil)
		else
			var_0_0.Cancel()
		end
	end)
	arg_18_0:RefreshView(true)
end

function var_0_0.OnBehind(arg_20_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0.scrollHelper_:Dispose()
	var_0_0.super.Dispose(arg_21_0)
end

function var_0_0.BindRedPoint(arg_22_0)
	return
end

function var_0_0.UnBindRedPoint(arg_23_0)
	return
end

function var_0_0.RefreshModeDropdown(arg_24_0)
	local var_24_0 = SimBusinessTools.GetFlag("quickEditShelf")

	arg_24_0.modeDropdown_:SetValueWithoutNotify(var_24_0 and 1 or 0)
	arg_24_0.quickEditController:SetSelectedState(var_24_0 and "true" or "false")
end

function var_0_0.InitShelfEditModeDropdown(arg_25_0)
	local var_25_0 = OptionDataList.New()
	local var_25_1 = {
		"SIM_BUSINESS_SHELF_EDIT_MODE",
		"SIM_BUSINESS_SHELF_QUICK_MODIFY_MODE"
	}

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		local var_25_2 = GetTips(iter_25_1)

		var_25_0.options:Add(OptionData.New(var_25_2))
	end

	arg_25_0.modeDropdown_:AddOptions(var_25_0.options)
	arg_25_0.modeDropdown_:RefreshShownValue()
end

function var_0_0.Save(arg_26_0, arg_26_1)
	if not SimBusinessMgr.instance.IsCalculatingPreviewPath then
		SimBusinessGame.GetInstance():UpdatePreviewPath(function(arg_27_0)
			if arg_27_0 ~= nil then
				local var_27_0 = SimBusinessTools.GetCurEditStage()

				SimBusinessAction.SaveShelfDeployment(SimBusinessGame.CalcShelfLayout(), var_27_0, function()
					SimBusinessData:CleanupEditCache()

					if arg_26_0 then
						arg_26_0()
					end
				end)
			else
				ShowTips("SIM_BUSINESS_NO_VALID_PATH")

				if arg_26_1 then
					arg_26_1()
				end
			end
		end)
	end
end

function var_0_0.Cancel()
	if SimBusinessMgr.instance.IsCalculatingPreviewPath then
		return
	end

	SimBusinessGame.GetInstance():RestoreAllEditShelf()
	SimBusinessGame.GetInstance():UpdatePreviewPath()
	SimBusinessData:CleanupEditCache()
	JumpTools.Back()
end

function var_0_0.InitList(arg_30_0)
	arg_30_0.dataList = SimBusinessTools.GetShelfList()
end

function var_0_0.RefreshView(arg_31_0)
	arg_31_0:InitList()
	arg_31_0:RefreshList()
end

function var_0_0.SetCurSelectItem(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0.selItem = arg_32_1
	arg_32_0.selIndex = arg_32_2
end

function var_0_0.RefreshList(arg_33_0)
	arg_33_0:SetCurSelectItem(nil, nil)
	arg_33_0.scrollHelper_:StartScroll(#arg_33_0.dataList)

	if arg_33_0.selIndex then
		arg_33_0.scrollHelper_:ScrollToIndex(arg_33_0.selIndex, true, false)
	end
end

function var_0_0.indexItem(arg_34_0, arg_34_1, arg_34_2)
	arg_34_2:RefreshUI(arg_34_0, arg_34_1)
end

function var_0_0.OnShelfItemPointerDown(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_2.cfgID
	local var_35_1 = arg_35_2.idx

	arg_35_0:SetCurSelectItem(var_35_0, var_35_1)
	arg_35_0.scrollHelper_:Refresh()

	if arg_35_2:IsAvailable() then
		arg_35_0.descController:SetSelectedState("true")

		arg_35_0.descText.text = GetTips("SIM_BUSINESS_SHELF_EDIT_INFO")
	elseif SimBusinessTools.CheckDeployNewShelfCostOver(var_35_0) then
		arg_35_0.descController:SetSelectedState("true")

		arg_35_0.descText.text = GetTips("SIM_BUSINESS_NOT_ENOUGH_COST")
	end
end

local function var_0_1(arg_36_0, arg_36_1)
	return arg_36_0.pointerId
end

function var_0_0.OnShelfItemBeginDrag(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_2.cfgID
	local var_37_1 = arg_37_2.idx

	if not arg_37_0.dragging then
		arg_37_0.dragging = var_0_1(arg_37_1, arg_37_2)

		arg_37_0.uiList_:OnBeginDrag(arg_37_1)
	end
end

function var_0_0.OnShelfItemDrag(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_2.cfgID
	local var_38_1 = arg_38_2.idx
	local var_38_2 = var_0_1(arg_38_1, arg_38_2)
	local var_38_3 = arg_38_0.dragging and arg_38_0.dragging == var_38_2 and arg_38_0:DragOutOfArea(arg_38_1)
	local var_38_4 = arg_38_2:IsAvailable()

	if var_38_3 and var_38_4 and not SimBusinessMgr.instance.IsCalculatingPreviewPath then
		arg_38_0.dragging = nil

		arg_38_0.uiList_:OnEndDrag(arg_38_1)
		arg_38_0:GenNewShelf(var_38_0)
	else
		arg_38_0.uiList_:OnDrag(arg_38_1)
	end
end

function var_0_0.OnShelfItemEndDrag(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_0.dragging then
		arg_39_0.dragging = nil

		arg_39_0.uiList_:OnEndDrag(arg_39_1)
	end
end

function var_0_0.DragOutOfArea(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1.position
	local var_40_1 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	return not UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_40_0.dragOutArea_, var_40_0, var_40_1)
end

function var_0_0.GenNewShelf(arg_41_0, arg_41_1)
	if not SimBusinessMgr.instance.IsCalculatingPreviewPath then
		arg_41_0.descController:SetSelectedState("false")
		JumpTools.OpenPageByJump("/activitySummerSimBusinessMoveShelf", {
			create = true,
			itemID = arg_41_1
		})
	end
end

function var_0_0.UpdateCostDelta(arg_42_0)
	local var_42_0 = SimBusinessTools.CalcEditCacheShelfCostFund()
	local var_42_1 = SimBusinessTools.CalcRealtimeShelfTotalCostFund()

	arg_42_0.cost_.text = string.format("%+d", var_42_0 - var_42_1)
end

return var_0_0
