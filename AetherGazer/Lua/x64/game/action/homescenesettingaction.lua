local var_0_0 = {}

manager.net:Bind(32107, function(arg_1_0)
	HomeSceneSettingData:InitOverdueSceneList(arg_1_0.poster_background_list or {})
end)
manager.net:Bind(32011, function(arg_2_0)
	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.sub_poster_background_list) do
		local var_2_2 = iter_2_1.poster_background_id
		local var_2_3 = {}

		for iter_2_2, iter_2_3 in ipairs(iter_2_1.sub_background_list) do
			var_2_3[iter_2_3] = true
		end

		var_2_0[var_2_2] = var_2_3
		var_2_1[var_2_2] = iter_2_1.current_sub_background
	end

	HomeSceneSettingData:InitSpecialViewInfo(var_2_0, var_2_1)
end)

function var_0_0.DealOverdueScene()
	manager.net:SendWithLoadingNew(32112, {}, 32113, var_0_0.OnDealOverdueScene)
end

function var_0_0.OnDealOverdueScene(arg_4_0, arg_4_1)
	if isSuccess(arg_4_0.result) then
		-- block empty
	else
		ShowTips(arg_4_0.result)
	end
end

function var_0_0.SetHomeScene(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1 and HomeSceneSettingData:GetRealScene() or HomeSceneSettingData:GetCurScene()

	arg_5_0 = arg_5_0 or HomeSceneSettingData:GetCurSceneID()

	if arg_5_0 == var_5_0 and not arg_5_2 then
		return
	end

	local var_5_1 = {
		poster_background_id = arg_5_0
	}

	manager.net:SendWithLoadingNew(32108, var_5_1, 32109, var_0_0.OnSetHomeScene)
end

local function var_0_1(arg_6_0, arg_6_1)
	local var_6_0 = HomeSceneSettingData:GetCurScene()
	local var_6_1 = arg_6_1.poster_background_id

	HomeSceneSettingData:SetCurScene(var_6_1)

	if HomeSceneSettingData:IsRandomScene() and HomeSceneSettingData:GetUsedState(var_6_0) == SceneConst.HOME_SCENE_TYPE.LOCK then
		HomeSceneSettingData:CalcNextScene()
	end

	if IllustratedData:GetBgm() == 0 then
		local var_6_2 = SettingData:GetHomeSceneSettingData()
		local var_6_3 = HomeSceneSettingCfg[var_6_1]
		local var_6_4 = var_6_3.scene_setting
		local var_6_5 = var_6_3.default_music

		if var_6_5 ~= 0 and var_6_2.home_scene_scene_bgm == 1 and table.indexof(var_6_4, HomeSceneSettingConst.SETTING.SCENE_BGM) then
			IllustratedAction.QuerySetBgm(var_6_5)
		else
			local var_6_6 = HomeSceneSettingCfg[var_6_0]
			local var_6_7 = var_6_6.scene_setting
			local var_6_8 = var_6_6.default_music

			if var_6_8 ~= 0 and table.indexof(var_6_7, HomeSceneSettingConst.SETTING.SCENE_BGM) then
				IllustratedAction.QuerySetBgm(var_6_8)
			end
		end
	end

	manager.notify:CallUpdateFunc(HOME_SCENE_CHANGE)
	manager.notify:Invoke(HOME_SCENE_CHANGE)
end

function var_0_0.OnSetHomeScene(arg_7_0, arg_7_1)
	if isSuccess(arg_7_0.result) then
		var_0_1(arg_7_0, arg_7_1)
	else
		ShowTips(arg_7_0.result)
	end
end

function var_0_0.SetHomeSceneWithCallback(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_1 and HomeSceneSettingData:GetRealScene() or HomeSceneSettingData:GetCurScene()

	arg_8_0 = arg_8_0 or HomeSceneSettingData:GetCurSceneID()

	if arg_8_0 == var_8_0 and not arg_8_2 then
		if arg_8_3 then
			arg_8_3()
		end

		return
	end

	local var_8_1 = {
		poster_background_id = arg_8_0
	}

	manager.net:SendWithLoadingNew(32108, var_8_1, 32109, function(arg_9_0, arg_9_1)
		if isSuccess(arg_9_0.result) then
			var_0_1(arg_9_0, arg_9_1)

			if arg_8_3 then
				arg_8_3()
			end
		else
			ShowTips(arg_9_0.result)
		end
	end)
end

function var_0_0.CheckMatchScene(arg_10_0, arg_10_1)
	local var_10_0 = ItemCfg[arg_10_0].param[1]

	if CustomCenterTools.IsTimeChangeScene(var_10_0) and (arg_10_1 == 0 or arg_10_1 ~= 0 and arg_10_1 > manager.time:GetServerTime()) then
		HomeSceneSettingAction.SetHomeScene(var_10_0)

		return true
	end

	return false
end

function var_0_0.CheckPosterSceneCanUse(arg_11_0)
	if not arg_11_0 or arg_11_0 == 0 then
		return false
	end

	return HomeSceneSettingData:GetUsedState(arg_11_0) == SceneConst.HOME_SCENE_TYPE.TRIAL or HomeSceneSettingData:GetUsedState(arg_11_0) == SceneConst.HOME_SCENE_TYPE.UNLOCK
end

function var_0_0.AutoSwitchMatchSkinScene(arg_12_0)
	local var_12_0 = PlayerData:GetPlayerInfo()
	local var_12_1 = SkinCfg[var_12_0.poster_girl].hero

	if arg_12_0 ~= var_12_1 then
		return
	end

	local var_12_2 = HeroTools.HeroUsingSkinInfo(var_12_1).id
	local var_12_3 = HomeSceneSettingData:GetRealScene()
	local var_12_4 = CustomCenterTools.GetSkinSceneCfg(var_12_2, var_12_3) or CustomCenterTools.PickSkinSceneCfg(var_12_2)

	if var_12_4 then
		local var_12_5 = var_12_4.special_scene_id

		if var_0_0.CheckPosterSceneCanUse(var_12_5) then
			var_0_0.SetHomeScene(var_12_5)

			if PosterGirlTools.SceneHasTimeEffect(var_12_5) then
				HomeSceneSettingData:SetIsTimeScene(false)
			end

			return true
		end
	end

	if HomeSceneSettingCfg[var_12_3].limit_display == 0 then
		local var_12_6 = HomeSceneSettingData:GetDefaultScene()

		var_0_0.SetHomeScene(var_12_6, true)

		return true
	end

	return false
end

function var_0_0.CheckMatchPosterGirl(arg_13_0)
	local var_13_0 = HeroTools.HeroUsingSkinInfo(arg_13_0).id
	local var_13_1 = HomeSceneSettingData:GetRealScene()
	local var_13_2 = HomeSceneSettingCfg[var_13_1]

	if CustomCenterTools.GetSkinSceneCfg(var_13_0, var_13_1) then
		local var_13_3 = var_13_1

		if var_0_0.CheckPosterSceneCanUse(var_13_3) then
			HomeSceneSettingAction.SetHomeScene(var_13_3)

			if PosterGirlTools.SceneHasTimeEffect(var_13_3) then
				HomeSceneSettingData:SetIsTimeScene(false)
			end

			return true
		end
	end

	if var_13_2.limit_display == 0 then
		local var_13_4 = HomeSceneSettingData:GetDefaultScene()

		HomeSceneSettingAction.SetHomeScene(var_13_4)

		return true
	end

	return false
end

function var_0_0.ChangeSceneTab(arg_14_0)
	local var_14_0 = HomeSceneSettingData:GetCurScene()
	local var_14_1 = CustomCenterTools.GetSkinSceneCfg(arg_14_0, var_14_0)

	if var_14_1 and var_0_0.CheckPosterSceneCanUse(var_14_1.special_scene_id) then
		if var_14_0 ~= var_14_1.special_scene_id then
			HomeSceneSettingAction.SetHomeScene(var_14_1.special_scene_id)
			HomeSceneSettingData:SetIsUseDlcScene(true)
		else
			local var_14_2 = HomeSceneSettingData:GetDefaultScene()

			HomeSceneSettingAction.SetHomeScene(var_14_2)
			HomeSceneSettingData:SetIsUseDlcScene(false)
		end
	end
end

function var_0_0.SetIsRandomScene(arg_15_0, arg_15_1)
	local var_15_0 = PlayerTools.MakeRandomModeData(arg_15_0, HomeSceneSettingData:GetRandomMode())

	manager.net:SendWithLoadingNew(32124, {
		type = 2,
		model = var_15_0
	}, 32125, function(arg_16_0)
		if isSuccess(arg_16_0.result) then
			HomeSceneSettingData:SetIsRandomScene(arg_15_0)
			arg_15_1()
		else
			ShowTips(arg_16_0.result)
		end
	end)
end

function var_0_0.SetRandomMode(arg_17_0, arg_17_1)
	local var_17_0 = PlayerTools.MakeRandomModeData(HomeSceneSettingData:IsRandomScene(), arg_17_0)

	manager.net:SendWithLoadingNew(32124, {
		type = 2,
		model = var_17_0
	}, 32125, function(arg_18_0)
		if isSuccess(arg_18_0.result) then
			HomeSceneSettingData:SetRandomMode(arg_17_0)
			arg_17_1()
			manager.notify:Invoke(CUSTOM_CENTER_SWITCH_RANDOM_MODE)
		else
			ShowTips(arg_18_0.result)
		end
	end)
end

function var_0_0.SetRandomSceneList(arg_19_0, arg_19_1)
	manager.net:SendWithLoadingNew(32130, {
		type = 2,
		random_list = arg_19_0
	}, 32131, function(arg_20_0)
		if isSuccess(arg_20_0.result) then
			HomeSceneSettingData:SetRandomSceneList(arg_19_0)
			arg_19_1()
		else
			ShowTips(arg_20_0.result)
		end
	end)
end

function var_0_0.ChangeTimeScene(arg_21_0, arg_21_1)
	arg_21_0 = arg_21_0 or HomeSceneSettingData:GetCurScene()

	return CustomCenterTools.AutoChangeSceneByTime(arg_21_0, arg_21_1) or arg_21_0
end

function var_0_0.SelectSceneView(arg_22_0, arg_22_1)
	if HomeSceneSettingData:IsSpecialViewInfoInited() and HomeSceneSettingData:HasSpecialViewCfg(arg_22_0) then
		manager.net:SendWithLoadingNew(32134, {
			poster_background_id = arg_22_0,
			sub_poster_background = arg_22_1
		}, 32135, var_0_0.OnSelectSpecialView)
	end
end

function var_0_0.OnSelectSpecialView(arg_23_0, arg_23_1)
	if isSuccess(arg_23_0.result) then
		local var_23_0 = arg_23_1.poster_background_id
		local var_23_1 = arg_23_1.sub_poster_background

		HomeSceneSettingData:OnSelectSpecialView(var_23_0, var_23_1)
	else
		ShowTips(arg_23_0.result)
	end
end

return var_0_0
