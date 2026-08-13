singletonClass = var_0_10000

local var_0_0 = var_0_10000("PoolMgr")

pg = var_0_10001

local var_0_1

var_0_1 = var_0_10001 or {}
pg = pg
var_1.PoolMgr = var_0_0

local var_0_2 = PoolMgr

require = var_1

local var_0_3 = var_1("Mgr/Pool/PoolPlural")

require = var_2

local var_0_4 = var_2("Mgr/Pool/PoolSingleton")

require = var_3

local var_0_5 = var_3("Mgr/Pool/PoolObjPack")

require = var_4

local var_0_6 = var_4("Mgr/Pool/PoolUtil")

ResourceMgr = var_5

local var_0_7 = var_5.Inst

function var_0_2.Ctor(arg_1_0)
	GameObject = var_1_10001
	arg_1_0.root = var_1_10001.New("__Pool__").transform
	arg_1_0.pools_plural = {}
	arg_1_0.pools_pack = {}
	arg_1_0.callbacks = {}
	arg_1_0.pluralIndex = 0
	arg_1_0.singleIndex = 0
	arg_1_0.preloadDic = {
		["ui/share/world_common_atlas"] = 1,
		["shipyardicon/unknown"] = 1,
		["ui/commonui_atlas"] = 1,
		channel = 1,
		skillframe = 1,
		["painting/mat"] = 1,
		["ui/share/msgbox_atlas"] = 1,
		shipframeb = 1,
		["ui/story_atlas"] = 1,
		["ui/guide_atlas"] = 1,
		energy = 1,
		weaponframes = 1,
		attricon = 1,
		skinicon = 1,
		shipstatus = 1,
		custom_builtin = 1,
		shiptype = 1,
		shipframe = 1
	}
	arg_1_0.keepDic = {}

	return
end

function var_0_2.Init(arg_2_0, arg_2_1)
	print = var_1_10002

	var_1_10002("initializing pool manager...")

	local var_2_0 = {}

	pairs = var_1_10003

	for iter_2_0, iter_2_1 in var_1_10003(arg_2_0.preloadDic) do
		table = var_1_10008

		var_1_10008.insert(var_2_0, function(arg_3_0)
			AssetBundleHelper = var_2_10001

			var_2_10001.LoadAssetBundle(iter_2_0, true, true, function(arg_4_0)
				local var_4_0 = arg_2_0

				var_1.AddPoolsPack(var_4_0, iter_2_0, arg_4_0)
				arg_3_0()

				return
			end)

			return
		end)
	end

	arg_2_0:RegisterUIConst()

	seriesAsync = var_3

	var_3(var_2_0, arg_2_1)

	return
end

function var_0_2.GetSpineChar(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = {}
	local var_5_1 = "char/" .. arg_5_1

	HXSet = var_1_10007

	local var_5_2, var_5_3 = var_1_10007.autoHxShiftPath("char/" .. arg_5_1, arg_5_1)
	local var_5_4 = var_5_3 .. "_SkeletonData"

	arg_5_0:FromPlural(var_5_2, "", arg_5_2, 1, function(arg_6_0)
		setActiveViaLayer = var_2_10001

		var_2_10001(arg_6_0, true)
		arg_5_3(arg_6_0)

		return
	end, function(arg_7_0)
		assert = var_2_10001

		var_2_10001(arg_7_0 ~= nil, "Spine角色不存在: " .. arg_5_1)

		SpineAnimUI = var_2_10001
		arg_7_0 = var_2_10001.AnimChar(arg_5_1, arg_7_0)
		tf = var_1

		local var_7_0 = var_1(arg_7_0)

		var_1.SetParent(var_7_0, arg_5_0.root, false)

		var_1.material = arg_7_0:GetComponent("SkeletonGraphic").skeletonDataAsset.atlasAssets[0].materials[0]

		arg_7_0:SetActive(false)

		return arg_7_0
	end)

	return
end

function var_0_2.ReturnSpineChar(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = "char/" .. arg_8_1

	IsNil = var_1_10005

	if var_1_10005(arg_8_2) then
		Debugger = var_5

		local var_8_1 = var_5.LogError

		debug = var_7

		var_8_1(var_7.traceback("empty go: " .. arg_8_1))
	elseif arg_8_0.pools_plural[var_8_0] then
		local var_8_2 = arg_8_2

		if arg_8_2.GetComponent(var_8_2, "SkeletonGraphic").allowMultipleCanvasRenderers then
			UIUtil = var_6

			var_6.ClearChildren(arg_8_2, {
				"Renderer"
			})
		else
			UIUtil = var_6

			var_6.ClearChildren(arg_8_2)
		end

		setActiveViaLayer = var_6

		var_6(arg_8_2.transform, true)
		arg_8_2:SetActive(false)

		local var_8_3 = arg_8_2.transform

		var_6.SetParent(var_8_3, arg_8_0.root, false)

		local var_8_4 = arg_8_2.transform

		Vector3 = var_8_2
		var_8_4.localPosition = var_8_2.New(0, 0, 0)

		local var_8_5 = arg_8_2.transform

		Vector3 = var_7
		var_8_5.localScale = var_7.New(0.5, 0.5, 1)

		local var_8_6 = arg_8_2.transform

		Quaternion = var_7
		var_8_6.localRotation = var_7.identity

		local var_8_7 = arg_8_0.pools_plural[var_8_0]

		var_6.Enqueue(var_8_7, arg_8_2)
		arg_8_0:ExcessSpineChar()
	else
		var_0_6.Destroy(arg_8_2)
	end

	return
end

function var_0_2.ExcessSpineChar(arg_9_0, arg_9_1)
	local var_9_0 = 0
	local var_9_1 = 6
	local var_9_2 = {}

	pairs = var_1_10005

	for iter_9_0, iter_9_1 in var_1_10005(arg_9_0.pools_plural) do
		string = var_1_10010

		if var_1_10010.find(iter_9_0, "char/", nil, true) == 1 and iter_9_1:AllReturned() then
			table = var_1_10010

			var_1_10010.insert(var_9_2, iter_9_0)
		end
	end

	if arg_9_1 then
		ipairs = var_5

		for iter_9_2, iter_9_3 in var_5(var_9_2) do
			local var_9_3 = arg_9_0.pools_plural[iter_9_3]

			var_10.Clear(var_9_3)

			arg_9_0.pools_plural[iter_9_3] = nil
		end
	elseif var_9_1 < #var_9_2 then
		gcAll = var_5

		var_5()
	end

	return
end

function var_0_2.GetSpineSkel(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	HXSet = var_1_10004

	local var_10_0, var_10_1 = var_1_10004.autoHxShiftPath("char/" .. arg_10_1, arg_10_1)
	local var_10_2 = var_10_1 .. "_SkeletonData"
	local var_10_3 = arg_10_0
	local var_10_4 = arg_10_0.LoadAsset
	local var_10_5 = var_10_0
	local var_10_6 = ""

	typeof = var_1_10011
	Object = var_1_10013

	var_10_4(var_10_3, var_10_5, var_10_6, var_1_10011(var_1_10013), arg_10_2, function(arg_11_0)
		arg_10_3(arg_11_0)

		return
	end, true)

	return
end

function var_0_2.IsSpineSkelCached(arg_12_0, arg_12_1)
	local var_12_0 = "char/" .. arg_12_1

	return arg_12_0.pools_plural[var_12_0] ~= nil
end

local var_0_8 = {
	WorldResPanel = 3,
	ResPanel = 3
}
local var_0_9 = {
	"ResPanel",
	"WorldResPanel",
	"NewMainUI",
	"DockyardUI",
	"AwardInfoUI",
	"SkillInfoUI",
	"ItemInfoUI",
	"ShipDetailView",
	"LevelFleetSelectView",
	"Loading",
	"WorldUI"
}

function var_0_2.RegisterUIConst(arg_13_0)
	ipairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(var_0_9) do
		arg_13_0:KeepUICache(iter_13_1, true)
	end

	return
end

function var_0_2.GetUI(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = "ui/" .. arg_14_1
	local var_14_1

	if not var_0_8[arg_14_1] then
		var_14_1 = 1
	end

	arg_14_0:FromPlural(var_14_0, "", arg_14_2, var_14_1, arg_14_3)

	return
end

function var_0_2.ReturnUI(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = "ui/" .. arg_15_1

	IsNil = var_1_10005

	if var_1_10005(arg_15_2) then
		Debugger = var_5

		local var_15_1 = var_5.LogError

		debug = var_7

		var_15_1(var_7.traceback("empty go: " .. arg_15_1))
	elseif arg_15_0.pools_plural[var_15_0] then
		setActiveViaLayer = var_5

		var_5(arg_15_2, false)

		local var_15_2 = arg_15_2.transform

		var_5.SetParent(var_15_2, arg_15_0.root, false)

		local var_15_3 = arg_15_0.pools_plural[var_15_0]

		var_5.Enqueue(var_15_3, arg_15_2, true)

		local var_15_4 = arg_15_0.pools_plural[var_15_0]

		if var_5.AllReturned(var_15_4) and (not arg_15_0.callbacks[var_15_0] or #arg_15_0.callbacks[var_15_0] == 0) then
			local var_15_5 = arg_15_0.pools_plural[var_15_0]

			var_5.Clear(var_15_5)

			arg_15_0.pools_plural[var_15_0] = nil
		end
	else
		var_0_6.Destroy(arg_15_2)
	end

	return
end

function var_0_2.PreloadUI(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = {}
	local var_16_1 = "ui/" .. arg_16_1

	if not arg_16_0.pools_plural[var_16_1] then
		table = var_6

		var_6.insert(var_16_0, function(arg_17_0)
			local var_17_0 = arg_16_0

			var_1.GetUI(var_17_0, arg_16_1, true, function(arg_18_0)
				setActive = var_3_10001

				var_3_10001(arg_18_0, false)

				local var_18_0 = arg_16_0.pools_plural[var_16_1]

				var_1.Enqueue(var_18_0, arg_18_0)
				arg_17_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_16_0, arg_16_2)

	return
end

function var_0_2.KeepUICache(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = "ui/" .. arg_19_1

	arg_19_0.keepDic[var_19_0] = arg_19_2 or nil

	if arg_19_0.pools_plural[var_19_0] then
		local var_19_1 = arg_19_0.pools_plural[var_19_0]
		local var_19_2 = var_4.SetKeep

		tobool = var_1_10007

		var_19_2(var_19_1, var_1_10007(arg_19_0.keepDic[var_19_0]))

		local var_19_3 = arg_19_0.pools_plural[var_19_0]

		if var_4.AllReturned(var_19_3) and (not arg_19_0.callbacks[var_19_0] or #arg_19_0.callbacks[var_19_0] == 0) then
			local var_19_4 = arg_19_0.pools_plural[var_19_0]

			var_4.Clear(var_19_4)

			arg_19_0.pools_plural[var_19_0] = nil
		end
	end

	return
end

function var_0_2.PreloadPainting(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = {}
	local var_20_1 = "painting/" .. arg_20_1

	if not arg_20_0.pools_plural[var_20_1] then
		table = var_6

		var_6.insert(var_20_0, function(arg_21_0)
			local var_21_0 = arg_20_0

			var_1.GetPainting(var_21_0, arg_20_1, true, function(arg_22_0)
				local var_22_0 = arg_20_0.pools_plural[var_20_1]

				var_1.Enqueue(var_22_0, arg_22_0)
				arg_21_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_6

	var_6(var_20_0, arg_20_2)

	return
end

function var_0_2.GetPainting(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = "painting/" .. arg_23_1

	arg_23_0:FromPlural(var_4, "", arg_23_2, 1, function(arg_24_0)
		arg_24_0:SetActive(true)

		ShipExpressionHelper = var_1

		if var_1.DefaultFaceless(arg_23_1) then
			setActive = var_2_10002
			tf = var_4

			local var_24_0 = var_4(arg_24_0)

			var_2_10002(var_4.Find(var_24_0, "face"), true)
		end

		arg_23_3(arg_24_0)

		return
	end)

	return
end

function var_0_2.ReturnPainting(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = "painting/" .. arg_25_1

	IsNil = var_1_10005

	if var_1_10005(arg_25_2) then
		Debugger = var_5

		local var_25_1 = var_5.LogError

		debug = var_7

		var_25_1(var_7.traceback("empty go: " .. arg_25_1))
	elseif arg_25_0.pools_plural[var_25_0] then
		setActiveViaLayer = var_5

		var_5(arg_25_2, true)

		tf = var_5

		local var_25_2 = var_5(arg_25_2)

		if var_5.Find(var_25_2, "face") then
			setActive = var_1_10006

			var_1_10006(var_5, false)
		end

		arg_25_2:SetActive(false)

		local var_25_3 = arg_25_2.transform

		var_6.SetParent(var_25_3, arg_25_0.root, false)

		local var_25_4 = arg_25_0.pools_plural[var_25_0]

		var_6.Enqueue(var_25_4, arg_25_2)
		arg_25_0:ExcessPainting()
	else
		var_0_6.Destroy(arg_25_2)
	end

	return
end

function var_0_2.ExcessPainting(arg_26_0, arg_26_1)
	local var_26_0 = 0
	local var_26_1 = 6
	local var_26_2 = {}

	pairs = var_1_10005

	for iter_26_0, iter_26_1 in var_1_10005(arg_26_0.pools_plural) do
		string = var_1_10010

		if var_1_10010.find(iter_26_0, "painting/", nil, true) == 1 and iter_26_1:AllReturned() then
			table = var_1_10010

			var_1_10010.insert(var_26_2, iter_26_0)
		end
	end

	if arg_26_1 then
		ipairs = var_5

		for iter_26_2, iter_26_3 in var_5(var_26_2) do
			local var_26_3 = arg_26_0.pools_plural[iter_26_3]

			var_10.Clear(var_26_3)

			arg_26_0.pools_plural[iter_26_3] = nil
		end
	elseif var_26_1 < #var_26_2 then
		gcAll = var_5

		var_5(false)
	end

	return
end

function var_0_2.GetPaintingWithPrefix(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	local var_27_0 = arg_27_4 .. arg_27_1

	arg_27_0:FromPlural(var_5, "", arg_27_2, 1, function(arg_28_0)
		arg_28_0:SetActive(true)

		ShipExpressionHelper = var_1

		if var_1.DefaultFaceless(arg_27_1) then
			setActive = var_2_10002
			tf = var_4

			local var_28_0 = var_4(arg_28_0)

			var_2_10002(var_4.Find(var_28_0, "face"), true)
		end

		arg_27_3(arg_28_0)

		return
	end)

	return
end

function var_0_2.ReturnPaintingWithPrefix(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_3 .. arg_29_1

	IsNil = var_1_10006

	if var_1_10006(arg_29_2) then
		Debugger = var_6

		local var_29_1 = var_6.LogError

		debug = var_8

		var_29_1(var_8.traceback("empty go: " .. arg_29_1))
	elseif arg_29_0.pools_plural[var_29_0] then
		setActiveViaLayer = var_6

		var_6(arg_29_2, true)

		tf = var_6

		local var_29_2 = var_6(arg_29_2)

		if var_6.Find(var_29_2, "face") then
			setActive = var_1_10007

			var_1_10007(var_6, false)
		end

		arg_29_2:SetActive(false)

		local var_29_3 = arg_29_2.transform

		var_7.SetParent(var_29_3, arg_29_0.root, false)

		local var_29_4 = arg_29_0.pools_plural[var_29_0]

		var_7.Enqueue(var_29_4, arg_29_2)
		arg_29_0:ExcessPainting()
	else
		var_0_6.Destroy(arg_29_2)
	end

	return
end

function var_0_2.GetSpinePainting(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	local var_30_0

	HXSet = var_1_10005

	local var_30_1, var_30_2 = var_1_10005.autoHxShift("spinePainting/", arg_30_1)

	arg_30_1 = var_30_2

	local var_30_3 = var_30_1 .. arg_30_1

	arg_30_0:FromPlural(var_30_3, "", arg_30_2, 1, function(arg_31_0)
		arg_31_0:SetActive(true)
		arg_30_3(arg_31_0)

		return
	end)

	return
end

function var_0_2.ReturnSpinePainting(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0

	HXSet = var_1_10004

	local var_32_1, var_32_2 = var_1_10004.autoHxShift("spinePainting/", arg_32_1)

	arg_32_1 = var_32_2

	local var_32_3 = var_32_1 .. arg_32_1

	IsNil = var_5

	if var_5(arg_32_2) then
		Debugger = var_5

		local var_32_4 = var_5.LogError

		debug = var_7

		var_32_4(var_7.traceback("empty go: " .. arg_32_1))
	elseif arg_32_0.pools_plural[var_32_3] then
		setActiveViaLayer = var_5

		var_5(arg_32_2, true)
		arg_32_2:SetActive(false)

		local var_32_5 = arg_32_2.transform

		var_5.SetParent(var_32_5, arg_32_0.root, false)

		local var_32_6 = arg_32_0.pools_plural[var_32_3]

		var_5.Enqueue(var_32_6, arg_32_2)
		arg_32_0:ExcessDymPainting()
	else
		var_0_6.Destroy(arg_32_2)
	end

	return
end

function var_0_2.GetLive2D(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0

	HXSet = var_1_10005

	local var_33_1, var_33_2 = var_1_10005.autoHxShift("live2d/", arg_33_1)

	arg_33_1 = var_33_2

	local var_33_3 = var_33_1 .. arg_33_1

	arg_33_0:FromPlural(var_33_3, "", arg_33_2, 1, function(arg_34_0)
		arg_34_0:SetActive(true)
		arg_33_3(arg_34_0)

		return
	end)

	return
end

function var_0_2.ReturnLive2D(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0

	HXSet = var_1_10004

	local var_35_1, var_35_2 = var_1_10004.autoHxShift("live2d/", arg_35_1)

	arg_35_1 = var_35_2

	local var_35_3 = var_35_1 .. arg_35_1

	IsNil = var_5

	if var_5(arg_35_2) then
		Debugger = var_5

		local var_35_4 = var_5.LogError

		debug = var_7

		var_35_4(var_7.traceback("empty go: " .. arg_35_1))
	elseif arg_35_0.pools_plural[var_35_3] then
		setActiveViaLayer = var_5

		var_5(arg_35_2, true)
		arg_35_2:SetActive(false)

		local var_35_5 = arg_35_2.transform

		var_5.SetParent(var_35_5, arg_35_0.root, false)

		local var_35_6 = arg_35_0.pools_plural[var_35_3]

		var_5.Enqueue(var_35_6, arg_35_2, true)
		arg_35_0:ExcessDymPainting()
	else
		var_0_6.Destroy(arg_35_2)
	end

	return
end

local var_0_10 = {
	["spinePainting/"] = true,
	["live2d/"] = true
}

ApartmentProxy = var_0_10009

local var_0_11 = var_0_10009.CheckDeviceRAMEnough() and 6 or 2
local var_0_12 = 0

function var_0_2.ExcessDymPainting(arg_36_0, arg_36_1)
	local var_36_0 = 0
	local var_36_1 = var_0_11
	local var_36_2 = {}

	pairs = var_1_10005

	for iter_36_0, iter_36_1 in var_1_10005(arg_36_0.pools_plural) do
		string = var_1_10010

		if var_1_10010.find(iter_36_0, "/", nil, true) then
			local var_36_3 = var_0_10

			string = var_12

			if var_36_3[var_12.sub(iter_36_0, 1, var_1_10010)] and iter_36_1:AllReturned() then
				table = var_11

				var_11.insert(var_36_2, iter_36_0)
			end
		end
	end

	var_0_12 = var_0_12 + 1

	if arg_36_1 then
		var_0_12 = 0
		ipairs = var_5

		for iter_36_2, iter_36_3 in var_5(var_36_2) do
			local var_36_4 = arg_36_0.pools_plural[iter_36_3]

			var_10.Clear(var_36_4)

			arg_36_0.pools_plural[iter_36_3] = nil
		end
	elseif var_36_1 < #var_36_2 then
		gcAll = var_5

		var_5(false)
	elseif var_0_12 >= 5 then
		gcAll = var_5

		var_5(false)
	end

	return
end

function var_0_2.GetSprite(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.FromObjPack
	local var_37_2 = arg_37_1

	tostring = var_1_10009

	local var_37_3 = var_1_10009(arg_37_2)

	typeof = var_1_10010
	Sprite = var_1_10012

	var_37_1(var_37_0, var_37_2, var_37_3, var_1_10010(var_1_10012), arg_37_3, function(arg_38_0)
		arg_37_4(arg_38_0)

		return
	end)

	return
end

function var_0_2.DecreasSprite(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_1

	if arg_39_0.pools_pack[var_39_0] then
		local var_39_1 = arg_39_0.pools_pack[var_39_0]

		var_4.Remove(var_39_1, arg_39_2)

		local var_39_2 = arg_39_0.pools_pack[var_39_0]

		if var_4.GetAmount(var_39_2) <= 0 then
			arg_39_0:RemovePoolsPack(var_39_0)
		end
	end

	return
end

function var_0_2.DestroySprite(arg_40_0, arg_40_1)
	arg_40_0:RemovePoolsPack(arg_40_1)

	return
end

function var_0_2.DestroyAllSprite(arg_41_0)
	local var_41_0 = arg_41_0
	local var_41_1 = arg_41_0.SpriteMemUsage(var_41_0)
	local var_41_2 = 24

	print = var_41_0

	local var_41_3 = "cached sprite size: "

	math = var_1_10006

	var_41_0(var_41_3 .. var_1_10006.ceil(var_41_1 * 10) / 10 .. "/" .. var_41_2 .. "MB")

	pairs = var_41_0

	for iter_41_0, iter_41_1 in var_41_0(arg_41_0.pools_pack) do
		arg_41_0:RemovePoolsPack(iter_41_0)
	end

	local var_41_4 = var_0_7

	var_3.unloadUnusedAssetBundles(var_41_4)

	return
end

function var_0_2.DisplayPoolPacks(arg_42_0)
	local var_42_0

	pairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0.pools_pack) do
		table = var_1_10007

		var_1_10007.insert(var_42_0, iter_42_0)

		pairs = var_1_10007

		for iter_42_2, iter_42_3 in var_1_10007(iter_42_1.items) do
			table = var_1_10012
			var_1_10012 = var_1_10012.insert

			local var_42_1 = var_42_0

			string = var_1_10015
			var_1_10015 = var_1_10015.format

			local var_42_2 = "assetName:%s type:%s"
			local var_42_3 = iter_42_2

			tostring = var_1_10019

			var_1_10012(var_42_1, var_1_10015(var_42_2, var_42_3, var_1_10019(iter_42_1.type.FullName)))
		end
	end

	warning = var_2
	table = var_4

	var_2(var_4.concat(var_42_0, "\n"))

	return
end

function var_0_2.SpriteMemUsage(arg_43_0)
	local var_43_0 = 0
	local var_43_1 = 9.5367431640625e-07

	typeof = var_1_10003
	Sprite = var_1_10005

	local var_43_2 = var_1_10003(var_1_10005)

	pairs = var_1_10004

	for iter_43_0, iter_43_1 in var_1_10004(arg_43_0.pools_pack) do
		local var_43_3 = {}

		pairs = var_1_10010

		for iter_43_2, iter_43_3 in var_1_10010(iter_43_1.items) do
			if iter_43_1.typeDic[iter_43_2] == var_43_2 and not var_43_3[iter_43_1.items[iter_43_2].texture.name] then
				local var_43_4 = 4
				local var_43_5 = var_15.format

				TextureFormat = var_1_10019

				if var_43_5 == var_1_10019.RGB24 then
					var_43_4 = 3

					goto label_43_0
				end

				TextureFormat = var_1_10019

				if var_43_5 ~= var_1_10019.ARGB4444 then
					TextureFormat = var_1_10019

					if var_43_5 == var_1_10019.RGBA4444 then
						var_43_4 = 2

						goto label_43_0
					end

					TextureFormat = var_1_10019

					if var_43_5 ~= var_1_10019.DXT5 then
						TextureFormat = var_1_10019

						if var_43_5 ~= var_1_10019.ASTC_4x4 then
							TextureFormat = var_1_10019

							if var_43_5 == var_1_10019.ETC2_RGBA8 then
								var_43_4 = 1

								goto label_43_0
							end

							TextureFormat = var_1_10019

							if var_43_5 ~= var_1_10019.PVRTC_RGB4 then
								TextureFormat = var_1_10019

								if var_43_5 ~= var_1_10019.PVRTC_RGBA4 then
									TextureFormat = var_1_10019

									if var_43_5 ~= var_1_10019.ETC_RGB4 then
										TextureFormat = var_1_10019

										if var_43_5 ~= var_1_10019.ETC2_RGB then
											TextureFormat = var_1_10019

											if var_43_5 ~= var_1_10019.ASTC_6x6 then
												TextureFormat = var_1_10019

												if var_43_5 == var_1_10019.DXT1 then
													var_43_4 = 0.5
												end

												::label_43_0::

												var_43_0 = var_43_0 + var_15.width * var_15.height * var_43_4 * var_43_1 / 8
												var_43_3[var_16] = true
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return var_43_0
end

local var_0_13 = 64
local var_0_14 = {
	"chapter/",
	"emoji/",
	"world/"
}

function var_0_2.GetPrefab(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	local var_44_0 = arg_44_1

	arg_44_0:FromPlural(arg_44_1, "", arg_44_3, arg_44_5 or var_0_13, function(arg_45_0)
		string = var_2_10001

		if var_2_10001.find(arg_44_1, "emoji/") == 1 then
			local var_45_0 = arg_45_0
			local var_45_1 = arg_45_0.GetComponent

			typeof = var_4
			CriManaEffectUI = var_2_10006

			if var_45_1(var_45_0, var_4(var_2_10006)) then
				var_1:Pause(false)
			end
		end

		arg_45_0:SetActive(true)

		tf = var_1

		local var_45_2 = var_1(arg_45_0)

		var_1.SetParent(var_45_2, arg_44_0.root, false)
		arg_44_4(arg_45_0)

		return
	end)

	return
end

function var_0_2.ReturnPrefab(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	local var_46_0 = arg_46_1

	IsNil = var_1_10006

	if var_1_10006(arg_46_3) then
		Debugger = var_6

		local var_46_1 = var_6.LogError

		debug = var_8

		var_46_1(var_8.traceback("empty go: " .. arg_46_1))
	elseif arg_46_0.pools_plural[var_46_0] then
		string = var_6

		if var_6.find(arg_46_1, "emoji/") == 1 then
			local var_46_2 = arg_46_3
			local var_46_3 = arg_46_3.GetComponent

			typeof = var_9
			CriManaEffectUI = var_1_10011

			if var_46_3(var_46_2, var_9(var_1_10011)) then
				var_6:Pause(true)
			end
		end

		arg_46_3:SetActive(false)

		local var_46_4 = arg_46_3.transform

		var_6.SetParent(var_46_4, arg_46_0.root, false)

		local var_46_5 = arg_46_0.pools_plural[var_46_0]

		var_6.Enqueue(var_46_5, arg_46_3)

		if arg_46_4 then
			local var_46_6 = arg_46_0.pools_plural[var_46_0]

			if var_6.AllReturned(var_46_6) and (not arg_46_0.callbacks[var_46_0] or #arg_46_0.callbacks[var_46_0] == 0) then
				arg_46_0:DestroyPrefab(arg_46_1, arg_46_2)
			end
		end
	else
		var_0_6.Destroy(arg_46_3)
	end

	return
end

function var_0_2.DestroyPrefab(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_1

	if arg_47_0.pools_plural[var_47_0] then
		local var_47_1 = arg_47_0.pools_plural[var_47_0]

		var_4.Clear(var_47_1)

		arg_47_0.pools_plural[var_47_0] = nil
	end

	return
end

function var_0_2.DestroyAllPrefab(arg_48_0)
	local var_48_0 = {}

	pairs = var_1_10002

	for iter_48_0, iter_48_1 in var_1_10002(arg_48_0.pools_plural) do
		_ = var_1_10007

		if var_1_10007.any(var_0_14, function(arg_49_0)
			string = var_2_10001

			return var_2_10001.find(iter_48_0, arg_49_0) == 1
		end) then
			iter_48_1:Clear()

			table = var_1_10007

			var_1_10007.insert(var_48_0, iter_48_0)
		end
	end

	_ = var_2

	var_2.each(var_48_0, function(arg_50_0)
		arg_48_0.pools_plural[arg_50_0] = nil

		return
	end)

	return
end

function var_0_2.DisplayPluralPools(arg_51_0)
	local var_51_0 = ""

	pairs = var_1_10002

	for iter_51_0, iter_51_1 in var_1_10002(arg_51_0.pools_plural) do
		if #var_51_0 > 0 then
			var_51_0 = var_51_0 .. "\n"
		end

		_ = var_7

		local var_51_1 = var_7.map({
			iter_51_0,
			"balance",
			iter_51_1.balance,
			"currentItmes",
			#iter_51_1.items
		}, function(arg_52_0)
			tostring = var_2_10001

			return var_2_10001(arg_52_0)
		end)
		local var_51_2 = var_51_0
		local var_51_3 = " "

		table = var_10
		var_51_0 = var_51_2 .. var_51_3 .. var_10.concat(var_51_1, " ")
	end

	warning = var_2

	var_2(var_51_0)

	return
end

function var_0_2.GetPluralStatus(arg_53_0, arg_53_1)
	if not arg_53_0.pools_plural[arg_53_1] then
		return "NIL"
	end

	local var_53_0 = arg_53_0.pools_plural[arg_53_1]

	_ = var_1_10003

	local var_53_1 = var_1_10003.map
	local var_53_2 = {
		arg_53_1,
		"balance",
		var_53_0.balance,
		"currentItmes",
		#var_53_0.items
	}

	tostring = var_6

	local var_53_3 = var_53_1(var_53_2, var_6)

	table = var_1_10004

	return var_1_10004.concat(var_53_3, " ")
end

function var_0_2.FromPlural(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4, arg_54_5, arg_54_6)
	local var_54_0 = arg_54_2 == "" and arg_54_1 or arg_54_1 .. "|" .. arg_54_2
	local var_54_1 = {}

	if not arg_54_0.pools_plural[var_54_0] then
		table = var_9

		var_9.insert(var_54_1, function(arg_55_0)
			local var_55_0 = arg_54_0
			local var_55_1 = var_1.LoadAsset
			local var_55_2 = arg_54_1
			local var_55_3 = arg_54_2

			typeof = var_2_10006
			Object = var_2_10008

			var_55_1(var_55_0, var_55_2, var_55_3, var_2_10006(var_2_10008), arg_54_3, function(arg_56_0)
				if arg_56_0 == nil then
					Debugger = var_3_10001

					var_3_10001.LogError("can not find asset: " .. arg_54_1 .. " : " .. arg_54_2)

					return
				end

				if arg_54_6 then
					arg_56_0 = arg_54_6(arg_56_0)
				end

				if not arg_54_0.pools_plural[var_54_0] then
					arg_54_0.pools_plural[var_54_0] = var_0_3.New(arg_56_0, arg_54_4)

					local var_56_0 = arg_54_0.pools_plural[var_54_0]
					local var_56_1 = var_1.SetKeep

					tobool = var_3_10004

					var_56_1(var_56_0, var_3_10004(arg_54_0.keepDic[var_54_0]))
				end

				arg_55_0()

				return
			end, true, true)

			return
		end)
	end

	seriesAsync = var_9

	var_9(var_54_1, function()
		local var_57_0 = arg_54_0.pools_plural[var_54_0]

		var_57_0.index = arg_54_0.pluralIndex
		arg_54_0.pluralIndex = arg_54_0.pluralIndex + 1

		arg_54_5(var_57_0:Dequeue())

		return
	end)

	return
end

function var_0_2.FromObjPack(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4, arg_58_5)
	local var_58_0 = arg_58_1
	local var_58_1 = {}

	if not arg_58_0.pools_pack[var_58_0] then
		table = var_8

		var_8.insert(var_58_1, function(arg_59_0)
			AssetBundleHelper = var_2_10001

			var_2_10001.LoadAssetBundle(arg_58_1, arg_58_4, true, function(arg_60_0)
				local var_60_0 = arg_58_0

				var_1.AddPoolsPack(var_60_0, arg_58_1, arg_60_0)
				arg_59_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_8

	var_8(var_58_1, function()
		local var_61_0 = arg_58_5
		local var_61_1 = arg_58_0.pools_pack[var_58_0]

		var_61_0(var_2.Get(var_61_1, arg_58_2, arg_58_3))

		return
	end)

	return
end

function var_0_2.LoadAsset(arg_62_0, arg_62_1, arg_62_2, arg_62_3, arg_62_4, arg_62_5, arg_62_6, arg_62_7)
	HXSet = var_1_10008

	local var_62_0, var_62_1 = var_1_10008.autoHxShiftPath(arg_62_1, arg_62_2)

	arg_62_2 = var_62_1

	local var_62_2 = var_62_0 .. "|" .. arg_62_2

	if arg_62_0.callbacks[var_62_2] then
		if not arg_62_4 then
			errorMsg = var_9

			var_9("Sync Loading after async operation")
		end

		table = var_9

		var_9.insert(arg_62_0.callbacks[var_62_2], arg_62_5)
	elseif arg_62_4 then
		arg_62_0.callbacks[var_62_2] = {
			arg_62_5
		}

		local var_62_3 = var_0_7
		local var_62_4 = var_9.getAssetAsync
		local var_62_5 = arg_62_1
		local var_62_6 = arg_62_2
		local var_62_7 = arg_62_3

		UnityEngine = var_1_10015

		var_62_4(var_62_3, var_62_5, var_62_6, var_62_7, var_1_10015.Events.UnityAction_UnityEngine_Object(function(arg_63_0)
			if arg_62_0.callbacks[var_62_2] then
				local var_63_0 = arg_62_0.callbacks[var_62_2]
				local var_63_1 = arg_62_0.callbacks

				var_63_1[var_62_2] = nil

				::label_63_0::

				next = var_63_1

				if var_63_1(var_63_0) then
					repeat
						table = var_63_1

						var_63_1.remove(var_63_0)(arg_63_0)

						goto label_63_0
					until true
				end
			end

			return
		end), arg_62_6, arg_62_7 or false)
	else
		local var_62_8 = arg_62_5
		local var_62_9 = var_0_7

		var_62_8(var_11.getAssetSync(var_62_9, arg_62_1, arg_62_2, arg_62_3, arg_62_6, arg_62_7 or false))
	end

	return
end

function var_0_2.AddPoolsPack(arg_64_0, arg_64_1, arg_64_2)
	if arg_64_0.pools_pack[arg_64_1] then
		arg_64_2:Dispose()
	else
		arg_64_0.pools_pack[arg_64_1] = var_0_5.New(arg_64_1, arg_64_2)
	end

	return
end

function var_0_2.RemovePoolsPack(arg_65_0, arg_65_1)
	if not arg_65_0.pools_pack[arg_65_1] or arg_65_0.preloadDic[arg_65_1] then
		return
	end

	local var_65_0 = arg_65_0.pools_pack[arg_65_1]

	var_2.Clear(var_65_0)

	arg_65_0.pools_pack[arg_65_1] = nil

	return
end

function var_0_2.PrintPools(arg_66_0)
	local var_66_0 = ""

	pairs = var_1_10002

	for iter_66_0, iter_66_1 in var_1_10002(arg_66_0.pools_plural) do
		var_66_0 = var_66_0 .. "\n" .. iter_66_0
	end

	warning = var_2

	var_2(var_66_0)

	return
end

function var_0_2.PrintObjPack(arg_67_0)
	local var_67_0 = {}

	pairs = var_1_10002

	for iter_67_0, iter_67_1 in var_1_10002(arg_67_0.pools_pack) do
		table = var_1_10007

		var_1_10007.insert(var_67_0, iter_67_0)

		pairs = var_1_10007

		for iter_67_2, iter_67_3 in var_1_10007(iter_67_1.items) do
			table = var_1_10012

			var_1_10012.insert(var_67_0, "    :" .. iter_67_2)
		end
	end

	warning = var_2
	table = var_4

	var_2(var_4.concat(var_67_0, "\n"))

	return
end

return var_0_2
