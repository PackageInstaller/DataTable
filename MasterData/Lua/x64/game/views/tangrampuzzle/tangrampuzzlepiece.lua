local PuzzleNewPiece = class("PuzzleNewPiece", ReduxView)

function PuzzleNewPiece:OnCtor(arg_1_1, arg_1_2, arg_1_3)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.globalIndex_ = arg_1_2
	self.correctID_ = arg_1_3

	self:Init()
	SetActive(self.gameObject_, true)
end

function PuzzleNewPiece:Init()
	self:InitUI()
	self:AddUIListener()

	self.icon_.alphaHitTestMinimumThreshold = 1
end

function PuzzleNewPiece:InitUI()
	self:BindCfgUI()

	self.statusController_ = ControllerUtil.GetController(self.transform_, "status")
	self.highLightController_ = ControllerUtil.GetController(self.transform_, "highLight")
	self.selectController_ = ControllerUtil.GetController(self.transform_, "select")
	self.enterAnimController_ = ControllerUtil.GetController(self.transform_, "enterAnim")
end

function PuzzleNewPiece:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.draging_ == true then
			return
		end

		if not ActivityData:GetActivityIsOpen(self.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		manager.audio:PlayEffect("ui_system", "button", "")

		if self.clickCallback_ then
			self.clickCallback_(self.globalIndex_)
		end
	end)
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(self, self.BeginDragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(self, self.DragFun)))
	self.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(self, self.EndDragFun)))
end

function PuzzleNewPiece:Dispose()
	self.clickCallback_ = nil
	self.endDragCallback_ = nil
	self.beginDragCallback_ = nil

	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
	self.eventTriggerListeners_:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
	self:StopLeanTween()
	PuzzleNewPiece.super.Dispose(self)
end

function PuzzleNewPiece:OnExit()
	self.draging_ = false

	self:StopAnimTimer()
	self:StopLeanTween()
	self:RecoverTrans()
end

function PuzzleNewPiece:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function PuzzleNewPiece:SetData(arg_9_1, arg_9_2)
	self.lastID_ = self.curID_
	self.curID_ = arg_9_1
	self.activityID_ = arg_9_2

	self:RefreshUI()
end

function PuzzleNewPiece:RefreshUI()
	if self.curID_ ~= 0 then
		self.icon_.sprite = pureGetSpriteWithoutAtlas(TangramPuzzleCfg[self.activityID_].path .. TangramPuzzleTools.GetPuzzlePictureDic(self.activityID_)[self.curID_])

		self.icon_:SetNativeSize()
	end

	SetActive(self.gameObject_, self.curID_ ~= 0)
	self:StopAnimTimer()
	self.enterAnimController_:SetSelectedState("false")
end

function PuzzleNewPiece:SetRegionID(arg_11_1, arg_11_2)
	self.regionID_ = arg_11_1
	self.localIndex_ = arg_11_2
end

function PuzzleNewPiece:GetCurRegion()
	return self.regionID_, self.localIndex_
end

function PuzzleNewPiece:GetGlobalIndex()
	return self.globalIndex_
end

function PuzzleNewPiece:SetSelectCallBack(arg_14_1)
	self.selectCallBack_ = arg_14_1
end

function PuzzleNewPiece:RefreshStatus()
	return
end

function PuzzleNewPiece:SetHighLight(arg_16_1)
	self.highLightController_:SetSelectedState(arg_16_1 and "on" or "off")
end

function PuzzleNewPiece:SetSelect(arg_17_1)
	self.selectController_:SetSelectedState(arg_17_1 and "on" or "off")
end

function PuzzleNewPiece:IsRightSide()
	return self.correctID_ == self.curID_
end

function PuzzleNewPiece:IsEmpty()
	return self.curID_ == 0
end

function PuzzleNewPiece:GetCurID()
	return self.curID_
end

function PuzzleNewPiece:SetTransParent(arg_21_1)
	self.originParent_ = self.transform_.parent

	self.transform_:SetParent(arg_21_1)
end

function PuzzleNewPiece:RecoverTrans()
	if self.originPos_ then
		self.transform_.position = self.originPos_
		self.originPos_ = nil
	end

	if self.originParent_ then
		self.transform_:SetParent(self.originParent_)

		self.originParent_ = nil
	end
end

function PuzzleNewPiece:RegistClickCallback(arg_23_1)
	self.clickCallback_ = arg_23_1
end

function PuzzleNewPiece:RegistBeginDragCallback(arg_24_1)
	self.beginDragCallback_ = arg_24_1
end

function PuzzleNewPiece:RegistEndDragCallback(arg_25_1)
	self.endDragCallback_ = arg_25_1
end

function PuzzleNewPiece:BeginDragFun(arg_26_1, arg_26_2)
	if self.draging_ then
		return
	end

	self.draging_ = true

	if self.beginDragCallback_ and not self.beginDragCallback_(self.globalIndex_) then
		self.draging_ = false

		return
	end

	self.originPos_ = self.transform_.position
	self.canvasRate_ = manager.ui.canvasSize_.x / Screen.width
end

function PuzzleNewPiece:DragFun(arg_27_1, arg_27_2)
	if not self.draging_ then
		return
	end

	self.transform_:SetLocalPositionDelta((arg_27_2.delta * self.canvasRate_).x, (arg_27_2.delta * self.canvasRate_).y, 0)
end

function PuzzleNewPiece:EndDragFun(arg_28_1, arg_28_2)
	if not self.draging_ then
		return
	end

	self.draging_ = false

	if self.endDragCallback_ then
		self.endDragCallback_(self.globalIndex_, arg_28_2)
	end
end

function PuzzleNewPiece:UpdatePosition(arg_29_1, arg_29_2)
	self.originPos_ = self.transform_.position

	self:StopLeanTween()

	self.posLeanTween_ = LeanTween.move(self.gameObject_, arg_29_1, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function()
		if arg_29_2 then
			arg_29_2()
		end

		self:StopLeanTween()
	end))
end

function PuzzleNewPiece:PlayEnterAnim(arg_31_1)
	SetActive(self.gameObject_, true)
	self.enterAnimController_:SetSelectedState("true")
	self:PlayAnim(self.anim_, "puzzleTemplate_enter", arg_31_1)
end

function PuzzleNewPiece:StopAnimTimer()
	if self.animtimer_ then
		self.animtimer_:Stop()

		self.animtimer_ = nil
	end
end

function PuzzleNewPiece:StopLeanTween()
	if self.posLeanTween_ then
		self.posLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(self.posLeanTween_.id)

		self.posLeanTween_ = nil
	end
end

function PuzzleNewPiece:PlayAnim(arg_34_1, arg_34_2, arg_34_3)
	if not arg_34_1 then
		if arg_34_3 then
			arg_34_3()
		end

		return
	end

	self:StopAnimTimer()

	arg_34_1.enabled = true

	arg_34_1:Play(arg_34_2, -1, 0)
	arg_34_1:Update(0)

	self.animtimer_ = Timer.New(function()
		local var_35_0 = arg_34_1:GetCurrentAnimatorStateInfo(0)

		if var_35_0:IsName(arg_34_2) and var_35_0.normalizedTime >= 1 then
			self:StopAnimTimer()

			arg_34_1.enabled = false

			if arg_34_3 then
				arg_34_3()
			end
		end
	end, 0.033, -1)

	self.animtimer_:Start()
end

return PuzzleNewPiece
