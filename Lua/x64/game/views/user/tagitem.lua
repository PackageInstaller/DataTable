local var_0_0 = class("TagItem", ReduxView)
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
	arg_3_0.selectCon_ = ControllerUtil.GetController(arg_3_0.transform_, "select")
end

function var_0_0.AddUIListeners(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if arg_4_0.clickFun_ then
			arg_4_0.clickFun_(arg_4_0.id_)
		end
	end)
end

function var_0_0.OnEnter(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.id_ = arg_7_1.id

	arg_7_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_8_0)
	manager.redPoint:unbindUIandKey(arg_8_0.transform_)
	SetActive(arg_8_0.gameObject_, true)

	arg_8_0.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize
	arg_8_0.cfg_ = ProfileLabelCfg[arg_8_0.id_]
	arg_8_0.desc_.text = arg_8_0.cfg_.name

	arg_8_0.typeCon_:SetSelectedState(arg_8_0.cfg_.type)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.desc_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.transform_)

	if arg_8_0.desc_.transform.rect.width < var_0_1 then
		arg_8_0.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize
	else
		arg_8_0.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
		arg_8_0.descRect_.sizeDelta = Vector2(var_0_1, arg_8_0.descRect_.sizeDelta.y)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.desc_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.transform_)
	manager.redPoint:bindUIandKey(arg_8_0.transform_, RedPointConst.TAG .. "_" .. arg_8_0.id_)
end

function var_0_0.RefreshSelect(arg_9_0, arg_9_1)
	arg_9_0.selectCon_:SetSelectedState(arg_9_1 and "on" or "off")
end

function var_0_0.GetID(arg_10_0)
	return arg_10_0.id_
end

function var_0_0.Show(arg_11_0, arg_11_1)
	SetActive(arg_11_0.gameObject_, arg_11_1)
end

function var_0_0.RegisterClickFunction(arg_12_0, arg_12_1)
	arg_12_0.clickFun_ = arg_12_1
end

function var_0_0.OnExit(arg_13_0)
	return
end

function var_0_0.Dispose(arg_14_0)
	manager.redPoint:unbindUIandKey(arg_14_0.transform_)
	arg_14_0:RemoveAllEventListener()
	var_0_0.super.Dispose(arg_14_0)
end

return var_0_0
