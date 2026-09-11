local DanceActionItem = class("DanceActionItem", ReduxView)

DanceActionItem.startDrag = {}

function DanceActionItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.dragDummy = nil

	self:Init()
end

function DanceActionItem:Init()
	self:BindCfgUI()
	self:InitUI()
	self:AddUIListener()
end

function DanceActionItem:InitUI()
	self.selectController = self.controllers_:GetController("sel")
	self.moveController = self.controllers_:GetController("move")
	self.playStateController = self.controllers_:GetController("play")
	self.lockController = self.controllers_:GetController("lock")
end

function DanceActionItem:AddUIListener()
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, function(arg_5_0, arg_5_1)
		self:OnBeginDrag(arg_5_1)
	end)
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, function(arg_6_0, arg_6_1)
		self:OnDrag(arg_6_1)
	end)
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, function(arg_7_0, arg_7_1)
		self:OnEndDrag(arg_7_1)
	end)
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerDown, function(arg_8_0, arg_8_1)
		self:OnPointerDown(arg_8_1)
	end)
	self.eventTriggerListener_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerClick, function(arg_9_0, arg_9_1)
		if not arg_9_1.dragging then
			self:OnPointerClick(arg_9_1)
		end
	end)
	self:SetListener(self.eventTriggerListener_)
end

local function var_0_1(arg_10_0)
	return IdolTraineeData:DanceDIYActionAvailable(arg_10_0) and not IdolDanceCollectionData:IsCollectionRecordViewed(arg_10_0)
end

function DanceActionItem:SetData(arg_11_1)
	self.actionID = arg_11_1
	self.name_.text = IdolDanceDIYActionCfg[arg_11_1].name

	local var_11_0 = GetTipsF("IDOL_DANCE_ACTION_BEAT", IdolDanceDIYActionCfg[arg_11_1].beat)

	self.beat_.text = var_11_0
	self.beat2_.text = var_11_0
	self.duration_.text = manager.time:DescCDTime4(self:TryGetActionDuration())
	self.style_.text = GetTips(IdolTraineeConst.style[IdolDanceDIYActionCfg[arg_11_1].type])
	self.color_.color = IdolTraineeConst.styleColor[IdolDanceDIYActionCfg[arg_11_1].type]

	local var_11_1 = false

	if IdolTraineeData:DanceDIYActionAvailable(arg_11_1) then
		var_11_1 = var_0_1(arg_11_1)

		self.lockController:SetSelectedState("false")

		self.lockMsg_.text = ""
	else
		self.lockController:SetSelectedState("true")

		self.lockMsg_.text = IdolTraineeTools.GetDanceDIYActionUnlockDesc(arg_11_1)
	end

	manager.redPoint:SetRedPointIndependent(self.transform_, var_11_1, RedPointStyle.SHOW_NEW_TAG)
	self.moveController:SetSelectedState("false")
end

function DanceActionItem:AssignBy(arg_12_1)
	self:SetData(arg_12_1.startDragActionID or arg_12_1.actionID)
end

function DanceActionItem:Clear()
	self:SetData(0)
end

function DanceActionItem:Swap(arg_14_1)
	self:SetData(arg_14_1.actionID)
	arg_14_1:SetData(self.actionID)
end

function DanceActionItem:SetSelected(arg_15_1)
	self.selectController:SetSelectedState(arg_15_1 and "true" or "false")
end

function DanceActionItem:MuteNewActionRedpoint()
	IdolDanceCollectionAction.ViewCollectionRecord(self.actionID)
end

local function var_0_2(arg_17_0, arg_17_1)
	return UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(arg_17_1, arg_17_0, (DanceActionItem.GetUICam()))
end

function DanceActionItem:DragOnHandleArea(arg_18_1)
	return var_0_2(arg_18_1.position, self.dragOutHandle_)
end

function DanceActionItem:DragOutOfArea(arg_19_1)
	return nullable(self.dragDummy, "dragOnHandle")
end

function DanceActionItem:IsCurItemDragging()
	return DanceActionItem.startDrag[self.actionID]
end

function DanceActionItem:Selectable()
	return self.lockController:GetSelectedState() ~= "true"
end

function DanceActionItem:IsDragging()
	return self.startDragActionID ~= nil
end

function DanceActionItem:Dragable()
	return self:Selectable()
end

function DanceActionItem:OnBeginDrag(arg_24_1)
	if self.parentScroll then
		self.parentScroll:OnBeginDrag(arg_24_1)

		if self.actionID then
			DanceActionItem.startDrag[self.actionID] = true
			self.startDragActionID = self.actionID
		end
	end

	self.dragDummy = {}

	local var_24_0 = DanceActionItem.GetUICam():WorldToScreenPoint(self.transform_.position)

	self.dragDummy.dragOnHandle = self:DragOnHandleArea(arg_24_1)
end

function DanceActionItem:OnDrag(arg_25_1)
	if self:Dragable() and self:DragOutOfArea(arg_25_1) then
		if self.dragDummy.obj == nil then
			self:CreateDragDummy()
			manager.notify:CallFirstUpdateFunc("OnBeginDragDanceActionItem", self, arg_25_1)
		end

		manager.notify:CallFirstUpdateFunc("OnDragDanceActionItem", self, arg_25_1)
	else
		if self.parentScroll then
			self.parentScroll:OnDrag(arg_25_1)
		end

		if self.dragDummy.obj then
			manager.notify:CallFirstUpdateFunc("OnEndDragDanceActionItem", self, arg_25_1)
			self:DisposeDragDummy()
		end
	end
end

function DanceActionItem:CreateDragDummy()
	if self.dragDummy.obj == nil then
		local var_26_0 = self.dragDummyRootTrs or self.transform_.parent
		local var_26_1 = GameObject.Instantiate(self.gameObject_, var_26_0, true)

		self.dragDummy.obj = var_26_1
		self.dragDummy.parent = var_26_0
		self.dragDummy.ctrl = {}
		self.dragDummy.pivot = Vector2(0.5, 0.5)
		self.dragDummy.size = var_26_1.transform.sizeDelta

		self:BindCfgUI(var_26_1, self.dragDummy.ctrl)
		self.dragDummy.ctrl.controllers_:GetController("move"):SetSelectedState("true")
		self.dragDummy.ctrl.controllers_:GetController("play"):SetSelectedState("normal")
	end
end

function DanceActionItem:DisposeDragDummy()
	if self.dragDummy and self.dragDummy.obj then
		GameObject.Destroy(self.dragDummy.obj)

		self.dragDummy.obj = nil
		self.dragDummy.ctrl = nil
	end
end

function DanceActionItem:OnEndDrag(arg_28_1)
	local var_28_0 = self.startDragActionID or self.actionID

	if self.parentScroll and self.startDrag then
		if var_28_0 then
			DanceActionItem.startDrag[var_28_0] = nil
		end

		self.parentScroll:OnEndDrag(arg_28_1)
	end

	if nullable(self.dragDummy, "obj") then
		manager.notify:CallFirstUpdateFunc("OnDropDanceActionItem", self, arg_28_1)
		GameObject.Destroy(self.dragDummy.obj)

		self.dragDummy = nil
	end

	self.startDragActionID = nil
end

function DanceActionItem:WillAcceptDrop(arg_29_1)
	return false
end

function DanceActionItem:OnDropAccepted(arg_30_1)
	arg_30_1:AssignBy(self)
end

function DanceActionItem:OnPointerDown()
	if self:Selectable() then
		self:MuteNewActionRedpoint()
		manager.notify:CallFirstUpdateFunc("OnDanceItemPointerDown", self)
	end
end

function DanceActionItem:OnPointerClick(arg_32_1)
	manager.notify:CallFirstUpdateFunc("OnDanceItemPointerClick", self)
end

function DanceActionItem:GetAction()
	return nullable(IdolDanceDIYActionCfg, self.actionID, "anime_action")
end

function DanceActionItem:SetPlayState(arg_34_1)
	self.playStateController:SetSelectedState(arg_34_1)
end

function DanceActionItem:SetDragDummyRoot(arg_35_1)
	self.dragDummyRootTrs = arg_35_1
end

function DanceActionItem:OnPreviewStart()
	self:SetPlayState("play")

	self.progress_.fillAmount = 0
end

function DanceActionItem:OnPreviewUpdate(arg_37_1)
	self.progress_.fillAmount = arg_37_1
end

function DanceActionItem:OnPreviewEnd(arg_38_1)
	self:SetPlayState(arg_38_1 and "pause" or "normal")

	self.progress_.fillAmount = 0
end

function DanceActionItem:IsDuringPreview()
	return self.playStateController:GetSelectedState() == "play"
end

function DanceActionItem:TryGetActionDuration()
	local var_40_0 = nullable(IdolDanceDIYActionCfg, self.actionID, "duration")

	if var_40_0 and var_40_0 > 0 then
		return var_40_0
	end

	local var_40_1 = DanceGame.GetSequence(DormUtils.GetEntityData(DIYBridge.charaEID).cfgID, nil, self:GetAction()).duration

	var_40_1 = var_40_1 or 0

	return var_40_1
end

function DanceActionItem:Dispose()
	self:DisposeDragDummy()
	DanceActionItem.super.Dispose(self)
end

return DanceActionItem
