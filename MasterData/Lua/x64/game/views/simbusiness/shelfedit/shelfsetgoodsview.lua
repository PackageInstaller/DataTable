local ShelfSetGoodsView = class("ShelfSetGoodsView", ReduxView)

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
	return arg_3_0[(arg_3_1 - 1) % #arg_3_0 + 1]
end

function ShelfSetGoodsView:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/SummerUI_3_5_SetGoodsUI"
end

function ShelfSetGoodsView:UIParent()
	return manager.ui.uiMain.transform
end

local var_0_3 = class("ShelfSetGoodsView.ShelfSetGoodsItem", SimBusinessGoodsItem)

function var_0_3:Init()
	var_0_3.super.Init(self)

	self.highlightController = self.controllerExCollection_:GetController("award")
end

function var_0_3:AddUIListener()
	var_0_3.super.AddUIListener(self)
	self:AddBtnListener(self.showDetailBtn_, nil, function()
		manager.notify:CallFirstUpdateFunc("OnShowGoodsDetail", self.id)
	end)
end

function var_0_3:SetHighlighted(arg_9_1)
	self.highlightController:SetSelectedState(arg_9_1 and "on" or "off")
end

function ShelfSetGoodsView:Init()
	self:BindCfgUI()

	self.infoPanel = {}
	self.showGoodsDetailController = self.controllers_:GetController("goodsDetail")

	self:BindCfgUI(self.infoPanel_, self.infoPanel)

	self.shelfItem = SimBusinessShelfItem.New(self.infoPanel.shelfItemObj_)
	self.goodsList = LuaList.New(handler(self, self.RenderGoods), self.infoPanel.goodsList_.gameObject, var_0_3)
	self.goodsPanel = SimBusinessGoodPage.New(self.goodsInfo_)

	self:AddUIListener()
end

function ShelfSetGoodsView:Dispose()
	self.goodsList:Dispose()
	self.shelfItem:Dispose()
	self.goodsPanel:Dispose()
	ShelfSetGoodsView.super.Dispose(self)
end

function ShelfSetGoodsView:OnEnter()
	self.cacheSortedShelfList = var_0_1()

	self:FocusOnShelf(self.params_.eid)
	self:RegisterEvents()
end

function ShelfSetGoodsView:OnExit()
	self:RemoveAllEventListener()
	self:FocusOnShelf(nil)

	self.cacheSortedShelfList = nil
end

function ShelfSetGoodsView:OnTop()
	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function ShelfSetGoodsView:OnBehind()
	manager.windowBar:HideBar()
end

function ShelfSetGoodsView:OnEventRefreshView()
	self.goodsList:Refresh()
end

function ShelfSetGoodsView:AddUIListener()
	self:AddToggleListener(self.infoPanel.batchOpToggle_, function(arg_18_0)
		if arg_18_0 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("SIM_BUSINESS_BATCH_SET_GOODS_TIPS"),
				CancelCallback = function()
					self.infoPanel.batchOpToggle_:SetIsOnWithoutNotify(false)
					self.infoPanel.batchOpToggle_:UpdateControllerValue()
				end
			})
		end
	end)
	self:AddBtnListenerScale(self.prevBtn_, nil, function()
		self:FocusOnShelf(self:FindPrevShelf())
	end)
	self:AddBtnListenerScale(self.nextBtn_, nil, function()
		self:FocusOnShelf(self:FindNextShelf())
	end)

	self.emptyArea_.onPointerClick = LuaHelper.EventTriggerAction1(function(arg_22_0, arg_22_1)
		if self.showGoodsDetailController:GetSelectedState() == "show" then
			self.goodsPanel:RefreshView(0)
			self.goodsList:Refresh()
			self.showGoodsDetailController:SetSelectedState("hide")
		else
			local var_22_0 = UnityEngine.Physics.RaycastAll((UnityEngine.Camera.main:ScreenPointToRay(arg_22_1.position)))

			for iter_22_0 = 0, var_22_0.Length - 1 do
				local var_22_1 = var_22_0[iter_22_0].transform:GetComponent("ShelfTrigger")

				if var_22_1 then
					var_22_1:OnPointerClick(arg_22_1)

					return
				end
			end

			JumpTools.Back()
		end
	end)

	self:SetListener(self.emptyArea_)
end

function ShelfSetGoodsView:RegisterEvents()
	self:RegistEventListener("ON_FURNITURE_CLICKED", handler(self, self.FocusOnShelf))
end

local function var_0_4(arg_24_0, arg_24_1)
	if arg_24_0 and Dorm.DormEntityManager.IsValidEntityID(arg_24_0) then
		Dorm.DormEntityManager.SetHighlighted(arg_24_0, arg_24_1)
	end
end

function ShelfSetGoodsView:FocusOnShelf(arg_25_1)
	if arg_25_1 == self.focus then
		return
	end

	if self.dirty then
		SimBusinessAction.SaveShelfDeployment(SimBusinessGame.CalcShelfLayout(), (SimBusinessTools.GetCurEditStage()))

		self.dirty = nil
	end

	var_0_4(self.focus, false)

	self.focus = arg_25_1

	var_0_4(arg_25_1, true)

	self.itemList = SimBusinessTools.GetFilteredGoodsList(handler(self, self.FilterShelfAcceptGoods))

	self.goodsList:StartScroll(#self.itemList)
	self:RefreshPanel()
end

function ShelfSetGoodsView:FindPrevShelf()
	for iter_26_0, iter_26_1 in ipairs(self.cacheSortedShelfList) do
		if iter_26_1.eid == self.focus then
			return var_0_2(self.cacheSortedShelfList, iter_26_0 - 1).eid
		end
	end
end

function ShelfSetGoodsView:FindNextShelf()
	for iter_27_0, iter_27_1 in ipairs(self.cacheSortedShelfList) do
		if iter_27_1.eid == self.focus then
			return var_0_2(self.cacheSortedShelfList, iter_27_0 + 1).eid
		end
	end
end

function ShelfSetGoodsView:RefreshPanel()
	if self.focus then
		local var_28_0 = DormUtils.GetEntityData(self.focus)

		self:RefreshInfo(var_28_0.cfgID, var_28_0.goods)
		self:RefreshGoodsList(var_28_0.goods)
	end
end

function ShelfSetGoodsView:FilterShelfAcceptGoods(arg_29_1)
	if self.focus then
		for iter_29_0, iter_29_1 in ipairs(SimBusinessShelfCfg[DormUtils.GetEntityData(self.focus).cfgID].sell_type) do
			if iter_29_1 == SimBusinessGoodsCfg[arg_29_1].type then
				local var_29_0, var_29_1 = SimBusinessTools.GetGoodLockState(arg_29_1)

				return not var_29_0 or var_29_1 ~= SimBusinessTools.State.LOCK_BY_LEVEL
			end
		end
	end

	return false
end

function ShelfSetGoodsView:RefreshInfo(arg_30_1, arg_30_2)
	self.shelfID = arg_30_1

	self.shelfItem:RefreshData(arg_30_1)

	self.infoPanel.name_.text = SimBusinessShelfCfg[arg_30_1].name
	self.infoPanel.level_.text = SimBusinessTools.GetShelfLevelText(arg_30_1)
	self.infoPanel.sellDirType_.text = GetTips(SimBusinessConst.OrientationType[SimBusinessShelfCfg[arg_30_1].sell_direction])
	self.infoPanel.sellAbility_.text = SimBusinessTools.GetSellAbilityText(arg_30_1, arg_30_2)
end

local function var_0_5(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in ipairs(arg_31_1) do
		if iter_31_1 == arg_31_0 then
			return arg_31_0
		end
	end

	return nil
end

function ShelfSetGoodsView:RefreshGoodsList(arg_32_1)
	arg_32_1 = var_0_5(arg_32_1, self.itemList)
	self.dirty = self.goods ~= arg_32_1
	self.goods = arg_32_1

	self.goodsList:Refresh()
end

function ShelfSetGoodsView:RenderGoods(arg_33_1, arg_33_2)
	local var_33_0 = self.itemList[arg_33_1]

	arg_33_2:RefreshData(self.itemList[arg_33_1])
	arg_33_2:RefreshSelect(self.goods == var_33_0)
	arg_33_2:SetHighlighted(self.goodsPanel.id == var_33_0)
	arg_33_2:UseDefaultClick()
end

function ShelfSetGoodsView:OnGoodsItemClick(arg_34_1)
	local var_34_0, var_34_1 = SimBusinessTools.GetGoodLockState(arg_34_1)

	if var_34_0 then
		SimBusinessAction.UnlockGoods({
			arg_34_1
		})
	else
		if self.goods == arg_34_1 then
			arg_34_1 = nil
		end

		self:RefreshGoodsList(arg_34_1)

		if self.infoPanel.batchOpToggle_.isOn then
			SimBusinessGame.GetInstance():BatchSetShelfGoods(self.shelfID, arg_34_1)
		else
			SimBusinessGame.GetInstance():SetShelfGoods(self.focus, arg_34_1)
		end

		self:RefreshInfo(self.shelfID, arg_34_1)

		self.dirty = true
	end
end

function ShelfSetGoodsView:OnShowGoodsDetail(arg_35_1)
	local var_35_0 = self.goodsPanel.id ~= arg_35_1

	if self.goodsPanel.id ~= arg_35_1 then
		self.goodsPanel:RefreshView(arg_35_1)
	else
		self.goodsPanel:RefreshView(0)
	end

	self.showGoodsDetailController:SetSelectedState(var_35_0 and "show" or "hide")
	self.goodsList:Refresh()
end

return ShelfSetGoodsView
