class = var_0_10000

local var_0_0 = var_0_10000("SettingsDownloadableBtn")

function var_0_0.InitTpl(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.tpl
	local var_1_1 = arg_1_1.container
	local var_1_2 = arg_1_1.iconSP

	cloneTplTo = var_1_10005
	arg_1_0._tf = var_1_10005(var_1_0, var_1_1, arg_1_0:GetDownloadGroup())
	arg_1_0._go = arg_1_0._tf.gameObject
	setImageSprite = var_5

	local var_1_3 = arg_1_0._tf

	var_5(var_7.Find(var_1_3, "icon"), var_1_2)

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0:InitTpl(arg_2_1)

	pg = var_2

	var_2.DelegateInfo.New(arg_2_0)

	findTF = var_2
	arg_2_0.loadProgress = var_2(arg_2_0._tf, "progress")
	findTF = var_2
	arg_2_0.loadProgressHandle = var_2(arg_2_0._tf, "progress/handle")
	findTF = var_2
	arg_2_0.loadInfo1 = var_2(arg_2_0._tf, "status")
	findTF = var_2
	arg_2_0.loadInfo2 = var_2(arg_2_0._tf, "version")
	findTF = var_2
	arg_2_0.loadLabelNew = var_2(arg_2_0._tf, "version/new")
	findTF = var_2
	arg_2_0.loadDot = var_2(arg_2_0._tf, "new")
	findTF = var_2
	arg_2_0.loadLoading = var_2(arg_2_0._tf, "loading")
	setText = var_2

	local var_2_0 = arg_2_0._tf
	local var_2_1 = var_4.Find(var_2_0, "title")
	local var_2_2 = arg_2_0

	var_2(var_2_1, arg_2_0.GetTitle(var_2_2))

	local var_2_3

	if not arg_2_1.isDel then
		var_2_3 = false
	end

	findTF = var_1_10003
	arg_2_0.delBtn = var_1_10003(arg_2_0._tf, "DelBtn")
	setActive = var_3

	var_3(arg_2_0.delBtn, var_2_3)

	local var_2_4 = arg_2_0.delBtn
	local var_2_5

	var_2_5, setText = var_3.Find(var_2_4, "Text"), var_2_1
	i18n = var_2_2

	var_2_1(var_2_5, var_2_2("resource_clear_generaltext"))

	local var_2_6 = arg_2_0._tf
	local var_2_7 = var_4.Find(var_2_6, "BG")
	local var_2_8 = arg_2_0._tf
	local var_2_9 = var_5.Find(var_2_8, "BGDel")

	setActive = var_2_6

	var_2_6(var_2_7, not var_2_3)

	setActive = var_2_6

	var_2_6(var_2_9, var_2_3)

	local var_2_10 = arg_2_0._tf
	local var_2_11 = var_6.Find(var_2_10, "status")
	local var_2_12 = arg_2_0._tf
	local var_2_13 = var_7.Find(var_2_12, "version")

	setAnchoredPosition = var_2_10

	local var_2_14 = var_2_11
	local var_2_15

	if not var_2_3 or not {
		y = -106
	} then
		var_2_15 = {
			y = -135
		}
	end

	var_2_10(var_2_14, var_2_15)

	setAnchoredPosition = var_2_10

	local var_2_16 = var_2_13
	local var_2_17

	if not var_2_3 or not {
		y = -160
	} then
		var_2_17 = {
			y = -198
		}
	end

	var_2_10(var_2_16, var_2_17)
	arg_2_0:Init()
	arg_2_0:InitPrefsBar()

	return
end

function var_0_0.Init(arg_3_0)
	setSlider = var_1_10001

	var_1_10001(arg_3_0.loadProgress, 0, 1, 0)

	setActive = var_1_10001

	var_1_10001(arg_3_0.loadDot, false)

	setActive = var_1_10001

	var_1_10001(arg_3_0.loadLoading, false)

	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		Live2dConst = var_2_10000

		if var_2_10000.GetLive2DArm32MatchAble() then
			Live2dConst = var_0

			var_0.ShowLive2DArm32Tips()

			return
		end

		local var_4_0 = arg_3_0
		local var_4_1 = var_0.GetDownloadGroup(var_4_0)

		pg = var_2_10001

		local var_4_2 = var_2_10001.SettingsGroupMgr.GetInstance()
		local var_4_3 = var_1.GetState(var_4_2, var_4_1)
		local var_4_4 = arg_3_0

		if var_2.isNeedUpdate(var_4_4) then
			pg = var_2

			if var_4_3 ~= var_2.SettingsGroupMgr.State.Updating then
				local var_4_5 = {
					var_4_1
				}

				pg = var_4_2

				local var_4_6 = var_4_2.SettingsGroupMgr.GetInstance()
				local var_4_7 = var_3.GetTotalSize(var_4_6, var_4_5)

				HashUtil = var_4_4

				local var_4_8 = var_4_4.BytesToString(var_4_7)

				pg = var_4_6

				local var_4_9 = var_4_6.MsgboxMgr.GetInstance()
				local var_4_10 = var_5.ShowMsgBox
				local var_4_11 = {}

				MSGBOX_TYPE_NORMAL = var_2_10009
				var_4_11.type = var_2_10009
				string = var_2_10009

				local var_4_12 = var_2_10009.format

				i18n = var_2_10011
				var_4_11.content = var_4_12(var_2_10011("group_download_tip", var_4_8))

				function var_4_11.onYes()
					pg = var_3_10000

					local var_5_0 = var_3_10000.SettingsGroupMgr.GetInstance()

					var_0.StartDownload(var_5_0, var_4_1, var_4_5)

					return
				end

				var_4_10(var_4_9, var_4_11)
			end
		end

		return
	end

	SFX_PANEL = var_6

	var_1_10001(var_3_0, var_3_1, var_3_2, var_6)

	isActive = var_1_10001

	if var_1_10001(arg_3_0.delBtn) then
		onButton = var_1

		local var_3_3 = arg_3_0
		local var_3_4 = arg_3_0.delBtn

		local function var_3_5()
			local var_6_0 = arg_3_0
			local var_6_1 = var_0.GetDownloadGroup(var_6_0)

			GroupHelper = var_2_10001

			local var_6_2 = var_2_10001.GetGroupMgrByName(var_6_1)

			HashUtil = var_6_0

			local var_6_3 = var_6_0.BytesToString(var_6_2:GetAllCacheFileSize())
			local var_6_4 = arg_3_0
			local var_6_5 = var_3.getDelTipName(var_6_4)

			i18n = var_4

			local var_6_6 = var_4(var_6_5, var_6_3)

			pg = var_6_4

			local var_6_7 = var_6_4.MsgboxMgr.GetInstance()
			local var_6_8 = var_5.ShowMsgBox
			local var_6_9 = {}

			MSGBOX_TYPE_CONFIRM = var_2_10009
			var_6_9.type = var_2_10009
			var_6_9.content = var_6_6

			function var_6_9.onYes()
				GroupHelper = var_3_10000

				local var_7_0 = var_3_10000.SetGroupPrefsByName
				local var_7_1 = var_6_1

				DMFileChecker = var_3_10003

				var_7_0(var_7_1, var_3_10003.Prefs.Min)

				HotfixHelper = var_7_0

				if var_7_0.GetAllShortPathArrInGroup(var_6_1) and var_0.Length > 0 then
					HotfixHelper = var_1

					var_1.DeleteFileByShortPathArr(var_6_1, var_0)
				end

				return
			end

			var_6_8(var_6_7, var_6_9)

			return
		end

		SFX_PANEL = var_6

		var_1(var_3_3, var_3_4, var_3_5, var_6)
	end

	arg_3_0:Check()

	return
end

function var_0_0.InitPrefsBar(arg_8_0)
	findTF = var_1_10001
	arg_8_0.prefsBar = var_1_10001(arg_8_0._tf, "PrefsBar")
	setText = var_1
	findTF = var_3

	local var_8_0 = var_3(arg_8_0.prefsBar, "Text")

	i18n = var_4

	var_1(var_8_0, var_4("setting_group_prefs_tip"))

	setActive = var_1

	var_1(arg_8_0.prefsBar, true)

	local var_8_1 = arg_8_0:GetDownloadGroup()

	arg_8_0.hideTip = true
	onToggle = var_2

	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.prefsBar

	local function var_8_4(arg_9_0)
		Live2dConst = var_2_10001

		if var_2_10001.GetLive2DArm32MatchAble() then
			if arg_9_0 then
				Live2dConst = var_9_0

				var_9_0.ShowLive2DArm32Tips()

				triggerToggle = var_9_0

				var_9_0(arg_8_0.prefsBar, false)
			end

			return
		end

		local var_9_0

		if arg_9_0 == true then
			GroupHelper = var_9_0
			var_9_0 = var_9_0.SetGroupPrefsByName

			local var_9_1 = var_8_1

			DMFileChecker = var_2_10004

			var_9_0(var_9_1, var_2_10004.Prefs.Max)
		else
			GroupHelper = var_9_0

			local var_9_2 = var_9_0.SetGroupPrefsByName
			local var_9_3 = var_8_1

			DMFileChecker = var_2_10004

			var_9_2(var_9_3, var_2_10004.Prefs.Min)
		end

		if not arg_8_0.hideTip then
			pg = var_1

			local var_9_4 = var_1.TipsMgr.GetInstance()
			local var_9_5 = var_1.ShowTips

			i18n = var_2_10004

			var_9_5(var_9_4, var_2_10004("group_prefs_switch_tip"))
		end

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_8_2, var_8_3, var_8_4, var_1_10007)

	triggerToggle = var_2

	local var_8_5 = arg_8_0.prefsBar

	GroupHelper = var_8_3

	local var_8_6 = var_8_3.GetGroupPrefsByName(var_8_1)

	DMFileChecker = var_8_4

	var_2(var_8_5, var_8_6 == var_8_4.Prefs.Max)

	arg_8_0.hideTip = false

	return
end

function var_0_0.Check(arg_10_0)
	Timer = var_1_10001
	arg_10_0.timer = var_1_10001.New(function()
		local var_11_0 = arg_10_0

		var_0.UpdateDownLoadState(var_11_0)

		return
	end, 0.5, -1)

	local var_10_0 = arg_10_0.timer

	var_1.Start(var_10_0)
	arg_10_0:UpdateDownLoadState()

	return
end

function var_0_0.UpdateDownLoadState(arg_12_0)
	local var_12_0 = arg_12_0:GetDownloadGroup()

	BundleWizard = var_1_10002

	local var_12_1 = var_1_10002.Inst
	local var_12_2 = var_2.GetGroupMgr(var_12_1, var_12_0)
	local var_12_3
	local var_12_4
	local var_12_5
	local var_12_6
	local var_12_7
	local var_12_8 = false

	pg = var_1_10009

	local var_12_9 = var_1_10009.SettingsGroupMgr.GetInstance()
	local var_12_10 = var_9.GetState(var_12_9, var_12_0)
	local var_12_11
	local var_12_12

	IsUnityEditor = var_12

	if var_12 then
		var_12_11 = 1
		var_12_12 = 1
	else
		tonumber = var_12
		var_12_11 = var_12(var_12_2.localVersion.Build)
		tonumber = var_12
		var_12_12 = var_12(var_12_2.serverVersion.Build)
	end

	pg = var_12

	local var_12_14

	if var_12_10 == var_12.SettingsGroupMgr.State.None then
		if var_12_11 < var_12_12 then
			i18n = var_12_14
			var_12_4 = var_12_14("word_maingroup_checktoupdate")
			string = var_12_14
			var_12_5 = var_12_14.format("V.%d > V.%d", var_12_11, var_12_12)
			var_12_7 = true
		else
			i18n = var_12_14
			var_12_4 = var_12_14("word_maingroup_updatesuccess")
			string = var_12_14
			var_12_5 = var_12_14.format("V.%d", var_12_2.CurrentVersion.Build)
			var_12_7 = false
		end

		var_12_6 = 0
		var_12_8 = false
	else
		pg = var_12_14

		if var_12_10 == var_12_14.SettingsGroupMgr.State.Updating then
			pg = var_12_14

			local var_12_13 = var_12_14.SettingsGroupMgr.GetInstance()
			local var_12_15

			var_12_14, var_12_15 = var_12_14.GetCountProgress(var_12_13, var_12_0)
			i18n = var_12_13
			var_12_4 = var_12_13("word_maingroup_updating")
			string = var_14
			var_12_5 = var_14.format("(%d/%d)", var_12_14, var_12_15)
			math = var_14
			var_12_6 = var_12_14 / var_14.max(var_12_15, 1)
			var_12_7 = false
			var_12_8 = true
		else
			pg = var_12_14

			if var_12_10 == var_12_14.SettingsGroupMgr.State.Success then
				i18n = var_12_14
				var_12_4 = var_12_14("word_maingroup_updatesuccess")
				var_12_5 = "V." .. var_12_2.CurrentVersion.Build
				var_12_6 = 1
				var_12_7 = false
				var_12_8 = false
			else
				pg = var_12_14

				if var_12_10 == var_12_14.SettingsGroupMgr.State.Fail then
					i18n = var_12_14
					var_12_4 = var_12_14("word_maingroup_updatefailure")

					if var_12_11 < var_12_12 then
						string = var_12_14
						var_12_5 = var_12_14.format("V.%d > V.%d", var_12_11, var_12_12)
					else
						string = var_12_14
						var_12_5 = var_12_14.format("V.%d", var_12_2.CurrentVersion.Build)
					end

					var_12_6 = 0
					var_12_7 = true
					var_12_8 = false
				end
			end
		end
	end

	setText = var_12_14

	var_12_14(arg_12_0.loadInfo1, var_12_4)

	setText = var_12_14

	var_12_14(arg_12_0.loadInfo2, var_12_5)

	setSlider = var_12_14

	var_12_14(arg_12_0.loadProgress, 0, 1, var_12_6)

	setActive = var_12_14

	var_12_14(arg_12_0.loadProgressHandle, var_12_6 ~= 0 and var_12_6 ~= 1)

	setActive = var_12_14

	var_12_14(arg_12_0.loadDot, var_12_7)

	setActive = var_12_14

	var_12_14(arg_12_0.loadLoading, var_12_8)

	setActive = var_12_14

	var_12_14(arg_12_0.loadLabelNew, var_12_11 < var_12_12)

	return
end

function var_0_0.Dispose(arg_13_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_13_0)

	if arg_13_0.timer then
		local var_13_0 = arg_13_0.timer

		var_1.Stop(var_13_0)

		arg_13_0.timer = nil
	end

	return
end

function var_0_0.GetDownloadGroup(arg_14_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!")

	return
end

function var_0_0.GetTitle(arg_15_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me !!!")

	return
end

function var_0_0.isNeedUpdate(arg_16_0)
	IsUnityEditor = var_1_10001

	if var_1_10001 then
		return false
	end

	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.GetDownloadGroup(var_16_0)

	BundleWizard = var_1_10002

	local var_16_2 = var_1_10002.Inst
	local var_16_3 = var_2.GetGroupMgr(var_16_2, var_16_1)

	tonumber = var_16_0

	local var_16_4 = var_16_0(var_16_3.localVersion.Build)

	tonumber = var_16_2

	return var_16_4 < var_16_2(var_16_3.serverVersion.Build)
end

function var_0_0.getDelTipName(arg_17_0)
	return ({
		DORM = "resource_clear_3ddorm",
		MANGA = "resource_clear_manga",
		GALLERY_PIC = "resource_clear_gallery",
		MAP = "resource_clear_3disland"
	})[arg_17_0:GetDownloadGroup()]
end

return var_0_0
