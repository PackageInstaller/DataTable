local var_0_0 = {
	IsRandomHero = function()
		return PlayerData:IsRandomHero()
	end
}

function var_0_0.GetRandomHeroList()
	local var_2_0 = PlayerData:GetRandomHeroList()

	for iter_2_0 = #var_2_0, 1, -1 do
		local var_2_1 = var_2_0[iter_2_0]
		local var_2_2 = SkinCfg[var_2_1].hero

		if not var_0_0.IsValidHeroSkin(var_2_2, var_2_1) then
			local var_2_3 = var_0_0.GetValidHeroSkin(var_2_2)

			if var_0_0.IsValidHeroSkin(var_2_2, var_2_3) and not table.keyof(var_2_0, var_2_3) then
				var_2_0[iter_2_0] = var_2_3
			else
				table.remove(var_2_0, iter_2_0)
			end
		end
	end

	return var_2_0
end

function var_0_0.GetValidHeroSkin(arg_3_0)
	if CustomCenterTools.IsRandomHero() then
		local var_3_0 = HeroTools.HeroUsingSkinInfo(arg_3_0).id

		if var_0_0.IsValidHeroSkin(arg_3_0, var_3_0) then
			return var_3_0
		else
			return arg_3_0
		end
	else
		return arg_3_0
	end
end

function var_0_0.IsValidHeroSkin(arg_4_0, arg_4_1)
	local var_4_0 = HeroData:GetHeroData(arg_4_0)

	if arg_4_0 == arg_4_1 then
		return true
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_0.unlocked_skin) do
		if iter_4_1.skin_id == arg_4_1 then
			if iter_4_1.time == 0 then
				return true
			end

			if manager.time:GetServerTime() < iter_4_1.time then
				return true
			end

			return false
		end
	end

	return false
end

function var_0_0.IsValidScene(arg_5_0)
	local var_5_0 = HomeSceneSettingData:GetSceneTimeStamp(arg_5_0)

	if var_5_0 == 0 then
		return true
	end

	if var_5_0 > manager.time:GetServerTime() then
		return true
	end

	return false
end

function var_0_0.GetRandomHeroCnt()
	return #PlayerData:GetCacheHeroSkinList()
end

function var_0_0.IsContentRandomHeroSkinID(arg_7_0)
	if var_0_0.IsRandomHero() == false then
		return false
	end

	local var_7_0 = PlayerData:GetCacheHeroSkinList()

	return table.keyof(var_7_0, arg_7_0) ~= nil
end

function var_0_0.SetCacheRandomHeroSkinList(arg_8_0)
	PlayerData:SetCacheHeroSkinList(arg_8_0)
end

function var_0_0.UpdateCacheRandomHeroSkinID(arg_9_0)
	PlayerData:UpdateCacheHeroSkinID(arg_9_0)
end

function var_0_0.CanUpdateCacheRandomHeroSkinID(arg_10_0)
	local var_10_0 = PlayerData:GetCacheHeroSkinList()

	if #var_10_0 == 1 and var_10_0[1] == arg_10_0 then
		return false
	end

	return true
end

function var_0_0.GetHeroUseSkinCnt(arg_11_0)
	local var_11_0 = 0

	if CustomCenterTools.IsRandomHero() then
		local var_11_1 = PlayerData:GetCacheHeroSkinList()

		for iter_11_0, iter_11_1 in pairs(var_11_1) do
			if SkinCfg[iter_11_1].hero == arg_11_0 then
				var_11_0 = var_11_0 + 1
			end
		end

		return var_11_0
	else
		local var_11_2 = PlayerData:GetPosterGirlHeroSkinId()

		if SkinCfg[var_11_2].hero == arg_11_0 then
			return 1
		else
			return 0
		end
	end
end

function var_0_0.GetSkinSceneCfg(arg_12_0, arg_12_1)
	local var_12_0 = nullable(SkinSceneActionCfg.get_id_list_by_skin_id_special_scene_id, arg_12_0, arg_12_1, 1)

	return nullable(SkinSceneActionCfg, var_12_0)
end

function var_0_0.PickMatchSkinScene(arg_13_0, arg_13_1)
	local var_13_0 = SkinSceneActionCfg.get_id_list_by_skin_id_special_scene_id[arg_13_0]

	if var_13_0 then
		local var_13_1 = {}

		for iter_13_0, iter_13_1 in pairs(var_13_0) do
			table.insert(var_13_1, iter_13_0)
		end

		table.sort(var_13_1, arg_13_1)

		return var_13_1[1]
	end
end

function var_0_0.PickSkinSceneCfg(arg_14_0, arg_14_1)
	local var_14_0 = var_0_0.PickMatchSkinScene(arg_14_0, arg_14_1) or 0

	return var_0_0.GetSkinSceneCfg(arg_14_0, var_14_0)
end

local function var_0_1(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1[arg_15_0] == nil then
		local var_15_0 = HomeSceneSettingData:CanUseScene(arg_15_0)

		if var_15_0 then
			table.insert(arg_15_2, arg_15_0)
		else
			table.insert(arg_15_3, arg_15_0)
		end

		arg_15_1[arg_15_0] = var_15_0
	end
end

function var_0_0.GetSceneList(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = {}
	local var_16_2 = SkinSceneActionCfg.get_id_list_by_skin_id_special_scene_id[arg_16_0]
	local var_16_3 = {}

	var_0_1(arg_16_1, var_16_3, var_16_0, var_16_1)

	local var_16_4

	if var_0_0.IsRandomScene() then
		var_16_4 = HomeSceneSettingData:GetCacheRandomSceneList()[1]
	else
		var_16_4 = HomeSceneSettingData:GetSceneID(arg_16_0)
	end

	var_0_1(var_16_4, var_16_3, var_16_0, var_16_1)

	if var_16_2 then
		for iter_16_0, iter_16_1 in pairs(var_16_2) do
			var_0_1(iter_16_0, var_16_3, var_16_0, var_16_1)
		end
	end

	for iter_16_2, iter_16_3 in ipairs(HomeSceneSettingCfg.get_id_list_by_limit_display[1]) do
		var_0_1(iter_16_3, var_16_3, var_16_0, var_16_1)
	end

	table.insertto(var_16_0, var_16_1)

	return var_16_0
end

function var_0_0.HasDLCScene(arg_17_0)
	local var_17_0 = SkinSceneActionCfg.get_id_list_by_skin_id_special_scene_id[arg_17_0]

	if var_17_0 == nil then
		return false
	end

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_1 = HomeSceneSettingCfg[iter_17_0].limit_display == 1
		local var_17_2 = HomeSceneSettingData:GetUsedState(iter_17_0) == SceneConst.HOME_SCENE_TYPE.LOCK

		if not var_17_1 and not var_17_2 then
			return true
		end
	end

	return false
end

local function var_0_2(arg_18_0, arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(arg_18_0) do
		table.insert(var_18_0, iter_18_0)
	end

	table.sort(var_18_0, arg_18_1)

	return var_18_0
end

local function var_0_3(arg_19_0, arg_19_1)
	if arg_19_0 == arg_19_1 then
		return false
	elseif arg_19_0 == 0 then
		return false
	elseif arg_19_1 == 0 then
		return true
	else
		return arg_19_0 < arg_19_1
	end
end

function var_0_0.PickSkinMatchedScene(arg_20_0)
	local var_20_0 = SkinSceneActionCfg.get_id_list_by_skin_id_special_scene_id[arg_20_0]

	if var_20_0 then
		local var_20_1 = next(var_20_0)

		if var_20_1 ~= 0 then
			return var_20_1
		end
	end

	return nil
end

function var_0_0.PickRndSkinMatchedScene(arg_21_0)
	local var_21_0 = SkinSceneActionCfg.get_id_list_by_skin_id_special_scene_id[arg_21_0]

	if var_21_0 then
		local var_21_1 = var_0_2(var_21_0, var_0_3)
		local var_21_2 = var_21_0[var_21_1[math.random(#var_21_1)]]

		if var_21_2 ~= 0 then
			return var_21_2
		end
	end

	return nil
end

function var_0_0.PickFirstAvailableMatchedScene(arg_22_0)
	local var_22_0 = SkinSceneActionCfg.get_id_list_by_skin_id_special_scene_id[arg_22_0]

	if var_22_0 then
		local var_22_1 = var_0_2(var_22_0, var_0_3)

		for iter_22_0, iter_22_1 in ipairs(var_22_1) do
			if iter_22_1 ~= 0 and HomeSceneSettingData:CanUseScene(iter_22_1) then
				return iter_22_1
			end
		end
	end

	return nil
end

function var_0_0.GetDLCScene(arg_23_0)
	return nullable(SkinSceneActionCfg, var_0_0.PickFirstAvailableMatchedScene(arg_23_0))
end

function var_0_0.GetMatchedDLCScene(arg_24_0)
	local var_24_0 = var_0_0.PickRndSkinMatchedScene(arg_24_0)

	if var_24_0 ~= nil and type(var_24_0) == "table" then
		var_24_0 = var_24_0[1]
	end

	return (nullable(SkinSceneActionCfg, var_24_0))
end

function var_0_0.GetDlcMatchSkinIndex(arg_25_0, arg_25_1)
	local var_25_0 = SkinSceneActionCfg.get_id_list_by_skin_id_special_scene_id[arg_25_1]

	if var_25_0 then
		local var_25_1 = var_0_2(var_25_0, var_0_3)

		for iter_25_0, iter_25_1 in ipairs(var_25_1) do
			if iter_25_1 == arg_25_0 then
				return iter_25_0
			end
		end
	end

	return nil
end

function var_0_0.IsRandomScene()
	return HomeSceneSettingData:IsRandomScene()
end

function var_0_0.SetCacheRandomSceneList(arg_27_0)
	HomeSceneSettingData:SetCacheRandomSceneList(arg_27_0)
end

function var_0_0.GetRandomSceneCnt()
	return #HomeSceneSettingData:GetCacheRandomSceneList()
end

function var_0_0.IsContentRandomSceneID(arg_29_0)
	if var_0_0.IsRandomScene() == false then
		return false
	end

	local var_29_0 = HomeSceneSettingData:GetCacheRandomSceneList()

	return table.keyof(var_29_0, arg_29_0) ~= nil
end

function var_0_0.CanUpdateCacheRandomSceneID(arg_30_0)
	local var_30_0 = HomeSceneSettingData:GetCacheRandomSceneList()

	if #var_30_0 == 1 and var_30_0[1] == arg_30_0 then
		return false
	end

	return true
end

function var_0_0.UpdateCacheRandomSceneID(arg_31_0)
	HomeSceneSettingData:UpdateCacheRandomSceneList(arg_31_0)
end

function var_0_0.SetUseSelectedScene()
	local var_32_0 = HomeSceneSettingData:GetPreviewScene()

	HomeSceneSettingAction.SetHomeScene(var_32_0, true)
end

function var_0_0.IsDLCScene(arg_33_0)
	if HomeSceneSettingCfg[arg_33_0].limit_display == 1 then
		return false
	end

	return true
end

function var_0_0.IsMatchHeroScene(arg_34_0, arg_34_1)
	if HomeSceneSettingData:CanUseScene(arg_34_1) == false then
		return false
	end

	if not var_0_0.IsDLCScene(arg_34_1) then
		return true
	end

	return var_0_0.GetSkinSceneCfg(arg_34_0, arg_34_1) ~= nil
end

function var_0_0.GetMatchScene(arg_35_0, arg_35_1)
	if HomeSceneSettingData:CanUseScene(arg_35_1) == false and var_0_0.IsContentRandomSceneID(arg_35_1) then
		var_0_0.UpdateCacheRandomSceneID(arg_35_1)
	end

	if var_0_0.IsRandomScene() then
		-- block empty
	else
		HomeSceneSettingData:SetCacheSceneID(arg_35_1)
	end

	local var_35_0 = var_0_0.PickSkinMatchedScene(arg_35_0)

	if var_35_0 then
		local var_35_1 = var_0_0.AutoChangeSceneByTime(var_35_0)

		if HomeSceneSettingData:CanUseScene(var_35_1) then
			if not var_0_0.IsRandomScene() then
				HomeSceneSettingData:SetCacheSceneID(var_35_1)
			end

			return var_35_1
		end
	end

	if not var_0_0.IsMatchHeroScene(arg_35_0, arg_35_1) then
		local var_35_2 = HomeSceneSettingData:GetSceneID(arg_35_0)

		if not var_0_0.IsRandomScene() then
			HomeSceneSettingData:SetCacheSceneID(var_35_2)
		elseif var_0_0.IsDLCScene(var_35_2) then
			HomeSceneSettingData:CalcNextScene()

			var_35_2 = HomeSceneSettingData:GetSceneID(arg_35_0)
		end

		return var_35_2
	end

	return arg_35_1
end

function var_0_0.GetMatchSkinByScene(arg_36_0)
	local var_36_0 = nullable(SkinSceneActionCfg.get_id_list_by_special_scene_id, arg_36_0, 1)

	return nullable(SkinSceneActionCfg, var_36_0, "skin_id")
end

function var_0_0.AutoChangeSceneByTime(arg_37_0, arg_37_1)
	arg_37_1 = arg_37_1 or manager.time:GetServerTime()

	local var_37_0 = var_0_0.GetTimeChangeNextScene(arg_37_0, arg_37_1)

	if HomeSceneSettingData:CanUseScene(var_37_0) then
		return var_37_0
	end

	return arg_37_0
end

local var_0_4 = {
	{
		from_scene = 6017,
		change_to_scene = 6018,
		time = {
			18,
			6
		}
	},
	{
		from_scene = 6018,
		change_to_scene = 6017,
		time = {
			6,
			18
		}
	}
}

local function var_0_5(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_2 < arg_38_1 then
		var_0_5(arg_38_0, arg_38_1, 24)
		var_0_5(arg_38_0, 0, arg_38_2)
	elseif arg_38_1 < arg_38_2 then
		table.insert(arg_38_0, {
			arg_38_1,
			arg_38_2
		})
	end
end

local function var_0_6(arg_39_0, arg_39_1)
	local var_39_0 = manager.time:STimeDescS(arg_39_0, "!%H")
	local var_39_1 = tonumber(var_39_0)
	local var_39_2 = {}
	local var_39_3 = nullable(arg_39_1, 1) or 0
	local var_39_4 = nullable(arg_39_1, 2) or 24

	var_0_5(var_39_2, var_39_3, var_39_4)

	for iter_39_0, iter_39_1 in ipairs(var_39_2) do
		if var_39_1 >= iter_39_1[1] and var_39_1 < iter_39_1[2] then
			return true
		end
	end

	return false
end

function var_0_0.GetTimeChangeNextScene(arg_40_0, arg_40_1)
	for iter_40_0, iter_40_1 in ipairs(var_0_4) do
		if iter_40_1.from_scene == arg_40_0 then
			local var_40_0

			if arg_40_1 then
				var_40_0 = var_0_6(arg_40_1, iter_40_1.time)
			else
				var_40_0 = true
			end

			if var_40_0 then
				return iter_40_1.change_to_scene
			end
		end
	end

	return arg_40_0
end

function var_0_0.IsTimeChangeScene(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(var_0_4) do
		if iter_41_1.from_scene == arg_41_0 then
			return true
		end
	end

	return false
end

function var_0_0.GetLastPreviewHero()
	local var_42_0 = PlayerData:GetSelectSkinList()
	local var_42_1 = var_0_0.GetRandomHeroList()

	for iter_42_0 = #var_42_0, 1, -1 do
		local var_42_2 = var_42_0[iter_42_0]

		if table.keyof(var_42_1, var_42_2) then
			return var_42_2
		end
	end

	return var_42_1[1] or 1084
end

function var_0_0.GetLastPreviewScene()
	local var_43_0 = HomeSceneSettingData:GetSelectSceneList()
	local var_43_1 = HomeSceneSettingData:GetRandomSceneList()

	for iter_43_0 = #var_43_0, 1, -1 do
		local var_43_2 = var_43_0[iter_43_0]

		if table.keyof(var_43_1, var_43_2) then
			return var_43_2
		end
	end

	return var_43_1[1] or GameSetting.home_sence_default.value[2]
end

return var_0_0
