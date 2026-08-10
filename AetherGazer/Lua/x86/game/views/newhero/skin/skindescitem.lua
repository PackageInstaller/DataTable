local var_0_0 = class("SkinDescItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListeners()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.RefreshUI(arg_6_0, arg_6_1)
	local var_6_0 = SkinTagDescCfg[arg_6_1]

	arg_6_0.title_.text = var_6_0.tag_title
	arg_6_0.desc_.text = var_6_0.tag_desc
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.descRect_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_0.rect_)
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllListeners()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
