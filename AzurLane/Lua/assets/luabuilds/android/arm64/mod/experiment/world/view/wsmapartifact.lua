local var_0_0 = class("WSMapArtifact", import("...BaseEntity"))

var_0_0.Fields = {
	theme = "table",
	prefab = "string",
	transform = "userdata",
	attachment = "table",
	moduleTF = "userdata",
	item_info = "table"
}

function var_0_0.Build(arg_1_0)
	arg_1_0.transform = GetOrAddComponent(GameObject.New(), "RectTransform")
	arg_1_0.transform.name = "model"

	return
end

function var_0_0.Dispose(arg_2_0)
	arg_2_0:Unload()
	Destroy(arg_2_0.transform)
	arg_2_0:Clear()

	return
end

function var_0_0.Setup(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	assert(not arg_3_0.item_info)

	arg_3_0.item_info = arg_3_1
	arg_3_0.theme = arg_3_2
	arg_3_0.attachment = arg_3_3

	arg_3_0:Load()

	return
end

function var_0_0.Load(arg_4_0)
	local var_4_0 = arg_4_0.item_info[3]

	arg_4_0.prefab = arg_4_0.item_info[3]

	local var_4_1 = PoolMgr.GetInstance()

	PoolMgr.GetInstance():GetPrefab(WorldConst.ResChapterPrefab .. arg_4_0.item_info[3], arg_4_0.item_info[3], true, function(arg_5_0)
		if arg_4_0.prefab then
			arg_4_0.moduleTF = tf(arg_5_0)

			arg_4_0.moduleTF:SetParent(arg_4_0.transform, false)
			arg_4_0:Init()
		else
			var_4_1:ReturnPrefab(WorldConst.ResChapterPrefab .. var_4_0, var_4_0, arg_5_0)
		end

		return
	end)

	return
end

function var_0_0.Unload(arg_6_0)
	if arg_6_0.prefab and arg_6_0.moduleTF then
		PoolMgr.GetInstance():ReturnPrefab(WorldConst.ResChapterPrefab .. arg_6_0.prefab, arg_6_0.prefab, arg_6_0.moduleTF.gameObject, true)
	end

	arg_6_0.prefab = nil
	arg_6_0.moduleTF = nil

	return
end

function var_0_0.Init(arg_7_0)
	local var_7_0 = arg_7_0.moduleTF:GetComponent(typeof(UnityEngine.UI.Graphic))

	if not IsNil(var_7_0) then
		var_7_0.raycastTarget = false
	end

	local var_7_1 = arg_7_0.moduleTF:GetComponentsInChildren(typeof(UnityEngine.UI.Graphic), true)

	for iter_7_0, iter_7_1 in ipairs((var_7_1:ToTable())) do
		iter_7_1.raycastTarget = false
	end

	local var_7_2 = Vector2.zero
	local var_7_3 = Vector3.one
	local var_7_4 = Vector3.zero

	if arg_7_0.attachment then
		var_7_2 = arg_7_0.attachment:GetDeviation()
		var_7_3 = arg_7_0.attachment:GetScale()
		var_7_4 = arg_7_0.attachment:GetMillor() and Vector3(0, 180, 0) or Vector3.zero
	else
		var_7_2 = Vector2(arg_7_0.item_info[4], arg_7_0.item_info[5])
	end

	arg_7_0.transform.anchoredPosition = var_7_2
	arg_7_0.transform.localScale = var_7_3
	arg_7_0.transform.localEulerAngles = var_7_4

	return
end

return var_0_0
