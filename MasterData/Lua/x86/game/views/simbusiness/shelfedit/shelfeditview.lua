local ShelfEditView = class("ShelfEditView", ReduxView)

function ShelfEditView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_DormEditstatusUI"
end

function ShelfEditView:UIParent()
	return manager.ui.uiMain.transform
end

function ShelfEditView:Init()
	self:InitUI()
	self:AddUIListener()
end

function ShelfEditView:InitUI()
	self:BindCfgUI()
	self:InitShelfEditModeDropdown()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.uiList_.gameObject, ShelfEditItem)
	self.descController = ControllerUtil.GetController(self.transform_, "desc")
	self.quickEditController = ControllerUtil.GetController(self.transform_, "quickEdit")
	self.costIcon_.sprite = ItemTools.getItemSprite(SimBusinessData:GetSimBusinessFundItemID())
end

function ShelfEditView:AddUIListener()
	self:AddBtnListenerScale(self.cancelBtn_, nil, ShelfEditView.Cancel)
	self:AddBtnListenerScale(self.saveBtn_, nil, function()
		ShelfEditView.Save(JumpTools.Back, nil)
	end)
	self:AddBtnListenerScale(self.resetBtn_, nil, function()
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_EDIT_CLEAN"),
			OkCallback = function()
				SimBusinessGame.GetInstance():ClearAllGoodsShelves()

				if SimBusinessTools.GetFlag("quickEditShelf") then
					SimBusinessData:CleanupEditCache()
				end

				self:RefreshView(true)
				SimBusinessGame.GetInstance():UpdatePreviewPath()
			end
		})
	end)
	self:AddToggleListener(self.modeDropdown_, function(arg_9_0)
		if arg_9_0 ~= 0 then
			ShelfEditView.Save(function()
				SimBusinessTools.SetFlag("quickEditShelf", true)
				self.quickEditController:SetSelectedState("true")
			end, function()
				self.modeDropdown_:SetValueWithoutNotify(0)
				self.modeDropdown_:RefreshShownValue()
				SimBusinessTools.SetFlag("quickEditShelf", false)
				self.quickEditController:SetSelectedState("false")
			end)
		else
			SimBusinessData:CacheExisingShelvesBeforeEdit()
			SimBusinessTools.SetFlag("quickEditShelf", false)
			self.quickEditController:SetSelectedState("false")
		end
	end)
end

function ShelfEditView:RegisterEvents()
	self:RegistEventListener("ON_FURNITURE_CLICKED", function(arg_13_0)
		JumpTools.OpenPageByJump("/activitySummerSimBusinessMoveShelf", {
			itemID = DormUtils.GetEntityData(arg_13_0).cfgID,
			eid = arg_13_0
		})
	end)
	self:RegistEventListener("ON_SIM_BUSINESS_PREVIEW_PATH_UPDATE", function()
		self.pathLenText_.text = GetTipsF("SIM_BUSINESS_ROAD_LENGTH", SimBusinessTools.GetPreviewPathLength())
	end)
	self:RegistEventListener(CURRENCY_UPDATE, function(arg_15_0)
		if arg_15_0 == SimBusinessData:GetSimBusinessFundItemID() then
			self.scrollHelper_:Refresh()
		end
	end)
end

function ShelfEditView:OnEnter()
	self.descController:SetSelectedState("false")

	if not self.params_.isBack then
		SimBusinessData:CacheExisingShelvesBeforeEdit()
	end

	self:UpdateCostDelta()
	self:BindRedPoint()
	self:RegisterEvents()
end

function ShelfEditView:OnExit()
	self:UnBindRedPoint()
	self:RemoveAllEventListener()
end

function ShelfEditView:OnTop()
	self.pathLenText_.text = GetTipsF("SIM_BUSINESS_ROAD_LENGTH", SimBusinessTools.GetPreviewPathLength())

	self:RefreshModeDropdown()
	SimBusinessTools.SwitchBarWithFund({
		BACK_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		if SimBusinessMgr.instance.IsCalculatingPreviewPath then
			return
		end

		if SimBusinessTools.GetFlag("quickEditShelf") then
			ShelfEditView.Save(JumpTools.Back, nil)
		else
			ShelfEditView.Cancel()
		end
	end)
	self:RefreshView(true)
end

function ShelfEditView:OnBehind()
	manager.windowBar:HideBar()
end

function ShelfEditView:Dispose()
	self.scrollHelper_:Dispose()
	ShelfEditView.super.Dispose(self)
end

function ShelfEditView:BindRedPoint()
	return
end

function ShelfEditView:UnBindRedPoint()
	return
end

function ShelfEditView:RefreshModeDropdown()
	local var_24_0 = SimBusinessTools.GetFlag("quickEditShelf")

	self.modeDropdown_:SetValueWithoutNotify(var_24_0 and 1 or 0)
	self.quickEditController:SetSelectedState(var_24_0 and "true" or "false")
end

function ShelfEditView:InitShelfEditModeDropdown()
	local var_25_0 = OptionDataList.New()

	for iter_25_0, iter_25_1 in ipairs({
		"SIM_BUSINESS_SHELF_EDIT_MODE",
		"SIM_BUSINESS_SHELF_QUICK_MODIFY_MODE"
	}) do
		var_25_0.options:Add(OptionData.New((GetTips(iter_25_1))))
	end

	self.modeDropdown_:AddOptions(var_25_0.options)
	self.modeDropdown_:RefreshShownValue()
end

function ShelfEditView:Save(arg_26_1)
	if not SimBusinessMgr.instance.IsCalculatingPreviewPath then
		SimBusinessGame.GetInstance():UpdatePreviewPath(function(arg_27_0)
			if arg_27_0 ~= nil then
				SimBusinessAction.SaveShelfDeployment(SimBusinessGame.CalcShelfLayout(), SimBusinessTools.GetCurEditStage(), function()
					SimBusinessData:CleanupEditCache()

					if self then
						self()
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

function ShelfEditView.Cancel()
	if SimBusinessMgr.instance.IsCalculatingPreviewPath then
		return
	end

	SimBusinessGame.GetInstance():RestoreAllEditShelf()
	SimBusinessGame.GetInstance():UpdatePreviewPath()
	SimBusinessData:CleanupEditCache()
	JumpTools.Back()
end

function ShelfEditView:InitList()
	self.dataList = SimBusinessTools.GetShelfList()
end

function ShelfEditView:RefreshView()
	self:InitList()
	self:RefreshList()
end

function ShelfEditView:SetCurSelectItem(arg_32_1, arg_32_2)
	self.selItem = arg_32_1
	self.selIndex = arg_32_2
end

function ShelfEditView:RefreshList()
	self:SetCurSelectItem(nil, nil)
	self.scrollHelper_:StartScroll(#self.dataList)

	if self.selIndex then
		self.scrollHelper_:ScrollToIndex(self.selIndex, true, false)
	end
end

function ShelfEditView:indexItem(arg_34_1, arg_34_2)
	arg_34_2:RefreshUI(self, arg_34_1)
end

function ShelfEditView:OnShelfItemPointerDown(arg_35_1, arg_35_2)
	self:SetCurSelectItem(arg_35_2.cfgID, arg_35_2.idx)
	self.scrollHelper_:Refresh()

	if arg_35_2:IsAvailable() then
		self.descController:SetSelectedState("true")

		self.descText.text = GetTips("SIM_BUSINESS_SHELF_EDIT_INFO")
	elseif SimBusinessTools.CheckDeployNewShelfCostOver(arg_35_2.cfgID) then
		self.descController:SetSelectedState("true")

		self.descText.text = GetTips("SIM_BUSINESS_NOT_ENOUGH_COST")
	end
end

local function var_0_1(arg_36_0, arg_36_1)
	return arg_36_0.pointerId
end

function ShelfEditView:OnShelfItemBeginDrag(arg_37_1, arg_37_2)
	if not self.dragging then
		self.dragging = var_0_1(arg_37_1, arg_37_2)

		self.uiList_:OnBeginDrag(arg_37_1)
	end
end

function ShelfEditView:OnShelfItemDrag(arg_38_1, arg_38_2)
	if self.dragging and self.dragging == var_0_1(arg_38_1, arg_38_2) and self:DragOutOfArea(arg_38_1) and arg_38_2:IsAvailable() and not SimBusinessMgr.instance.IsCalculatingPreviewPath then
		self.dragging = nil

		self.uiList_:OnEndDrag(arg_38_1)
		self:GenNewShelf(arg_38_2.cfgID)
	else
		self.uiList_:OnDrag(arg_38_1)
	end
end

function ShelfEditView:OnShelfItemEndDrag(arg_39_1, arg_39_2)
	if self.dragging then
		self.dragging = nil

		self.uiList_:OnEndDrag(arg_39_1)
	end
end

function ShelfEditView:DragOutOfArea(arg_40_1)
	return not UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(self.dragOutArea_, arg_40_1.position, manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera)
end

function ShelfEditView:GenNewShelf(arg_41_1)
	if not SimBusinessMgr.instance.IsCalculatingPreviewPath then
		self.descController:SetSelectedState("false")
		JumpTools.OpenPageByJump("/activitySummerSimBusinessMoveShelf", {
			create = true,
			itemID = arg_41_1
		})
	end
end

function ShelfEditView:UpdateCostDelta()
	self.cost_.text = string.format("%+d", SimBusinessTools.CalcEditCacheShelfCostFund() - SimBusinessTools.CalcRealtimeShelfTotalCostFund())
end

return ShelfEditView
