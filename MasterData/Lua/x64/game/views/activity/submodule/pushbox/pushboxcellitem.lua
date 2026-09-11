local PushBoxCellItem = class("PushBoxCellItem", ReduxView)

function PushBoxCellItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function PushBoxCellItem:Init()
	self:InitUI()
	self:AddUIListeners()
end

function PushBoxCellItem:InitUI()
	self:BindCfgUI()

	self.overCon_ = ControllerUtil.GetController(self.transform_, "over")
	self.stateCon_ = ControllerUtil.GetController(self.transform_, "state")
	self.bridgeCon_ = ControllerUtil.GetController(self.transform_, "bridge")
end

function PushBoxCellItem:AddUIListeners()
	return
end

function PushBoxCellItem:OnEnter()
	return
end

function PushBoxCellItem:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.coordinateX_ = arg_6_1
	self.coordinateY_ = arg_6_2
	self.type_ = arg_6_3

	self:Reset()
	self:RefreshType()
end

function PushBoxCellItem:Reset()
	self.onReadyEnterHandler_ = nil
	self.actionPassHandler_ = nil
	self.onPassedHandler_ = nil
	self.onStopHandler_ = nil
	self.isCanPass_ = true
end

function PushBoxCellItem:RefreshType()
	self.stateCon_:SetSelectedState(self.type_)
	self.bridgeCon_:SetSelectedState("false")
	self.overCon_:SetSelectedState("false")

	if self.type_ == PushBoxConst.CELL_TYPE.NORMAL then
		self.actionPassHandler_ = handler(self, self.NormalActionPass)
		self.onStopHandler_ = handler(self, self.NormalStop)
	elseif self.type_ == PushBoxConst.CELL_TYPE.BLOCK then
		self.isCanPass_ = false
	elseif self.type_ == PushBoxConst.CELL_TYPE.GOAL then
		self.actionPassHandler_ = handler(self, self.GoalActionPass)
		self.onPassedHandler_ = handler(self, self.GoalPass)
		self.onStopHandler_ = handler(self, self.GoalStop)
	elseif self.type_ == PushBoxConst.CELL_TYPE.BRIDGE then
		self.actionPassHandler_ = handler(self, self.BridgeActionPass)
		self.onPassedHandler_ = handler(self, self.BridgePass)
		self.onStopHandler_ = handler(self, self.NormalStop)
	elseif self.type_ == PushBoxConst.CELL_TYPE.UP_SLIDER then
		self.actionPassHandler_ = handler(self, self.NormalActionPass)
		self.onStopHandler_ = handler(self, self.UpSlider)
		self.onReadyEnterHandler_ = handler(self, self.UpSliderEnter)
	elseif self.type_ == PushBoxConst.CELL_TYPE.DOWN_SLIDER then
		self.actionPassHandler_ = handler(self, self.NormalActionPass)
		self.onStopHandler_ = handler(self, self.DownSlider)
		self.onReadyEnterHandler_ = handler(self, self.DownSliderEnter)
	elseif self.type_ == PushBoxConst.CELL_TYPE.LEFT_SLIDER then
		self.actionPassHandler_ = handler(self, self.NormalActionPass)
		self.onStopHandler_ = handler(self, self.LeftSlider)
		self.onReadyEnterHandler_ = handler(self, self.LeftSliderEnter)
	elseif self.type_ == PushBoxConst.CELL_TYPE.RIGHT_SLIDER then
		self.actionPassHandler_ = handler(self, self.NormalActionPass)
		self.onStopHandler_ = handler(self, self.RightSlider)
		self.onReadyEnterHandler_ = handler(self, self.RightSliderEnter)
	end
end

function PushBoxCellItem:IsCanPass()
	return self.isCanPass_
end

function PushBoxCellItem:GetType()
	return self.type_
end

function PushBoxCellItem:GetPos()
	return self.coordinateX_, self.coordinateY_
end

function PushBoxCellItem:GetLoaclPosition()
	return self.transform_.localPosition.x, self.transform_.localPosition.y
end

function PushBoxCellItem:OnReadyEnter()
	if self.onReadyEnterHandler_ then
		self.onReadyEnterHandler_()
	end
end

function PushBoxCellItem:ActionPass()
	if self.actionPassHandler_ then
		self.actionPassHandler_()
	end
end

function PushBoxCellItem:OnPass()
	if self.onPassedHandler_ then
		self.onPassedHandler_()
	end
end

function PushBoxCellItem:OnStop()
	if self.onStopHandler_ then
		self.onStopHandler_()
	end
end

function PushBoxCellItem:UpSliderEnter()
	if not PushBoxTool:CheckCanPass(self.coordinateX_, self.coordinateY_, 0, -1) then
		return
	end

	self:SliderEnter()
end

function PushBoxCellItem:DownSliderEnter()
	if not PushBoxTool:CheckCanPass(self.coordinateX_, self.coordinateY_, 0, 1) then
		return
	end

	self:SliderEnter()
end

function PushBoxCellItem:LeftSliderEnter()
	if not PushBoxTool:CheckCanPass(self.coordinateX_, self.coordinateY_, -1, 0) then
		return
	end

	self:SliderEnter()
end

function PushBoxCellItem:RightSliderEnter()
	if not PushBoxTool:CheckCanPass(self.coordinateX_, self.coordinateY_, 1, 0) then
		return
	end

	self:SliderEnter()
end

function PushBoxCellItem:SliderEnter()
	manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_change")
end

function PushBoxCellItem:NormalStop()
	self.isCanPass_ = false
end

function PushBoxCellItem:GoalActionPass()
	self.isCanPass_ = true
end

function PushBoxCellItem:GoalPass()
	self.overCon_:SetSelectedState("false")
end

function PushBoxCellItem:GoalStop()
	self.overCon_:SetSelectedState("true")

	self.isCanPass_ = false
end

function PushBoxCellItem:BridgeActionPass()
	self.isCanPass_ = false
end

function PushBoxCellItem:NormalActionPass()
	self.isCanPass_ = true
end

function PushBoxCellItem:BridgePass()
	self.bridgeCon_:SetSelectedState("true")
	manager.audio:PlayEffect("minigame_activity_2_10", "minigame_activity_2_10_box_break")
end

function PushBoxCellItem:UpSlider()
	if not PushBoxTool:CheckCanPass(self.coordinateX_, self.coordinateY_, 0, -1) then
		self.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, 0, -1, self.coordinateX_, self.coordinateY_)
end

function PushBoxCellItem:DownSlider()
	if not PushBoxTool:CheckCanPass(self.coordinateX_, self.coordinateY_, 0, 1) then
		self.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, 0, 1, self.coordinateX_, self.coordinateY_)
end

function PushBoxCellItem:LeftSlider()
	if not PushBoxTool:CheckCanPass(self.coordinateX_, self.coordinateY_, -1, 0) then
		self.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, -1, 0, self.coordinateX_, self.coordinateY_)
end

function PushBoxCellItem:RightSlider()
	if not PushBoxTool:CheckCanPass(self.coordinateX_, self.coordinateY_, 1, 0) then
		self.isCanPass_ = false

		return
	end

	manager.notify:Invoke(PUSH_BOX_ACTION, 1, 0, self.coordinateX_, self.coordinateY_)
end

function PushBoxCellItem:OnExit()
	self:Reset()
end

function PushBoxCellItem:Dispose()
	self:RemoveAllListeners()
	self:Reset()
	self.super.Dispose(self)
end

return PushBoxCellItem
