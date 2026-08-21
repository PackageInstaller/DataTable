local var_0_0 = class("RankItemBase", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.commonPortrait_ = CommonHeadPortrait.New(arg_2_0.headItem_)

	arg_2_0:AddListeners()

	arg_2_0.rankController_ = arg_2_0.conExCollection_:GetController("rank")
end

function var_0_0.AddListeners(arg_3_0)
	arg_3_0:AddBtnListener(arg_3_0.viewBtn_, nil, function()
		JumpTools.OpenPageByJump("polyhedronRankSquads", {
			list = arg_3_0.heroList_
		})
	end)
end

function var_0_0.Refresh(arg_5_0, arg_5_1)
	arg_5_0.user_id = arg_5_1.user_id
	arg_5_0.rankText_.text = GetI18NText(arg_5_1.rank)
	arg_5_0.scoreText_.text = GetI18NText(arg_5_1.score)
	arg_5_0.layerText_.text = GetI18NText(arg_5_1.difficulty)
	arg_5_0.heroList_ = arg_5_1:GetSingleSelectHeroList()

	if arg_5_1.rank <= 3 then
		arg_5_0.rankController_:SetSelectedIndex(arg_5_1.rank)
	else
		arg_5_0.rankController_:SetSelectedIndex(0)
	end

	arg_5_0.nickText_.text = GetI18NText(arg_5_1.nick)

	arg_5_0.commonPortrait_:RenderHead(arg_5_1.portrait)
	arg_5_0.commonPortrait_:RenderFrame(arg_5_1.frame)
end

function var_0_0.Dispose(arg_6_0)
	arg_6_0.commonPortrait_:Dispose()
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
