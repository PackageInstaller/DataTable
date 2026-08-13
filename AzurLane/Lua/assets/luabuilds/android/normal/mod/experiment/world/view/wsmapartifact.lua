class = var_0_10000

local var_0_0 = "WSMapArtifact"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseEntity"))

var_0_1.Fields = {
	theme = "table",
	prefab = "string",
	transform = "userdata",
	attachment = "table",
	moduleTF = "userdata",
	item_info = "table"
}

function var_0_1.Build(arg_1_0)
	GetOrAddComponent = var_1_10001
	GameObject = var_1_10002
	arg_1_0.transform = var_1_10001(var_1_10002.New(), "RectTransform")
	arg_1_0.transform.name = "model"

	return
end

function var_0_1.Dispose(arg_2_0)
	arg_2_0:Unload()

	Destroy = var_1

	var_1(arg_2_0.transform)
	arg_2_0:Clear()

	return
end

function var_0_1.Setup(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	assert = var_1_10004

	var_1_10004(not arg_3_0.item_info)

	arg_3_0.item_info = arg_3_1
	arg_3_0.theme = arg_3_2
	arg_3_0.attachment = arg_3_3

	arg_3_0:Load()

	return
end

function var_0_1.Load(arg_4_0)
	arg_4_0.prefab = arg_4_0.item_info[3]
	PoolMgr = var_1_10002

	local var_4_0 = var_1_10002.GetInstance()
	local var_4_1 = var_2.GetPrefab

	WorldConst = var_1_10005

	var_4_1(var_4_0, var_1_10005.ResChapterPrefab .. var_1, var_1, true, function(arg_5_0)
		if arg_4_0.prefab then
			local var_5_0 = arg_4_0

			tf = var_2_10002
			var_5_0.moduleTF = var_2_10002(arg_5_0)

			local var_5_1 = arg_4_0.moduleTF

			var_1.SetParent(var_5_1, arg_4_0.transform, false)

			local var_5_2 = arg_4_0

			var_1.Init(var_5_2)
		else
			local var_5_3 = var_0
			local var_5_4 = var_1.ReturnPrefab

			WorldConst = var_2_10003

			var_5_4(var_5_3, var_2_10003.ResChapterPrefab .. var_0, var_0, arg_5_0)
		end

		return
	end)

	return
end

function var_0_1.Unload(arg_6_0)
	if arg_6_0.prefab and arg_6_0.moduleTF then
		PoolMgr = var_1

		local var_6_0 = var_1.GetInstance()
		local var_6_1 = var_1.ReturnPrefab

		WorldConst = var_1_10003

		var_6_1(var_6_0, var_1_10003.ResChapterPrefab .. arg_6_0.prefab, arg_6_0.prefab, arg_6_0.moduleTF.gameObject, true)
	end

	arg_6_0.prefab = nil
	arg_6_0.moduleTF = nil

	return
end

function var_0_1.Init(arg_7_0)
	local var_7_0 = arg_7_0.moduleTF
	local var_7_1 = var_1.GetComponent

	typeof = var_1_10003
	UnityEngine = var_1_10004

	local var_7_2 = var_7_1(var_7_0, var_1_10003(var_1_10004.UI.Graphic))

	IsNil = var_7_0

	if not var_7_0(var_7_2) then
		var_7_2.raycastTarget = false
	end

	local var_7_3 = arg_7_0.moduleTF
	local var_7_4 = var_2.GetComponentsInChildren

	typeof = var_4
	UnityEngine = var_1_10005

	local var_7_5 = var_7_4(var_7_3, var_4(var_1_10005.UI.Graphic), true)
	local var_7_6 = var_2.ToTable(var_7_5)

	ipairs = var_7_5

	for iter_7_0, iter_7_1 in var_7_5(var_7_6) do
		iter_7_1.raycastTarget = false
	end

	Vector2 = var_3

	local var_7_7 = var_3.zero

	Vector3 = var_4

	local var_7_8 = var_4.one

	Vector3 = var_5

	local var_7_9 = var_5.zero

	if arg_7_0.attachment then
		local var_7_10 = arg_7_0.attachment

		var_7_7 = var_6.GetDeviation(var_7_10)

		local var_7_11 = arg_7_0.attachment

		var_7_8 = var_6.GetScale(var_7_11)

		local var_7_12 = arg_7_0.attachment

		if var_6.GetMillor(var_7_12) then
			Vector3 = var_6

			if not var_6(0, 180, 0) then
				::label_7_0::

				Vector3 = var_6
				var_7_9 = var_6.zero
			end

			if false then
				Vector2 = var_6
				var_7_7 = var_6(arg_7_0.item_info[4], arg_7_0.item_info[5])
			end

			arg_7_0.transform.anchoredPosition = var_7_7
			arg_7_0.transform.localScale = var_7_8
			arg_7_0.transform.localEulerAngles = var_7_9

			return
		end
	end
end

return var_0_1
