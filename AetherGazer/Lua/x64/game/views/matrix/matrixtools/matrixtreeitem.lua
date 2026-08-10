local var_0_0 = class("MatrixTreeItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.id = arg_5_2
	arg_5_0.tag = arg_5_1

	arg_5_0:UpdateView()
end

function var_0_0.UpdateView(arg_6_0)
	local var_6_0 = MatrixData:GetHeroData(arg_6_0.id)
	local var_6_1 = HeroCfg[arg_6_0.id]

	arg_6_0.m_name.text = GetI18NText(var_6_1.name)
	arg_6_0.m_icon.sprite = HeroTools.GetHeadSprite(MatrixData:GetHeroSkin(arg_6_0.id))

	local var_6_2 = var_6_0:GetHeroHP()
	local var_6_3 = var_6_0:GetHeroMaxHP()

	arg_6_0.m_filled.fillAmount = var_6_3 == 0 and 0 or var_6_2 / var_6_3
end

function var_0_0.GetToggle(arg_7_0)
	return arg_7_0.m_toggle
end

function var_0_0.Dispose(arg_8_0)
	arg_8_0:RemoveAllListeners()
	Object.Destroy(arg_8_0.gameObject_)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
