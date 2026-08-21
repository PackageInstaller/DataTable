local var_0_0 = class("GuildBossTeamHeadItemView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroHead_ = NewHeroHead.New(arg_3_0.headGo_)

	arg_3_0.heroHead_:SetRedPointEnable(false)
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.AddEventListeners(arg_5_0)
	return
end

function var_0_0.SetTeamMark(arg_6_0, arg_6_1, arg_6_2)
	SetActive(arg_6_0.teamMark_, arg_6_1)

	if arg_6_1 then
		arg_6_0.teamMarkText_.text = GetI18NText(arg_6_2)
	end
end

function var_0_0.SetHeroData(arg_7_0, arg_7_1)
	arg_7_0.heroId_ = arg_7_1

	arg_7_0.heroHead_:SetHeroId(arg_7_1)
	arg_7_0:UpdateView()
end

function var_0_0.SetSelected(arg_8_0, arg_8_1)
	arg_8_0.heroHead_:SetSelected(arg_8_1)
end

function var_0_0.RegisterClickListener(arg_9_0, arg_9_1)
	arg_9_0.heroHead_:RegisterClickListener(arg_9_1)
end

function var_0_0.UpdateView(arg_10_0)
	return
end

function var_0_0.OnEnter(arg_11_0)
	arg_11_0:AddEventListeners()
end

function var_0_0.OnExit(arg_12_0)
	arg_12_0:RemoveAllEventListener()
end

function var_0_0.OnMainHomeViewTop(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	arg_14_0.heroId_ = nil

	if arg_14_0.heroHead_ then
		arg_14_0.heroHead_:Dispose()

		arg_14_0.heroHead_ = nil
	end

	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
