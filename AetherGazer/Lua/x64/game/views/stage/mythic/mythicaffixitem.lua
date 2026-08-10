local var_0_0 = class("MythicAffixItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = Object.Instantiate(arg_1_1, arg_1_2.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()

	arg_2_0.lockController = ControllerUtil.GetController(arg_2_0.transform_, "lock")
end

function var_0_0.SetData(arg_3_0, arg_3_1)
	if arg_3_1.lock then
		arg_3_0.lockController:SetSelectedIndex(1)
	else
		arg_3_0.lockController:SetSelectedIndex(0)

		arg_3_0.nameText_.text = getAffixName(arg_3_1)
		arg_3_0.icon_.sprite = getAffixSprite(arg_3_1)
		arg_3_0.level_.text = arg_3_1[2]
	end

	arg_3_0:Show(true)
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.Dispose(arg_5_0)
	Object.Destroy(arg_5_0.gameObject_)

	arg_5_0.gameObject_ = nil

	var_0_0.super.Dispose(arg_5_0)
end

return var_0_0
