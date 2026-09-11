local GraphicSettingView = class("GraphicSettingView", ReduxView)

function GraphicSettingView:SetActive(arg_1_1)
	if self.gameObject_ then
		SetActive(self.gameObject_, arg_1_1)
	end

	if arg_1_1 then
		self.scrollView_.verticalNormalizedPosition = 1
	end
end

function GraphicSettingView:Ctor(arg_2_1, arg_2_2, arg_2_3)
	self.hander_ = arg_2_1
	self.transform_ = arg_2_2.transform
	self.gameObject_ = arg_2_2
	self.info_ = arg_2_3

	self:Init()
end

function GraphicSettingView:BindRedPointUI()
	manager.redPoint:bindUIandKey(self.fps120go_.transform, RedPointConst.HIGH_FPS_DEVICE_SURRPORT)
end

function GraphicSettingView:UnBindRedPointUI()
	manager.redPoint:unbindUIandKey(self.fps120go_.transform, RedPointConst.HIGH_FPS_DEVICE_SURRPORT)
end

function GraphicSettingView:InitUI()
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

	for iter_5_0 = 1, self.picQualityNum_ do
		self.picToggle_[self.picQualityList_[iter_5_0]] = self["pic" .. self.picQualityList_[iter_5_0] .. "Btn_"]
		self.picToggleController_[self.picQualityList_[iter_5_0]] = ControllerUtil.GetController(self.picToggle_[self.picQualityList_[iter_5_0]]:GetComponent(typeof(RectTransform)), "name")
	end
end

function GraphicSettingView:AddUIListener()
	for iter_6_0 = 1, self.picQualityNum_ do
		local var_6_0 = self.picQualityList_[iter_6_0]

		self:AddBtnListener(self.picToggle_[self.picQualityList_[iter_6_0]], nil, function()
			if PictureQualitySettingCfg[iter_6_0].super_resolution_enable == 1 then
				ShowMessageBox({
					content = GetTips("GRAPHIIC_SETTING_TIPS1"),
					OkCallback = function()
						SettingAction.ChangePicSetting("picOptionId", var_6_0)
					end,
					CancelCallback = function()
						return
					end
				})
			else
				SettingAction.ChangePicSetting("picOptionId", var_6_0)
			end
		end)
	end

	for iter_6_1 = 1, 3 do
		self:AddBtnListener(self["fps" .. iter_6_1 .. "Tgl_"], nil, function()
			if self.settingData_.frame ~= iter_6_1 - 1 then
				if iter_6_1 == 3 then
					manager.redPoint:setTip(RedPointConst.HIGH_FPS_DEVICE_SURRPORT, 0)

					if GameLocalData:GetCommonModule("highFps").isFirstSet == nil == true then
						ShowMessageBox({
							isTop = true,
							content = GetTips("WARN_HIGH_FPS_TIPS"),
							OkCallback = function()
								SettingAction.ChangePicSetting("frame", iter_6_1 - 1)
								GameLocalData:SaveToCommonModule("highFps", "isFirstSet", false)
							end,
							CancelCallback = function()
								return
							end
						})
					else
						SettingAction.ChangePicSetting("frame", iter_6_1 - 1)
					end

					GameLocalData:SaveToCommonModule("highFps", "checkDevice", true)
				else
					SettingAction.ChangePicSetting("frame", iter_6_1 - 1)
				end
			end
		end)
	end

	for iter_6_2 = 1, 3 do
		self:AddBtnListener(self["resolution" .. iter_6_2 .. "Tgl_"], nil, function()
			if self.settingData_.resolution ~= iter_6_2 then
				SettingAction.ChangePicSetting("resolution", iter_6_2)
			end
		end)
	end

	for iter_6_3 = 1, 3 do
		self:AddBtnListener(self["teammate" .. iter_6_3 .. "Tgl_"], nil, function()
			if self.settingData_.teammate_effect ~= iter_6_3 then
				SettingAction.ChangePicSetting("teammate_effect", iter_6_3)
			end
		end)
	end

	for iter_6_4 = 1, 3 do
		self:AddBtnListener(self["user" .. iter_6_4 .. "Tgl_"], nil, function()
			if self.settingData_.user_effect ~= iter_6_4 then
				SettingAction.ChangePicSetting("user_effect", iter_6_4)
			end
		end)
	end

	self:AddBtnListener(self.antialiasTgl_, nil, function()
		if self.settingData_.anti_aliasing ~= (self.settingData_.anti_aliasing == 1 and 0 or 1) then
			SettingAction.ChangePicSetting("anti_aliasing", self.settingData_.anti_aliasing == 1 and 0 or 1)
		end
	end)
	self:AddBtnListener(self.reflectTgl_, nil, function()
		if self.settingData_.reflection_effect ~= (self.settingData_.reflection_effect == 1 and 0 or 1) then
			SettingAction.ChangePicSetting("reflection_effect", self.settingData_.reflection_effect == 1 and 0 or 1)
		end
	end)
	self:AddBtnListener(self.depthOfFiledTgl_, nil, function()
		if self.settingData_.depth_of_field_enable ~= (self.settingData_.depth_of_field_enable == 1 and 0 or 1) then
			SettingAction.ChangePicSetting("depth_of_field_enable", self.settingData_.depth_of_field_enable == 1 and 0 or 1)
		end
	end)
	self:AddBtnListener(self.superResolutionTgl_, nil, function()
		local var_19_0 = self.settingData_.super_resolution_enable == 1 and 0 or 1

		if self.settingData_.super_resolution_enable ~= (self.settingData_.super_resolution_enable == 1 and 0 or 1) then
			if var_19_0 == 1 then
				ShowMessageBox({
					content = GetTips("GRAPHIIC_SETTING_TIPS2"),
					OkCallback = function()
						SettingAction.ChangePicSetting("super_resolution_enable", var_19_0)
					end,
					CancelCallback = function()
						return
					end
				})
			else
				SettingAction.ChangePicSetting("super_resolution_enable", var_19_0)
			end
		end
	end)
	self:AddBtnListener(self.superResolutionTipsBtn_, nil, function()
		SetActive(self.tipsTrs_.gameObject, true)
		SetActive(self.maskBtn_.transform.gameObject, true)
	end)
	self:AddBtnListener(self.maskBtn_, nil, function()
		SetActive(self.tipsTrs_.gameObject, false)
		SetActive(self.maskBtn_.transform.gameObject, false)
	end)
end

function GraphicSettingView:RefreshPicOption()
	for iter_24_0, iter_24_1 in pairs(self.picToggleController_) do
		if iter_24_0 == self.settingData_.picOptionId then
			iter_24_1:SetSelectedIndex(0)
		else
			iter_24_1:SetSelectedIndex(1)
		end
	end
end

function GraphicSettingView:RefreshFPS()
	local var_25_0 = self.settingData_.frame + 1

	for iter_25_0 = 1, 3 do
		SetActive(self[string.format("fps%dCheck_", iter_25_0)], var_25_0 == iter_25_0)
	end
end

function GraphicSettingView:RefreshResolution()
	local var_26_0 = self.settingData_.resolution

	for iter_26_0 = 1, 3 do
		SetActive(self[string.format("resolution%dCheck_", iter_26_0)], var_26_0 == iter_26_0)
	end
end

function GraphicSettingView:RefreshTeamMateEffect()
	local var_27_0 = self.settingData_.teammate_effect

	for iter_27_0 = 1, 3 do
		SetActive(self[string.format("teammate%dCheck_", iter_27_0)], var_27_0 == iter_27_0)
	end
end

function GraphicSettingView:RefreshUserEffect()
	local var_28_0 = self.settingData_.user_effect

	for iter_28_0 = 1, 3 do
		SetActive(self[string.format("user%dCheck_", iter_28_0)], var_28_0 == iter_28_0)
	end
end

function GraphicSettingView:RefreshAntiAlias()
	self.antialiasTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(self.settingData_.anti_aliasing)
end

function GraphicSettingView:RefreshReflect()
	self.reflectTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(self.settingData_.reflection_effect)
end

function GraphicSettingView:RefreshDepthOfFiled()
	SetActive(self.depthOfFiledGo_, false)
end

function GraphicSettingView:RefreshSuperResolution()
	self.superResolutionTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(self.settingData_.super_resolution_enable)
end

function GraphicSettingView:CheckDataChange(arg_33_1)
	if self.tmpSettingData_ and not table.equal(self.tmpSettingData_, self.settingData_, "all") then
		print("CheckDataChange, 新旧数据不同！！！")

		return true
	end

	return false
end

function GraphicSettingView:SaveData()
	if self:CheckDataChange() then
		self.json_ = require("cjson")

		local var_34_0 = deepClone(self.settingData_)

		if var_34_0.picOptionId ~= 7 then
			var_34_0.pic = {
				quality = "quality_" .. var_34_0.picOptionId
			}
		end

		var_34_0.type = 1

		local var_34_1 = self.json_.encode(var_34_0)
		local var_34_2 = table.indexof({
			6,
			2,
			3,
			4,
			5,
			7
		}, var_34_0.picOptionId)

		SDKTools.SendMessageToSDK("graphics_setting", {
			graphics = (var_34_2 > 0 or nil) and var_34_2 - 1,
			fps_setting = self.settingData_.frame == 0 and 30 or self.settingData_.frame == 1 and 60 or 120,
			dpi_setting = self.settingData_.resolution,
			teammate_effect_setting = self.settingData_.teammate_effect,
			anti_aliasing_setting = self.settingData_.anti_aliasing == 0 and "false" or "true",
			reflect_setting = self.settingData_.reflection_effect == 0 and "false" or "true",
			user_effect_setting = self.settingData_.user_effect,
			other_object = {
				render_scale_setting = self.settingData_.super_resolution_enable
			}
		})

		local var_34_4 = self.json_.encode(var_34_0)
	end

	self.tmpSettingData_ = deepClone(self.settingData_)
end

function GraphicSettingView:RecoverTmpData()
	if self:CheckDataChange() then
		SettingAction.ChangePicSetting("allData", self.tmpSettingData_)
	end
end

function GraphicSettingView:OnPicSettingChange(arg_36_1, arg_36_2)
	self:RefreshPicOption()

	if arg_36_2.key == "picOptionId" or arg_36_2.key == "allData" then
		self:RefreshResolution()
		self:RefreshTeamMateEffect()
		self:RefreshUserEffect()
		self:RefreshFPS()
		self:RefreshAntiAlias()
		self:RefreshReflect()
		self:RefreshSuperResolution()
	elseif arg_36_2.key == "resolution" then
		self:RefreshResolution()
	elseif arg_36_2.key == "teammate_effect" then
		self:RefreshTeamMateEffect()
	elseif arg_36_2.key == "frame" then
		self:RefreshFPS()
	elseif arg_36_2.key == "anti_aliasing" then
		self:RefreshAntiAlias()
	elseif arg_36_2.key == "reflection_effect" then
		self:RefreshReflect()
	elseif arg_36_2.key == "user_effect" then
		self:RefreshUserEffect()
	elseif arg_36_2.key == "depth_of_field_enable" then
		self:RefreshDepthOfFiled()
	elseif arg_36_2.key == "super_resolution_enable" then
		self:RefreshSuperResolution()
	end
end

function GraphicSettingView:Init()
	self:InitUI()
	self:AddUIListener()
	self:OnEnter()
end

function GraphicSettingView:OnEnter()
	self.settingData_ = SettingData:GetPicSettingData()

	self:RefreshPicOption()
	self:RefreshFPS()
	self:RefreshResolution()
	self:RefreshTeamMateEffect()
	self:RefreshUserEffect()
	self:RefreshAntiAlias()
	self:RefreshReflect()
	self:RefreshDepthOfFiled()
	self:RefreshSuperResolution()

	self.tmpSettingData_ = deepClone(self.settingData_)

	self:BindRedPointUI()
end

function GraphicSettingView:RefreshUI()
	SetActive(self.tipsTrs_.gameObject, false)
	SetActive(self.maskBtn_.transform.gameObject, false)
end

function GraphicSettingView:OnExit()
	self:UnBindRedPointUI()
end

function GraphicSettingView:Dispose()
	self.hander_ = nil

	GraphicSettingView.super.Dispose(self)
end

return GraphicSettingView
