local var_0_0 = class("SkillComboSubItem", ReduxView)

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
end

function var_0_0.Show(arg_4_0, arg_4_1)
	SetActive(arg_4_0.gameObject_, arg_4_1)
end

function var_0_0.RefreshData(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.icon_.sprite = getSprite("Atlas/" .. arg_5_2, arg_5_1.list_icon[arg_5_3])
	arg_5_0.nameText_.text = GetI18NText(arg_5_1.list_name[arg_5_3])

	if #arg_5_1.list_icon ~= arg_5_3 then
		if arg_5_1.combine_char[arg_5_3] == "或" then
			arg_5_0.signImg_.enabled = false
			arg_5_0.signText_.text = GetTips("TIP_OR")

			SetActive(arg_5_0.signText_.gameObject, true)
		else
			arg_5_0.signImg_.enabled = true
			arg_5_0.signImg_.sprite = getSprite("Atlas/SettingAtlas", arg_5_1.combine_char[arg_5_3])
			arg_5_0.signText_.text = ""

			SetActive(arg_5_0.signText_.gameObject, false)
		end
	else
		arg_5_0.signImg_.enabled = false
		arg_5_0.signText_.text = ""

		SetActive(arg_5_0.signText_.gameObject, false)
	end
end

function var_0_0.Dispose(arg_6_0)
	var_0_0.super.Dispose(arg_6_0)
end

return var_0_0
