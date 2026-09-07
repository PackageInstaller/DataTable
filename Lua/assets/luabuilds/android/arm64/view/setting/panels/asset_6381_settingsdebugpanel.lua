local SettingsDebugPanel = class("SettingsDebugPanel", import(".SettingsBasePanel"))

function SettingsDebugPanel:GetUIName()
	return "SettingsOther"
end

function SettingsDebugPanel:GetTitle()
	return "测试面板"
end

function SettingsDebugPanel:GetTitleEn()
	return ""
end

function SettingsDebugPanel:OnInit()
	local var_4_0 = self._tf:Find("options/notify_tpl")

	setActive(var_4_0, false)

	self.container = self._tf:Find("options")
	self.toggleTpl = cloneTplTo(var_4_0, self._tf, "toggleTpl")
	self.btnTpl = cloneTplTo(var_4_0, self._tf, "btnTpl")

	GameObject.Destroy(findGO(self.btnTpl, "off"))
	GameObject.Destroy(findGO(self.btnTpl, "on"))
	RemoveComponent(self.btnTpl, "ToggleGroup")
	removeAllChildren(self.container)
	self:btn_brightness_permission()
	self:btn_brightness_setvalue()
	self:btn_alarm_permission()
	self:btn_notification_permission()
	self:toggle_notification_tag()
	self:btn_push_10s()
	self:btn_cancel_notification()
	self:btn_save_photo()
	self:btn_record_start()
	self:btn_record_stop()
	self:btn_vulkan()
	self:btn_gles()
	self:btn_show_api()

	return
end

function SettingsDebugPanel:createBtn(arg_5_1)
	local var_5_0 = cloneTplTo(self.btnTpl, self.container, arg_5_1.go)

	setText(var_5_0:Find("mask/Text"), arg_5_1.text)
	onButton(self, var_5_0, arg_5_1.func, SFX_PANEL)

	return
end

function SettingsDebugPanel:createToggle(arg_6_1)
	local var_6_0 = cloneTplTo(self.toggleTpl, self.container, arg_6_1.go)

	setText(var_6_0:Find("mask/Text"), arg_6_1.text)
	onToggle(self, var_6_0:Find("on"), arg_6_1.func, SFX_UI_TAG, SFX_UI_CANCEL)

	return
end

function SettingsDebugPanel:btn_brightness_permission()
	self:createBtn({
		go = "btn_brightness_permission",
		text = "检查亮度权限",
		func = function()
			if YSNormalTool.BrightnessTool.CanWriteSetting() then
				pg.TipsMgr.GetInstance():ShowTips("拥有权限")
			else
				YSNormalTool.OtherTool.OpenAndroidWriteSettings()
			end

			return
		end
	})

	return
end

function SettingsDebugPanel:btn_brightness_setvalue()
	local var_9_0 = "循环设置亮度，当前亮度："
	local var_9_1 = {
		go = "btn_brightness_setvalue",
		text = "循环设置亮度，当前亮度：" .. YSNormalTool.BrightnessTool.GetBrightnessValue()
	}

	local function var_9_2()
		setText(self.container:Find(var_9_1.go .. "/mask/Text"), var_9_0 .. YSNormalTool.BrightnessTool.GetBrightnessValue())

		return
	end

	function var_9_1.func()
		local var_11_0 = YSNormalTool.BrightnessTool.GetBrightnessValue() + 0.1

		if var_11_0 > 1 then
			var_11_0 = var_11_0 - 1
		end

		YSNormalTool.BrightnessTool.SetBrightnessValue(var_11_0)
		var_9_2()

		return
	end

	self:createBtn(var_9_1)

	return
end

function SettingsDebugPanel:btn_alarm_permission()
	if PermissionHelper.IsAndroid() then
		self:createBtn({
			go = "btn_alarm_permission",
			text = "检查安卓闹钟权限",
			func = function()
				if YSNormalTool.NotificationTool.CanScheduleExactAlarms() then
					pg.TipsMgr.GetInstance():ShowTips("拥有权限")
				else
					YSNormalTool.NotificationTool.RequestScheduleExactAlarmsPermission()
				end

				return
			end
		})
	end

	return
end

function SettingsDebugPanel:btn_notification_permission()
	self:createBtn({
		go = "btn_notification_permission",
		text = "检查通知权限",
		func = function()
			YSNormalTool.PermissionTool.RequestMultiPermission({
				YSNormalTool.PermissionTool.Notification
			}, function(arg_16_0, arg_16_1)
				local var_16_0 = true

				for iter_16_0 = 0, arg_16_1.Length - 1 do
					if arg_16_1[iter_16_0] ~= 0 then
						var_16_0 = false

						break
					end
				end

				if var_16_0 then
					pg.TipsMgr.GetInstance():ShowTips("授权成功")
				else
					pg.TipsMgr.GetInstance():ShowTips("授权失败")
				end

				return
			end)

			return
		end
	})

	return
end

function SettingsDebugPanel:toggle_notification_tag()
	self:createToggle({
		go = "btn_push_10s",
		text = "开启则可切到后台测试通知，测完需要关闭",
		func = function(arg_18_0)
			PUSH_NOTIFICATION_TEST_TAG = not not arg_18_0

			return
		end
	})

	return
end

function SettingsDebugPanel:btn_push_10s()
	self:createBtn({
		go = "btn_push_10s",
		text = "10秒后推送通知",
		func = function()
			pg.TipsMgr.GetInstance():ShowTips("推送测试通知")

			local var_20_0 = pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "*t")

			pg.PushNotificationMgr.GetInstance():Push("测试标题", var_20_0.year .. var_20_0.month .. var_20_0.day .. var_20_0.hour .. var_20_0.min .. var_20_0.sec, pg.TimeMgr.GetInstance():GetServerTime() + 10)
			pg.PushNotificationMgr.GetInstance():PushCache()

			return
		end
	})

	return
end

function SettingsDebugPanel:btn_cancel_notification()
	self:createBtn({
		go = "btn_cancel_notification",
		text = "取消所有通知",
		func = function()
			YSNormalTool.NotificationTool.CancelAllNotification()

			return
		end
	})

	return
end

function SettingsDebugPanel:btn_save_photo()
	self:createBtn({
		go = "btn_save_photo",
		text = "保存截图",
		func = function()
			YSNormalTool.MediaTool.SaveImageWithBytes(YSTool.YSScreenShoter.TakeScreenShotDirectly(), function(arg_25_0, arg_25_1)
				if arg_25_0 then
					pg.TipsMgr.GetInstance():ShowTips("保存截图成功")
				else
					pg.TipsMgr.GetInstance():ShowTips("保存截图失败：" .. arg_25_1)
				end

				return
			end)

			return
		end
	})

	return
end

function SettingsDebugPanel:btn_record_start()
	local var_26_0 = {
		go = "btn_record_start",
		text = "开始录屏"
	}

	local function var_26_1(arg_27_0)
		if not arg_27_0 then
			pg.TipsMgr.GetInstance():ShowTips("开始录屏失败")
		else
			pg.TipsMgr.GetInstance():ShowTips("开始录屏成功")
		end

		return
	end

	function var_26_0.func()
		PermissionHelper.RequestCamera(function()
			self.recordFilePath = YSNormalTool.RecordTool.GenRecordFilePath()

			YSNormalTool.RecordTool.StartRecording(var_26_1, self.recordFilePath)

			return
		end, function()
			pg.TipsMgr.GetInstance():ShowTips("请求录屏所需权限失败")

			return
		end)

		return
	end

	self:createBtn(var_26_0)

	return
end

function SettingsDebugPanel:btn_record_stop()
	local var_31_0 = {
		go = "btn_record_stop",
		text = "结束录屏"
	}

	local function var_31_1(arg_32_0)
		if arg_32_0 and PLATFORM == PLATFORM_ANDROID then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("word_save_video"),
				onNo = function()
					if System.IO.File.Exists(self.recordFilePath) then
						System.IO.File.Delete(self.recordFilePath)
					end

					return
				end,
				onYes = function()
					YSNormalTool.MediaTool.SaveVideoToAlbum(self.recordFilePath, function(arg_35_0, arg_35_1)
						if arg_35_0 then
							pg.TipsMgr.GetInstance():ShowTips(i18n("word_save_ok"))

							if System.IO.File.Exists(self.recordFilePath) then
								System.IO.File.Delete(self.recordFilePath)
							end
						end

						return
					end)

					return
				end
			})
		end

		return
	end

	function var_31_0.func()
		YSNormalTool.RecordTool.StopRecording(var_31_1)

		return
	end

	self:createBtn(var_31_0)

	return
end

function SettingsDebugPanel:btn_vulkan()
	local var_37_0 = GraphApiHelper.GetGraphApiSaveValue()
	local var_37_1 = ""

	if var_37_0 == 0 then
		var_37_1 = " 当前未设置，Unity自己选择。"
	elseif var_37_0 == 1 then
		var_37_1 = " 当前强制设置Vulkan。"
	elseif var_37_0 == 2 then
		var_37_1 = " 当前强制设置GLES。"
	end

	self:createBtn({
		go = "btn_vulkan",
		text = "设置为Vulkan(需要重启)" .. var_37_1,
		func = function()
			GraphApiHelper.SetForceGraphApi(GraphApiHelper.Api.Force_Vulkan)

			return
		end
	})

	return
end

function SettingsDebugPanel:btn_gles()
	local var_39_0 = GraphApiHelper.GetGraphApiSaveValue()
	local var_39_1 = ""

	if var_39_0 == 0 then
		var_39_1 = " 当前未设置，Unity自己选择。"
	elseif var_39_0 == 1 then
		var_39_1 = " 当前强制设置Vulkan。"
	elseif var_39_0 == 2 then
		var_39_1 = " 当前强制设置GLES。"
	end

	self:createBtn({
		go = "btn_gles",
		text = "设置为OpenGLES(需要重启)" .. var_39_1,
		func = function()
			GraphApiHelper.SetForceGraphApi(GraphApiHelper.Api.Force_OpenGLES)

			return
		end
	})

	return
end

function SettingsDebugPanel:btn_show_api()
	self:createBtn({
		go = "btn_show_api",
		text = "点击显示当前Api",
		func = function()
			pg.TipsMgr.GetInstance():ShowTips("当前Api:" .. GraphApiHelper.GetCurGraphApi())

			return
		end
	})

	return
end

return SettingsDebugPanel
