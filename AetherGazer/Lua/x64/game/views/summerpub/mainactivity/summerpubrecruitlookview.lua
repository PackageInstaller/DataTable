local var_0_0 = class("SummerPubRecruitLookView", ReduxView)

RECRUIT_PATH = "TextureConfig/Character/Icon/"

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Activity_SummerPub/MainPub/Activity_SummerPub_RecruitLookPopUI"
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
	arg_5_0:AddBtnListener(arg_5_0.m_bgmask, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_7_0)
	cfg = SummerPubHeroCfg[arg_7_0.params_.id]
	arg_7_0.heroName_.text = GetI18NText(cfg.hero_name)
	arg_7_0.heroDesc_.text = GetI18NText(cfg.resume_desc)
	arg_7_0.heroHobby_.text = GetI18NText(cfg.resume_preference)
	arg_7_0.heroIcon_.sprite = pureGetSpriteWithoutAtlas(RECRUIT_PATH .. cfg.resume_icon)
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.super.Dispose(arg_9_0)
end

return var_0_0
