local var_0_0 = class("GraphicSettingPCView", ReduxView)

function var_0_0.SetActive(arg_1_0, arg_1_1)
	if arg_1_0.gameObject_ then
		SetActive(arg_1_0.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		arg_1_0.scrollView_.verticalNormalizedPosition = 1
	end
end

function var_0_0.Ctor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.hander_ = arg_2_1
	arg_2_0.transform_ = arg_2_2.transform
	arg_2_0.gameObject_ = arg_2_2
	arg_2_0.info_ = arg_2_3

	arg_2_0:Init()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.picQualityList_ = {
		6,
		2,
		3,
		4,
		5,
		7
	}
	arg_3_0.picQualityNum_ = #arg_3_0.picQualityList_
	arg_3_0.picToggle_ = {}
	arg_3_0.picToggleController_ = {}
	arg_3_0.resolutions_ = {}

	for iter_3_0 = 1, arg_3_0.picQualityNum_ do
		local var_3_0 = arg_3_0.picQualityList_[iter_3_0]

		arg_3_0.picToggle_[var_3_0] = arg_3_0["pic" .. var_3_0 .. "Btn_"]

		local var_3_1 = arg_3_0.picToggle_[var_3_0]:GetComponent(typeof(RectTransform))

		arg_3_0.picToggleController_[var_3_0] = ControllerUtil.GetController(var_3_1, "name")
	end

	arg_3_0:InitDropDown()
end

function var_0_0.InitDropDown(arg_4_0)
	arg_4_0.resolutionDropdown_.options:Clear()

	local var_4_0 = Screen.resolutions
	local var_4_1 = arg_4_0:ReverseTable(var_4_0:ToTable())

	for iter_4_0 = 1, #var_4_1 do
		local var_4_2 = "" .. var_4_1[iter_4_0].width .. "*" .. var_4_1[iter_4_0].height

		if iter_4_0 == 1 then
			table.insert(arg_4_0.resolutions_, {
				width = var_4_1[iter_4_0].width,
				height = var_4_1[iter_4_0].height
			})
			arg_4_0.resolutionDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_4_2, nil))
		else
			local var_4_3 = arg_4_0.resolutions_[#arg_4_0.resolutions_]

			if var_4_3 and (var_4_3.width and var_4_3.width ~= var_4_1[iter_4_0].width or var_4_3.height and var_4_3.height ~= var_4_1[iter_4_0].height) then
				table.insert(arg_4_0.resolutions_, {
					width = var_4_1[iter_4_0].width,
					height = var_4_1[iter_4_0].height
				})
				arg_4_0.resolutionDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_4_2, nil))
			end
		end
	end

	arg_4_0.resolutionDropdown_:RefreshShownValue()

	arg_4_0.render_scale_ = {
		1,
		1.2,
		1.5,
		1.8,
		2
	}
end

function var_0_0.ReverseTable(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_1 then
		for iter_5_0 = 1, #arg_5_1 do
			var_5_0[iter_5_0] = arg_5_1[#arg_5_1 + 1 - iter_5_0]
		end
	end

	return var_5_0
end

local var_0_1 = import("game.const.SettingConst").FPS_TARGET
local var_0_2 = {
	var_0_1.FPS_30,
	var_0_1.FPS_60,
	var_0_1.FPS_90_PC_ONLY,
	var_0_1.FPS_120
}

function var_0_0.AddUIListener(arg_6_0)
	for iter_6_0 = 1, arg_6_0.picQualityNum_ do
		local var_6_0 = arg_6_0.picQualityList_[iter_6_0]

		arg_6_0:AddBtnListener(arg_6_0.picToggle_[var_6_0], nil, function()
			SettingAction.ChangePicSetting("picOptionId", var_6_0)
		end)
	end

	for iter_6_1 = 1, 4 do
		arg_6_0:AddBtnListener(arg_6_0["teammate" .. iter_6_1 .. "Tgl_"], nil, function()
			if arg_6_0.settingData_.teammate_effect ~= iter_6_1 then
				SettingAction.ChangePicSetting("teammate_effect", iter_6_1)
			end
		end)
	end

	for iter_6_2 = 1, 4 do
		arg_6_0:AddBtnListener(arg_6_0["user" .. iter_6_2 .. "Tgl_"], nil, function()
			if arg_6_0.settingData_.user_effect ~= iter_6_2 then
				SettingAction.ChangePicSetting("user_effect", iter_6_2)
			end
		end)
	end

	for iter_6_3 = 1, 4 do
		arg_6_0:AddBtnListener(arg_6_0["fps" .. iter_6_3 .. "Tgl_"], nil, function()
			if arg_6_0.settingData_.frame ~= var_0_2[iter_6_3] then
				SettingAction.ChangePicSetting("frame", var_0_2[iter_6_3])
			end
		end)
	end

	for iter_6_4 = 1, 3 do
		arg_6_0:AddBtnListener(arg_6_0["shadow" .. iter_6_4 .. "Tgl_"], nil, function()
			if arg_6_0.settingData_.shadow ~= iter_6_4 then
				SettingAction.ChangePicSetting("shadow", iter_6_4)
			end
		end)
	end

	for iter_6_5 = 1, 3 do
		arg_6_0:AddBtnListener(arg_6_0["postProcess" .. iter_6_5 .. "Tgl_"], nil, function()
			if arg_6_0.settingData_.post_process ~= iter_6_5 then
				SettingAction.ChangePicSetting("post_process", iter_6_5)
			end
		end)
	end

	arg_6_0:AddBtnListener(arg_6_0.antialiasTgl_, nil, function()
		local var_13_0 = arg_6_0.settingData_.anti_aliasing == 1 and 0 or 1

		if arg_6_0.settingData_.anti_aliasing ~= var_13_0 then
			SettingAction.ChangePicSetting("anti_aliasing", var_13_0)
		end
	end)
	arg_6_0:AddBtnListener(arg_6_0.vertical_synchronizationTgl_, nil, function()
		local var_14_0 = arg_6_0.settingData_.vertical_sync == 1 and 0 or 1

		if arg_6_0.settingData_.vertical_sync ~= var_14_0 then
			SettingAction.ChangePicSetting("vertical_sync", var_14_0)
		end
	end)

	for iter_6_6 = 1, 3 do
		arg_6_0:AddBtnListener(arg_6_0["window" .. iter_6_6 .. "Tgl_"], nil, function()
			if arg_6_0.settingData_.window ~= iter_6_6 then
				SettingAction.ChangePicSetting("window", iter_6_6)
			end
		end)
	end

	arg_6_0:AddToggleListener(arg_6_0.resolutionDropdown_, function(arg_16_0)
		local var_16_0 = arg_6_0.resolutions_[arg_16_0 + 1].width
		local var_16_1 = arg_6_0.resolutions_[arg_16_0 + 1].height

		SettingAction.ChangePicSetting("pc_resolution", {
			var_16_0,
			var_16_1
		})
	end)
	arg_6_0:AddToggleListener(arg_6_0.renderScaleDropdown_, function(arg_17_0)
		local var_17_0 = arg_6_0.render_scale_[arg_17_0 + 1]

		SettingAction.ChangePicSetting("render_scale", var_17_0)
	end)
	arg_6_0:AddBtnListener(arg_6_0.depthOfFiledTgl_, nil, function()
		local var_18_0 = arg_6_0.settingData_.depth_of_field_enable == 1 and 0 or 1

		if arg_6_0.settingData_.depth_of_field_enable ~= var_18_0 then
			SettingAction.ChangePicSetting("depth_of_field_enable", var_18_0)
		end
	end)
end

function var_0_0.RefreshPicOption(arg_19_0)
	local var_19_0 = arg_19_0.settingData_.picOptionId

	for iter_19_0, iter_19_1 in pairs(arg_19_0.picToggleController_) do
		if iter_19_0 == var_19_0 then
			iter_19_1:SetSelectedIndex(0)
		else
			iter_19_1:SetSelectedIndex(1)
		end
	end
end

function var_0_0.RefreshUserEffect(arg_20_0)
	local var_20_0 = arg_20_0.settingData_.user_effect

	for iter_20_0 = 1, 4 do
		SetActive(arg_20_0[string.format("user%dCheck_", iter_20_0)], var_20_0 == iter_20_0)
	end
end

function var_0_0.RefreshTeamMateEffect(arg_21_0)
	local var_21_0 = arg_21_0.settingData_.teammate_effect

	for iter_21_0 = 1, 4 do
		SetActive(arg_21_0[string.format("teammate%dCheck_", iter_21_0)], var_21_0 == iter_21_0)
	end
end

function var_0_0.RefreshFPS(arg_22_0)
	local var_22_0 = arg_22_0.settingData_.frame

	for iter_22_0 = 1, 4 do
		SetActive(arg_22_0[string.format("fps%dCheck_", iter_22_0)], var_22_0 == var_0_2[iter_22_0])
	end
end

function var_0_0.RefreshShadow(arg_23_0)
	local var_23_0 = arg_23_0.settingData_.shadow

	for iter_23_0 = 1, 3 do
		SetActive(arg_23_0[string.format("shadow%dCheck_", iter_23_0)], var_23_0 == iter_23_0)
	end
end

function var_0_0.RefreshPostProcess(arg_24_0)
	local var_24_0 = arg_24_0.settingData_.post_process

	for iter_24_0 = 1, 3 do
		SetActive(arg_24_0[string.format("postProcess%dCheck_", iter_24_0)], var_24_0 == iter_24_0)
	end
end

function var_0_0.RefreshAntiAlias(arg_25_0)
	local var_25_0 = arg_25_0.settingData_.anti_aliasing

	arg_25_0.antialiasTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(var_25_0)
end

function var_0_0.RefreshVerticalSync(arg_26_0)
	local var_26_0 = arg_26_0.settingData_.vertical_sync

	arg_26_0.vertical_synchronizationTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(var_26_0)
end

function var_0_0.RefreshWindow(arg_27_0)
	local var_27_0 = arg_27_0.settingData_.window

	for iter_27_0 = 1, 3 do
		SetActive(arg_27_0[string.format("window%dCheck_", iter_27_0)], var_27_0 == iter_27_0)
	end
end

function var_0_0.RefreshResolution(arg_28_0)
	local var_28_0 = arg_28_0.settingData_.pc_resolution
	local var_28_1 = false

	for iter_28_0, iter_28_1 in pairs(arg_28_0.resolutions_) do
		if var_28_0[1] == iter_28_1.width and var_28_0[2] == iter_28_1.height then
			var_28_1 = true
			arg_28_0.resolutionDropdown_.value = iter_28_0 - 1

			break
		end
	end

	if not var_28_1 then
		Debug.LogError("未找到分辨率挡位")

		arg_28_0.resolutionDropdown_.value = 0
	end

	if var_28_0[1] > 3839 then
		SetActive(arg_28_0.renderScaleIcon_, false)

		arg_28_0.renderScaleDropdown_.interactable = false

		SettingAction.ChangePicSetting("render_scale", 1)
		arg_28_0:RefreshRenderScale()
	else
		SetActive(arg_28_0.renderScaleIcon_, true)

		arg_28_0.renderScaleDropdown_.interactable = true
	end
end

function var_0_0.RefreshRenderScale(arg_29_0)
	local var_29_0 = arg_29_0.settingData_.render_scale
	local var_29_1 = false

	for iter_29_0, iter_29_1 in pairs(arg_29_0.render_scale_) do
		if iter_29_1 == var_29_0 then
			var_29_1 = true

			arg_29_0.renderScaleDropdown_:SetValueWithoutNotify(iter_29_0 - 1)

			break
		end
	end

	if not var_29_1 then
		Debug.LogError("未找到分辨率挡位")
		arg_29_0.renderScaleDropdown_:SetValueWithoutNotify(0)
	end
end

function var_0_0.RefreshDepthOfFiled(arg_30_0)
	SetActive(arg_30_0.depthOfFiledGo_, false)
end

function var_0_0.CheckDataChange(arg_31_0, arg_31_1)
	local var_31_0 = ""

	if arg_31_0.tmpSettingData_ and not table.equal(arg_31_0.tmpSettingData_, arg_31_0.settingData_, "all") then
		print("CheckDataChange, 新旧数据不同！！！")

		return true
	end

	return false
end

function var_0_0.SaveData(arg_32_0)
	if arg_32_0:CheckDataChange() then
		arg_32_0.json_ = require("cjson")

		local var_32_0 = deepClone(arg_32_0.settingData_)

		if var_32_0.picOptionId ~= 7 then
			var_32_0.pic = {
				quality = "quality_" .. var_32_0.picOptionId
			}
		end

		var_32_0.type = 1

		local var_32_1 = arg_32_0.json_.encode(var_32_0)
		local var_32_2 = {
			6,
			2,
			3,
			4,
			5,
			7
		}
		local var_32_3 = table.indexof(var_32_2, var_32_0.picOptionId)
		local var_32_4 = 0

		if var_32_3 > 0 then
			var_32_4 = var_32_3 - 1
		end

		SDKTools.SendMessageToSDK("graphics_setting", {
			graphics = var_32_4,
			fps_setting = arg_32_0.settingData_.frame == 0 and 30 or arg_32_0.settingData_.frame == 1 and 60 or 120,
			teammate_effect_setting = arg_32_0.settingData_.teammate_effect,
			anti_aliasing_setting = arg_32_0.settingData_.anti_aliasing == 0 and "false" or "true",
			reflect_setting = arg_32_0.settingData_.reflection_effect == 0 and "false" or "true",
			HDR_setting = arg_32_0.settingData_.hdr == 0 and "false" or "true",
			user_effect_setting = arg_32_0.settingData_.user_effect,
			other_object = {
				window_setting = arg_32_0.settingData_.window,
				pc_dpi_setting = arg_32_0.settingData_.pc_resolution,
				shadow_setting = arg_32_0.settingData_.shadow,
				post_process_setting = arg_32_0.settingData_.post_process,
				vertical_sync_setting = arg_32_0.settingData_.vertical_sync == 0 and "false" or "true",
				render_scale_setting = arg_32_0.settingData_.render_scale
			}
		})

		local var_32_5 = arg_32_0.json_.encode(var_32_0)
	end

	arg_32_0.tmpSettingData_ = deepClone(arg_32_0.settingData_)
end

function var_0_0.RecoverTmpData(arg_33_0)
	if arg_33_0:CheckDataChange() then
		SettingAction.ChangePicSetting("allData", arg_33_0.tmpSettingData_)
	end
end

function var_0_0.OnPicSettingChange(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0:RefreshPicOption()

	if arg_34_2.key == "picOptionId" or arg_34_2.key == "allData" then
		arg_34_0:RefreshUserEffect()
		arg_34_0:RefreshTeamMateEffect()
		arg_34_0:RefreshFPS()
		arg_34_0:RefreshShadow()
		arg_34_0:RefreshAntiAlias()
		arg_34_0:RefreshVerticalSync()
		arg_34_0:RefreshRenderScale()
		arg_34_0:RefreshPostProcess()
	elseif arg_34_2.key == "user_effect" then
		arg_34_0:RefreshUserEffect()
	elseif arg_34_2.key == "teammate_effect" then
		arg_34_0:RefreshTeamMateEffect()
	elseif arg_34_2.key == "frame" then
		arg_34_0:RefreshFPS()
	elseif arg_34_2.key == "shadow" then
		arg_34_0:RefreshShadow()
	elseif arg_34_2.key == "post_process" then
		arg_34_0:RefreshPostProcess()
	elseif arg_34_2.key == "anti_aliasing" then
		arg_34_0:RefreshAntiAlias()
	elseif arg_34_2.key == "vertical_sync" then
		arg_34_0:RefreshVerticalSync()
	elseif arg_34_2.key == "window" then
		arg_34_0:RefreshWindow()
	elseif arg_34_2.key == "pc_resolution" then
		arg_34_0:RefreshResolution()
	elseif arg_34_2.key == "render_scale" then
		arg_34_0:RefreshRenderScale()
	elseif arg_34_2.key == "depth_of_field_enable" then
		arg_34_0:RefreshDepthOfFiled()
	end
end

function var_0_0.Init(arg_35_0)
	arg_35_0:InitUI()
	arg_35_0:AddUIListener()
	arg_35_0:OnEnter()
end

function var_0_0.OnEnter(arg_36_0)
	arg_36_0.settingData_ = SettingData:GetPicSettingData()

	arg_36_0:RefreshUI()

	arg_36_0.tmpSettingData_ = deepClone(arg_36_0.settingData_)
end

function var_0_0.RefreshUI(arg_37_0)
	arg_37_0:RefreshPicOption()
	arg_37_0:RefreshUserEffect()
	arg_37_0:RefreshTeamMateEffect()
	arg_37_0:RefreshFPS()
	arg_37_0:RefreshShadow()
	arg_37_0:RefreshPostProcess()
	arg_37_0:RefreshAntiAlias()
	arg_37_0:RefreshVerticalSync()
	arg_37_0:RefreshWindow()
	arg_37_0:RefreshResolution()
	arg_37_0:RefreshRenderScale()
	arg_37_0:RefreshDepthOfFiled()
end

function var_0_0.OnExit(arg_38_0)
	return
end

function var_0_0.Dispose(arg_39_0)
	arg_39_0.hander_ = nil

	var_0_0.super.Dispose(arg_39_0)
end

return var_0_0
