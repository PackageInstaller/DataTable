local var_0_0 = class("GuildActivitySPRaceRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.commonPortrait_ = CommonHeadPortrait.New(arg_3_0.headItem_)
	arg_3_0.heroCountController_ = ControllerUtil.GetController(arg_3_0.transform_, "heroCount")
	arg_3_0.rankController_ = ControllerUtil.GetController(arg_3_0.transform_, "rank")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.userID_ = arg_4_1.user_id
	arg_4_0.name_.text = arg_4_1.nick

	arg_4_0.commonPortrait_:RenderHead(arg_4_1.icon)
	arg_4_0.commonPortrait_:RenderFrame(arg_4_1.icon_frame)

	arg_4_0.rank_.text = arg_4_1.rank
	arg_4_0.score_.text = arg_4_1.score

	local var_4_0 = arg_4_1.select_hero_id_list
	local var_4_1 = math.min(table.length(var_4_0), 3)

	arg_4_0.heroCountController_:SetSelectedState(var_4_1)

	for iter_4_0 = 1, var_4_1 do
		arg_4_0["m_heroIcon_" .. iter_4_0].sprite = getSpriteViaConfig("HeroLittleIcon", var_4_0[iter_4_0])
	end

	if arg_4_1.rank <= 3 then
		arg_4_0.rankController_:SetSelectedState(arg_4_1.rank)
	else
		arg_4_0.rankController_:SetSelectedState(0)
	end
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
