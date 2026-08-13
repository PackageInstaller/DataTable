pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.LayerWeightMgr = var_0_10001("LayerWeightMgr")

local var_0_1 = var_0.LayerWeightMgr

var_0_1.DEBUG = false
var_0_1.ADAPT_TAG = "(Adapt)"
var_0_1.RECYCLE_ADAPT_TAG = "recycleAdapt"

function var_0_1.Init(arg_1_0, arg_1_1)
	tf = var_1_10002
	GameObject = var_1_10003
	arg_1_0.baseParent = var_1_10002(var_1_10003.Find("UICamera/Canvas"))

	local var_1_0 = arg_1_0.baseParent

	arg_1_0.uiMain = var_2.Find(var_1_0, "UIMain")
	tf = var_2
	instantiate = var_1_0
	arg_1_0.uiOrigin = var_2(var_1_0(arg_1_0.uiMain, arg_1_0.baseParent, false))

	local var_1_1 = arg_1_0.uiOrigin

	var_1_1.name = "UIOrigin"
	GetOrAddComponent = var_1_1

	local var_1_2 = arg_1_0.uiOrigin

	typeof = var_4
	Canvas = var_5

	local var_1_3 = var_1_1(var_1_2, var_4(var_5))

	var_1_3.overrideSorting = true
	var_1_3.sortingOrder = 200
	GetOrAddComponent = var_3

	local var_1_4 = arg_1_0.uiOrigin

	typeof = var_5
	GraphicRaycaster = var_6

	var_3(var_1_4, var_5(var_6))

	GetOrAddComponent = var_3
	GameObject = var_1_4

	local var_1_5 = var_1_4.Find("LevelCamera")

	typeof = var_5
	Camera = var_6
	arg_1_0.lvCamera = var_3(var_1_5, var_5(var_6))
	tf = var_3

	local var_1_6 = var_3(arg_1_0.lvCamera)

	arg_1_0.lvParent = var_3.Find(var_1_6, "Canvas")
	tf = var_3
	instantiate = var_1_6
	arg_1_0.lvOrigin = var_3(var_1_6(arg_1_0.uiOrigin, arg_1_0.lvParent, false))

	local var_1_7 = arg_1_0.lvOrigin

	var_1_7.name = "LevelOrigin"
	GetOrAddComponent = var_1_7

	local var_1_8 = arg_1_0.lvOrigin

	typeof = var_5
	Canvas = var_6
	var_1_7(var_1_8, var_5(var_6)).sortingOrder = 5000
	arg_1_0.adaptPool = {}
	rtf = var_3
	GameObject = var_4

	local var_1_9 = var_3(var_4.Find("OverlayCamera/Overlay"))

	arg_1_0.OverlayMain = var_3.Find(var_1_9, "UIMain")
	arg_1_0.OverlayAdapt = var_3:Find("UIAdapt")
	arg_1_0.OverlayTop = var_3:Find("UIOverlay")
	setmetatable = var_4
	arg_1_0.groupWeightDic = var_4({}, {
		__index = function(arg_2_0, arg_2_1)
			LayerWeightConst = var_2_10002

			if arg_2_1 == var_2_10002.GROUP_TOP then
				return arg_2_0[arg_1_0.groupStack[#arg_1_0.groupStack]] + 1
			else
				return 0
			end

			return
		end
	})
	arg_1_0.groupStack = {}
	arg_1_0.storeUIs = {}
	existCall = var_4

	var_4(arg_1_1)

	return
end

function var_0_1.RegisterGroupWeight(arg_3_0, arg_3_1)
	if arg_3_0.groupWeightDic[arg_3_1] > 0 then
		return
	end

	local var_3_0 = arg_3_0.groupWeightDic
	local var_3_1 = arg_3_0.groupWeightDic

	LayerWeightConst = var_1_10004
	var_3_0[arg_3_1] = var_3_1[var_1_10004.GROUP_TOP]
	table = var_3_0

	var_3_0.insert(arg_3_0.groupStack, arg_3_1)

	return
end

function var_0_1.RemoveGroupWeight(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.storeUIs) do
		if iter_4_1.groupName == arg_4_1 then
			return
		end
	end

	local var_4_0 = arg_4_0.groupWeightDic

	var_4_0[arg_4_1] = nil
	table = var_4_0

	var_4_0.removebyvalue(arg_4_0.groupStack, arg_4_1)

	return
end

function var_0_1.CreateRefreshHandler(arg_5_0)
	if not arg_5_0.luHandle then
		arg_5_0:Log("CreateRefreshHandler")

		LateUpdateBeat = var_1
		arg_5_0.luHandle = var_1:CreateListener(arg_5_0.Refresh, arg_5_0)
		LateUpdateBeat = var_1

		var_1:AddListener(arg_5_0.luHandle)
	end

	return
end

function var_0_1.ClearRefreshHandler(arg_6_0)
	if arg_6_0.luHandle then
		LateUpdateBeat = var_1

		var_1:RemoveListener(arg_6_0.luHandle)

		arg_6_0.luHandle = nil
	end

	return
end

function var_0_1.Refresh(arg_7_0)
	arg_7_0:LayerSortHandler()
	arg_7_0:ClearRefreshHandler()

	return
end

function var_0_1.Add2Overlay(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2.ui = arg_8_1
	arg_8_2.type = arg_8_2.type

	local var_8_0

	if not arg_8_2.pbList then
		var_8_0 = {}
	end

	arg_8_2.pbList = var_8_0

	local var_8_1

	if not arg_8_2.overlayType then
		LayerWeightConst = var_8_1
		var_8_1 = var_8_1.OVERLAY_UI_MAIN
	end

	arg_8_2.overlayType = var_8_1

	local var_8_2

	if not arg_8_2.groupName then
		LayerWeightConst = var_8_2
		var_8_2 = var_8_2.GROUP_TOP
	end

	arg_8_2.groupName = var_8_2

	local var_8_3

	if not arg_8_2.groupDelta then
		var_8_3 = 0
	end

	arg_8_2.groupDelta = var_8_3

	if not arg_8_2.blurCamList then
		if not arg_8_2.globalBlur then
			local var_8_4 = #arg_8_2.pbList

			if 0 < var_8_4 then
				arg_8_2.blurCamList = {
					var_0.UIMgr.CameraLevel,
					var_0.UIMgr.CameraUI
				}
			else
				arg_8_2.blurCamList = {}
			end

			local var_8_5 = arg_8_2.type

			assert = var_1_10004

			if var_8_5 then
				::label_8_0::

				LayerWeightConst = var_1_10005
				var_1_10005 = var_1_10005.TYPE_DIC[var_8_5]
			end

			var_1_10004(var_1_10005)

			local var_8_6 = arg_8_0
			local var_8_7 = arg_8_0.Log

			string = var_1_10006

			local var_8_8 = var_1_10006.format
			local var_8_9 = "ui:%s 加入了ui层级管理\n%s"
			local var_8_10 = arg_8_1.name

			PrintTable = var_1_10009

			var_8_7(var_8_6, var_8_8(var_8_9, var_8_10, var_1_10009(arg_8_2)))

			local var_8_11 = arg_8_0
			local var_8_12 = arg_8_0.DelList(var_8_11, arg_8_1)

			table = var_8_11

			var_8_11.insert(arg_8_0.storeUIs, arg_8_2)
			arg_8_0:CreateRefreshHandler()

			if arg_8_2.force then
				arg_8_0:Refresh()
			end

			return
		end
	end
end

function var_0_1.DelFromOverlay(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.Log

	string = var_1_10005

	var_9_1(var_9_0, var_1_10005.format("ui:%s 退出了ui层级管理", arg_9_1.name))

	if arg_9_0:DelList(arg_9_1) ~= nil then
		local var_9_2 = var_3.ui

		if not arg_9_0:GetAdaptObjFromUI(var_9_2) then
			local var_9_3 = var_9_2
		end

		arg_9_0:CheckRecycleAdaptObj(var_9_2, arg_9_2)
	end

	arg_9_0:CreateRefreshHandler()

	return
end

function var_0_1.DelList(arg_10_0, arg_10_1)
	local var_10_0

	for iter_10_0 = #arg_10_0.storeUIs, 1, -1 do
		if arg_10_0.storeUIs[iter_10_0].ui == arg_10_1 then
			var_10_0 = arg_10_0.storeUIs[iter_10_0]
			table = var_8

			var_8.remove(arg_10_0.storeUIs, iter_10_0)

			break
		end
	end

	return var_10_0
end

function var_0_1.SortStoreUIs(arg_11_0)
	arg_11_0:Log("-----------------------------------------")

	mergeSort = var_1

	local var_11_0 = arg_11_0.storeUIs

	CompareFuncs = var_3

	var_1(var_11_0, var_3({
		function(arg_12_0)
			return arg_11_0.groupWeightDic[arg_12_0.groupName]
		end,
		function(arg_13_0)
			return arg_13_0.groupDelta
		end
	}, true))

	local var_11_1 = arg_11_0
	local var_11_2 = arg_11_0.Log

	PrintTable = var_3

	var_11_2(var_11_1, var_3(arg_11_0.storeUIs))
	arg_11_0:Log("-----------------------------------------")

	return
end

function var_0_1.LayerSortHandler(arg_14_0)
	arg_14_0:SortStoreUIs()

	arg_14_0.indexDic = {}

	local var_14_0
	local var_14_1
	local var_14_2 = {}
	local var_14_3 = false
	local var_14_4 = false
	local var_14_5 = false
	local var_14_6 = {}

	for iter_14_0 = #arg_14_0.storeUIs, 1, -1 do
		var_1_10013 = arg_14_0.storeUIs[iter_14_0].ui

		local var_14_7 = var_12.parent
		local var_14_8 = var_12.type
		local var_14_9 = var_12.overlayType
		local var_14_10 = var_12.groupName
		local var_14_11 = var_12.globalBlur
		local var_14_12 = var_12.lockGlobalBlur
		local var_14_13 = var_12.staticBlur
		local var_14_14 = var_12.blurCamList
		local var_14_15 = var_12.pbList
		local var_14_16 = var_12.stopTop

		var_14_1 = var_14_1 or var_14_10

		if not var_14_0 then
			if var_14_10 ~= var_14_1 then
				var_14_0 = iter_14_0 + 1

				goto label_14_0
			end

			if not var_14_11 and not var_14_16 then
				LayerWeightConst = var_1_10024

				if var_14_1 == var_1_10024.GROUP_TOP then
					var_14_0 = iter_14_0
				end

				::label_14_0::

				var_1_10024 = not var_14_0 or var_14_0 <= iter_14_0
				var_14_4 = var_14_4 or var_14_12

				if var_1_10024 then
					var_14_3 = var_14_3 or var_14_11
					var_14_5 = var_14_5 or var_14_13
					table = var_1_10025

					var_1_10025.insertto(var_14_6, var_14_14)

					var_1_10025 = #var_14_15

					if 0 < var_1_10025 then
						table = var_1_10025

						var_1_10025.insertto(var_14_2, var_14_15)
					end
				end

				var_1_10025 = var_1_10013
				LayerWeightConst = var_1_10026

				if var_14_9 == var_1_10026.OVERLAY_UI_ADAPT then
					var_1_10025 = arg_14_0:GetAdaptObjFromUI(var_1_10013) or arg_14_0:GetAdaptObj(var_1_10013)
				end

				switch = var_1_10026

				local var_14_17 = var_14_8
				local var_14_18 = {}

				LayerWeightConst = var_1_10029
				var_14_18[var_1_10029.UI_TYPE_SUB] = function()
					if var_1_10024 then
						if var_14_7 then
							local var_15_0 = arg_14_0

							var_0.SetSpecificParent(var_15_0, var_1_10025, var_14_7)
						else
							return arg_14_0.OverlayMain
						end
					else
						local var_15_1

						if not arg_14_0.lvCamera.enabled or not arg_14_0.lvOrigin then
							var_15_1 = arg_14_0.uiOrigin
						end

						return var_15_1
					end

					return
				end
				LayerWeightConst = var_1_10029
				var_14_18[var_1_10029.UI_TYPE_SYSTEM] = function()
					return arg_14_0.uiMain
				end

				if var_1_10026(var_14_17, var_14_18, function()
					assert = var_2_10000

					var_2_10000(false)

					return
				end) then
					arg_14_0:SetSpecificParent(var_1_10025, var_1_10026, 0)
				end
			end
		end
	end

	arg_14_0:SequentizationUIIndex()

	if not var_14_4 then
		local var_14_19 = var_0.UIMgr.GetInstance()

		var_8.SetCameraBlurLock(var_14_19, var_14_4)
	end

	if not var_14_3 and #var_14_2 > 0 then
		local var_14_20 = var_0.UIMgr.GetInstance()

		var_8.PartialBlurTfs(var_14_20, var_14_2)
	else
		local var_14_21 = var_0.UIMgr.GetInstance()

		var_8.ShutdownPartialBlur(var_14_21)
	end

	ipairs = var_8

	for iter_14_1, iter_14_2 in var_8({
		var_0.UIMgr.CameraUI,
		var_0.UIMgr.CameraLevel
	}) do
		if var_14_3 then
			table = var_1_10013

			if var_1_10013.contains(var_14_6, iter_14_2) then
				local var_14_22 = var_0.UIMgr.GetInstance()

				var_1_10013.BlurCamera(var_14_22, iter_14_2, var_14_5)

				goto label_14_1
			end
		end

		do
			local var_14_23 = var_0.UIMgr.GetInstance()

			var_1_10013.UnblurCamera(var_14_23, iter_14_2)
		end

		::label_14_1::
	end

	if var_14_4 then
		local var_14_24 = var_0.UIMgr.GetInstance()

		var_8.SetCameraBlurLock(var_14_24, var_14_4)
	end

	return
end

function var_0_1.SetSpecificParent(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_3 then
		var_1_10004 = arg_18_0.indexDic

		local var_18_0

		if not arg_18_0.indexDic[arg_18_2] then
			var_18_0 = {}
		end

		var_1_10004[arg_18_2] = var_18_0
		table = var_1_10004

		var_1_10004.insert(arg_18_0.indexDic[arg_18_2], 1, arg_18_1)
	else
		SetParent = var_1_10004

		var_1_10004(arg_18_1, arg_18_2, false)
	end

	return
end

function var_0_1.SequentizationUIIndex(arg_19_0)
	pairs = var_1_10001

	for iter_19_0, iter_19_1 in var_1_10001(arg_19_0.indexDic) do
		ipairs = var_1_10006

		for iter_19_2, iter_19_3 in var_1_10006(iter_19_1) do
			SetParent = var_1_10011

			var_1_10011(iter_19_3, iter_19_0, false)

			if iter_19_3:GetSiblingIndex() ~= iter_19_2 - 1 then
				iter_19_3:SetSiblingIndex(iter_19_2 - 1)
			end
		end
	end

	arg_19_0.indexDic = nil

	return
end

function var_0_1.GetAdaptObj(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:GetAdatpObjName(arg_20_1)
	local var_20_1
	local var_20_2

	if #arg_20_0.adaptPool > 0 then
		table = var_20_2
		var_20_1 = var_20_2.remove(arg_20_0.adaptPool, #arg_20_0.adaptPool)
		var_20_1.name = var_20_0
	else
		GameObject = var_20_2
		var_20_2 = var_20_2.New

		local var_20_3 = var_20_0

		typeof = var_1_10006
		RectTransform = var_1_10007

		local var_20_4 = var_1_10006(var_1_10007)

		typeof = var_1_10007
		NotchAdapt = var_1_10008
		var_20_1 = var_20_2(var_20_3, var_20_4, var_1_10007(var_1_10008)).transform
	end

	Vector2 = var_20_2
	var_20_1.anchorMin = var_20_2.zero
	Vector2 = var_4
	var_20_1.anchorMax = var_4.one
	Vector2 = var_4
	var_20_1.pivot = var_4(0.5, 0.5)
	Vector2 = var_4
	var_20_1.offsetMax = var_4.zero
	Vector2 = var_4
	var_20_1.offsetMin = var_4.zero
	Vector3 = var_4
	var_20_1.localPosition = var_4.zero
	SetActive = var_4

	var_4(var_20_1, true)

	SetParent = var_4

	var_4(arg_20_1, var_20_1, false)

	return var_20_1
end

function var_0_1.CheckRecycleAdaptObj(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.GetAdaptObjFromUI(var_21_0, arg_21_1)

	if arg_21_2 ~= nil then
		SetParent = var_21_0

		var_21_0(arg_21_1, arg_21_2, false)
	end

	if var_21_1 ~= nil then
		if #arg_21_0.adaptPool < 4 then
			table = var_4

			var_4.insert(arg_21_0.adaptPool, var_21_1)

			SetParent = var_4

			var_4(var_21_1, arg_21_0.OverlayAdapt, false)

			var_21_1.name = var_0_1.RECYCLE_ADAPT_TAG
			SetActive = var_4

			var_4(var_21_1, false)
		else
			Destroy = var_4

			var_4(var_21_1)
		end
	end

	return
end

function var_0_1.GetAdaptObjFromUI(arg_22_0, arg_22_1)
	if arg_22_1.parent ~= nil and arg_22_1.parent.name == arg_22_0:GetAdatpObjName(arg_22_1) then
		return arg_22_1.parent
	end

	return nil
end

function var_0_1.GetAdatpObjName(arg_23_0, arg_23_1)
	return arg_23_1.name .. var_0_1.ADAPT_TAG
end

function var_0_1.Log(arg_24_0, arg_24_1)
	if not var_0_1.DEBUG then
		return
	end

	originalPrint = var_2

	var_2(arg_24_1)

	return
end

return
