pg = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = pg
singletonClass = var_0_10001
var_0.SceneAnimMgr = var_0_10001("SceneAnimMgr")
pg = var_0

local var_0_1 = var_0.SceneAnimMgr

function var_0_1.Ctor(arg_1_0)
	arg_1_0.loadingList = {}
	arg_1_0.dormCallbackList = {}

	return
end

function var_0_1.Init(arg_2_0, arg_2_1)
	print = var_1_10002

	var_1_10002("initializing sceneanim manager...")

	LoadAndInstantiateAsync = var_1_10002

	var_1_10002("ui", "SceneAnimUI", function(arg_3_0)
		arg_2_0._go = arg_3_0

		local var_3_0 = arg_2_0._go

		var_1.SetActive(var_3_0, false)

		arg_2_0._tf = arg_2_0._go.transform

		local var_3_1 = arg_2_0._tf
		local var_3_2 = var_1.SetParent

		pg = var_4

		var_3_2(var_3_1, var_4.UIMgr.GetInstance().OverlayToast, false)

		local var_3_3 = arg_2_0
		local var_3_4 = arg_2_0._tf

		var_3_3.container = var_2.Find(var_3_4, "container")

		if arg_2_1 then
			arg_2_1()
		end

		return
	end, true, true)

	return
end

function var_0_1.SixthAnniversaryJPCoverGoScene(arg_4_0, arg_4_1)
	arg_4_0.playing = true
	setActive = var_2

	var_2(arg_4_0._tf, true)

	local var_4_0 = "SixthAnniversaryJPCoverUI"

	PoolMgr = var_1_10003

	local var_4_1 = var_1_10003.GetInstance()

	var_3.GetUI(var_4_1, var_4_0, true, function(arg_5_0)
		local var_5_0 = arg_5_0.transform

		setParent = var_2_10002

		var_2_10002(var_5_0, arg_4_0.container, false)

		setActive = var_2_10002

		var_2_10002(var_5_0, true)

		local var_5_1 = var_5_0:Find("houshanyunwu")
		local var_5_2 = var_2.GetComponent

		typeof = var_5
		SpineAnimUI = var_2_10007

		local var_5_3 = var_5_2(var_5_1, var_5(var_2_10007))

		var_2.SetActionCallBack(var_5_3, function(arg_6_0)
			if arg_6_0 == "finish" then
				PoolMgr = var_3_10001

				local var_6_0 = var_3_10001.GetInstance()

				var_3_10001.ReturnUI(var_6_0, var_4_0, arg_5_0)

				var_3_10001 = arg_4_0
				var_3_10001.playing = nil
				setActive = var_3_10001

				var_3_10001(var_5_0, false)

				setActive = var_3_10001

				var_3_10001(arg_4_0._tf, false)
			elseif arg_6_0 == "action" then
				pg = var_3_10001

				local var_6_1 = var_3_10001.m02
				local var_6_2 = var_1.sendNotification

				GAME = var_3_10004

				var_6_2(var_6_1, var_3_10004.GO_SCENE, arg_4_1)
			end

			return
		end)
		var_2:SetAction("action", 0)

		return
	end)

	return
end

function var_0_1.OtherWorldCoverGoScene(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.playing = true
	setActive = var_3

	var_3(arg_7_0._tf, true)

	local var_7_0 = "OtherworldCoverUI"

	PoolMgr = var_1_10004

	local var_7_1 = var_1_10004.GetInstance()

	var_4.GetUI(var_7_1, var_7_0, true, function(arg_8_0)
		local var_8_0 = arg_8_0.transform

		setParent = var_2_10002

		var_2_10002(var_8_0, arg_7_0.container, false)

		setActive = var_2_10002

		var_2_10002(var_8_0, true)

		local var_8_1 = var_8_0:Find("yuncaizhuanchang")
		local var_8_2 = var_2.GetComponent

		typeof = var_5
		SpineAnimUI = var_2_10007

		local var_8_3 = var_8_2(var_8_1, var_5(var_2_10007))

		var_2.SetActionCallBack(var_8_3, function(arg_9_0)
			if arg_9_0 == "finish" then
				PoolMgr = var_3_10001

				local var_9_0 = var_3_10001.GetInstance()

				var_3_10001.ReturnUI(var_9_0, var_7_0, arg_8_0)

				var_3_10001 = arg_7_0
				var_3_10001.playing = nil
				setActive = var_3_10001

				var_3_10001(var_8_0, false)

				setActive = var_3_10001

				var_3_10001(arg_7_0._tf, false)
			elseif arg_9_0 == "action" then
				pg = var_3_10001

				local var_9_1 = var_3_10001.m02
				local var_9_2 = var_1.sendNotification

				GAME = var_3_10004

				var_9_2(var_9_1, var_3_10004.GO_SCENE, arg_7_1, arg_7_2)
			end

			return
		end)
		var_2:SetAction("action", 0)

		return
	end)

	return
end

function var_0_1.CommonSceneChange(arg_10_0, arg_10_1, arg_10_2)
	table = var_1_10003

	var_1_10003.insert(arg_10_0.loadingList, {
		arg_10_1,
		arg_10_2
	})

	if not arg_10_0.playing then
		arg_10_0:DoSceneChange()
	end

	return
end

function var_0_1.DoSceneChange(arg_11_0)
	arg_11_0.playing = true
	setActive = var_1

	var_1(arg_11_0._tf, true)

	pg = var_1

	local var_11_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_11_0, false)

	unpack = var_1
	table = var_11_0

	local var_11_1, var_11_2 = var_1(var_11_0.remove(arg_11_0.loadingList, 1))
	local var_11_3 = arg_11_0.container
	local var_11_4 = var_3.Find(var_11_3, var_11_1)
	local var_11_5 = {}

	if not var_11_4 then
		table = var_11_3

		var_11_3.insert(var_11_5, function(arg_12_0)
			PoolMgr = var_2_10001

			local var_12_0 = var_2_10001.GetInstance()

			var_1.GetUI(var_12_0, var_11_1, true, function(arg_13_0)
				var_11_4 = arg_13_0.transform
				setParent = var_1

				var_1(var_11_4, arg_11_0.container, false)
				arg_12_0()

				return
			end)

			return
		end)
	end

	table = var_11_3

	var_11_3.insert(var_11_5, function(arg_14_0)
		local var_14_0 = arg_11_0

		var_1.StartLoading(var_14_0, var_11_1, var_11_4, arg_14_0)

		return
	end)

	table = var_5

	var_5.insert(var_11_5, function(arg_15_0)
		local var_15_0

		local function var_15_1()
			if #arg_11_0.loadingList > 0 and arg_11_0.loadingList[1][1] == var_11_1 then
				unpack = var_0
				table = var_3_10002
				var_11_1, var_11_2 = var_0(var_3_10002.remove(arg_11_0.loadingList, 1))

				var_11_2(var_15_1)
			else
				arg_15_0()
			end

			return
		end

		var_11_2(var_15_1)

		local var_15_2 = arg_11_0

		var_2.LoopLoading(var_15_2, var_11_1, var_11_4)

		return
	end)

	table = var_5

	var_5.insert(var_11_5, function(arg_17_0)
		local var_17_0 = arg_11_0

		var_1.EndLoading(var_17_0, var_11_1, var_11_4, arg_17_0)

		return
	end)

	seriesAsync = var_5

	var_5(var_11_5, function()
		PoolMgr = var_2_10000

		local var_18_0 = var_2_10000.GetInstance()

		var_0.ReturnUI(var_18_0, var_11_1, var_11_4.gameObject)

		pg = var_0

		local var_18_1 = var_0.UIMgr.GetInstance()

		var_0.LoadingOff(var_18_1)

		if #arg_11_0.loadingList > 0 then
			local var_18_2 = arg_11_0

			var_0.DoSceneChange(var_18_2)
		else
			local var_18_3 = arg_11_0

			var_18_3.playing = nil
			setActive = var_18_3

			var_18_3(arg_11_0._tf, false)
		end

		return
	end)

	return
end

function var_0_1.StartLoading(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	switch = var_1_10004

	var_1_10004(arg_19_1, {
		Dorm3DLoading = function()
			GetComponent = var_2_10000

			local var_20_0 = arg_19_2

			typeof = var_2_10003
			Animator = var_2_10005

			local var_20_1 = var_2_10000(var_20_0, var_2_10003(var_2_10005))

			var_0.SetBool(var_20_1, "Finish", false)

			local var_20_2 = arg_19_2
			local var_20_3 = var_0.Find(var_20_2, "bg")
			local var_20_4 = var_0.GetComponent

			typeof = var_3
			Image = var_2_10005

			local var_20_5 = var_20_4(var_20_3, var_3(var_2_10005)).material

			var_0.SetInt(var_20_5, "_DissolveTexFlip", 1)

			LeanTween = var_1

			local var_20_6 = var_1.value(1, 0, 0.6)
			local var_20_7 = var_1.setOnUpdate

			System = var_4

			local var_20_8 = var_20_7(var_20_6, var_4.Action_float(function(arg_21_0)
				local var_21_0 = var_0

				var_1.SetFloat(var_21_0, "_Dissolve", arg_21_0)

				return
			end))
			local var_20_9 = var_1.setEase

			LeanTweenType = var_4

			var_20_9(var_20_8, var_4.easeOutCubic)

			local var_20_10 = arg_19_2
			local var_20_11 = var_1.GetComponent(var_20_10, "DftAniEvent")

			var_1.SetTriggerEvent(var_20_11, arg_19_3)

			quickPlayAnimator = var_2

			var_2(arg_19_2, "anim_dorm3d_loading_in")

			return
		end,
		IslandplaneLoading = function()
			local var_22_0 = arg_19_2
			local var_22_1 = var_0.GetComponent(var_22_0, "DftAniEvent")

			var_0.SetTriggerEvent(var_22_1, arg_19_3)

			quickPlayAnimation = var_1

			var_1(arg_19_2, "anim_planeLoading_in")

			local var_22_2 = arg_19_2
			local var_22_3 = var_1.Find(var_22_2, "load")
			local var_22_4 = var_1.GetComponent(var_22_3, "SkeletonAnimation").state

			var_1.SetAnimation(var_22_4, 0, "cut_in", false)

			return
		end,
		IslandcarLoading = function()
			local var_23_0 = arg_19_2
			local var_23_1 = var_0.GetComponent(var_23_0, "DftAniEvent")

			var_0.SetTriggerEvent(var_23_1, arg_19_3)

			quickPlayAnimation = var_1

			var_1(arg_19_2, "anim_planeLoading_in")

			local var_23_2 = arg_19_2
			local var_23_3 = var_1.Find(var_23_2, "load")
			local var_23_4 = var_1.GetComponent(var_23_3, "SkeletonAnimation").state

			var_1.SetAnimation(var_23_4, 0, "cut_in", false)

			return
		end,
		jufengyuziyouqundao = function()
			local var_24_0 = arg_19_2

			arg_19_2 = var_0.Find(var_24_0, "scale")

			local var_24_1 = arg_19_2
			local var_24_2 = var_0.GetComponent(var_24_1, "DftAniEvent")

			var_0.SetTriggerEvent(var_24_2, arg_19_3)

			quickPlayAnimator = var_1

			var_1(arg_19_2, "jufeng")

			return
		end,
		jufengyuziyouqundao_fullscreen = function()
			local var_25_0 = arg_19_2

			arg_19_2 = var_0.Find(var_25_0, "scale")

			local var_25_1 = arg_19_2
			local var_25_2 = var_0.GetComponent(var_25_1, "DftAniEvent")

			var_0.SetTriggerEvent(var_25_2, arg_19_3)

			quickPlayAnimator = var_1

			var_1(arg_19_2, "jufeng")

			return
		end,
		jiarihangxianshanyaohaibin = function()
			local var_26_0 = arg_19_2

			arg_19_2 = var_0.Find(var_26_0, "scale")

			local var_26_1 = arg_19_2
			local var_26_2 = var_0.GetComponent(var_26_1, "DftAniEvent")

			var_0.SetTriggerEvent(var_26_2, arg_19_3)

			quickPlayAnimator = var_1

			var_1(arg_19_2, "manyou")

			return
		end
	}, function()
		return
	end)

	return
end

function var_0_1.LoopLoading(arg_28_0, arg_28_1, arg_28_2)
	switch = var_1_10003

	var_1_10003(arg_28_1, {
		Dorm3DLoading = function()
			pg = var_2_10000

			local var_29_0 = var_2_10000.CriMgr.GetInstance()

			var_0.PlaySE_V3(var_29_0, "ui-dorm_loading_loop")

			return
		end,
		IslandplaneLoading = function()
			local var_30_0 = arg_28_2
			local var_30_1 = var_0.Find(var_30_0, "load")
			local var_30_2 = var_0.GetComponent(var_30_1, "SkeletonAnimation").state

			var_0.SetAnimation(var_30_2, 0, "normal", true)

			return
		end,
		IslandcarLoading = function()
			local var_31_0 = arg_28_2
			local var_31_1 = var_0.Find(var_31_0, "load")
			local var_31_2 = var_0.GetComponent(var_31_1, "SkeletonAnimation").state

			var_0.SetAnimation(var_31_2, 0, "normal", true)

			return
		end
	}, function()
		return
	end)

	return
end

function var_0_1.EndLoading(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	switch = var_1_10004

	var_1_10004(arg_33_1, {
		Dorm3DLoading = function()
			local var_34_0 = arg_33_2
			local var_34_1 = var_0.Find(var_34_0, "bg")
			local var_34_2 = var_0.GetComponent

			typeof = var_3
			Image = var_2_10005

			local var_34_3 = var_34_2(var_34_1, var_3(var_2_10005)).material

			var_0.SetInt(var_34_3, "_DissolveTexFlip", 0)

			LeanTween = var_1

			local var_34_4 = var_1.value(0, 1, 0.6)
			local var_34_5 = var_1.setOnUpdate

			System = var_4

			local var_34_6 = var_34_5(var_34_4, var_4.Action_float(function(arg_35_0)
				local var_35_0 = var_0

				var_1.SetFloat(var_35_0, "_Dissolve", arg_35_0)

				return
			end))
			local var_34_7 = var_1.setEase

			LeanTweenType = var_4

			var_34_7(var_34_6, var_4.easeInOutCubic)

			local var_34_8 = arg_33_2
			local var_34_9 = var_1.GetComponent(var_34_8, "DftAniEvent")

			var_1.SetEndEvent(var_34_9, arg_33_3)

			GetComponent = var_2

			local var_34_10 = arg_33_2

			typeof = var_5
			Animator = var_2_10007

			local var_34_11 = var_2(var_34_10, var_5(var_2_10007))

			var_2.SetBool(var_34_11, "Finish", true)

			return
		end,
		IslandplaneLoading = function()
			local var_36_0 = arg_33_2
			local var_36_1 = var_0.GetComponent(var_36_0, "DftAniEvent")

			var_0.SetEndEvent(var_36_1, arg_33_3)

			quickPlayAnimation = var_1

			var_1(arg_33_2, "anim_planeLoading_out")

			return
		end,
		IslandcarLoading = function()
			local var_37_0 = arg_33_2
			local var_37_1 = var_0.GetComponent(var_37_0, "DftAniEvent")

			var_0.SetEndEvent(var_37_1, arg_33_3)

			quickPlayAnimation = var_1

			var_1(arg_33_2, "anim_planeLoading_out")

			return
		end,
		jufengyuziyouqundao = function()
			arg_33_3()

			return
		end,
		jufengyuziyouqundao_fullscreen = function()
			arg_33_3()

			return
		end,
		jiarihangxianshanyaohaibin = function()
			arg_33_3()

			return
		end
	}, function()
		return
	end)

	return
end

function var_0_1.RegisterDormNextCall(arg_42_0, arg_42_1)
	function arg_42_0.dormNextCall()
		arg_42_0.dormNextCall = nil

		return arg_42_1()
	end

	return
end

function var_0_1.Dorm3DSceneChange(arg_44_0, arg_44_1)
	table = var_1_10002

	var_1_10002.insert(arg_44_0.dormCallbackList, arg_44_1)

	if not arg_44_0.playing then
		pg = var_2

		local var_44_0 = var_2.UIMgr.GetInstance()

		var_2.LoadingOn(var_44_0, false)
		arg_44_0:DoDorm3DSceneChange()
	end

	existCall = var_2

	var_2(arg_44_0.dormNextCall)

	return
end

function var_0_1.DoDorm3DSceneChange(arg_45_0, arg_45_1)
	arg_45_0.playing = true
	setActive = var_2

	var_2(arg_45_0._tf, true)

	local var_45_0 = "Dorm3DLoading"
	local var_45_1 = {}

	if not arg_45_1 then
		table = var_4

		var_4.insert(var_45_1, function(arg_46_0)
			PoolMgr = var_2_10001

			local var_46_0 = var_2_10001.GetInstance()

			var_1.GetUI(var_46_0, var_45_0, true, function(arg_47_0)
				arg_45_1 = arg_47_0.transform
				setParent = var_1

				var_1(arg_45_1, arg_45_0.container, false)
				arg_46_0()

				return
			end)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_45_1, function()
		local var_48_0 = arg_45_1
		local var_48_1 = var_0.Find(var_48_0, "bg")
		local var_48_2 = var_0.GetComponent

		typeof = var_3
		Image = var_2_10005

		local var_48_3 = var_48_2(var_48_1, var_3(var_2_10005)).material
		local var_48_4 = arg_45_1
		local var_48_5 = var_1.GetComponent(var_48_4, "DftAniEvent")

		var_1.SetTriggerEvent(var_48_5, function(arg_49_0)
			local var_49_0

			;(function()
				if #arg_45_0.dormCallbackList > 0 then
					table = var_0

					var_0.remove(arg_45_0.dormCallbackList, 1)(var_0)
				else
					GetComponent = var_0

					local var_50_0 = arg_45_1

					typeof = var_4_10003
					Animator = var_4_10005

					local var_50_1 = var_0(var_50_0, var_4_10003(var_4_10005))

					var_0.SetBool(var_50_1, "Finish", true)

					local var_50_2 = var_48_3

					var_0.SetInt(var_50_2, "_DissolveTexFlip", 0)

					LeanTween = var_0

					local var_50_3 = var_0.value(0, 1, 0.6)
					local var_50_4 = var_0.setOnUpdate

					System = var_3

					local var_50_5 = var_50_4(var_50_3, var_3.Action_float(function(arg_51_0)
						local var_51_0 = var_48_3

						var_1.SetFloat(var_51_0, "_Dissolve", arg_51_0)

						return
					end))
					local var_50_6 = var_0.setEase

					LeanTweenType = var_3

					var_50_6(var_50_5, var_3.easeInOutCubic)
				end

				return
			end)()

			pg = var_2

			local var_49_1 = var_2.CriMgr.GetInstance()

			var_2.PlaySE_V3(var_49_1, "ui-dorm_loading_loop")

			return
		end)
		var_1:SetEndEvent(function(arg_52_0)
			if #arg_45_0.dormCallbackList > 0 then
				quickPlayAnimator = var_1

				var_1(arg_45_1, "anim_dorm3d_loading_in")

				local var_52_0 = arg_45_0

				var_1.DoDorm3DSceneChange(var_52_0, arg_45_1)
			else
				PoolMgr = var_1

				local var_52_1 = var_1.GetInstance()

				var_1.ReturnUI(var_52_1, var_45_0, arg_45_1.gameObject)

				local var_52_2 = arg_45_0

				var_52_2.playing = nil
				setActive = var_52_2

				var_52_2(arg_45_0._tf, false)

				pg = var_52_2

				local var_52_3 = var_52_2.UIMgr.GetInstance()

				var_1.LoadingOff(var_52_3)
			end

			return
		end)

		GetComponent = var_2

		local var_48_6 = arg_45_1

		typeof = var_5
		Animator = var_2_10007

		local var_48_7 = var_2(var_48_6, var_5(var_2_10007))

		var_2.SetBool(var_48_7, "Finish", false)
		var_48_3:SetInt("_DissolveTexFlip", 1)

		LeanTween = var_2

		local var_48_8 = var_2.value(1, 0, 0.6)
		local var_48_9 = var_2.setOnUpdate

		System = var_5

		local var_48_10 = var_48_9(var_48_8, var_5.Action_float(function(arg_53_0)
			local var_53_0 = var_48_3

			var_1.SetFloat(var_53_0, "_Dissolve", arg_53_0)

			return
		end))
		local var_48_11 = var_2.setEase

		LeanTweenType = var_5

		var_48_11(var_48_10, var_5.easeOutCubic)

		return
	end)

	return
end

function var_0_1.IsPlaying(arg_54_0)
	return arg_54_0.playing
end

function var_0_1.Dispose(arg_55_0)
	setActive = var_1_10001

	var_1_10001(arg_55_0._tf, false)

	arg_55_0.playing = nil

	return
end

return
