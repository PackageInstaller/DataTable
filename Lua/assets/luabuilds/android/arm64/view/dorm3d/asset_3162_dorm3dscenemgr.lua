local Dorm3dSceneMgr = class("Dorm3dSceneMgr")

function Dorm3dSceneMgr:ParseInfo()
	return unpack(string.split(self, "|"))
end

function Dorm3dSceneMgr:Ctor(arg_2_1, arg_2_2)
	self.sceneInfo = arg_2_1
	self.artSceneInfo = self.sceneInfo
	self.subSceneInfo = self.sceneInfo
	self.lastSceneRootDict = {}
	self.cacheSceneDic = {}

	local var_2_0, var_2_1 = Dorm3dSceneMgr.ParseInfo(self.sceneInfo)

	seriesAsync({
		function(arg_3_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_2_1 .. "/" .. var_2_0 .. "_scene"), var_2_0, LoadSceneMode.Additive, function(arg_4_0, arg_4_1)
				self.originArtScene = arg_4_0

				SceneManager.SetActiveScene(arg_4_0)

				local var_4_0 = getSceneRootTFDic(arg_4_0).MainCamera

				if var_4_0 then
					setActive(var_4_0, false)
				end

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_2_1 .. "/" .. var_2_0 .. "_base_scene"), var_2_0 .. "_base", LoadSceneMode.Additive, arg_5_0)

			return
		end
	}, arg_2_2)

	return
end

function Dorm3dSceneMgr:EnableSceneDisplay(arg_6_1, arg_6_2)
	assert(tobool(self.lastSceneRootDict[arg_6_1]) == arg_6_2)

	if arg_6_2 then
		table.Foreach(self.lastSceneRootDict[arg_6_1], function(arg_7_0, arg_7_1)
			if IsNil(arg_7_0) then
				return
			end

			setActive(arg_7_0, arg_7_1)

			return
		end)

		self.lastSceneRootDict[arg_6_1] = nil
	else
		self.lastSceneRootDict[arg_6_1] = {}

		table.IpairsCArray(SceneManager.GetSceneByName(arg_6_1):GetRootGameObjects(), function(arg_8_0, arg_8_1)
			if tostring(arg_8_1.hideFlags) ~= "None" then
				return
			end

			self.lastSceneRootDict[arg_6_1][arg_8_1] = isActive(arg_8_1)

			setActive(arg_8_1, false)

			return
		end)
	end

	return
end

function Dorm3dSceneMgr:LoadTimelineScene(arg_9_1, arg_9_2)
	local var_9_0 = {}
	local var_9_1

	if not self.cacheSceneDic[arg_9_1.name] then
		self.cacheSceneDic[arg_9_1.name] = arg_9_1

		table.insert(var_9_0, function(arg_10_0)
			pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_11_0)
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
		table.insert(var_9_0, function(arg_12_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/character/" .. arg_9_1.assetRootName .. "/timeline/" .. arg_9_1.name .. "/" .. arg_9_1.name .. "_scene"), arg_9_1.name, LoadSceneMode.Additive, function(arg_13_0, arg_13_1)
				existCall(arg_9_1.loadSceneFunc, arg_13_0, arg_13_1)
				setActive(GameObject.Find("[camera]").transform:GetComponentInChildren(typeof(Camera)), false)
				arg_12_0()

				return
			end)

			return
		end)
	end

	table.insert(var_9_0, function(arg_14_0)
		if tobool(self.lastSceneRootDict[arg_9_1.name]) ~= tobool(arg_9_1.isCache) then
			self:EnableSceneDisplay(arg_9_1.name, not arg_9_1.isCache)
		end

		arg_14_0()
		existCall(var_9_1)

		return
	end)
	seriesAsync(var_9_0, arg_9_2)

	return
end

function Dorm3dSceneMgr:UnloadTimelineScene(arg_15_1, arg_15_2, arg_15_3)
	assert(self.cacheSceneDic[arg_15_1])

	if tobool(arg_15_2) == tobool(self.cacheSceneDic[arg_15_1].isCache) then
		SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/character/scenes/" .. self.cacheSceneDic[arg_15_1].assetRootName .. "/timeline/" .. arg_15_1 .. "/" .. arg_15_1 .. "_scene"), arg_15_1, function()
			self.cacheSceneDic[arg_15_1] = nil
			self.lastSceneRootDict[arg_15_1] = nil

			existCall(arg_15_3)

			return
		end)
	else
		self:EnableSceneDisplay(arg_15_1, false)
		existCall(arg_15_3)
	end

	return
end

function Dorm3dSceneMgr:ChangeArtScene(arg_17_1, arg_17_2)
	if Dorm3dSceneMgr.IsSameSceneInfo(arg_17_1, self.artSceneInfo) then
		existCall(arg_17_2)

		return
	end

	local var_17_0 = {}
	local var_17_1 = false
	local var_17_2

	if Dorm3dSceneMgr.IsSameSceneInfo(arg_17_1, self.sceneInfo) then
		table.insert(var_17_0, function(arg_18_0)
			local var_18_0, var_18_1 = Dorm3dSceneMgr.ParseInfo(self.sceneInfo)

			SceneManager.SetActiveScene(SceneManager.GetSceneByName(var_18_0))
			self:EnableSceneDisplay(var_18_0, true)
			arg_18_0()

			return
		end)
	else
		var_17_1 = true

		table.insert(var_17_0, function(arg_19_0)
			pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_20_0)
				var_17_2 = arg_20_0

				arg_19_0()

				return
			end)

			return
		end)

		local var_17_3, var_17_4 = Dorm3dSceneMgr.ParseInfo(arg_17_1)

		table.insert(var_17_0, function(arg_21_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_17_4 .. "/" .. var_17_3 .. "_scene"), var_17_3, LoadSceneMode.Additive, function(arg_22_0, arg_22_1)
				SceneManager.SetActiveScene(arg_22_0)

				local var_22_0 = getSceneRootTFDic(arg_22_0).MainCamera

				if var_22_0 then
					setActive(var_22_0, false)
				end

				arg_21_0()

				return
			end)

			return
		end)
	end

	if Dorm3dSceneMgr.IsSameSceneInfo(self.artSceneInfo, self.sceneInfo) then
		table.insert(var_17_0, function(arg_23_0)
			local var_23_0, var_23_1 = Dorm3dSceneMgr.ParseInfo(self.sceneInfo)

			self:EnableSceneDisplay(var_23_0, false)
			arg_23_0()

			return
		end)
	else
		local var_17_5, var_17_6 = Dorm3dSceneMgr.ParseInfo(self.artSceneInfo)

		table.insert(var_17_0, function(arg_24_0)
			SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_17_6 .. "/" .. var_17_5 .. "_scene"), var_17_5, function()
				existCall(arg_24_0)

				return
			end)

			return
		end)
	end

	table.insert(var_17_0, function(arg_26_0)
		arg_26_0()

		if var_17_1 then
			var_17_2()
		end

		return
	end)

	self.artSceneInfo = arg_17_1

	seriesAsync(var_17_0, arg_17_2)

	return
end

function Dorm3dSceneMgr:ChangeSubScene(arg_27_1, arg_27_2)
	if Dorm3dSceneMgr.IsSameSceneInfo(arg_27_1, self.subSceneInfo) then
		return existCall(arg_27_2)
	end

	local var_27_0 = {}
	local var_27_1 = false
	local var_27_2

	if not Dorm3dSceneMgr.IsSameSceneInfo(arg_27_1, self.sceneInfo) then
		var_27_1 = true

		table.insert(var_27_0, function(arg_28_0)
			pg.SceneAnimMgr.GetInstance():Dorm3DSceneChange(function(arg_29_0)
				var_27_2 = arg_29_0

				arg_28_0()

				return
			end)

			return
		end)

		local var_27_3, var_27_4 = Dorm3dSceneMgr.ParseInfo(arg_27_1)
		local var_27_5 = var_27_3 .. "_base"

		table.insert(var_27_0, function(arg_30_0)
			SceneOpMgr.Inst:LoadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_27_4 .. "/" .. var_27_5 .. "_scene"), var_27_5, LoadSceneMode.Additive, arg_30_0)

			return
		end)
	end

	if not Dorm3dSceneMgr.IsSameSceneInfo(self.subSceneInfo, self.sceneInfo) then
		local var_27_6, var_27_7 = Dorm3dSceneMgr.ParseInfo(self.subSceneInfo)
		local var_27_8 = var_27_6 .. "_base"

		table.insert(var_27_0, function(arg_31_0)
			SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_27_7 .. "/" .. var_27_8 .. "_scene"), var_27_8, arg_31_0)

			return
		end)
	end

	table.insert(var_27_0, function(arg_32_0)
		arg_32_0()

		if var_27_1 then
			var_27_2()
		end

		return
	end)

	self.subSceneInfo = arg_27_1

	seriesAsync(var_27_0, arg_27_2)

	return
end

function Dorm3dSceneMgr:Dispose()
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in pairs(self.cacheSceneDic) do
		if iter_33_1 then
			local var_33_1 = iter_33_1.assetRootName

			table.insert(var_33_0, function(arg_34_0)
				SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/character/scenes/" .. var_33_1 .. "/timeline/" .. iter_33_0 .. "/" .. iter_33_0 .. "_scene"), iter_33_0, arg_34_0)

				return
			end)
		end
	end

	local var_33_2 = {
		self.sceneInfo
	}

	if not Dorm3dSceneMgr.IsSameSceneInfo(self.subSceneInfo, self.sceneInfo) then
		table.insert(var_33_2, self.subSceneInfo)
	end

	for iter_33_2, iter_33_3 in ipairs(var_33_2) do
		local var_33_3, var_33_4 = Dorm3dSceneMgr.ParseInfo(iter_33_3)
		local var_33_5 = var_33_3 .. "_base"

		table.insert(var_33_0, function(arg_35_0)
			SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_33_4 .. "/" .. var_33_5 .. "_scene"), var_33_5, arg_35_0)

			return
		end)
	end

	local var_33_6 = {
		self.sceneInfo
	}

	if not Dorm3dSceneMgr.IsSameSceneInfo(self.artSceneInfo, self.sceneInfo) then
		table.insert(var_33_6, self.artSceneInfo)
	end

	for iter_33_4, iter_33_5 in ipairs(var_33_6) do
		local var_33_7, var_33_8 = Dorm3dSceneMgr.ParseInfo(iter_33_5)

		table.insert(var_33_0, function(arg_36_0)
			SceneOpMgr.Inst:UnloadSceneAsync(string.lower("dorm3d/scenesres/scenes/" .. var_33_8 .. "/" .. var_33_7 .. "_scene"), var_33_7, arg_36_0)

			return
		end)
	end

	seriesAsync(var_33_0, function()
		self.sceneInfo = nil
		self.artSceneInfo = nil
		self.subSceneInfo = nil
		self.lastSceneRootDict = nil
		self.cacheSceneDic = nil

		print("unload scene finish !")

		return
	end)

	return
end

function Dorm3dSceneMgr:IsSameSceneInfo(arg_38_1)
	return string.lower(self) == string.lower(arg_38_1)
end

return Dorm3dSceneMgr
