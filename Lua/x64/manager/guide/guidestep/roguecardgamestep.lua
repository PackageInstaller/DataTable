local var_0_0 = class("RogueCardGameStep", ComponentStep)
local var_0_1 = {
	24301,
	24306,
	24308,
	24404,
	24502,
	24504,
	24506,
	24601,
	24603,
	24605,
	24702,
	247101
}
local var_0_2 = {
	[var_0_1[1]] = {
		2,
		3,
		4
	},
	[var_0_1[2]] = {
		2,
		3,
		4
	},
	[var_0_1[3]] = {
		0,
		1,
		2
	},
	[var_0_1[4]] = 0,
	[var_0_1[5]] = 100,
	[var_0_1[6]] = 1,
	[var_0_1[7]] = 0,
	[var_0_1[8]] = 101,
	[var_0_1[9]] = 1,
	[var_0_1[10]] = 1,
	[var_0_1[11]] = 0,
	[var_0_1[12]] = 0
}

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	arg_1_0._eventName = GuideStepCfg[arg_1_0._stepId].params[1]
end

function var_0_0.EventTrigger(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.Play(arg_3_0)
	manager.guide.view:Init()

	local var_3_0 = arg_3_0:Component()

	arg_3_0:ShowTalk()

	local var_3_1 = arg_3_0:AnalyzeComponentCfg(arg_3_0._maskComponentCfg)
	local var_3_2 = var_3_1 and var_3_1.gameObject or var_3_0.gameObject

	manager.guide.view:ShowHoldMask(var_3_2, arg_3_0._maskScale, arg_3_0._params)

	local var_3_3 = false

	if arg_3_0._stepId == var_0_1[1] or arg_3_0._stepId == var_0_1[2] or arg_3_0._stepId == var_0_1[3] then
		arg_3_0:SetRayCastTargetActive(false)

		local var_3_4 = var_0_2[arg_3_0._stepId]

		RogueCard.RogueCardGameMain.Instance:LockGuide(1, {
			var_3_4[1],
			var_3_4[2],
			var_3_4[3]
		})

		var_3_3 = true
		arg_3_0.timer_ = Timer.New(function()
			if arg_3_0._stepId == nil then
				return
			end

			local var_4_0 = var_0_2[arg_3_0._stepId]

			if var_4_0 == nil then
				return
			end

			if not RogueCard.RogueCardGameMain.Instance then
				arg_3_0.timer_:Stop()

				arg_3_0.timer_ = nil

				return
			end

			if RogueCard.RogueCardGameMain.Instance:CheckSelectCard(var_4_0[1], var_4_0[2], var_4_0[3]) then
				if var_3_3 then
					RogueCard.RogueCardGameMain.Instance:UnlockGuide()

					var_3_3 = false
				end

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
	elseif arg_3_0._stepId == var_0_1[4] or arg_3_0._stepId == var_0_1[5] or arg_3_0._stepId == var_0_1[8] or arg_3_0._stepId == var_0_1[11] or arg_3_0._stepId == var_0_1[12] then
		arg_3_0:SetRayCastTargetActive(false)
		RogueCard.RogueCardGameMain.Instance:LockGuide(3, {
			var_0_2[arg_3_0._stepId]
		})

		var_3_3 = true
		arg_3_0.timer_ = Timer.New(function()
			if arg_3_0._stepId == nil then
				return
			end

			local var_5_0 = var_0_2[arg_3_0._stepId]

			if var_5_0 == nil then
				return
			end

			if not RogueCard.RogueCardGameMain.Instance then
				arg_3_0.timer_:Stop()

				arg_3_0.timer_ = nil

				return
			end

			if RogueCard.RogueCardGameMain.Instance:CheckSelectShopItem(var_5_0) then
				if var_3_3 then
					RogueCard.RogueCardGameMain.Instance:UnlockGuide()

					var_3_3 = false
				end

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
	elseif arg_3_0._stepId == var_0_1[6] or arg_3_0._stepId == var_0_1[9] or arg_3_0._stepId == var_0_1[10] then
		arg_3_0:SetRayCastTargetActive(false)
		RogueCard.RogueCardGameMain.Instance:LockGuide(4, {
			var_0_2[arg_3_0._stepId]
		})

		var_3_3 = true
		arg_3_0.timer_ = Timer.New(function()
			if arg_3_0._stepId == nil then
				return
			end

			local var_6_0 = var_0_2[arg_3_0._stepId]

			if var_6_0 == nil then
				return
			end

			if not RogueCard.RogueCardGameMain.Instance then
				arg_3_0.timer_:Stop()

				arg_3_0.timer_ = nil

				return
			end

			if RogueCard.RogueCardGameMain.Instance:CheckSelectPackageItem(var_6_0) then
				if var_3_3 then
					RogueCard.RogueCardGameMain.Instance:UnlockGuide()

					var_3_3 = false
				end

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
	elseif arg_3_0._stepId == var_0_1[7] then
		arg_3_0:SetRayCastTargetActive(false)
		RogueCard.RogueCardGameMain.Instance:LockGuide(2, {
			var_0_2[arg_3_0._stepId]
		})

		var_3_3 = true
		arg_3_0.timer_ = Timer.New(function()
			if arg_3_0._stepId == nil then
				return
			end

			local var_7_0 = var_0_2[arg_3_0._stepId]

			if var_7_0 == nil then
				return
			end

			if not RogueCard.RogueCardGameMain.Instance then
				arg_3_0.timer_:Stop()

				arg_3_0.timer_ = nil

				return
			end

			if RogueCard.RogueCardGameMain.Instance:CheckSelectJokerItem(var_7_0) then
				if var_3_3 then
					RogueCard.RogueCardGameMain.Instance:UnlockGuide()

					var_3_3 = false
				end

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
	else
		arg_3_0:SetRayCastTargetActive(true)
	end
end

function var_0_0.SetRayCastTargetActive(arg_8_0, arg_8_1)
	local var_8_0 = manager.guide.view.mask_.transform:Find("HoleImage")

	manager.guide.view.maskImage1_:GetComponent("AdditionMask").raycastTarget = arg_8_1
	manager.guide.view.maskImage2_:GetComponent("AdditionMask").raycastTarget = arg_8_1
	manager.guide.view.mask_.transform:GetComponent(typeof(Image)).raycastTarget = arg_8_1
	manager.guide.view.maskUI_.transform:GetComponent(typeof(Image)).raycastTarget = arg_8_1
	manager.guide.view.btnMaskCom_:GetComponent(typeof(Image)).raycastTarget = arg_8_1
	var_8_0:GetComponent("HoleImage").raycastTarget = arg_8_1
end

function var_0_0.Component(arg_9_0)
	if arg_9_0._component == nil then
		arg_9_0:SetSpecialParams()

		arg_9_0._component = arg_9_0:AnalyzeComponentCfg(arg_9_0._guideComponentCfg)
	end

	return arg_9_0._component
end

return var_0_0
