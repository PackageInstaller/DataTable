GraphicSettingConst = {}

local var_0_0 = GraphicSettingConst

GraphicSettingConst.PlayerGraphicLevelDorm = "dorm3d_graphics_settings_new"
GraphicSettingConst.PlayerGraphicLevelIsland = "island3d_graphics_settings_new"
GraphicSettingConst.SettingType = {
	select = 2,
	toggle = 1
}
GraphicSettingConst.SettingLevel = {
	High = 3,
	Mid = 2,
	Low = 1,
	Custom = 4
}
GraphicSettingConst.assetPath = {
	"Default_LowQualitySettings",
	"Default_MediumQualitySettings",
	"Default_HighQualitySettings",
	"Default_QualitySettings"
}
GraphicSettingConst.settings = {
	{
		tips = "grapihcs3d_setting_gpgpu_warning",
		parameterId = 0,
		settingType = 1,
		playerPrefsname = "enableGPUDriver",
		settingName = "grapihcs3d_setting_enable_gup_driver",
		isShow = 1,
		defaultValues = {
			0,
			0,
			1,
			0
		}
	},
	{
		playerPrefsname = "gameOptions",
		settingType = 2,
		parameterId = 3,
		settingName = "grapihcs3d_setting_global_illumination",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_global_illumination_optionname0",
			"grapihcs3d_setting_global_illumination_optionname1",
			"grapihcs3d_setting_global_illumination_optionname2",
			"grapihcs3d_setting_global_illumination_optionname3"
		},
		options = {
			0,
			1,
			2,
			3
		},
		defaultValues = {
			2,
			2,
			2,
			2
		}
	},
	{
		playerPrefsname = "bloomIntensity",
		settingType = 2,
		parameterId = 12,
		settingName = "grapihcs3d_setting_bloom_intensity",
		isShow = 0,
		optionNames = {
			"grapihcs3d_setting_bloom_intensity_0",
			"grapihcs3d_setting_bloom_intensity_1",
			"grapihcs3d_setting_bloom_intensity_2",
			"grapihcs3d_setting_bloom_intensity_3"
		},
		options = {
			0,
			1,
			2,
			3
		},
		defaultValues = {
			3,
			3,
			3,
			3
		}
	},
	{
		playerPrefsname = "resolution",
		settingType = 2,
		parameterId = 2,
		settingName = "grapihcs3d_setting_resolution",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_resolution_optionname0",
			"grapihcs3d_setting_resolution_optionname1",
			"grapihcs3d_setting_resolution_optionname2"
		},
		options = {
			1280,
			1920,
			2560
		},
		defaultValues = {
			1280,
			1920,
			2560,
			1920
		}
	},
	{
		playerPrefsname = "renderingQuality",
		settingType = 2,
		parameterId = 1,
		settingName = "grapihcs3d_setting_rendering_quality",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_rendering_quality_optionname0",
			"grapihcs3d_setting_rendering_quality_optionname1"
		},
		options = {
			0,
			1
		},
		defaultValues = {
			0,
			0,
			0,
			0
		}
	},
	{
		playerPrefsname = "shaderQuality",
		settingType = 2,
		parameterId = 4,
		settingName = "grapihcs3d_setting_shader_quality",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_shader_quality_optionname0",
			"grapihcs3d_setting_shader_quality_optionname1"
		},
		options = {
			0,
			1
		},
		defaultValues = {
			0,
			1,
			1,
			1
		}
	},
	{
		playerPrefsname = "enableAdditionalLights",
		settingType = 1,
		parameterId = 5,
		settingName = "grapihcs3d_setting_enable_additional_lights",
		isShow = 1,
		defaultValues = {
			0,
			1,
			1,
			1
		}
	},
	{
		playerPrefsname = "shadowQuality",
		settingType = 2,
		parameterId = 6,
		settingName = "grapihcs3d_setting_shadow_quality",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_shadow_quality_optionname0",
			"grapihcs3d_setting_shadow_quality_optionname1",
			"grapihcs3d_setting_shadow_quality_optionname2",
			"grapihcs3d_setting_shadow_quality_optionname3"
		},
		options = {
			0,
			1,
			2,
			3
		},
		defaultValues = {
			0,
			2,
			3,
			2
		}
	},
	{
		playerPrefsname = "shadowUpdateMode",
		settingType = 2,
		parameterId = 7,
		settingName = "grapihcs3d_setting_shadow_update_mode",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_shadow_update_mode_optionname0",
			"grapihcs3d_setting_shadow_update_mode_optionname1",
			"grapihcs3d_setting_shadow_update_mode_optionname2",
			"grapihcs3d_setting_shadow_update_mode_optionname3"
		},
		options = {
			0,
			1,
			2,
			3
		},
		defaultValues = {
			0,
			2,
			2,
			2
		}
	},
	{
		playerPrefsname = "lodQuality",
		settingType = 2,
		parameterId = 21,
		settingName = "Lod",
		isShow = 0,
		optionNames = {
			"关",
			"低",
			"中",
			"高"
		},
		options = {
			0,
			1,
			2,
			3
		},
		defaultValues = {
			3,
			3,
			3,
			3
		}
	},
	{
		playerPrefsname = "enableAO",
		settingType = 1,
		parameterId = 18,
		settingName = "AO",
		isShow = 0,
		defaultValues = {
			1,
			1,
			1,
			1
		}
	},
	{
		playerPrefsname = "enablePostProcess",
		settingType = 1,
		parameterId = 9,
		settingName = "grapihcs3d_setting_enable_post_process",
		isShow = 1,
		defaultValues = {
			1,
			1,
			1,
			1
		}
	},
	{
		playerPrefsname = "enableReflection",
		settingType = 1,
		parameterId = 8,
		settingName = "grapihcs3d_setting_enable_reflection",
		isShow = 1,
		defaultValues = {
			0,
			1,
			1,
			1
		}
	},
	{
		parentId = 12,
		playerPrefsname = "enablePostAntialiasing",
		settingType = 1,
		parameterId = 10,
		settingName = "grapihcs3d_setting_enable_post_antialiasing",
		isShow = 1,
		defaultValues = {
			0,
			0,
			0,
			1
		}
	},
	{
		parentId = 12,
		playerPrefsname = "enableHDR",
		settingType = 1,
		parameterId = 11,
		settingName = "grapihcs3d_setting_enable_hdr",
		isShow = 1,
		defaultValues = {
			1,
			1,
			1,
			1
		}
	},
	{
		parentId = 12,
		playerPrefsname = "enableDOF",
		settingType = 1,
		parameterId = 13,
		settingName = "grapihcs3d_setting_enable_dof",
		isShow = 1,
		defaultValues = {
			0,
			0,
			1,
			1
		}
	},
	{
		parentId = 12,
		playerPrefsname = "enableDistort",
		settingType = 1,
		parameterId = 14,
		settingName = "grapihcs3d_setting_enable_distort",
		isShow = 1,
		defaultValues = {
			0,
			0,
			1,
			1
		}
	},
	{
		playerPrefsname = "enableFog",
		settingType = 1,
		parameterId = 15,
		settingName = "雾",
		isShow = 0,
		defaultValues = {
			1,
			1,
			1,
			1
		}
	},
	{
		playerPrefsname = "enableFlare",
		settingType = 1,
		parameterId = 16,
		settingName = "grapihcs3d_setting_flare",
		isShow = 1,
		defaultValues = {
			1,
			1,
			1,
			1
		}
	},
	{
		playerPrefsname = "enableLensFlare",
		settingType = 1,
		parameterId = 17,
		settingName = "镜头炫光",
		isShow = 0,
		defaultValues = {
			1,
			1,
			1,
			1
		}
	},
	{
		playerPrefsname = "characterQuality",
		settingType = 2,
		parameterId = 19,
		settingName = "grapihcs3d_setting_character_quality",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_character_quality_optionname0",
			"grapihcs3d_setting_character_quality_optionname1",
			"grapihcs3d_setting_character_quality_optionname2"
		},
		options = {
			0,
			1,
			2
		},
		defaultValues = {
			0,
			1,
			2,
			1
		}
	},
	{
		playerPrefsname = "terrainLayerQuality",
		settingType = 2,
		parameterId = 20,
		settingName = "grapihcs3d_setting_terrain_layer_quality",
		isShow = 1,
		optionNames = {
			"grapihcs3d_setting_terrain_layer_quality_optionname0",
			"grapihcs3d_setting_terrain_layer_quality_optionname1",
			"grapihcs3d_setting_terrain_layer_quality_optionname2"
		},
		options = {
			0,
			1,
			2
		},
		defaultValues = {
			0,
			1,
			2,
			1
		}
	}
}

function GraphicSettingConst.InitDefautQuality(arg_1_0)
	if arg_1_0 then
		local var_1_0 = var_0_0.PlayerGraphicLevelIsland or var_0_0.PlayerGraphicLevelDorm

		if PlayerPrefs.GetInt(var_1_0, 0) == 0 then
			local var_1_1 = DevicePerformanceUtil.GetDevicePerformanceLevel()

			if PLATFORM == PLATFORM_IPHONEPLAYER then
				local var_1_2 = SystemInfo.deviceModel or ""

				if (function(arg_2_0)
					local var_2_0 = tonumber((string.match(arg_2_0, "iPad(%d+)")))

					if var_2_0 and var_2_0 >= 8 then
						return true
					end

					return false
				end)(var_1_2) or (function(arg_3_0)
					local var_3_0 = tonumber((string.match(arg_3_0, "iPhone(%d+)")))

					if var_3_0 and var_3_0 >= 13 then
						return true
					end

					return false
				end)(var_1_2) then
					var_1_1 = DevicePerformanceLevel.High
				end
			end

			local var_1_3 = var_1_1 == DevicePerformanceLevel.High and 3 or var_1_1 == DevicePerformanceLevel.Mid and 2 or 1

			if arg_1_0 then
				PlayerPrefs.SetInt(var_1_0, 1)
			else
				PlayerPrefs.SetInt(var_1_0, var_1_3)
			end

			if not arg_1_0 then
				Dorm3dRoomTemplateScene.FirstDefaultSetting = var_1_3
			end
		end

		return
	end
end

function GraphicSettingConst.SettingQuality(arg_4_0)
	if arg_4_0 then
		local var_4_0 = var_0_0.PlayerGraphicLevelIsland or var_0_0.PlayerGraphicLevelDorm
		local var_4_1 = PlayerPrefs.GetInt(var_4_0, 4)

		if var_4_1 ~= 4 then
			for iter_4_0, iter_4_1 in ipairs(var_0_0.settings) do
				GraphicsInterface.Instance:SetQualitySettings(iter_4_1.parameterId, iter_4_1.defaultValues[var_4_1])
			end

			return
		end

		for iter_4_2, iter_4_3 in ipairs(var_0_0.settings) do
			local var_4_2 = iter_4_3.parameterId

			if arg_4_0 then
				local var_4_3 = iter_4_3.playerPrefsname .. "island" or iter_4_3.playerPrefsname
				local var_4_4 = PlayerPrefs.GetInt(var_4_3, -1)
				local var_4_5 = iter_4_3.defaultValues[4]

				if var_4_4 ~= -1 then
					var_4_5 = var_4_4
				end

				GraphicsInterface.Instance:SetQualitySettings(var_4_2, var_4_5)
			end
		end

		return
	end
end

function GraphicSettingConst.ClearPlayerPrefs()
	if PlayerPrefs.GetInt("dorm3d_graphics_settings_changeed", 0) == 1 then
		return
	end

	PlayerPrefs.SetInt("dorm3d_graphics_settings_changeed", 1)

	for iter_5_0, iter_5_1 in ipairs(var_0_0.settings) do
		PlayerPrefs.DeleteKey(iter_5_1.playerPrefsname)
	end

	return
end

return GraphicSettingConst
