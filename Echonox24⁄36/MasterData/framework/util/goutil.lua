module("framework.util.goutil", package.seeall)

local var_0_0 = {
	Type_UIRawImage = typeof(UnityEngine.UI.RawImage),
	Type_UIImage = typeof(UnityEngine.UI.Image),
	Type_UIText = typeof(UnityEngine.UI.Text),
	Type_UIButton = typeof(UnityEngine.UI.Button),
	Type_RectTransform = typeof(UnityEngine.RectTransform),
	Layer_UI = Astral.LayerUtil.NameToLayer("UI"),
	isNil = function(arg_1_0)
		return arg_1_0 == nil or arg_1_0:Equals(nil)
	end,
	find = function(arg_2_0)
		return (UnityEngine.GameObject.Find(arg_2_0))
	end,
	findChild = function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0.transform:Find(arg_3_1)

		if var_3_0 then
			return var_3_0.gameObject
		end

		return nil
	end
}

function var_0_0.findChildComponent(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.findChild(arg_4_0, arg_4_1)

	if var_4_0 then
		return var_4_0:GetComponent(arg_4_2)
	end

	return nil
end

function var_0_0.findChildRawImageComponent(arg_5_0, arg_5_1)
	return var_0_0.findChildComponent(arg_5_0, arg_5_1, var_0_0.Type_UIRawImage)
end

function var_0_0.findChildImageComponent(arg_6_0, arg_6_1)
	return var_0_0.findChildComponent(arg_6_0, arg_6_1, var_0_0.Type_UIImage)
end

function var_0_0.findChildTextComponent(arg_7_0, arg_7_1)
	return var_0_0.findChildComponent(arg_7_0, arg_7_1, var_0_0.Type_UIText)
end

function var_0_0.findChildButtonComponent(arg_8_0, arg_8_1)
	return var_0_0.findChildComponent(arg_8_0, arg_8_1, var_0_0.Type_UIButton)
end

function var_0_0.addComponentOnce(arg_9_0, arg_9_1)
	return arg_9_0:GetComponent(arg_9_1) or arg_9_0:AddComponent(arg_9_1)
end

function var_0_0.addChildToParent(arg_10_0, arg_10_1)
	if not var_0_0.isNil(arg_10_0) then
		arg_10_0.transform:SetParent(arg_10_1 and arg_10_1.transform or nil, false)
	end
end

function var_0_0.create(arg_11_0, arg_11_1)
	local var_11_0 = UnityEngine.GameObject.New()

	if arg_11_0 ~= nil then
		var_11_0.name = arg_11_0
	end

	if arg_11_1 ~= false then
		var_11_0:AddComponent(var_0_0.Type_RectTransform)

		var_11_0.layer = var_0_0.Layer_UI
	end

	return var_11_0
end

function var_0_0.clearChildren(arg_12_0)
	local var_12_0 = arg_12_0.transform

	for iter_12_0 = var_12_0.childCount, 1, -1 do
		local var_12_1 = var_12_0:GetChild(iter_12_0 - 1)

		UnityEngine.GameObject.Destroy(var_12_1.gameObject)
	end

	var_12_0:DetachChildren()
end

function var_0_0.clone(arg_13_0, arg_13_1)
	if arg_13_0 == nil then
		return nil
	end

	local var_13_0 = UnityEngine.GameObject.Instantiate(arg_13_0)

	if arg_13_1 ~= nil then
		var_13_0.name = arg_13_1
	end

	return var_13_0
end

function var_0_0.cloneAndSetParent(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0 == nil then
		return nil
	end

	return (Astral.GameObjectUtil.CloneAndSetParent(arg_14_0, arg_14_1, arg_14_2))
end

function var_0_0.destroy(arg_15_0, arg_15_1)
	if arg_15_0 == nil then
		return
	end

	UnityEngine.GameObject.Destroy(arg_15_0)
end

function var_0_0.getWidth(arg_16_0)
	return arg_16_0.rect.width
end

function var_0_0.getHeight(arg_17_0)
	return arg_17_0.rect.height
end

function var_0_0.setWidth(arg_18_0, arg_18_1)
	Astral.GeometryUtil.SetWidth(arg_18_0, arg_18_1)
end

function var_0_0.setHeight(arg_19_0, arg_19_1)
	Astral.GeometryUtil.SetHeight(arg_19_0, arg_19_1)
end

function var_0_0.screenToLocalPos(arg_20_0, arg_20_1)
	local var_20_0 = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	return Astral.GeometryUtil.ScreenToLocalPos(arg_20_0, arg_20_1, var_20_0)
end

function var_0_0.setActive(arg_21_0, arg_21_1)
	if arg_21_0 == nil or var_0_0.isNil(arg_21_0) then
		return
	end

	arg_21_1 = checkbool(arg_21_1)

	if arg_21_0.activeSelf ~= arg_21_1 then
		arg_21_0:SetActive(arg_21_1)
	end
end

function var_0_0.uiPath(arg_22_0)
	local var_22_0, var_22_1 = arg_22_0.transform, ""

	while not var_0_0.isNil(var_22_0) do
		var_22_1 = "/" .. var_22_0.name .. var_22_1
		var_22_0 = var_22_0.parent
	end

	return var_22_1
end

setglobal("goutil", var_0_0)
