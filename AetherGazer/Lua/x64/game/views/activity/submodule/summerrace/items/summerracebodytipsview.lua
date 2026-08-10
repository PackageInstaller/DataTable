local var_0_0 = class("SummerRaceBodyTipsView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		SetActive(arg_3_0.rootGo_, false)

		return
	end

	SetActive(arg_3_0.rootGo_, true)

	arg_3_0.titleText_.text = tostring(arg_3_1.title or "")
	arg_3_0.hpText_.text = tostring(arg_3_1.hpText or arg_3_1.hp or "0")
	arg_3_0.costText_.text = tostring(arg_3_1.costText or arg_3_1.cost or "0")
	arg_3_0.descText_.text = tostring(arg_3_1.desc or "")
end

return var_0_0
