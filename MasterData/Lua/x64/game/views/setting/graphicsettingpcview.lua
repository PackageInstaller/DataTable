local GraphicSettingPCView = class("GraphicSettingPCView", ReduxView)

function GraphicSettingPCView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		self.scrollView_.verticalNormalizedPosition = 1
	end
end

function GraphicSettingPCView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.info_ = arg_2_3

	self:Init()
end

function GraphicSettingPCView:InitUI()
	self:BindCfgUI()

	self.picQualityList_ = {
		6,
		2,
		3,
		4,
		5,
		7
	}
	self.picQualityNum_ = #self.picQualityList_
	self.picToggle_ = {}
	self.picToggleController_ = {}
	self.resolutions_ = {}

	for iter_3_0 = 1, self.picQualityNum_ do
		self.picToggle_[self.picQualityList_[iter_3_0]] = self["pic" .. self.picQualityList_[iter_3_0] .. "Btn_"]
		self.picToggleController_[self.picQualityList_[iter_3_0]] = ControllerUtil.GetController(self.picToggle_[self.picQualityList_[iter_3_0]]:GetComponent(typeof(RectTransform)), "name")
	end

	self:InitDropDown()
end

function GraphicSettingPCView:InitDropDown()
	self.resolutionDropdown_.options:Clear()

	local var_4_0 = self:ReverseTable(Screen.resolutions:ToTable())

	for iter_4_0 = 1, #var_4_0 do
		local var_4_1 = "" .. var_4_0[iter_4_0].width .. "*" .. var_4_0[iter_4_0].height

		if iter_4_0 == 1 then
			table.insert(self.resolutions_, {
				width = var_4_0[iter_4_0].width,
				height = var_4_0[iter_4_0].height
			})
			self.resolutionDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_4_1, nil))
		else
			local var_4_2 = self.resolutions_[#self.resolutions_]

			if self.resolutions_[#self.resolutions_] and (var_4_2.width and var_4_2.width ~= var_4_0[iter_4_0].width or var_4_2.height and var_4_2.height ~= var_4_0[iter_4_0].height) then
				table.insert(self.resolutions_, {
					width = var_4_0[iter_4_0].width,
					height = var_4_0[iter_4_0].height
				})
				self.resolutionDropdown_.options:Add(UnityEngine.UI.Dropdown.OptionData.New(var_4_1, nil))
			end
		end
	end

	self.resolutionDropdown_:RefreshShownValue()

	self.render_scale_ = {
		1,
		1.2,
		1.5,
		1.8,
		2
	}
end

function GraphicSettingPCView:ReverseTable(arg_5_1)
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

function GraphicSettingPCView:AddUIListener()
	for iter_6_0 = 1, self.picQualityNum_ do
		local var_6_0 = self.picQualityList_[iter_6_0]

		self:AddBtnListener(self.picToggle_[self.picQualityList_[iter_6_0]], nil, function()
			SettingAction.ChangePicSetting("picOptionId", var_6_0)
		end)
	end

	for iter_6_1 = 1, 4 do
		self:AddBtnListener(self["teammate" .. iter_6_1 .. "Tgl_"], nil, function()
			if self.settingData_.teammate_effect ~= iter_6_1 then
				SettingAction.ChangePicSetting("teammate_effect", iter_6_1)
			end
		end)
	end

	for iter_6_2 = 1, 4 do
		self:AddBtnListener(self["user" .. iter_6_2 .. "Tgl_"], nil, function()
			if self.settingData_.user_effect ~= iter_6_2 then
				SettingAction.ChangePicSetting("user_effect", iter_6_2)
			end
		end)
	end

	for iter_6_3 = 1, 4 do
		self:AddBtnListener(self["fps" .. iter_6_3 .. "Tgl_"], nil, function()
			if self.settingData_.frame ~= var_0_2[iter_6_3] then
				SettingAction.ChangePicSetting("frame", var_0_2[iter_6_3])
			end
		end)
	end

	for iter_6_4 = 1, 3 do
		self:AddBtnListener(self["shadow" .. iter_6_4 .. "Tgl_"], nil, function()
			if self.settingData_.shadow ~= iter_6_4 then
				SettingAction.ChangePicSetting("shadow", iter_6_4)
			end
		end)
	end

	for iter_6_5 = 1, 3 do
		self:AddBtnListener(self["postProcess" .. iter_6_5 .. "Tgl_"], nil, function()
			if self.settingData_.post_process ~= iter_6_5 then
				SettingAction.ChangePicSetting("post_process", iter_6_5)
			end
		end)
	end

	self:AddBtnListener(self.antialiasTgl_, nil, function()
		if self.settingData_.anti_aliasing ~= (self.settingData_.anti_aliasing == 1 and 0 or 1) then
			SettingAction.ChangePicSetting("anti_aliasing", self.settingData_.anti_aliasing == 1 and 0 or 1)
		end
	end)
	self:AddBtnListener(self.vertical_synchronizationTgl_, nil, function()
		if self.settingData_.vertical_sync ~= (self.settingData_.vertical_sync == 1 and 0 or 1) then
			SettingAction.ChangePicSetting("vertical_sync", self.settingData_.vertical_sync == 1 and 0 or 1)
		end
	end)

	for iter_6_6 = 1, 3 do
		self:AddBtnListener(self["window" .. iter_6_6 .. "Tgl_"], nil, function()
			if self.settingData_.window ~= iter_6_6 then
				SettingAction.ChangePicSetting("window", iter_6_6)
			end
		end)
	end

	self:AddToggleListener(self.resolutionDropdown_, function(arg_16_0)
		SettingAction.ChangePicSetting("pc_resolution", {
			self.resolutions_[arg_16_0 + 1].width,
			self.resolutions_[arg_16_0 + 1].height
		})
	end)
	self:AddToggleListener(self.renderScaleDropdown_, function(arg_17_0)
		SettingAction.ChangePicSetting("render_scale", self.render_scale_[arg_17_0 + 1])
	end)
	self:AddBtnListener(self.depthOfFiledTgl_, nil, function()
		if self.settingData_.depth_of_field_enable ~= (self.settingData_.depth_of_field_enable == 1 and 0 or 1) then
			SettingAction.ChangePicSetting("depth_of_field_enable", self.settingData_.depth_of_field_enable == 1 and 0 or 1)
		end
	end)
end

function GraphicSettingPCView:RefreshPicOption()
	for iter_19_0, iter_19_1 in pairs(self.picToggleController_) do
		if iter_19_0 == self.settingData_.picOptionId then
			iter_19_1:SetSelectedIndex(0)
		else
			iter_19_1:SetSelectedIndex(1)
		end
	end
end

function GraphicSettingPCView:RefreshUserEffect()
	local var_20_0 = self.settingData_.user_effect

	for iter_20_0 = 1, 4 do
		SetActive(self[string.format("user%dCheck_", iter_20_0)], var_20_0 == iter_20_0)
	end
end

function GraphicSettingPCView:RefreshTeamMateEffect()
	local var_21_0 = self.settingData_.teammate_effect

	for iter_21_0 = 1, 4 do
		SetActive(self[string.format("teammate%dCheck_", iter_21_0)], var_21_0 == iter_21_0)
	end
end

function GraphicSettingPCView:RefreshFPS()
	local var_22_0 = self.settingData_.frame

	for iter_22_0 = 1, 4 do
		SetActive(self[string.format("fps%dCheck_", iter_22_0)], var_22_0 == var_0_2[iter_22_0])
	end
end

function GraphicSettingPCView:RefreshShadow()
	local var_23_0 = self.settingData_.shadow

	for iter_23_0 = 1, 3 do
		SetActive(self[string.format("shadow%dCheck_", iter_23_0)], var_23_0 == iter_23_0)
	end
end

function GraphicSettingPCView:RefreshPostProcess()
	local var_24_0 = self.settingData_.post_process

	for iter_24_0 = 1, 3 do
		SetActive(self[string.format("postProcess%dCheck_", iter_24_0)], var_24_0 == iter_24_0)
	end
end

function GraphicSettingPCView:RefreshAntiAlias()
	self.antialiasTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(self.settingData_.anti_aliasing)
end

function GraphicSettingPCView:RefreshVerticalSync()
	self.vertical_synchronizationTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(self.settingData_.vertical_sync)
end

function GraphicSettingPCView:RefreshWindow()
	local var_27_0 = self.settingData_.window

	for iter_27_0 = 1, 3 do
		SetActive(self[string.format("window%dCheck_", iter_27_0)], var_27_0 == iter_27_0)
	end
end

function GraphicSettingPCView:RefreshResolution()
	local var_28_0 = false

	for iter_28_0, iter_28_1 in pairs(self.resolutions_) do
		if self.settingData_.pc_resolution[1] == iter_28_1.width and self.settingData_.pc_resolution[2] == iter_28_1.height then
			var_28_0 = true
			self.resolutionDropdown_.value = iter_28_0 - 1

			break
		end
	end

	if not var_28_0 then
		Debug.LogError("未找到分辨率挡位")

		self.resolutionDropdown_.value = 0
	end

	if self.settingData_.pc_resolution[1] > 3839 then
		SetActive(self.renderScaleIcon_, false)

		self.renderScaleDropdown_.interactable = false

		SettingAction.ChangePicSetting("render_scale", 1)
		self:RefreshRenderScale()
	else
		SetActive(self.renderScaleIcon_, true)

		self.renderScaleDropdown_.interactable = true
	end
end

function GraphicSettingPCView:RefreshRenderScale()
	local var_29_0 = false

	for iter_29_0, iter_29_1 in pairs(self.render_scale_) do
		if iter_29_1 == self.settingData_.render_scale then
			var_29_0 = true

			self.renderScaleDropdown_:SetValueWithoutNotify(iter_29_0 - 1)

			break
		end
	end

	if not var_29_0 then
		Debug.LogError("未找到分辨率挡位")
		self.renderScaleDropdown_:SetValueWithoutNotify(0)
	end
end

function GraphicSettingPCView:RefreshDepthOfFiled()
	SetActive(self.depthOfFiledGo_, false)
end

function GraphicSettingPCView:CheckDataChange(arg_31_1)
	if self.tmpSettingData_ and not table.equal(self.tmpSettingData_, self.settingData_, "all") then
		print("CheckDataChange, 新旧数据不同！！！")

		return true
	end

	return false
end

function GraphicSettingPCView:SaveData()
	if self:CheckDataChange() then
		self.json_ = require("cjson")

		local var_32_0 = deepClone(self.settingData_)

		if var_32_0.picOptionId ~= 7 then
			var_32_0.pic = {
				quality = "quality_" .. var_32_0.picOptionId
			}
		end

		var_32_0.type = 1

		local var_32_1 = self.json_.encode(var_32_0)
		local var_32_2 = table.indexof({
			6,
			2,
			3,
			4,
			5,
			7
		}, var_32_0.picOptionId)

		SDKTools.SendMessageToSDK("graphics_setting", {
			graphics = (var_32_2 > 0 or nil) and var_32_2 - 1,
			fps_setting = self.settingData_.frame == 0 and 30 or self.settingData_.frame == 1 and 60 or 120,
			teammate_effect_setting = self.settingData_.teammate_effect,
			anti_aliasing_setting = self.settingData_.anti_aliasing == 0 and "false" or "true",
			reflect_setting = self.settingData_.reflection_effect == 0 and "false" or "true",
			HDR_setting = self.settingData_.hdr == 0 and "false" or "true",
			user_effect_setting = self.settingData_.user_effect,
			other_object = {
				window_setting = self.settingData_.window,
				pc_dpi_setting = self.settingData_.pc_resolution,
				shadow_setting = self.settingData_.shadow,
				post_process_setting = self.settingData_.post_process,
				vertical_sync_setting = self.settingData_.vertical_sync == 0 and "false" or "true",
				render_scale_setting = self.settingData_.render_scale
			}
		})

		local var_32_4 = self.json_.encode(var_32_0)
	end

	self.tmpSettingData_ = deepClone(self.settingData_)
end

function GraphicSettingPCView:RecoverTmpData()
	if self:CheckDataChange() then
		SettingAction.ChangePicSetting("allData", self.tmpSettingData_)
	end
end

function GraphicSettingPCView:OnPicSettingChange(arg_34_1, arg_34_2)
	self:RefreshPicOption()

	if arg_34_2.key == "picOptionId" or arg_34_2.key == "allData" then
		self:RefreshUserEffect()
		self:RefreshTeamMateEffect()
		self:RefreshFPS()
		self:RefreshShadow()
		self:RefreshAntiAlias()
		self:RefreshVerticalSync()
		self:RefreshRenderScale()
		self:RefreshPostProcess()
	elseif arg_34_2.key == "user_effect" then
		self:RefreshUserEffect()
	elseif arg_34_2.key == "teammate_effect" then
		self:RefreshTeamMateEffect()
	elseif arg_34_2.key == "frame" then
		self:RefreshFPS()
	elseif arg_34_2.key == "shadow" then
		self:RefreshShadow()
	elseif arg_34_2.key == "post_process" then
		self:RefreshPostProcess()
	elseif arg_34_2.key == "anti_aliasing" then
		self:RefreshAntiAlias()
	elseif arg_34_2.key == "vertical_sync" then
		self:RefreshVerticalSync()
	elseif arg_34_2.key == "window" then
		self:RefreshWindow()
	elseif arg_34_2.key == "pc_resolution" then
		self:RefreshResolution()
	elseif arg_34_2.key == "render_scale" then
		self:RefreshRenderScale()
	elseif arg_34_2.key == "depth_of_field_enable" then
		self:RefreshDepthOfFiled()
	end
end

function GraphicSettingPCView:Init()
	self:InitUI()
	self:AddUIListener()
	self:OnEnter()
end

function GraphicSettingPCView:OnEnter()
	self.settingData_ = SettingData:GetPicSettingData()

	self:RefreshUI()

	self.tmpSettingData_ = deepClone(self.settingData_)
end

function GraphicSettingPCView:RefreshUI()
	self:RefreshPicOption()
	self:RefreshUserEffect()
	self:RefreshTeamMateEffect()
	self:RefreshFPS()
	self:RefreshShadow()
	self:RefreshPostProcess()
	self:RefreshAntiAlias()
	self:RefreshVerticalSync()
	self:RefreshWindow()
	self:RefreshResolution()
	self:RefreshRenderScale()
	self:RefreshDepthOfFiled()
end

function GraphicSettingPCView:OnExit()
	return
end

function GraphicSettingPCView:Dispose()
	self.hander_ = nil

	GraphicSettingPCView.super.Dispose(self)
end

return GraphicSettingPCView
