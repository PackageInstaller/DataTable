local var_0_0 = class("AshPlotModule", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController = arg_2_0.controller_:GetController("lock")

	arg_2_0:AddBtnListener(arg_2_0.clickMask_, nil, function()
		if arg_2_0.isUnlock and arg_2_0.plotCfg then
			if arg_2_0.plotCfg.real_type == 5 then
				AshSystemData:StartStory()
				manager.story:StartStoryById(arg_2_0.plotCfg.correlation_id, function()
					AshSystemData:EndStory()
				end)
			else
				JumpTools.OpenPageByJump("stageAshMomoTalk", {
					isSelectEnter = true,
					isSkip = true,
					customID = arg_2_0.plotCfg.correlation_id
				})
			end
		end
	end)
end

function var_0_0.Render(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.plotCfg = arg_5_1

	if not arg_5_1 then
		arg_5_0.lockController:SetSelectedState("true")

		arg_5_0.isUnlock = false

		return
	end

	local var_5_0 = arg_5_0.plotCfg.unlockRate

	if var_5_0 > AshSystemData:GetHomologyRate() then
		arg_5_0.lockController:SetSelectedState("true")

		arg_5_0.isUnlock = false
	else
		arg_5_0.lockController:SetSelectedState("false")

		arg_5_0.isUnlock = true
	end

	arg_5_0.numTxt_.text = "0" .. arg_5_2
	arg_5_0.unlockTxt_.text = string.format(GetTips("ASH_UNLOCK_TIP"), var_5_0)

	local var_5_1 = AshShootUnlockItemCfg[arg_5_0.plotCfg.unlock_id]

	arg_5_0.nameTxt_.text = var_5_1.story_name
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.super.Dispose(arg_6_0)
end

return var_0_0
