UnityEngine = var_0_10000

local function var_0_0(arg_1_0, arg_1_1)
	if arg_1_0 and arg_1_1 then
		pg = var_1_10002

		local var_1_0 = var_1_10002.ConnectionMgr.GetInstance()

		if var_2.isConnected(var_1_0) then
			pg = var_2

			local var_1_1 = var_2.m02
			local var_1_2 = var_2.sendNotification

			GAME = var_1_10005

			var_1_2(var_1_1, var_1_10005.SEND_CMD, {
				cmd = "log",
				arg1 = arg_1_0,
				arg2 = arg_1_1
			})
		end
	end

	return
end

local var_0_1 = flog

local function var_0_2(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0
	local var_2_1
	local var_2_2
	local var_2_3 = 0

	local function var_2_4()
		if arg_2_2 then
			Time = var_0

			local var_3_0

			if not var_0.unscaledTime then
				var_3_0 = 0
			end

			var_2_3 = var_3_0
			var_2_0 = nil

			local var_3_1 = arg_2_0

			unpackEx = var_2_10002
			var_2_2 = var_3_1(var_2_10002(var_2_1))

			if not var_2_0 then
				var_2_1 = nil
			end

			return
		end
	end

	return function(...)
		Time = var_2_10000

		local var_4_0 = var_2_10000.unscaledTime

		if not var_2_3 and not arg_2_2 then
			var_2_3 = var_4_0
		end

		local var_4_1 = arg_2_1 - (var_4_0 - var_2_3)

		packEx = var_2
		var_2_1 = var_2(...)

		if var_4_1 <= 0 or var_4_1 > arg_2_1 then
			local var_4_2

			if var_2_0 then
				var_4_2 = var_2_0

				var_2.Stop(var_4_2)

				var_2_0 = nil
			end

			var_2_3 = var_4_0

			local var_4_3 = arg_2_0

			unpackEx = var_4_2
			var_2_2 = var_4_3(var_4_2(var_2_1))

			if not var_2_0 then
				var_2_1 = nil
			end
		elseif not var_2_0 and arg_2_2 then
			Timer = var_2
			var_2_0 = var_2.New(var_2_4, var_4_1, 1)

			local var_4_4 = var_2_0

			var_2.Start(var_4_4)
		end

		return var_2_2
	end
end

local var_0_3 = throttle

local function var_0_4(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0
	local var_5_1
	local var_5_2
	local var_5_3
	local var_5_4

	local function var_5_5()
		Time = var_2_10000

		if var_2_10000.unscaledTime - var_5_2 < arg_5_1 and 0 < var_0 then
			Timer = var_1
			var_5_0 = var_1.New(var_5_5, arg_5_1 - var_0, 1)
			var_2_10003 = var_5_0

			var_1.Start(var_2_10003)
		else
			var_5_0 = nil

			if not arg_5_2 then
				local var_6_0 = arg_5_0

				unpackEx = var_2_10003
				var_5_3 = var_6_0(var_2_10003(var_5_1))

				if not var_5_0 then
					var_5_1 = nil
				end
			else
				arg_5_2 = false
			end
		end

		return
	end

	return function(...)
		packEx = var_2_10000
		var_5_1 = var_2_10000(...)
		Time = var_0
		var_5_2 = var_0.unscaledTime

		local var_7_0

		if arg_5_2 then
			var_7_0 = not var_5_0
		end

		if not var_5_0 then
			Timer = var_1
			var_5_0 = var_1.New(var_5_5, arg_5_1, 1)
			var_2_10003 = var_5_0

			var_1.Start(var_2_10003)
		end

		if var_7_0 then
			local var_7_1 = arg_5_0

			unpackEx = var_2_10003
			var_5_3 = var_7_1(var_2_10003(var_5_1))
			var_5_1 = nil
		end

		return var_5_3
	end
end

local var_0_5 = debounce

local function var_0_6(arg_8_0, arg_8_1)
	LOG = var_1_10002

	if var_1_10002 and arg_8_1 then
		return function(...)
			print = var_2_10000

			var_2_10000(arg_8_0 .. ": ", ...)

			return
		end
	else
		print = var_1_10002

		var_1_10002(arg_8_0 .. ": log disabled")

		return function()
			return
		end
	end

	return
end

local var_0_7 = createLog

local function var_0_8(arg_11_0)
	assert = var_1_10001
	pg = var_1_10003

	var_1_10001(var_1_10003.m02, "game is not started")

	pg = var_1_10001

	local var_11_0 = var_1_10001.m02

	return var_1.retrieveProxy(var_11_0, arg_11_0.__cname)
end

local var_0_9 = getProxy

local function var_0_10(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	defaultValue = var_1_10005
	arg_12_4 = var_1_10005(arg_12_4, true)
	defaultValue = var_5
	arg_12_3 = var_5(arg_12_3, true)
	HXSet = var_5

	local var_12_0, var_12_1 = var_5.autoHxShift(arg_12_0 .. "/", arg_12_1)

	arg_12_1 = var_12_1
	arg_12_0 = var_12_0
	ResourceMgr = var_12_0

	local var_12_2 = var_12_0.Inst

	var_5.getAssetAsync(var_12_2, arg_12_0 .. arg_12_1, "", var_0_10000.Events.UnityAction_UnityEngine_Object(function(arg_13_0)
		Instantiate = var_2_10001

		local var_13_0 = var_2_10001(arg_13_0)

		arg_12_2(var_13_0)

		return
	end), arg_12_3, arg_12_4)

	return
end

local var_0_11 = LoadAndInstantiateAsync

local function var_0_12(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	defaultValue = var_1_10004
	arg_14_3 = var_1_10004(arg_14_3, true)
	defaultValue = var_4
	arg_14_2 = var_4(arg_14_2, true)
	HXSet = var_4

	local var_14_0, var_14_1 = var_4.autoHxShift(arg_14_0 .. "/", arg_14_1)

	arg_14_1 = var_14_1
	arg_14_0 = var_14_0
	ResourceMgr = var_14_0

	local var_14_2 = var_14_0.Inst
	local var_14_3 = var_4.getAssetSync(var_14_2, arg_14_0 .. arg_14_1, "", arg_14_2, arg_14_3)

	Instantiate = var_14_1

	return (var_14_1(var_14_3))
end

local var_0_13 = LoadAndInstantiateSync
local var_0_14 = {}

local function var_0_15(arg_15_0, arg_15_1)
	LoadAny = var_1_10002

	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_1

	typeof = var_1_10006
	Sprite = var_1_10008

	return var_1_10002(var_15_0, var_15_1, var_1_10006(var_1_10008))
end

local var_0_16 = LoadSprite

local function var_0_17(arg_16_0, arg_16_1, arg_16_2)
	LoadAnyAsync = var_1_10003

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_1

	typeof = var_1_10007
	Sprite = var_1_10009

	var_1_10003(var_16_0, var_16_1, var_1_10007(var_1_10009), arg_16_2)

	return
end

local var_0_18 = LoadSpriteAtlasAsync

local function var_0_19(arg_17_0, arg_17_1)
	LoadSpriteAtlasAsync = var_1_10002

	var_1_10002(arg_17_0, "", arg_17_1)

	return
end

local var_0_20 = LoadSpriteAsync

local function var_0_21(arg_18_0, arg_18_1, arg_18_2)
	HXSet = var_1_10003

	local var_18_0, var_18_1 = var_1_10003.autoHxShiftPath(arg_18_0, arg_18_1)

	arg_18_1 = var_18_1
	arg_18_0 = var_18_0
	AssetBundleHelper = var_18_0

	return var_18_0.LoadAsset(arg_18_0, arg_18_1, arg_18_2, false, nil, true)
end

local var_0_22 = LoadAny

local function var_0_23(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	HXSet = var_1_10004

	local var_19_0, var_19_1 = var_1_10004.autoHxShiftPath(arg_19_0, arg_19_1)

	arg_19_1 = var_19_1
	arg_19_0 = var_19_0
	AssetBundleHelper = var_19_0

	var_19_0.LoadAsset(arg_19_0, arg_19_1, arg_19_2, true, arg_19_3, true)

	return
end

local var_0_24 = LoadAnyAsync

local function var_0_25(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = arg_20_2
	local var_20_1 = arg_20_2.GetComponent

	typeof = var_1_10007
	Image = var_1_10009

	local var_20_2 = var_20_1(var_20_0, var_1_10007(var_1_10009))

	var_20_2.enabled = false

	local var_20_3 = var_0_14

	var_20_3[var_20_2] = arg_20_0
	LoadSpriteAtlasAsync = var_20_3

	var_20_3(arg_20_0, arg_20_1, function(arg_21_0)
		IsNil = var_2_10001

		if not var_2_10001(var_20_2) and var_0_14[var_20_2] == arg_20_0 then
			var_0_14[var_20_2] = nil
			var_20_2.enabled = true
			var_20_2.sprite = arg_21_0

			if arg_20_3 then
				local var_21_0 = var_20_2

				var_1.SetNativeSize(var_21_0)
			end
		end

		return
	end)

	return
end

local var_0_26 = LoadImageSpriteAtlasAsync

local function var_0_27(arg_22_0, arg_22_1, arg_22_2)
	LoadImageSpriteAtlasAsync = var_1_10003

	var_1_10003(arg_22_0, nil, arg_22_1, arg_22_2)

	return
end

local var_0_28 = LoadImageSpriteAsync

local function var_0_29(arg_23_0, arg_23_1)
	local var_23_0

	HXSet = var_1_10003

	local var_23_1, var_23_2 = var_1_10003.autoHxShiftPath(arg_23_0, arg_23_1)

	arg_23_1 = var_23_2
	arg_23_0 = var_23_1
	PoolMgr = var_23_1

	local var_23_3 = var_23_1.GetInstance()

	var_3.GetSprite(var_23_3, arg_23_0, arg_23_1, false, function(arg_24_0)
		var_23_0 = arg_24_0

		return
	end)

	return var_23_0
end

local var_0_30 = GetSpriteFromAtlas

local function var_0_31(arg_25_0, arg_25_1, arg_25_2)
	HXSet = var_1_10003

	local var_25_0, var_25_1 = var_1_10003.autoHxShiftPath(arg_25_0, arg_25_1)

	arg_25_1 = var_25_1
	arg_25_0 = var_25_0
	PoolMgr = var_25_0

	local var_25_2 = var_25_0.GetInstance()

	var_3.GetSprite(var_25_2, arg_25_0, arg_25_1, true, function(arg_26_0)
		arg_25_2(arg_26_0)

		return
	end)

	return
end

local var_0_32 = GetSpriteFromAtlasAsync

local function var_0_33(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	HXSet = var_1_10004
	arg_27_0, arg_27_1 = var_1_10004.autoHxShiftPath(arg_27_0, arg_27_1)

	local var_27_0 = arg_27_2
	local var_27_1 = arg_27_2.GetComponent

	typeof = var_7
	Image = var_1_10009

	local var_27_2 = var_27_1(var_27_0, var_7(var_1_10009))

	var_27_2.enabled = false

	local var_27_3 = var_0_14

	var_27_3[var_27_2] = arg_27_0 .. arg_27_1
	GetSpriteFromAtlasAsync = var_27_3

	var_27_3(arg_27_0, arg_27_1, function(arg_28_0)
		IsNil = var_2_10001

		if not var_2_10001(var_27_2) and var_0_14[var_27_2] == arg_27_0 .. arg_27_1 then
			var_0_14[var_27_2] = nil
			var_27_2.enabled = true
			var_27_2.sprite = arg_28_0

			if arg_27_3 then
				local var_28_0 = var_27_2

				var_1.SetNativeSize(var_28_0)
			end
		end

		return
	end)

	return
end

local var_0_34 = GetImageSpriteFromAtlasAsync

local function var_0_35(arg_29_0, arg_29_1, arg_29_2)
	pg = var_1_10003

	local var_29_0 = var_1_10003.PoolMgr.GetInstance()

	var_0_14[arg_29_1] = arg_29_0

	var_29_0:GetPrefab(arg_29_0, "", true, function(arg_30_0)
		IsNil = var_2_10001

		if var_2_10001(arg_29_1) or var_0_14[arg_29_1] ~= arg_29_0 then
			local var_30_0 = var_29_0

			var_1.ReturnPrefab(var_30_0, arg_29_0, "", arg_30_0)

			return
		else
			tf = var_1

			local var_30_1 = var_1(arg_29_1)

			if var_1.Find(var_30_1, arg_30_0.name) then
				local var_30_2 = var_29_0

				var_1.ReturnPrefab(var_30_2, arg_29_0, "", arg_30_0)

				tf = var_1

				local var_30_3 = var_1(arg_29_1)

				arg_30_0 = var_1.Find(var_30_3, arg_30_0.name).gameObject
			else
				setParent = var_1

				var_1(arg_30_0, arg_29_1)
			end
		end

		var_0_14[arg_29_1] = nil

		arg_29_2(arg_30_0)

		return
	end)

	return
end

local var_0_36 = GetPrefabFromAtlasAsync

local function var_0_37(arg_31_0, arg_31_1, arg_31_2)
	GetComponent = var_1_10003

	local var_31_0 = var_1_10003(arg_31_0, "SkeletonGraphic").AnimationState
	local var_31_1 = var_3.SetAnimation
	local var_31_2 = 0
	local var_31_3 = arg_31_1

	defaultValue = var_1_10009

	var_31_1(var_31_0, var_31_2, var_31_3, var_1_10009(arg_31_2, true))

	local var_31_4 = var_3
	local var_31_5 = var_3.Update

	Time = var_31_2

	var_31_5(var_31_4, var_31_2.deltaTime)

	return
end

local var_0_38 = SetAction

local function var_0_39(arg_32_0, arg_32_1)
	GetOrAddComponent = var_1_10002

	local var_32_0 = arg_32_0

	typeof = var_1_10005
	SpineAnimUI = var_1_10007

	local var_32_1 = var_1_10002(var_32_0, var_1_10005(var_1_10007))

	var_2.SetActionCallBack(var_32_1, arg_32_1)

	return
end

local var_0_40 = SetActionCallback

local function var_0_41(arg_33_0, arg_33_1)
	GetComponent = var_1_10002

	local var_33_0 = var_1_10002(arg_33_0, "TextMesh")

	GetComponent = var_1_10003

	local var_33_1 = var_1_10003(arg_33_0, "MeshRenderer")

	Shader = var_4

	local var_33_2 = var_4.Find("UI/Unlit/Transparent")
	local var_33_3 = var_33_1.materials
	local var_33_4 = {
		var_33_3[0]
	}
	local var_33_5 = {}
	local var_33_6 = 0
	local var_33_7 = {}

	string = var_1_10010

	local var_33_8 = var_1_10010.gsub(arg_33_1, "#(%d+)#", function(arg_34_0)
		if not var_33_5[arg_34_0] then
			var_33_6 = var_33_6 + 1

			local var_34_0 = var_33_7
			local var_34_1 = "emoji" .. arg_34_0

			Material = var_4
			var_34_0[var_34_1] = var_4.New(var_33_2)
			table = var_34_0

			local var_34_2 = var_34_0.insert
			local var_34_3 = var_33_4

			mat = var_2_10005

			var_34_2(var_34_3, var_2_10005)

			var_33_5[arg_34_0] = var_33_6

			local var_34_4 = var_33_6
		end

		return "<quad material=" .. var_33_6 .. " />"
	end)

	AssetBundleHelper = var_1_10011

	local var_33_9 = var_1_10011.LoadManyAssets
	local var_33_10 = "emojis"

	underscore = var_14

	local var_33_11 = var_33_9(var_33_10, var_14.keys(var_33_7), nil, false, nil, true)

	pairs = var_12

	for iter_33_0, iter_33_1 in var_12(var_33_7) do
		iter_33_1.mainTexture = var_33_11[iter_33_0]
	end

	var_33_0.text = var_33_8
	var_33_1.materials = var_33_4

	return
end

local var_0_42 = emojiText

local function var_0_43(arg_35_0, arg_35_1)
	LoadSprite = var_1_10002

	local var_35_0

	if not var_1_10002("painting/" .. arg_35_1) then
		LoadSprite = var_35_0
		var_35_0 = var_35_0("painting/unknown")
	end

	setImageSprite = var_1_10003

	var_1_10003(arg_35_0, var_35_0)

	resetAspectRatio = var_1_10003

	var_1_10003(arg_35_0)

	return
end

local var_0_44 = setPaintingImg

local function var_0_45(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	findTF = var_1_10006

	local var_36_0 = var_1_10006(arg_36_0, "fitter")

	assert = var_1_10007

	var_1_10007(var_36_0, "请添加子物体fitter")

	removeAllChildren = var_1_10007

	var_1_10007(var_36_0)

	GetOrAddComponent = var_1_10007

	local var_36_1 = var_1_10007(var_36_0, "PaintingScaler")

	var_36_1.FrameName = arg_36_2 or ""
	var_36_1.Tween = 1

	local var_36_2 = arg_36_1

	if not arg_36_3 then
		checkABExist = var_9

		if var_9("painting/" .. arg_36_1 .. "_n") then
			PlayerPrefs = var_9

			if var_9.GetInt("paint_hide_other_obj_" .. arg_36_1, 0) ~= 0 then
				arg_36_1 = arg_36_1 .. "_n"
			end
		end
	end

	PoolMgr = var_9

	local var_36_3 = var_9.GetInstance()

	var_9.GetPainting(var_36_3, arg_36_1, false, function(arg_37_0)
		setParent = var_2_10001

		var_2_10001(arg_37_0, var_36_0, false)

		findTF = var_2_10001

		local var_37_0 = var_2_10001(arg_37_0, "Touch")

		IsNil = var_2_10002

		if not var_2_10002(var_37_0) then
			setActive = var_2

			var_2(var_37_0, false)
		end

		findTF = var_2

		local var_37_1 = var_2(arg_37_0, "hx")

		IsNil = var_3

		if not var_3(var_37_1) then
			setActive = var_3

			local var_37_2 = var_37_1

			HXSet = var_2_10006

			var_3(var_37_2, var_2_10006.isHx())
		end

		ShipExpressionHelper = var_3

		local var_37_3 = var_3.SetExpression
		local var_37_4 = var_36_0

		var_37_3(var_5.GetChild(var_37_4, 0), var_36_2)

		existCall = var_37_3

		var_37_3(arg_36_5)

		return
	end)

	PaintingShiftTransform = var_9

	var_9(var_36_0, arg_36_2, arg_36_4)

	return
end

local var_0_46 = setPaintingPrefab
local var_0_47 = {}

local function var_0_48(arg_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)
	local var_38_0 = arg_38_1

	checkABExist = var_1_10006

	if var_1_10006("painting/" .. arg_38_1 .. "_n") then
		PlayerPrefs = var_6

		if var_6.GetInt("paint_hide_other_obj_" .. arg_38_1, 0) ~= 0 then
			arg_38_1 = arg_38_1 .. "_n"
		end
	end

	LoadPaintingPrefabAsync = var_6

	var_6(arg_38_0, var_38_0, arg_38_1, arg_38_2, arg_38_3, arg_38_4)

	return
end

local var_0_49 = setPaintingPrefabAsync

local function var_0_50(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
	findTF = var_1_10006

	local var_39_0 = var_1_10006(arg_39_0, "fitter")

	assert = var_1_10007

	var_1_10007(var_39_0, "请添加子物体fitter")

	removeAllChildren = var_1_10007

	var_1_10007(var_39_0)

	GetOrAddComponent = var_1_10007

	local var_39_1 = var_1_10007(var_39_0, "PaintingScaler")

	var_39_1.FrameName = arg_39_3 or ""
	var_39_1.Tween = 1

	local var_39_2 = var_0_47

	var_39_2[arg_39_0] = arg_39_2
	PoolMgr = var_39_2

	local var_39_3 = var_39_2.GetInstance()

	var_8.GetPainting(var_39_3, arg_39_2, true, function(arg_40_0)
		IsNil = var_2_10001

		local var_40_1

		if var_2_10001(arg_39_0) or var_0_47[arg_39_0] ~= arg_39_2 then
			PoolMgr = var_40_1

			local var_40_0 = var_40_1.GetInstance()

			var_40_1.ReturnPainting(var_40_0, arg_39_2, arg_40_0)

			return
		else
			setParent = var_40_1

			var_40_1(arg_40_0, var_39_0, false)

			var_40_1 = var_0_47
			var_40_1[arg_39_0] = nil
			ShipExpressionHelper = var_40_1

			var_40_1.SetExpression(arg_40_0, arg_39_1)
		end

		findTF = var_40_1

		local var_40_2 = var_40_1(arg_40_0, "Touch")

		IsNil = var_2_10002

		if not var_2_10002(var_40_2) then
			setActive = var_2

			var_2(var_40_2, false)
		end

		findTF = var_2

		local var_40_3 = var_2(arg_40_0, "Drag")

		IsNil = var_3

		if not var_3(var_40_3) then
			setActive = var_3

			var_3(var_40_3, false)
		end

		findTF = var_3

		local var_40_4 = var_3(arg_40_0, "hx")

		IsNil = var_4

		if not var_4(var_40_4) then
			setActive = var_4

			local var_40_5 = var_40_4

			HXSet = var_2_10007

			var_4(var_40_5, var_2_10007.isHx())
		end

		if arg_39_4 then
			arg_39_4(arg_40_0)
		end

		return
	end)

	PaintingShiftTransform = var_8

	var_8(var_39_0, arg_39_3, arg_39_5)

	return
end

local var_0_51 = LoadPaintingPrefabAsync
local var_0_52 = {
	pifu = "skin_card_shift",
	biandui = "formation_shift"
}

local function var_0_53(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_0.parent
	local var_41_1 = var_3.GetComponent

	typeof = var_1_10006
	RectTransform = var_1_10008

	local var_41_2 = var_41_1(var_41_0, var_1_10006(var_1_10008))

	if var_0_52[arg_41_1] ~= nil and arg_41_2 ~= nil then
		pg = var_41_0

		if var_41_0.ship_skin_newmainui_shift[arg_41_2.skinID] then
			local var_41_3 = var_41_0[var_4]

			Vector3 = var_1_10007

			local var_41_4 = 0
			local var_41_5 = 0
			local var_41_6

			if not var_41_3[5] or not var_41_3[5] then
				var_41_6 = 0
			end

			var_41_2.localEulerAngles = var_1_10007(var_41_4, var_41_5, var_41_6)

			return
		end
	end

	Vector3 = var_41_0
	var_41_2.localEulerAngles = var_41_0(0, 0, 0)

	return
end

local var_0_54 = PaintingShiftTransform

local function var_0_55(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_0 and arg_42_1 then
		findTF = var_1_10003

		if var_1_10003(arg_42_0, "fitter") then
			local var_42_0 = var_3.childCount

			if 0 < var_42_0 then
				local var_42_1 = var_3
				local var_42_2 = var_3.GetChild(var_42_1, 0)

				IsNil = var_5

				if not var_5(var_42_2) then
					findTF = var_5

					local var_42_3 = var_5(var_42_2, "Touch")

					IsNil = var_42_1

					if not var_42_1(var_42_3) then
						eachChild = var_42_5

						var_42_5(var_42_3, function(arg_43_0)
							local var_43_0 = arg_43_0
							local var_43_1 = arg_43_0.GetComponent

							typeof = var_2_10004
							Button = var_2_10006

							local var_43_2 = var_43_1(var_43_0, var_2_10004(var_2_10006))

							IsNil = var_2_10002

							if not var_2_10002(var_43_2) then
								removeOnButton = var_2

								var_2(arg_43_0)
							end

							return
						end)
					end

					local var_42_5

					if not arg_42_2 then
						PoolMgr = var_42_5

						local var_42_4 = var_42_5.GetInstance()

						var_42_5 = var_42_5.ReturnPainting
						string = var_1_10009

						var_42_5(var_42_4, var_1_10009.gsub(var_42_2.name, "%(Clone%)", ""), var_42_2.gameObject)
					else
						PoolMgr = var_42_5

						local var_42_6 = var_42_5.GetInstance()
						local var_42_7 = var_6.ReturnPaintingWithPrefix

						string = var_1_10009

						var_42_7(var_42_6, var_1_10009.gsub(var_42_2.name, "%(Clone%)", ""), var_42_2.gameObject, arg_42_2)
					end
				end
			end
		end

		var_0_47[arg_42_0] = nil
	end

	return
end

local var_0_56 = retPaintingPrefab

local function var_0_57(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	findTF = var_1_10005

	local var_44_0 = var_1_10005(arg_44_0, "fitter")

	assert = var_1_10006

	var_1_10006(var_44_0, "请添加子物体fitter")

	removeAllChildren = var_1_10006

	var_1_10006(var_44_0)

	GetOrAddComponent = var_1_10006

	local var_44_1 = var_1_10006(var_44_0, "PaintingScaler")

	var_44_1.FrameName = arg_44_2 or ""
	var_44_1.Tween = 1

	local var_44_2 = arg_44_4 or "painting/"
	local var_44_3 = arg_44_1

	if not arg_44_3 then
		checkABExist = var_9

		if var_9(var_44_2 .. arg_44_1 .. "_n") then
			PlayerPrefs = var_9

			if var_9.GetInt("paint_hide_other_obj_" .. arg_44_1, 0) ~= 0 then
				arg_44_1 = arg_44_1 .. "_n"
			end
		end
	end

	return var_44_0, arg_44_1, var_44_3
end

local var_0_58 = checkPaintingPrefab

local function var_0_59(arg_45_0)
	local var_45_0 = arg_45_0.paintingTF
	local var_45_1 = arg_45_0.fitterTF
	local var_45_2 = arg_45_0.defaultPaintingName

	setParent = var_1_10004

	var_1_10004(var_45_0, var_45_1, false)

	findTF = var_1_10004

	local var_45_3 = var_1_10004(var_45_0, "Touch")

	IsNil = var_1_10005

	if not var_1_10005(var_45_3) then
		setActive = var_5

		var_5(var_45_3, false)
	end

	findTF = var_5

	local var_45_4 = var_5(var_45_0, "hx")

	IsNil = var_6

	if not var_6(var_45_4) then
		setActive = var_6

		local var_45_5 = var_45_4

		HXSet = var_1_10009

		var_6(var_45_5, var_1_10009.isHx())
	end

	ShipExpressionHelper = var_6

	var_6.SetExpression(var_45_1:GetChild(0), var_45_2)

	return
end

local var_0_60 = onLoadedPaintingPrefab

local function var_0_61(arg_46_0)
	local var_46_0 = arg_46_0.paintingTF
	local var_46_1 = arg_46_0.fitterTF
	local var_46_2 = arg_46_0.objectOrTransform
	local var_46_3 = arg_46_0.paintingName
	local var_46_4 = arg_46_0.defaultPaintingName
	local var_46_5 = arg_46_0.callback

	IsNil = var_1_10007

	local var_46_7

	if var_1_10007(var_46_2) or var_0_47[var_46_2] ~= var_46_3 then
		PoolMgr = var_46_7

		local var_46_6 = var_46_7.GetInstance()

		var_46_7.ReturnPainting(var_46_6, var_46_3, var_46_0)

		return
	else
		setParent = var_46_7

		var_46_7(var_46_0, var_46_1, false)

		var_46_7 = var_0_47
		var_46_7[var_46_2] = nil
		ShipExpressionHelper = var_46_7

		var_46_7.SetExpression(var_46_0, var_46_4)
	end

	findTF = var_46_7

	local var_46_8 = var_46_7(var_46_0, "Touch")

	IsNil = var_1_10008

	if not var_1_10008(var_46_8) then
		setActive = var_8

		var_8(var_46_8, false)
	end

	findTF = var_8

	local var_46_9 = var_8(var_46_0, "hx")

	IsNil = var_9

	if not var_9(var_46_9) then
		setActive = var_9

		local var_46_10 = var_46_9

		HXSet = var_1_10012

		var_9(var_46_10, var_1_10012.isHx())
	end

	if var_46_5 then
		var_46_5()
	end

	return
end

local var_0_62 = onLoadedPaintingPrefabAsync

local function var_0_63(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	checkPaintingPrefab = var_1_10004

	local var_47_0, var_47_1, var_47_2 = var_1_10004(arg_47_0, arg_47_1, arg_47_2, arg_47_3)

	PoolMgr = var_7

	local var_47_3 = var_7.GetInstance()

	var_7.GetPaintingWithPrefix(var_47_3, var_47_1, false, function(arg_48_0)
		local var_48_0 = {
			paintingTF = arg_48_0,
			fitterTF = var_47_0,
			defaultPaintingName = var_47_2
		}

		onLoadedPaintingPrefab = var_2

		var_2(var_48_0)

		return
	end, "commanderpainting/")

	return
end

local var_0_64 = setCommanderPaintingPrefab

local function var_0_65(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	checkPaintingPrefab = var_1_10005

	local var_49_0, var_49_1, var_49_2 = var_1_10005(arg_49_0, arg_49_1, arg_49_2, arg_49_4)
	local var_49_3 = var_0_47

	var_49_3[arg_49_0] = var_49_1
	PoolMgr = var_49_3

	local var_49_4 = var_49_3.GetInstance()

	var_8.GetPaintingWithPrefix(var_49_4, var_49_1, true, function(arg_50_0)
		local var_50_0 = {
			paintingTF = arg_50_0,
			fitterTF = var_49_0,
			objectOrTransform = arg_49_0,
			paintingName = var_49_1,
			defaultPaintingName = var_49_2,
			callback = arg_49_3
		}

		onLoadedPaintingPrefabAsync = var_2

		var_2(var_50_0)

		return
	end, "commanderpainting/")

	return
end

local var_0_66 = setCommanderPaintingPrefabAsync

local function var_0_67(arg_51_0, arg_51_1)
	retPaintingPrefab = var_1_10002

	var_1_10002(arg_51_0, arg_51_1, "commanderpainting/")

	return
end

local var_0_68 = retCommanderPaintingPrefab

local function var_0_69(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	checkPaintingPrefab = var_1_10004

	local var_52_0, var_52_1, var_52_2 = var_1_10004(arg_52_0, arg_52_1, arg_52_2, arg_52_3)

	PoolMgr = var_7

	local var_52_3 = var_7.GetInstance()

	var_7.GetPaintingWithPrefix(var_52_3, var_52_1, false, function(arg_53_0)
		local var_53_0 = {
			paintingTF = arg_53_0,
			fitterTF = var_52_0,
			defaultPaintingName = var_52_2
		}

		onLoadedPaintingPrefab = var_2

		var_2(var_53_0)

		return
	end, "metapainting/")

	return
end

local var_0_70 = setMetaPaintingPrefab

local function var_0_71(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	checkPaintingPrefab = var_1_10005

	local var_54_0, var_54_1, var_54_2 = var_1_10005(arg_54_0, arg_54_1, arg_54_2, arg_54_4)
	local var_54_3 = var_0_47

	var_54_3[arg_54_0] = var_54_1
	PoolMgr = var_54_3

	local var_54_4 = var_54_3.GetInstance()

	var_8.GetPaintingWithPrefix(var_54_4, var_54_1, true, function(arg_55_0)
		local var_55_0 = {
			paintingTF = arg_55_0,
			fitterTF = var_54_0,
			objectOrTransform = arg_54_0,
			paintingName = var_54_1,
			defaultPaintingName = var_54_2,
			callback = arg_54_3
		}

		onLoadedPaintingPrefabAsync = var_2

		var_2(var_55_0)

		return
	end, "metapainting/")

	return
end

local var_0_72 = setMetaPaintingPrefabAsync

local function var_0_73(arg_56_0, arg_56_1)
	retPaintingPrefab = var_1_10002

	var_1_10002(arg_56_0, arg_56_1, "metapainting/")

	return
end

local var_0_74 = retMetaPaintingPrefab

local function var_0_75(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	checkPaintingPrefab = var_1_10004

	local var_57_0, var_57_1, var_57_2 = var_1_10004(arg_57_0, arg_57_1, arg_57_2, arg_57_3)

	PoolMgr = var_7

	local var_57_3 = var_7.GetInstance()

	var_7.GetPaintingWithPrefix(var_57_3, var_57_1, false, function(arg_58_0)
		local var_58_0 = {
			paintingTF = arg_58_0,
			fitterTF = var_57_0,
			defaultPaintingName = var_57_2
		}

		onLoadedPaintingPrefab = var_2

		var_2(var_58_0)

		return
	end, "guildpainting/")

	return
end

local var_0_76 = setGuildPaintingPrefab

local function var_0_77(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	checkPaintingPrefab = var_1_10005

	local var_59_0, var_59_1, var_59_2 = var_1_10005(arg_59_0, arg_59_1, arg_59_2, arg_59_4)
	local var_59_3 = var_0_47

	var_59_3[arg_59_0] = var_59_1
	PoolMgr = var_59_3

	local var_59_4 = var_59_3.GetInstance()

	var_8.GetPaintingWithPrefix(var_59_4, var_59_1, true, function(arg_60_0)
		local var_60_0 = {
			paintingTF = arg_60_0,
			fitterTF = var_59_0,
			objectOrTransform = arg_59_0,
			paintingName = var_59_1,
			defaultPaintingName = var_59_2,
			callback = arg_59_3
		}

		onLoadedPaintingPrefabAsync = var_2

		var_2(var_60_0)

		return
	end, "guildpainting/")

	return
end

local var_0_78 = setGuildPaintingPrefabAsync

local function var_0_79(arg_61_0, arg_61_1)
	retPaintingPrefab = var_1_10002

	var_1_10002(arg_61_0, arg_61_1, "guildpainting/")

	return
end

local var_0_80 = retGuildPaintingPrefab

local function var_0_81(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	checkPaintingPrefab = var_1_10004

	local var_62_0, var_62_1, var_62_2 = var_1_10004(arg_62_0, arg_62_1, arg_62_2, arg_62_3)

	PoolMgr = var_7

	local var_62_3 = var_7.GetInstance()

	var_7.GetPaintingWithPrefix(var_62_3, var_62_1, false, function(arg_63_0)
		local var_63_0 = {
			paintingTF = arg_63_0,
			fitterTF = var_62_0,
			defaultPaintingName = var_62_2
		}

		pg = var_2

		local var_63_1 = var_2.SdkMgr.GetInstance()
		local var_63_2 = var_2.GetChannelUIDIncludeHarmony(var_63_1)

		findTF = var_2_10003

		local var_63_3 = var_2_10003(arg_63_0, "exchange_hx_ch" .. var_63_2)

		IsNil = var_63_1

		if not var_63_1(var_63_3) then
			setActive = var_4

			local var_63_4 = var_63_3

			HXSet = var_7

			var_4(var_63_4, var_7.isHx())
		end

		onLoadedPaintingPrefab = var_4

		var_4(var_63_0)

		return
	end, "shoppainting/")

	return
end

local var_0_82 = setShopPaintingPrefab

local function var_0_83(arg_64_0, arg_64_1)
	retPaintingPrefab = var_1_10002

	var_1_10002(arg_64_0, arg_64_1, "shoppainting/")

	return
end

local var_0_84 = retShopPaintingPrefab

local function var_0_85(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	checkPaintingPrefab = var_1_10005

	local var_65_0, var_65_1, var_65_2 = var_1_10005(arg_65_0, arg_65_1, arg_65_2, arg_65_4)
	local var_65_3 = var_0_47

	var_65_3[arg_65_0] = var_65_1
	PoolMgr = var_65_3

	local var_65_4 = var_65_3.GetInstance()

	var_8.GetPaintingWithPrefix(var_65_4, var_65_1, true, function(arg_66_0)
		local var_66_0 = {
			paintingTF = arg_66_0,
			fitterTF = var_65_0,
			objectOrTransform = arg_65_0,
			paintingName = var_65_1,
			defaultPaintingName = var_65_2,
			callback = arg_65_3
		}

		onLoadedPaintingPrefabAsync = var_2

		var_2(var_66_0)

		return
	end, "buildpainting/")

	return
end

local var_0_86 = setBuildPaintingPrefabAsync

local function var_0_87(arg_67_0, arg_67_1)
	retPaintingPrefab = var_1_10002

	var_1_10002(arg_67_0, arg_67_1, "buildpainting/")

	return
end

local var_0_88 = retBuildPaintingPrefab

local function var_0_89(arg_68_0, arg_68_1, arg_68_2)
	setText = var_1_10003

	local var_68_0 = arg_68_0

	string = var_1_10006

	local var_68_1 = var_1_10006.format

	if arg_68_1 < arg_68_2 then
		local var_68_2 = "<color="

		COLOR_RED = var_1_10009

		local var_68_3

		if not (var_68_2 .. var_1_10009 .. ">%d</color>/%d") then
			var_68_3 = "%d/%d"
		end

		var_1_10003(var_68_0, var_68_1(var_68_3, arg_68_1, arg_68_2))

		return
	end
end

local var_0_90 = setColorCount

local function var_0_91(arg_69_0, arg_69_1, arg_69_2, arg_69_3, arg_69_4)
	_customColorCount = var_1_10005
	arg_69_0.text = var_1_10005(arg_69_1, arg_69_2, arg_69_3, arg_69_4)

	return
end

local var_0_92 = customColorCount

local function var_0_93(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	local var_70_0 = arg_70_0 < arg_70_1 and arg_70_3 or arg_70_2

	string = var_1_10005

	local var_70_1 = var_1_10005.format
	local var_70_2

	if not ("<color=" .. var_70_0 .. ">%d</color>/%d") then
		var_70_2 = "%d/%d"
	end

	return var_70_1(var_70_2, arg_70_0, arg_70_1)
end

local var_0_94 = _customColorCount

local function var_0_95(arg_71_0, arg_71_1)
	return "<color=" .. arg_71_1 .. ">" .. arg_71_0 .. "</color>"
end

local var_0_96 = setColorStr

local function var_0_97(arg_72_0, arg_72_1)
	string = var_1_10002

	local var_72_0, var_72_1 = var_1_10002.gsub(arg_72_0, "[<]size=%d+[>]", "<size=" .. arg_72_1 .. ">")

	if var_72_1 == 0 then
		var_72_0 = "<size=" .. arg_72_1 .. ">" .. var_72_0 .. "</size>"
	end

	return var_72_0
end

local var_0_98 = setSizeStr

local function var_0_99(arg_73_0, arg_73_1)
	pg = var_1_10002

	local var_73_0 = var_1_10002.voice_bgm[arg_73_0]

	pg = var_1_10003

	local var_73_1 = var_1_10003.CriMgr.GetInstance()

	if var_3.IsDefaultBGM(var_73_1) then
		local var_73_2

		if not var_73_0 or not var_73_0.default_bgm then
			var_73_2 = nil
		end

		return var_73_2
	elseif var_73_0 then
		if var_73_0.special_bgm then
			type = var_3

			if var_3(var_73_0.special_bgm) == "table" then
				local var_73_3 = #var_73_0.special_bgm

				if 0 < var_73_3 then
					_ = var_73_3

					if var_73_3.all(var_73_0.special_bgm, function(arg_74_0)
						type = var_2_10001

						if var_2_10001(arg_74_0) == "table" and #arg_74_0 > 2 then
							type = var_1

							local var_74_0

							if var_1(arg_74_0[2]) ~= "number" then
								var_74_0 = false
							else
								var_74_0 = true
							end

							return var_74_0
						end
					end) then
						Clone = var_3

						local var_73_4 = var_3(var_73_0.special_bgm)

						table = var_4

						var_4.sort(var_73_4, function(arg_75_0, arg_75_1)
							return arg_75_0[2] > arg_75_1[2]
						end)

						local var_73_5 = ""

						_ = var_5

						var_5.each(var_73_4, function(arg_76_0)
							if var_73_5 ~= "" then
								return
							end

							local var_76_0 = arg_76_0[1]
							local var_76_1 = arg_76_0[3]

							switch = var_2_10003

							var_2_10003(var_76_0, {
								function()
									local var_77_0 = var_76_1[1]
									local var_77_1 = var_76_1[2]

									if #var_77_0 == 1 then
										if var_77_0[1] ~= "always" then
											return
										end
									else
										pg = var_2

										local var_77_2 = var_2.TimeMgr.GetInstance()

										if not var_2.inTime(var_77_2, var_77_0) then
											return
										end
									end

									_ = var_2

									var_2.each(var_77_1, function(arg_78_0)
										if var_73_5 ~= "" then
											return
										end

										if #arg_78_0 == 2 then
											pg = var_1

											local var_78_0 = var_1.TimeMgr.GetInstance()

											if var_1.inPeriod(var_78_0, arg_78_0[1]) then
												var_73_5 = arg_78_0[2]

												goto label_78_0
											end
										end

										if #arg_78_0 == 3 then
											pg = var_1

											local var_78_1 = var_1.TimeMgr.GetInstance()

											if var_1.inPeriod(var_78_1, arg_78_0[1], arg_78_0[2]) then
												var_73_5 = arg_78_0[3]
											end
										end

										::label_78_0::

										return
									end)

									return
								end,
								function()
									local var_79_0 = false
									local var_79_1 = ""

									_ = var_3_10002

									var_3_10002.each(var_76_1, function(arg_80_0)
										if #arg_80_0 ~= 2 or var_79_0 then
											return
										end

										pg = var_1

										local var_80_0 = var_1.NewStoryMgr.GetInstance()

										if var_1.IsPlayed(var_80_0, arg_80_0[1]) then
											var_73_5 = arg_80_0[2]

											if var_73_5 ~= "" then
												var_79_1 = var_73_5
											else
												var_73_5 = var_79_1
											end
										else
											var_79_0 = true
										end

										return
									end)

									return
								end,
								function()
									if not arg_73_1 then
										return
									end

									_ = var_0

									var_0.each(var_76_1, function(arg_82_0)
										if #arg_82_0 == 2 and arg_82_0[1] == arg_73_1 then
											var_73_5 = arg_82_0[2]

											return
										end

										return
									end)

									return
								end
							})

							return
						end)

						do return var_73_5 ~= "" and var_73_5 or var_73_0.bgm end

						goto label_73_0
					end
				end
			end
		end

		local var_73_6

		if not var_73_0 or not var_73_0.bgm then
			var_73_6 = nil
		end

		return var_73_6
	else
		return nil
	end

	::label_73_0::

	return
end

local var_0_100 = getBgm

local function var_0_101(arg_83_0, arg_83_1)
	pg = var_1_10002

	local var_83_0 = var_1_10002.NewStoryMgr.GetInstance()

	var_2.Play(var_83_0, arg_83_0, arg_83_1)

	return
end

local var_0_102 = playStory

local function var_0_103(arg_84_0)
	ERROR_MESSAGE = var_1_10001

	local var_84_0

	if var_1_10001[arg_84_0] == nil then
		ERROR_MESSAGE = var_1_10002
		var_84_0 = var_1_10002[9999] .. ":" .. arg_84_0
	end

	return var_84_0
end

local var_0_104 = errorMessage

local function var_0_105(arg_85_0, arg_85_1, ...)
	pg = var_1_10002

	local var_85_0 = var_1_10002.gametip[arg_85_0 .. "_error"]
	local var_85_1

	if var_85_0 then
		var_85_1 = var_85_0.tip
	else
		pg = var_4
		var_85_1 = var_4.gametip.common_error.tip
	end

	local var_85_2 = arg_85_0 .. "_error_" .. arg_85_1

	pg = var_5

	if var_5.gametip[var_85_2] then
		i18n = var_5

		local var_85_3 = var_5(var_85_2, ...)

		return var_85_1 .. var_85_3
	else
		local var_85_4 = "common_error_" .. arg_85_1

		pg = var_5

		local var_85_5

		if var_5.gametip[var_85_4] then
			i18n = var_85_5
			var_85_5 = var_85_5(var_85_4, ...)

			return var_85_1 .. var_85_5
		else
			errorMessage = var_85_5

			local var_85_6 = var_85_5(arg_85_1)

			return var_85_1 .. arg_85_1 .. ":" .. var_85_6
		end
	end

	return
end

local var_0_106 = errorTip

local function var_0_107(arg_86_0, arg_86_1)
	local var_86_0 = "@COLOR_SCOPE"
	local var_86_1 = {}

	string = var_1_10004
	arg_86_0 = var_1_10004.gsub(arg_86_0, "<color=#%x+>", function(arg_87_0)
		table = var_2_10001

		var_2_10001.insert(var_86_1, arg_87_0)

		return var_86_0
	end)
	string = var_4
	arg_86_0 = var_4.gsub(arg_86_0, "%d+%.?%d*%%*", function(arg_88_0)
		return "<color=" .. arg_86_1 .. ">" .. arg_88_0 .. "</color>"
	end)

	local var_86_2 = #var_86_1

	if 0 < var_86_2 then
		local var_86_3 = 0

		string = var_5

		return (var_5.gsub(arg_86_0, var_86_0, function(arg_89_0)
			var_86_3 = var_86_3 + 1

			return var_86_1[var_86_3]
		end))
	else
		return arg_86_0
	end

	return
end

local var_0_108 = colorNumber

local function var_0_109(arg_90_0)
	LuaHelper = var_1_10001

	local var_90_0 = var_1_10001.GetWorldCorners

	rtf = var_1_10003

	local var_90_1 = var_90_0(var_1_10003(arg_90_0))

	Bounds = var_1_10002

	local var_90_2 = var_1_10002.New
	local var_90_3 = var_90_1[0]

	Vector3 = var_5

	local var_90_4 = var_90_2(var_90_3, var_5.zero)

	var_2.Encapsulate(var_90_4, var_90_1[2])

	return var_2
end

local var_0_110 = getBounds

local function var_0_111(arg_91_0, arg_91_1)
	Vector3 = var_1_10002
	arg_91_0.localScale = var_1_10002.one
	Vector2 = var_2
	arg_91_0.anchorMin = var_2.zero
	Vector2 = var_2
	arg_91_0.anchorMax = var_2.one
	Vector2 = var_2
	arg_91_0.offsetMin = var_2(arg_91_1[1], arg_91_1[2])
	Vector2 = var_2
	arg_91_0.offsetMax = var_2(-arg_91_1[3], -arg_91_1[4])

	return
end

local var_0_112 = {
	frame4_0 = {
		-8,
		-8.5,
		-8,
		-8
	},
	frame5_0 = {
		-8,
		-8.5,
		-8,
		-8
	},
	frame4_1 = {
		-8,
		-8.5,
		-8,
		-8
	},
	frame_design = {
		-16.5,
		-2.5,
		-3.5,
		-16.5
	},
	frame_skin = {
		-16.5,
		-2.5,
		-3.5,
		-16.5
	},
	frame_npc = {
		-4,
		-4,
		-4,
		-4
	},
	frame_store = {
		-17,
		-3,
		-3,
		-18
	},
	frame_prop = {
		-11,
		-12,
		-14,
		-14
	},
	frame_prop_meta = {
		-11,
		-12,
		-14,
		-14
	},
	frame_battle_ui = {
		-16,
		-3.4,
		-2.6,
		-31
	},
	other = {
		-2.5,
		-4.5,
		-3,
		-4.5
	},
	frame_dorm = {
		-16.5,
		-2.5,
		-3.5,
		-16.5
	}
}
local var_0_113 = {
	["IconColorful(Clone)"] = 1,
	["Item_duang5(Clone)"] = 99,
	specialFrame = 2
}

local function var_0_114(arg_92_0, arg_92_1, arg_92_2)
	tostring = var_1_10003
	arg_92_1 = var_1_10003(arg_92_1)
	unpack = var_3
	string = var_5

	local var_92_0, var_92_1 = var_3((var_5.split(arg_92_1, "_")))

	if not var_92_1 then
		tonumber = var_92_2

		local var_92_2 = var_92_2(var_92_0)

		if 5 < var_92_2 then
			arg_92_2 = arg_92_2 or "frame" .. arg_92_1
		end

		GetImageSpriteFromAtlasAsync = var_92_2

		var_92_2("weaponframes", "frame", arg_92_0)

		if arg_92_2 then
			Color = var_92_2

			if not var_92_2.white then
				Color = var_92_2
				var_92_2 = var_92_2.NewHex
				ItemRarity = var_92_3

				local var_92_3 = var_92_3.Rarity2FrameHexColor

				if var_92_0 then
					tonumber = var_92_4

					local var_92_4

					if not var_92_4(var_92_0) then
						ItemRarity = var_92_4
						var_92_4 = var_92_4.Gray
					end

					var_92_2 = var_92_2(var_92_3(var_92_4))
					setImageColor = var_1_10006

					var_1_10006(arg_92_0, var_92_2)

					findTF = var_1_10006

					local var_92_5 = var_1_10006(arg_92_0, "specialFrame")

					if arg_92_2 then
						if var_92_5 then
							setActive = var_92_3

							var_92_3(var_92_5, true)
						else
							cloneTplTo = var_92_3
							var_92_5 = var_92_3(arg_92_0, arg_92_0, "specialFrame")
							removeAllChildren = var_92_3

							var_92_3(var_92_5)
						end

						var_92_3 = var_0_111

						local var_92_6 = var_92_5
						local var_92_7

						if not var_0_112[arg_92_2] then
							var_92_7 = var_0_112.other
						end

						var_92_3(var_92_6, var_92_7)

						GetImageSpriteFromAtlasAsync = var_92_3

						var_92_3("weaponframes", arg_92_2, var_92_5)
					elseif var_92_5 then
						setActive = var_92_3

						var_92_3(var_92_5, false)
					end

					return
				end
			end
		end
	end
end

local var_0_115 = setFrame

local function var_0_116(arg_93_0, arg_93_1, arg_93_2, arg_93_3)
	if not arg_93_3 then
		var_1_10004 = {}
		ItemRarity = var_1_10005
		var_1_10004[var_1_10005.SSR] = {
			name = "IconColorful",
			active = function(arg_94_0, arg_94_1)
				if not arg_94_1.noIconColorful then
					ItemRarity = var_2

					local var_94_0

					if arg_94_0 ~= var_2.SSR then
						var_94_0 = false
					else
						var_94_0 = true
					end

					return var_94_0
				end
			end
		}
		arg_93_3 = var_1_10004
	end

	findTF = var_1_10004

	local var_93_0 = var_1_10004(arg_93_0, "icon_bg/frame")

	pairs = var_1_10005

	for iter_93_0, iter_93_1 in var_1_10005(arg_93_3) do
		local var_93_1 = iter_93_1.name
		local var_93_2 = iter_93_1.active(arg_93_1, arg_93_2)

		if var_93_0:Find(var_93_1 .. "(Clone)") then
			setActive = var_13

			var_13(var_12, var_93_2)
		elseif var_93_2 then
			LoadAndInstantiateAsync = var_13

			local var_93_3 = "ui"

			string = var_16

			var_13(var_93_3, var_16.lower(var_93_1), function(arg_95_0)
				IsNil = var_2_10001

				if not var_2_10001(arg_93_0) then
					local var_95_0 = var_93_0

					if var_1.Find(var_95_0, var_93_1 .. "(Clone)") then
						Object = var_1

						var_1.Destroy(arg_95_0)
					else
						local var_95_1

						if not var_0_113[arg_95_0.name] then
							var_95_1 = 999
						end

						underscore = var_2

						local var_95_2 = var_2.range(var_93_0.childCount)
						local var_95_3 = var_2.chain(var_95_2)
						local var_95_4 = var_2.map(var_95_3, function(arg_96_0)
							local var_96_0 = var_93_0

							return var_1.GetChild(var_96_0, arg_96_0 - 1)
						end)
						local var_95_5 = var_2.map(var_95_4, function(arg_97_0)
							local var_97_0

							if not var_0_113[arg_97_0.name] then
								var_97_0 = 0
							end

							return var_97_0
						end)
						local var_95_6 = var_2.value(var_95_5)
						local var_95_7 = 0

						for iter_95_0 = #var_95_6, 1, -1 do
							if var_95_1 > var_95_6[iter_95_0] then
								var_95_7 = iter_95_0

								break
							end
						end

						setParent = var_4

						var_4(arg_95_0, var_93_0)

						tf = var_4

						local var_95_8 = var_4(arg_95_0)

						var_4.SetSiblingIndex(var_95_8, var_95_7)

						setActive = var_4

						var_4(arg_95_0, var_93_2)
					end

					return
				end
			end)
		end
	end

	return
end

local var_0_117 = setIconColorful

local function var_0_118(arg_98_0, arg_98_1, arg_98_2)
	findTF = var_1_10003

	local var_98_0 = var_1_10003(arg_98_0, "icon_bg/startpl")

	findTF = var_1_10004

	if var_1_10004(arg_98_0, "icon_bg/stars") and var_98_0 then
		setActive = var_5

		var_5(var_4, false)

		setActive = var_5

		var_5(var_98_0, false)
	end

	if not var_4 or not arg_98_1 then
		return
	end

	local var_98_1 = 1

	math = var_6

	for iter_98_0 = var_98_1, var_6.max(arg_98_2, var_4.childCount) do
		setActive = var_9

		if var_4.childCount < iter_98_0 then
			cloneTplTo = var_11

			local var_98_2

			if not var_11(var_98_0, var_4) then
				var_98_2 = var_4:GetChild(iter_98_0 - 1)
			end

			var_9(var_98_2, iter_98_0 <= arg_98_2)
		end
	end

	setActive = var_98_1

	var_98_1(var_4, true)

	return
end

local var_0_119 = setIconStars

local function var_0_120(arg_99_0, arg_99_1)
	findTF = var_1_10002

	local var_99_0 = var_1_10002(arg_99_0, "icon_bg/slv")

	IsNil = var_1_10003

	if not var_1_10003(var_99_0) then
		setActive = var_3

		var_3(var_99_0, arg_99_1 > 0)

		setText = var_3
		findTF = var_5

		var_3(var_5(var_99_0, "Text"), arg_99_1)
	end

	return
end

local function var_0_121(arg_100_0, arg_100_1, arg_100_2)
	findTF = var_1_10003

	local var_100_0 = var_1_10003(arg_100_0, "name")

	IsNil = var_1_10004

	if not var_1_10004(var_100_0) then
		setText = var_4

		var_4(var_100_0, arg_100_1)

		setTextAlpha = var_4

		var_4(var_100_0, (arg_100_2.hideName or arg_100_2.anonymous) and 0 or 1)
	end

	return
end

local var_0_122 = setIconName

local function var_0_123(arg_101_0, arg_101_1)
	findTF = var_1_10002

	local var_101_0 = var_1_10002(arg_101_0, "icon_bg/count")

	IsNil = var_1_10003

	if not var_1_10003(var_101_0) then
		setText = var_3

		local var_101_1 = var_101_0

		if arg_101_1 then
			type = var_1_10006

			local var_101_2

			if var_1_10006(arg_101_1) == "number" and not (arg_101_1 > 0) or not arg_101_1 then
				::label_101_0::

				var_101_2 = ""
			end

			var_3(var_101_1, var_101_2)

			return
		end
	end
end

local var_0_124 = setIconCount

local function var_0_125(arg_102_0, arg_102_1, arg_102_2)
	arg_102_2 = arg_102_2 or {}
	assert = var_1_10003

	var_1_10003(arg_102_1, "equipmentVo can not be nil.")

	EquipmentRarity = var_1_10003

	local var_102_0 = var_1_10003.Rarity2Print(arg_102_1:getConfig("rarity"))

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_102_1 = "weaponframes"
	local var_102_2 = "bg" .. var_102_0

	findTF = var_8

	var_1_10004(var_102_1, var_102_2, var_8(arg_102_0, "icon_bg"))

	setFrame = var_1_10004
	findTF = var_102_1

	var_1_10004(var_102_1(arg_102_0, "icon_bg/frame"), var_102_0)

	findTF = var_1_10004

	local var_102_3 = var_1_10004(arg_102_0, "icon_bg/icon")

	var_0_111(var_102_3, {
		16,
		16,
		16,
		16
	})

	GetImageSpriteFromAtlasAsync = var_5

	var_5("equips/" .. arg_102_1:getConfig("icon"), "", var_102_3)

	setIconStars = var_5

	var_5(arg_102_0, true, arg_102_1:getConfig("rarity"))
	var_0_120(arg_102_0, arg_102_1:getConfig("level") - 1)

	setIconName = var_5

	var_5(arg_102_0, arg_102_1:getConfig("name"), arg_102_2)

	setIconCount = var_5

	var_5(arg_102_0, arg_102_1.count)

	setIconColorful = var_5

	var_5(arg_102_0, arg_102_1:getConfig("rarity") - 1, arg_102_2)

	return
end

local var_0_126 = updateEquipment

local function var_0_127(arg_103_0, arg_103_1, arg_103_2)
	arg_103_2 = arg_103_2 or {}
	ItemRarity = var_1_10003

	local var_103_0 = var_1_10003.Rarity2Print(arg_103_1:getConfig("rarity"))

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_103_1 = "weaponframes"
	local var_103_2 = "bg" .. var_103_0

	findTF = var_8

	var_1_10004(var_103_1, var_103_2, var_8(arg_103_0, "icon_bg"))

	local var_103_3
	local var_103_4 = arg_103_1

	if arg_103_1.getConfig(var_103_4, "type") == 9 then
		var_103_3 = "frame_design"
	else
		var_103_4 = arg_103_1

		if arg_103_1.getConfig(var_103_4, "type") == 100 then
			var_103_3 = "frame_dorm"
		elseif arg_103_1.id == 44004 then
			var_103_3 = "frame8_1"
		elseif arg_103_2.frame then
			var_103_3 = arg_103_2.frame
		end
	end

	setFrame = var_5
	findTF = var_103_4

	var_5(var_103_4(arg_103_0, "icon_bg/frame"), var_103_0, var_103_3)

	findTF = var_5

	local var_103_5 = var_5(arg_103_0, "icon_bg/icon")
	local var_103_6, var_103_7

	if not arg_103_1.icon then
		var_103_6 = arg_103_1
		var_103_7 = arg_103_1.getConfig(var_103_6, "icon")
	end

	local var_103_8 = arg_103_1:getConfig("type")

	Item = var_103_6

	if var_103_8 == var_103_6.LOVE_LETTER_TYPE then
		assert = var_103_8

		var_103_8(arg_103_1.extra, "without extra data")

		var_103_8 = "SquareIcon/"
		ShipGroup = var_8
		var_103_7 = var_103_8 .. var_8.getDefaultSkin(arg_103_1.extra).painting
	end

	GetImageSpriteFromAtlasAsync = var_103_8

	var_103_8(var_103_7, "", var_103_5)

	setIconStars = var_103_8

	var_103_8(arg_103_0, false)

	setIconName = var_103_8

	var_103_8(arg_103_0, arg_103_1:getName(), arg_103_2)

	setIconColorful = var_103_8

	var_103_8(arg_103_0, arg_103_1:getConfig("rarity"), arg_103_2)

	return
end

local var_0_128 = updateItem

local function var_0_129(arg_104_0, arg_104_1)
	local var_104_0 = arg_104_1:getConfigTable().cmd_icon

	setIslandRarityFrame = var_1_10003

	var_1_10003(arg_104_0, arg_104_1)

	setActive = var_1_10003
	findTF = var_5

	var_1_10003(var_5(arg_104_0, "icon_bg/count_bg"), false)

	GetImageSpriteFromAtlasAsync = var_1_10003

	local var_104_1 = "island/" .. var_104_0
	local var_104_2 = ""

	findTF = var_7

	var_1_10003(var_104_1, var_104_2, var_7(arg_104_0, "icon_bg/icon"))

	setIconName = var_1_10003

	var_1_10003(arg_104_0, "", {})

	return
end

local var_0_130 = updateIslandUnlock

local function var_0_131(arg_105_0, arg_105_1)
	pg = var_1_10002

	local var_105_0 = var_1_10002.island_chara_template[arg_105_1.id].invite_item

	pg = var_3

	local var_105_1 = var_3.island_item_data_template[var_105_0].icon

	setIslandRarityFrame = var_1_10004

	var_1_10004(arg_105_0, arg_105_1)

	setActive = var_1_10004
	findTF = var_6

	var_1_10004(var_6(arg_105_0, "icon_bg/count_bg"), arg_105_1.count > 0)

	setText = var_1_10004
	findTF = var_6

	var_1_10004(var_6(arg_105_0, "icon_bg/count_bg/count"), arg_105_1.count)

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_105_2 = "island/" .. var_105_1
	local var_105_3 = ""

	findTF = var_8

	var_1_10004(var_105_2, var_105_3, var_8(arg_105_0, "icon_bg/icon"))

	setIconName = var_1_10004

	var_1_10004(arg_105_0, "", {})

	return
end

local var_0_132 = updateIslandInvitation

local function var_0_133(arg_106_0, arg_106_1)
	local var_106_0 = arg_106_1
	local var_106_1 = arg_106_1.getConfigTable(var_106_0).icon
	local var_106_2 = arg_106_1:getConfigTable().name

	setIslandRarityFrame = var_106_0

	var_106_0(arg_106_0, arg_106_1)

	setActive = var_106_0
	findTF = var_6

	var_106_0(var_6(arg_106_0, "icon_bg/count_bg"), arg_106_1.count > 0)

	setText = var_106_0
	findTF = var_6

	var_106_0(var_6(arg_106_0, "icon_bg/count_bg/count"), arg_106_1.count)

	GetImageSpriteFromAtlasAsync = var_106_0

	local var_106_3 = "island/" .. var_106_1
	local var_106_4 = ""

	findTF = var_8

	var_106_0(var_106_3, var_106_4, var_8(arg_106_0, "icon_bg/icon"))

	setIconName = var_106_0

	var_106_0(arg_106_0, var_106_2, {})

	return
end

local var_0_134 = updateIslandItem

local function var_0_135(arg_107_0, arg_107_1)
	local var_107_0 = arg_107_1:getConfigTable().rarity
	local var_107_1 = arg_107_1
	local var_107_2 = arg_107_1.getConfigTable(var_107_1).icon
	local var_107_3 = arg_107_1:getConfigTable().name

	setIslandRarityFrame = var_107_1

	var_107_1(arg_107_0, arg_107_1)

	setActive = var_107_1
	findTF = var_7

	var_107_1(var_7(arg_107_0, "icon_bg/count_bg"), arg_107_1.count > 0)

	setText = var_107_1
	findTF = var_7

	var_107_1(var_7(arg_107_0, "icon_bg/count_bg/count"), arg_107_1.count)

	GetImageSpriteFromAtlasAsync = var_107_1

	local var_107_4 = "island/IslandFurnitureIcon/" .. var_107_2
	local var_107_5 = ""

	findTF = var_9

	var_107_1(var_107_4, var_107_5, var_9(arg_107_0, "icon_bg/icon"))

	setIconName = var_107_1

	var_107_1(arg_107_0, var_107_3, {})

	return
end

local var_0_136 = updateIslandFurniture

local function var_0_137(arg_108_0, arg_108_1, arg_108_2)
	arg_108_2 = arg_108_2 or {}

	local var_108_0 = arg_108_1
	local var_108_1 = arg_108_1.getDropRarity(var_108_0)

	ItemRarity = var_1_10004

	local var_108_2 = var_1_10004.Rarity2Print(var_108_1)

	GetImageSpriteFromAtlasAsync = var_108_0

	var_108_0("weaponframes", "bg" .. var_108_2, arg_108_0:Find("icon_bg"))

	setFrame = var_108_0

	var_108_0(arg_108_0:Find("icon_bg/frame"), var_108_2)

	local var_108_3 = arg_108_0:Find("icon_bg/icon")

	ipairs = var_6

	local var_108_4 = {
		(arg_108_1:getIcon())
	}
	local var_108_5 = arg_108_1

	var_108_4[2] = arg_108_1.getDefaultIcon(var_108_5)

	for iter_108_0, iter_108_1 in var_6(var_108_4) do
		noEmptyStr = var_108_5

		if var_108_5(iter_108_1) then
			checkABExist = var_108_5

			if var_108_5(iter_108_1) then
				GetImageSpriteFromAtlasAsync = var_108_5

				var_108_5(iter_108_1, "", var_108_3)

				break
			end
		end
	end

	setIconStars = var_6

	var_6(arg_108_0, false)

	setIconName = var_6

	var_6(arg_108_0, arg_108_1:getName(), arg_108_2)

	setIconColorful = var_6

	var_6(arg_108_0, var_108_1, arg_108_2)

	return
end

local var_0_138 = updateDefaultIconTpl

local function var_0_139(arg_109_0, arg_109_1, arg_109_2)
	GetImageSpriteFromAtlasAsync = var_1_10003

	local var_109_0 = arg_109_1
	local var_109_1 = arg_109_1.getIcon(var_109_0)
	local var_109_2 = ""

	findTF = var_109_0

	var_1_10003(var_109_1, var_109_2, var_109_0(arg_109_0, "icon_bg/icon"))

	setActive = var_1_10003
	findTF = var_109_1

	var_1_10003(var_109_1(arg_109_0, "icon_bg/count_bg"), arg_109_1.count > 0)

	setText = var_1_10003
	findTF = var_5

	var_1_10003(var_5(arg_109_0, "icon_bg/count_bg/count"), arg_109_1.count)

	setIconName = var_1_10003

	var_1_10003(arg_109_0, arg_109_1:getName(), {})

	setIslandRarityFrame = var_1_10003

	var_1_10003(arg_109_0, arg_109_1)

	return
end

local var_0_140 = updateIslandDefaultIconTpl

local function var_0_141(arg_110_0, arg_110_1)
	local var_110_0 = arg_110_1
	local var_110_1 = arg_110_1.getIslandRarity(var_110_0)

	IslandItemRarity = var_1_10003

	local var_110_2 = var_1_10003.Rarity2FrameName(var_110_1)

	GetImageSpriteFromAtlasAsync = var_110_0

	local var_110_3 = "island/islandframe"
	local var_110_4 = var_110_2

	findTF = var_1_10008

	var_110_0(var_110_3, var_110_4, var_1_10008(arg_110_0, "icon_bg"))

	IsNil = var_110_0
	findTF = var_110_3

	if not var_110_0(var_110_3(arg_110_0, "icon_bg/frame")) then
		GetImageSpriteFromAtlasAsync = var_4

		local var_110_5 = "island/islandframe"
		local var_110_6 = var_110_2

		findTF = var_8

		var_4(var_110_5, var_110_6, var_8(arg_110_0, "icon_bg/frame"))
	end

	return
end

local var_0_142 = setIslandRarityFrame

local function var_0_143()
	pg = var_1_10000

	local var_111_0 = var_1_10000.island_set.season_pt_show.key_value_int

	pg = var_1_10001

	local var_111_1 = var_1_10001.island_item_data_template[var_111_0]

	return {
		name = var_111_1.name,
		icon = var_111_1.icon
	}
end

local var_0_144 = getIslandSeasonPtInfo

local function var_0_145(arg_112_0, arg_112_1)
	Drop = var_1_10002

	local var_112_0 = var_1_10002.New
	local var_112_1 = {}

	DROP_TYPE_ISLAND_ITEM = var_1_10005
	var_112_1.type = var_1_10005
	pg = var_1_10005
	var_112_1.id = var_1_10005.island_set.season_pt_show.key_value_int
	var_112_1.count = arg_112_1.count

	local var_112_2 = var_112_0(var_112_1)

	updateIslandItem = var_1_10003

	var_1_10003(arg_112_0, var_112_2)

	return
end

local var_0_146 = updateIslandSeasonPt

local function var_0_147(arg_113_0, arg_113_1)
	GetImageSpriteFromAtlasAsync = var_1_10002

	local var_113_0 = arg_113_1
	local var_113_1 = arg_113_1.getIcon(var_113_0)
	local var_113_2 = ""

	findTF = var_113_0

	var_1_10002(var_113_1, var_113_2, var_113_0(arg_113_0, "icon_bg/icon"))

	setActive = var_1_10002
	findTF = var_113_1

	var_1_10002(var_113_1(arg_113_0, "icon_bg/count_bg"), arg_113_1.count > 0)

	setText = var_1_10002
	findTF = var_4

	var_1_10002(var_4(arg_113_0, "icon_bg/count_bg/count"), arg_113_1.count)

	setIconName = var_1_10002

	var_1_10002(arg_113_0, arg_113_1:getConfigTable().name, {})

	setIslandRarityFrame = var_1_10002

	var_1_10002(arg_113_0, arg_113_1)

	return
end

local var_0_148 = updateIslandCardDiy

local function var_0_149(arg_114_0, arg_114_1)
	local var_114_0 = arg_114_1:getConfigTable().icon

	GetImageSpriteFromAtlasAsync = var_1_10003

	local var_114_1 = "island/" .. var_114_0
	local var_114_2 = ""

	findTF = var_1_10007

	var_1_10003(var_114_1, var_114_2, var_1_10007(arg_114_0, "icon_bg/icon"))

	setActive = var_1_10003
	findTF = var_114_1

	var_1_10003(var_114_1(arg_114_0, "icon_bg/count_bg"), arg_114_1.count > 0)

	setText = var_1_10003
	findTF = var_5

	var_1_10003(var_5(arg_114_0, "icon_bg/count_bg/count"), arg_114_1.count)

	setIconName = var_1_10003

	var_1_10003(arg_114_0, arg_114_1:getConfigTable().name, {})

	setIslandRarityFrame = var_1_10003

	var_1_10003(arg_114_0, arg_114_1)

	return
end

local var_0_150 = updateIslandSpeedupTicket

local function var_0_151(arg_115_0, arg_115_1)
	local var_115_0 = arg_115_1:getConfigTable().icon

	GetImageSpriteFromAtlasAsync = var_1_10003

	local var_115_1 = "island/IslandDressIcon/" .. var_115_0
	local var_115_2 = ""

	findTF = var_1_10007

	var_1_10003(var_115_1, var_115_2, var_1_10007(arg_115_0, "icon_bg/icon"))

	setActive = var_1_10003
	findTF = var_115_1

	var_1_10003(var_115_1(arg_115_0, "icon_bg/count_bg"), arg_115_1.count > 0)

	setText = var_1_10003
	findTF = var_5

	var_1_10003(var_5(arg_115_0, "icon_bg/count_bg/count"), arg_115_1.count)

	setIconName = var_1_10003

	var_1_10003(arg_115_0, arg_115_1:getConfigTable().name, {})

	setIslandRarityFrame = var_1_10003

	var_1_10003(arg_115_0, arg_115_1)

	return
end

local var_0_152 = updateIslandSkin

local function var_0_153(arg_116_0, arg_116_1)
	local var_116_0 = arg_116_1:getConfigTable().icon

	GetImageSpriteFromAtlasAsync = var_1_10003

	local var_116_1 = "island/IslandDressIcon/" .. var_116_0
	local var_116_2 = ""

	findTF = var_1_10007

	var_1_10003(var_116_1, var_116_2, var_1_10007(arg_116_0, "icon_bg/icon"))

	setActive = var_1_10003
	findTF = var_116_1

	var_1_10003(var_116_1(arg_116_0, "icon_bg/count_bg"), arg_116_1.count > 0)

	setText = var_1_10003
	findTF = var_5

	var_1_10003(var_5(arg_116_0, "icon_bg/count_bg/count"), arg_116_1.count)

	setIconName = var_1_10003

	var_1_10003(arg_116_0, arg_116_1:getConfigTable().name, {})

	setIslandRarityFrame = var_1_10003

	var_1_10003(arg_116_0, arg_116_1)

	return
end

local var_0_154 = updateIslandDress

local function var_0_155(arg_117_0, arg_117_1)
	local var_117_0 = arg_117_1
	local var_117_1 = arg_117_1.getConfigTable(var_117_0).icon
	local var_117_2 = arg_117_1:getConfigTable().name

	setText = var_117_0
	findTF = var_1_10006

	var_117_0(var_1_10006(arg_117_0, "icon_bg/count"), arg_117_1.count)

	GetImageSpriteFromAtlasAsync = var_117_0

	local var_117_3 = "island/" .. var_117_1
	local var_117_4 = ""

	findTF = var_8

	var_117_0(var_117_3, var_117_4, var_8(arg_117_0, "icon_bg/icon"))

	setIconName = var_117_0

	var_117_0(arg_117_0, var_117_2, {})

	setIslandRarityFrame = var_117_0

	var_117_0(arg_117_0, arg_117_1)

	return
end

local var_0_156 = updateIslandWatherCollect

local function var_0_157(arg_118_0, arg_118_1, arg_118_2)
	arg_118_2 = arg_118_2 or {}
	ItemRarity = var_1_10003

	local var_118_0 = var_1_10003.Rarity2Print(arg_118_1:getConfig("rarity"))

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_118_1 = "weaponframes"
	local var_118_2 = "bg" .. var_118_0

	findTF = var_8

	var_1_10004(var_118_1, var_118_2, var_8(arg_118_0, "icon_bg"))

	setFrame = var_1_10004
	findTF = var_118_1

	var_1_10004(var_118_1(arg_118_0, "icon_bg/frame"), var_118_0)

	findTF = var_1_10004

	local var_118_3 = var_1_10004(arg_118_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_5

	local var_118_4

	if not arg_118_1.icon then
		var_118_4 = arg_118_1:getConfig("icon")
	end

	var_5(var_118_4, "", var_118_3)

	setIconStars = var_5

	var_5(arg_118_0, false)

	setIconName = var_5

	var_5(arg_118_0, arg_118_1:getConfig("name"), arg_118_2)

	setIconColorful = var_5

	var_5(arg_118_0, arg_118_1:getConfig("rarity"), arg_118_2)

	return
end

local var_0_158 = updateWorldItem

local function var_0_159(arg_119_0, arg_119_1, arg_119_2)
	arg_119_2 = arg_119_2 or {}
	assert = var_1_10003

	var_1_10003(arg_119_1:getConfigTable(), "world_collection_file_template 和 world_collection_record_template 表中找不到配置: " .. arg_119_1.id)

	local var_119_0 = arg_119_1
	local var_119_1 = arg_119_1.getDropRarity(var_119_0)

	ItemRarity = var_1_10004

	local var_119_2 = var_1_10004.Rarity2Print(var_119_1)

	GetImageSpriteFromAtlasAsync = var_119_0

	local var_119_3 = "weaponframes"
	local var_119_4 = "bg" .. var_119_2

	findTF = var_9

	var_119_0(var_119_3, var_119_4, var_9(arg_119_0, "icon_bg"))

	setFrame = var_119_0
	findTF = var_119_3

	var_119_0(var_119_3(arg_119_0, "icon_bg/frame"), var_119_2)

	findTF = var_119_0

	local var_119_5 = var_119_0(arg_119_0, "icon_bg/icon")

	WorldCollectionProxy = var_6

	local var_119_6 = var_6.GetCollectionType(arg_119_1.id)

	WorldCollectionProxy = var_7

	local var_119_7 = var_119_6 == var_7.WorldCollectionType.FILE and "shoucangguangdie" or "shoucangjiaojuan"

	GetImageSpriteFromAtlasAsync = var_8

	var_8("props/" .. var_119_7, "", var_119_5)

	setIconStars = var_8

	var_8(arg_119_0, false)

	setIconName = var_8

	var_8(arg_119_0, arg_119_1:getName(), arg_119_2)

	setIconColorful = var_8

	var_8(arg_119_0, var_119_1, arg_119_2)

	return
end

local var_0_160 = updateWorldCollection

local function var_0_161(arg_120_0, arg_120_1, arg_120_2)
	arg_120_2 = arg_120_2 or {}
	pg = var_1_10003

	local var_120_0 = var_1_10003.world_SLGbuff_data[arg_120_1]

	assert = var_1_10004

	var_1_10004(var_120_0, "找不到大世界buff配置: " .. arg_120_1)

	ItemRarity = var_1_10004

	local var_120_1 = var_1_10004.Rarity2Print

	ItemRarity = var_6

	local var_120_2 = var_120_1(var_6.Gray)

	GetImageSpriteFromAtlasAsync = var_1_10005

	local var_120_3 = "weaponframes"
	local var_120_4 = "bg" .. var_120_2

	findTF = var_9

	var_1_10005(var_120_3, var_120_4, var_9(arg_120_0, "icon_bg"))

	setFrame = var_1_10005
	findTF = var_120_3

	var_1_10005(var_120_3(arg_120_0, "icon_bg/frame"), var_120_2)

	findTF = var_1_10005

	local var_120_5 = var_1_10005(arg_120_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_6

	var_6("world/buff/" .. var_120_0.icon, "", var_120_5)

	local var_120_6 = arg_120_0
	local var_120_7 = arg_120_0.Find(var_120_6, "icon_bg/stars")

	IsNil = var_7

	if not var_7(var_120_7) then
		setActive = var_7

		var_7(var_120_7, false)
	end

	findTF = var_7

	local var_120_8 = var_7(arg_120_0, "name")

	IsNil = var_120_6

	if not var_120_6(var_120_8) then
		setText = var_8

		var_8(var_120_8, var_120_0.name)
	end

	findTF = var_8

	local var_120_9 = var_8(arg_120_0, "icon_bg/count")

	IsNil = var_9

	if not var_9(var_120_9) then
		SetActive = var_9

		var_9(var_120_9, false)
	end

	return
end

local var_0_162 = updateWorldBuff

local function var_0_163(arg_121_0, arg_121_1, arg_121_2)
	arg_121_2 = arg_121_2 or {}

	local var_121_0 = arg_121_1:rarity2bgPrint()
	local var_121_1 = arg_121_1
	local var_121_2 = arg_121_1.getPainting(var_121_1)

	if arg_121_2.anonymous then
		var_121_0 = "1"
		var_121_2 = "unknown"
	end

	if arg_121_2.unknown_small then
		var_121_2 = "unknown_small"
	end

	findTF = var_5

	if var_5(arg_121_0, "icon_bg/new") then
		if arg_121_2.isSkin then
			setActive = var_121_1

			var_121_1(var_5, not arg_121_2.isTimeLimit and arg_121_2.isNew)
		else
			setActive = var_121_1

			var_121_1(var_5, arg_121_1.virgin)
		end
	end

	findTF = var_121_1

	if var_121_1(arg_121_0, "icon_bg/timelimit") then
		setActive = var_7

		var_7(var_6, arg_121_2.isTimeLimit)
	end

	findTF = var_7

	local var_121_3 = var_7(arg_121_0, "icon_bg")

	GetImageSpriteFromAtlasAsync = var_8

	var_8("weaponframes", "bg" .. (arg_121_2.isSkin and "_skin" or var_121_0), var_121_3)

	findTF = var_8

	local var_121_4 = var_8(arg_121_0, "icon_bg/frame")
	local var_121_5

	if arg_121_1.isNpc then
		var_121_5 = "frame_npc"
	elseif arg_121_1:ShowPropose() then
		var_121_5 = "frame_prop"

		if arg_121_1:isMetaShip() then
			var_121_5 = var_121_5 .. "_meta"
		end
	elseif arg_121_2.isSkin then
		var_121_5 = "frame_skin"
	end

	setFrame = var_10

	var_10(var_121_4, var_121_0, var_121_5)

	if arg_121_2.gray then
		setGray = var_10

		var_10(var_121_3, true, true)
	end

	findTF = var_10

	local var_121_6 = var_10(arg_121_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_11

	var_11((arg_121_2.Q and "QIcon/" or "SquareIcon/") .. var_121_2, "", var_121_6)

	findTF = var_11

	if var_11(arg_121_0, "icon_bg/lv") then
		setActive = var_12

		var_12(var_11, not arg_121_1.isNpc)

		if not arg_121_1.isNpc then
			findTF = var_12

			if var_12(var_11, "Text") and arg_121_1.level then
				setText = var_13

				var_13(var_12, arg_121_1.level)
			end
		end
	end

	findTF = var_12

	if var_12(arg_121_0, "ship_type") then
		setActive = var_13

		var_13(var_12, true)

		setImageSprite = var_13

		local var_121_7 = var_12

		GetSpriteFromAtlas = var_16

		local var_121_8 = "shiptype"

		shipType2print = var_1_10019

		var_13(var_121_7, var_16(var_121_8, var_1_10019(arg_121_1:getShipType())))
	end

	local var_121_9 = var_121_3
	local var_121_10 = var_121_3.Find(var_121_9, "npc")

	IsNil = var_14

	if not var_14(var_121_10) then
		if var_5 then
			go = var_14

			if var_14(var_5).activeSelf then
				setActive = var_14

				var_14(var_121_10, false)

				goto label_121_0
			end
		end

		setActive = var_14

		var_14(var_121_10, arg_121_1:isActivityNpc())
	end

	::label_121_0::

	if arg_121_0:Find("group_locked") then
		setActive = var_121_9

		local var_121_11 = var_14
		local var_121_13

		if not arg_121_2.isSkin then
			getProxy = var_18
			CollectionProxy = var_1_10020

			local var_121_12 = var_18(var_1_10020)

			var_121_13 = not var_18.getShipGroup(var_121_12, arg_121_1.groupId)
		else
			var_121_13 = false
		end

		if false then
			var_121_13 = true
		end

		var_121_9(var_121_11, var_121_13)
	end

	setIconStars = var_121_9

	var_121_9(arg_121_0, arg_121_2.initStar, arg_121_1:getStar())

	setIconName = var_121_9

	local var_121_14 = arg_121_0
	local var_121_15

	if not arg_121_2.isSkin or not arg_121_1:GetSkinConfig().name then
		var_121_15 = arg_121_1:getName()
	end

	var_121_9(var_121_14, var_121_15, arg_121_2)

	setIconColorful = var_121_9

	local var_121_16 = arg_121_0

	if arg_121_2.isSkin then
		ItemRarity = var_18

		local var_121_17

		if not var_18.Gold then
			var_121_17 = arg_121_1:getRarity() - 1
		end

		var_121_9(var_121_16, var_121_17, arg_121_2)

		return
	end
end

local var_0_164 = updateShip

local function var_0_165(arg_122_0, arg_122_1, arg_122_2)
	arg_122_2 = arg_122_2 or {}

	local var_122_0 = arg_122_1:getDropRarity()

	ItemRarity = var_1_10004

	local var_122_1 = var_1_10004.Rarity2Print(var_122_0)
	local var_122_2 = arg_122_1
	local var_122_3 = arg_122_1.getConfig(var_122_2, "painting")

	if arg_122_2.anonymous then
		var_122_1 = 1
		var_122_3 = "unknown"
	end

	findTF = var_6

	local var_122_4 = var_6(arg_122_0, "icon_bg")

	GetImageSpriteFromAtlasAsync = var_122_2

	var_122_2("weaponframes", "bg" .. var_122_1, var_122_4)

	findTF = var_122_2

	local var_122_5 = var_122_2(arg_122_0, "icon_bg/frame")

	setFrame = var_8

	var_8(var_122_5, var_122_1)

	if arg_122_2.gray then
		setGray = var_8

		var_8(var_122_4, true, true)
	end

	findTF = var_8

	local var_122_6 = var_8(arg_122_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_9

	var_9("CommanderIcon/" .. var_122_3, "", var_122_6)

	setIconStars = var_9

	var_9(arg_122_0, arg_122_2.initStar, 0)

	setIconName = var_9

	var_9(arg_122_0, arg_122_1:getName(), arg_122_2)

	return
end

local var_0_166 = updateCommander

local function var_0_167(arg_123_0, arg_123_1, arg_123_2)
	arg_123_2 = arg_123_2 or {}
	ItemRarity = var_1_10003

	local var_123_0 = var_1_10003.Rarity2Print

	ItemRarity = var_1_10005

	local var_123_1 = var_123_0(var_1_10005.Gray)

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_123_2 = "weaponframes"
	local var_123_3 = "bg" .. var_123_1

	findTF = var_8

	var_1_10004(var_123_2, var_123_3, var_8(arg_123_0, "icon_bg"))

	setFrame = var_1_10004
	findTF = var_123_2

	var_1_10004(var_123_2(arg_123_0, "icon_bg/frame"), var_123_1)

	findTF = var_1_10004

	local var_123_4 = var_1_10004(arg_123_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_5

	var_5((arg_123_1.isWorldBuff and "world/buff/" or "strategyicon/") .. arg_123_1:getIcon(), "", var_123_4)

	setIconStars = var_5

	var_5(arg_123_0, false)

	setIconName = var_5

	var_5(arg_123_0, arg_123_1:getName(), arg_123_2)

	setIconColorful = var_5

	local var_123_5 = arg_123_0

	ItemRarity = var_8

	var_5(var_123_5, var_8.Gray, arg_123_2)

	return
end

local var_0_168 = updateStrategy

local function var_0_169(arg_124_0, arg_124_1, arg_124_2)
	arg_124_2 = arg_124_2 or {}

	local var_124_0 = arg_124_1
	local var_124_1 = arg_124_1.getDropRarity(var_124_0)

	ItemRarity = var_1_10004

	local var_124_2 = var_1_10004.Rarity2Print(var_124_1)

	GetImageSpriteFromAtlasAsync = var_124_0

	local var_124_3 = "weaponframes"
	local var_124_4 = "bg" .. var_124_2

	findTF = var_9

	var_124_0(var_124_3, var_124_4, var_9(arg_124_0, "icon_bg"))

	setFrame = var_124_0
	findTF = var_124_3

	var_124_0(var_124_3(arg_124_0, "icon_bg/frame"), var_124_2)

	findTF = var_124_0

	local var_124_5 = var_124_0(arg_124_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_6

	var_6("furnitureicon/" .. arg_124_1:getIcon(), "", var_124_5)

	setIconStars = var_6

	var_6(arg_124_0, false)

	setIconName = var_6

	var_6(arg_124_0, arg_124_1:getName(), arg_124_2)

	setIconColorful = var_6

	var_6(arg_124_0, var_124_1, arg_124_2)

	return
end

local var_0_170 = updateFurniture

local function var_0_171(arg_125_0, arg_125_1, arg_125_2)
	arg_125_2 = arg_125_2 or {}
	assert = var_1_10003

	var_1_10003(arg_125_1, "spWeaponVO can not be nil.")

	assert = var_1_10003
	isa = var_5

	local var_125_0 = arg_125_1

	SpWeapon = var_1_10008

	var_1_10003(var_5(var_125_0, var_1_10008), "spWeaponVO is not Equipment.")

	ItemRarity = var_1_10003

	local var_125_1 = var_1_10003.Rarity2Print(arg_125_1:GetRarity())

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_125_2 = "weaponframes"
	local var_125_3 = "bg" .. var_125_1

	findTF = var_8

	var_1_10004(var_125_2, var_125_3, var_8(arg_125_0, "icon_bg"))

	setFrame = var_1_10004
	findTF = var_125_2

	var_1_10004(var_125_2(arg_125_0, "icon_bg/frame"), var_125_1)

	findTF = var_1_10004

	local var_125_4 = var_1_10004(arg_125_0, "icon_bg/icon")

	var_0_111(var_125_4, {
		16,
		16,
		16,
		16
	})

	GetImageSpriteFromAtlasAsync = var_5

	var_5(arg_125_1:GetIconPath(), "", var_125_4)

	setIconStars = var_5

	var_5(arg_125_0, true, arg_125_1:GetRarity())
	var_0_120(arg_125_0, arg_125_1:GetLevel() - 1)

	setIconName = var_5

	var_5(arg_125_0, arg_125_1:GetName(), arg_125_2)

	setIconCount = var_5

	var_5(arg_125_0, arg_125_1.count)

	setIconColorful = var_5

	var_5(arg_125_0, arg_125_1:GetRarity(), arg_125_2)

	return
end

local var_0_172 = updateSpWeapon

local function var_0_173(arg_126_0, arg_126_1, arg_126_2)
	ItemRarity = var_1_10003

	local var_126_0 = var_1_10003.Rarity2Print(arg_126_1:GetRarity())

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_126_1 = "weaponframes"
	local var_126_2 = "bg" .. var_126_0

	findTF = var_8

	var_1_10004(var_126_1, var_126_2, var_8(arg_126_0, "Icon/Mask/icon_bg"))

	findTF = var_1_10004

	local var_126_3 = var_1_10004(arg_126_0, "Icon/Mask/icon_bg/icon")

	arg_126_2 = arg_126_2 or {
		16,
		16,
		16,
		16
	}

	var_0_111(var_126_3, arg_126_2)

	GetImageSpriteFromAtlasAsync = var_5

	var_5(arg_126_1:GetIconPath(), "", var_126_3)

	local var_126_4 = arg_126_1
	local var_126_5 = arg_126_1.GetLevel(var_126_4) - 1

	findTF = var_6

	local var_126_6 = var_6(arg_126_0, "Icon/LV")

	setActive = var_126_4

	var_126_4(var_126_6, var_126_5 > 0)

	setText = var_126_4
	findTF = var_9

	var_126_4(var_9(var_126_6, "Text"), var_126_5)

	return
end

local var_0_174 = UpdateSpWeaponSlot

local function var_0_175(arg_127_0, arg_127_1)
	local var_127_0 = arg_127_1
	local var_127_1 = arg_127_1.getDropRarityDorm(var_127_0)

	GetImageSpriteFromAtlasAsync = var_1_10003

	local var_127_2 = "weaponframes"
	local var_127_3 = "dorm3d_"

	ItemRarity = var_1_10007

	var_1_10003(var_127_2, var_127_3 .. var_1_10007.Rarity2Print(var_127_1), arg_127_0)

	local var_127_4 = arg_127_0:Find("icon")

	GetImageSpriteFromAtlasAsync = var_127_0

	var_127_0(arg_127_1:getIcon(), "", var_127_4)

	setText = var_127_0

	var_127_0(arg_127_0:Find("count/Text"), "x" .. arg_127_1.count)

	setText = var_127_0

	var_127_0(arg_127_0:Find("name/Text"), arg_127_1:getName())

	return
end

local var_0_176 = updateDorm3dIcon

local function var_0_177(arg_128_0, arg_128_1, arg_128_2)
	local var_128_0

	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_129_0)
			GetPrefabFromAtlasAsync = var_2_10001

			local var_129_0 = arg_128_1

			var_2_10001(var_3.GetPrefabName(var_129_0), arg_128_0, function(arg_130_0)
				var_128_0 = arg_130_0.transform
				eachChild = var_1

				var_1(arg_128_0, function(arg_131_0, arg_131_1)
					if arg_131_0.name ~= arg_130_0.name then
						returnLoveLetterMedal = var_2

						var_2(arg_131_0)
					end

					return
				end)
				arg_129_0()

				return
			end)

			return
		end
	}, function()
		local var_132_0 = arg_128_1
		local var_132_1 = var_0.GetPainting(var_132_0)

		GetImageSpriteFromAtlasAsync = var_2_10001

		local var_132_2 = "SquareIcon/" .. var_132_1
		local var_132_3 = ""
		local var_132_4 = var_128_0

		var_2_10001(var_132_2, var_132_3, var_5.Find(var_132_4, "mask/icon"))

		setText = var_2_10001

		local var_132_5 = var_128_0
		local var_132_6 = var_3.Find(var_132_5, "front/mark/Text")
		local var_132_7 = arg_128_1

		var_2_10001(var_132_6, var_4.GetDisplayLevelMark(var_132_7))

		setActive = var_2_10001

		local var_132_8 = var_128_0
		local var_132_9 = var_3.Find(var_132_8, "pick_up")
		local var_132_10

		if arg_128_2 then
			var_132_10 = arg_128_2.showPickUp
		end

		var_2_10001(var_132_9, var_132_10)

		setActive = var_2_10001

		local var_132_11 = var_128_0

		var_2_10001(var_3.Find(var_132_11, "front/mark"), true)

		if arg_128_2 and arg_128_2.hideMark then
			setActive = var_1

			local var_132_12 = var_128_0

			var_1(var_3.Find(var_132_12, "front/mark"), false)
		end

		return
	end)

	return
end

local var_0_178 = setLoveLetterMedal

local function var_0_179(arg_133_0)
	IsNil = var_1_10001

	if var_1_10001(arg_133_0) then
		return
	end

	string = var_1

	local var_133_0 = var_1.gsub(arg_133_0.name, "%(Clone%)", "")

	pg = var_1_10002

	local var_133_1 = var_1_10002.PoolMgr.GetInstance()
	local var_133_2 = var_2.ReturnPrefab
	local var_133_3 = "lovelettermedal/"

	string = var_1_10006

	var_133_2(var_133_1, var_133_3 .. var_1_10006.lower(var_133_0), "", arg_133_0.gameObject)

	return
end

local var_0_180 = returnLoveLetterMedal
local var_0_181

local function var_0_182(arg_134_0)
	if #arg_134_0 == 0 then
		return false
	end

	local var_134_0 = arg_134_0[1].canvasRect

	for iter_134_0 = 1, #arg_134_0 do
		rectIntersect = var_1_10006
		var_134_0 = var_1_10006(var_134_0, arg_134_0[iter_134_0].canvasRect)
	end

	if var_134_0.width <= 0 or var_134_0.height <= 0 then
		return false
	end

	local var_134_1

	if not var_0_181 then
		GameObject = var_134_1
		var_134_1 = var_134_1.Find("UICamera/Canvas").transform
	end

	var_0_181 = var_134_1

	local var_134_2 = var_0_181
	local var_134_3 = var_2.TransformPoint

	Vector3 = iter_134_0

	local var_134_4 = var_134_3(var_134_2, iter_134_0(var_134_0.x, var_134_0.y, 0))
	local var_134_5 = var_0_181
	local var_134_6 = var_3.TransformPoint

	Vector3 = var_1_10006

	local var_134_7 = var_134_6(var_134_5, var_1_10006(var_134_0.x + var_134_0.width, var_134_0.y + var_134_0.height, 0))
	local var_134_8 = true

	Vector4 = var_134_5

	local var_134_9 = var_134_5(var_134_4.x, var_134_4.y, var_134_7.x, var_134_7.y)
end

local var_0_183 = findCullAndClipWorldRect

local function var_0_184(arg_135_0, arg_135_1)
	math = var_1_10002

	local var_135_0 = var_1_10002.max(arg_135_0.x, arg_135_1.x)

	math = var_1_10003

	local var_135_1 = var_1_10003.min(arg_135_0.x + arg_135_0.width, arg_135_1.x + arg_135_1.width)

	math = var_4

	local var_135_2 = var_4.max(arg_135_0.y, arg_135_1.y)

	math = var_5

	local var_135_3 = var_5.min(arg_135_0.y + arg_135_0.height, arg_135_1.y + arg_135_1.height)

	if var_135_0 <= var_135_1 and var_135_2 <= var_135_3 then
		return var_0_10000.Rect.New(var_135_0, var_135_2, var_135_1 - var_135_0, var_135_3 - var_135_2)
	end

	return var_0_10000.Rect.New(0, 0, 0, 0)
end

local var_0_185 = rectIntersect

local function var_0_186(arg_136_0)
	local var_136_0 = {}

	ipairs = var_1_10002

	for iter_136_0, iter_136_1 in var_1_10002(arg_136_0) do
		Drop = var_1_10007

		local var_136_1

		if not var_1_10007.Create(iter_136_1).count then
			var_136_1 = 1
		end

		var_1_10007.count = var_136_1

		local var_136_2 = var_1_10007.type

		DROP_TYPE_EMOJI = var_9

		if var_136_2 == var_9 then
			table = var_136_2

			var_136_2.insert(var_136_0, var_1_10007:getName())
		else
			table = var_136_2

			var_136_2.insert(var_136_0, var_1_10007:getName() .. "x" .. var_1_10007.count)
		end
	end

	table = var_2

	return var_2.concat(var_136_0, "、")
end

local var_0_187 = getDropInfo

local function var_0_188(arg_137_0, arg_137_1, arg_137_2)
	Drop = var_1_10003

	var_1_10003.Change(arg_137_1)

	arg_137_2 = arg_137_2 or {}

	local var_137_0 = {
		{
			"icon_bg/slv"
		},
		{
			"icon_bg/frame/specialFrame"
		}
	}
	local var_137_1 = {
		"ship_type"
	}

	DROP_TYPE_SHIP = var_5
	var_137_1[2] = var_5
	var_137_0[3] = var_137_1

	local var_137_2 = {
		"icon_bg/new"
	}

	DROP_TYPE_SHIP = var_5
	var_137_2[2] = var_5
	var_137_0[4] = var_137_2

	local var_137_3 = {
		"icon_bg/npc"
	}

	DROP_TYPE_SHIP = var_5
	var_137_3[2] = var_5
	var_137_0[5] = var_137_3

	local var_137_4 = {
		"group_locked"
	}

	DROP_TYPE_SHIP = var_5
	var_137_4[2] = var_5
	var_137_0[6] = var_137_4

	local var_137_5

	ipairs = var_5

	for iter_137_0, iter_137_1 in var_5(var_137_0) do
		local var_137_6 = arg_137_0:Find(iter_137_1[1])

		if arg_137_1.type ~= iter_137_1[2] then
			IsNil = var_10

			if not var_10(var_137_6) then
				setActive = var_10

				var_10(var_137_6, false)
			end
		end
	end

	IsNil = var_5

	if not var_5(arg_137_0:Find("icon_bg/frame")) then
		local var_137_7 = arg_137_0:Find("icon_bg/frame")
		local var_137_8 = var_5.GetComponent

		typeof = var_8
		Image = var_10

		local var_137_9 = var_137_8(var_137_7, var_8(var_10))

		var_137_9.enabled = true
		setIconColorful = var_137_9

		local var_137_10 = arg_137_0
		local var_137_11 = arg_137_1:getDropRarity()
		local var_137_12 = arg_137_2
		local var_137_13 = {}

		ItemRarity = var_1_10011
		var_137_13[var_1_10011.Gold] = {
			name = "Item_duang5",
			active = function(arg_138_0, arg_138_1)
				local var_138_0

				if arg_138_1.fromAwardLayer then
					ItemRarity = var_138_0
					var_138_0 = var_138_0.Gold <= arg_138_0
				end

				return var_138_0
			end
		}

		var_137_9(var_137_10, var_137_11, var_137_12, var_137_13)

		local var_137_14 = var_0_111

		findTF = var_137_10

		var_137_14(var_137_10(arg_137_0, "icon_bg/icon"), {
			2,
			2,
			2,
			2
		})
	end

	arg_137_1:UpdateDropTpl(arg_137_0, arg_137_2)

	setIconCount = var_5

	local var_137_15 = arg_137_0
	local var_137_16

	if not arg_137_2.count then
		var_137_16 = arg_137_1:getCount()
	end

	var_5(var_137_15, var_137_16)

	return
end

local var_0_189 = updateDrop

local function var_0_190(arg_139_0, arg_139_1, arg_139_2)
	Drop = var_1_10003

	var_1_10003.Change(arg_139_1)

	arg_139_2 = arg_139_2 or {}

	arg_139_1:UpdateCustomDropTpl(arg_139_0, arg_139_2)

	return
end

local var_0_191 = updateCustomDrop

local function var_0_192(arg_140_0, arg_140_1, arg_140_2)
	arg_140_2 = arg_140_2 or {}
	ItemRarity = var_1_10003

	local var_140_0 = var_1_10003.Rarity2Print

	ItemRarity = var_1_10005

	local var_140_1 = var_140_0(var_1_10005.Gray)

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_140_2 = "weaponframes"
	local var_140_3 = "bg" .. var_140_1

	findTF = var_8

	var_1_10004(var_140_2, var_140_3, var_8(arg_140_0, "icon_bg"))

	pg = var_1_10004

	local var_140_4 = var_1_10004.benefit_buff_template[arg_140_1]

	setFrame = var_5
	findTF = var_140_3

	var_5(var_140_3(arg_140_0, "icon_bg/frame"), var_140_1)

	setText = var_5
	findTF = var_7

	var_5(var_7(arg_140_0, "icon_bg/count"), 1)

	findTF = var_5

	local var_140_5 = var_5(arg_140_0, "icon_bg/icon")
	local var_140_6 = var_140_4.icon

	GetImageSpriteFromAtlasAsync = var_7

	var_7(var_140_6, "", var_140_5)

	setIconStars = var_7

	var_7(arg_140_0, false)

	setIconName = var_7

	var_7(arg_140_0, var_140_4.name, arg_140_2)

	setIconColorful = var_7

	local var_140_7 = arg_140_0

	ItemRarity = var_10

	var_7(var_140_7, var_10.Gold, arg_140_2)

	return
end

local var_0_193 = updateBuff

local function var_0_194(arg_141_0, arg_141_1, arg_141_2, arg_141_3)
	local var_141_0 = 4

	GetImageSpriteFromAtlasAsync = var_1_10005

	local var_141_1 = "weaponframes"
	local var_141_2 = "bg" .. var_141_0

	findTF = var_9

	var_1_10005(var_141_1, var_141_2, var_9(arg_141_0, "icon_bg"))

	setFrame = var_1_10005
	findTF = var_141_1

	var_1_10005(var_141_1(arg_141_0, "icon_bg/frame"), var_141_0)

	findTF = var_1_10005

	local var_141_3 = var_1_10005(arg_141_0, "icon_bg/icon")
	local var_141_4

	AttireConst = var_7

	if arg_141_1 == var_7.TYPE_CHAT_FRAME then
		var_141_4 = "chat_frame"
	else
		AttireConst = var_7

		if arg_141_1 == var_7.TYPE_ICON_FRAME then
			var_141_4 = "icon_frame"
		end
	end

	GetImageSpriteFromAtlasAsync = var_7

	var_7("Props/" .. var_141_4, "", var_141_3)

	setIconName = var_7

	var_7(arg_141_0, arg_141_2.name, arg_141_3)

	return
end

local var_0_195 = updateAttire

local function var_0_196(arg_142_0, arg_142_1, arg_142_2, arg_142_3)
	local var_142_0 = arg_142_2.rare

	GetImageSpriteFromAtlasAsync = var_1_10005

	local var_142_1 = "weaponframes"
	local var_142_2 = "bg" .. var_142_0

	findTF = var_9

	var_1_10005(var_142_1, var_142_2, var_9(arg_142_0, "icon_bg"))

	setFrame = var_1_10005
	findTF = var_142_1

	var_1_10005(var_142_1(arg_142_0, "icon_bg/frame"), var_142_0, "frame_battle_ui")

	findTF = var_1_10005

	local var_142_3 = var_1_10005(arg_142_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_1_10006

	var_1_10006("Props/" .. arg_142_2.display_icon, "", var_142_3)

	setIconName = var_1_10006

	var_1_10006(arg_142_0, arg_142_2.name, arg_142_3)

	return
end

local var_0_197 = updateAttireCombatUI

local function var_0_198(arg_143_0, arg_143_1, arg_143_2)
	ItemRarity = var_1_10003

	local var_143_0 = var_1_10003.Rarity2Print(arg_143_1.rarity)

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_143_1 = "weaponframes"
	local var_143_2 = "bg" .. var_143_0

	findTF = var_8

	var_1_10004(var_143_1, var_143_2, var_8(arg_143_0, "icon_bg"))

	setFrame = var_1_10004
	findTF = var_143_1

	var_1_10004(var_143_1(arg_143_0, "icon_bg/frame"), var_143_0)

	findTF = var_1_10004

	local var_143_3 = var_1_10004(arg_143_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_5

	var_5(arg_143_1.icon, "", var_143_3)

	setIconName = var_5

	var_5(arg_143_0, arg_143_1.name, arg_143_2)

	return
end

local var_0_199 = updateActivityMedal

local function var_0_200(arg_144_0, arg_144_1, arg_144_2)
	local var_144_0 = arg_144_1
	local var_144_1 = arg_144_1.getDropRarity(var_144_0)

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_144_2 = "weaponframes"
	local var_144_3 = "bg" .. var_144_1

	findTF = var_8

	var_1_10004(var_144_2, var_144_3, var_8(arg_144_0, "icon_bg"))

	setFrame = var_1_10004
	findTF = var_144_2

	var_1_10004(var_144_2(arg_144_0, "icon_bg/frame"), var_144_1)

	findTF = var_1_10004

	local var_144_4 = var_1_10004(arg_144_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_144_0

	var_144_0(arg_144_1:getIcon(), "", var_144_4)

	setIconName = var_144_0

	var_144_0(arg_144_0, arg_144_1:getName(), arg_144_2)

	setIconStars = var_144_0

	var_144_0(arg_144_0, false)

	return
end

local var_0_201 = updateCover

local function var_0_202(arg_145_0, arg_145_1, arg_145_2)
	findTF = var_1_10003

	local var_145_0 = var_1_10003(arg_145_0, "icon_bg/icon")
	local var_145_1 = "icon_emoji"

	GetImageSpriteFromAtlasAsync = var_5

	var_5("Props/" .. var_145_1, "", var_145_0)

	local var_145_2 = 4

	GetImageSpriteFromAtlasAsync = var_6

	local var_145_3 = "weaponframes"
	local var_145_4 = "bg" .. var_145_2

	findTF = var_10

	var_6(var_145_3, var_145_4, var_10(arg_145_0, "icon_bg"))

	setFrame = var_6
	findTF = var_145_3

	var_6(var_145_3(arg_145_0, "icon_bg/frame"), var_145_2)

	setIconName = var_6

	var_6(arg_145_0, arg_145_1.name, arg_145_2)

	return
end

local var_0_203 = updateEmoji

local function var_0_204(arg_146_0, arg_146_1, arg_146_2)
	arg_146_2 = arg_146_2 or {}
	EquipmentRarity = var_1_10003

	local var_146_0 = var_1_10003.Rarity2Print(arg_146_1.rarity)

	GetImageSpriteFromAtlasAsync = var_1_10004

	local var_146_1 = "weaponframes"
	local var_146_2 = "bg" .. var_146_0

	findTF = var_8

	var_1_10004(var_146_1, var_146_2, var_8(arg_146_0, "icon_bg"))

	setFrame = var_1_10004
	findTF = var_146_1

	var_1_10004(var_146_1(arg_146_0, "icon_bg/frame"), var_146_0, "frame_skin")

	findTF = var_1_10004

	local var_146_3 = var_1_10004(arg_146_0, "icon_bg/icon")

	GetImageSpriteFromAtlasAsync = var_5

	var_5("equips/" .. arg_146_1.icon, "", var_146_3)

	setIconStars = var_5

	var_5(arg_146_0, false)

	setIconName = var_5

	var_5(arg_146_0, arg_146_1.name, arg_146_2)

	setIconCount = var_5

	var_5(arg_146_0, arg_146_1.count)

	setIconColorful = var_5

	var_5(arg_146_0, arg_146_1.rarity - 1, arg_146_2)

	return
end

local var_0_205 = updateEquipmentSkin

local function var_0_206(arg_147_0, arg_147_1, arg_147_2, arg_147_3)
	local var_147_0
	local var_147_1 = {}

	if arg_147_1 then
		table = var_1_10006

		var_1_10006.insert(var_147_1, {
			text = "text_noPos_clear",
			atuoClose = true,
			onCallback = arg_147_1
		})
	end

	if arg_147_2 then
		table = var_1_10006

		var_1_10006.insert(var_147_1, {
			text = "text_noPos_buy",
			atuoClose = true,
			onCallback = arg_147_2
		})
	end

	if arg_147_3 then
		table = var_1_10006

		var_1_10006.insert(var_147_1, {
			text = "text_noPos_intensify",
			atuoClose = true,
			onCallback = arg_147_3
		})
	end

	pg = var_1_10006

	local var_147_2 = var_1_10006.MsgboxMgr.GetInstance()

	var_6.ShowMsgBox(var_147_2, {
		hideNo = true,
		hideYes = true,
		content = arg_147_0,
		custom = var_147_1
	})

	return
end

local var_0_207 = NoPosMsgBox

local function var_0_208()
	pg = var_1_10000

	local var_148_0 = var_1_10000.m02
	local var_148_1 = var_0.hasMediator

	EquipmentMediator = var_1_10003

	local var_148_2

	if var_148_1(var_148_0, var_1_10003.__cname) then
		getProxy = var_0
		ContextProxy = var_148_0
		var_148_2 = var_0(var_148_0)
		var_1_10004 = var_0.getCurrentContext(var_148_2)

		local var_148_3 = var_1.getContextByMediator

		EquipmentMediator = var_1_10005

		if var_148_3(var_1_10004, var_1_10005) and var_2.data.shipId then
			pg = var_148_2

			local var_148_4 = var_148_2.m02

			var_148_2 = var_148_2.sendNotification
			GAME = var_1_10006

			var_148_2(var_148_4, var_1_10006.REMOVE_LAYERS, {
				context = var_2
			})
		else
			pg = var_148_2

			local var_148_5 = var_148_2.m02

			var_148_2 = var_148_2.sendNotification
			EquipmentMediator = var_1_10006

			var_148_2(var_148_5, var_1_10006.BATCHDESTROY_MODE)

			return
		end
	end

	pg = var_0

	local var_148_6 = var_0.m02
	local var_148_7 = var_0.sendNotification

	GAME = var_148_2

	local var_148_8 = var_148_2.GO_SCENE

	SCENE = var_1_10004

	local var_148_9 = var_1_10004.EQUIPSCENE
	local var_148_10 = {}

	StoreHouseConst = var_1_10006
	var_148_10.warp = var_1_10006.WARP_TO_WEAPON
	StoreHouseConst = var_6
	var_148_10.mode = var_6.DESTROY

	var_148_7(var_148_6, var_148_8, var_148_9, var_148_10)

	return
end

local var_0_209 = openDestroyEquip

local function var_0_210()
	pg = var_1_10000

	local var_149_0 = var_1_10000.m02
	local var_149_1 = var_0.hasMediator

	EquipmentMediator = var_1_10003

	local var_149_2

	if var_149_1(var_149_0, var_1_10003.__cname) then
		getProxy = var_0
		ContextProxy = var_149_0
		var_149_2 = var_0(var_149_0)
		var_1_10004 = var_0.getCurrentContext(var_149_2)

		local var_149_3 = var_1.getContextByMediator

		EquipmentMediator = var_1_10005

		if var_149_3(var_1_10004, var_1_10005) and var_2.data.shipId then
			pg = var_149_2

			local var_149_4 = var_149_2.m02

			var_149_2 = var_149_2.sendNotification
			GAME = var_1_10006

			var_149_2(var_149_4, var_1_10006.REMOVE_LAYERS, {
				context = var_2
			})
		else
			pg = var_149_2

			local var_149_5 = var_149_2.m02

			var_149_2 = var_149_2.sendNotification
			EquipmentMediator = var_1_10006

			var_149_2(var_149_5, var_1_10006.SWITCH_TO_SPWEAPON_PAGE)

			return
		end
	end

	pg = var_0

	local var_149_6 = var_0.m02
	local var_149_7 = var_0.sendNotification

	GAME = var_149_2

	local var_149_8 = var_149_2.GO_SCENE

	SCENE = var_1_10004

	local var_149_9 = var_1_10004.EQUIPSCENE
	local var_149_10 = {}

	StoreHouseConst = var_1_10006
	var_149_10.warp = var_1_10006.WARP_TO_WEAPON
	StoreHouseConst = var_6
	var_149_10.mode = var_6.SPWEAPON

	var_149_7(var_149_6, var_149_8, var_149_9, var_149_10)

	return
end

local var_0_211 = OpenSpWeaponPage

local function var_0_212()
	pg = var_1_10000

	local var_150_0 = var_1_10000.m02
	local var_150_1 = var_0.sendNotification

	GAME = var_1_10003

	local var_150_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	local var_150_3 = var_1_10004.DOCKYARD
	local var_150_4 = {
		blockLock = true
	}

	DockyardScene = var_1_10006
	var_150_4.mode = var_1_10006.MODE_DESTROY
	i18n = var_6
	var_150_4.leftTopInfo = var_6("word_destroy")
	getGameset = var_6
	var_150_4.selectedMax = var_6("ship_select_limit")[1]
	ShipStatus = var_6
	var_150_4.onShip = var_6.canDestroyShip
	pg = var_6

	local var_150_5 = var_6.ShipFlagMgr.GetInstance()

	var_150_4.ignoredIds = var_6.FilterShips(var_150_5, {
		isActivityNpc = true
	})

	var_150_1(var_150_0, var_150_2, var_150_3, var_150_4)

	return
end

local var_0_213 = openDockyardClear

local function var_0_214()
	pg = var_1_10000

	local var_151_0 = var_1_10000.m02
	local var_151_1 = var_0.sendNotification

	GAME = var_1_10003

	local var_151_2 = var_1_10003.GO_SCENE

	SCENE = var_1_10004

	local var_151_3 = var_1_10004.DOCKYARD
	local var_151_4 = {}

	DockyardScene = var_1_10006
	var_151_4.mode = var_1_10006.MODE_OVERVIEW

	function var_151_4.onClick(arg_152_0, arg_152_1)
		pg = var_2_10002

		local var_152_0 = var_2_10002.m02
		local var_152_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_152_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_152_1(var_152_0, var_152_2, var_2_10006.SHIPINFO, {
			page = 3,
			shipId = arg_152_0.id,
			shipVOs = arg_152_1
		})

		return
	end

	var_151_1(var_151_0, var_151_2, var_151_3, var_151_4)

	return
end

local var_0_215 = openDockyardIntensify

local function var_0_216(arg_153_0, arg_153_1, arg_153_2)
	if arg_153_2 then
		var_1_10003 = ""
		ipairs = var_1_10004

		for iter_153_0, iter_153_1 in var_1_10004(arg_153_2) do
			Item = var_1_10009
			var_1_10009 = var_1_10009.getConfigData(iter_153_1[1])

			local var_153_0 = var_1_10003

			i18n = var_11
			var_1_10003 = var_153_0 .. var_11(iter_153_1[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", var_1_10009.name, iter_153_1[2])

			if iter_153_0 < #arg_153_2 then
				local var_153_1 = var_1_10003

				i18n = var_11
				var_1_10003 = var_153_1 .. var_11("text_noRes_info_tip_link")
			end
		end

		if var_1_10003 ~= "" then
			local var_153_2 = arg_153_0
			local var_153_3 = "\n"

			i18n = var_6
			arg_153_0 = var_153_2 .. var_153_3 .. var_6("text_noRes_tip", var_1_10003)
		end
	end

	pg = var_1_10003

	local var_153_4 = var_1_10003.MsgboxMgr.GetInstance()

	var_3.ShowMsgBox(var_153_4, {
		content = arg_153_0,
		onYes = function()
			gotoChargeScene = var_2_10000

			var_2_10000(arg_153_1, arg_153_2)

			return
		end
	})

	return
end

local var_0_217 = GoShoppingMsgBox

local function var_0_218(arg_155_0, arg_155_1, arg_155_2, arg_155_3, arg_155_4)
	pg = var_1_10005

	local var_155_0 = var_1_10005.shop_template[arg_155_0]

	assert = var_1_10006

	var_1_10006(var_155_0, "shop_template中找不到商品id：" .. arg_155_0)

	getProxy = var_1_10006
	PlayerProxy = var_8

	local var_155_1 = var_1_10006(var_8)
	local var_155_2 = var_6.getData(var_155_1)

	id2res = var_8

	local var_155_3 = var_155_2[var_8(var_155_0.resource_type)]
	local var_155_4

	if not arg_155_1.price then
		var_155_4 = var_155_0.resource_num
	end

	math = var_10

	local var_155_5 = var_10.floor(var_155_3 / var_155_4) <= 0 and 1 or var_155_5

	var_155_5 = arg_155_2 ~= nil and arg_155_2 < var_155_5 and arg_155_2 or var_155_5

	local var_155_6 = true
	local var_155_7 = 1

	if var_155_0 ~= nil and arg_155_1.id then
		print = var_13

		var_13(var_155_5 * var_155_0.num, "--", var_155_5)

		assert = var_13
		Item = var_15

		var_13(var_15.getConfigData(arg_155_1.id), "item config should be existence")

		Item = var_13

		local var_155_8 = var_13.New({
			id = arg_155_1.id
		})
		local var_155_9 = var_13.getConfig(var_155_8, "name")

		pg = var_1_10014

		local var_155_10 = var_1_10014.MsgboxMgr.GetInstance()
		local var_155_11 = var_14.ShowMsgBox
		local var_155_12 = {
			needCounter = true
		}

		MSGBOX_TYPE_SINGLE_ITEM = var_1_10018
		var_155_12.type = var_1_10018

		local var_155_13 = {}

		DROP_TYPE_ITEM = var_1_10019
		var_155_13.type = var_1_10019
		var_155_13.id = arg_155_1.id
		var_155_12.drop = var_155_13
		var_155_12.addNum = var_155_0.num
		var_155_12.maxNum = var_155_5 * var_155_0.num
		var_155_12.defaultNum = var_155_0.num

		function var_155_12.numUpdate(arg_156_0, arg_156_1)
			math = var_2_10002
			var_155_7 = var_2_10002.floor(arg_156_1 / var_155_0.num)

			local var_156_0 = var_155_7 * var_155_4

			if var_155_3 < var_156_0 then
				setText = var_3

				local var_156_1 = arg_156_0

				i18n = var_2_10006

				local var_156_2 = arg_155_3
				local var_156_3 = var_156_0
				local var_156_4 = arg_156_1

				COLOR_RED = var_2_10011

				var_3(var_156_1, var_2_10006(var_156_2, var_156_3, var_156_4, var_2_10011, var_155_9))

				var_155_6 = false
			else
				setText = var_3

				local var_156_5 = arg_156_0

				i18n = var_2_10006

				local var_156_6 = arg_155_3
				local var_156_7 = var_156_0
				local var_156_8 = arg_156_1

				COLOR_GREEN = var_2_10011

				var_3(var_156_5, var_2_10006(var_156_6, var_156_7, var_156_8, var_2_10011, var_155_9))

				var_155_6 = true
			end

			return
		end

		function var_155_12.onYes()
			if var_155_6 then
				pg = var_0

				local var_157_0 = var_0.m02
				local var_157_1 = var_0.sendNotification

				GAME = var_2_10003

				var_157_1(var_157_0, var_2_10003.SHOPPING, {
					id = arg_155_0,
					count = var_155_7
				})
			else
				local var_157_3

				if arg_155_4 then
					pg = var_157_3

					local var_157_2 = var_157_3.TipsMgr.GetInstance()

					var_157_3 = var_157_3.ShowTips
					i18n = var_2_10003

					var_157_3(var_157_2, var_2_10003(arg_155_4))

					pg = var_157_3

					local var_157_4 = var_157_3.TrackerMgr.GetInstance()

					var_157_3 = var_157_3.Tracking
					TRACKING_BUILD_OR_SKIN_FAILD = var_2_10003

					var_157_3(var_157_4, var_2_10003)
				else
					pg = var_157_3

					local var_157_5 = var_157_3.TipsMgr.GetInstance()
					local var_157_6 = var_0.ShowTips

					i18n = var_2_10003

					var_157_6(var_157_5, var_2_10003("main_playerInfoLayer_error_changeNameNoGem"))
				end
			end

			return
		end

		var_155_11(var_155_10, var_155_12)
	end

	return
end

local var_0_219 = shoppingBatch

local function var_0_220(arg_158_0, arg_158_1, arg_158_2, arg_158_3, arg_158_4)
	pg = var_1_10005

	local var_158_0 = var_1_10005.shop_template[arg_158_0]

	assert = var_1_10006

	var_1_10006(var_158_0, "shop_template中找不到商品id：" .. arg_158_0)

	getProxy = var_1_10006
	PlayerProxy = var_8

	local var_158_1 = var_1_10006(var_8)
	local var_158_2 = var_6.getData(var_158_1)

	id2res = var_8

	local var_158_3 = var_158_2[var_8(var_158_0.resource_type)]
	local var_158_4

	if not arg_158_1.price then
		var_158_4 = var_158_0.resource_num
	end

	math = var_10

	local var_158_5 = var_10.floor(var_158_3 / var_158_4) <= 0 and 1 or var_158_5

	var_158_5 = arg_158_2 ~= nil and arg_158_2 < var_158_5 and arg_158_2 or var_158_5

	local var_158_6 = true
	local var_158_7 = 1

	if var_158_0 ~= nil and arg_158_1.id then
		print = var_13

		var_13(var_158_5 * var_158_0.num, "--", var_158_5)

		assert = var_13
		Item = var_15

		var_13(var_15.getConfigData(arg_158_1.id), "item config should be existence")

		Item = var_13

		local var_158_8 = var_13.New({
			id = arg_158_1.id
		})
		local var_158_9 = var_13.getConfig(var_158_8, "name")

		pg = var_1_10014

		local var_158_10 = var_1_10014.NewStyleMsgboxMgr.GetInstance()
		local var_158_11 = var_14.Show

		pg = var_17

		local var_158_12 = var_17.NewStyleMsgboxMgr.TYPE_COMMON_SHOPPING
		local var_158_13 = {}

		Drop = var_1_10019

		local var_158_14 = var_1_10019.New
		local var_158_15 = {
			count = 1
		}

		DROP_TYPE_ITEM = var_1_10022
		var_158_15.type = var_1_10022
		var_158_15.id = arg_158_1.id
		var_158_13.drop = var_158_14(var_158_15)
		var_158_13.price = var_158_4
		var_158_13.addNum = var_158_0.num
		var_158_13.maxNum = var_158_5 * var_158_0.num
		var_158_13.defaultNum = var_158_0.num

		function var_158_13.numUpdate(arg_159_0, arg_159_1)
			math = var_2_10002
			var_158_7 = var_2_10002.floor(arg_159_1 / var_158_0.num)

			local var_159_0 = var_158_7 * var_158_4

			if var_158_3 < var_159_0 then
				setTextInNewStyleBox = var_3

				local var_159_1 = arg_159_0

				i18n = var_2_10006

				local var_159_2 = arg_158_3
				local var_159_3 = var_159_0
				local var_159_4 = arg_159_1

				COLOR_RED = var_2_10011

				var_3(var_159_1, var_2_10006(var_159_2, var_159_3, var_159_4, var_2_10011, var_158_9))

				var_158_6 = false
			else
				setTextInNewStyleBox = var_3

				local var_159_5 = arg_159_0

				i18n = var_2_10006

				var_3(var_159_5, var_2_10006(arg_158_3, var_159_0, arg_159_1, "#238C40FF", var_158_9))

				var_158_6 = true
			end

			return
		end

		local var_158_16 = {}
		local var_158_17 = {}

		pg = var_158_15
		var_158_17.type = var_158_15.NewStyleMsgboxMgr.BUTTON_TYPE.shopping
		i18n = var_21
		var_158_17.name = var_21("word_buy")

		function var_158_17.func()
			if var_158_6 then
				pg = var_0

				local var_160_0 = var_0.m02
				local var_160_1 = var_0.sendNotification

				GAME = var_2_10003

				var_160_1(var_160_0, var_2_10003.SHOPPING, {
					id = arg_158_0,
					count = var_158_7
				})
			else
				local var_160_3

				if arg_158_4 then
					pg = var_160_3

					local var_160_2 = var_160_3.TipsMgr.GetInstance()

					var_160_3 = var_160_3.ShowTips
					i18n = var_2_10003

					var_160_3(var_160_2, var_2_10003(arg_158_4))
				else
					pg = var_160_3

					local var_160_4 = var_160_3.TipsMgr.GetInstance()
					local var_160_5 = var_0.ShowTips

					i18n = var_2_10003

					var_160_5(var_160_4, var_2_10003("main_playerInfoLayer_error_changeNameNoGem"))
				end
			end

			return
		end

		SFX_CONFIRM = var_21
		var_158_17.sound = var_21
		var_158_16[1] = var_158_17
		var_158_13.btnList = var_158_16

		var_158_11(var_158_10, var_158_12, var_158_13)
	end

	return
end

local var_0_221 = shoppingBatchNewStyle

local function var_0_222(arg_161_0, arg_161_1)
	getProxy = var_1_10002
	ContextProxy = var_1_10004

	local var_161_0 = var_1_10002(var_1_10004)

	getProxy = var_1_10003
	ContextProxy = var_1_10005

	local var_161_1 = var_1_10003(var_1_10005)
	local var_161_2 = var_3.getCurrentContext(var_161_1)

	instanceof = var_1_10004

	local var_161_3 = var_161_2.mediator

	NewShopMainMediator = var_1_10007

	local var_161_7

	if var_1_10004(var_161_3, var_1_10007) then
		local var_161_4 = var_161_2.mediator
		local var_161_5 = var_161_7.getViewComponent(var_161_4)

		var_161_7.switchSubViewByTogger(var_161_5, arg_161_0)
	else
		pg = var_161_7

		local var_161_6 = var_161_7.m02

		var_161_7 = var_161_7.sendNotification
		GAME = var_1_10007
		var_1_10007 = var_1_10007.GO_SCENE
		SCENE = var_1_10008

		local var_161_8 = var_1_10008.CHARGE
		local var_161_9 = {}

		if not arg_161_0 then
			::label_161_0::

			ChargeScene = var_1_10010
			var_1_10010 = var_1_10010.TYPE_ITEM
		end

		var_161_9.wrap = var_1_10010
		var_161_9.noRes = arg_161_1

		var_161_7(var_161_6, var_1_10007, var_161_8, var_161_9)
	end

	pg = var_161_7

	local var_161_10 = var_161_7.TrackerMgr.GetInstance()
	local var_161_11 = var_4.Tracking

	TRACKING_BUILD_OR_SKIN_FAILD = var_1_10007

	var_161_11(var_161_10, var_1_10007)

	return
end

local var_0_223 = gotoChargeScene

local function var_0_224(arg_162_0)
	findTF = var_1_10001

	local var_162_0 = var_1_10001(arg_162_0, "icon_bg")

	findTF = var_1_10002

	local var_162_1 = var_1_10002(arg_162_0, "icon_bg/frame")

	findTF = var_3

	local var_162_2 = var_3(arg_162_0, "icon_bg/icon")

	findTF = var_4

	local var_162_3 = var_4(arg_162_0, "icon_bg/icon/icon")

	clearImageSprite = var_5

	var_5(var_162_0)

	clearImageSprite = var_5

	var_5(var_162_1)

	clearImageSprite = var_5

	var_5(var_162_2)

	if var_162_3 then
		clearImageSprite = var_5

		var_5(var_162_3)
	end

	return
end

local var_0_225 = clearDrop
local var_0_226 = {}

Color = var_0_10010
var_0_226.red = var_0_10010.New(1, 0.25, 0.25)
Color = var_10
var_0_226.blue = var_10.New(0.11, 0.55, 0.64)
Color = var_10
var_0_226.yellow = var_10.New(0.92, 0.52, 0)

local function var_0_227(arg_163_0, arg_163_1, arg_163_2, arg_163_3)
	findTF = var_1_10004

	local var_163_0 = var_1_10004(arg_163_0, "skill")

	findTF = var_1_10005

	local var_163_1 = var_1_10005(arg_163_0, "lock")

	findTF = var_6

	local var_163_2 = var_6(arg_163_0, "unknown")
	local var_163_4

	if arg_163_1 then
		setActive = var_163_4

		var_163_4(var_163_0, true)

		setActive = var_163_4

		var_163_4(var_163_2, false)

		setActive = var_163_4

		var_163_4(var_163_1, not arg_163_2)

		LoadImageSpriteAsync = var_163_4

		local var_163_3 = "skillicon/" .. arg_163_1.icon

		findTF = var_10

		var_163_4(var_163_3, var_10(var_163_0, "icon"))

		if not arg_163_1.color then
			var_163_4 = "blue"
		end

		setText = var_8
		findTF = var_10

		local var_163_5 = var_10(var_163_0, "name")

		shortenString = var_1_10011
		getSkillName = var_13

		var_8(var_163_5, var_1_10011(var_13(arg_163_1.id), arg_163_3 or 8))

		findTF = var_8

		local var_163_6 = var_8(var_163_0, "level")

		setText = var_163_3

		local var_163_7 = var_163_6
		local var_163_8 = "LEVEL: "
		local var_163_9

		if not arg_163_2 or not arg_163_2.level then
			var_163_9 = "??"
		end

		var_163_3(var_163_7, var_163_8 .. var_163_9)

		setTextColor = var_163_3

		var_163_3(var_163_6, var_0_226[var_163_4])
	else
		setActive = var_163_4

		var_163_4(var_163_0, false)

		setActive = var_163_4

		var_163_4(var_163_2, true)

		setActive = var_163_4

		var_163_4(var_163_1, false)
	end

	return
end

local var_0_228 = updateSkill
local var_0_229 = true

local function var_0_230(arg_164_0, arg_164_1, arg_164_2, arg_164_3)
	GetOrAddComponent = var_1_10004

	local var_164_0 = var_1_10004(arg_164_1, "UILongPressTrigger")

	assert = var_1_10005

	var_1_10005(arg_164_2, "callback should exist")

	defaultValue = var_1_10005
	var_164_0.longPressThreshold = var_1_10005(arg_164_3, 1)

	local function var_164_1(arg_165_0)
		return function()
			if var_0_229 then
				pg = var_0

				local var_166_0 = var_0.CriMgr.GetInstance()
				local var_166_1 = var_0.PlaySoundEffect_V3

				SOUND_BACK = var_3_10003

				var_166_1(var_166_0, var_3_10003)
			end

			local var_166_2, var_166_3 = arg_164_2()

			if var_166_2 then
				arg_165_0(var_166_3)
			end

			return
		end
	end

	local var_164_2 = var_164_0.onReleased

	pg = var_7

	var_7.DelegateInfo.Add(arg_164_0, var_164_2)
	var_164_2:RemoveAllListeners()
	var_164_2:AddListener(var_164_1(function(arg_167_0)
		local var_167_0 = arg_167_0
		local var_167_1 = arg_167_0.emit

		BaseUI = var_2_10004

		var_167_1(var_167_0, var_2_10004.ON_BACK)

		return
	end))

	local var_164_3 = var_164_0.onLongPressed

	pg = var_8

	var_8.DelegateInfo.Add(arg_164_0, var_164_3)
	var_164_3:RemoveAllListeners()
	var_164_3:AddListener(var_164_1(function(arg_168_0)
		local var_168_0 = arg_168_0
		local var_168_1 = arg_168_0.emit

		BaseUI = var_2_10004

		var_168_1(var_168_0, var_2_10004.ON_HOME)

		return
	end))

	return
end

local var_0_231 = onBackButton

local function var_0_232()
	pg = var_1_10000

	local var_169_0 = var_1_10000.TimeMgr.GetInstance()

	return var_0.GetNextTime(var_169_0, 0, 0, 0)
end

local var_0_233 = GetZeroTime

local function var_0_234()
	pg = var_1_10000

	local var_170_0 = var_1_10000.TimeMgr.GetInstance()

	return var_0.GetNextTime(var_170_0, 0, 0, 0, 1800)
end

local var_0_235 = GetHalfHour

local function var_0_236(arg_171_0)
	pg = var_1_10001

	local var_171_0 = var_1_10001.TimeMgr.GetInstance()
	local var_171_1 = var_1.GetServerTime(var_171_0)

	pg = var_1_10002

	local var_171_2 = var_1_10002.TimeMgr.GetInstance()
	local var_171_3, var_171_4 = var_2.parseTimeFrom(var_171_2, var_171_1)

	return var_171_3 * 0 + (var_171_4 + arg_171_0) * 16
end

local var_0_237 = GetNextHour

local function var_0_238(arg_172_0, arg_172_1)
	local function var_172_0(arg_173_0)
		if not arg_173_0 then
			return 0, 1
		elseif arg_173_0 > 240 then
			return 4, 1
		elseif arg_173_0 > 225 then
			return 3, 1
		elseif arg_173_0 > 192 then
			return 2, 1
		elseif arg_173_0 < 126 then
			local var_173_0 = 1
			local var_173_1

			if not arg_172_1 then
				var_173_1 = 0.5
			end

			return var_173_0, var_173_1
		else
			return 1, 1
		end

		return
	end

	type = var_1_10003

	if var_1_10003(arg_172_0) == "number" then
		return var_172_0(arg_172_0)
	end

	local var_172_1 = 1
	local var_172_2 = 0
	local var_172_3 = 0
	local var_172_4 = #arg_172_0

	while var_172_1 <= var_172_4 do
		string = var_1_10007
		var_1_10007 = var_1_10007.byte(arg_172_0, var_172_1)

		local var_172_5, var_172_6 = var_172_0(var_1_10007)

		var_172_1 = var_172_1 + var_172_5
		var_172_2 = var_172_2 + var_172_6
	end

	return var_172_2
end

local var_0_239 = GetPerceptualSize

local function var_0_240(arg_174_0, arg_174_1, arg_174_2)
	local var_174_0 = 1
	local var_174_1 = 0
	local var_174_2 = 0
	local var_174_3 = #arg_174_0

	while var_174_0 <= var_174_3 do
		string = var_1_10007
		var_1_10007 = var_1_10007.byte(arg_174_0, var_174_0)
		GetPerceptualSize = var_1_10008

		local var_174_4

		var_1_10008, var_174_4 = var_1_10008(var_1_10007, arg_174_2)
		var_174_0 = var_174_0 + var_1_10008
		var_174_1 = var_174_1 + var_174_4
		math = var_10

		if arg_174_1 <= var_10.ceil(var_174_1) then
			var_174_2 = var_174_0

			break
		end
	end

	if var_174_2 == 0 or var_174_3 < var_174_2 then
		return arg_174_0
	end

	string = var_1_10007

	return var_1_10007.sub(arg_174_0, 1, var_174_2 - 1) .. ".."
end

local var_0_241 = shortenString

local function var_0_242(arg_175_0, arg_175_1)
	local var_175_0 = 1
	local var_175_1 = 0
	local var_175_2 = 0
	local var_175_3 = #arg_175_0

	while var_175_0 <= var_175_3 do
		string = var_1_10006
		var_1_10006 = var_1_10006.byte(arg_175_0, var_175_0)
		GetPerceptualSize = var_1_10007

		local var_175_4

		var_1_10007, var_175_4 = var_1_10007(var_1_10006)
		var_175_0 = var_175_0 + var_1_10007
		var_175_1 = var_175_1 + var_175_4
		math = var_9

		if arg_175_1 <= var_9.ceil(var_175_1) then
			var_175_2 = var_175_0

			break
		end
	end

	if var_175_2 == 0 or var_175_3 < var_175_2 then
		return false
	end

	return true
end

local var_0_243 = shouldShortenString

local function var_0_244(arg_176_0, arg_176_1, arg_176_2, arg_176_3)
	local var_176_0 = true

	utf8_to_unicode = var_1_10005

	local var_176_1, var_176_2 = var_1_10005(arg_176_0)

	filterEgyUnicode = var_7
	filterSpecChars = var_1_10009

	local var_176_3 = var_7(var_1_10009(arg_176_0))

	wordVer = var_1_10008

	local var_176_4 = var_1_10008(arg_176_0)

	checkSpaceValid = var_9

	if not var_9(arg_176_0) then
		pg = var_9

		local var_176_5 = var_9.TipsMgr.GetInstance()
		local var_176_6 = var_9.ShowTips

		i18n = var_1_10012

		var_176_6(var_176_5, var_1_10012(arg_176_3[1]))

		var_176_0 = false
	else
		local var_176_8

		if 0 < var_176_4 or var_176_3 ~= arg_176_0 then
			pg = var_176_8

			local var_176_7 = var_176_8.TipsMgr.GetInstance()

			var_176_8 = var_176_8.ShowTips
			i18n = var_1_10012

			var_176_8(var_176_7, var_1_10012(arg_176_3[4]))

			var_176_0 = false
		elseif var_176_2 < arg_176_1 then
			pg = var_176_8

			local var_176_9 = var_176_8.TipsMgr.GetInstance()

			var_176_8 = var_176_8.ShowTips
			i18n = var_1_10012

			var_176_8(var_176_9, var_1_10012(arg_176_3[2]))

			var_176_0 = false
		elseif arg_176_2 < var_176_2 then
			pg = var_176_8

			local var_176_10 = var_176_8.TipsMgr.GetInstance()
			local var_176_11 = var_9.ShowTips

			i18n = var_1_10012

			var_176_11(var_176_10, var_1_10012(arg_176_3[3]))

			var_176_0 = false
		end
	end

	return var_176_0
end

local var_0_245 = nameValidityCheck

local function var_0_246(arg_177_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_US = var_1_10002

	if var_1_10001 == var_1_10002 then
		return true
	end

	string = var_1_10001

	local var_177_0 = var_1_10001.gsub(arg_177_0, " ", "")

	string = var_1_10002

	return arg_177_0 == var_1_10002.gsub(var_177_0, "　", "")
end

local var_0_247 = checkSpaceValid

local function var_0_248(arg_178_0)
	local var_178_0 = {}
	local var_178_1 = 0
	local var_178_2 = 0
	local var_178_3 = 0
	local var_178_4 = 1

	while var_178_4 <= #arg_178_0 do
		string = var_6

		if not var_6.byte(arg_178_0, var_178_4) then
			break
		end

		if 48 <= var_6 and var_6 <= 57 or 65 <= var_6 and var_6 <= 90 or var_6 == 95 or 97 <= var_6 and var_6 <= 122 then
			table = var_7

			local var_178_5 = var_7.insert
			local var_178_6 = var_178_0

			string = var_1_10010

			var_178_5(var_178_6, var_1_10010.char(var_6))
		else
			local var_178_7, var_178_8

			if 228 <= var_6 and var_6 <= 233 then
				string = var_178_7
				var_178_7 = var_178_7.byte(arg_178_0, var_178_4 + 1)
				string = var_178_8
				var_178_8 = var_178_8.byte(arg_178_0, var_178_4 + 2)

				if var_178_7 and var_178_8 and var_178_7 >= 128 and var_178_7 <= 191 and var_178_8 >= 128 and var_178_8 <= 191 then
					var_178_4 = var_178_4 + 2
					table = var_9

					local var_178_9 = var_9.insert

					var_1_10011 = var_178_0
					string = var_1_10012

					var_178_9(var_1_10011, var_1_10012.char(var_6, var_178_7, var_178_8))

					var_178_1 = var_178_1 + 1
				end
			elseif var_6 == 45 or var_6 == 40 or var_6 == 41 then
				table = var_178_7
				var_178_7 = var_178_7.insert

				local var_178_10 = var_178_0

				string = var_1_10010

				var_178_7(var_178_10, var_1_10010.char(var_6))
			elseif var_6 == 194 then
				string = var_178_7

				if var_178_7.byte(arg_178_0, var_178_4 + 1) == 183 then
					var_178_4 = var_178_4 + 1
					table = var_178_8
					var_178_8 = var_178_8.insert
					var_1_10010 = var_178_0
					string = var_1_10011

					var_178_8(var_1_10010, var_1_10011.char(var_6, var_178_7))

					var_178_1 = var_178_1 + 1
				end
			elseif var_6 == 239 then
				string = var_178_7
				var_178_7 = var_178_7.byte(arg_178_0, var_178_4 + 1)
				string = var_178_8
				var_178_8 = var_178_8.byte(arg_178_0, var_178_4 + 2)

				if var_178_7 == 188 and (var_178_8 == 8 or var_178_8 == 9) then
					var_178_4 = var_178_4 + 2
					table = var_9

					local var_178_11 = var_9.insert

					var_1_10011 = var_178_0
					string = var_1_10012

					var_178_11(var_1_10011, var_1_10012.char(var_6, var_178_7, var_178_8))

					var_178_1 = var_178_1 + 1
				end
			elseif var_6 == 206 or var_6 == 207 then
				string = var_178_7
				var_178_7 = var_178_7.byte(arg_178_0, var_178_4 + 1)

				if var_6 == 206 and 177 <= var_178_7 or var_6 == 207 and var_178_7 <= 134 then
					var_178_4 = var_178_4 + 1
					table = var_178_8
					var_178_8 = var_178_8.insert
					var_1_10010 = var_178_0
					string = var_1_10011

					var_178_8(var_1_10010, var_1_10011.char(var_6, var_178_7))

					var_178_1 = var_178_1 + 1
				end
			else
				if var_6 == 227 then
					PLATFORM_CODE = var_178_7
					PLATFORM_JP = var_178_8

					if var_178_7 == var_178_8 then
						string = var_178_7

						local var_178_12 = var_178_7.byte(arg_178_0, var_178_4 + 1)

						string = var_178_8
						var_178_8 = var_178_8.byte(arg_178_0, var_178_4 + 2)

						if var_178_12 and var_178_8 and var_178_12 > 128 and var_178_12 <= 191 and var_178_8 >= 128 and var_178_8 <= 191 then
							var_178_4 = var_178_4 + 2
							table = var_9

							local var_178_13 = var_9.insert

							var_1_10011 = var_178_0
							string = var_1_10012

							var_178_13(var_1_10011, var_1_10012.char(var_6, var_178_12, var_178_8))

							var_178_2 = var_178_2 + 1
						end

						goto label_178_0
					end
				end

				local var_178_14

				if 224 <= var_6 then
					PLATFORM_CODE = var_178_14
					PLATFORM_KR = var_178_8

					if var_178_14 == var_178_8 then
						string = var_178_14
						var_178_14 = var_178_14.byte(arg_178_0, var_178_4 + 1)
						string = var_178_8
						var_178_8 = var_178_8.byte(arg_178_0, var_178_4 + 2)

						if var_178_14 and var_178_8 and var_178_14 >= 128 and var_178_14 <= 191 and var_178_8 >= 128 and var_178_8 <= 191 then
							var_178_4 = var_178_4 + 2
							table = var_9

							local var_178_15 = var_9.insert

							var_1_10011 = var_178_0
							string = var_1_10012

							var_178_15(var_1_10011, var_1_10012.char(var_6, var_178_14, var_178_8))

							var_178_3 = var_178_3 + 1
						end

						goto label_178_0
					end
				end

				PLATFORM_CODE = var_178_14
				PLATFORM_US = var_178_8

				if var_178_14 == var_178_8 then
					if var_178_4 ~= 1 and var_6 == 32 then
						string = var_178_14

						if var_178_14.byte(arg_178_0, var_178_4 + 1) ~= 32 then
							table = var_178_8

							local var_178_16 = var_178_8.insert

							var_1_10010 = var_178_0
							string = var_1_10011

							var_178_16(var_1_10010, var_1_10011.char(var_6))
						end
					end

					if var_6 >= 192 and var_6 <= 223 then
						string = var_7

						local var_178_17 = var_7.byte(arg_178_0, var_178_4 + 1)

						var_178_4 = var_178_4 + 1

						if var_6 == 194 and var_178_17 and 128 <= var_178_17 then
							table = var_8

							local var_178_18 = var_8.insert

							var_1_10010 = var_178_0
							string = var_1_10011

							var_178_18(var_1_10010, var_1_10011.char(var_6, var_178_17))
						elseif var_6 == 195 and var_178_17 and var_178_17 <= 191 then
							table = var_8

							local var_178_19 = var_8.insert

							var_1_10010 = var_178_0
							string = var_1_10011

							var_178_19(var_1_10010, var_1_10011.char(var_6, var_178_17))
						end
					end
				end
			end
		end

		::label_178_0::

		var_178_4 = var_178_4 + 1
	end

	table = var_6

	return var_6.concat(var_178_0), var_178_1 + var_178_2 + var_178_3
end

local var_0_249 = filterSpecChars

local function var_0_250(arg_179_0)
	string = var_1_10001
	arg_179_0 = var_1_10001.gsub(arg_179_0, "�[�-�][�-�]", "")
	string = var_1

	return (var_1.gsub(arg_179_0, "�[�-�]", ""))
end

local var_0_251 = filterEgyUnicode

local function var_0_252(arg_180_0, arg_180_1, arg_180_2, arg_180_3, arg_180_4, arg_180_5, arg_180_6, arg_180_7, arg_180_8)
	arg_180_3 = arg_180_3 or 0.2

	if arg_180_5 then
		LeanTween = var_1_10009
		var_1_10009 = var_1_10009.cancel
		go = var_1_10011

		var_1_10009(var_1_10011(arg_180_0))
	end

	rtf = var_1_10009

	local var_180_0 = var_1_10009(arg_180_0)

	arg_180_1 = arg_180_1 or var_180_0.anchoredPosition.x
	arg_180_2 = arg_180_2 or var_180_0.anchoredPosition.y
	LeanTween = var_1_10010

	local var_180_1 = var_1_10010.move
	local var_180_2 = var_180_0

	Vector3 = var_1_10013

	local var_180_3 = var_180_1(var_180_2, var_1_10013(arg_180_1, arg_180_2, 0), arg_180_3)

	if not arg_180_7 then
		LeanTweenType = var_11
		arg_180_7 = var_11.easeInOutSine
	end

	var_180_3:setEase(arg_180_7)

	if arg_180_4 then
		var_180_3:setDelay(arg_180_4)
	end

	if arg_180_6 then
		GetOrAddComponent = var_11
		var_11(arg_180_0, "CanvasGroup").blocksRaycasts = false
	end

	local var_180_4 = var_180_3
	local var_180_5 = var_180_3.setOnComplete

	System = var_14

	var_180_5(var_180_4, var_14.Action(function()
		if arg_180_8 then
			arg_180_8()
		end

		if arg_180_6 then
			GetOrAddComponent = var_0
			var_0(arg_180_0, "CanvasGroup").blocksRaycasts = true
		end

		return
	end))

	return var_180_3
end

local var_0_253 = shiftPanel

local function var_0_254(arg_182_0, arg_182_1, arg_182_2, arg_182_3, arg_182_4, arg_182_5, arg_182_6, arg_182_7)
	LeanTween = var_1_10008

	local var_182_0 = var_1_10008.value

	go = var_1_10010

	local var_182_1 = var_182_0(var_1_10010(arg_182_0), arg_182_1, arg_182_2, arg_182_3)
	local var_182_2 = var_8.setOnUpdate

	System = var_11

	local var_182_3 = var_182_2(var_182_1, var_11.Action_float(function(arg_183_0)
		if arg_182_5 then
			arg_182_5(arg_183_0)
		end

		return
	end))
	local var_182_4 = var_8.setOnComplete

	System = var_11

	local var_182_5 = var_182_4(var_182_3, var_11.Action(function()
		if arg_182_6 then
			arg_182_6()
		end

		return
	end))
	local var_182_6 = var_8.setDelay(var_182_5, arg_182_4 or 0)

	if arg_182_7 and arg_182_7 > 0 then
		var_182_6:setRepeat(arg_182_7)
	end

	return var_182_6
end

local var_0_255 = TweenValue

local function var_0_256(arg_185_0, arg_185_1, arg_185_2)
	LeanTween = var_1_10003

	local var_185_0 = var_1_10003.rotate

	rtf = var_1_10005

	local var_185_1 = var_185_0(var_1_10005(arg_185_0), 360 * arg_185_1, arg_185_2)

	return var_3.setLoopClamp(var_185_1)
end

local var_0_257 = rotateAni

local function var_0_258(arg_186_0, arg_186_1, arg_186_2, arg_186_3)
	LeanTween = var_1_10004

	local var_186_0 = var_1_10004.alpha

	rtf = var_1_10006

	local var_186_1 = var_186_0(var_1_10006(arg_186_0), arg_186_3 or 0, arg_186_1)
	local var_186_2 = var_4.setEase

	LeanTweenType = var_7

	local var_186_3 = var_186_2(var_186_1, var_7.easeInOutSine)

	return var_4.setLoopPingPong(var_186_3, arg_186_2 or 0)
end

local var_0_259 = blinkAni

local function var_0_260(arg_187_0, arg_187_1, arg_187_2, arg_187_3)
	LeanTween = var_1_10004

	local var_187_0 = var_1_10004.scale

	rtf = var_1_10006

	local var_187_1 = var_187_0(var_1_10006(arg_187_0), arg_187_3 or 0, arg_187_1)

	return var_4.setLoopPingPong(var_187_1, arg_187_2 or 0)
end

local var_0_261 = scaleAni

local function var_0_262(arg_188_0, arg_188_1, arg_188_2, arg_188_3)
	local var_188_0 = arg_188_0.localPosition.y + arg_188_1

	LeanTween = var_1_10005

	local var_188_1 = var_1_10005.moveY

	rtf = var_1_10007

	local var_188_2 = var_188_1(var_1_10007(arg_188_0), var_188_0, arg_188_2)

	return var_5.setLoopPingPong(var_188_2, arg_188_3 or 0)
end

tostring = floatAni

local function var_0_263(arg_189_0)
	if arg_189_0 == nil then
		return "nil"
	end

	if var_0(arg_189_0) == nil then
		type = var_1_10002

		if var_1_10002(arg_189_0) == "table" then
			return "{}"
		end

		return " ~nil"
	end

	return var_1
end

local var_0_264 = tostring

local function var_0_265(arg_190_0, arg_190_1)
	local var_190_0 = arg_190_0.match
	local var_190_1 = arg_190_0

	ChatConst = var_1_10005

	if var_190_0(var_190_1, var_1_10005.EmojiCodeMatch) then
		return 0, arg_190_0
	end

	arg_190_1 = arg_190_1 or {}
	filterEgyUnicode = var_2

	if #var_2(arg_190_0) ~= #arg_190_0 then
		if arg_190_1.isReplace then
			arg_190_0 = var_2
		else
			return 1
		end
	end

	wordSplit = var_3

	local var_190_2 = var_3(arg_190_0)

	pg = var_4

	local var_190_3 = var_4.word_template

	pg = var_5

	local var_190_4 = var_5.word_legal_template
	local var_190_5

	if not arg_190_1.isReplace then
		var_190_5 = false
	end

	arg_190_1.isReplace = var_190_5

	local var_190_6

	if not arg_190_1.replaceWord then
		var_190_6 = "*"
	end

	arg_190_1.replaceWord = var_190_6

	local var_190_7 = #var_190_2
	local var_190_8 = 1
	local var_190_9 = ""
	local var_190_10 = 0

	while var_190_8 <= var_190_7 do
		wordLegalMatch = var_1_10010

		local var_190_11, var_190_12

		var_1_10010, var_190_11, var_190_12 = var_1_10010(var_190_2, var_190_4, var_190_8)

		if var_1_10010 then
			var_190_8 = var_190_11
			var_190_9 = var_190_9 .. var_190_12
		else
			wordVerMatch = var_13

			local var_190_13, var_190_14, var_190_15 = var_13(var_190_2, var_190_3, arg_190_1, var_190_8, "", false, var_190_8, "")

			if var_190_13 then
				var_190_8 = var_190_14
				var_190_10 = var_190_10 + 1

				if arg_190_1.isReplace then
					var_190_9 = var_190_9 .. var_190_15
				end
			else
				if arg_190_1.isReplace then
					var_190_9 = var_190_9 .. var_190_2[var_190_8]
				end

				var_190_8 = var_190_8 + 1
			end
		end
	end

	if arg_190_1.isReplace then
		return var_190_10, var_190_9
	else
		return var_190_10
	end

	return
end

local var_0_266 = wordVer

local function var_0_267(arg_191_0, arg_191_1, arg_191_2, arg_191_3, arg_191_4)
	if arg_191_2 > #arg_191_0 then
		return arg_191_3, arg_191_2, arg_191_4
	end

	local var_191_0 = arg_191_1[arg_191_0[arg_191_2]]

	arg_191_4 = arg_191_4 == nil and "" or arg_191_4

	if var_191_0 then
		if var_191_0.this then
			wordLegalMatch = var_7

			return var_7(arg_191_0, var_191_0, arg_191_2 + 1, true, arg_191_4 .. var_5)
		else
			wordLegalMatch = var_7

			return var_7(arg_191_0, var_191_0, arg_191_2 + 1, false, arg_191_4 .. var_5)
		end
	else
		return arg_191_3, arg_191_2, arg_191_4
	end

	return
end

string = wordLegalMatch

local var_0_268 = var_12.byte("a")

string = var_13

local var_0_269 = var_13.byte("z")

string = var_14

local var_0_270 = var_14.byte("A")

string = var_15

local var_0_271 = var_15.byte("Z")

local function var_0_272(arg_192_0)
	if not arg_192_0 then
		return arg_192_0
	end

	string = var_1_10001

	if var_1_10001.byte(arg_192_0) > 128 then
		return
	end

	if var_1 >= var_0_268 and var_1 <= var_0_269 then
		string = var_2

		return var_2.char(var_1 - 32)
	elseif var_1 >= var_0_270 and var_1 <= var_0_271 then
		string = var_2

		return var_2.char(var_1 + 32)
	else
		return arg_192_0
	end

	return
end

local function var_0_273(arg_193_0, arg_193_1, arg_193_2, arg_193_3, arg_193_4, arg_193_5, arg_193_6, arg_193_7)
	if arg_193_3 > #arg_193_0 then
		return arg_193_5, arg_193_6, arg_193_7
	end

	if arg_193_1[arg_193_0[arg_193_3]] then
		wordVerMatch = var_1_10010

		local var_193_0 = arg_193_0
		local var_193_1 = var_9
		local var_193_2 = arg_193_2
		local var_193_3 = arg_193_3 + 1
		local var_193_4

		if not arg_193_2.isReplace or not (arg_193_4 .. arg_193_2.replaceWord) then
			var_193_4 = arg_193_4
		end

		local var_193_5

		if not var_9.this then
			var_193_5 = arg_193_5
		end

		local var_193_6

		if not var_9.this or not (arg_193_3 + 1) then
			var_193_6 = arg_193_6
		end

		local var_193_7

		if not var_9.this or (not arg_193_2.isReplace or not (arg_193_4 .. arg_193_2.replaceWord)) and not arg_193_4 then
			::label_193_0::

			var_193_7 = arg_193_7
		end

		local var_193_8, var_193_9

		var_193_8, var_1_10011, var_193_9 = var_1_10010(var_193_0, var_193_1, var_193_2, var_193_3, var_193_4, var_193_5, var_193_6, var_193_7)

		if var_193_8 then
			return var_193_8, var_1_10011, var_193_9
		end
	end

	local var_193_10 = arg_193_1[var_0_272(var_8)]

	if var_10 ~= var_8 and var_193_10 then
		wordVerMatch = var_1_10011

		local var_193_11 = arg_193_0
		local var_193_12 = var_193_10
		local var_193_13 = arg_193_2
		local var_193_14 = arg_193_3 + 1
		local var_193_15

		if not arg_193_2.isReplace or not (arg_193_4 .. arg_193_2.replaceWord) then
			var_193_15 = arg_193_4
		end

		local var_193_16

		if not var_193_10.this then
			var_193_16 = arg_193_5
		end

		local var_193_17

		if not var_193_10.this or not (arg_193_3 + 1) then
			var_193_17 = arg_193_6
		end

		local var_193_18

		if not var_193_10.this or (not arg_193_2.isReplace or not (arg_193_4 .. arg_193_2.replaceWord)) and not arg_193_4 then
			::label_193_1::

			var_193_18 = arg_193_7
		end

		local var_193_19, var_193_20, var_193_21 = var_1_10011(var_193_11, var_193_12, var_193_13, var_193_14, var_193_15, var_193_16, var_193_17, var_193_18)

		if var_193_19 then
			return var_193_19, var_193_20, var_193_21
		end
	end

	return arg_193_5, arg_193_6, arg_193_7
end

local var_0_274 = wordVerMatch

local function var_0_275(arg_194_0)
	local var_194_0 = {}

	for iter_194_0 in arg_194_0.gmatch(arg_194_0, "[\x01-\x7F�-�][�-�]*") do
		var_194_0[#var_194_0 + 1] = iter_194_0
	end

	return var_194_0
end

local var_0_276 = wordSplit

local function var_0_277(arg_195_0, arg_195_1, arg_195_2)
	LuaHelper = var_1_10003

	return #var_1_10003.WrapContent(arg_195_0, arg_195_1, arg_195_2) ~= #arg_195_0, var_3
end

local var_0_278 = contentWrap

local function var_0_279(arg_196_0)
	local var_196_0

	for iter_196_0 = 1, 20 do
		string = var_1_10006

		local var_196_1

		var_1_10006, var_196_1 = var_1_10006.gsub(arg_196_0, "<([^>]*)>", "%1")

		local var_196_2 = var_196_1

		arg_196_0 = var_1_10006

		if var_196_2 <= 0 then
			break
		end
	end

	return arg_196_0
end

local var_0_280 = cancelRich

local function var_0_281(arg_197_0)
	local var_197_0

	for iter_197_0 = 1, 20 do
		string = var_1_10006

		local var_197_1

		var_1_10006, var_197_1 = var_1_10006.gsub(arg_197_0, "<color=#[a-zA-Z0-9]+>(.-)</color>", "%1")

		local var_197_2 = var_197_1

		arg_197_0 = var_1_10006

		if var_197_2 <= 0 then
			break
		end
	end

	return arg_197_0
end

local var_0_282 = cancelColorRich

local function var_0_283(arg_198_0)
	pg = var_1_10001

	if not var_1_10001.buffCfg["buff_" .. arg_198_0] then
		return
	end

	Clone = var_2

	local var_198_0 = var_2(var_1)

	getSkillName = var_3
	var_198_0.name = var_3(arg_198_0)
	HXSet = var_3
	var_198_0.desc = var_3.hxLan(var_198_0.desc)
	HXSet = var_3
	var_198_0.desc_get = var_3.hxLan(var_198_0.desc_get)
	_ = var_3

	var_3.each(var_198_0, function(arg_199_0)
		HXSet = var_2_10001
		arg_199_0.desc = var_2_10001.hxLan(arg_199_0.desc)

		return
	end)

	return var_198_0
end

local var_0_284 = getSkillConfig

local function var_0_285(arg_200_0)
	pg = var_1_10001

	local var_200_0

	if not var_1_10001.skill_data_template[arg_200_0] then
		pg = var_200_0
		var_200_0 = var_200_0.skill_data_display[arg_200_0]
	end

	if var_200_0 then
		HXSet = var_1_10002

		return var_1_10002.hxLan(var_200_0.name)
	else
		return ""
	end

	return
end

local var_0_286 = getSkillName

local function var_0_287(arg_201_0, arg_201_1)
	if arg_201_1 then
		pg = var_1_10002

		if var_1_10002.skill_world_display[arg_201_0] then
			setmetatable = var_1_10002

			if not var_1_10002({}, {
				__index = function(arg_202_0, arg_202_1)
					pg = var_2_10002

					local var_202_0

					if not var_2_10002.skill_world_display[arg_201_0][arg_202_1] then
						pg = var_202_0
						var_202_0 = var_202_0.skill_data_template[arg_201_0][arg_202_1]
					end

					return var_202_0
				end
			}) then
				pg = var_1_10002
				var_1_10002 = var_1_10002.skill_data_template[arg_201_0]
			end

			if not var_1_10002 then
				return ""
			end

			local var_201_0

			if var_1_10002.desc_get == "" or not var_1_10002.desc_get then
				var_201_0 = var_1_10002.desc
			end

			pairs = var_1_10004

			for iter_201_0, iter_201_1 in var_1_10004(var_1_10002.desc_get_add) do
				setColorStr = var_1_10009

				local var_201_1 = iter_201_1[1]

				COLOR_GREEN = var_1_10012
				var_1_10009 = var_1_10009(var_201_1, var_1_10012)

				local var_201_2

				if iter_201_1[2] then
					var_201_2 = var_1_10009
					specialGSub = var_201_1
					i18n = var_1_10013
					var_1_10013 = var_1_10013("word_skill_desc_get")

					local var_201_3 = "$1"

					setColorStr = var_15

					local var_201_4 = iter_201_1[2]

					COLOR_GREEN = var_1_10018
					var_1_10009 = var_201_2 .. var_201_1(var_1_10013, var_201_3, var_15(var_201_4, var_1_10018))
				end

				specialGSub = var_201_2
				var_201_0 = var_201_2(var_201_0, "$" .. iter_201_0, var_1_10009)
			end

			HXSet = var_4

			return var_4.hxLan(var_201_0)
		end
	end
end

local var_0_288 = getSkillDescGet

local function var_0_289(arg_203_0, arg_203_1, arg_203_2)
	if arg_203_2 then
		pg = var_1_10003

		if var_1_10003.skill_world_display[arg_203_0] then
			setmetatable = var_1_10003

			if not var_1_10003({}, {
				__index = function(arg_204_0, arg_204_1)
					pg = var_2_10002

					local var_204_0

					if not var_2_10002.skill_world_display[arg_203_0][arg_204_1] then
						pg = var_204_0
						var_204_0 = var_204_0.skill_data_template[arg_203_0][arg_204_1]
					end

					return var_204_0
				end
			}) then
				pg = var_1_10003
				var_1_10003 = var_1_10003.skill_data_template[arg_203_0]
			end

			if not var_1_10003 then
				return ""
			end

			local var_203_0 = var_1_10003.desc

			if not var_1_10003.desc_add then
				HXSet = var_5

				return var_5.hxLan(var_203_0)
			end

			pairs = var_5

			for iter_203_0, iter_203_1 in var_5(var_1_10003.desc_add) do
				local var_203_1 = iter_203_1[arg_203_1][1]
				local var_203_2

				if iter_203_1[arg_203_1][2] then
					var_203_2 = var_203_1
					specialGSub = var_1_10012
					i18n = var_1_10014
					var_203_1 = var_203_2 .. var_1_10012(var_1_10014("word_skill_desc_learn"), "$1", iter_203_1[arg_203_1][2])
				end

				specialGSub = var_203_2

				local var_203_3 = var_203_0

				var_1_10014 = "$" .. iter_203_0
				setColorStr = var_15

				local var_203_4 = var_203_1

				COLOR_YELLOW = var_1_10018
				var_203_0 = var_203_2(var_203_3, var_1_10014, var_15(var_203_4, var_1_10018))
			end

			HXSet = var_5

			return var_5.hxLan(var_203_0)
		end
	end
end

local var_0_290 = getSkillDescLearn

local function var_0_291(arg_205_0, arg_205_1, arg_205_2)
	if arg_205_2 then
		pg = var_1_10003

		if var_1_10003.skill_world_display[arg_205_0] then
			setmetatable = var_1_10003

			if not var_1_10003({}, {
				__index = function(arg_206_0, arg_206_1)
					pg = var_2_10002

					local var_206_0

					if not var_2_10002.skill_world_display[arg_205_0][arg_206_1] then
						pg = var_206_0
						var_206_0 = var_206_0.skill_data_template[arg_205_0][arg_206_1]
					end

					return var_206_0
				end
			}) then
				pg = var_1_10003
				var_1_10003 = var_1_10003.skill_data_template[arg_205_0]
			end

			if not var_1_10003 then
				return ""
			end

			local var_205_0 = var_1_10003.desc

			if not var_1_10003.desc_add then
				HXSet = var_5

				return var_5.hxLan(var_205_0)
			end

			pairs = var_5

			for iter_205_0, iter_205_1 in var_5(var_1_10003.desc_add) do
				setColorStr = var_1_10010

				local var_205_1 = iter_205_1[arg_205_1][1]

				COLOR_GREEN = var_1_10013
				var_1_10010 = var_1_10010(var_205_1, var_1_10013)
				specialGSub = var_1_10011
				var_205_0 = var_1_10011(var_205_0, "$" .. iter_205_0, var_1_10010)
			end

			HXSet = var_5

			return var_5.hxLan(var_205_0)
		end
	end
end

local var_0_292 = getSkillDesc

local function var_0_293(arg_207_0, arg_207_1, arg_207_2)
	string = var_1_10003
	arg_207_0 = var_1_10003.gsub(arg_207_0, "<color=#", "<color=NNN")
	string = var_3
	arg_207_0 = var_3.gsub(arg_207_0, "#", "")
	string = var_3
	arg_207_2 = var_3.gsub(arg_207_2, "%%", "%%%%")
	string = var_3
	arg_207_0 = var_3.gsub(arg_207_0, arg_207_1, arg_207_2)
	string = var_3

	return (var_3.gsub(arg_207_0, "<color=NNN", "<color=#"))
end

local var_0_294 = specialGSub

local function var_0_295(arg_208_0, arg_208_1, arg_208_2, arg_208_3, arg_208_4, arg_208_5)
	local var_208_0 = {}

	arg_208_4 = arg_208_4 or 0.27

	local var_208_1 = 0.05

	if arg_208_0 then
		var_1_10008 = arg_208_0.transform.localPosition.x
		setAnchoredPosition = var_1_10009

		var_1_10009(arg_208_0, {
			x = var_1_10008 - 500
		})

		shiftPanel = var_1_10009

		var_1_10009(arg_208_0, var_1_10008, nil, 0.05, arg_208_4, true, true)

		setActive = var_1_10009

		var_1_10009(arg_208_0, true)
	end

	setActive = var_1_10008

	var_1_10008(arg_208_1, false)

	setActive = var_1_10008

	var_1_10008(arg_208_2, false)

	setActive = var_1_10008

	var_1_10008(arg_208_3, false)

	for iter_208_0 = 1, 3 do
		table = var_1_10012
		var_1_10012 = var_1_10012.insert

		local var_208_2 = var_208_0

		LeanTween = var_1_10015
		var_1_10015 = var_1_10015.delayedCall

		local var_208_3 = arg_208_4 + 0.13 + var_208_1 * iter_208_0

		System = var_18

		var_1_10012(var_208_2, var_1_10015(var_208_3, var_18.Action(function()
			if arg_208_1 then
				setActive = var_0

				var_0(arg_208_1, not arg_208_1.gameObject.activeSelf)
			end

			return
		end)).uniqueId)

		table = var_1_10012
		var_1_10012 = var_1_10012.insert

		local var_208_4 = var_208_0

		LeanTween = var_1_10015
		var_1_10015 = var_1_10015.delayedCall

		local var_208_5 = arg_208_4 + 0.02 + var_208_1 * iter_208_0

		System = var_18

		var_1_10012(var_208_4, var_1_10015(var_208_5, var_18.Action(function()
			if arg_208_2 then
				setActive = var_0

				local var_210_0 = arg_208_2

				go = var_2_10003

				var_0(var_210_0, not var_2_10003(arg_208_2).activeSelf)
			end

			if arg_208_2 then
				setActive = var_0

				local var_210_1 = arg_208_3

				go = var_2_10003

				var_0(var_210_1, not var_2_10003(arg_208_3).activeSelf)
			end

			return
		end)).uniqueId)
	end

	if arg_208_5 then
		table = var_8

		local var_208_6 = var_8.insert
		local var_208_7 = var_208_0

		LeanTween = iter_208_0

		local var_208_8 = iter_208_0.delayedCall
		local var_208_9 = arg_208_4 + 0.13 + var_208_1 * 3 + 0.1

		System = var_14

		var_208_6(var_208_7, var_208_8(var_208_9, var_14.Action(function()
			arg_208_5()

			return
		end)).uniqueId)
	end

	return var_208_0
end

local var_0_296 = topAnimation

local function var_0_297(arg_212_0)
	assert = var_1_10001

	var_1_10001(arg_212_0, "must provide cancel targets, LeanTween.cancelAll is not allow")

	ipairs = var_1_10001

	for iter_212_0, iter_212_1 in var_1_10001(arg_212_0) do
		if iter_212_1 then
			LeanTween = var_1_10006

			var_1_10006.cancel(iter_212_1)
		end
	end

	return
end

local var_0_298 = cancelTweens

local function var_0_299(arg_213_0)
	pg = var_1_10001

	local var_213_0 = var_1_10001.TimeMgr.GetInstance()
	local var_213_1 = var_1.GetServerTime(var_213_0) - arg_213_0
	local var_213_2 = ""

	if var_213_1 <= 59 then
		i18n = var_4
		var_213_2 = var_4("just_now")
	elseif var_213_1 <= 3599 then
		i18n = var_4

		local var_213_3 = "several_minutes_before"

		math = var_1_10007
		var_213_2 = var_4(var_213_3, var_1_10007.floor(var_213_1 / 60))
	elseif var_213_1 <= 86399 then
		i18n = var_4

		local var_213_4 = "several_hours_before"

		math = var_1_10007
		var_213_2 = var_4(var_213_4, var_1_10007.floor(var_213_1 / 16))
	else
		i18n = var_4

		local var_213_5 = "several_days_before"

		math = var_1_10007
		var_213_2 = var_4(var_213_5, var_1_10007.floor(var_213_1 / 0))
	end

	return var_213_2
end

local var_0_300 = getOfflineTimeStamp
local var_0_301 = false
local var_0_302 = PaintCameraAdjustOn

local function var_0_303(arg_214_0)
	PaintCameraAdjustOn = var_1_10001

	if var_1_10001 ~= arg_214_0 then
		GameObject = var_1_10001

		local var_214_0 = var_1_10001.Find("UICamera/Canvas")
		local var_214_1 = var_1.GetComponent

		typeof = var_1_10004
		CanvasScaler = var_1_10006

		local var_214_2 = var_214_1(var_214_0, var_1_10004(var_1_10006))

		if arg_214_0 then
			CanvasScaler = var_1_10002
			var_214_2.screenMatchMode = var_1_10002.ScreenMatchMode.MatchWidthOrHeight
			var_214_2.matchWidthOrHeight = 1
		else
			CanvasScaler = var_1_10002
			var_214_2.screenMatchMode = var_1_10002.ScreenMatchMode.Expand
		end

		pg = var_1_10002

		local var_214_3 = var_1_10002.CameraFixMgr.GetInstance()

		var_2.BlockCameraRatioControll(var_214_3, arg_214_0)

		arg_214_0 = PaintCameraAdjustOn
	end

	return
end

local var_0_304 = cameraPaintViewAdjust

local function var_0_305(arg_215_0, arg_215_1)
	math = var_1_10002

	local var_215_0 = var_1_10002.abs(arg_215_0.row - arg_215_1.row)

	math = var_1_10003

	return var_215_0 + var_1_10003.abs(arg_215_0.column - arg_215_1.column)
end

local var_0_306 = ManhattonDist

local function var_0_307(arg_216_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10003

	local var_216_0 = var_1_10001(var_1_10003)

	if not var_1.checkReadHelp(var_216_0, arg_216_0) then
		pg = var_2

		local var_216_1 = var_2.MsgboxMgr.GetInstance()
		local var_216_2 = var_2.ShowMsgBox
		local var_216_3 = {}

		MSGBOX_TYPE_HELP = var_1_10006
		var_216_3.type = var_1_10006
		pg = var_1_10006
		var_216_3.helps = var_1_10006.gametip[arg_216_0].tip

		var_216_2(var_216_1, var_216_3)
		var_1:recordReadHelp(arg_216_0)
	end

	return
end

local var_0_308 = checkFirstHelpShow
local var_0_309
local var_0_310 = preOrientation
local var_0_311 = false
local var_0_312 = preNotchFitterEnabled

local function var_0_313(arg_217_0)
	Input = var_1_10001

	local var_217_0 = var_1_10001.deviceOrientation
	local var_217_1 = var_1.ToString(var_217_0)

	originalPrint = preOrientation

	local var_217_2 = "Begining Orientation:"

	preOrientation = var_1_10004

	var_1(var_217_2 .. var_1_10004)

	Screen = var_1
	var_1.autorotateToPortrait = true
	Screen = var_1
	var_1.autorotateToPortraitUpsideDown = true
	cameraPaintViewAdjust = var_1

	var_1(true)

	return
end

local var_0_314 = openPortrait

local function var_0_315(arg_218_0)
	Screen = var_1_10001
	var_1_10001.autorotateToPortrait = false
	Screen = var_1_10001
	var_1_10001.autorotateToPortraitUpsideDown = false
	originalPrint = var_1_10001

	local var_218_0 = "Closing Orientation:"

	preOrientation = var_1_10004

	var_1_10001(var_218_0 .. var_1_10004)

	Screen = var_1_10001
	ScreenOrientation = var_2
	var_1_10001.orientation = var_2.LandscapeLeft
	Timer = var_1_10001

	local var_218_1 = var_1_10001.New(function()
		Screen = var_2_10000
		ScreenOrientation = var_2_10001
		var_2_10000.orientation = var_2_10001.AutoRotation

		return
	end, 0.2, 1)
	local var_218_2 = var_1.Start(var_218_1)

	cameraPaintViewAdjust = var_2

	var_2(false)

	return
end

local var_0_316 = closePortrait

local function var_0_317(arg_220_0)
	local var_220_0 = arg_220_0
	local var_220_1 = 0

	repeat
		string = var_1_10003

		local var_220_2

		var_1_10003, var_220_2 = var_1_10003.gsub(var_220_0, "^(-?%d+)(%d%d%d)", "%1,%2")

		local var_220_3 = var_220_2

		var_220_0 = var_1_10003
	until var_220_3 == 0

	return var_220_0
end

local var_0_318 = comma_value
local var_0_319 = 0.2

local function var_0_320(arg_221_0, arg_221_1, arg_221_2, arg_221_3, arg_221_4, arg_221_5)
	defaultValue = var_1_10006
	arg_221_3 = var_1_10006(arg_221_3, var_0_319)

	local var_221_0

	if arg_221_5 then
		LeanTween = var_221_0
		var_221_0 = var_221_0.cancel
		go = var_8

		var_221_0(var_8(arg_221_0))
	end

	Vector3 = var_221_0

	local var_221_1 = var_221_0.New

	tf = var_8

	local var_221_2 = var_8(arg_221_0).localPosition.x

	tf = var_9

	local var_221_3 = var_9(arg_221_0).localPosition.y

	tf = var_10

	local var_221_4 = var_221_1(var_221_2, var_221_3, var_10(arg_221_0).localPosition.z)

	if arg_221_1 then
		var_221_4.x = arg_221_1
	end

	if arg_221_2 then
		var_221_4.y = arg_221_2
	end

	LeanTween = var_1_10007

	local var_221_5 = var_1_10007.move

	rtf = var_221_3

	local var_221_6 = var_221_5(var_221_3(arg_221_0), var_221_4, arg_221_3)
	local var_221_7 = var_7.setEase

	LeanTweenType = var_10

	local var_221_8 = var_221_7(var_221_6, var_10.easeInOutSine)

	if arg_221_4 then
		var_221_8:setDelay(arg_221_4)
	end

	return var_221_8
end

local var_0_321 = SwitchPanel

local function var_0_322(arg_222_0)
	IslandTaskActhelper = var_1_10001

	if var_1_10001.IsIslandTaskAct(arg_222_0) then
		return
	end

	local var_222_0 = arg_222_0:getConfig("config_id")

	getActivityTask = var_1_10002

	local var_222_1, var_222_2 = var_1_10002(arg_222_0, true)

	if not var_222_2 then
		pg = var_4

		local var_222_3 = var_4.m02
		local var_222_4 = var_4.sendNotification

		GAME = var_1_10007

		var_222_4(var_222_3, var_1_10007.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_222_0.id
		})

		return true
	end

	return false
end

local var_0_323 = updateActivityTaskStatus

local function var_0_324(arg_223_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_223_0 = var_1_10001(var_1_10003)
	local var_223_1 = arg_223_0
	local var_223_2 = arg_223_0.getNDay(var_223_1)

	pg = var_1_10003

	local var_223_3 = var_1_10003.TimeMgr.GetInstance()
	local var_223_4 = var_3.GetServerOverWeek(var_223_3, arg_223_0:getStartTime())

	ipairs = var_223_1

	for iter_223_0, iter_223_1 in var_223_1(arg_223_0:getConfig("config_data")) do
		pg = var_9

		if var_9.battlepass_task_group[iter_223_1] and var_9.group_mask <= var_223_4 then
			underscore = var_1_10010
			var_1_10010 = var_1_10010.any
			underscore = var_1_10012

			if var_1_10010(var_1_10012.flatten(var_9.task_group), function(arg_224_0)
				local var_224_0 = var_223_0

				return var_1.getTaskVO(var_224_0, arg_224_0) == nil
			end) then
				pg = var_1_10010
				var_1_10012 = var_1_10010.m02
				var_1_10010 = var_1_10010.sendNotification
				GAME = var_13

				var_1_10010(var_1_10012, var_13.CRUSING_CMD, {
					cmd = 1,
					activity_id = arg_223_0.id
				})

				return true
			end
		elseif not var_9 then
			warning = var_1_10010

			var_1_10010("battlepass_task_group表中不存在 id = " .. iter_223_1)
		end
	end

	return false
end

local var_0_325 = updateCrusingActivityTask

local function var_0_326(arg_225_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10003

	local var_225_0 = var_1_10001(var_1_10003)
	local var_225_1 = arg_225_0
	local var_225_2 = arg_225_0.getNDay(var_225_1)

	pg = var_1_10003

	local var_225_3 = var_1_10003.TimeMgr.GetInstance()
	local var_225_4 = var_3.GetServerOverWeek(var_225_3, arg_225_0:getStartTime())

	ipairs = var_225_1

	for iter_225_0, iter_225_1 in var_225_1(arg_225_0:getConfig("config_data")) do
		pg = var_9

		if var_9.black_friday_battlepass_task_group[iter_225_1] and var_9.group_mask <= var_225_4 then
			underscore = var_1_10010
			var_1_10010 = var_1_10010.any
			underscore = var_1_10012

			if var_1_10010(var_1_10012.flatten(var_9.task_group), function(arg_226_0)
				local var_226_0 = var_225_0

				return var_1.getTaskVO(var_226_0, arg_226_0) == nil
			end) then
				pg = var_1_10010
				var_1_10012 = var_1_10010.m02
				var_1_10010 = var_1_10010.sendNotification
				GAME = var_13

				var_1_10010(var_1_10012, var_13.CRUSING_CMD_HEI5, {
					cmd = 1,
					activity_id = arg_225_0.id
				})

				return true
			end
		elseif not var_9 then
			warning = var_1_10010

			var_1_10010("black_friday_battlepass_task_group表中不存在 id = " .. iter_225_1)
		end
	end

	return false
end

local var_0_327 = updateCrusingHei5ActivityTask

local function var_0_328(arg_227_0, arg_227_1, arg_227_2)
	Vector3 = var_1_10003
	arg_227_0.localScale = var_1_10003.one
	Vector2 = var_3
	arg_227_0.anchorMin = var_3.zero
	Vector2 = var_3
	arg_227_0.anchorMax = var_3.one

	local var_227_0 = arg_227_2 or arg_227_1

	GetImageSpriteFromAtlasAsync = var_1_10004

	var_1_10004("shipframe", var_227_0, arg_227_0)

	pg = var_1_10004

	if var_1_10004.frame_resource[var_227_0] then
		local var_227_1 = var_4.param

		Vector2 = var_1_10005
		arg_227_0.offsetMin = var_1_10005(var_227_1[1], var_227_1[2])
		Vector2 = var_1_10005
		arg_227_0.offsetMax = var_1_10005(var_227_1[3], var_227_1[4])
	else
		Vector2 = var_1_10005
		arg_227_0.offsetMin = var_1_10005.zero
		Vector2 = var_5
		arg_227_0.offsetMax = var_5.zero
	end

	return
end

local var_0_329 = setShipCardFrame

local function var_0_330(arg_228_0, arg_228_1, arg_228_2)
	Vector3 = var_1_10003
	arg_228_0.localScale = var_1_10003.one
	Vector2 = var_3
	arg_228_0.anchorMin = var_3.zero
	Vector2 = var_3
	arg_228_0.anchorMax = var_3.one
	setImageSprite = var_3

	local var_228_0 = arg_228_0

	GetSpriteFromAtlas = var_1_10006

	var_3(var_228_0, var_1_10006("shipframeb", "b" .. (arg_228_2 or arg_228_1)))

	local var_228_1 = "b" .. (arg_228_2 or arg_228_1)

	pg = var_4

	if var_4.frame_resource[var_228_1] then
		local var_228_2 = var_4.param

		Vector2 = var_228_0
		arg_228_0.offsetMin = var_228_0(var_228_2[1], var_228_2[2])
		Vector2 = var_228_0
		arg_228_0.offsetMax = var_228_0(var_228_2[3], var_228_2[4])
	else
		Vector2 = var_228_0
		arg_228_0.offsetMin = var_228_0.zero
		Vector2 = var_5
		arg_228_0.offsetMax = var_5.zero
	end

	return
end

local var_0_331 = setRectShipCardFrame

local function var_0_332(arg_229_0, arg_229_1)
	if arg_229_1 then
		var_1_10002 = arg_229_1 .. "(Clone)"

		local var_229_0 = false

		eachChild = var_1_10004

		var_1_10004(arg_229_0, function(arg_230_0)
			setActive = var_2_10001

			var_2_10001(arg_230_0, arg_230_0.name == var_1_10002)

			local var_230_0

			if not var_229_0 then
				var_230_0 = arg_230_0.name == var_1_10002
			end

			var_229_0 = var_230_0

			return
		end)

		if not var_229_0 then
			LoadAndInstantiateAsync = var_1_10004

			var_1_10004("effect", arg_229_1, function(arg_231_0)
				IsNil = var_2_10001

				if not var_2_10001(arg_229_0) then
					findTF = var_1

					if var_1(arg_229_0, var_1_10002) then
						Object = var_1

						var_1.Destroy(arg_231_0)
					else
						setParent = var_1

						var_1(arg_231_0, arg_229_0)

						setActive = var_1

						var_1(arg_231_0, true)
					end

					return
				end
			end)
		end
	end

	setActive = var_1_10002

	var_1_10002(arg_229_0, arg_229_1)

	return
end

local var_0_333 = setFrameEffect

local function var_0_334(arg_232_0, arg_232_1)
	local var_232_0 = arg_232_0
	local var_232_1 = arg_232_0.Find(var_232_0, "proposeShipCard(Clone)")
	local var_232_2

	if arg_232_1.propose then
		var_232_2 = not arg_232_1:ShowPropose()
	end

	if var_232_1 then
		setActive = var_232_0

		var_232_0(var_232_1, var_232_2)
	elseif var_232_2 then
		pg = var_232_0

		local var_232_3 = var_232_0.PoolMgr.GetInstance()

		var_4.GetUI(var_232_3, "proposeShipCard", true, function(arg_233_0)
			IsNil = var_2_10001

			if not var_2_10001(arg_232_0) then
				local var_233_0 = arg_232_0

				if var_1.Find(var_233_0, "proposeShipCard(Clone)") then
					pg = var_1

					local var_233_1 = var_1.PoolMgr.GetInstance()

					var_1.ReturnUI(var_233_1, "proposeShipCard", arg_233_0)
				else
					setParent = var_1

					var_1(arg_233_0, arg_232_0, false)
				end

				return
			end
		end)
	end

	return
end

local var_0_335 = setProposeMarkIcon

local function var_0_336(arg_234_0, arg_234_1)
	local var_234_0 = arg_234_1
	local var_234_1 = arg_234_1.rarity2bgPrint(var_234_0)

	findTF = var_1_10003

	local var_234_2 = var_1_10003(arg_234_0, "content/bg")

	GetImageSpriteFromAtlasAsync = var_234_0

	var_234_0("bg/star_level_card_" .. var_234_1, "", var_234_2)

	findTF = var_234_0

	local var_234_3 = var_234_0(arg_234_0, "content/ship_icon")
	local var_234_4

	if not arg_234_1 or not {
		"shipYardIcon/" .. arg_234_1:getPainting(),
		arg_234_1:getPainting()
	} then
		var_234_4 = {
			"shipYardIcon/unknown",
			""
		}
	end

	GetImageSpriteFromAtlasAsync = var_6

	var_6(var_234_4[1], var_234_4[2], var_234_3)

	local var_234_5 = arg_234_1
	local var_234_6 = arg_234_1.getShipType(var_234_5)

	findTF = var_7

	local var_234_7 = var_7(arg_234_0, "content/info/top/type")

	GetImageSpriteFromAtlasAsync = var_234_5

	local var_234_8 = "shiptype"

	shipType2print = var_1_10011

	var_234_5(var_234_8, var_1_10011(var_234_6), var_234_7)

	setText = var_234_5
	findTF = var_234_8

	local var_234_9 = var_234_8(arg_234_0, "content/dockyard/lv/Text")

	defaultValue = var_11

	var_234_5(var_234_9, var_11(arg_234_1.level, 1))

	local var_234_10 = arg_234_1
	local var_234_11 = arg_234_1.getStar(var_234_10)
	local var_234_12 = arg_234_1
	local var_234_13 = arg_234_1.getMaxStar(var_234_12)

	findTF = var_234_10

	local var_234_14 = var_234_10(arg_234_0, "content/front/stars")

	setActive = var_234_12

	var_234_12(var_234_14, true)

	findTF = var_234_12

	local var_234_15 = var_234_12(var_234_14, "star_tpl")
	local var_234_16 = var_234_14.childCount
	local var_234_17 = 1

	Ship = var_14

	for iter_234_0 = var_234_17, var_14.CONFIG_MAX_STAR do
		if var_234_16 < iter_234_0 then
			cloneTplTo = var_1_10017

			if not var_1_10017(var_234_15, var_234_14) then
				var_1_10017 = var_234_14:GetChild(iter_234_0 - 1)
			end

			setActive = var_1_10018

			var_1_10018(var_1_10017, iter_234_0 <= var_234_13)

			triggerToggle = var_1_10018

			var_1_10018(var_1_10017, iter_234_0 <= var_234_11)
		end
	end

	findTF = var_234_17

	local var_234_18 = var_234_17(arg_234_0, "content/front/frame")
	local var_234_19 = arg_234_1
	local var_234_20, var_234_21 = arg_234_1.GetFrameAndEffect(var_234_19)

	setShipCardFrame = var_234_19

	var_234_19(var_234_18, var_234_1, var_234_20)

	setFrameEffect = var_234_19
	findTF = var_18

	var_234_19(var_18(arg_234_0, "content/front/bg_other"), var_234_21)

	setProposeMarkIcon = var_234_19

	var_234_19(arg_234_0:Find("content/dockyard/propose"), arg_234_1)

	return
end

local var_0_337 = flushShipCard

local function var_0_338(arg_235_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_235_0)

	GetOrAddComponent = var_1

	local var_235_0 = var_1(arg_235_0, "CanvasGroup")

	var_235_0.alpha = 0
	LeanTween = var_2

	local var_235_1 = var_2.alphaCanvas(var_235_0, 1, 0.2)

	var_2.setUseEstimatedTime(var_235_1, true)

	findTF = var_2

	if var_2(arg_235_0.transform, "white_mask") then
		setActive = var_3

		var_3(var_2, false)
	end

	return
end

local var_0_339 = TweenItemAlphaAndWhite

local function var_0_340(arg_236_0)
	LeanTween = var_1_10001

	var_1_10001.cancel(arg_236_0)

	GetOrAddComponent = var_1
	var_1(arg_236_0, "CanvasGroup").alpha = 0

	return
end

local var_0_341 = ClearTweenItemAlphaAndWhite

local function var_0_342(arg_237_0)
	local var_237_0 = {}

	getProxy = var_1_10002
	ShipSkinProxy = var_1_10004

	local var_237_1 = var_1_10002(var_1_10004)
	local var_237_2 = var_2.getSkinList(var_237_1)

	getProxy = var_1_10004
	CollectionProxy = var_1_10006

	local var_237_3 = var_1_10004(var_1_10006)

	if var_4.getShipGroup(var_237_3, arg_237_0) then
		ShipGroup = var_237_1

		local var_237_4 = var_237_1.getSkinList(arg_237_0)

		ipairs = var_237_3

		for iter_237_0, iter_237_1 in var_237_3(var_237_4) do
			local var_237_5 = iter_237_1.skin_type

			ShipSkin = var_1_10012

			if var_237_5 ~= var_1_10012.SKIN_TYPE_DEFAULT then
				table = var_237_5

				if not var_237_5.contains(var_237_2, iter_237_1.id) then
					local var_237_6 = iter_237_1.skin_type

					ShipSkin = var_1_10012

					if var_237_6 ~= var_1_10012.SKIN_TYPE_REMAKE or not var_4.trans then
						local var_237_7 = iter_237_1.skin_type

						ShipSkin = var_1_10012

						if var_237_7 == var_1_10012.SKIN_TYPE_PROPOSE and var_4.married == 1 then
							var_237_0[iter_237_1.id] = true
						end
					end
				end
			end
		end
	end

	return var_237_0
end

local var_0_343 = getGroupOwnSkins

local function var_0_344(arg_238_0, arg_238_1)
	local var_238_0 = {}

	if not arg_238_0 then
		return nil
	end

	local var_238_1 = #arg_238_0
	local var_238_2 = 1

	while var_238_2 <= var_238_1 do
		string = var_1_10005

		if var_1_10005.find(arg_238_0, arg_238_1, var_238_2) == nil then
			table = var_1_10006
			var_1_10006 = var_1_10006.insert

			local var_238_3 = var_238_0

			string = var_9

			var_1_10006(var_238_3, var_9.sub(arg_238_0, var_238_2, var_238_1))

			break
		end

		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_238_4 = var_238_0

		string = var_9

		var_1_10006(var_238_4, var_9.sub(arg_238_0, var_238_2, var_1_10005 - 1))

		if var_1_10005 == var_238_1 then
			table = var_1_10006

			var_1_10006.insert(var_238_0, "")

			break
		end

		var_238_2 = var_1_10005 + 1
	end

	return var_238_0
end

local var_0_345 = split

local function var_0_346(arg_239_0, arg_239_1)
	local var_239_0 = ""
	local var_239_1 = #arg_239_0

	for iter_239_0 = 1, var_239_1 do
		string = var_1_10008

		if var_1_10008.sub(arg_239_0, iter_239_0, iter_239_0) ~= "0" or var_1_10008 == "0" and not arg_239_1 then
			if arg_239_1 then
				if 2 <= var_239_1 then
					if iter_239_0 == 1 then
						if var_1_10008 == "1" then
							i18n = var_9
							var_239_0 = var_9("number_" .. 10)
						else
							i18n = var_9

							local var_239_2 = var_9("number_" .. var_1_10008)

							i18n = var_10
							var_239_0 = var_239_2 .. var_10("number_" .. 10)
						end
					else
						local var_239_3 = var_239_0

						i18n = var_10
						var_239_0 = var_239_3 .. var_10("number_" .. var_1_10008)
					end
				else
					local var_239_4 = var_239_0

					i18n = var_10
					var_239_0 = var_239_4 .. var_10("number_" .. var_1_10008)
				end
			else
				local var_239_5 = var_239_0

				i18n = var_10
				var_239_0 = var_239_5 .. var_10("number_" .. var_1_10008)
			end
		end
	end

	return var_239_0
end

local var_0_347 = NumberToChinese

local function var_0_348(arg_240_0, arg_240_1)
	getProxy = var_1_10002
	TaskProxy = var_1_10004

	local var_240_0 = var_1_10002(var_1_10004)
	local var_240_1 = arg_240_0:getConfig("config_data")
	local var_240_2 = arg_240_0:getNDay(arg_240_0.data1)
	local var_240_3
	local var_240_4
	local var_240_5

	math = var_1_10008

	local var_240_6 = var_1_10008.max(arg_240_0.data3, 1)

	math = var_1_10009

	for iter_240_0 = var_240_6, var_1_10009.min(var_240_2, #var_240_1) do
		_ = var_240_7

		local var_240_7 = var_240_7.flatten({
			var_240_1[iter_240_0]
		})

		ipairs = var_1_10013

		for iter_240_1, iter_240_2 in var_1_10013(var_240_7) do
			if var_240_0:getTaskById(iter_240_2) then
				return var_5.id, var_5
			end

			if var_240_4 then
				if var_240_0:getFinishTaskById(iter_240_2) then
					var_240_4 = var_240_5
				elseif arg_240_1 then
					return iter_240_2
				else
					return var_240_4.id, var_240_4
				end
			else
				var_240_4 = var_240_0:getFinishTaskById(iter_240_2)
				var_240_5 = var_240_5 or iter_240_2
			end
		end
	end

	if var_240_4 then
		return var_240_4.id, var_240_4
	else
		return var_240_5
	end

	return
end

local var_0_349 = getActivityTask

local function var_0_350(arg_241_0, arg_241_1, arg_241_2)
	GetComponent = var_1_10003

	local var_241_0 = var_1_10003(arg_241_0, "Image")

	GetComponent = var_1_10004
	var_241_0.sprite = var_1_10004(arg_241_1, "Image").sprite

	if arg_241_2 then
		var_241_0:SetNativeSize()
	end

	return
end

local var_0_351 = setImageFromImage

local function var_0_352(arg_242_0)
	pg = var_1_10001

	local var_242_0 = var_1_10001.TimeMgr.GetInstance()
	local var_242_1, var_242_2, var_242_3, var_242_4 = var_1.parseTimeFrom(var_242_0, arg_242_0)

	if 1 <= var_242_1 then
		i18n = var_5

		return var_5("limit_skin_time_day", var_242_1)
	elseif var_242_1 <= 0 and 0 < var_242_2 then
		i18n = var_5

		return var_5("limit_skin_time_day_min", var_242_2, var_242_3)
	elseif var_242_1 <= 0 and var_242_2 <= 0 and (0 < var_242_3 or 0 < var_242_4) then
		i18n = var_5

		local var_242_5 = "limit_skin_time_min"

		math = var_1_10008

		return var_5(var_242_5, var_1_10008.max(var_242_3, 1))
	elseif var_242_1 <= 0 and var_242_2 <= 0 and var_242_3 <= 0 and var_242_4 <= 0 then
		i18n = var_5

		return var_5("limit_skin_time_overtime")
	end

	return
end

local var_0_353 = skinTimeStamp

local function var_0_354(arg_243_0)
	pg = var_1_10001

	local var_243_0 = var_1_10001.TimeMgr.GetInstance()
	local var_243_1 = var_1.GetServerTime(var_243_0)

	math = var_1_10002

	local var_243_2 = var_1_10002.max(arg_243_0 - var_243_1, 0)

	math = var_243_0

	local var_243_3 = var_243_0.floor(var_243_2 / 0)
	local var_243_4

	if 0 < var_243_3 then
		i18n = var_243_4
		var_243_4 = var_243_4("time_remaining_tip")

		local var_243_5 = var_243_3

		i18n = var_6

		return var_243_4 .. var_243_5 .. var_6("word_date")
	else
		math = var_243_4

		local var_243_6 = var_243_4.floor(var_243_2 / 16)
		local var_243_7

		if 0 < var_243_6 then
			i18n = var_243_7
			var_243_7 = var_243_7("time_remaining_tip")

			local var_243_8 = var_243_6

			i18n = var_7

			return var_243_7 .. var_243_8 .. var_7("word_hour")
		else
			math = var_243_7

			local var_243_9 = var_243_7.floor(var_243_2 / 60)
			local var_243_10

			if 0 < var_243_9 then
				i18n = var_243_10
				var_243_10 = var_243_10("time_remaining_tip")

				local var_243_11 = var_243_9

				i18n = var_8

				return var_243_10 .. var_243_11 .. var_8("word_minute")
			else
				i18n = var_243_10

				local var_243_12 = var_243_10("time_remaining_tip")
				local var_243_13 = var_243_2

				i18n = var_8

				return var_243_12 .. var_243_13 .. var_8("word_second")
			end
		end
	end

	return
end

local var_0_355 = skinCommdityTimeStamp

local function var_0_356(arg_244_0)
	pg = var_1_10001

	local var_244_0 = var_1_10001.TimeMgr.GetInstance()
	local var_244_1 = (var_1.GetServerTime(var_244_0) - arg_244_0) / 0

	if 1 < var_244_1 then
		i18n = var_4

		local var_244_2 = "ins_word_day"

		math = var_1_10007

		return var_4(var_244_2, var_1_10007.floor(var_244_1))
	else
		local var_244_3 = var_2 / 16

		if 1 < var_244_3 then
			i18n = var_5

			local var_244_4 = "ins_word_hour"

			math = var_1_10008

			return var_5(var_244_4, var_1_10008.floor(var_244_3))
		else
			local var_244_5 = var_2 / 60

			if 1 < var_244_5 then
				i18n = var_6

				local var_244_6 = "ins_word_minu"

				math = var_1_10009

				return var_6(var_244_6, var_1_10009.floor(var_244_5))
			else
				i18n = var_6

				return var_6("ins_word_minu", 1)
			end
		end
	end

	return
end

local var_0_357 = InstagramTimeStamp

local function var_0_358(arg_245_0)
	pg = var_1_10001

	local var_245_0 = var_1_10001.TimeMgr.GetInstance()
	local var_245_1 = (var_1.GetServerTime(var_245_0) - arg_245_0) / 0

	if 1 < var_245_1 then
		i18n1 = var_4
		math = var_1_10006

		return var_4(var_1_10006.floor(var_245_1) .. "d")
	else
		local var_245_2 = var_2 / 16

		if 1 < var_245_2 then
			i18n1 = var_5
			math = var_1_10007

			return var_5(var_1_10007.floor(var_245_2) .. "h")
		else
			local var_245_3 = var_2 / 60

			if 1 < var_245_3 then
				i18n1 = var_6
				math = var_1_10008

				return var_6(var_1_10008.floor(var_245_3) .. "min")
			else
				i18n1 = var_6

				return var_6("1min")
			end
		end
	end

	return
end

local var_0_359 = InstagramReplyTimeStamp

local function var_0_360(arg_246_0)
	pg = var_1_10001

	local var_246_0 = var_1_10001.TimeMgr.GetInstance()
	local var_246_1, var_246_2, var_246_3, var_246_4 = var_1.parseTimeFrom(var_246_0, arg_246_0)

	if var_246_1 <= 0 and var_246_2 <= 0 and var_246_3 <= 0 and var_246_4 <= 0 then
		i18n = var_5

		return var_5("limit_skin_time_overtime")
	else
		i18n = var_5

		return var_5("attire_time_stamp", var_246_1, var_246_2, var_246_3)
	end

	return
end

local var_0_361 = attireTimeStamp

local function var_0_362(arg_247_0, ...)
	local var_247_0 = {
		...
	}

	ipairs = var_2

	for iter_247_0, iter_247_1 in var_2(var_247_0) do
		if arg_247_0 == nil then
			break
		end

		assert = var_1_10007
		type = var_1_10009
		var_1_10009 = var_1_10009(arg_247_0) == "table"

		var_1_10007(var_1_10009, "type error : intermediate target should be table")

		assert = var_1_10007
		type = var_1_10009
		var_1_10009 = var_1_10009(iter_247_1) == "table"

		var_1_10007(var_1_10009, "type error : param should be table")

		type = var_1_10007

		if var_1_10007(arg_247_0[iter_247_1[1]]) == "function" then
			var_1_10007 = arg_247_0[iter_247_1[1]]
			var_1_10009 = arg_247_0
			unpack = var_10

			local var_247_1

			if not iter_247_1[2] then
				var_247_1 = {}
			end

			arg_247_0 = var_1_10007(var_1_10009, var_10(var_247_1))
		else
			arg_247_0 = arg_247_0[iter_247_1[1]]
		end
	end

	return arg_247_0
end

local var_0_363 = checkExist

local function var_0_364(arg_248_0, arg_248_1)
	if arg_248_0 == nil then
		return
	end

	assert = var_1_10002
	type = var_1_10004

	var_1_10002(var_1_10004(arg_248_0) == "table")

	return arg_248_0[arg_248_1]
end

local var_0_365 = AcessWithinNull

local function var_0_366()
	local var_249_0 = {}

	i18n = var_1_10001
	var_249_0.text = var_1_10001("msgbox_repair")

	function var_249_0.onCallback()
		PathMgr = var_2_10000

		local var_250_0 = var_2_10000.FileExists

		Application = var_2_10002

		local var_250_2

		if var_250_0(var_2_10002.persistentDataPath .. "/hashes.csv") then
			BundleWizard = var_0

			local var_250_1 = var_0.Inst

			var_250_2 = var_0.GetGroupMgr(var_250_1, "DEFAULT_RES")

			var_0.StartVerifyForLua(var_250_2)
		else
			pg = var_0

			local var_250_3 = var_0.TipsMgr.GetInstance()
			local var_250_4 = var_0.ShowTips

			i18n = var_250_2

			var_250_4(var_250_3, var_250_2("word_no_cache"))
		end

		return
	end

	local var_249_1 = {}

	i18n = var_1_10002
	var_249_1.text = var_1_10002("msgbox_repair_l2d")

	function var_249_1.onCallback()
		PathMgr = var_2_10000

		local var_251_0 = var_2_10000.FileExists

		Application = var_2_10002

		local var_251_2

		if var_251_0(var_2_10002.persistentDataPath .. "/hashes-live2d.csv") then
			BundleWizard = var_0

			local var_251_1 = var_0.Inst

			var_251_2 = var_0.GetGroupMgr(var_251_1, "L2D")

			var_0.StartVerifyForLua(var_251_2)
		else
			pg = var_0

			local var_251_3 = var_0.TipsMgr.GetInstance()
			local var_251_4 = var_0.ShowTips

			i18n = var_251_2

			var_251_4(var_251_3, var_251_2("word_no_cache"))
		end

		return
	end

	local var_249_2 = {}

	i18n = var_3
	var_249_2.text = var_3("msgbox_repair_painting")

	function var_249_2.onCallback()
		PathMgr = var_2_10000

		local var_252_0 = var_2_10000.FileExists

		Application = var_2_10002

		local var_252_2

		if var_252_0(var_2_10002.persistentDataPath .. "/hashes-painting.csv") then
			BundleWizard = var_0

			local var_252_1 = var_0.Inst

			var_252_2 = var_0.GetGroupMgr(var_252_1, "PAINTING")

			var_0.StartVerifyForLua(var_252_2)
		else
			pg = var_0

			local var_252_3 = var_0.TipsMgr.GetInstance()
			local var_252_4 = var_0.ShowTips

			i18n = var_252_2

			var_252_4(var_252_3, var_252_2("word_no_cache"))
		end

		return
	end

	pg = var_3

	local var_249_3 = var_3.MsgboxMgr.GetInstance()
	local var_249_4 = var_3.ShowMsgBox
	local var_249_5 = {
		hideYes = true,
		hideNo = true
	}

	i18n = var_1_10007
	var_249_5.content = var_1_10007("resource_verify_warn")
	var_249_5.custom = {
		var_249_2,
		var_249_1,
		var_249_0
	}

	var_249_4(var_249_3, var_249_5)

	return
end

local var_0_367 = showRepairMsgbox

local function var_0_368(arg_253_0, arg_253_1)
	CSharpVersion = var_1_10002

	if var_1_10002 > 35 then
		BundleWizard = var_1_10002
		var_1_10004 = var_1_10002.Inst

		local var_253_0 = var_1_10002.GetGroupMgr(var_1_10004, "DEFAULT_RES")

		var_1_10002.StartVerifyForLua(var_253_0)

		return
	end

	Application = var_1_10002

	local var_253_1 = var_1_10002.persistentDataPath .. "/hashes.csv"
	local var_253_2

	PathMgr = var_1_10004

	local var_253_3 = var_1_10004.ReadAllLines(var_253_1)
	local var_253_4 = {}

	if arg_253_0 then
		setActive = var_6

		var_6(arg_253_0, true)
	else
		pg = var_6

		local var_253_5 = var_6.UIMgr.GetInstance()

		var_6.LoadingOn(var_253_5)
	end

	local function var_253_6()
		if arg_253_0 then
			setActive = var_0

			var_0(arg_253_0, false)
		else
			pg = var_0

			local var_254_0 = var_0.UIMgr.GetInstance()

			var_0.LoadingOff(var_254_0)
		end

		print = var_0

		var_0(var_253_2)

		local var_254_2

		if var_253_2 then
			pg = var_254_2

			local var_254_1 = var_254_2.MsgboxMgr.GetInstance()

			var_254_2 = var_254_2.ShowMsgBox

			local var_254_3 = {}

			i18n = var_2_10004
			var_254_3.content = var_2_10004("resource_verify_fail", "")

			function var_254_3.onYes()
				VersionMgr = var_3_10000

				local var_255_0 = var_3_10000.Inst

				var_0.DeleteCacheFiles(var_255_0)

				Application = var_0

				var_0.Quit()

				return
			end

			var_254_2(var_254_1, var_254_3)
		else
			pg = var_254_2

			local var_254_4 = var_254_2.MsgboxMgr.GetInstance()
			local var_254_5 = var_0.ShowMsgBox
			local var_254_6 = {}

			i18n = var_2_10004
			var_254_6.content = var_2_10004("resource_verify_success")

			var_254_5(var_254_4, var_254_6)
		end

		return
	end

	local var_253_7 = var_253_3.Length
	local var_253_8

	;(function(arg_256_0)
		if arg_256_0 < 0 then
			var_253_6()

			return
		end

		if arg_253_1 then
			setSlider = var_1

			var_1(arg_253_1, 0, var_253_7, var_253_7 - arg_256_0)
		end

		string = var_1

		local var_256_0 = var_1.split(var_253_3[arg_256_0], ",")[1]
		local var_256_1 = var_1[3]

		PathMgr = var_4

		local var_256_2 = var_4.getAssetBundle(var_256_0)

		PathMgr = var_2_10005

		if var_2_10005.FileExists(var_256_2) then
			PathMgr = var_5

			local var_256_3 = var_5.ReadAllBytes

			PathMgr = var_7

			local var_256_4 = var_256_3(var_7.getAssetBundle(var_256_0))

			HashUtil = var_6

			if var_256_1 == var_6.CalcMD5(var_256_4) then
				onNextTick = var_7

				var_7(function()
					var_0(arg_256_0 - 1)

					return
				end)

				return
			end
		end

		var_253_2 = var_256_0

		var_253_6()

		return
	end)(var_253_7 - 1)

	return
end

local var_0_369 = resourceVerify

local function var_0_370(arg_258_0, arg_258_1)
	string = var_1_10002

	local var_258_0 = var_1_10002.split(arg_258_0, " ")
	local var_258_1 = ""
	local var_258_2 = ""
	local var_258_3 = arg_258_1
	local var_258_4 = arg_258_1.GetComponent

	typeof = var_1_10008
	RectTransform = var_1_10010

	local var_258_5 = var_258_4(var_258_3, var_1_10008(var_1_10010))
	local var_258_6 = arg_258_1
	local var_258_7 = arg_258_1.GetComponent

	typeof = var_1_10009
	Text = var_1_10011

	local var_258_8 = var_258_7(var_258_6, var_1_10009(var_1_10011))
	local var_258_9 = var_258_5.rect.width

	ipairs = var_258_6

	for iter_258_0, iter_258_1 in var_258_6(var_258_0) do
		local var_258_10 = var_258_2

		var_258_2 = var_258_2 == "" and iter_258_1 or var_258_2 .. " " .. iter_258_1
		setText = var_1_10014

		var_1_10014(arg_258_1, var_258_2)

		if var_258_9 < var_258_8.preferredWidth then
			var_258_1 = var_258_1 == "" and var_258_10 or var_258_1 .. "\n" .. var_258_10
			var_258_2 = iter_258_1
		end

		if #var_258_0 <= iter_258_0 then
			var_258_1 = var_258_1 == "" and var_258_2 or var_258_1 .. "\n" .. var_258_2
		end
	end

	return var_258_1
end

local var_0_371 = splitByWordEN

local function var_0_372(arg_259_0)
	if #arg_259_0 ~= 8 then
		return false
	end

	local var_259_0 = 0
	local var_259_1 = #arg_259_0

	while var_259_0 < var_259_1 do
		string = var_1_10003

		if var_1_10003.byte(arg_259_0, var_259_0 + 1) < 48 or var_1_10003 > 57 then
			return false
		end

		var_259_0 = var_259_0 + 1
	end

	return true
end

local var_0_373 = checkBirthFormat

local function var_0_374(arg_260_0)
	local var_260_0 = {
		"biaoqiang",
		"z23",
		"lafei",
		"lingbo",
		"mingshi",
		"xuefeng"
	}

	_ = var_1_10002

	return var_1_10002.any(var_260_0, function(arg_261_0)
		return arg_261_0 == arg_260_0
	end)
end

local var_0_375 = isHalfBodyLive2D

local function var_0_376(arg_262_0)
	local var_262_0 = -1
	local var_262_1 = 0
	local var_262_2 = 1
	local var_262_3 = 2

	NetConst = var_1_10005

	local var_262_4 = var_1_10005.GetServerStateUrl()

	PLATFORM_CODE = var_1_10006
	PLATFORM_CH = var_1_10007

	if var_1_10006 == var_1_10007 then
		string = var_1_10006
		var_262_4 = var_1_10006.gsub(var_262_4, "https", "http")
	end

	VersionMgr = var_1_10006

	local var_262_5 = var_1_10006.Inst

	var_6.WebRequest(var_262_5, var_262_4, function(arg_263_0, arg_263_1)
		local var_263_0 = true
		local var_263_1 = false

		string = var_2_10004

		for iter_263_0 in var_2_10004.gmatch(arg_263_1, "\"state\":%d") do
			if iter_263_0 ~= "\"state\":1" then
				var_263_0 = false
			end

			var_263_1 = true
		end

		if not var_263_1 then
			var_263_0 = false
		end

		if arg_262_0 ~= nil then
			local var_263_2 = arg_262_0
			local var_263_3

			if not var_263_0 or not var_262_2 then
				var_263_3 = var_262_1
			end

			var_263_2(var_263_3)
		end

		return
	end)

	return
end

local var_0_377 = GetServerState

local function var_0_378(arg_264_0, arg_264_1)
	GetOrAddComponent = var_1_10002

	local var_264_0 = var_1_10002(arg_264_0, "ScrollText")

	var_2.SetText(var_264_0, arg_264_1)

	return
end

local var_0_379 = setScrollText

local function var_0_380(arg_265_0, arg_265_1)
	GetComponent = var_1_10002

	local var_265_0 = arg_265_0

	typeof = var_1_10005
	Text = var_1_10007

	local var_265_1 = var_1_10002(var_265_0, var_1_10005(var_1_10007))

	assert = var_1_10003

	var_1_10003(var_265_1, "without component<Text>")

	local var_265_2

	if not arg_265_0:Find("subText") then
		cloneTplTo = var_265_0
		var_265_2 = var_265_0(arg_265_0, arg_265_0, "subText")
		eachChild = var_265_0

		var_265_0(arg_265_0, function(arg_266_0)
			setActive = var_2_10001

			var_2_10001(arg_266_0, arg_266_0 == var_265_2)

			return
		end)

		local var_265_3 = arg_265_0

		var_265_0 = arg_265_0.GetComponent
		typeof = var_7
		Text = var_1_10009
		var_265_0 = var_265_0(var_265_3, var_7(var_1_10009))
		var_265_0.enabled = false
	end

	setScrollText = var_265_0

	var_265_0(var_265_2, arg_265_1)

	return
end

local var_0_381 = changeToScrollText

local function var_0_382(arg_267_0, arg_267_1, arg_267_2, arg_267_3)
	GetPerceptualSize = var_1_10004

	local var_267_0 = arg_267_3 < var_1_10004(arg_267_2)

	setActive = var_1_10005

	var_1_10005(arg_267_1, var_267_0)

	setActive = var_1_10005

	var_1_10005(arg_267_0, not var_267_0)

	if var_267_0 then
		setScrollText = var_1_10005

		var_1_10005(arg_267_1, arg_267_2)
	else
		setText = var_1_10005

		var_1_10005(arg_267_0, arg_267_2)
	end

	return
end

local var_0_383 = setScrollTextWithSize
local var_0_384
local var_0_385
local var_0_386
local var_0_387

local function var_0_388(arg_268_0, arg_268_1, arg_268_2)
	local var_268_0 = arg_268_0:Find("base")

	Equipment = var_1_10004

	local var_268_1, var_268_2, var_268_3 = var_1_10004.GetInfoTrans(arg_268_1, arg_268_2)
	local var_268_4

	if arg_268_1.nextValue then
		var_268_4 = {
			name = arg_268_1.name,
			type = arg_268_1.type,
			value = arg_268_1.nextValue
		}
		Equipment = var_1_10008

		local var_268_5

		var_1_10008, var_268_5 = var_1_10008.GetInfoTrans(var_268_4, arg_268_2)

		local var_268_6 = var_268_2

		setColorStr = var_11

		local var_268_7 = "   >   " .. var_268_5

		COLOR_GREEN = var_14
		var_268_2 = var_268_6 .. var_11(var_268_7, var_14)
	end

	setText = var_268_4

	var_268_4(var_268_0:Find("name"), var_268_1)

	if var_268_3 then
		var_268_4 = "<color=#afff72>(+"
		ys = var_1_10008
		var_268_4 = var_268_4 .. var_1_10008.Battle.BattleConst.UltimateBonus.AuxBoostValue * 100 .. "%)</color>"
		setText = var_8

		var_8(var_268_0:Find("value"), var_268_2 .. var_268_4)
	else
		setText = var_268_4

		var_268_4(var_268_0:Find("value"), var_268_2)
	end

	setActive = var_268_4

	local var_268_8 = var_268_0:Find("value/up")
	local var_268_9

	if arg_268_1.compare then
		var_268_9 = arg_268_1.compare > 0
	end

	var_268_4(var_268_8, var_268_9)

	setActive = var_268_4

	local var_268_10 = var_268_0:Find("value/down")
	local var_268_11

	if arg_268_1.compare then
		var_268_11 = arg_268_1.compare < 0
	end

	var_268_4(var_268_10, var_268_11)

	triggerToggle = var_268_4

	var_268_4(var_268_0, arg_268_1.lock_open)

	local var_268_13

	if not arg_268_1.lock_open and arg_268_1.sub and #arg_268_1.sub > 0 then
		GetComponent = var_268_13

		local var_268_12 = var_268_0

		typeof = var_10
		Toggle = var_12
		var_268_13 = var_268_13(var_268_12, var_10(var_12))
		var_268_13.enabled = true
	else
		setActive = var_268_13

		var_268_13(var_268_0:Find("name/close"), false)

		setActive = var_268_13

		var_268_13(var_268_0:Find("name/open"), false)

		GetComponent = var_268_13

		local var_268_14 = var_268_0

		typeof = var_10
		Toggle = var_12
		var_268_13(var_268_14, var_10(var_12)).enabled = false
	end

	return
end

local function var_0_389(arg_269_0, arg_269_1, arg_269_2, arg_269_3)
	var_0_388(arg_269_0, arg_269_2, arg_269_3)

	if not arg_269_2.sub or #arg_269_2.sub == 0 then
		return
	end

	var_0_386(arg_269_0:Find("subs"), arg_269_1, arg_269_2.sub, arg_269_3)

	return
end

function var_0_386(arg_270_0, arg_270_1, arg_270_2, arg_270_3)
	removeAllChildren = var_1_10004

	var_1_10004(arg_270_0)
	var_0_387(arg_270_0, arg_270_1, arg_270_2, arg_270_3)

	return
end

function var_0_387(arg_271_0, arg_271_1, arg_271_2, arg_271_3)
	ipairs = var_1_10004

	for iter_271_0, iter_271_1 in var_1_10004(arg_271_2) do
		cloneTplTo = var_1_10009
		var_1_10009 = var_1_10009(arg_271_1, arg_271_0)

		var_0_389(var_1_10009, arg_271_1, iter_271_1, arg_271_3)
	end

	return
end

local function var_0_390(arg_272_0, arg_272_1, arg_272_2, arg_272_3)
	local var_272_0 = arg_272_0:Find("attr_tpl")

	var_0_386(arg_272_0:Find("attrs"), var_272_0, arg_272_1.attrs, arg_272_3)

	setActive = var_272_1

	var_272_1(arg_272_0:Find("skill"), arg_272_2)

	local var_272_1

	if arg_272_2 then
		var_272_1 = var_0_389

		local var_272_2 = arg_272_0:Find("skill/attr")
		local var_272_3 = var_272_0
		local var_272_4 = {}

		i18n = var_10
		var_272_4.name = var_10("skill")
		setColorStr = var_10
		var_272_4.value = var_10(arg_272_2.name, "#FFDE00FF")

		var_272_1(var_272_2, var_272_3, var_272_4, arg_272_3)

		setText = var_272_1

		local var_272_5 = arg_272_0:Find("skill/value/Text")

		getSkillDescGet = var_272_3

		var_272_1(var_272_5, var_272_3(arg_272_2.id))
	end

	setActive = var_272_1

	var_272_1(arg_272_0:Find("weapon"), #arg_272_1.weapon.sub > 0)

	if #arg_272_1.weapon.sub > 0 then
		var_0_386(arg_272_0:Find("weapon"), var_272_0, {
			arg_272_1.weapon
		}, arg_272_3)
	end

	setActive = var_5

	var_5(arg_272_0:Find("equip_info"), #arg_272_1.equipInfo.sub > 0)

	if #arg_272_1.equipInfo.sub > 0 then
		var_0_386(arg_272_0:Find("equip_info"), var_272_0, {
			arg_272_1.equipInfo
		}, arg_272_3)
	end

	local var_272_6 = var_0_389
	local var_272_7 = arg_272_0:Find("part/attr")
	local var_272_8 = var_272_0
	local var_272_9 = {}

	i18n = var_10
	var_272_9.name = var_10("equip_info_23")

	var_272_6(var_272_7, var_272_8, var_272_9, arg_272_3)

	local var_272_10 = arg_272_0:Find("part/value")
	local var_272_11 = var_5.Find(var_272_10, "label")
	local var_272_12 = {}
	local var_272_13 = {}

	if #arg_272_1.part[1] == 0 and #arg_272_1.part[2] == 0 then
		setmetatable = var_9

		var_9(var_272_12, {
			__index = function(arg_273_0, arg_273_1)
				return true
			end
		})

		setmetatable = var_9

		var_9(var_272_13, {
			__index = function(arg_274_0, arg_274_1)
				return true
			end
		})
	else
		ipairs = var_9

		for iter_272_0, iter_272_3 in var_9(arg_272_1.part[1]) do
			var_272_12[iter_272_3] = true
		end

		ipairs = var_9

		for iter_272_2, iter_272_3 in var_9(arg_272_1.part[2]) do
			var_272_13[iter_272_3] = true
		end
	end

	ShipType = var_9

	local var_272_14 = var_9.MergeFengFanType

	ShipType = var_1_10011

	local var_272_15 = var_1_10011.FilterOverQuZhuType

	ShipType = iter_272_3

	local var_272_16 = var_272_14(var_272_15(iter_272_3.AllShipType), var_272_12, var_272_13)

	UIItemList = var_10

	var_10.StaticAlign(var_5, var_272_11, #var_272_16, function(arg_275_0, arg_275_1, arg_275_2)
		arg_275_1 = arg_275_1 + 1
		UIItemList = var_2_10003

		if arg_275_0 == var_2_10003.EventUpdate then
			local var_275_0 = var_272_16[arg_275_1]

			GetImageSpriteFromAtlasAsync = var_2_10004

			local var_275_1 = "shiptype"

			ShipType = var_2_10007

			var_2_10004(var_275_1, var_2_10007.Type2CNLabel(var_275_0), arg_275_2)

			setActive = var_2_10004

			local var_275_2 = arg_275_2:Find("main")
			local var_275_3

			if var_272_12[var_275_0] then
				var_275_3 = not var_272_13[var_275_0]
			end

			var_2_10004(var_275_2, var_275_3)

			setActive = var_2_10004

			local var_275_4 = arg_275_2:Find("sub")
			local var_275_5

			if var_272_13[var_275_0] then
				var_275_5 = not var_272_12[var_275_0]
			end

			var_2_10004(var_275_4, var_275_5)

			setImageAlpha = var_2_10004

			var_2_10004(arg_275_2, not var_272_12[var_275_0] and not var_272_13[var_275_0] and 0.3 or 1)
		end

		return
	end)

	return
end

local var_0_391 = updateEquipInfo

local function var_0_392(arg_276_0, arg_276_1, arg_276_2)
	local var_276_0 = arg_276_0:Find("attr_tpl")

	var_0_386(arg_276_0:Find("attrs"), var_276_0, arg_276_1.attrs, arg_276_2)

	setActive = var_4

	var_4(arg_276_0:Find("weapon"), #arg_276_1.weapon.sub > 0)

	if #arg_276_1.weapon.sub > 0 then
		var_0_386(arg_276_0:Find("weapon"), var_276_0, {
			arg_276_1.weapon
		}, arg_276_2)
	end

	setActive = var_4

	var_4(arg_276_0:Find("equip_info"), #arg_276_1.equipInfo.sub > 0)

	if #arg_276_1.equipInfo.sub > 0 then
		var_0_386(arg_276_0:Find("equip_info"), var_276_0, {
			arg_276_1.equipInfo
		}, arg_276_2)
	end

	return
end

local var_0_393 = updateEquipUpgradeInfo

local function var_0_394(arg_277_0, arg_277_1)
	local var_277_0 = arg_277_0.parent
	local var_277_1 = arg_277_0
	local var_277_2 = arg_277_0.SetParent

	pg = var_1_10006

	var_277_2(var_277_1, var_1_10006.LayerWeightMgr.GetInstance().uiOrigin, false)

	isActive = var_277_2

	local var_277_4

	if var_277_2(arg_277_0) then
		GetOrAddComponent = var_277_4

		local var_277_3 = arg_277_0

		typeof = var_6
		Canvas = var_1_10008
		var_277_4 = var_277_4(var_277_3, var_6(var_1_10008))
		var_277_4.overrideSorting = arg_277_1
	else
		setActive = var_277_4

		var_277_4(arg_277_0, true)

		GetOrAddComponent = var_277_4

		local var_277_5 = arg_277_0

		typeof = var_6
		Canvas = var_1_10008

		local var_277_6 = var_277_4(var_277_5, var_6(var_1_10008))

		var_277_6.overrideSorting = arg_277_1
		setActive = var_277_6

		var_277_6(arg_277_0, false)
	end

	arg_277_0:SetParent(var_277_0, false)

	return
end

local var_0_395 = SetCanvasOverrideSorting

local function var_0_396(arg_278_0, arg_278_1)
	local var_278_0 = {}
	local var_278_1 = arg_278_0
	local var_278_2 = arg_278_0.GetComponentsInChildren

	typeof = var_1_10006
	Renderer = var_1_10008

	local var_278_3 = var_278_2(var_278_1, var_1_10006(var_1_10008), true)
	local var_278_4 = var_3.ToTable(var_278_3)

	table = var_1_10004

	var_1_10004.insertto(var_278_0, var_278_4)

	local var_278_5 = arg_278_0
	local var_278_6 = arg_278_0.GetComponentsInChildren

	typeof = var_7
	Canvas = var_1_10009

	local var_278_7 = var_278_6(var_278_5, var_7(var_1_10009), true)
	local var_278_8 = var_4.ToTable(var_278_7)

	table = var_278_3

	var_278_3.insertto(var_278_0, var_278_8)

	ipairs = var_5

	for iter_278_0, iter_278_1 in var_5(var_278_0) do
		iter_278_1.sortingOrder = arg_278_1
	end

	return
end

local var_0_397 = SetTFLayerOrder

local function var_0_398(arg_279_0, arg_279_1)
	GameObject = var_1_10002

	local var_279_0 = var_1_10002.New()

	if arg_279_0 then
		var_279_0.name = "model"
	end

	if not arg_279_1 then
		::label_279_0::

		Layer = var_1_10003
		var_1_10003 = var_1_10003.UI
	end

	var_279_0.layer = var_1_10003
	GetOrAddComponent = var_1_10003

	return var_1_10003(var_279_0, "RectTransform")
end

local var_0_399 = createNewGameObject

local function var_0_400(arg_280_0)
	type = var_1_10001

	if var_1_10001(arg_280_0) ~= "table" then
		type = var_1

		if var_1(arg_280_0) ~= "userdata" then
			return arg_280_0
		end
	end

	setmetatable = var_1

	local var_280_0 = var_1({
		__index = arg_280_0
	}, arg_280_0)

	setmetatable = var_1_10002

	return var_1_10002({}, var_280_0)
end

local var_0_401 = CreateShell

local function var_0_402(arg_281_0)
	GetComponent = var_1_10001

	local var_281_0 = arg_281_0

	typeof = var_1_10004
	Camera = var_1_10006

	local var_281_1 = var_1_10001(var_281_0, var_1_10004(var_1_10006))
	local var_281_2 = 1.7777777777777777

	Screen = var_281_0

	local var_281_3 = var_281_0.width

	Screen = var_4

	if var_281_3 / var_4.height < var_281_2 then
		local var_281_4 = var_3 / var_281_2

		var_281_1.rect = var_0_10000.Rect.New(0, (1 - var_281_4) / 2, 1, var_281_4)
	end

	return
end

local var_0_403 = CameraFittingSettin

local function var_0_404(arg_282_0, arg_282_1)
	PLATFORM_CODE = var_1_10002
	PLATFORM_US = var_1_10003

	if var_1_10002 ~= var_1_10003 then
		local var_282_0 = arg_282_0:gsub(" ", " ")

		arg_282_0 = arg_282_0.gsub(var_282_0, "\t", "    ")
	end

	if not arg_282_1 then
		arg_282_0 = arg_282_0:gsub("\n", " ")
	end

	return arg_282_0
end

local var_0_405 = SwitchSpecialChar

local function var_0_406(arg_283_0, arg_283_1)
	local var_283_0 = {}

	ipairs = var_1_10003

	for iter_283_0, iter_283_1 in var_1_10003(arg_283_0) do
		var_283_0[iter_283_0] = iter_283_1[1]()
	end

	arg_283_1()

	ipairs = var_3

	for iter_283_2, iter_283_3 in var_3(arg_283_0) do
		if var_283_0[iter_283_2] ~= iter_283_3[1]() then
			iter_283_3[2]()
		end

		var_283_0[iter_283_2] = iter_283_3[1]()
	end

	return
end

local var_0_407 = AfterCheck

local function var_0_408(arg_284_0, arg_284_1)
	local var_284_0 = {}

	local function var_284_1(arg_285_0, arg_285_1)
		local var_285_0 = var_284_0
		local var_285_1

		if not var_284_0[arg_285_0] then
			var_285_1 = {}
		end

		var_285_0[arg_285_0] = var_285_1

		local var_285_2 = var_284_0[arg_285_0]
		local var_285_3

		if not var_284_0[arg_285_0][arg_285_1] then
			var_285_3 = arg_284_0[arg_285_0](arg_285_1)
		end

		var_285_2[arg_285_1] = var_285_3

		return var_284_0[arg_285_0][arg_285_1]
	end

	return function(arg_286_0, arg_286_1)
		local var_286_0 = 1

		while var_286_0 <= #arg_284_0 do
			if var_284_1(var_286_0, arg_286_0) == var_284_1(var_286_0, arg_286_1) then
				var_286_0 = var_286_0 + 1
			else
				return var_3 < var_4
			end
		end

		tobool = var_3

		return var_3(arg_284_1)
	end
end

local var_0_409 = CompareFuncs

local function var_0_410(arg_287_0)
	local var_287_0 = {}
	local var_287_1 = 1

	while var_287_1 <= #arg_287_0 do
		local var_287_2 = arg_287_0[var_287_1].type
		local var_287_3 = arg_287_0[var_287_1].id
		local var_287_4

		if not var_287_0[var_287_2] then
			var_287_4 = {}
		end

		var_287_0[var_287_2] = var_287_4

		if var_287_0[var_287_2][var_287_3] then
			local var_287_5 = arg_287_0[var_287_0[var_287_2][var_287_3]]

			table = var_1_10006
			var_1_10006 = var_1_10006.remove(arg_287_0, var_287_1)
			var_287_5.count = var_287_5.count + var_1_10006.count
		else
			var_287_0[var_287_2][var_287_3] = var_287_1
			var_287_1 = var_287_1 + 1
		end
	end

	local var_287_6 = {
		function(arg_288_0)
			local var_288_0 = arg_288_0.type
			local var_288_1 = arg_288_0.id

			DROP_TYPE_SHIP = var_2_10003

			if var_288_0 == var_2_10003 then
				return 1
			else
				DROP_TYPE_RESOURCE = var_2_10003

				if var_288_0 == var_2_10003 then
					if var_288_1 == 1 then
						return 2
					else
						return 3
					end
				else
					DROP_TYPE_ITEM = var_2_10003

					if var_288_0 == var_2_10003 then
						if var_288_1 == 2 then
							return 4
						elseif var_288_1 == 59900 then
							return 5
						else
							Item = var_2_10003

							local var_288_2

							if not var_2_10003.getConfigData(var_288_1) or not var_2_10003.type then
								var_288_2 = 0
							end

							if var_288_2 == 9 then
								return 6
							elseif var_288_2 == 5 then
								return 7
							elseif var_288_2 == 4 then
								return 8
							elseif var_288_2 == 7 then
								return 9
							end
						end
					else
						DROP_TYPE_VITEM = var_2_10003

						if var_288_0 == var_2_10003 and var_288_1 == 3 then
							return 4
						end
					end
				end
			end

			return 100
		end,
		function(arg_289_0)
			local var_289_0
			local var_289_1 = arg_289_0.type

			DROP_TYPE_SHIP = var_2_10003

			if var_289_1 == var_2_10003 then
				pg = var_289_1
				var_289_0 = var_289_1.ship_data_statistics[arg_289_0.id]
			else
				local var_289_2 = arg_289_0.type

				DROP_TYPE_ITEM = var_2_10003

				if var_289_2 == var_2_10003 then
					Item = var_289_2
					var_289_0 = var_289_2.getConfigData(arg_289_0.id)
				end
			end

			local var_289_3

			if not var_289_0 or not var_289_0.rarity then
				var_289_3 = 0
			end

			return var_289_3 * -1
		end,
		function(arg_290_0)
			return arg_290_0.id
		end
	}

	table = var_4

	local var_287_7 = var_4.sort
	local var_287_8 = arg_287_0

	CompareFuncs = var_1_10007

	var_287_7(var_287_8, var_1_10007(var_287_6))

	return
end

local var_0_411 = DropResultIntegration

local function var_0_412()
	local var_291_0 = {}

	pg = var_1_10001

	local var_291_1 = var_1_10001.TimeMgr.GetInstance()
	local var_291_2 = var_1.GetServerTime(var_291_1)

	ipairs = var_1_10002
	pg = var_1_10004

	for iter_291_0, iter_291_1 in var_1_10002(var_1_10004.login.all) do
		pg = var_1_10007

		if var_1_10007.login[iter_291_1].date ~= "stop" then
			parseTimeConfig = var_1_10007
			pg = var_1_10009

			local var_291_3

			var_1_10007, var_291_3 = var_1_10007(var_1_10009.login[iter_291_1].date)
			assert = var_1_10009

			var_1_10009(not var_291_3)

			pg = var_1_10009
			var_1_10011 = var_1_10009.TimeMgr.GetInstance()

			if var_1_10009.inTime(var_1_10011, var_1_10007, var_291_2) then
				table = var_1_10009

				var_1_10009.insert(var_291_0, iter_291_1)
			end
		end
	end

	local function var_291_4(arg_292_0)
		pg = var_2_10001

		local var_292_0 = var_2_10001.login[arg_292_0].effective_channel

		type = var_2_10002

		if var_2_10002(var_292_0) == "table" then
			return var_292_0
		end

		if not var_292_0 or var_292_0 <= 0 then
			return {}
		end

		return {
			var_292_0
		}
	end

	local var_291_5 = {}

	PLATFORM_CODE = var_291_7
	PLATFORM_CH = iter_291_0

	local var_291_7

	if var_291_7 == iter_291_0 then
		pg = var_291_7

		local var_291_6 = var_291_7.SdkMgr.GetInstance()

		var_291_7 = var_291_7.GetChannelUIDIncludeHarmony(var_291_6)
		ipairs = iter_291_0

		for iter_291_2, iter_291_3 in iter_291_0(var_291_0) do
			local var_291_8 = var_291_4(iter_291_3)

			_ = var_1_10011

			if var_1_10011.any(var_291_8, function(arg_293_0)
				return arg_293_0 == var_291_7
			end) or #var_291_8 == 0 then
				table = var_1_10011

				var_1_10011.insert(var_291_5, iter_291_3)
			end
		end
	else
		ipairs = var_291_7

		for iter_291_4, iter_291_5 in var_291_7(var_291_0) do
			if #var_291_4(iter_291_5) == 0 then
				table = var_10

				var_10.insert(var_291_5, iter_291_5)
			end
		end
	end

	if #var_291_5 <= 0 then
		return 1
	end

	if #var_291_5 == 1 then
		return var_291_5[1]
	end

	table = var_4

	var_4.sort(var_291_5, function(arg_294_0, arg_294_1)
		local var_294_0 = var_291_4(arg_294_0)
		local var_294_1 = var_291_4(arg_294_1)

		if #var_294_0 == #var_294_1 then
			return arg_294_1 < arg_294_0
		else
			return #var_294_0 > #var_294_1
		end

		return
	end)

	return var_291_5[1]
end

local function var_0_413()
	LOGIN_HX = var_1_10000

	if var_1_10000 then
		PlayerProxy = var_1_10000
		var_1_10000 = var_1_10000.GetDeviceMaxPlayerLevel()
		pg = var_1_10001
		var_1_10000 = var_1_10000 <= var_1_10001.gameset.LOGIN_HX_LV.key_value
	end

	if var_1_10000 then
		return false, "login", "", false, ""
	end

	pg = var_1_10001

	local var_295_0 = var_1_10001.TimeMgr.GetInstance()
	local var_295_1 = var_1.GetServerTime(var_295_0)
	local var_295_2 = var_0_412()

	pg = var_295_0

	local var_295_3 = var_295_0.login[var_295_2].login_static ~= "" and var_295_3 or "login"

	pg = var_1_10004

	local var_295_4 = var_1_10004.login[var_295_2].login_cri ~= "" and true or false

	pg = var_1_10006

	local var_295_5 = var_1_10006.login[var_295_2].op_play == 1 and true or false

	noEmptyStr = var_1_10007
	pg = var_1_10009

	local var_295_6 = var_1_10007(var_1_10009.login[var_295_2].op_time)
	local var_295_7 = ""

	if not var_295_6 or var_295_6 == "stop" then
		var_295_5 = false
	else
		parseTimeConfig = var_9
		pg = var_1_10011

		local var_295_8, var_295_9 = var_9(var_1_10011.login[var_295_2].date)

		assert = var_1_10011

		var_1_10011(not var_295_9)

		table = var_1_10011
		var_295_7 = var_1_10011.concat(var_295_8[2][1])
		pg = var_1_10011

		local var_295_10 = var_1_10011.TimeMgr.GetInstance()

		if not var_1_10011.inTime(var_295_10, var_295_8, var_295_1) then
			var_295_5 = false
		end
	end

	local var_295_11 = var_295_4
	local var_295_12 = var_295_4 and var_4 or var_295_3

	pg = var_1_10011

	return var_295_11, var_295_12, var_1_10011.login[var_295_2].bgm, var_295_5, var_295_7
end

local var_0_414 = getLoginConfig

local function var_0_415(arg_296_0, arg_296_1, arg_296_2)
	local var_296_0 = {}
	local var_296_1

	seriesAsync = var_1_10005

	var_1_10005({
		function(arg_297_0)
			if arg_296_0.childCount > 0 then
				local var_297_0 = arg_296_0

				var_296_1 = var_1.GetChild(var_297_0, 0)

				arg_297_0()
			else
				LoadAndInstantiateAsync = var_1

				var_1("template", "intimacytpl", function(arg_298_0)
					if arg_296_0.childCount == 0 then
						tf = var_1
						var_296_1 = var_1(arg_298_0)
						setParent = var_1

						var_1(var_296_1, arg_296_0)
						arg_297_0()
					end

					return
				end)
			end

			return
		end,
		function(arg_299_0)
			setImageAlpha = var_2_10001

			var_2_10001(var_296_1, arg_296_2 and 0 or 1)

			eachChild = var_2_10001

			var_2_10001(var_296_1, function(arg_300_0)
				setActive = var_3_10001

				var_3_10001(arg_300_0, false)

				return
			end)

			if arg_296_2 then
				local var_299_0 = var_296_1

				if not var_1.Find(var_299_0, arg_296_2 .. "(Clone)") then
					LoadAndInstantiateAsync = var_2_10002

					var_2_10002("ui", arg_296_2, function(arg_301_0)
						setParent = var_3_10001

						var_3_10001(arg_301_0, var_296_1)

						setActive = var_3_10001

						var_3_10001(arg_301_0, true)

						return
					end)
				else
					setActive = var_2_10002

					var_2_10002(var_1, true)
				end
			elseif arg_296_1 then
				setImageSprite = var_1

				local var_299_1 = var_296_1

				GetSpriteFromAtlas = var_4

				var_1(var_299_1, var_4("energy", arg_296_1), true)
			else
				assert = var_1

				var_1(false, "param error")
			end

			return
		end
	})

	return
end

local var_0_416 = setIntimacyIcon
local var_0_417

local function var_0_418()
	local var_302_0

	if not var_0_417 then
		getProxy = var_302_0
		WorldProxy = var_1_10002
		var_302_0 = var_302_0(var_1_10002)
	end

	var_0_417 = var_302_0

	local var_302_1

	if var_0_417 then
		var_302_1 = var_0_417.world
	end

	return var_302_1
end

local var_0_419 = nowWorld

local function var_0_420()
	local var_303_0 = var_0_417.world

	var_0.Dispose(var_303_0)

	var_0_417.world = nil
	var_0_417 = nil

	return
end

local var_0_421 = removeWorld

local function var_0_422(arg_304_0, arg_304_1, arg_304_2, ...)
	::label_304_0::

	type = var_1_10003

	if var_1_10003(arg_304_1[arg_304_0]) ~= "function" then
		repeat
			if arg_304_1[arg_304_0] == nil then
				existCall = var_1_10003

				return var_1_10003(arg_304_2, ...)
			else
				arg_304_0 = arg_304_1[arg_304_0]
			end

			goto label_304_0
		until true
	end

	return arg_304_1[arg_304_0](...)
end

local var_0_423 = switch

local function var_0_424(arg_305_0)
	type = var_1_10001

	if var_1_10001(arg_305_0[1]) == "table" then
		return arg_305_0[2], arg_305_0[1]
	else
		return arg_305_0
	end

	return
end

local var_0_425 = parseTimeConfig
local var_0_426 = {
	__add = function(arg_306_0, arg_306_1)
		NewPos = var_1_10002

		return var_1_10002(arg_306_0.x + arg_306_1.x, arg_306_0.y + arg_306_1.y)
	end,
	__sub = function(arg_307_0, arg_307_1)
		NewPos = var_1_10002

		return var_1_10002(arg_307_0.x - arg_307_1.x, arg_307_0.y - arg_307_1.y)
	end,
	__mul = function(arg_308_0, arg_308_1)
		type = var_1_10002

		if var_1_10002(arg_308_1) == "number" then
			NewPos = var_2

			return var_2(arg_308_0.x * arg_308_1, arg_308_0.y * arg_308_1)
		else
			NewPos = var_2

			return var_2(arg_308_0.x * arg_308_1.x, arg_308_0.y * arg_308_1.y)
		end

		return
	end,
	__eq = function(arg_309_0, arg_309_1)
		return arg_309_0.x == arg_309_1.x and arg_309_0.y == arg_309_1.y
	end,
	__tostring = function(arg_310_0)
		return arg_310_0.x .. "_" .. arg_310_0.y
	end
}

local function var_0_427(arg_311_0, arg_311_1)
	assert = var_1_10002

	var_1_10002(arg_311_0 and arg_311_1)

	setmetatable = var_1_10002

	local var_311_0 = var_1_10002({
		x = arg_311_0,
		y = arg_311_1
	}, var_0_426)

	function var_311_0.SqrMagnitude(arg_312_0)
		return arg_312_0.x * arg_312_0.x + arg_312_0.y * arg_312_0.y
	end

	function var_311_0.Normalize(arg_313_0)
		local var_313_0 = arg_313_0:SqrMagnitude()

		if 1e-05 < var_313_0 then
			math = var_2

			return arg_313_0 * (1 / var_2.sqrt(var_313_0))
		else
			NewPos = var_2

			return var_2(0, 0)
		end

		return
	end

	return var_311_0
end

local var_0_428 = NewPos
local var_0_429

local function var_0_430()
	warning = var_1_10000
	Time = var_1_10002

	local var_314_0 = var_1_10002.realtimeSinceStartup
	local var_314_1

	if not var_0_429 then
		Time = var_314_1
		var_314_1 = var_314_1.realtimeSinceStartup
	end

	local var_314_2 = var_314_0 - var_314_1

	Time = var_314_1

	var_1_10000(var_314_2, var_314_1.realtimeSinceStartup)

	Time = var_1_10000
	var_0_429 = var_1_10000.realtimeSinceStartup

	return
end

local var_0_431 = Timekeeping

local function var_0_432(arg_315_0)
	string = var_1_10001

	return (var_1_10001.char(226, 133, 160 + (arg_315_0 - 1)))
end

local var_0_433 = GetRomanDigit

local function var_0_434(arg_316_0)
	if 0 < arg_316_0 and arg_316_0 <= 10 then
		GetRomanDigit = var_1

		return var_1(arg_316_0)
	else
		switch = var_1

		return var_1(arg_316_0, {
			[11] = function()
				return "XI"
			end
		}, function()
			return arg_316_0
		end)
	end

	return
end

local var_0_435 = GetRomanDigitPlus

local function var_0_436(arg_319_0, arg_319_1)
	local var_319_0 = arg_319_0
	local var_319_1 = arg_319_0.GetComponent

	typeof = var_1_10005
	Animator = var_1_10007

	local var_319_2 = var_319_1(var_319_0, var_1_10005(var_1_10007))

	var_2.Play(var_319_2, arg_319_1, -1, 0)

	return
end

local var_0_437 = quickPlayAnimator

local function var_0_438(arg_320_0, arg_320_1)
	local var_320_0 = arg_320_0
	local var_320_1 = arg_320_0.GetComponent

	typeof = var_1_10005
	Animator = var_1_10007

	local var_320_2 = var_320_1(var_320_0, var_1_10005(var_1_10007))

	var_320_2.enabled = true
	Animator = var_3

	local var_320_3 = var_3.StringToHash(arg_320_1)

	if var_320_2:HasState(0, var_320_3) then
		var_320_2:Play(arg_320_1, -1, 0)
	end

	return
end

local var_0_439 = quickCheckAndPlayAnimator

local function var_0_440(arg_321_0, arg_321_1)
	local var_321_0 = arg_321_0
	local var_321_1 = arg_321_0.GetComponent

	typeof = var_1_10005
	Animation = var_1_10007

	local var_321_2 = var_321_1(var_321_0, var_1_10005(var_1_10007))

	var_2.Stop(var_321_2)
	var_2:Play(arg_321_1)

	return
end

local var_0_441 = quickPlayAnimation

local function var_0_442(arg_322_0)
	pg = var_1_10001

	local var_322_0 = var_1_10001.survey_data_template[arg_322_0]
	local var_322_1

	IsUnityEditor = var_1_10003

	if not var_1_10003 then
		PLATFORM_CODE = var_1_10003
		PLATFORM_CH = var_1_10004

		if var_1_10003 == var_1_10004 then
			getProxy = var_1_10003
			UserProxy = var_1_10005
			var_1_10005 = var_1_10003(var_1_10005)
			var_1_10003 = var_1_10003.GetCacheGatewayInServerLogined(var_1_10005)
			PLATFORM_ANDROID = var_1_10004

			if var_1_10003 == var_1_10004 then
				LuaHelper = var_1_10004
				var_1_10004 = var_1_10004.GetCHPackageType()
				PACKAGE_TYPE_BILI = var_1_10005

				if var_1_10004 == var_1_10005 then
					var_322_1 = var_322_0.main_url
				else
					var_322_1 = var_322_0.uo_url
				end
			else
				PLATFORM_IPHONEPLAYER = var_1_10004

				if var_1_10003 == var_1_10004 then
					var_322_1 = var_322_0.ios_url
				end
			end

			goto label_322_0
		end

		PLATFORM_CODE = var_1_10003
		PLATFORM_US = var_1_10004

		if var_1_10003 ~= var_1_10004 then
			PLATFORM_CODE = var_1_10003
			PLATFORM_JP = var_1_10004

			if var_1_10003 ~= var_1_10004 then
				PLATFORM_CODE = var_1_10003
				PLATFORM_KR = var_1_10004

				if var_1_10003 == var_1_10004 then
					var_322_1 = var_322_0.main_url

					goto label_322_0

					var_322_1 = var_322_0.main_url
				end

				::label_322_0::

				getProxy = var_1_10003
				PlayerProxy = var_1_10005

				local var_322_2 = var_1_10003(var_1_10005)
				local var_322_3 = var_3.getRawData(var_322_2).id

				getProxy = var_1_10004
				UserProxy = var_1_10006

				local var_322_4 = var_1_10004(var_1_10006)
				local var_322_5

				if not var_4.getRawData(var_322_4).arg2 then
					var_322_5 = ""
				end

				local var_322_6

				PLATFORM = var_322_4
				PLATFORM_ANDROID = var_1_10007

				if var_322_4 == var_1_10007 then
					var_322_6 = 1
				else
					PLATFORM = var_322_4
					PLATFORM_IPHONEPLAYER = var_1_10007
					var_322_6 = var_322_4 == var_1_10007 and 2 or 3
				end

				getProxy = var_322_4
				UserProxy = var_1_10008

				local var_322_7 = var_322_4(var_1_10008)
				local var_322_8 = var_6.getRawData(var_322_7)

				getProxy = var_1_10007
				ServerProxy = var_1_10009

				local var_322_9 = var_1_10007(var_1_10009)
				local var_322_10 = var_7.getRawData(var_322_9)
				local var_322_11

				if not var_322_8 or not var_322_8.server then
					var_322_11 = 0
				end

				local var_322_12

				if not var_322_10[var_322_11] or not var_7.id then
					var_322_12 = ""
				end

				getProxy = var_322_9
				PlayerProxy = var_1_10011

				local var_322_13 = var_322_9(var_1_10011)
				local var_322_14 = var_9.getRawData(var_322_13).level
				local var_322_15 = var_322_3 .. "_" .. arg_322_0
				local var_322_16 = var_322_1
				local var_322_17 = {
					var_322_3,
					var_322_5,
					var_322_6,
					var_322_12,
					var_322_14,
					var_322_15
				}

				if var_322_16 then
					ipairs = var_1_10013

					for iter_322_0, iter_322_1 in var_1_10013(var_322_17) do
						string = var_1_10018
						var_1_10018 = var_1_10018.gsub

						local var_322_18 = var_322_16
						local var_322_19 = "$" .. iter_322_0

						tostring = var_22
						var_322_16 = var_1_10018(var_322_18, var_322_19, var_22(iter_322_1))
					end
				end

				originalPrint = var_1_10013

				local var_322_20 = "survey url"

				tostring = iter_322_0

				var_1_10013(var_322_20, iter_322_0(var_322_16))

				return var_322_16
			end
		end
	end
end

local var_0_443 = getSurveyUrl

local function var_0_444()
	PLATFORM_CH = var_1_10000
	PLATFORM_CODE = var_1_10001

	if var_1_10000 == var_1_10001 then
		return "￥"
	else
		PLATFORM_JP = var_1_10000
		PLATFORM_CODE = var_1_10001

		if var_1_10000 == var_1_10001 then
			return "￥"
		else
			PLATFORM_KR = var_1_10000
			PLATFORM_CODE = var_1_10001

			if var_1_10000 == var_1_10001 then
				return "₩"
			else
				PLATFORM_US = var_1_10000
				PLATFORM_CODE = var_1_10001

				if var_1_10000 == var_1_10001 then
					return "$"
				else
					PLATFORM_CHT = var_1_10000
					PLATFORM_CODE = var_1_10001

					if var_1_10000 == var_1_10001 then
						return "TWD"
					end
				end
			end
		end
	end

	return ""
end

local var_0_445 = GetMoneySymbol

local function var_0_446(arg_324_0)
	assert = var_1_10001
	type = var_1_10003

	local var_324_0

	if var_1_10003(arg_324_0) ~= "string" then
		type = var_3

		if var_3(arg_324_0) ~= "table" then
			var_324_0 = false

			goto label_324_0
		end
	end

	var_324_0 = true

	::label_324_0::

	var_1_10001(var_324_0)

	if arg_324_0 == "" then
		return nil
	end

	return arg_324_0
end

local var_0_447 = FilterVarchar

local function var_0_448(arg_325_0)
	pg = var_1_10001

	local var_325_0 = var_1_10001.gameset[arg_325_0]

	assert = var_1_10002

	var_1_10002(var_325_0)

	return {
		var_325_0.key_value,
		var_325_0.description
	}
end

local var_0_449 = getGameset

local function var_0_450(arg_326_0)
	pg = var_1_10001

	local var_326_0 = var_1_10001.dorm3d_set[arg_326_0]

	assert = var_1_10002

	var_1_10002(var_326_0)

	return {
		var_326_0.key_value_int,
		var_326_0.key_value_varchar
	}
end

local var_0_451 = getDorm3dGameset

local function var_0_452(arg_327_0)
	arg_327_0 = arg_327_0 or {}

	local var_327_0 = {}

	DROP_TYPE_ITEM = var_1_10002
	var_327_0[var_1_10002] = {}
	DROP_TYPE_RESOURCE = var_1_10002
	var_327_0[var_1_10002] = {}
	DROP_TYPE_EQUIP = var_1_10002
	var_327_0[var_1_10002] = 0
	DROP_TYPE_SHIP = var_1_10002
	var_327_0[var_1_10002] = 0
	DROP_TYPE_WORLD_ITEM = var_1_10002
	var_327_0[var_1_10002] = 0

	::label_327_0::

	local var_327_1 = #arg_327_0

	if 0 < var_327_1 then
		repeat
			table = var_327_1
			var_327_1 = var_327_1.remove(arg_327_0)
			switch = var_3

			local var_327_2 = var_327_1.type
			local var_327_3 = {}

			DROP_TYPE_ITEM = var_1_10007
			var_327_3[var_1_10007] = function()
				local var_328_0 = var_327_1

				if var_0.getConfig(var_328_0, "open_directly") == 1 then
					ipairs = var_0

					local var_328_1 = var_327_1

					for iter_328_0, iter_328_1 in var_0(var_2.getConfig(var_328_1, "display_icon")) do
						Drop = var_5
						var_5.count = var_5.Create(iter_328_1).count * var_327_1.count
						table = var_6

						var_6.insert(arg_327_0, var_5)
					end
				else
					local var_328_2 = var_327_1
					local var_328_3 = var_0.getSubClass(var_328_2)

					if var_0.IsShipExpType(var_328_3) then
						local var_328_4 = var_327_0[var_327_1.type]
						local var_328_5 = var_327_1.id

						defaultValue = var_328_3
						var_328_4[var_328_5] = var_328_3(var_327_0[var_327_1.type][var_327_1.id], 0) + var_327_1.count
					end
				end

				return
			end
			DROP_TYPE_RESOURCE = var_1_10007
			var_327_3[var_1_10007] = function()
				local var_329_0 = var_327_0[var_327_1.type]
				local var_329_1 = var_327_1.id

				defaultValue = var_2_10002
				var_329_0[var_329_1] = var_2_10002(var_327_0[var_327_1.type][var_327_1.id], 0) + var_327_1.count

				return
			end
			DROP_TYPE_EQUIP = var_1_10007
			var_327_3[var_1_10007] = function()
				var_327_0[var_327_1.type] = var_327_0[var_327_1.type] + var_327_1.count

				return
			end
			DROP_TYPE_SHIP = var_1_10007
			var_327_3[var_1_10007] = function()
				var_327_0[var_327_1.type] = var_327_0[var_327_1.type] + var_327_1.count

				return
			end
			DROP_TYPE_WORLD_ITEM = var_1_10007
			var_327_3[var_1_10007] = function()
				var_327_0[var_327_1.type] = var_327_0[var_327_1.type] + var_327_1.count

				return
			end

			var_3(var_327_2, var_327_3)

			goto label_327_0
		until true
	end

	return var_327_0
end

local var_0_453 = GetItemsOverflowDic

local function var_0_454(arg_333_0, arg_333_1)
	local var_333_0 = {}

	DROP_TYPE_RESOURCE = var_1_10003

	local var_333_1 = arg_333_0[var_1_10003]

	PlayerConst = var_1_10004

	local var_333_2

	if not var_333_1[var_1_10004.ResGold] then
		var_333_2 = 0
	end

	DROP_TYPE_RESOURCE = var_4

	local var_333_3 = arg_333_0[var_4]

	PlayerConst = var_1_10005

	local var_333_4

	if not var_333_3[var_1_10005.ResOil] then
		var_333_4 = 0
	end

	DROP_TYPE_EQUIP = var_5

	local var_333_5 = arg_333_0[var_5]

	DROP_TYPE_SHIP = var_1_10006

	local var_333_6 = arg_333_0[var_1_10006]

	getProxy = var_1_10007
	PlayerProxy = var_1_10009

	local var_333_7 = var_1_10007(var_1_10009)
	local var_333_8 = var_7.getRawData(var_333_7)
	local var_333_9 = false

	if arg_333_1 then
		var_1_10011 = var_333_8

		local var_333_10 = var_333_8.OverStore

		PlayerConst = var_1_10012

		local var_333_11 = var_333_10(var_1_10011, var_1_10012.ResStoreGold, var_333_2)
		local var_333_12 = var_333_8
		local var_333_13 = var_333_8.OverStore

		PlayerConst = var_13

		local var_333_14 = var_333_13(var_333_12, var_13.ResStoreOil, var_333_4)

		if 0 < var_333_11 or 0 < var_333_14 then
			var_333_0.isStoreOverflow = {
				var_333_11,
				var_333_14
			}
		end
	else
		if var_333_2 > 0 then
			var_1_10011 = var_333_8

			if var_333_8.GoldMax(var_1_10011, var_333_2) then
				return false, "gold"
			end
		end

		if var_333_4 > 0 then
			var_1_10011 = var_333_8

			if var_333_8.OilMax(var_1_10011, var_333_4) then
				return false, "oil"
			end
		end
	end

	var_333_0.isExpBookOverflow = {}
	pairs = var_9
	DROP_TYPE_ITEM = var_1_10011

	for iter_333_0, iter_333_1 in var_9(arg_333_0[var_1_10011]) do
		Item = var_1_10014
		var_1_10014 = var_1_10014.getConfigData(iter_333_0)
		getProxy = var_1_10015
		BagProxy = var_1_10017
		var_1_10017 = var_1_10015(var_1_10017)

		if var_1_10015.getItemCountById(var_1_10017, iter_333_0) + iter_333_1 > var_1_10014.max_num then
			table = var_1_10015

			var_1_10015.insert(var_333_0.isExpBookOverflow, iter_333_0)
		end
	end

	getProxy = var_9
	EquipmentProxy = var_11

	local var_333_15 = var_9(var_11)
	local var_333_16 = var_9.getCapacity(var_333_15)

	if 0 < var_333_5 then
		iter_333_0 = var_333_8

		if var_333_8.getMaxEquipmentBag(iter_333_0) <= var_333_16 then
			return false, "equip"
		end
	end

	getProxy = var_10
	BayProxy = iter_333_0

	local var_333_17 = var_10(iter_333_0)
	local var_333_18 = var_10.getShipCount(var_333_17)

	if var_333_6 > 0 and var_333_6 + var_333_18 > var_333_8:getMaxShipBag() then
		return false, "ship"
	end

	return true, var_333_0
end

local var_0_455 = CheckOverflow

local function var_0_456(arg_334_0)
	local var_334_0 = {}

	pairs = var_1_10002

	for iter_334_0, iter_334_1 in var_1_10002(arg_334_0) do
		local var_334_1 = iter_334_1.type

		DROP_TYPE_EQUIP = var_1_10008

		if var_334_1 == var_1_10008 then
			var_1_10009 = iter_334_1

			local var_334_2 = iter_334_1.getConfig(var_1_10009, "group")

			pg = var_1_10008

			if var_1_10008.equip_data_limit[var_334_2] then
				defaultValue = var_1_10009
				var_334_0[var_334_2] = var_1_10009(var_334_0[var_334_2], 0) + iter_334_1.count
			end
		end
	end

	local var_334_3 = {}

	pairs = var_3

	for iter_334_2, iter_334_3 in var_3(var_334_0) do
		pg = var_1_10008
		var_1_10008 = var_1_10008.equip_data_limit[iter_334_2]
		pg = var_1_10009
		var_1_10009 = var_1_10009.equip_data_template.get_id_list_by_group[iter_334_2]
		underscore = var_1_10010

		if var_1_10010.reduce(var_1_10009, 0, function(arg_335_0, arg_335_1)
			getProxy = var_2_10002
			EquipmentProxy = var_2_10004

			local var_335_0 = var_2_10002(var_2_10004)
			local var_335_1

			if not var_2.getEquipmentById(var_335_0, arg_335_1) or not var_2.count then
				var_335_1 = 0
			end

			local var_335_2 = arg_335_0 + var_335_1

			getProxy = var_335_0
			BayProxy = var_2_10006

			local var_335_3 = var_335_0(var_2_10006)

			return var_335_2 + var_4.GetEquipCountInShips(var_335_3, arg_335_1)
		end) + iter_334_3 > var_1_10008.max then
			table = var_11

			var_11.insert(var_334_3, {
				iter_334_2,
				var_1_10010 + iter_334_3 - var_1_10008.max
			})
		end
	end

	if #var_334_3 == 0 then
		return false
	end

	return var_334_3
end

local var_0_457 = CheckEquipLimit

local function var_0_458(arg_336_0)
	getProxy = var_1_10001
	BagProxy = var_1_10003

	local var_336_0 = var_1_10001(var_1_10003)

	pairs = var_1_10002
	DROP_TYPE_ITEM = var_1_10004

	for iter_336_0, iter_336_1 in var_1_10002(arg_336_0[var_1_10004]) do
		local var_336_1 = var_336_0:getItemCountById(iter_336_0) + iter_336_1

		Item = var_1_10008

		if var_1_10008.getConfigData(iter_336_0).max_num < var_336_1 then
			return false
		end
	end

	return true
end

local var_0_459 = CheckShipExpOverflow
local var_0_460 = {
	[11] = "equip_skin_detail_tip",
	[17] = "item_type17_tip2",
	[16] = "item_type16_tip2",
	tech = "techpackage_item_use_confirm",
	[13] = "item_type13_tip2"
}

local function var_0_461(arg_337_0, arg_337_1, arg_337_2)
	Drop = var_1_10003

	var_1_10003.Change(arg_337_2)

	switch = var_3

	local var_337_0 = arg_337_2.type
	local var_337_1 = {}

	DROP_TYPE_ITEM = var_1_10007
	var_337_1[var_1_10007] = function()
		local var_338_0 = arg_337_2
		local var_338_1 = var_0.getConfig(var_338_0, "type")

		Item = var_2_10001

		if var_338_1 == var_2_10001.SKIN_ASSIGNED_TYPE then
			Item = var_338_1

			local var_338_2 = var_338_1.getConfigData(arg_337_2.id).usage_arg[3]

			Item = var_338_0

			if var_338_0.InTimeLimitSkinAssigned(arg_337_2.id) then
				table = var_338_0
				var_338_2 = var_338_0.mergeArray(var_338_1[2], var_338_2, true)
			end

			var_338_0 = {}
			ipairs = var_3

			for iter_338_0, iter_338_1 in var_3(var_338_1[2]) do
				var_338_0[iter_338_1] = true
			end

			onButton = var_3

			local var_338_3 = arg_337_0
			local var_338_4 = arg_337_1

			local function var_338_5()
				local var_339_0 = arg_337_0

				var_0.closeView(var_339_0)

				pg = var_0

				local var_339_1 = var_0.m02
				local var_339_2 = var_0.sendNotification

				GAME = var_3_10003

				local var_339_3 = var_3_10003.LOAD_LAYERS
				local var_339_4 = {}

				getProxy = var_3_10005
				ContextProxy = var_3_10007

				local var_339_5 = var_3_10005(var_3_10007)

				var_339_4.parentContext = var_5.getCurrentContext(var_339_5)
				Context = var_5

				local var_339_6 = var_5.New
				local var_339_7 = {}

				NewSelectSkinLayer = var_3_10008
				var_339_7.viewComponent = var_3_10008
				NewSkinAtlasMediator = var_3_10008
				var_339_7.mediator = var_3_10008

				local var_339_8 = {}

				SelectSkinLayer = var_3_10009
				var_339_8.mode = var_3_10009.MODE_VIEW
				var_339_8.itemId = arg_337_2.id
				underscore = var_9
				var_339_8.selectableSkinList = var_9.map(var_338_2, function(arg_340_0)
					SelectableSkin = var_4_10001

					local var_340_0 = var_4_10001.New
					local var_340_1 = {
						id = arg_340_0
					}
					local var_340_2

					if not var_338_0[arg_340_0] then
						var_340_2 = false
					end

					var_340_1.isTimeLimit = var_340_2

					return var_340_0(var_340_1)
				end)
				var_339_7.data = var_339_8
				var_339_4.context = var_339_6(var_339_7)

				var_339_2(var_339_1, var_339_3, var_339_4)

				return
			end

			SFX_PANEL = var_2_10008

			var_3(var_338_3, var_338_4, var_338_5, var_2_10008)

			setActive = var_3

			var_3(arg_337_1, true)
		else
			getProxy = var_338_1
			TechnologyProxy = var_338_0

			local var_338_6 = var_338_1(var_338_0)
			local var_338_7

			if var_0.getItemCanUnlockBluePrint(var_338_6, arg_337_2.id) then
				var_338_7 = "tech"
			else
				var_338_6 = arg_337_2
				var_338_7 = var_0.getConfig(var_338_6, "type")
			end

			local var_338_8

			if var_0_460[var_338_7] then
				var_338_8 = {
					item2Row = true
				}
				i18n = var_338_6
				var_338_8.content = var_338_6(var_0_460[var_338_7])
				underscore = var_2

				local var_338_9 = var_2.map
				local var_338_10 = arg_337_2

				var_338_8.itemList = var_338_9(var_2_10004.getConfig(var_338_10, "display_icon"), function(arg_341_0)
					Drop = var_3_10001

					return var_3_10001.Create(arg_341_0)
				end)

				if var_338_7 == 11 then
					onButton = var_2
					var_2_10004 = arg_337_0

					local var_338_11 = arg_337_1

					local function var_338_12()
						local var_342_0 = arg_337_0
						local var_342_1 = var_0.emit

						BaseUI = var_3_10003

						var_342_1(var_342_0, var_3_10003.ON_DROP_LIST_OWN, var_338_8)

						return
					end

					SFX_PANEL = var_7

					var_2(var_2_10004, var_338_11, var_338_12, var_7)
				else
					onButton = var_2
					var_2_10004 = arg_337_0

					local var_338_13 = arg_337_1

					local function var_338_14()
						local var_343_0 = arg_337_0
						local var_343_1 = var_0.emit

						BaseUI = var_3_10003

						var_343_1(var_343_0, var_3_10003.ON_DROP_LIST, var_338_8)

						return
					end

					SFX_PANEL = var_7

					var_2(var_2_10004, var_338_13, var_338_14, var_7)
				end
			end

			setActive = var_338_8

			local var_338_15 = arg_337_1

			tobool = var_2_10004

			var_338_8(var_338_15, var_2_10004(var_0_460[var_338_7]))
		end

		return
	end
	DROP_TYPE_EQUIP = var_1_10007
	var_337_1[var_1_10007] = function()
		onButton = var_2_10000

		local var_344_0 = arg_337_0
		local var_344_1 = arg_337_1

		local function var_344_2()
			local var_345_0 = arg_337_0
			local var_345_1 = var_0.emit

			BaseUI = var_3_10003

			var_345_1(var_345_0, var_3_10003.ON_DROP, arg_337_2)

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10000(var_344_0, var_344_1, var_344_2, var_2_10005)

		setActive = var_2_10000

		var_2_10000(arg_337_1, true)

		return
	end
	DROP_TYPE_SPWEAPON = var_1_10007
	var_337_1[var_1_10007] = function()
		onButton = var_2_10000

		local var_346_0 = arg_337_0
		local var_346_1 = arg_337_1

		local function var_346_2()
			local var_347_0 = arg_337_0
			local var_347_1 = var_0.emit

			BaseUI = var_3_10003

			var_347_1(var_347_0, var_3_10003.ON_DROP, arg_337_2)

			return
		end

		SFX_PANEL = var_2_10005

		var_2_10000(var_346_0, var_346_1, var_346_2, var_2_10005)

		setActive = var_2_10000

		var_2_10000(arg_337_1, true)

		return
	end

	var_3(var_337_0, var_337_1, function()
		setActive = var_2_10000

		var_2_10000(arg_337_1, false)

		return
	end)

	return
end

local var_0_462 = RegisterDetailButton

local function var_0_463(arg_349_0, arg_349_1, arg_349_2)
	Drop = var_1_10003

	var_1_10003.Change(arg_349_2)

	switch = var_3

	local var_349_0 = arg_349_2.type
	local var_349_1 = {}

	DROP_TYPE_ITEM = var_1_10007
	var_349_1[var_1_10007] = function()
		getProxy = var_2_10000
		TechnologyProxy = var_2_10002

		local var_350_0 = var_2_10000(var_2_10002)
		local var_350_1

		if var_0.getItemCanUnlockBluePrint(var_350_0, arg_349_2.id) then
			var_350_1 = "tech"
		else
			local var_350_2 = arg_349_2

			var_350_1 = var_0.getConfig(var_350_2, "type")
		end

		local var_350_3

		if var_0_460[var_350_1] then
			var_350_3 = {
				useDeepShow = true,
				showOwn = var_350_1 == 11
			}
			i18n = var_2
			var_350_3.content = var_2(var_0_460[var_350_1])
			underscore = var_2

			local var_350_4 = var_2.map
			local var_350_5 = arg_349_2

			var_350_3.itemList = var_350_4(var_2_10004.getConfig(var_350_5, "display_icon"), function(arg_351_0)
				Drop = var_3_10001

				return var_3_10001.Create(arg_351_0)
			end)
			onButton = var_2
			var_2_10004 = arg_349_0

			local var_350_6 = arg_349_1

			local function var_350_7()
				local var_352_0 = arg_349_0
				local var_352_1 = var_0.emit

				BaseUI = var_3_10003

				var_352_1(var_352_0, var_3_10003.ON_NEW_STYLE_ITEMS, var_350_3)

				return
			end

			SFX_PANEL = var_7

			var_2(var_2_10004, var_350_6, var_350_7, var_7)
		end

		setActive = var_350_3

		local var_350_8 = arg_349_1

		tobool = var_2_10004

		var_350_3(var_350_8, var_2_10004(var_0_460[var_350_1]))

		return
	end

	var_3(var_349_0, var_349_1, function()
		setActive = var_2_10000

		var_2_10000(arg_349_1, false)

		return
	end)

	return
end

local var_0_464 = RegisterNewStyleDetailButton

local function var_0_465(arg_354_0, arg_354_1)
	local var_354_0 = arg_354_1
	local var_354_1, var_354_2 = arg_354_1.getOwnedCount(var_354_0)

	setActive = var_354_0

	var_354_0(arg_354_0, var_354_2 and var_354_1 > 0)

	if var_354_2 and 0 < var_354_1 then
		setText = var_4

		local var_354_3 = arg_354_0:Find("label")

		i18n = var_7

		var_4(var_354_3, var_7("word_own1"))

		setText = var_4

		var_4(arg_354_0:Find("Text"), var_354_1)
	end

	return
end

local var_0_466 = UpdateOwnDisplay

local function var_0_467(arg_355_0, arg_355_1, arg_355_2)
	Mathf = var_1_10003
	arg_355_1 = var_1_10003.Max(1, arg_355_1)
	Mathf = var_3

	if not (arg_355_1 < var_3.Epsilon) then
		Mathf = var_1_10004

		if var_3 > var_1_10004.Abs(arg_355_0) then
			return arg_355_0
		end

		if arg_355_2 < var_3 then
			return 0
		end

		local var_355_0 = -4.605170186

		Mathf = var_5

		return arg_355_0 * (1 - var_5.Exp(var_355_0 * arg_355_2 / arg_355_1))
	end
end

local var_0_468 = Damp

local function var_0_469(arg_356_0, arg_356_1)
	if not arg_356_1 then
		ReflectionHelp = var_1_10002

		local var_356_0 = var_1_10002.RefCallMethodEx

		typeof = var_1_10004

		local var_356_1 = var_1_10004("UnityEngine.CanvasRenderer")

		var_1_10005 = "GetMaterial"
		GetComponent = var_6

		local var_356_2 = var_6(arg_356_0, "CanvasRenderer")
		local var_356_3 = {}

		typeof = var_8
		var_356_3[1] = var_8("System.Int32")

		if not var_356_0(var_356_1, var_1_10005, var_356_2, var_356_3, {
			0
		}) then
			local var_356_4 = arg_356_0
			local var_356_5 = arg_356_0.GetComponentsInChildren

			typeof = var_1_10005

			local var_356_6 = var_356_5(var_356_4, var_1_10005(var_0_10000.UI.Graphic))
			local var_356_7 = var_2.ToTable(var_356_6)

			ipairs = var_1_10003

			for iter_356_0, iter_356_1 in var_1_10003(var_356_7) do
				iter_356_1:SetVerticesDirty()
			end

			return false
		end

		return true
	end
end

local var_0_470 = checkCullResume

local function var_0_471(arg_357_0)
	local var_357_0 = {}

	if arg_357_0 and arg_357_0 ~= "" then
		base64 = var_1_10002

		local var_357_1 = var_1_10002.dec(arg_357_0)

		string = var_1_10003
		var_357_0 = var_1_10003.split(var_357_1, "/")
		unpack = var_3
		string = var_5
		var_357_0[5], var_357_0[6] = var_3(var_5.split(var_357_0[5], "\\"))

		if not (#var_357_0 < 6) then
			base64 = var_357_2

			local var_357_2 = var_357_2.enc

			table = var_5

			local var_357_3 = var_5.concat
			local var_357_4 = {}

			table = var_8

			local var_357_5 = var_8.concat

			underscore = var_1_10010
			var_357_4[1] = var_357_5(var_1_10010.first(var_357_0, 5), "/")
			var_357_4[2] = var_357_0[6]

			if arg_357_0 ~= var_357_2(var_357_3(var_357_4, "\\")) then
				pg = var_357_2

				local var_357_6 = var_357_2.TipsMgr.GetInstance()
				local var_357_7 = var_3.ShowTips

				i18n = var_6

				var_357_7(var_357_6, var_6("equipcode_illegal"))

				var_357_0 = {}
			end

			for iter_357_0 = 1, 6 do
				if var_357_0[iter_357_0] then
					tonumber = var_6

					local var_357_8

					if not var_6(var_357_0[iter_357_0], 32) then
						var_357_8 = 0
					end

					var_357_0[iter_357_0] = var_357_8
				end
			end

			return var_357_0
		end
	end
end

local var_0_472 = parseEquipCode

local function var_0_473(arg_358_0)
	underscore = var_1_10001

	local var_358_0 = var_1_10001.map(arg_358_0:getAllEquipments(), function(arg_359_0)
		ConversionBase = var_2_10001

		local var_359_0 = 32
		local var_359_1

		if not arg_359_0 or not arg_359_0.id then
			var_359_1 = 0
		end

		return var_2_10001(var_359_0, var_359_1)
	end)
	local var_358_1 = {}

	table = var_3
	var_358_1[1] = var_3.concat(var_358_0, "/")
	ConversionBase = var_3

	local var_358_2 = 32

	checkExist = var_6

	local var_358_3

	if not var_6(arg_358_0:GetSpWeapon(), {
		"id"
	}) then
		var_358_3 = 0
	end

	var_358_1[2] = var_3(var_358_2, var_358_3)

	local var_358_4 = var_358_1

	base64 = var_358_1

	local var_358_5 = var_358_1.enc

	table = var_4

	return var_358_5(var_4.concat(var_358_4, "\\"))
end

local var_0_474 = buildEquipCode

local function var_0_475(arg_360_0, arg_360_1)
	GetComponent = var_1_10002

	local var_360_0 = arg_360_0

	typeof = var_1_10005
	TimelineSpeed = var_1_10007

	local var_360_1 = var_1_10002(var_360_0, var_1_10005(var_1_10007))

	var_2.SetTimelineSpeed(var_360_1, arg_360_1)

	return
end

local var_0_476 = setDirectorSpeed

local function var_0_477(arg_361_0)
	setmetatable = var_1_10001

	return var_1_10001(arg_361_0, {
		__index = function(arg_362_0, arg_362_1)
			rawget = var_2_10002

			if var_2_10002(arg_362_0, arg_362_1) == nil then
				arg_362_0[arg_362_1] = 0
			end

			return arg_362_0[arg_362_1]
		end
	})
end

local var_0_478 = setDefaultZeroMetatable

local function var_0_479(arg_363_0)
	EDITOR_TOOL = var_1_10001

	if var_1_10001 then
		ResourceMgr = var_1_10001
		var_1_10003 = var_1_10001.Inst

		return var_1_10001.AssetExist(var_1_10003, arg_363_0)
	else
		PathMgr = var_1_10001

		local var_363_0 = var_1_10001.FileExists

		PathMgr = var_1_10003

		return var_363_0(var_1_10003.getAssetBundle(arg_363_0))
	end

	return
end

local var_0_480 = checkABExist

local function var_0_481(arg_364_0, arg_364_1, arg_364_2)
	switch = var_1_10003

	return var_1_10003(arg_364_1, {
		[">"] = function()
			return arg_364_0 > arg_364_2
		end,
		[">="] = function()
			return arg_364_0 >= arg_364_2
		end,
		["="] = function()
			return arg_364_0 == arg_364_2
		end,
		["<"] = function()
			return arg_364_0 < arg_364_2
		end,
		["<="] = function()
			return arg_364_0 <= arg_364_2
		end
	})
end

local var_0_482 = compareNumber

local function var_0_483(arg_370_0)
	local var_370_0 = {
		{
			1000,
			"M"
		},
		{
			900,
			"CM"
		},
		{
			500,
			"D"
		},
		{
			400,
			"CD"
		},
		{
			100,
			"C"
		},
		{
			90,
			"XC"
		},
		{
			50,
			"L"
		},
		{
			40,
			"XL"
		},
		{
			10,
			"X"
		},
		{
			9,
			"IX"
		},
		{
			5,
			"V"
		},
		{
			4,
			"IV"
		},
		{
			1,
			"I"
		}
	}

	local function var_370_1(arg_371_0, arg_371_1)
		select = var_2_10002

		return var_2_10002(2, arg_371_0:gsub(arg_371_1, ""))
	end

	local var_370_2 = ""

	while 0 < arg_370_0 do
		pairs = var_4

		for iter_370_0, iter_370_1 in var_4(var_370_0) do
			local var_370_3 = iter_370_1[2]
			local var_370_4 = iter_370_1[1]

			while var_370_4 <= arg_370_0 do
				var_370_2 = var_370_2 .. var_370_3
				arg_370_0 = arg_370_0 - var_370_4
			end
		end
	end

	if arg_370_0 > 10000 then
		local var_370_5 = var_370_1(var_370_2, "M")

		var_370_2 = "M*" .. var_370_5 .. " " .. var_370_2
	end

	return var_370_2
end

local var_0_484 = ArabicToRoman

local function var_0_485(arg_372_0, ...)
	ipairs = var_1_10001

	for iter_372_0, iter_372_1 in var_1_10001({
		...
	}) do
		string = var_1_10006
		arg_372_0 = var_1_10006.gsub(arg_372_0, "$" .. iter_372_0, iter_372_1)
	end

	return arg_372_0
end

local var_0_486 = stringInset

local function var_0_487(arg_373_0, arg_373_1)
	string = var_1_10002

	local var_373_0 = var_1_10002.sub
	local var_373_1 = arg_373_0
	local var_373_2 = 1

	string = var_1_10006

	return var_373_0(var_373_1, var_373_2, var_1_10006.len(arg_373_1)) == arg_373_1
end

local var_0_488 = StringStartsWith

local function var_0_489(arg_374_0, arg_374_1, arg_374_2, arg_374_3, arg_374_4)
	if arg_374_2 then
		while arg_374_1.parent do
			arg_374_1 = arg_374_1.parent
		end
	end

	local var_374_0 = {
		parentContext = arg_374_1,
		context = arg_374_0,
		callback = arg_374_3
	}

	if arg_374_4 then
		table = var_1_10006
		var_374_0 = var_1_10006.merge(var_374_0, arg_374_4) or var_374_0
	end

	pg = var_1_10006

	local var_374_1 = var_1_10006.m02
	local var_374_2 = var_6.sendNotification

	GAME = var_1_10009

	var_374_2(var_374_1, var_1_10009.LOAD_LAYERS, var_374_0)

	return
end

local var_0_490 = addSubLayer

local function var_0_491(arg_375_0, arg_375_1)
	tostring = var_1_10002

	local var_375_0 = var_1_10002(arg_375_0)
	local var_375_1 = ","

	tostring = var_4

	return var_375_0 .. var_375_1 .. var_4(arg_375_1)
end

local var_0_492 = PackIntToString

local function var_0_493(arg_376_0)
	string = var_1_10001

	local var_376_0, var_376_1 = var_1_10001.match(arg_376_0, "(%-?%d+),(%-?%d+)")

	tonumber = var_3

	local var_376_2 = var_3(var_376_0)

	tonumber = var_4

	local var_376_3 = var_4(var_376_1)
end

local var_0_494 = UnpackIntFromString

local function var_0_495(arg_377_0)
	local var_377_0 = 0

	ipairs = var_1_10002

	for iter_377_0, iter_377_1 in var_1_10002(arg_377_0) do
		var_377_0 = var_377_0 + iter_377_1
	end

	assert = var_2

	var_2(var_377_0 ~= 0, "总权重为0")

	math = var_2

	local var_377_1 = var_2.random(1, var_377_0)
	local var_377_2 = 0

	ipairs = var_4

	for iter_377_2, iter_377_3 in var_4(arg_377_0) do
		if var_377_1 <= var_377_2 + iter_377_3 then
			return iter_377_2
		end
	end

	return #arg_377_0
end

local var_0_496 = getRandomIdxByWeights

return
