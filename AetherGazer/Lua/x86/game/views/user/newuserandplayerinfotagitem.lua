local var_0_0 = class("NewUserAndPlayerInfoTagItem", ReduxView)
local var_0_1 = 288

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

	arg_3_0.textContentFitter_ = arg_3_0.desc_.transform:GetComponent("ContentSizeFitter")
	arg_3_0.typeCon_ = ControllerUtil.GetController(arg_3_0.transform_, "type")
end

function var_0_0.AddUIListeners(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.SetData(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, true)

	arg_6_0.id_ = arg_6_1
	arg_6_0.cfg_ = ProfileLabelCfg[arg_6_0.id_]
	arg_6_0.desc_.text = arg_6_0.cfg_.name

	arg_6_0.typeCon_:SetSelectedState(arg_6_0.cfg_.type)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.desc_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.transform_)

	if arg_6_0.desc_.transform.rect.width < var_0_1 then
		arg_6_0.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize
	else
		arg_6_0.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
		arg_6_0.descRect_.sizeDelta = Vector2(var_0_1, arg_6_0.descRect_.sizeDelta.y)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.desc_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_0.transform_)
end

function var_0_0.Show(arg_7_0, arg_7_1)
	SetActive(arg_7_0.gameObject_, arg_7_1)
end

function var_0_0.OnExit(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
