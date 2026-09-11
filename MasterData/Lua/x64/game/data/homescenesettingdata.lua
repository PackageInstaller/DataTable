local HomeSceneViewCfg = require("game.config.HomeSceneViewCfg")
local var_0_1 = singletonClass("HomeSceneSettingData")
local var_0_2 = {}
local var_0_3 = {}
local var_0_5 = 0
local var_0_6 = 0
local var_0_7 = {}
local var_0_8 = 0
local var_0_9 = {}
local var_0_10 = 0
local var_0_11 = false
local var_0_12 = false
local var_0_13 = false

function var_0_1.Init(arg_1_0)
	var_0_2 = {}
	var_0_3 = {}
	var_0_5 = 0
	var_0_6 = GameSetting.home_sence_default.value[1]
	var_0_7 = {}
	arg_1_0.cacheSceneList_ = {}
	arg_1_0.clearSceneFlag_ = false
	arg_1_0.cacheSceneID_ = nil
	arg_1_0.unlockedSpecialView = nil
	arg_1_0.selectedSpecialView = {}
end

function var_0_1.InitData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	var_0_6 = arg_2_2

	for iter_2_0, iter_2_1 in ipairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.SCENE_NORMAL]) do
		var_0_3[iter_2_1] = {
			timestamp = 0,
			unlock = 0,
			id = iter_2_1
		}
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1) do
		if var_0_3[iter_2_3.id] then
			var_0_3[iter_2_3.id].unlock = 1
			var_0_3[iter_2_3.id].timestamp = iter_2_3.lasted_time
		end
	end

	var_0_8 = arg_2_3.random_model
	var_0_9 = {}

	table.insertto(var_0_9, arg_2_3.random_list)

	arg_2_0.selectSceneList_ = {}
end

function var_0_1.InitOverdueSceneList(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		table.insert(var_0_2, {
			id = iter_3_1.id,
			timeValid = iter_3_1.time_valid
		})
	end
end

function var_0_1.DealOverdueScene(arg_4_0)
	if var_0_2 and #var_0_2 > 0 then
		ShowTips("HOME_SCENE_TIME_INVALID")
		HomeSceneSettingAction.DealOverdueScene()

		var_0_2 = {}
	end
end

function var_0_1.SetCurScene(arg_5_0, arg_5_1)
	var_0_6 = arg_5_1
	arg_5_0.cacheSceneID_ = arg_5_1
end

function var_0_1.SetDefaultScene(arg_6_0, arg_6_1)
	saveData("scene", "default_scene", arg_6_1)
end

function var_0_1:GetDefaultScene()
	if self:IsRandomScene() then
		return self:GetRandomScene()
	end

	local var_7_0 = GameSetting.home_sence_default.value
	local var_7_1 = GameSetting.home_sence_default.value[#GameSetting.home_sence_default.value]
	local var_7_2 = HomeSceneSettingData:GetUsedState(var_7_1)

	if var_7_2 ~= SceneConst.HOME_SCENE_TYPE.TRIAL and var_7_2 ~= SceneConst.HOME_SCENE_TYPE.UNLOCK then
		var_7_1 = var_7_0[#var_7_0]
	end

	return var_7_1
end

function var_0_1:GetCurScene()
	return (self:GetSceneID((PlayerData:GetPosterGirlHeroSkinId())))
end

function var_0_1:GetSceneID(arg_9_1)
	local var_9_0 = self:GetCacheSceneID() or var_0_6
	local var_9_1 = CustomCenterTools.GetSkinSceneCfg(arg_9_1, var_9_0)

	if self:IsRandomScene() then
		var_9_0 = var_0_10

		local var_9_2 = clone(var_9_1)

		var_9_1 = CustomCenterTools.PickSkinSceneCfg(arg_9_1)

		if var_9_2 and HomeSceneSettingData:CanUseScene(var_9_2.special_scene_id) then
			return var_9_2.special_scene_id
		elseif var_9_1 and HomeSceneSettingData:CanUseScene(var_9_1.special_scene_id) then
			if var_9_0 == var_9_1.special_scene_id then
				return var_9_0
			else
				if HomeSceneSettingData:GetRandomMode() == HomeSceneSettingConst.RANDOM_MODE.EACH_ENTER then
					self:SetRandomScene(var_9_1.special_scene_id)
				end

				return var_9_1.special_scene_id
			end
		else
			return self:GetDefaultScene()
		end
	else
		if CustomCenterTools.IsRandomHero() then
			local var_9_3 = CustomCenterTools.PickFirstAvailableMatchedScene(arg_9_1)

			if var_9_3 then
				return var_9_3
			end
		end

		if HomeSceneSettingCfg[var_9_0].limit_display == 0 then
			if var_9_1 and HomeSceneSettingData:CanUseScene(var_9_1.special_scene_id) and (var_9_0 == var_9_1.special_scene_id or var_9_0 == var_9_1.special_scene_id_2) then
				return var_9_0
			elseif var_9_1 and HomeSceneSettingData:CanUseScene(var_9_1.special_scene_id) then
				return var_9_1.special_scene_id
			elseif HomeSceneSettingCfg[var_0_6].limit_display == 0 then
				return self:GetDefaultScene()
			else
				return var_0_6
			end
		elseif HomeSceneSettingData:CanUseScene(var_9_0) then
			return var_9_0
		else
			return self:GetDefaultScene()
		end
	end
end

function var_0_1:GetRealScene()
	if self:IsRandomScene() then
		return self:GetRandomScene()
	end

	if CustomCenterTools.IsRandomHero() and HomeSceneSettingCfg[var_0_6].limit_display ~= 1 then
		var_0_6 = GameSetting.home_sence_default.value[2]
	end

	return var_0_6
end

function var_0_1:IsHaveScene(arg_11_1)
	local var_11_0 = self:GetUsedState(arg_11_1)

	if arg_11_1 == ItemCfg[arg_11_1].param[1] then
		return var_11_0 == SceneConst.HOME_SCENE_TYPE.UNLOCK
	else
		return var_11_0 == SceneConst.HOME_SCENE_TYPE.TRIAL
	end
end

function var_0_1.IsUnlockScene(arg_12_0, arg_12_1)
	if var_0_3[arg_12_1] then
		return var_0_3[arg_12_1].unlock == 1 and var_0_3[arg_12_1].timestamp == 0
	end

	return false
end

function var_0_1:CanUseScene(arg_13_1)
	local var_13_0 = self:GetUsedState(arg_13_1)

	return var_13_0 == SceneConst.HOME_SCENE_TYPE.TRIAL or var_13_0 == SceneConst.HOME_SCENE_TYPE.UNLOCK
end

function var_0_1:GetUsedState(arg_14_1)
	local var_14_0 = nullable(ItemCfg[arg_14_1], "param", 1)

	if self:IsUnlockScene(var_14_0) then
		return SceneConst.HOME_SCENE_TYPE.UNLOCK
	end

	if var_0_3[var_14_0] and (HomeSceneSettingCfg[var_14_0].scene_trial == 1 or var_0_3[var_14_0].timestamp ~= 0) and var_0_3[var_14_0].unlock == 1 then
		if (not table.isEmpty(HomeSceneSettingCfg[var_14_0].obtain_way) and not JumpTools.NeedHide(HomeSceneSettingCfg[var_14_0].obtain_way, self.curSceneID_) or var_0_3[var_14_0].timestamp > 0) and manager.time:GetServerTime() <= var_0_3[var_14_0].timestamp then
			return SceneConst.HOME_SCENE_TYPE.TRIAL
		end
	end

	return SceneConst.HOME_SCENE_TYPE.LOCK
end

function var_0_1:UnlockScene(arg_15_1, arg_15_2)
	if var_0_3[ItemCfg[arg_15_1].param[1]] then
		if var_0_3[ItemCfg[arg_15_1].param[1]].unlock == 0 and var_0_3[ItemCfg[arg_15_1].param[1]].timestamp == 0 then
			self:RefreshRed(ItemCfg[arg_15_1].param[1])
		end

		var_0_3[ItemCfg[arg_15_1].param[1]].unlock = 1
		var_0_3[ItemCfg[arg_15_1].param[1]].timestamp = arg_15_2
	end
end

function var_0_1.GetTotalScene(arg_16_0)
	return var_0_3 or {}
end

function var_0_1.RefreshRed(arg_17_0, arg_17_1)
	saveData("scene", tostring(arg_17_1), 1)
	manager.redPoint:setTip(RedPointConst.SCENE .. "_" .. arg_17_1, 1)
end

function var_0_1.SetPreviewScene(arg_18_0, arg_18_1, arg_18_2)
	var_0_5 = arg_18_1

	local var_18_0 = {
		data = "",
		weather = "",
		time = manager.loadScene:GetTimeScene((manager.time:STimeDescS(manager.time:GetServerTime(), "!%H"))),
		skinID = arg_18_2
	}

	for iter_18_0 = 1, 3 do
		if not table.indexof(HomeSceneSettingCfg[arg_18_1].impact, iter_18_0) then
			if iter_18_0 == 1 then
				var_18_0.weather = nil
			elseif iter_18_0 == 2 then
				var_18_0.data = nil
			elseif iter_18_0 == 3 then
				var_18_0.time = nil
			end
		end
	end

	return var_18_0
end

function var_0_1.SetPreviewSceneParams(arg_19_0, arg_19_1)
	preParams = deepClone(arg_19_1)
end

function var_0_1.GetPreviewScene(arg_20_0)
	return var_0_5, deepClone(preParams)
end

function var_0_1.GetIsPlay(arg_21_0, arg_21_1)
	return var_0_7[arg_21_1] == 1
end

function var_0_1.SetIsPlay(arg_22_0, arg_22_1, arg_22_2)
	arg_22_2 = arg_22_2 and arg_22_2 or 1
	var_0_7[arg_22_1] = 1
end

function var_0_1.GetSceneTimeStamp(arg_23_0, arg_23_1)
	if var_0_3[arg_23_1] then
		return var_0_3[arg_23_1].timestamp
	else
		return nil
	end
end

function var_0_1:IsNeedSceenCheck()
	local var_24_0 = GameSetting.home_sence_default.value[#GameSetting.home_sence_default.value]

	if not getData("scenePop", "sceneID_" .. var_24_0) and table.indexof(GameSetting.home_sence_default.value, (self:GetCurScene())) then
		return true, var_24_0, GameSetting.home_sence_default.value[#GameSetting.home_sence_default.value - 1] or GameSetting.home_sence_default.value[1]
	end

	saveData("scenePop", "sceneID_" .. var_24_0, true)

	return false, nil, nil
end

function var_0_1:GetRandomSceneList()
	local var_25_0 = false

	for iter_25_0, iter_25_1 in ipairs(var_0_9) do
		if not self:CanUseScene(iter_25_1) then
			var_25_0 = true

			break
		end
	end

	if var_25_0 then
		local var_25_1 = {}

		for iter_25_2, iter_25_3 in ipairs(var_0_9) do
			if self:CanUseScene(iter_25_3) then
				table.insert(var_25_1, iter_25_3)
			end
		end

		var_0_9 = var_25_1
	end

	return var_0_9
end

function var_0_1.SetRandomSceneList(arg_26_0, arg_26_1)
	var_0_9 = clone(arg_26_1)
end

function var_0_1.UpdateRandomSceneList(arg_27_0, arg_27_1)
	local var_27_0 = table.keyof(var_0_9, arg_27_1)

	if var_27_0 then
		table.remove(var_0_9, var_27_0)
	else
		table.insert(var_0_9, arg_27_1)
	end
end

function var_0_1.GetRandomModeRaw(arg_28_0)
	return var_0_8
end

function var_0_1.GetRandomMode(arg_29_0)
	return PlayerTools.RandomModeDataGetMode(var_0_8)
end

function var_0_1:SetRandomMode(arg_30_1)
	var_0_8 = PlayerTools.MakeRandomModeData(self:IsRandomScene(), arg_30_1)
end

function var_0_1.IsRandomScene(arg_31_0)
	return PlayerTools.RandomModeDataIsEnable(var_0_8)
end

function var_0_1:SetIsRandomScene(arg_32_1)
	var_0_8 = PlayerTools.MakeRandomModeData(arg_32_1, self:GetRandomMode())
end

function var_0_1:GetRandomScene()
	if var_0_10 == 0 or not self:CanUseScene(var_0_10) then
		self:CalcNextScene()
	end

	if var_0_12 then
		return var_0_6
	end

	return var_0_10
end

function var_0_1.SetRandomScene(arg_34_0, arg_34_1)
	if table.indexof(HomeSceneSettingCfg.get_id_list_by_limit_display[1], arg_34_1) then
		var_0_10 = arg_34_1
	end
end

function var_0_1:IsExistValidScene()
	for iter_35_0, iter_35_1 in pairs((self:GetRandomSceneList())) do
		if self:CanUseScene(iter_35_1) then
			return true
		end
	end

	return false
end

function var_0_1.SetForceRandomSceneID(arg_36_0, arg_36_1)
	arg_36_0.forceRandomSceneID_ = arg_36_1
end

function var_0_1:GetForceRandomSceneID()
	return self.forceRandomSceneID_
end

function var_0_1:CalcNextScene()
	local var_38_0 = self:GetRandomSceneList()

	if not self:IsExistValidScene() then
		var_0_10 = GameSetting.home_sence_default.value[#GameSetting.home_sence_default.value]
		self.forceRandomSceneID_ = nil

		return var_0_10
	end

	if self.forceRandomSceneID_ then
		var_0_10 = self.forceRandomSceneID_
		self.forceRandomSceneID_ = nil

		return
	end

	local var_38_1 = #var_38_0
	local var_38_2 = math.random(#var_38_0)
	local var_38_3 = var_38_0[var_38_2]

	if var_38_0[var_38_2] == var_0_10 then
		if var_38_1 >= var_38_2 + 1 then
			var_38_3 = var_38_0[var_38_2 + 1]
		elseif var_38_2 - 1 >= 1 then
			var_38_3 = var_38_0[var_38_2 - 1]
		end
	end

	var_0_10 = var_38_3
end

function var_0_1.SetIsUseDlcScene(arg_39_0, arg_39_1)
	var_0_11 = not arg_39_1
end

function var_0_1.SetIsSwitchTime(arg_40_0, arg_40_1)
	var_0_12 = arg_40_1
end

function var_0_1.SetIsTimeScene(arg_41_0, arg_41_1)
	var_0_13 = arg_41_1
end

function var_0_1.IsTimeScene(arg_42_0)
	return var_0_13
end

function var_0_1.SetCacheRandomSceneList(arg_43_0, arg_43_1)
	arg_43_0.cacheSceneList_ = arg_43_1
end

function var_0_1:GetCacheRandomSceneList()
	return self.cacheSceneList_
end

function var_0_1:UpdateCacheRandomSceneList(arg_45_1)
	local var_45_0 = table.keyof(self.cacheSceneList_, arg_45_1)

	if var_45_0 then
		table.remove(self.cacheSceneList_, var_45_0)
	else
		table.insert(self.cacheSceneList_, arg_45_1)
	end
end

function var_0_1.SetClearSceneFlag(arg_46_0, arg_46_1)
	arg_46_0.clearSceneFlag_ = arg_46_1
end

function var_0_1:GetClearSceneFlag()
	return self.clearSceneFlag_
end

function var_0_1.SetCacheSceneID(arg_48_0, arg_48_1)
	arg_48_0.cacheSceneID_ = arg_48_1
end

function var_0_1:GetCacheSceneID()
	return self.cacheSceneID_
end

function var_0_1.GetCurSceneID(arg_50_0)
	return var_0_6
end

function var_0_1:AddSelectSceneID(arg_51_1)
	table.insert(self.selectSceneList_, arg_51_1)
end

function var_0_1:GetSelectSceneList()
	return self.selectSceneList_
end

function var_0_1.ClearSelectSceneList(arg_53_0)
	arg_53_0.selectSceneList_ = {}
end

function var_0_1:IsSpecialViewInfoInited()
	return self.unlockedSpecialView ~= nil
end

function var_0_1:OnSelectSpecialView(arg_55_1, arg_55_2)
	self.selectedSpecialView[arg_55_1] = arg_55_2
end

function var_0_1.InitSpecialViewInfo(arg_56_0, arg_56_1, arg_56_2)
	arg_56_0.selectedSpecialView = arg_56_2
	arg_56_0.unlockedSpecialView = arg_56_1 or {}

	manager.notify:Invoke(ON_POSTERGIRL_UNLOCK_SPEC_VIEW)
end

function var_0_1:HasSpecialViewCfg(arg_57_1)
	if HomeSceneViewCfg.get_id_list_by_scene_id_view[arg_57_1] ~= nil then
		return self.selectedSpecialView[arg_57_1] or PosterGirlConst.ViewDirect.center
	end

	return nil
end

function var_0_1:HasSpecialViewUnlocked(arg_58_1, arg_58_2)
	if arg_58_2 == PosterGirlConst.ViewDirect.center then
		return true
	end

	local var_58_0 = nullable(HomeSceneViewCfg, nullable(HomeSceneViewCfg.get_id_list_by_scene_id_view, arg_58_1, arg_58_2, 1), "unlock_condition")

	var_58_0 = var_58_0 or 0

	if var_58_0 == 0 then
		return true
	end

	return nullable(self.unlockedSpecialView, arg_58_1, arg_58_2)
end

return var_0_1
