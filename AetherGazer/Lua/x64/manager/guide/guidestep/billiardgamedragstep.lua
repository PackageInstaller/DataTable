local var_0_0 = class("BilliardGameDragStep", DragStep)

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)
end

function var_0_0.Component(arg_2_0)
	if arg_2_0._component == nil then
		arg_2_0:SetSpecialParams()

		arg_2_0._component = arg_2_0:AnalyzeComponentCfg(arg_2_0._guideComponentCfg)
		arg_2_0._dragConponent = BilliardGameLuaBridge.GetTrigger()
	end

	return arg_2_0._component, arg_2_0._dragConponent
end

function var_0_0.EventTrigger(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "beginDrag" then
		arg_3_0._dragConponent:OnBeginDrag(arg_3_2)
	elseif arg_3_1 == "drag" then
		arg_3_0._dragConponent:OnDrag(arg_3_2)
	elseif arg_3_1 == "endDrag" then
		arg_3_0._dragConponent:OnEndDrag(arg_3_2)

		if arg_3_0.timer_ then
			arg_3_0.timer_:Stop()

			arg_3_0.timer_ = nil
		end

		arg_3_0.timer_ = Timer.New(function()
			if arg_3_0:CheckDragSuccess() then
				local var_4_0 = arg_3_0:GetViewComponent(arg_3_0._guideComponentCfg[2], {
					"guideGo_"
				})

				SetActive(var_4_0, false)
				arg_3_0:OnStepEnd()
			end

			arg_3_0.timer_:Stop()

			arg_3_0.timer_ = nil
		end, 0.4, 1)

		arg_3_0.timer_:Start()
	end
end

function var_0_0.Play(arg_5_0)
	manager.guide.view:Init()

	local var_5_0, var_5_1 = arg_5_0:Component()

	arg_5_0:ShowTalk()

	local var_5_2 = arg_5_0:AnalyzeComponentCfg(arg_5_0._maskComponentCfg)
	local var_5_3 = var_5_2 and var_5_2.gameObject or var_5_0.gameObject

	manager.guide.view:ShowHoldMask(var_5_3, arg_5_0._maskScale, arg_5_0._params)

	if #arg_5_0._dragGuideComponentCfg > 0 then
		local var_5_4 = arg_5_0:AnalyzeComponentCfg(arg_5_0._dragMaskComponentCfg)
		local var_5_5 = var_5_4 and var_5_4.gameObject or var_5_1.gameObject

		manager.guide.view:ShowHoldMask2(var_5_5, arg_5_0._maskScale, arg_5_0._params)
	end

	BilliardGameLuaBridge.SetGuideInfo(arg_5_0._params[1], arg_5_0._params[2])

	local var_5_6 = arg_5_0:GetViewComponent(arg_5_0._guideComponentCfg[2], {
		"guideGo_"
	})

	SetActive(var_5_6, true)
end

function var_0_0.CheckDragSuccess(arg_6_0)
	return BilliardGameLuaBridge.CheckDrag(arg_6_0._params[1], arg_6_0._params[2])
end

return var_0_0
