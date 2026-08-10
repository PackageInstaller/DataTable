local var_0_0 = class("ShelfMoveView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_FurnitureEditorUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:InitShelfEditModeDropdown()
	arg_4_0:AddUIListener()
end

function var_0_0.InitShelfEditModeDropdown(arg_5_0)
	local var_5_0 = OptionDataList.New()
	local var_5_1 = {
		"SIM_BUSINESS_SHELF_EDIT_MODE",
		"SIM_BUSINESS_SHELF_QUICK_MODIFY_MODE"
	}

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = GetTips(iter_5_1)

		var_5_0.options:Add(OptionData.New(var_5_2))
	end

	arg_5_0.modeDropdown_:AddOptions(var_5_0.options)
	arg_5_0.modeDropdown_:RefreshShownValue()
end

function var_0_0.AddUIListener(arg_6_0)
	local var_6_0 = SimBusinessGame.GetInstance()

	arg_6_0:AddBtnListenerScale(arg_6_0.cancelBtn_, nil, function()
		var_6_0:RevokeEditGoodsShelf(arg_6_0.furEntityID)
		JumpTools.Back()
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.rotateBtn_, nil, function()
		SimBusinessMgr.RotateCurEditingShelf()
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.saveBtn_, nil, function()
		if var_6_0:PlaceGoodsShelf(arg_6_0.furEntityID) then
			if arg_6_0:EnableQuickSave() then
				ShelfEditView.Save(function()
					SimBusinessData:CacheExisingShelvesBeforeEdit()
					JumpTools.Back()
				end, function()
					SimBusinessGame.GetInstance():EditExistingGoodsShelf(arg_6_0.furEntityID)
				end)
			else
				JumpTools.Back()
			end
		else
			ShowTips("SIM_BUSINESS_SHELF_CANNOT_SET")
		end
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.storageBtn_, nil, function()
		var_6_0:RemoveEntity(arg_6_0.furEntityID)

		if arg_6_0:EnableQuickSave() then
			ShelfEditView.Save(function()
				SimBusinessData:CacheExisingShelvesBeforeEdit()
				JumpTools.Back()
			end)
		else
			JumpTools.Back()
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.infoBtn_, nil, function()
		if arg_6_0.itemID and arg_6_0.itemID > 0 and SimBusinessShelfCfg[arg_6_0.itemID] then
			-- block empty
		end
	end)
	arg_6_0:AddToggleListener(arg_6_0.modeDropdown_, function(arg_15_0)
		SimBusinessTools.SetFlag("quickEditShelf", arg_15_0 ~= 0)
	end)
	arg_6_0.panelTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, handler(arg_6_0, arg_6_0.OnClick))
	arg_6_0:SetListener(arg_6_0.panelTriggerListener_)
end

function var_0_0.OnEnter(arg_16_0)
	arg_16_0.itemID = arg_16_0.params_.itemID

	if arg_16_0.params_.create then
		local var_16_0 = arg_16_0.itemID
		local var_16_1 = SimBusinessGame.GetInstance():GenerateGoodsShelf(var_16_0)

		DormLuaBridge.ChangeFurnitureState(var_16_1, DormFurnitureManager.FurnitureState.Editing, true)
		SimBusinessMgr.TryRefreshShelfCanPlace(var_16_1)
		DormLuaBridge.BeginDragFurniture(var_16_1)

		arg_16_0.furEntityID = var_16_1
		arg_16_0.params_.create = nil
	else
		arg_16_0.furEntityID = arg_16_0.params_.eid or arg_16_0.furEntityID

		SimBusinessGame.GetInstance():EditExistingGoodsShelf(arg_16_0.furEntityID)
	end

	arg_16_0:RefreshFurInfo()
end

function var_0_0.OnExit(arg_17_0)
	DormLuaBridge.ClearEditingFurniture()
end

function var_0_0.RegisterEvents(arg_18_0)
	arg_18_0:RegistEventListener("ON_FURNITURE_CLICKED", function(arg_19_0)
		if arg_18_0:EnableQuickSave() then
			arg_18_0:OnSwitchFocusShelf(arg_19_0)
		end
	end)
	arg_18_0:RegistEventListener("ON_SIM_BUSINESS_PREVIEW_PATH_UPDATE", function()
		arg_18_0.pathLenText_.text = GetTipsF("SIM_BUSINESS_ROAD_LENGTH", SimBusinessTools.GetPreviewPathLength())
	end)
end

function var_0_0.OnTop(arg_21_0)
	arg_21_0.pathLenText_.text = GetTipsF("SIM_BUSINESS_ROAD_LENGTH", SimBusinessTools.GetPreviewPathLength())

	arg_21_0:RefreshModeDropdown()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("DORM_EDIT_CANCEL"),
			OkCallback = function()
				SimBusinessGame.GetInstance():RevokeEditGoodsShelf(arg_21_0.furEntityID)
				JumpTools.Back()
			end
		})
	end)
	arg_21_0:RegisterEvents()
end

function var_0_0.OnBehind(arg_24_0)
	manager.windowBar:HideBar()
	arg_24_0:RemoveAllEventListener()
end

function var_0_0.RefreshFurInfo(arg_25_0)
	local var_25_0 = SimBusinessShelfCfg[arg_25_0.itemID]

	if var_25_0 then
		arg_25_0.nameText_.text = var_25_0.name
	end
end

function var_0_0.EnableQuickSave(arg_26_0)
	return SimBusinessTools.GetFlag("quickEditShelf")
end

function var_0_0.RefreshModeDropdown(arg_27_0)
	local var_27_0 = arg_27_0:EnableQuickSave()

	arg_27_0.modeDropdown_:SetValueWithoutNotify(var_27_0 and 1 or 0)
end

function var_0_0.OnClick(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = arg_28_2.position
	local var_28_1 = UnityEngine.Camera.main:ScreenPointToRay(var_28_0)
	local var_28_2 = UnityEngine.Physics.RaycastAll(var_28_1)

	for iter_28_0 = 0, var_28_2.Length - 1 do
		local var_28_3 = var_28_2[iter_28_0].transform:GetComponent("ShelfTrigger")

		if var_28_3 then
			var_28_3:OnPointerClick(arg_28_2)

			return
		end
	end
end

function var_0_0.OnSwitchFocusShelf(arg_29_0, arg_29_1)
	if arg_29_1 ~= arg_29_0.furEntityID and SimBusinessGame.GetInstance():PlaceGoodsShelf(arg_29_0.furEntityID) then
		ShelfEditView.Save(function()
			arg_29_0.furEntityID = arg_29_1
			arg_29_0.itemID = DormUtils.GetEntityData(arg_29_1).cfgID

			SimBusinessGame.GetInstance():EditExistingGoodsShelf(arg_29_0.furEntityID)
			SimBusinessMgr.TryRefreshShelfCanPlace(arg_29_1)
			SimBusinessData:CacheExisingShelvesBeforeEdit()
			arg_29_0:RefreshFurInfo()
		end, function()
			SimBusinessGame.GetInstance():EditExistingGoodsShelf(arg_29_0.furEntityID)
		end)
	end
end

return var_0_0
