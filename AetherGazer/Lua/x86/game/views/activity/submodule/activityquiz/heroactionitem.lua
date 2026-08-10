local var_0_0 = class("HeroActionItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.buttonItem_, nil, function()
		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_SEND_ACTION, arg_4_0.act_)
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.Refresh(arg_7_0, arg_7_1)
	arg_7_0.act_ = arg_7_1
	arg_7_0.imageIcon_.spriteSync = "TextureConfig/VersionUI/CORGUI_SandPlay_Com/SandPlay_Com_AnswerUI/" .. arg_7_0.act_
end

function var_0_0.OnExit(arg_8_0)
	arg_8_0:RemoveAllEventListener()
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
