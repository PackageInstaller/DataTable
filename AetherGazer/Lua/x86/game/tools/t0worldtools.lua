local var_0_0 = {}
local var_0_1 = {
	Skd = 108502,
	Horus = 104402
}

function var_0_0.GetUseCharacterID()
	return T0WorldMgr:GetHeroID()
end

function var_0_0.GetMainUiView()
	return string.format("Widget/System/Main_T0SceneGame/%s/%s_CaptureUI", var_0_0:GetUseCharacterID(), var_0_0:GetUseCharacterID())
end

function var_0_0.GetFilterImg(arg_3_0, arg_3_1)
	return string.format("TextureConfig/Main_T0SceneGame/%s/%s", var_0_0:GetUseCharacterID(), arg_3_1)
end

function var_0_0.GetCaptureModelPath()
	return string.format("T0CaptureContent/%s_Capture_Charater", var_0_0:GetUseCharacterID())
end

function var_0_0.GetCaptureSceneList()
	if var_0_0.GetUseCharacterID() == var_0_1.Horus then
		return GameSetting.t0_world_capture_scene_horus.value
	else
		return GameSetting.t0_world_capture_scene.value
	end
end

function var_0_0.GetT0WorldHelpDataKey()
	return string.format("T0World_%s", var_0_0.GetUseCharacterID())
end

function var_0_0.GetT0WorldHelpPages()
	local var_7_0 = {}

	if var_0_0.GetUseCharacterID() == var_0_1.Horus then
		var_7_0 = GameSetting.t0_world_horus_desc1
	else
		var_7_0 = GameSetting.t0_world_skuld_desc
	end

	return var_7_0 and var_7_0.value or {}
end

var_0_0.heroShowName = {
	[614801] = "T0_WORLD_HORUS_TIPS_4",
	[105401] = "T0_WORLD_HORUS_TIPS_5"
}

function var_0_0.GetCharacterShowName(arg_8_0)
	if var_0_0.heroShowName[arg_8_0] then
		return GetTips(var_0_0.heroShowName[arg_8_0])
	end

	local var_8_0 = SkinCfg[arg_8_0].hero

	return (HeroTools.GetHeroSuffixName(var_8_0))
end

function var_0_0.GetSkinDLC(arg_9_0)
	local var_9_0 = SkinSceneActionCfg.get_id_list_by_skin_id_special_scene_id[arg_9_0]

	if var_9_0 then
		for iter_9_0, iter_9_1 in pairs(var_9_0) do
			return iter_9_0
		end
	end

	return nil
end

return var_0_0
