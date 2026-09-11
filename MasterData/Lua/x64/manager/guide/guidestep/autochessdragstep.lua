local AutoChessDragStep = class("AutoChessDragStep", DragStep)

function AutoChessDragStep:Init()
	AutoChessDragStep.super.Init(self)

	AutoChessDragStep.prepareView = AutoChessBattleRenderer.GetInstance():GetPrepareView()
end

function AutoChessDragStep:EventTrigger(arg_2_1, arg_2_2)
	if arg_2_1 == "beginDrag" then
		self._dragConponent:OnBeginDrag(arg_2_2)
	elseif arg_2_1 == "drag" then
		self._dragConponent:OnDrag(arg_2_2)
	elseif arg_2_1 == "endDrag" then
		self._dragConponent:OnEndDrag(arg_2_2)

		if self.timer_ then
			self.timer_:Stop()

			self.timer_ = nil
		end

		self.timer_ = Timer.New(function()
			if self:CheckDragSuccess() then
				manager.guide.view:ResetPointer()
				self:OnStepEnd()
			end

			self.timer_:Stop()

			self.timer_ = nil
		end, 0.33, -1)

		self.timer_:Start()
	elseif arg_2_1 == "onPointerEnter" then
		if arg_2_2.pointerEnter.name == manager.guide.view.btnMaskGo_.name then
			if self._params[1] ~= -1 then
				AutoChessDragStep.prepareView.autoChessFormationItemView_:GetChessItem(self._params[1]):PointerEnter(arg_2_2)
			else
				self._component:OnPointerEnter(arg_2_2)
			end
		end
	elseif arg_2_1 == "onPointerExit" and arg_2_2.pointerEnter.name == manager.guide.view.btnMaskGo_.name then
		if self._params[1] ~= -1 then
			AutoChessDragStep.prepareView.autoChessFormationItemView_:GetChessItem(self._params[1]):PointerExit(arg_2_2)
		else
			self._component:OnPointerExit(arg_2_2)
		end
	end
end

function AutoChessDragStep:Play()
	AutoChessDragStep.super.Play(self)
	manager.guide.view:SetPointerMove({
		x = 0,
		y = 0
	}, {
		x = 0,
		y = 0
	}, 2.5)
	AutoChessDragStep.prepareView:SetGuideTargetIndex(self._params[1])
end

function AutoChessDragStep:CheckDragSuccess()
	return AutoChessDragStep.prepareView:CheckGuideDragIsComplete()
end

return AutoChessDragStep
