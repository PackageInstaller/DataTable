local var_0_0 = class("DragStep", ComponentStep)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0._dragGuideComponentCfg = GuideStepCfg[arg_1_0._stepId].drag_guide_component
	arg_1_0._dragMaskComponentCfg = GuideStepCfg[arg_1_0._stepId].drag_mask_component
end

function var_0_0.Check(arg_2_0)
	return arg_2_0:Component() ~= nil and arg_2_0._dragConponent ~= nil
end

function var_0_0.Component(arg_3_0)
	if arg_3_0._component == nil then
		arg_3_0:SetSpecialParams()

		arg_3_0._component = arg_3_0:AnalyzeComponentCfg(arg_3_0._guideComponentCfg)
		arg_3_0._dragConponent = arg_3_0:AnalyzeComponentCfg(arg_3_0._dragGuideComponentCfg)
	end

	return arg_3_0._component, arg_3_0._dragConponent
end

function var_0_0.EventTrigger(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "beginDrag" then
		arg_4_0._dragConponent:OnBeginDrag(arg_4_2)
	elseif arg_4_1 == "drag" then
		arg_4_0._dragConponent:OnDrag(arg_4_2)
	elseif arg_4_1 == "endDrag" then
		arg_4_0._dragConponent:OnEndDrag(arg_4_2)

		if arg_4_0.timer_ then
			arg_4_0.timer_:Stop()

			arg_4_0.timer_ = nil
		end

		arg_4_0.timer_ = Timer.New(function()
			if arg_4_0:CheckDragSuccess() then
				arg_4_0:OnStepEnd()
			end

			arg_4_0.timer_:Stop()

			arg_4_0.timer_ = nil
		end, 0.33, -1)

		arg_4_0.timer_:Start()
	end
end

function var_0_0.Play(arg_6_0)
	manager.guide.view:Init()

	local var_6_0, var_6_1 = arg_6_0:Component()

	arg_6_0:ShowTalk()

	local var_6_2 = arg_6_0:AnalyzeComponentCfg(arg_6_0._maskComponentCfg)
	local var_6_3 = var_6_2 and var_6_2.gameObject or var_6_0.gameObject

	manager.guide.view:ShowHoldMask(var_6_3, arg_6_0._maskScale, arg_6_0._params)

	if #arg_6_0._dragGuideComponentCfg > 0 then
		local var_6_4 = arg_6_0:AnalyzeComponentCfg(arg_6_0._dragMaskComponentCfg)
		local var_6_5 = var_6_4 and var_6_4.gameObject or var_6_1.gameObject

		manager.guide.view:ShowHoldMask2(var_6_5, arg_6_0._maskScale, arg_6_0._params)
	end
end

function var_0_0.CheckDragSuccess(arg_7_0)
	return true
end

return var_0_0
