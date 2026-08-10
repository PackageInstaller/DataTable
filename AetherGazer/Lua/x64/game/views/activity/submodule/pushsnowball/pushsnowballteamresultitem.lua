local var_0_0 = class("PushSnowBallTeamResultItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:initUI()
end

function var_0_0.initUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.rankController_ = ControllerUtil.GetController(arg_2_0.transform_, "rank")
end

function var_0_0.SetData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.data_ = arg_3_2
	arg_3_0.index_ = arg_3_1

	arg_3_0:Refresh()
end

function var_0_0.Refresh(arg_4_0)
	if arg_4_0.rankText_ then
		arg_4_0.rankText_.text = arg_4_0.data_.rank
	end

	if arg_4_0.scoreText_ then
		arg_4_0.scoreText_.text = arg_4_0.data_.score
	end

	if arg_4_0.rankController_ then
		if arg_4_0.data_.rank <= 3 then
			arg_4_0.rankController_:SetSelectedIndex(arg_4_0.data_.rank - 1)
		else
			arg_4_0.rankController_:SetSelectedIndex(0)
		end
	end

	arg_4_0.nameText_.text = arg_4_0.data_.nick
	arg_4_0.iconImg_.sprite = ItemTools.getItemSprite(arg_4_0.data_.icon)
	arg_4_0.frameImg_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_4_0.data_.frame)
end

return var_0_0
