local var_0_0 = class("BaseStep")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._starTime = 0
	arg_1_0._guide = arg_1_1
	arg_1_0._stepId = arg_1_2
	arg_1_0._stepCfg = GuideStepCfg[arg_1_0._stepId]
	arg_1_0._isFinish = arg_1_0._stepCfg.is_finish or false

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	return
end

function var_0_0.Check(arg_3_0)
	return true
end

function var_0_0.Play(arg_4_0)
	return
end

function var_0_0.OnStepEnd(arg_5_0)
	if arg_5_0._guide ~= nil then
		arg_5_0._guide:OnStepEnd(arg_5_0)
	end

	arg_5_0._guide = nil
end

function var_0_0.Guide(arg_6_0)
	return arg_6_0._guide
end

function var_0_0.IsFinish(arg_7_0)
	return arg_7_0._isFinish
end

function var_0_0.GetStepId(arg_8_0)
	return arg_8_0._stepId
end

function var_0_0.GetShowMask(arg_9_0)
	return false
end

function var_0_0.Click(arg_10_0)
	return
end

function var_0_0.EventTrigger(arg_11_0, arg_11_1, arg_11_2)
	return
end

function var_0_0.BattleFinish(arg_12_0, arg_12_1)
	return
end

function var_0_0.UpdateStarTime(arg_13_0)
	arg_13_0._starTime = Time.realtimeSinceStartup
end

function var_0_0.GetStarTime(arg_14_0)
	return arg_14_0._starTime
end

function var_0_0.ShowTalk(arg_15_0)
	manager.guide.view:SetTalkItem(arg_15_0._stepCfg, arg_15_0._guide)
	manager.guide.view:ShowTalk(arg_15_0._stepCfg)
end

return var_0_0
