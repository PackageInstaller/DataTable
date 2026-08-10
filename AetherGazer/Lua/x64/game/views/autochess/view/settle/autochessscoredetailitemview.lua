local var_0_0 = class("AutoChessScoreDetailItemView", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	local var_3_0 = AutoChessPVPScoreCfg[arg_3_1.id]

	arg_3_0.titleText_.text = var_3_0.title
	arg_3_0.scoreText_.text = arg_3_1.score
	arg_3_0.icon_.sprite = getSprite("Atlas/Activity_OsirisHorusAtlas", var_3_0.icon)
end

function var_0_0.SetActive(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

return var_0_0
