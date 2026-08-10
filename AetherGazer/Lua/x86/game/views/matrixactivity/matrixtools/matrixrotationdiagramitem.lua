local var_0_0 = class("MatrixRotationDiagramItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Object.Instantiate(arg_1_1, arg_1_2)

	arg_1_0.gameObject_ = var_1_0
	arg_1_0.transform_ = var_1_0.transform
	arg_1_0.rectTransform_ = var_1_0:GetComponent(typeof(RectTransform))

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()

	arg_2_0.campController = ControllerUtil.GetController(arg_2_0.transform_, "camp")
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.SetData(arg_5_0, arg_5_1)
	arg_5_0.index = arg_5_1

	arg_5_0.campController:SetSelectedIndex(arg_5_1 - 1)

	arg_5_0.img = arg_5_0["m_img" .. arg_5_1]
end

function var_0_0.RegistCallBack(arg_6_0, arg_6_1)
	arg_6_0.callback_ = arg_6_1
end

function var_0_0.SetPosId(arg_7_0, arg_7_1)
	arg_7_0.posId = arg_7_1
end

function var_0_0.GetPosId(arg_8_0)
	return arg_8_0.posId
end

function var_0_0.GetIndex(arg_9_0)
	return arg_9_0.index
end

function var_0_0.InitPosData(arg_10_0, arg_10_1)
	arg_10_0.rectTransform_.anchoredPosition = arg_10_1.pos
	arg_10_0.m_container.transform.localScale = Vector2.one * arg_10_1.scale
	arg_10_0.img.color = arg_10_1.color

	arg_10_0.transform_:SetSiblingIndex(arg_10_1.order)
end

function var_0_0.SetPosData(arg_11_0, arg_11_1)
	local var_11_0 = Vector3.one * arg_11_1.scale
	local var_11_1 = arg_11_1.pos

	LeanTween.scale(arg_11_0.m_container, var_11_0, 0.5):setEase(LeanTweenType.easeOutQuad)
	LeanTween.moveLocal(arg_11_0.gameObject_, var_11_1, 0.5):setEase(LeanTweenType.easeOutQuad)

	local var_11_2 = arg_11_0.img.color
	local var_11_3 = arg_11_1.color

	LeanTween.value(arg_11_0.gameObject_, 0, 1, 0.5):setEase(LeanTweenType.easeOutQuad):setOnUpdate(LuaHelper.FloatAction(function(arg_12_0)
		arg_11_0.img.color = Color.Lerp(var_11_2, var_11_3, arg_12_0)
	end))
	arg_11_0.transform_:SetSiblingIndex(arg_11_1.order)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)
end

return var_0_0
