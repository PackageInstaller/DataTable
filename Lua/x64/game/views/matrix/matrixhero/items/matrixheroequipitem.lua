local var_0_0 = class("MatrixHeroEquipItem", ReduxView)

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

function var_0_0.Refresh(arg_4_0, arg_4_1)
	local var_4_0 = MatrixItemCfg[arg_4_1]

	arg_4_0.m_icon.sprite = MatrixTools.GetMatrixItemSprite(arg_4_1)
	arg_4_0.m_nameLab.text = GetI18NText(var_4_0.name)
	arg_4_0.m_desLab.text = GetI18NText(MatrixTools.GetMatrixItemDes(arg_4_1))

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_4_0.m_content)

	if arg_4_0.m_viewport.rect.height < arg_4_0.m_content.rect.height then
		arg_4_0.m_scroller.enabled = true
	else
		arg_4_0.m_scroller.enabled = false
	end
end

return var_0_0
