local var_0_0 = class("BossSwitchItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.info_ = arg_1_2

	arg_1_0:InitUI()
	arg_1_0:Init()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1)
	arg_2_0.info_ = arg_2_1

	local var_2_0 = DamageTestCfg[arg_2_0.info_.id]
	local var_2_1 = BossChallengeUICfg[var_2_0.boss_id]

	arg_2_0.icon_.sprite = pureGetSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossLittlePaint.path, var_2_1.icon))
	arg_2_0.nameText_.text = GetI18NText(var_2_1.main_name)
	arg_2_0.numText_.text = string.format("NO.%02d", arg_2_0.info_.index)
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
	arg_3_0:AddBtnListener(nil, nil, "OnClick")
end

function var_0_0.Init(arg_4_0)
	return
end

function var_0_0.AddListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		return
	end)
end

function var_0_0.OnClick(arg_7_0)
	if arg_7_0.clickFunc_ then
		arg_7_0.clickFunc_(arg_7_0.info_)
	end
end

function var_0_0.RegistCallBack(arg_8_0, arg_8_1)
	arg_8_0.clickFunc_ = arg_8_1
end

function var_0_0.GetItemInfo(arg_9_0)
	return arg_9_0.info_
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.clickFunc_ = nil

	arg_10_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
