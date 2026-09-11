local AutoChessCardDetailView = class("AutoChessCardDetailView", ReduxView)

function AutoChessCardDetailView:UIName()
	return "Widget/System/Activity_AutoChess_Main/Illustrated/Activity_AutoChess_IllustratedDetailUI"
end

function AutoChessCardDetailView:UIParent()
	return manager.ui.uiMain.transform
end

function AutoChessCardDetailView:Init()
	self:InitUI()
	self:AddListeners()
end

function AutoChessCardDetailView:InitUI()
	self:BindCfgUI()

	self.rightPanelController_ = self.controller_:GetController("rightPanel")
	self.switchController_ = self.controller_:GetController("switch")
	self.sunglassesController_ = self.controller_:GetController("sunglasses")
	self.tabListController_ = self.controller_:GetController("tab")
	self.tabSwitchController_ = self.tabController_:GetController("switch")
	self.tipsItem_ = AutoChessCardTipsItem.New(self.tipsGo_)
	self.mixItem_ = AutoChessCardMixItem.New(self.mixGo_)
	self.cardItem_ = AutoChessCardItem.New(self.cardGo_)
	self.chessItem_ = AutoChessShowItem.New(self.chessGo_)
	self.URFactoryItem_ = AutoChessURFactoryItem.New(self.URItemGo_)
end

function AutoChessCardDetailView:AddListeners()
	self:AddBtnListener(self.uRBtn_, nil, function()
		self.cardId_ = self.cardList[AutoChessCardConst.CARD_TYPE.UR]

		self:RefreshUI()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_rarity_touch",
			type = 3,
			activity_id = AutoChessData:GetActivityID(),
			item_id = self.cardId_
		})
	end)
	self:AddBtnListener(self.sRBtn_, nil, function()
		self.cardId_ = self.cardList[AutoChessCardConst.CARD_TYPE.SR]

		self:RefreshUI()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_rarity_touch",
			type = 2,
			activity_id = AutoChessData:GetActivityID(),
			item_id = self.cardId_
		})
	end)
	self:AddBtnListener(self.rBtn_, nil, function(arg_8_0)
		self.cardId_ = self.cardList[AutoChessCardConst.CARD_TYPE.R]

		self:RefreshUI()
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_rarity_touch",
			type = 1,
			activity_id = AutoChessData:GetActivityID(),
			item_id = self.cardId_
		})
	end)
	self:AddBtnListener(self.mixBtn_, nil, function()
		self.rightPanelController_:SetSelectedState("mixPanel")
		self.mixItem_:SetData(self.cardId_)
	end)
	self:AddBtnListener(self.sunglassesOnBtn_, nil, function()
		if self.isOpen then
			return
		end

		self.isOpen = true

		AutoChessCardAction.RequestSunglasses(handler(self, self.OnSunglassesBack), 1)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_special_change_touch",
			type = 1,
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	self:AddBtnListener(self.sunglassesOffBtn_, nil, function()
		if not self.isOpen then
			return
		end

		self.isOpen = false

		AutoChessCardAction.RequestSunglasses(handler(self, self.OnSunglassesBack), 2)
		OperationRecorder.RecordButtonTouch({
			button_name = "activity_autochess_item_special_change_touch",
			type = 2,
			activity_id = AutoChessData:GetActivityID()
		})
	end)
	self:AddBtnListener(self.leftBtn_, nil, function()
		local var_12_0 = table.indexof(AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardCfg[self.cardId_].type][1], self.cardId_)

		self.cardId_ = var_12_0 == 1 and AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardCfg[self.cardId_].type][1][#AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardCfg[self.cardId_].type][1]] or AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardCfg[self.cardId_].type][1][var_12_0 - 1]

		self:Refresh()
		self:RefreshUI()
	end)
	self:AddBtnListener(self.rightBtn_, nil, function()
		local var_13_0 = table.indexof(AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardCfg[self.cardId_].type][1], self.cardId_)

		self.cardId_ = var_13_0 == #AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardCfg[self.cardId_].type][1] and AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardCfg[self.cardId_].type][1][1] or AutoChessCardCfg.get_id_list_by_type_is_card_pool[AutoChessCardCfg[self.cardId_].type][1][var_13_0 + 1]

		self:Refresh()
		self:RefreshUI()
	end)
end

function AutoChessCardDetailView:OnSunglassesBack()
	self:RefreshSwitch()
end

function AutoChessCardDetailView:OnEnter()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.OnBeginDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.OnDragFun)))
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.OnEndDragFun)))

	self.cardId_ = self.params_.cardId

	self:Refresh()
end

function AutoChessCardDetailView:Refresh()
	self.chessId_ = AutoChessCardTools.GetChessId(self.cardId_)
	self.cardList = AutoChessCardCfg.get_id_list_by_group_id[AutoChessCardCfg[self.cardId_].group_id]

	table.sort(self.cardList, function(arg_17_0, arg_17_1)
		return AutoChessCardCfg[arg_17_0].type < AutoChessCardCfg[arg_17_1].type
	end)
	self.tabListController_:SetSelectedIndex(#self.cardList - 1)
	self:RefreshSwitch()
end

function AutoChessCardDetailView:RefreshSwitch()
	if AutoChessCardData:GetSunglassesState() == 0 then
		self.switchController_:SetSelectedState("hide")
		self.chessItem_:RefreshSunglassesState(0)
	elseif AutoChessCardData:GetSunglassesState() == 1 then
		self.isOpen = true

		self.switchController_:SetSelectedState("show")
		self.sunglassesController_:SetSelectedState("on")
		self.chessItem_:RefreshSunglassesState(1)
	else
		self.isOpen = false

		self.switchController_:SetSelectedState("show")
		self.sunglassesController_:SetSelectedState("off")
		self.chessItem_:RefreshSunglassesState(2)
	end
end

function AutoChessCardDetailView:RefreshUI()
	local var_19_0 = AutoChessCardCfg[self.cardId_]

	self.cardItem_:SetData(self.cardId_, self.URFactoryItem_:GetItem(self.cardId_))
	self.chessItem_:SetData(self.cardId_, self.chessId_, AutoChessCardData:GetSunglassesState())

	if AutoChessCardData:GetCardNum(self.cardId_) > 0 then
		self.isDragable_ = true

		self.cardItem_:SetPositionState(true)
		self.cardItem_:SetGreyState(false)
		self.anim_:Play("Container_light_ani")
	else
		self.isDragable_ = false

		self.cardItem_:SetPositionState(false)
		self.cardItem_:SetGreyState(true)
		self.anim_:Play("default")
	end

	self.rightPanelController_:SetSelectedState("tipsPanel")
	self.tipsItem_:SetData(self.chessId_, self.cardId_)

	if var_19_0.type == AutoChessCardConst.CARD_TYPE.R then
		self.tabSwitchController_:SetSelectedState("state2")
	elseif var_19_0.type == AutoChessCardConst.CARD_TYPE.SR then
		self.tabSwitchController_:SetSelectedState("state1")
	else
		self.tabSwitchController_:SetSelectedState("state0")
	end
end

function AutoChessCardDetailView:OnBeginDragFun()
	if not self.isDragable_ then
		return
	end

	self.isDraging_ = true

	local var_20_0, var_20_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.cardTrans_, Vector2.New(Input.mousePosition.x, Input.mousePosition.y), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

	self.dragStartPos_ = var_20_1

	self.anim_:Play("default")

	self.anim_.applyRootMotion = true
	self.initRotation_ = self.cardTrans_.localEulerAngles
end

function AutoChessCardDetailView:OnDragFun()
	if not self.isDragable_ then
		return
	end

	if not self.isDraging_ then
		return
	end

	local var_21_0, var_21_1 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.cardTrans_, Vector2.New(Input.mousePosition.x, Input.mousePosition.y), manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera, {})

	self.cardTrans_.localEulerAngles = Vector3.New(math.min(30, math.max(-30, self:NormalizeAngle(self.initRotation_.x + (var_21_1.y - self.dragStartPos_.y) * 0.1))), math.min(30, math.max(-30, self:NormalizeAngle(self.initRotation_.y - (var_21_1.x - self.dragStartPos_.x) * 0.1))), self.cardTrans_.localEulerAngles.z)
end

function AutoChessCardDetailView:OnEndDragFun(arg_22_1)
	if not self.isDragable_ then
		return
	end

	self.isDraging_ = false
	self.anim_.applyRootMotion = false

	self.anim_:Play("Container_light_ani")
end

function AutoChessCardDetailView:NormalizeAngle(arg_23_1)
	local var_23_0 = arg_23_1 % 360

	var_23_0 = arg_23_1 % 360 > 180 and var_23_0 - 360 or var_23_0 < -180 and var_23_0 + 360 or var_23_0

	return var_23_0
end

function AutoChessCardDetailView:OnTop()
	self:RefreshUI()
	manager.windowBar:SwitchBar({
		HOME_BAR,
		BACK_BAR
	})
end

function AutoChessCardDetailView:OnExit()
	manager.windowBar:HideBar()
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self.eventTriggerListener_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.anim_:Rebind()
end

function AutoChessCardDetailView:Dispose()
	self.cardItem_:Dispose()
	self.tipsItem_:Dispose()
	self.mixItem_:Dispose()
	self.chessItem_:Dispose()
	self.URFactoryItem_:Dispose()
	AutoChessCardDetailView.super.Dispose(self)
end

return AutoChessCardDetailView
