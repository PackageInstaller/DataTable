local var_0_0 = class("HodurMainlineStageItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.stateController_ = arg_2_0.mainControllerEx_:GetController("state")
	arg_2_0.selectController_ = arg_2_0.mainControllerEx_:GetController("select")
	arg_2_0.lineController_ = arg_2_0.mainControllerEx_:GetController("line")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	arg_3_0.stageID_ = arg_3_1

	arg_3_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_4_0)
	local var_4_0 = ActivityHodurCfg[arg_4_0.stageID_]

	arg_4_0.bossHeadImg_1.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. var_4_0.boss_img)
	arg_4_0.bossHeadImg_2.sprite = getSpriteWithoutAtlas(HodurConst.BOSS_IMG_PATH .. var_4_0.boss_img)
end

function var_0_0.SetActive(arg_5_0, arg_5_1)
	SetActive(arg_5_0.gameObject_, arg_5_1)
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
