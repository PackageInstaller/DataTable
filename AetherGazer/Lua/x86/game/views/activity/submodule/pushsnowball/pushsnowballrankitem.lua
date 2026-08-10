local var_0_0 = class("AdvanceTestRankItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.rankController_ = ControllerUtil.GetController(arg_2_0.transform_, "rank")
	arg_2_0.stateController_ = ControllerUtil.GetController(arg_2_0.transform_, "state")
end

function var_0_0.Refresh(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.rankText_.text = arg_3_1.rank

	if arg_3_2 == 1 then
		arg_3_0.scoreText_.text = arg_3_1.score
		arg_3_0.campText_.text = arg_3_1.extraInfo[1] == 1 and "Boss" or GetTips("ACTIVITY_SNOWBALL_PUSH_RANK_TEAM")

		arg_3_0.stateController_:SetSelectedState("boss")
	else
		arg_3_0.campText_.text = ""
		arg_3_0.killNumText_.text = arg_3_1.score

		arg_3_0.stateController_:SetSelectedState("neck")
	end

	if arg_3_1.rank <= 3 then
		arg_3_0.rankController_:SetSelectedIndex(arg_3_1.rank - 1)
	else
		arg_3_0.rankController_:SetSelectedIndex(3)
	end

	arg_3_0.nameText_.text = arg_3_1.nick
	arg_3_0.iconImg_.sprite = ItemTools.getItemSprite(arg_3_1.portrait)
	arg_3_0.frameImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_3_1.frame)
end

return var_0_0
