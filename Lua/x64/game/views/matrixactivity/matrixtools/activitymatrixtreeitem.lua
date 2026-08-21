local var_0_0 = class("ActivityMatrixTreeItem", MatrixTreeItem)

function var_0_0.SetData(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_2
	arg_1_0.tag = arg_1_1
	arg_1_0.matrix_activity_id = arg_1_3

	arg_1_0:UpdateView()
end

function var_0_0.UpdateView(arg_2_0)
	local var_2_0 = ActivityMatrixData:GetHeroData(arg_2_0.matrix_activity_id, arg_2_0.id)
	local var_2_1 = HeroCfg[arg_2_0.id]

	arg_2_0.m_name.text = GetI18NText(var_2_1.name)
	arg_2_0.m_icon.sprite = HeroTools.GetHeadSprite(ActivityMatrixData:GetHeroSkin(arg_2_0.matrix_activity_id, arg_2_0.id))

	local var_2_2 = var_2_0:GetHeroHP()
	local var_2_3 = var_2_0:GetHeroMaxHP()

	arg_2_0.m_filled.fillAmount = var_2_3 == 0 and 0 or var_2_2 / var_2_3
end

return var_0_0
