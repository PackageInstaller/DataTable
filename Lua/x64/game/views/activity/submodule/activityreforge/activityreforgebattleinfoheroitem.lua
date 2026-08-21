local var_0_0 = class("ActivityReforgeBattleInfoHeroItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.heroHeadItem_ = ActivityReforgeHeroHeadItem.New(arg_3_0.heroHeadGo_)
end

function var_0_0.SetData(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = ActivityReforgeData:GetFinishWaveHeroInfo(arg_4_1, arg_4_2)

	if var_4_0.leftHp <= 0 then
		SetActive(arg_4_0.diePanelGo_, true)

		arg_4_0.curHpImage_.fillAmount = 0
	else
		SetActive(arg_4_0.diePanelGo_, false)

		arg_4_0.curHpImage_.fillAmount = var_4_0.leftHp / var_4_0.maxHp
	end

	arg_4_0.heroHeadItem_:SetData(arg_4_2)
end

function var_0_0.Dispose(arg_5_0)
	arg_5_0.heroHeadItem_:Dispose()

	arg_5_0.heroHeadItem_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
