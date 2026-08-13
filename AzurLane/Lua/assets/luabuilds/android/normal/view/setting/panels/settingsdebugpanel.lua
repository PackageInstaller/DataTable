class = var_0_10000

local var_0_0 = "SettingsDebugPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SettingsBasePanel"))

function var_0_1.GetUIName(arg_1_0)
	return "SettingsOther"
end

function var_0_1.GetTitle(arg_2_0)
	return "测试面板"
end

function var_0_1.GetTitleEn(arg_3_0)
	return ""
end

function var_0_1.OnInit(arg_4_0)
	local var_4_0 = arg_4_0._tf
	local var_4_1 = var_1.Find(var_4_0, "options/notify_tpl")

	setActive = var_4_0

	var_4_0(var_4_1, false)

	local var_4_2 = arg_4_0._tf

	arg_4_0.container = var_2.Find(var_4_2, "options")
	cloneTplTo = var_2
	arg_4_0.toggleTpl = var_2(var_4_1, arg_4_0._tf, "toggleTpl")
	cloneTplTo = var_2
	arg_4_0.btnTpl = var_2(var_4_1, arg_4_0._tf, "btnTpl")
	GameObject = var_2

	local var_4_3 = var_2.Destroy

	findGO = var_3

	var_4_3(var_3(arg_4_0.btnTpl, "off"))

	GameObject = var_4_3

	local var_4_4 = var_4_3.Destroy

	findGO = var_3

	var_4_4(var_3(arg_4_0.btnTpl, "on"))

	RemoveComponent = var_4_4

	var_4_4(arg_4_0.btnTpl, "ToggleGroup")

	removeAllChildren = var_4_4

	var_4_4(arg_4_0.container)
	arg_4_0:btn_brightness_permission()
	arg_4_0:btn_brightness_setvalue()
	arg_4_0:btn_alarm_permission()
	arg_4_0:btn_notification_permission()
	arg_4_0:toggle_notification_tag()
	arg_4_0:btn_push_10s()
	arg_4_0:btn_cancel_notification()
	arg_4_0:btn_save_photo()
	arg_4_0:btn_record_start()
	arg_4_0:btn_record_stop()
	arg_4_0:btn_vulkan()
	arg_4_0:btn_gles()
	arg_4_0:btn_show_api()

	return
end

function var_0_1.createBtn(arg_5_0, arg_5_1)
	cloneTplTo = var_1_10002

	local var_5_0 = var_1_10002(arg_5_0.btnTpl, arg_5_0.container, arg_5_1.go)
	local var_5_1 = var_2.Find(var_5_0, "mask/Text")

	setText = var_5_0

	var_5_0(var_5_1, arg_5_1.text)

	onButton = var_5_0

	local var_5_2 = arg_5_0
	local var_5_3 = var_2
	local var_5_4 = arg_5_1.func

	SFX_PANEL = var_1_10008

	var_5_0(var_5_2, var_5_3, var_5_4, var_1_10008)

	return
end

function var_0_1.createToggle(arg_6_0, arg_6_1)
	cloneTplTo = var_1_10002

	local var_6_0 = var_1_10002(arg_6_0.toggleTpl, arg_6_0.container, arg_6_1.go)
	local var_6_1 = var_2.Find(var_6_0, "mask/Text")
	local var_6_2 = var_2
	local var_6_3 = var_2.Find(var_6_2, "on")

	setText = var_6_2

	var_6_2(var_6_1, arg_6_1.text)

	onToggle = var_6_2

	local var_6_4 = arg_6_0
	local var_6_5 = var_6_3
	local var_6_6 = arg_6_1.func

	SFX_UI_TAG = var_1_10009
	SFX_UI_CANCEL = var_1_10010

	var_6_2(var_6_4, var_6_5, var_6_6, var_1_10009, var_1_10010)

	return
end

function var_0_1.btn_brightness_permission(arg_7_0)
	local var_7_0 = {
		go = "btn_brightness_permission",
		text = "检查亮度权限",
		func = function()
			YSNormalTool = var_2_10000

			if var_2_10000.BrightnessTool.CanWriteSetting() then
				pg = var_0

				local var_8_0 = var_0.TipsMgr.GetInstance()

				var_0.ShowTips(var_8_0, "拥有权限")
			else
				YSNormalTool = var_0

				var_0.OtherTool.OpenAndroidWriteSettings()
			end

			return
		end
	}

	arg_7_0:createBtn(var_7_0)

	return
end

function var_0_1.btn_brightness_setvalue(arg_9_0)
	local var_9_0 = "循环设置亮度，当前亮度："
	local var_9_1 = {
		go = "btn_brightness_setvalue"
	}
	local var_9_2 = var_9_0

	YSNormalTool = var_1_10004
	var_9_1.text = var_9_2 .. var_1_10004.BrightnessTool.GetBrightnessValue()

	local function var_9_3()
		local var_10_0 = arg_9_0.container
		local var_10_1

		var_10_1, setText = var_0.Find(var_10_0, var_9_1.go .. "/mask/Text"), var_10_0

		local var_10_2 = var_9_0

		YSNormalTool = var_2_10004

		var_10_0(var_10_1, var_10_2 .. var_2_10004.BrightnessTool.GetBrightnessValue())

		return
	end

	function var_9_1.func()
		YSNormalTool = var_2_10000

		local var_11_0 = var_2_10000.BrightnessTool.GetBrightnessValue() + 0.1

		if 1 < var_11_0 then
			var_11_0 = var_11_0 - 1
		end

		YSNormalTool = var_1

		var_1.BrightnessTool.SetBrightnessValue(var_11_0)
		var_9_3()

		return
	end

	arg_9_0:createBtn(var_9_1)

	return
end

function var_0_1.btn_alarm_permission(arg_12_0)
	local var_12_0 = {
		go = "btn_alarm_permission",
		text = "检查安卓闹钟权限",
		func = function()
			YSNormalTool = var_2_10000

			if var_2_10000.NotificationTool.CanScheduleExactAlarms() then
				pg = var_0

				local var_13_0 = var_0.TipsMgr.GetInstance()

				var_0.ShowTips(var_13_0, "拥有权限")
			else
				YSNormalTool = var_0

				var_0.NotificationTool.RequestScheduleExactAlarmsPermission()
			end

			return
		end
	}

	PermissionHelper = var_2

	if var_2.IsAndroid() then
		arg_12_0:createBtn(var_12_0)
	end

	return
end

function var_0_1.btn_notification_permission(arg_14_0)
	local var_14_0 = {
		go = "btn_notification_permission",
		text = "检查通知权限",
		func = function()
			local var_15_0 = {}

			YSNormalTool = var_2_10001
			var_15_0[1] = var_2_10001.PermissionTool.Notification
			YSNormalTool = var_1

			var_1.PermissionTool.RequestMultiPermission(var_15_0, function(arg_16_0, arg_16_1)
				local var_16_0 = true
				local var_16_1 = arg_16_1.Length

				for iter_16_0 = 0, var_16_1 - 1 do
					if arg_16_1[iter_16_0] ~= 0 then
						var_16_0 = false

						break
					end
				end

				if var_16_0 then
					pg = var_4

					local var_16_2 = var_4.TipsMgr.GetInstance()

					var_4.ShowTips(var_16_2, "授权成功")
				else
					pg = var_4

					local var_16_3 = var_4.TipsMgr.GetInstance()

					var_4.ShowTips(var_16_3, "授权失败")
				end

				return
			end)

			return
		end
	}

	arg_14_0:createBtn(var_14_0)

	return
end

function var_0_1.toggle_notification_tag(arg_17_0)
	local var_17_0 = {
		go = "btn_push_10s",
		text = "开启则可切到后台测试通知，测完需要关闭",
		func = function(arg_18_0)
			if arg_18_0 then
				local var_18_0 = true
				local var_18_1 = PUSH_NOTIFICATION_TEST_TAG
			else
				local var_18_2 = false
				local var_18_3 = PUSH_NOTIFICATION_TEST_TAG
			end

			return
		end
	}

	arg_17_0:createToggle(var_17_0)

	return
end

function var_0_1.btn_push_10s(arg_19_0)
	local var_19_0 = {
		go = "btn_push_10s",
		text = "10秒后推送通知",
		func = function()
			pg = var_2_10000

			local var_20_0 = var_2_10000.TipsMgr.GetInstance()

			var_0.ShowTips(var_20_0, "推送测试通知")

			pg = var_0

			local var_20_1 = var_0.TimeMgr.GetInstance()
			local var_20_2 = var_0.STimeDescS

			pg = var_2

			local var_20_3 = var_2.TimeMgr.GetInstance()
			local var_20_4 = var_20_2(var_20_1, var_2.GetServerTime(var_20_3), "*t").year .. var_0.month .. var_0.day .. var_0.hour .. var_0.min .. var_0.sec

			pg = var_2

			local var_20_5 = var_2.TimeMgr.GetInstance()
			local var_20_6 = var_2.GetServerTime(var_20_5) + 10

			pg = var_20_5

			local var_20_7 = var_20_5.PushNotificationMgr.GetInstance()

			var_3.Push(var_20_7, "测试标题", var_20_4, var_20_6)

			pg = var_3

			local var_20_8 = var_3.PushNotificationMgr.GetInstance()

			var_3.PushCache(var_20_8)

			return
		end
	}

	arg_19_0:createBtn(var_19_0)

	return
end

function var_0_1.btn_cancel_notification(arg_21_0)
	local var_21_0 = {
		go = "btn_cancel_notification",
		text = "取消所有通知",
		func = function()
			YSNormalTool = var_2_10000

			var_2_10000.NotificationTool.CancelAllNotification()

			return
		end
	}

	arg_21_0:createBtn(var_21_0)

	return
end

function var_0_1.btn_save_photo(arg_23_0)
	local var_23_0 = {
		go = "btn_save_photo",
		text = "保存截图",
		func = function()
			YSTool = var_2_10000

			local var_24_0 = var_2_10000.YSScreenShoter.TakeScreenShotDirectly()

			YSNormalTool = var_2_10001

			var_2_10001.MediaTool.SaveImageWithBytes(var_24_0, function(arg_25_0, arg_25_1)
				if arg_25_0 then
					pg = var_3_10002

					local var_25_0 = var_3_10002.TipsMgr.GetInstance()

					var_3_10002.ShowTips(var_25_0, "保存截图成功")
				else
					pg = var_3_10002

					local var_25_1 = var_3_10002.TipsMgr.GetInstance()

					var_2.ShowTips(var_25_1, "保存截图失败：" .. arg_25_1)
				end

				return
			end)

			return
		end
	}

	arg_23_0:createBtn(var_23_0)

	return
end

function var_0_1.btn_record_start(arg_26_0)
	local var_26_0 = {
		go = "btn_record_start",
		text = "开始录屏"
	}

	local function var_26_1(arg_27_0)
		if not arg_27_0 then
			pg = var_2_10001

			local var_27_0 = var_2_10001.TipsMgr.GetInstance()

			var_2_10001.ShowTips(var_27_0, "开始录屏失败")
		else
			pg = var_2_10001

			local var_27_1 = var_2_10001.TipsMgr.GetInstance()

			var_1.ShowTips(var_27_1, "开始录屏成功")
		end

		return
	end

	function var_26_0.func()
		PermissionHelper = var_2_10000

		var_2_10000.RequestCamera(function()
			local var_29_0 = arg_26_0

			YSNormalTool = var_3_10001
			var_29_0.recordFilePath = var_3_10001.RecordTool.GenRecordFilePath()
			YSNormalTool = var_29_0

			var_29_0.RecordTool.StartRecording(var_26_1, arg_26_0.recordFilePath)

			return
		end, function()
			pg = var_3_10000

			local var_30_0 = var_3_10000.TipsMgr.GetInstance()

			var_0.ShowTips(var_30_0, "请求录屏所需权限失败")

			return
		end)

		return
	end

	arg_26_0:createBtn(var_26_0)

	return
end

function var_0_1.btn_record_stop(arg_31_0)
	local var_31_0 = {
		go = "btn_record_stop",
		text = "结束录屏"
	}

	local function var_31_1(arg_32_0)
		if arg_32_0 then
			PLATFORM = var_2_10001
			PLATFORM_ANDROID = var_2_10002

			if var_2_10001 == var_2_10002 then
				pg = var_2_10001

				local var_32_0 = var_2_10001.MsgboxMgr.GetInstance()
				local var_32_1 = var_1.ShowMsgBox
				local var_32_2 = {}

				i18n = var_2_10004
				var_32_2.content = var_2_10004("word_save_video")

				function var_32_2.onNo()
					System = var_3_10000

					if var_3_10000.IO.File.Exists(arg_31_0.recordFilePath) then
						System = var_0

						var_0.IO.File.Delete(arg_31_0.recordFilePath)
					end

					return
				end

				function var_32_2.onYes()
					YSNormalTool = var_3_10000

					var_3_10000.MediaTool.SaveVideoToAlbum(arg_31_0.recordFilePath, function(arg_35_0, arg_35_1)
						if arg_35_0 then
							pg = var_4_10002

							local var_35_0 = var_4_10002.TipsMgr.GetInstance()
							local var_35_1 = var_2.ShowTips

							i18n = var_4_10004

							var_35_1(var_35_0, var_4_10004("word_save_ok"))

							System = var_35_1

							if var_35_1.IO.File.Exists(arg_31_0.recordFilePath) then
								System = var_2

								var_2.IO.File.Delete(arg_31_0.recordFilePath)
							end
						end

						return
					end)

					return
				end

				var_32_1(var_32_0, var_32_2)
			end
		end

		return
	end

	function var_31_0.func()
		YSNormalTool = var_2_10000

		var_2_10000.RecordTool.StopRecording(var_31_1)

		return
	end

	arg_31_0:createBtn(var_31_0)

	return
end

function var_0_1.btn_vulkan(arg_37_0)
	GraphApiHelper = var_1_10001

	local var_37_0 = var_1_10001.GetGraphApiSaveValue()
	local var_37_1 = ""

	if var_37_0 == 0 then
		var_37_1 = " 当前未设置，Unity自己选择。"
	elseif var_37_0 == 1 then
		var_37_1 = " 当前强制设置Vulkan。"
	elseif var_37_0 == 2 then
		var_37_1 = " 当前强制设置GLES。"
	end

	local var_37_2 = {
		go = "btn_vulkan",
		text = "设置为Vulkan(需要重启)" .. var_37_1,
		func = function()
			GraphApiHelper = var_2_10000

			local var_38_0 = var_2_10000.SetForceGraphApi

			GraphApiHelper = var_2_10001

			var_38_0(var_2_10001.Api.Force_Vulkan)

			return
		end
	}

	arg_37_0:createBtn(var_37_2)

	return
end

function var_0_1.btn_gles(arg_39_0)
	GraphApiHelper = var_1_10001

	local var_39_0 = var_1_10001.GetGraphApiSaveValue()
	local var_39_1 = ""

	if var_39_0 == 0 then
		var_39_1 = " 当前未设置，Unity自己选择。"
	elseif var_39_0 == 1 then
		var_39_1 = " 当前强制设置Vulkan。"
	elseif var_39_0 == 2 then
		var_39_1 = " 当前强制设置GLES。"
	end

	local var_39_2 = {
		go = "btn_gles",
		text = "设置为OpenGLES(需要重启)" .. var_39_1,
		func = function()
			GraphApiHelper = var_2_10000

			local var_40_0 = var_2_10000.SetForceGraphApi

			GraphApiHelper = var_2_10001

			var_40_0(var_2_10001.Api.Force_OpenGLES)

			return
		end
	}

	arg_39_0:createBtn(var_39_2)

	return
end

function var_0_1.btn_show_api(arg_41_0)
	local var_41_0 = {
		go = "btn_show_api",
		text = "点击显示当前Api",
		func = function()
			GraphApiHelper = var_2_10000

			local var_42_0 = var_2_10000.GetCurGraphApi()

			pg = var_2_10001

			local var_42_1 = var_2_10001.TipsMgr.GetInstance()

			var_1.ShowTips(var_42_1, "当前Api:" .. var_42_0)

			return
		end
	}

	arg_41_0:createBtn(var_41_0)

	return
end

return var_0_1
