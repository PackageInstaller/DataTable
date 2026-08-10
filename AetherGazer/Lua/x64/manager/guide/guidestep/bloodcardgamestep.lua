local var_0_0 = class("BloodCardGameStep", ComponentStep)
local var_0_1 = {
	[10807] = 6
}

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0._eventName = GuideStepCfg[arg_1_0._stepId].params[1]
end

function var_0_0.EventTrigger(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0._stepId == 10806 and arg_2_1 == "pointerDown" then
		arg_2_0:OnStepEnd()

		return
	end
end

function var_0_0.Play(arg_3_0)
	manager.guide.view:Init()

	local var_3_0 = arg_3_0:Component()

	arg_3_0:ShowTalk()

	local var_3_1 = arg_3_0:AnalyzeComponentCfg(arg_3_0._maskComponentCfg)
	local var_3_2 = var_3_1 and var_3_1.gameObject or var_3_0.gameObject

	manager.guide.view:ShowHoldMask(var_3_2, arg_3_0._maskScale, arg_3_0._params)

	if arg_3_0._stepId == 10807 then
		arg_3_0:SetRayCastTargetActive(false)
		BloodCardManager.Instance:LockCell(true, 5)

		arg_3_0.timer_ = Timer.New(function()
			if arg_3_0._stepId == nil then
				return
			end

			local var_4_0 = var_0_1[arg_3_0._stepId]

			if var_4_0 == nil then
				return
			end

			if not BloodCardManager.Instance then
				arg_3_0.timer_:Stop()

				arg_3_0.timer_ = nil

				return
			end

			if BloodCardManager.Instance:CheckCell(var_4_0) then
				BloodCardManager.Instance:LockCell(false, -1)
				arg_3_0:SetRayCastTargetActive(true)
				arg_3_0:OnStepEnd()

				if arg_3_0.timer_ then
					arg_3_0.timer_:Stop()

					arg_3_0.timer_ = nil
				end
			else
				return
			end
		end, 0.1, -1)

		arg_3_0.timer_:Start()
	elseif arg_3_0._stepId == 10901 then
		arg_3_0:SetRayCastTargetActive(false)
		BloodCardManager.Instance:LockCardLisener(true)

		arg_3_0.timer_ = Timer.New(function()
			if not BloodCardManager.Instance then
				arg_3_0.timer_:Stop()

				arg_3_0.timer_ = nil

				return
			end

			if BloodCardManager.Instance.sufferCardIndexs.Count > 0 then
				arg_3_0:SetRayCastTargetActive(true)
				BloodCardManager.Instance:LockCardLisener(false)
				arg_3_0:OnStepEnd()

				if arg_3_0.timer_ then
					arg_3_0.timer_:Stop()

					arg_3_0.timer_ = nil
				end
			else
				return
			end
		end, 0.1, -1)

		arg_3_0.timer_:Start()
	else
		arg_3_0:SetRayCastTargetActive(true)
	end
end

function var_0_0.SetRayCastTargetActive(arg_6_0, arg_6_1)
	local var_6_0 = manager.guide.view.mask_.transform:Find("HoleImage")

	manager.guide.view.maskImgCom1_:GetComponent("AdditionMask").raycastTarget = arg_6_1
	manager.guide.view.maskImgCom2_:GetComponent("AdditionMask").raycastTarget = arg_6_1
	manager.guide.view.mask_.transform:GetComponent(typeof(Image)).raycastTarget = arg_6_1
	manager.guide.view.maskUI_.transform:GetComponent(typeof(Image)).raycastTarget = arg_6_1
	manager.guide.view.btnMaskCom_:GetComponent(typeof(Image)).raycastTarget = arg_6_1
	var_6_0:GetComponent("HoleImage").raycastTarget = arg_6_1
end

function var_0_0.Component(arg_7_0)
	if arg_7_0._component == nil then
		arg_7_0:SetSpecialParams()

		arg_7_0._component = arg_7_0:AnalyzeComponentCfg(arg_7_0._guideComponentCfg)
	end

	return arg_7_0._component
end

return var_0_0
