class = var_0_10000

local var_0_0 = var_0_10000("Dorm3dSceneMgr")

function var_0_0.ParseInfo(arg_1_0)
	unpack = var_1_10001
	string = var_1_10002

	return var_1_10001(var_1_10002.split(arg_1_0, "|"))
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.sceneInfo = arg_2_1
	arg_2_0.artSceneInfo = arg_2_0.sceneInfo
	arg_2_0.subSceneInfo = arg_2_0.sceneInfo
	arg_2_0.lastSceneRootDict = {}
	arg_2_0.cacheSceneDic = {}

	local var_2_0, var_2_1 = var_0_0.ParseInfo(arg_2_0.sceneInfo)
	local var_2_2 = {
		function(arg_3_0)
			SceneOpMgr = var_2_10001

			local var_3_0 = var_2_10001.Inst
			local var_3_1 = var_1.LoadSceneAsync

			string = var_2_10003

			local var_3_2 = var_2_10003.lower("dorm3d/scenesres/scenes/" .. var_2_1 .. "/" .. var_2_0 .. "_scene")
			local var_3_3 = var_2_0

			LoadSceneMode = var_5

			var_3_1(var_3_0, var_3_2, var_3_3, var_5.Additive, function(arg_4_0, arg_4_1)
				local var_4_0 = arg_2_0

				var_4_0.originArtScene = arg_4_0
				SceneManager = var_4_0

				var_4_0.SetActiveScene(arg_4_0)

				getSceneRootTFDic = var_2

				if var_2(arg_4_0).MainCamera then
					setActive = var_3

					var_3(var_2, false)
				end

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			SceneOpMgr = var_2_10001

			local var_5_0 = var_2_10001.Inst
			local var_5_1 = var_1.LoadSceneAsync

			string = var_2_10003

			local var_5_2 = var_2_10003.lower("dorm3d/scenesres/scenes/" .. var_2_1 .. "/" .. var_2_0 .. "_base_scene")
			local var_5_3 = var_2_0 .. "_base"

			LoadSceneMode = var_5

			var_5_1(var_5_0, var_5_2, var_5_3, var_5.Additive, arg_5_0)

			return
		end
	}

	seriesAsync = var_6

	var_6(var_2_2, arg_2_2)

	return
end

function var_0_0.EnableSceneDisplay(arg_6_0, arg_6_1, arg_6_2)
	assert = var_1_10003
	tobool = var_1_10004

	var_1_10003(var_1_10004(arg_6_0.lastSceneRootDict[arg_6_1]) == arg_6_2)

	if arg_6_2 then
		table = var_1_10003

		var_1_10003.Foreach(arg_6_0.lastSceneRootDict[arg_6_1], function(arg_7_0, arg_7_1)
			IsNil = var_2_10002

			if var_2_10002(arg_7_0) then
				return
			end

			setActive = var_2

			var_2(arg_7_0, arg_7_1)

			return
		end)

		arg_6_0.lastSceneRootDict[arg_6_1] = nil
	else
		local var_6_0 = arg_6_0.lastSceneRootDict

		var_6_0[arg_6_1] = {}
		SceneManager = var_6_0

		local var_6_1 = var_6_0.GetSceneByName(arg_6_1)

		table = var_4

		var_4.IpairsCArray(var_6_1:GetRootGameObjects(), function(arg_8_0, arg_8_1)
			tostring = var_2_10002

			if var_2_10002(arg_8_1.hideFlags) ~= "None" then
				return
			end

			local var_8_0 = arg_6_0.lastSceneRootDict[arg_6_1]

			isActive = var_3
			var_8_0[arg_8_1] = var_3(arg_8_1)
			setActive = var_8_0

			var_8_0(arg_8_1, false)

			return
		end)
	end

	return
end

function var_0_0.LoadTimelineScene(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1
	local var_9_2

	if not arg_9_0.cacheSceneDic[arg_9_1.name] then
		var_9_2 = arg_9_0.cacheSceneDic
		var_9_2[arg_9_1.name] = arg_9_1
		table = var_9_2

		var_9_2.insert(var_9_0, function(arg_10_0)
			pg = var_2_10001

			local var_10_0 = var_2_10001.SceneAnimMgr.GetInstance()

			var_1.Dorm3DSceneChange(var_10_0, function(arg_11_0)
				if arg_9_1.waitForTimeline then
					arg_9_1.waitForTimeline(arg_11_0)
				else
					var_9_1 = arg_11_0
				end

				arg_10_0()

				return
			end)

			return
		end)

		table = var_9_2

		var_9_2.insert(var_9_0, function(arg_12_0)
			SceneOpMgr = var_2_10001

			local var_12_0 = var_2_10001.Inst
			local var_12_1 = var_1.LoadSceneAsync

			string = var_2_10003

			local var_12_2 = var_2_10003.lower("dorm3d/character/" .. arg_9_1.assetRootName .. "/timeline/" .. arg_9_1.name .. "/" .. arg_9_1.name .. "_scene")
			local var_12_3 = arg_9_1.name

			LoadSceneMode = var_5

			var_12_1(var_12_0, var_12_2, var_12_3, var_5.Additive, function(arg_13_0, arg_13_1)
				existCall = var_3_10002

				var_3_10002(arg_9_1.loadSceneFunc, arg_13_0, arg_13_1)

				GameObject = var_3_10002

				local var_13_0 = var_3_10002.Find("[camera]").transform
				local var_13_1 = var_2.GetComponentInChildren

				typeof = var_5
				Camera = var_3_10006

				local var_13_2 = var_13_1(var_13_0, var_5(var_3_10006))

				setActive = var_13_0

				var_13_0(var_13_2, false)
				arg_12_0()

				return
			end)

			return
		end)
	end

	table = var_9_2

	var_9_2.insert(var_9_0, function(arg_14_0)
		tobool = var_2_10001

		local var_14_0 = var_2_10001(arg_9_0.lastSceneRootDict[arg_9_1.name])

		tobool = var_2

		if var_14_0 ~= var_2(arg_9_1.isCache) then
			local var_14_1 = arg_9_0

			var_1.EnableSceneDisplay(var_14_1, arg_9_1.name, not arg_9_1.isCache)
		end

		arg_14_0()

		existCall = var_1

		var_1(var_9_1)

		return
	end)

	seriesAsync = var_5

	var_5(var_9_0, arg_9_2)

	return
end

function var_0_0.UnloadTimelineScene(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	assert = var_1_10004

	var_1_10004(arg_15_0.cacheSceneDic[arg_15_1])

	local var_15_0 = arg_15_0.cacheSceneDic[arg_15_1]

	tobool = var_5

	local var_15_1 = var_5(arg_15_2)

	tobool = var_6

	if var_15_1 == var_6(var_15_0.isCache) then
		local var_15_2 = var_15_0.assetRootName

		SceneOpMgr = var_6

		local var_15_3 = var_6.Inst
		local var_15_4 = var_6.UnloadSceneAsync

		string = var_1_10008

		var_15_4(var_15_3, var_1_10008.lower("dorm3d/character/scenes/" .. var_15_2 .. "/timeline/" .. arg_15_1 .. "/" .. arg_15_1 .. "_scene"), arg_15_1, function()
			arg_15_0.cacheSceneDic[arg_15_1] = nil

			local var_16_0 = arg_15_0.lastSceneRootDict

			var_16_0[arg_15_1] = nil
			existCall = var_16_0

			var_16_0(arg_15_3)

			return
		end)
	else
		arg_15_0:EnableSceneDisplay(arg_15_1, false)

		existCall = var_5

		var_5(arg_15_3)
	end

	return
end

function var_0_0.ChangeArtScene(arg_17_0, arg_17_1, arg_17_2)
	if var_0_0.IsSameSceneInfo(arg_17_1, arg_17_0.artSceneInfo) then
		existCall = var_3

		var_3(arg_17_2)

		return
	end

	local var_17_0 = {}
	local var_17_1 = false
	local var_17_2

	if var_0_0.IsSameSceneInfo(arg_17_1, arg_17_0.sceneInfo) then
		table = var_6

		var_6.insert(var_17_0, function(arg_18_0)
			local var_18_0, var_18_1 = var_0_0.ParseInfo(arg_17_0.sceneInfo)

			SceneManager = var_2_10003

			local var_18_2 = var_2_10003.SetActiveScene

			SceneManager = var_2_10004

			var_18_2(var_2_10004.GetSceneByName(var_18_0))

			local var_18_3 = arg_17_0

			var_3.EnableSceneDisplay(var_18_3, var_18_0, true)
			arg_18_0()

			return
		end)
	else
		var_17_1 = true
		table = var_6

		var_6.insert(var_17_0, function(arg_19_0)
			pg = var_2_10001

			local var_19_0 = var_2_10001.SceneAnimMgr.GetInstance()

			var_1.Dorm3DSceneChange(var_19_0, function(arg_20_0)
				var_17_2 = arg_20_0

				arg_19_0()

				return
			end)

			return
		end)

		local var_17_3, var_17_4 = var_0_0.ParseInfo(arg_17_1)

		table = var_8

		var_8.insert(var_17_0, function(arg_21_0)
			SceneOpMgr = var_2_10001

			local var_21_0 = var_2_10001.Inst
			local var_21_1 = var_1.LoadSceneAsync

			string = var_2_10003

			local var_21_2 = var_2_10003.lower("dorm3d/scenesres/scenes/" .. var_17_4 .. "/" .. var_17_3 .. "_scene")
			local var_21_3 = var_17_3

			LoadSceneMode = var_5

			var_21_1(var_21_0, var_21_2, var_21_3, var_5.Additive, function(arg_22_0, arg_22_1)
				SceneManager = var_3_10002

				var_3_10002.SetActiveScene(arg_22_0)

				getSceneRootTFDic = var_2

				if var_2(arg_22_0).MainCamera then
					setActive = var_3

					var_3(var_2, false)
				end

				arg_21_0()

				return
			end)

			return
		end)
	end

	local var_17_5

	if var_0_0.IsSameSceneInfo(arg_17_0.artSceneInfo, arg_17_0.sceneInfo) then
		table = var_17_5

		var_17_5.insert(var_17_0, function(arg_23_0)
			local var_23_0, var_23_1 = var_0_0.ParseInfo(arg_17_0.sceneInfo)
			local var_23_2 = arg_17_0

			var_3.EnableSceneDisplay(var_23_2, var_23_0, false)
			arg_23_0()

			return
		end)
	else
		local var_17_6

		var_17_5, var_17_6 = var_0_0.ParseInfo(arg_17_0.artSceneInfo)
		table = var_8

		var_8.insert(var_17_0, function(arg_24_0)
			SceneOpMgr = var_2_10001

			local var_24_0 = var_2_10001.Inst
			local var_24_1 = var_1.UnloadSceneAsync

			string = var_2_10003

			var_24_1(var_24_0, var_2_10003.lower("dorm3d/scenesres/scenes/" .. var_17_6 .. "/" .. var_17_5 .. "_scene"), var_17_5, function()
				existCall = var_3_10000

				var_3_10000(arg_24_0)

				return
			end)

			return
		end)
	end

	table = var_17_5

	var_17_5.insert(var_17_0, function(arg_26_0)
		arg_26_0()

		if var_17_1 then
			var_17_2()
		end

		return
	end)

	arg_17_0.artSceneInfo = arg_17_1
	seriesAsync = var_6

	var_6(var_17_0, arg_17_2)

	return
end

function var_0_0.ChangeSubScene(arg_27_0, arg_27_1, arg_27_2)
	if var_0_0.IsSameSceneInfo(arg_27_1, arg_27_0.subSceneInfo) then
		existCall = var_3

		return var_3(arg_27_2)
	end

	local var_27_0 = {}
	local var_27_1 = false
	local var_27_2

	if not var_0_0.IsSameSceneInfo(arg_27_1, arg_27_0.sceneInfo) then
		var_27_1 = true
		table = var_6

		var_6.insert(var_27_0, function(arg_28_0)
			pg = var_2_10001

			local var_28_0 = var_2_10001.SceneAnimMgr.GetInstance()

			var_1.Dorm3DSceneChange(var_28_0, function(arg_29_0)
				var_27_2 = arg_29_0

				arg_28_0()

				return
			end)

			return
		end)

		local var_27_3, var_27_4 = var_0_0.ParseInfo(arg_27_1)
		local var_27_5 = var_27_3 .. "_base"

		table = var_8

		var_8.insert(var_27_0, function(arg_30_0)
			SceneOpMgr = var_2_10001

			local var_30_0 = var_2_10001.Inst
			local var_30_1 = var_1.LoadSceneAsync

			string = var_2_10003

			local var_30_2 = var_2_10003.lower("dorm3d/scenesres/scenes/" .. var_27_4 .. "/" .. var_27_5 .. "_scene")
			local var_30_3 = var_27_5

			LoadSceneMode = var_5

			var_30_1(var_30_0, var_30_2, var_30_3, var_5.Additive, arg_30_0)

			return
		end)
	end

	local var_27_6

	if not var_0_0.IsSameSceneInfo(arg_27_0.subSceneInfo, arg_27_0.sceneInfo) then
		local var_27_7

		var_27_6, var_27_7 = var_0_0.ParseInfo(arg_27_0.subSceneInfo)
		var_27_6 = var_27_6 .. "_base"
		table = var_8

		var_8.insert(var_27_0, function(arg_31_0)
			SceneOpMgr = var_2_10001

			local var_31_0 = var_2_10001.Inst
			local var_31_1 = var_1.UnloadSceneAsync

			string = var_2_10003

			var_31_1(var_31_0, var_2_10003.lower("dorm3d/scenesres/scenes/" .. var_27_7 .. "/" .. var_27_6 .. "_scene"), var_27_6, arg_31_0)

			return
		end)
	end

	table = var_27_6

	var_27_6.insert(var_27_0, function(arg_32_0)
		arg_32_0()

		if var_27_1 then
			var_27_2()
		end

		return
	end)

	arg_27_0.subSceneInfo = arg_27_1
	seriesAsync = var_6

	var_6(var_27_0, arg_27_2)

	return
end

function var_0_0.Dispose(arg_33_0)
	local var_33_0 = {}

	pairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(arg_33_0.cacheSceneDic) do
		if iter_33_1 then
			local var_33_1 = iter_33_1.assetRootName

			table = var_1_10008

			var_1_10008.insert(var_33_0, function(arg_34_0)
				SceneOpMgr = var_2_10001

				local var_34_0 = var_2_10001.Inst
				local var_34_1 = var_1.UnloadSceneAsync

				string = var_2_10003

				var_34_1(var_34_0, var_2_10003.lower("dorm3d/character/scenes/" .. var_33_1 .. "/timeline/" .. iter_33_0 .. "/" .. iter_33_0 .. "_scene"), iter_33_0, arg_34_0)

				return
			end)
		end
	end

	local var_33_2 = {
		arg_33_0.sceneInfo
	}

	if not var_0_0.IsSameSceneInfo(arg_33_0.subSceneInfo, arg_33_0.sceneInfo) then
		table = var_3

		var_3.insert(var_33_2, arg_33_0.subSceneInfo)
	end

	ipairs = var_3

	for iter_33_2, iter_33_3 in var_3(var_33_2) do
		local var_33_3, var_33_4 = var_0_0.ParseInfo(iter_33_3)
		local var_33_5 = var_33_3 .. "_base"

		table = var_10

		var_10.insert(var_33_0, function(arg_35_0)
			SceneOpMgr = var_2_10001

			local var_35_0 = var_2_10001.Inst
			local var_35_1 = var_1.UnloadSceneAsync

			string = var_2_10003

			var_35_1(var_35_0, var_2_10003.lower("dorm3d/scenesres/scenes/" .. var_33_4 .. "/" .. var_33_5 .. "_scene"), var_33_5, arg_35_0)

			return
		end)
	end

	local var_33_6 = {
		arg_33_0.sceneInfo
	}

	if not var_0_0.IsSameSceneInfo(arg_33_0.artSceneInfo, arg_33_0.sceneInfo) then
		table = var_4

		var_4.insert(var_33_6, arg_33_0.artSceneInfo)
	end

	ipairs = var_4

	for iter_33_4, iter_33_5 in var_4(var_33_6) do
		local var_33_7, var_33_8 = var_0_0.ParseInfo(iter_33_5)

		table = var_1_10011

		var_1_10011.insert(var_33_0, function(arg_36_0)
			SceneOpMgr = var_2_10001

			local var_36_0 = var_2_10001.Inst
			local var_36_1 = var_1.UnloadSceneAsync

			string = var_2_10003

			var_36_1(var_36_0, var_2_10003.lower("dorm3d/scenesres/scenes/" .. var_33_8 .. "/" .. var_33_7 .. "_scene"), var_33_7, arg_36_0)

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_33_0, function()
		arg_33_0.sceneInfo = nil
		arg_33_0.artSceneInfo = nil
		arg_33_0.subSceneInfo = nil
		arg_33_0.lastSceneRootDict = nil

		local var_37_0 = arg_33_0

		var_37_0.cacheSceneDic = nil
		print = var_37_0

		var_37_0("unload scene finish !")

		return
	end)

	return
end

function var_0_0.IsSameSceneInfo(arg_38_0, arg_38_1)
	string = var_1_10002

	local var_38_0 = var_1_10002.lower(arg_38_0)

	string = var_3

	return var_38_0 == var_3.lower(arg_38_1)
end

return var_0_0
