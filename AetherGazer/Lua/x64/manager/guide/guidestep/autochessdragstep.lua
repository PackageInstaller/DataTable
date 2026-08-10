local var_0_0 = class("AutoChessDragStep", DragStep)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	var_0_0.prepareView = AutoChessBattleRenderer.GetInstance():GetPrepareView()
end

function var_0_0.EventTrigger(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == "beginDrag" then
		arg_2_0._dragConponent:OnBeginDrag(arg_2_2)
	elseif arg_2_1 == "drag" then
		arg_2_0._dragConponent:OnDrag(arg_2_2)
	elseif arg_2_1 == "endDrag" then
		arg_2_0._dragConponent:OnEndDrag(arg_2_2)

		if arg_2_0.timer_ then
			arg_2_0.timer_:Stop()

			arg_2_0.timer_ = nil
		end

		arg_2_0.timer_ = Timer.New(function()
			if arg_2_0:CheckDragSuccess() then
				manager.guide.view:ResetPointer()
				arg_2_0:OnStepEnd()
			end

			arg_2_0.timer_:Stop()

			arg_2_0.timer_ = nil
		end, 0.33, -1)

		arg_2_0.timer_:Start()
	elseif arg_2_1 == "onPointerEnter" then
		if arg_2_2.pointerEnter.name == manager.guide.view.btnMaskGo_.name then
			if arg_2_0._params[1] ~= -1 then
				var_0_0.prepareView.autoChessFormationItemView_:GetChessItem(arg_2_0._params[1]):PointerEnter(arg_2_2)
			else
				arg_2_0._component:OnPointerEnter(arg_2_2)
			end
		end
	elseif arg_2_1 == "onPointerExit" and arg_2_2.pointerEnter.name == manager.guide.view.btnMaskGo_.name then
		if arg_2_0._params[1] ~= -1 then
			var_0_0.prepareView.autoChessFormationItemView_:GetChessItem(arg_2_0._params[1]):PointerExit(arg_2_2)
		else
			arg_2_0._component:OnPointerExit(arg_2_2)
		end
	end
end

function var_0_0.Play(arg_4_0)
	var_0_0.super.Play(arg_4_0)
	manager.guide.view:SetPointerMove({
		x = 0,
		y = 0
	}, {
		x = 0,
		y = 0
	}, 2.5)
	var_0_0.prepareView:SetGuideTargetIndex(arg_4_0._params[1])
end

function var_0_0.CheckDragSuccess(arg_5_0)
	return var_0_0.prepareView:CheckGuideDragIsComplete()
end

return var_0_0
