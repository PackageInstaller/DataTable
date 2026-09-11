local var_0_0 = singletonClass("LoadSceneMgr")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.loadScenePool_ = {}
	arg_1_0.isLoading_ = false
	arg_1_0.cacheSceneNameList_ = {}
	arg_1_0.loadInit_ = SceneLoadAndUnloadManager.Instance
end

function var_0_0:GetNeedLoadSceneName(arg_2_1)
	local var_2_0

	for iter_2_0 = #arg_2_1, 1, -1 do
		if SceneConst.NEED_CHANGE_SCENE_URL_LIST[arg_2_1[iter_2_0]] then
			var_2_0 = arg_2_1[iter_2_0]

			local var_2_1, var_2_2 = self:GetShouldLoadSceneName(arg_2_1[iter_2_0])

			if not self.loadScenePool_[arg_2_1[iter_2_0]] or self:IsNeedLoadScene(arg_2_1[iter_2_0], var_2_2) then
				return arg_2_1[iter_2_0], var_2_0
			end
		end
	end

	return nil, var_2_0
end

function var_0_0:ForceSetShouldLoadSceneName(arg_3_1, arg_3_2)
	if not SceneConst.NEED_CHANGE_SCENE_URL_LIST[arg_3_1] then
		if arg_3_2 then
			arg_3_2()
		end

		return
	end

	local var_3_0, var_3_1 = self:GetShouldLoadSceneName(arg_3_1)

	if var_3_1 == self.loadScenePool_[arg_3_1] then
		if arg_3_2 then
			arg_3_2()
		end

		return
	end

	self:TryStopSceneSoundEffect(arg_3_1)
	SetForceShowQuanquan(true)

	self.isLoading_ = true

	self.loadInit_:ChangeScene(var_3_0, self.loadScenePool_[arg_3_1], function()
		self.isLoading_ = false

		self:SetLoadSceneTable(arg_3_1, var_3_1)
		SetForceShowQuanquan(false)

		if arg_3_2 then
			arg_3_2()
		end
	end)
end

function var_0_0:SetShouldLoadSceneName(arg_5_1)
	if not SceneConst.NEED_CHANGE_SCENE_URL_LIST[arg_5_1] then
		return
	end

	local var_5_0, var_5_1 = self:GetShouldLoadSceneName(arg_5_1)

	if var_5_1 == self.loadScenePool_[arg_5_1] then
		return
	end

	self:TryStopSceneSoundEffect(arg_5_1)

	self.isLoading_ = true

	self.loadInit_:ChangeScene(var_5_0, self.loadScenePool_[arg_5_1], function()
		self.isLoading_ = false

		self:SetLoadSceneTable(arg_5_1, var_5_1)
	end)
end

function var_0_0:SetLoadSceneTable(arg_7_1, arg_7_2)
	self.loadScenePool_[arg_7_1] = arg_7_2

	if arg_7_1 == "sectionSelectHero" or arg_7_1 == "cooperationSectionSelectHero" then
		return
	end

	local var_7_0

	if SceneManager.GetSceneByName(arg_7_2).rootCount > 0 then
		var_7_0 = SceneManager.GetSceneByName(arg_7_2):GetRootGameObjects()
	end

	if var_7_0 ~= nil then
		local var_7_1 = gameContext:GetFirstRoutePage()

		for iter_7_0 = #self.cacheSceneNameList_, 1, -1 do
			if arg_7_1 == self.cacheSceneNameList_[iter_7_0] then
				if self.cacheSceneNameList_[iter_7_0] ~= var_7_1 then
					self:ActiveScene(var_7_0, arg_7_2, false)
				else
					self:ActiveScene(var_7_0, arg_7_2, true)
				end

				table.remove(self.cacheSceneNameList_, iter_7_0)
			end
		end

		manager.notify:Invoke("ON_ASYNC_SCENE_LOADED", arg_7_2)
	end
end

function var_0_0.ActiveScene(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	for iter_8_0 = 0, arg_8_1.Length - 1 do
		if arg_8_1[iter_8_0].name == arg_8_2 then
			SetActive(arg_8_1[iter_8_0], arg_8_3)

			if arg_8_3 then
				manager.ui:SetScene(arg_8_1[iter_8_0])
			end
		end
	end
end

function var_0_0:GetShouldLoadSceneName(arg_9_1)
	local var_9_0 = ""
	local var_9_1 = ""

	if arg_9_1 == "home" or arg_9_1 == "chat" or arg_9_1 == "userinfo" then
		var_9_1 = self:GetHomeShouldLoadSceneName()
		var_9_0 = "Levels/" .. var_9_1
	elseif arg_9_1 == "homePreview" then
		var_9_1 = self:GetPreviewHomeShouldLoadSceneName()
		var_9_0 = "Levels/" .. var_9_1
	elseif SceneConst.RESERVE_VIEW_PAGE[arg_9_1] == true then
		var_9_1 = "X104"
		var_9_0 = "Levels/X104"
	elseif arg_9_1 == "furniturePreview" then
		var_9_1 = "X100_DormPreview"
		var_9_0 = "Levels/X100_DormPreview"
	elseif arg_9_1 == "furniturePreviewWithEntity" then
		var_9_1 = "X100_DormPreviewWithEntity"
		var_9_0 = "Levels/X100_DormPreviewWithEntity"
	else
		error("未实现界面场景获取途径")
	end

	self:DealCommonScene(arg_9_1)

	return var_9_0, var_9_1
end

function var_0_0.GetShouldLoadSceneNameID(arg_10_0, arg_10_1)
	if arg_10_1 == "home" or arg_10_1 == "chat" or arg_10_1 == "userinfo" then
		return (manager.loadScene:GetTimeSceneID((HomeSceneSettingData:GetCurScene())))
	elseif arg_10_1 == "homePreview" then
		return (HomeSceneSettingData:GetPreviewScene())
	elseif SceneConst.RESERVE_VIEW_PAGE[arg_10_1] == true then
		return -1
	elseif arg_10_1 == "furniturePreview" or arg_10_1 == "furniturePreviewWithEntity" then
		return -1
	else
		error("未实现界面场景获取途径")
	end
end

function var_0_0:DealCommonScene(arg_11_1)
	local var_11_0 = {
		"home",
		"homePreview",
		"userinfo",
		"chat",
		"clubBoss"
	}

	for iter_11_0, iter_11_1 in pairs(SceneConst.RESERVE_VIEW_PAGE) do
		var_11_0[#var_11_0 + 1] = iter_11_0
	end

	if not table.indexof(var_11_0, arg_11_1) then
		return
	end

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		if iter_11_3 ~= arg_11_1 and self.loadScenePool_[iter_11_3] then
			self.loadScenePool_[arg_11_1] = self.loadScenePool_[iter_11_3]
			self.loadScenePool_[iter_11_3] = nil
		end
	end
end

function var_0_0:IsNeedLoadScene(arg_12_1, arg_12_2)
	local var_12_0 = {
		"home",
		"homePreview",
		"userinfo",
		"chat",
		"clubBoss"
	}

	for iter_12_0, iter_12_1 in pairs(SceneConst.RESERVE_VIEW_PAGE) do
		var_12_0[#var_12_0 + 1] = iter_12_0
	end

	if not table.indexof(var_12_0, arg_12_1) then
		return self.loadScenePool_[arg_12_1] ~= arg_12_2
	end

	for iter_12_2, iter_12_3 in ipairs(var_12_0) do
		if self.loadScenePool_[iter_12_3] and self.loadScenePool_[iter_12_3] ~= arg_12_2 then
			return true
		end
	end

	return false
end

function var_0_0:CanEnd()
	return not self.isLoading_
end

local function var_0_1(arg_14_0, arg_14_1)
	local var_14_0 = CustomCenterTools.GetSkinSceneCfg(arg_14_1, arg_14_0)

	if var_14_0 and arg_14_0 == var_14_0.special_scene_id and not string.isNullOrEmpty(HomeSceneSettingCfg[arg_14_0].prefix_dlc) then
		return HomeSceneSettingCfg[arg_14_0].prefix_dlc
	end

	return HomeSceneSettingCfg[arg_14_0].prefix
end

function var_0_0:GetHomeShouldLoadSceneName(arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1 or HomeSceneSettingData:GetCurScene()

	if not arg_15_1 and HomeSceneSettingData:GetUsedState(var_15_0) == SceneConst.HOME_SCENE_TYPE.LOCK then
		var_15_0 = GameSetting.home_sence_default.value[1]

		HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[1])
	end

	local var_15_3 = manager.time:GetServerTime()
	local var_15_4 = self:GetTimeSceneID(var_15_0)
	local var_15_5 = ""
	local var_15_6 = ""
	local var_15_7 = ""

	for iter_15_0, iter_15_1 in ipairs(HomeSceneSettingCfg[var_15_4].impact) do
		if iter_15_1 == SceneConst.HOME_SCENE_IMPACT.WEATHER then
			var_15_5 = self:GetWeatherScene()
		elseif iter_15_1 == SceneConst.HOME_SCENE_IMPACT.DATA then
			var_15_6 = self:GetDataScene()
		elseif iter_15_1 == SceneConst.HOME_SCENE_IMPACT.TIME then
			var_15_7 = self:GetTimeScene((manager.time:STimeDescS(var_15_3, "!%H")))
		end
	end

	return var_0_1(var_15_4, (not arg_15_2 or nil) and PlayerData:GetPosterGirlHeroSkinId()) .. var_15_5 .. var_15_6 .. var_15_7
end

function var_0_0:GetTimeSceneID(arg_16_1)
	if not self.sceneDisableAutoChange_ and HomeSceneSettingData:IsTimeScene() and not CustomCenterTools.IsRandomScene() and PosterGirlTools.SceneHasTimeEffect(arg_16_1) then
		return HomeSceneSettingAction.ChangeTimeScene(arg_16_1, (manager.time:GetServerTime()))
	end

	return arg_16_1
end

function var_0_0.GetWeatherScene(arg_17_0)
	return ""
end

function var_0_0.GetDataScene(arg_18_0)
	return ""
end

function var_0_0.GetTimeScene(arg_19_0, arg_19_1)
	local var_19_0 = tonumber(arg_19_1)

	for iter_19_0, iter_19_1 in ipairs(HomeSceneCfg.get_id_list_by_type[SceneConst.HOME_SCENE_IMPACT.TIME]) do
		if HomeSceneCfg[iter_19_1].start_time <= var_19_0 and var_19_0 <= HomeSceneCfg[iter_19_1].end_time then
			return HomeSceneCfg[iter_19_1].scene
		end
	end

	return ""
end

function var_0_0.GetPreviewHomeShouldLoadSceneName(arg_20_0)
	local var_20_0, var_20_1 = HomeSceneSettingData:GetPreviewScene()
	local var_20_2 = HomeSceneSettingCfg[var_20_0]

	if not var_20_0 and HomeSceneSettingData:GetUsedState(var_20_0) == SceneConst.HOME_SCENE_TYPE.LOCK then
		var_20_0 = GameSetting.home_sence_default.value[1]
		var_20_2 = HomeSceneSettingCfg[GameSetting.home_sence_default.value[1]]

		HomeSceneSettingAction.SetHomeScene(GameSetting.home_sence_default.value[1])
	end

	local var_20_3 = ""
	local var_20_4 = ""
	local var_20_5 = ""

	for iter_20_0, iter_20_1 in ipairs(var_20_2.impact) do
		if iter_20_1 == SceneConst.HOME_SCENE_IMPACT.WEATHER then
			var_20_3 = var_20_1.weather
		elseif iter_20_1 == SceneConst.HOME_SCENE_IMPACT.DATA then
			var_20_4 = var_20_1.data
		elseif iter_20_1 == SceneConst.HOME_SCENE_IMPACT.TIME then
			var_20_5 = var_20_1.time
		end
	end

	return var_0_1(var_20_0, var_20_1.skinID) .. var_20_3 .. var_20_4 .. var_20_5
end

function var_0_0.SetHomeSceneSoundEffect(arg_21_0)
	if not table.indexof(HomeSceneSettingCfg[HomeSceneSettingData:GetCurScene()].scene_setting, HomeSceneSettingConst.SETTING.SOUND_EFFECT) then
		return
	end

	if SettingData:GetHomeSceneSettingData().home_scene_sound_effect ~= 1 then
		manager.audio:PlayEffect("ui_scene", "ui_scene_x201_stop", "")
		manager.audio:PlayEffect("ui_scene", "ui_scene_ambience_loop_stop", "")
	end
end

function var_0_0.SetPreviewHomeSceneSoundEffect(arg_22_0)
	local var_22_0, var_22_1 = HomeSceneSettingData:GetPreviewScene()

	if not table.indexof(HomeSceneSettingCfg[var_22_0].scene_setting, HomeSceneSettingConst.SETTING.SOUND_EFFECT) then
		return
	end

	if SettingData:GetHomeSceneSettingData().home_scene_sound_effect ~= 1 then
		manager.audio:PlayEffect("ui_scene", "ui_scene_x201_stop", "")
		manager.audio:PlayEffect("ui_scene", "ui_scene_ambience_loop_stop", "")
	end
end

function var_0_0:TryStopSceneSoundEffect(arg_23_1)
	local var_23_0 = HomeSceneSettingCfg[self:GetShouldLoadSceneNameID(arg_23_1)]

	if var_23_0 then
		if not table.indexof(var_23_0.scene_setting, HomeSceneSettingConst.SETTING.SOUND_EFFECT) then
			self:StopSceneSoundEffect()
		end
	else
		self:StopSceneSoundEffect()
	end
end

function var_0_0.StopSceneSoundEffect(arg_24_0)
	manager.audio:PlayEffect("ui_scene", "ui_scene_x201_stop", "")
	manager.audio:PlayEffect("ui_scene", "ui_scene_ambience_loop_stop", "")
end

function var_0_0.SetSceneWeather(arg_25_0, arg_25_1)
	local var_25_0, var_25_1 = PosterGirlTools.GetLoadWeatherEffect(arg_25_1)

	if var_25_0 then
		manager.ui:SetSceneWeatherEffect(var_25_1)
	end

	arg_25_0.curWeather_ = arg_25_1
end

function var_0_0:GetCurWeather()
	return self.curWeather_ or SceneConst.HOME_SCENE_WEATHER.SUNNY
end

function var_0_0:GetLoadScenePool()
	return self.loadScenePool_
end

function var_0_0:Dispose()
	for iter_28_0, iter_28_1 in pairs(self.loadScenePool_) do
		SceneManager.UnloadSceneAsync(iter_28_1)
	end

	self.loadScenePool_ = {}
	self.cacheSceneNameList_ = {}
end

function var_0_0:HideLastSceneList()
	for iter_29_0 = #self.cacheSceneNameList_, 1, -1 do
		if self.loadScenePool_[self.cacheSceneNameList_[iter_29_0]] then
			local var_29_0, var_29_1 = self:GetShouldLoadSceneName(self.cacheSceneNameList_[iter_29_0])
			local var_29_2 = SceneManager.GetSceneByName(var_29_1)

			if var_29_2.rootCount > 0 then
				local var_29_3 = var_29_2:GetRootGameObjects()

				if var_29_3 then
					self:ActiveScene(var_29_3, var_29_1, false)
					table.remove(self.cacheSceneNameList_, iter_29_0)
				end
			end
		end
	end
end

function var_0_0:SetCurSceneActive(arg_30_1)
	local var_30_0 = HomeSceneSettingCfg[HomeSceneSettingData:GetCurScene()].prefix
	local var_30_1 = SceneManager.GetSceneByName(var_30_0)

	if var_30_1 and var_30_1.rootCount > 0 then
		self:ActiveScene(var_30_1:GetRootGameObjects(), var_30_0, arg_30_1)
	end
end

function var_0_0:AddCachePage()
	if not self:CanEnd() then
		table.insert(self.cacheSceneNameList_, (gameContext:GetFirstRoutePage()))
	end
end

function var_0_0.SetSceneDisableAutoChange(arg_32_0, arg_32_1)
	arg_32_0.sceneDisableAutoChange_ = arg_32_1
end

function var_0_0.SetSceneActive(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = manager.ui:GetSceneByName(arg_33_1)

	LuaForUtil.SetSceneSetting(var_33_0, arg_33_2)
	SetActive(var_33_0, arg_33_2)
end

return var_0_0
