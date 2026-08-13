class = var_0_10000

local var_0_0 = var_0_10000("SettingsMainGroupBtn")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	pg = var_1_10002

	var_1_10002.DelegateInfo.New(arg_1_0)
	arg_1_0:initData()
	arg_1_0:findUI(arg_1_1)
	arg_1_0:addListener()
	arg_1_0:check()

	return
end

function var_0_0.Dispose(arg_2_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_2_0)

	if arg_2_0.timer then
		local var_2_0 = arg_2_0.timer

		var_1.Stop(var_2_0)

		arg_2_0.timer = nil
	end

	return
end

function var_0_0.initData(arg_3_0)
	pg = var_1_10001
	arg_3_0.mgr = var_1_10001.SettingsGroupMgr.GetInstance()
	arg_3_0.infoName = "MainGroup"

	local var_3_0 = {}

	PaintingGroupConst = var_1_10002
	var_3_0[1] = var_1_10002.PaintingGroupName
	arg_3_0.groupNameList = var_3_0

	return
end

function var_0_0.findUI(arg_4_0, arg_4_1)
	arg_4_0._tf = arg_4_1
	findTF = var_1_10002

	local var_4_0 = var_1_10002(arg_4_0._tf, "Content")

	findTF = var_1_10003
	arg_4_0.titleText = var_1_10003(var_4_0, "Title")
	findTF = var_3
	arg_4_0.progressBar = var_3(var_4_0, "Progress")
	findTF = var_3
	arg_4_0.btn = var_3(var_4_0, "Btn")
	findTF = var_3
	arg_4_0.btnText = var_3(arg_4_0.btn, "Text")
	findTF = var_3
	arg_4_0.loadingIcon = var_3(var_4_0, "Status/Loading")
	findTF = var_3
	arg_4_0.newIcon = var_3(var_4_0, "Status/New")
	findTF = var_3
	arg_4_0.finishIcon = var_3(var_4_0, "Status/Finish")
	setText = var_3

	local var_4_1 = arg_4_0.titleText

	i18n = var_6

	var_3(var_4_1, var_6("setting_resdownload_title_main_group"))

	return
end

function var_0_0.addListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0._tf

	local function var_5_2()
		local var_6_0 = arg_5_0.mgr
		local var_6_1 = var_0.GetState(var_6_0, arg_5_0.infoName)

		pg = var_2_10001

		if var_6_1 ~= var_2_10001.SettingsGroupMgr.State.Updating then
			local var_6_2 = arg_5_0.mgr
			local var_6_3 = var_1.GetTotalSize(var_6_2, arg_5_0.groupNameList)

			HashUtil = var_6_0

			local var_6_4 = var_6_0.BytesToString(var_6_3)

			pg = var_6_2

			local var_6_5 = var_6_2.MsgboxMgr.GetInstance()
			local var_6_6 = var_3.ShowMsgBox
			local var_6_7 = {}

			MSGBOX_TYPE_NORMAL = var_2_10007
			var_6_7.type = var_2_10007
			string = var_2_10007

			local var_6_8 = var_2_10007.format

			i18n = var_2_10009
			var_6_7.content = var_6_8(var_2_10009("main_group_msgbox_content", var_6_4))

			function var_6_7.onYes()
				GroupMainHelper = var_3_10000

				local var_7_0 = var_3_10000.SavePrefs

				DMFileChecker = var_3_10002

				var_7_0(var_3_10002.Prefs.Max)

				local var_7_1 = arg_5_0.mgr

				var_0.StartDownload(var_7_1, arg_5_0.infoName, arg_5_0.groupNameList)

				return
			end

			var_6_6(var_6_5, var_6_7)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	return
end

function var_0_0.check(arg_8_0)
	Timer = var_1_10001
	arg_8_0.timer = var_1_10001.New(function()
		local var_9_0 = arg_8_0

		var_0.updateUI(var_9_0)

		return
	end, 0.5, -1)

	local var_8_0 = arg_8_0.timer

	var_1.Start(var_8_0)
	arg_8_0:updateUI()

	return
end

function var_0_0.updateUI(arg_10_0)
	local var_10_0 = arg_10_0.mgr
	local var_10_1 = var_1.GetState(var_10_0, arg_10_0.infoName)

	pg = var_1_10002

	if var_10_1 == var_1_10002.SettingsGroupMgr.State.None then
		setText = var_2

		local var_10_2 = arg_10_0.btnText

		i18n = var_1_10005

		var_2(var_10_2, var_1_10005("word_maingroup_checktoupdate"))

		setActive = var_2

		var_2(arg_10_0.loadingIcon, false)

		setActive = var_2

		var_2(arg_10_0.newIcon, true)

		setActive = var_2

		var_2(arg_10_0.finishIcon, false)
	else
		pg = var_2

		local var_10_5

		if var_10_1 == var_2.SettingsGroupMgr.State.Updating then
			setText = var_10_5

			local var_10_3 = arg_10_0.btnText

			i18n = var_1_10005

			var_10_5(var_10_3, var_1_10005("word_maingroup_updating"))

			setActive = var_10_5

			var_10_5(arg_10_0.loadingIcon, true)

			setActive = var_10_5

			var_10_5(arg_10_0.newIcon, false)

			setActive = var_10_5

			var_10_5(arg_10_0.finishIcon, false)

			local var_10_4 = arg_10_0.mgr
			local var_10_6

			var_10_5, var_10_6 = var_10_5.GetCountProgress(var_10_4, arg_10_0.infoName)
			setSlider = var_10_4

			var_10_4(arg_10_0.progressBar, 0, var_10_6, var_10_5)

			setText = var_10_4

			var_10_4(arg_10_0.btnText, var_10_5 .. "/" .. var_10_6)
		else
			pg = var_10_5

			if var_10_1 == var_10_5.SettingsGroupMgr.State.Success then
				setText = var_2

				local var_10_7 = arg_10_0.btnText

				i18n = var_1_10005

				var_2(var_10_7, var_1_10005("word_maingroup_updatesuccess"))

				setActive = var_2

				var_2(arg_10_0.loadingIcon, false)

				setActive = var_2

				var_2(arg_10_0.newIcon, false)

				setActive = var_2

				var_2(arg_10_0.finishIcon, true)
			else
				pg = var_2

				if var_10_1 == var_2.SettingsGroupMgr.State.Fail then
					setText = var_2

					local var_10_8 = arg_10_0.btnText

					i18n = var_1_10005

					var_2(var_10_8, var_1_10005("word_maingroup_updatefailure"))

					setActive = var_2

					var_2(arg_10_0.loadingIcon, false)

					setActive = var_2

					var_2(arg_10_0.newIcon, false)

					setActive = var_2

					var_2(arg_10_0.finishIcon, false)
				end
			end
		end
	end

	return
end

return var_0_0
