local var_0_0 = class("CowboyGameBackPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VolumeIIIUI/VolumeXiugameScoreUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		manager.audio:Pause("music", false)
		manager.audio:StopEffect()
		manager.audio:Pause("effect", false)
		JumpTools.OpenPageByJump("/cowboy", {
			activityId = arg_5_0.mainActivityID_
		})
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		manager.audio:Pause("music", false)
		manager.audio:Pause("effect", false)
		manager.notify:CallUpdateFunc(COWBOY_CONTINUE)
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.mainActivityID_ = arg_8_0.params_.mainActivityID
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
