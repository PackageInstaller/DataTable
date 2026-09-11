local ShelfMoveView = class("ShelfMoveView", ReduxView)

function ShelfMoveView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_FurnitureEditorUI"
end

function ShelfMoveView:UIParent()
	return manager.ui.uiMain.transform
end

function ShelfMoveView:OnCtor()
	return
end

function ShelfMoveView:Init()
	self:BindCfgUI()
	self:InitShelfEditModeDropdown()
	self:AddUIListener()
end

function ShelfMoveView:InitShelfEditModeDropdown()
	local var_5_0 = OptionDataList.New()

	for iter_5_0, iter_5_1 in ipairs({
		"SIM_BUSINESS_SHELF_EDIT_MODE",
		"SIM_BUSINESS_SHELF_QUICK_MODIFY_MODE"
	}) do
		var_5_0.options:Add(OptionData.New((GetTips(iter_5_1))))
	end

	self.modeDropdown_:AddOptions(var_5_0.options)
	self.modeDropdown_:RefreshShownValue()
end

function ShelfMoveView:AddUIListener()
	local var_6_0 = SimBusinessGame.GetInstance()

	self:AddBtnListenerScale(self.cancelBtn_, nil, function()
		var_6_0:RevokeEditGoodsShelf(self.furEntityID)
		JumpTools.Back()
	end)
	self:AddBtnListenerScale(self.rotateBtn_, nil, function()
		SimBusinessMgr.RotateCurEditingShelf()
	end)
	self:AddBtnListenerScale(self.saveBtn_, nil, function()
		if var_6_0:PlaceGoodsShelf(self.furEntityID) then
			if self:EnableQuickSave() then
				ShelfEditView.Save(function()
					SimBusinessData:CacheExisingShelvesBeforeEdit()
					JumpTools.Back()
				end, function()
					SimBusinessGame.GetInstance():EditExistingGoodsShelf(self.furEntityID)
				end)
			else
				JumpTools.Back()
			end
		else
			ShowTips("SIM_BUSINESS_SHELF_CANNOT_SET")
		end
	end)
	self:AddBtnListenerScale(self.storageBtn_, nil, function()
		var_6_0:RemoveEntity(self.furEntityID)

		if self:EnableQuickSave() then
			ShelfEditView.Save(function()
				SimBusinessData:CacheExisingShelvesBeforeEdit()
				JumpTools.Back()
			end)
		else
			JumpTools.Back()
		end
	end)
	self:AddBtnListener(self.infoBtn_, nil, function()
		if self.itemID and self.itemID > 0 and SimBusinessShelfCfg[self.itemID] then
			-- block empty
		end
	end)
	self:AddToggleListener(self.modeDropdown_, function(arg_15_0)
		SimBusinessTools.SetFlag("quickEditShelf", arg_15_0 ~= 0)
	end)
	self.panelTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, handler(self, self.OnClick))
	self:SetListener(self.panelTriggerListener_)
end

function ShelfMoveView:OnEnter()
	self.itemID = self.params_.itemID

	if self.params_.create then
		local var_16_0 = SimBusinessGame.GetInstance():GenerateGoodsShelf(self.itemID)

		DormLuaBridge.ChangeFurnitureState(var_16_0, DormFurnitureManager.FurnitureState.Editing, true)
		SimBusinessMgr.TryRefreshShelfCanPlace(var_16_0)
		DormLuaBridge.BeginDragFurniture(var_16_0)

		self.furEntityID = var_16_0
		self.params_.create = nil
	else
		self.furEntityID = self.params_.eid or self.furEntityID

		SimBusinessGame.GetInstance():EditExistingGoodsShelf(self.furEntityID)
	end

	self:RefreshFurInfo()
end

function ShelfMoveView:OnExit()
	DormLuaBridge.ClearEditingFurniture()
end

function ShelfMoveView:RegisterEvents()
	self:RegistEventListener("ON_FURNITURE_CLICKED", function(arg_19_0)
		if self:EnableQuickSave() then
			self:OnSwitchFocusShelf(arg_19_0)
		end
	end)
	self:RegistEventListener("ON_SIM_BUSINESS_PREVIEW_PATH_UPDATE", function()
		self.pathLenText_.text = GetTipsF("SIM_BUSINESS_ROAD_LENGTH", SimBusinessTools.GetPreviewPathLength())
	end)
end

function ShelfMoveView:OnTop()
	self.pathLenText_.text = GetTipsF("SIM_BUSINESS_ROAD_LENGTH", SimBusinessTools.GetPreviewPathLength())

	self:RefreshModeDropdown()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		ShowMessageBox({
			content = GetTips("DORM_EDIT_CANCEL"),
			OkCallback = function()
				SimBusinessGame.GetInstance():RevokeEditGoodsShelf(self.furEntityID)
				JumpTools.Back()
			end
		})
	end)
	self:RegisterEvents()
end

function ShelfMoveView:OnBehind()
	manager.windowBar:HideBar()
	self:RemoveAllEventListener()
end

function ShelfMoveView:RefreshFurInfo()
	if SimBusinessShelfCfg[self.itemID] then
		self.nameText_.text = SimBusinessShelfCfg[self.itemID].name
	end
end

function ShelfMoveView:EnableQuickSave()
	return SimBusinessTools.GetFlag("quickEditShelf")
end

function ShelfMoveView:RefreshModeDropdown()
	self.modeDropdown_:SetValueWithoutNotify(self:EnableQuickSave() and 1 or 0)
end

function ShelfMoveView:OnClick(arg_28_1, arg_28_2)
	local var_28_0 = UnityEngine.Physics.RaycastAll((UnityEngine.Camera.main:ScreenPointToRay(arg_28_2.position)))

	for iter_28_0 = 0, var_28_0.Length - 1 do
		local var_28_1 = var_28_0[iter_28_0].transform:GetComponent("ShelfTrigger")

		if var_28_1 then
			var_28_1:OnPointerClick(arg_28_2)

			return
		end
	end
end

function ShelfMoveView:OnSwitchFocusShelf(arg_29_1)
	if arg_29_1 ~= self.furEntityID then
		if SimBusinessGame.GetInstance():PlaceGoodsShelf(self.furEntityID) then
			ShelfEditView.Save(function()
				self.furEntityID = arg_29_1
				self.itemID = DormUtils.GetEntityData(arg_29_1).cfgID

				SimBusinessGame.GetInstance():EditExistingGoodsShelf(self.furEntityID)
				SimBusinessMgr.TryRefreshShelfCanPlace(arg_29_1)
				SimBusinessData:CacheExisingShelvesBeforeEdit()
				self:RefreshFurInfo()
			end, function()
				SimBusinessGame.GetInstance():EditExistingGoodsShelf(self.furEntityID)
			end)
		end
	end
end

return ShelfMoveView
