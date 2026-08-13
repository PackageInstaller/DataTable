class = var_0_10000

local var_0_0 = var_0_10000("GuideUIDuplicator")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.caches = {}
	arg_1_0.root = arg_1_1

	return
end

function var_0_0.Duplicate(arg_2_0, arg_2_1, arg_2_2)
	Object = var_1_10003

	local var_2_0 = var_1_10003.Instantiate(arg_2_1, arg_2_0.root).transform

	setActive = var_1_10004

	var_1_10004(var_2_0, true)
	arg_2_0:InitDuplication(var_2_0, arg_2_1, arg_2_2)

	if arg_2_2 then
		arg_2_0:UpdateSettings(var_2_0, arg_2_1, arg_2_2)
	end

	table = var_4

	var_4.insert(arg_2_0.caches, var_2_0)

	return var_2_0
end

local function var_0_1(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.GetComponent

	typeof = var_1_10004
	Button = var_1_10006

	local var_3_6

	if var_3_1(var_3_0, var_1_10004(var_1_10006)) == nil then
		local var_3_2 = arg_3_0
		local var_3_3 = arg_3_0.GetComponent

		typeof = var_4
		Toggle = var_1_10006

		if var_3_3(var_3_2, var_4(var_1_10006)) == nil then
			local var_3_4 = arg_3_0
			local var_3_5 = arg_3_0.GetComponent

			typeof = var_4
			EventTriggerListener = var_1_10006

			if var_3_5(var_3_4, var_4(var_1_10006)) == nil then
				var_3_6 = false

				goto label_3_0
			end
		end
	end

	var_3_6 = true

	::label_3_0::

	return var_3_6
end

local function var_0_2(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.GetComponent

	typeof = var_1_10004
	Button = var_1_10006

	local var_4_2 = var_4_1(var_4_0, var_1_10004(var_1_10006))
	local var_4_3 = arg_4_0
	local var_4_4 = arg_4_0.GetComponentsInChildren

	typeof = var_1_10005
	Button = var_1_10007

	local var_4_5 = var_4_4(var_4_3, var_1_10005(var_1_10007))
	local var_4_6 = var_2.ToTable(var_4_5)

	ipairs = var_4_0

	for iter_4_0, iter_4_1 in var_4_0(var_4_6) do
		if var_4_2 ~= iter_4_1 then
			iter_4_1.enabled = false
		end
	end

	local var_4_7 = arg_4_0
	local var_4_8 = arg_4_0.GetComponent

	typeof = iter_4_0
	Toggle = var_1_10008

	local var_4_9 = var_4_8(var_4_7, iter_4_0(var_1_10008))
	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.GetComponentsInChildren

	typeof = iter_4_1
	Toggle = var_1_10009

	local var_4_12 = var_4_11(var_4_10, iter_4_1(var_1_10009))
	local var_4_13 = var_4.ToTable(var_4_12)

	ipairs = var_4_7

	for iter_4_2, iter_4_3 in var_4_7(var_4_13) do
		if var_4_9 ~= iter_4_3 then
			iter_4_3.enabled = false
		end
	end

	if var_4_9 then
		setToggleEnabled = var_5

		var_5(arg_4_0, true)
	end

	return
end

local function var_0_3(arg_5_0)
	LeanTween = var_1_10001

	if var_1_10001.isTweening(arg_5_0.gameObject) then
		LeanTween = var_1

		var_1.cancel(arg_5_0.gameObject)
	end

	eachChild = var_1

	var_1(arg_5_0, function(arg_6_0)
		LeanTween = var_2_10001

		if var_2_10001.isTweening(arg_6_0.gameObject) then
			LeanTween = var_1

			var_1.cancel(arg_6_0.gameObject)
		end

		return
	end)

	return
end

local function var_0_4(arg_7_0)
	ipairs = var_1_10001

	local var_7_0 = {}

	Animator = var_1_10004
	var_7_0[1] = var_1_10004
	Animation = var_1_10004
	var_7_0[2] = var_1_10004

	for iter_7_0, iter_7_1 in var_1_10001(var_7_0) do
		local var_7_1 = arg_7_0
		local var_7_2 = arg_7_0.GetComponentsInChildren

		typeof = var_1_10009

		local var_7_3 = var_7_2(var_7_1, var_1_10009(iter_7_1))
		local var_7_4 = var_6.ToTable(var_7_3)

		ipairs = var_1_10007

		for iter_7_2, iter_7_3 in var_1_10007(var_7_4) do
			iter_7_3.enabled = false
		end
	end

	return
end

function var_0_0.InitDuplication(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.GetComponent

	typeof = var_1_10007
	CanvasGroup = var_1_10009

	if var_8_1(var_8_0, var_1_10007(var_1_10009)) then
		var_4.alpha = 1
	end

	local var_8_2 = arg_8_1
	local var_8_3 = arg_8_1.GetComponentInChildren

	typeof = var_1_10008
	UnityEngine = var_1_10010

	local var_8_4 = var_8_3(var_8_2, var_1_10008(var_1_10010.UI.Graphic))
	local var_8_5 = arg_8_1
	local var_8_6 = arg_8_1.GetComponentInChildren

	typeof = var_1_10009
	Canvas = iter_8_0

	if var_8_6(var_8_5, var_1_10009(iter_8_0)) or var_8_4 == nil then
		GetOrAddComponent = var_8_2

		local var_8_7 = arg_8_1

		typeof = var_10
		Image = iter_8_1

		local var_8_8 = var_8_2(var_8_7, var_10(iter_8_1))

		Color = var_8_5
		var_8_8.color = var_8_5.New(1, 1, 1, 0)
	end

	if var_8_4 and var_8_4.raycastTarget == false then
		var_8_4.raycastTarget = true
	end

	var_0_4(arg_8_1)

	if var_0_1(arg_8_1) or arg_8_3.clearChildEvent then
		var_0_2(arg_8_1)
	end

	var_0_3(arg_8_1)

	if not arg_8_3.keepScrollTxt then
		local var_8_9 = arg_8_1
		local var_8_10 = arg_8_1.GetComponentsInChildren

		typeof = var_10
		ScrollText = iter_8_1

		local var_8_11 = var_8_10(var_8_9, var_10(iter_8_1))
		local var_8_12 = var_7.ToTable(var_8_11)

		ipairs = var_8_5

		for iter_8_0, iter_8_1 in var_8_5(var_8_12) do
			setActive = var_1_10013

			var_1_10013(iter_8_1.gameObject, false)
		end
	end

	local var_8_13 = arg_8_1
	local var_8_14 = arg_8_1.GetComponent

	typeof = var_10
	Canvas = iter_8_1

	if var_8_14(var_8_13, var_10(iter_8_1)) then
		local var_8_15 = arg_8_1
		local var_8_16 = arg_8_1.GetComponent

		typeof = iter_8_0
		GraphicRaycaster = var_1_10013

		if var_8_16(var_8_15, iter_8_0(var_1_10013)) == nil then
			GetOrAddComponent = var_8

			local var_8_17 = arg_8_1

			typeof = var_11
			GraphicRaycaster = var_1_10013

			var_8(var_8_17, var_11(var_1_10013))
		end
	end

	arg_8_1.anchorMax = arg_8_1.pivot
	arg_8_1.anchorMin = arg_8_1.pivot
	arg_8_1.sizeDelta = arg_8_2.rect.size

	return
end

function var_0_0.UpdateSettings(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3.customPosition then
		arg_9_0:SetCustomPosition(arg_9_1, arg_9_2, arg_9_3)
	else
		arg_9_0:Syn(arg_9_1, arg_9_2, arg_9_3)
	end

	if arg_9_3.clearAllEvent then
		GetOrAddComponent = var_4

		local var_9_0 = arg_9_1

		typeof = var_1_10007
		CanvasGroup = var_1_10009
		var_4(var_9_0, var_1_10007(var_1_10009)).blocksRaycasts = false
	end

	return
end

function var_0_0.SetCustomPosition(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3.pos then
		Vector3 = var_4

		local var_10_0 = arg_10_3.pos.x
		local var_10_1 = arg_10_3.pos.y
		local var_10_2

		if not arg_10_3.pos.z then
			var_10_2 = 0
		end

		arg_10_1.localPosition = var_4(var_10_0, var_10_1, var_10_2)
	elseif arg_10_3.isLevelPoint then
		pg = var_4

		local var_10_3 = var_4.UIMgr.GetInstance().levelCameraComp
		local var_10_4 = arg_10_2.transform.parent

		var_1_10005 = var_1_10005.TransformPoint(var_10_4, arg_10_2.transform.localPosition)

		local var_10_5 = var_10_3
		local var_10_6 = var_10_3.WorldToScreenPoint(var_10_5, var_1_10005)

		pg = var_10_4

		local var_10_7 = var_10_4.UIMgr.GetInstance().overlayCameraComp

		LuaHelper = var_10_5
		arg_10_1.localPosition = var_10_5.ScreenToLocal(arg_10_0.root, var_10_6, var_10_7)
	else
		arg_10_1.position = arg_10_2.transform.position
		Vector3 = var_4
		arg_10_1.localPosition = var_4(arg_10_1.localPosition.x, arg_10_1.localPosition.y, 0)
	end

	local var_10_8

	if not arg_10_3.scale then
		var_10_8 = 1
	end

	Vector3 = var_1_10005
	arg_10_1.localScale = var_1_10005(var_10_8, var_10_8, var_10_8)

	if arg_10_3.eulerAngles then
		Vector3 = var_10_9

		local var_10_9

		if not var_10_9(arg_10_3.eulerAngles[1], arg_10_3.eulerAngles[2], arg_10_3.eulerAngles[3]) then
			Vector3 = var_10_9
			var_10_9 = var_10_9(0, 0, 0)
		end

		arg_10_1.eulerAngles = var_10_9

		return
	end
end

local function var_0_5(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0.root
	local var_11_1 = var_4.InverseTransformPoint(var_11_0, arg_11_2.transform.position)

	Vector3 = var_1_10005
	arg_11_1.localPosition = var_1_10005(var_11_1.x, var_11_1.y, 0)

	local var_11_2 = arg_11_2.transform.localScale

	Vector3 = var_11_0
	arg_11_1.localScale = var_11_0(var_11_2.x, var_11_2.y, var_11_2.z)

	return
end

local function var_0_6(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0
	local var_12_1

	if not arg_12_2.image.isChild or not arg_12_1:Find(arg_12_2.image.source) then
		::label_12_0::

		GameObject = var_5
		var_12_0 = var_5.Find(arg_12_2.image.source)
	end

	if arg_12_2.image.isRelative then
		var_12_1 = arg_12_2.image.target == "" and arg_12_0 or arg_12_0:Find(arg_12_2.image.target)
	else
		GameObject = var_5
		var_12_1 = var_5.Find(arg_12_2.image.target)
	end

	IsNil = var_5

	if not var_5(var_12_0) then
		IsNil = var_5

		if var_5(var_12_1) then
			return
		end

		local var_12_2 = var_12_0
		local var_12_3 = var_12_0.GetComponent

		typeof = var_1_10008
		Image = var_1_10010

		local var_12_4 = var_12_3(var_12_2, var_1_10008(var_1_10010))
		local var_12_5 = var_12_1
		local var_12_6 = var_12_1.GetComponent

		typeof = var_1_10009
		Image = var_1_10011

		local var_12_7 = var_12_6(var_12_5, var_1_10009(var_1_10011))

		if not var_12_4 or not var_12_7 then
			return
		end

		local var_12_8 = var_12_4.sprite
		local var_12_9 = var_12_7.sprite

		if var_12_8 and var_12_9 and var_12_8 ~= var_12_9 then
			var_12_7.enabled = var_12_4.enabled
			setImageSprite = var_9

			var_9(var_12_1, var_12_8)
		end

		return
	end
end

function var_0_0.Syn(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0:RemoveTimer()

	Timer = var_4
	arg_13_0.timer = var_4.New(function()
		var_0_5(arg_13_0, arg_13_1, arg_13_2, arg_13_3)

		if arg_13_3.image then
			var_0_6(arg_13_1, arg_13_2, arg_13_3)
		end

		return
	end, 0.01, -1)

	local var_13_0 = arg_13_0.timer

	var_4.Start(var_13_0)
	arg_13_0.timer.func()

	return
end

function var_0_0.RemoveTimer(arg_15_0)
	if arg_15_0.timer then
		local var_15_0 = arg_15_0.timer

		var_1.Stop(var_15_0)

		arg_15_0.timer = nil
	end

	return
end

function var_0_0.Clear(arg_16_0)
	if arg_16_0.caches and #arg_16_0.caches > 0 then
		ipairs = var_1

		for iter_16_0, iter_16_1 in var_1(arg_16_0.caches) do
			Object = var_1_10006

			var_1_10006.Destroy(iter_16_1.gameObject)
		end

		arg_16_0.caches = {}
	end

	arg_16_0:RemoveTimer()

	return
end

return var_0_0
