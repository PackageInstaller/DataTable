local var_0_0 = class("HeroPageBase", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.handler_ = arg_1_1
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	return
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetHeroInfo(arg_5_0, arg_5_1)
	return
end

function var_0_0.PlayEnterAni(arg_6_0)
	arg_6_0.playableDirector_ = arg_6_0.playableDirector_ or arg_6_0:FindCom(typeof(PlayableDirector), "panel")

	if arg_6_0.playableDirector_ then
		arg_6_0.playableDirector_.time = 0

		arg_6_0.playableDirector_:Play()
	end
end

function var_0_0.OnEnter(arg_7_0)
	return
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Hide(arg_9_0)
	SetActive(arg_9_0.gameObject_, false)
end

function var_0_0.Show(arg_10_0)
	SetActive(arg_10_0.gameObject_, true)
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	arg_11_0.handler_ = nil

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
