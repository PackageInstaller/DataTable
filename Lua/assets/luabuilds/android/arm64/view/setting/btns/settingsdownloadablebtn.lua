local var_0_0 = class("SettingsDownloadableBtn")

function var_0_0.InitTpl(arg_1_0, arg_1_1)
	arg_1_0._tf = cloneTplTo(arg_1_1.tpl, arg_1_1.container, arg_1_0:GetDownloadGroup())
	arg_1_0._go = arg_1_0._tf.gameObject

	setImageSprite(arg_1_0._tf:Find("icon"), arg_1_1.iconSP)

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0:InitTpl(arg_2_1)
	pg.DelegateInfo.New(arg_2_0)

	arg_2_0.loadProgress = findTF(arg_2_0._tf, "progress")
	arg_2_0.loadProgressHandle = findTF(arg_2_0._tf, "progress/handle")
	arg_2_0.loadInfo1 = findTF(arg_2_0._tf, "status")
	arg_2_0.loadInfo2 = findTF(arg_2_0._tf, "version")
	arg_2_0.loadLabelNew = findTF(arg_2_0._tf, "version/new")
	arg_2_0.loadDot = findTF(arg_2_0._tf, "new")
	arg_2_0.loadLoading = findTF(arg_2_0._tf, "loading")

	setText(arg_2_0._tf:Find("title"), arg_2_0:GetTitle())

	local var_2_0 = arg_2_1.isDel or false

	arg_2_0.delBtn = findTF(arg_2_0._tf, "DelBtn")

	setActive(arg_2_0.delBtn, var_2_0)
	setText(arg_2_0.delBtn:Find("Text"), i18n("resource_clear_generaltext"))
	setActive(arg_2_0._tf:Find("BG"), not var_2_0)
	setActive(arg_2_0._tf:Find("BGDel"), var_2_0)

	local var_2_1 = arg_2_0._tf:Find("version")
	local var_2_3 = arg_2_0._tf:Find("status")

	if var_2_0 then
		local var_2_4 = {
			y = -106
		}

		if not {
			y = -106
		} then
			var_2_4 = {
				y = -135
			}
		end

		var_2_2(var_2_3, var_2_4)

		local var_2_6 = var_2_1

		if var_2_0 then
			local var_2_7 = {
				y = -160
			}

			if not {
				y = -160
			} then
				var_2_7 = {
					y = -198
				}
			end

			var_2_5(var_2_6, var_2_7)
			arg_2_0:Init()
			arg_2_0:InitPrefsBar()

			return
		end
	end
end

function var_0_0.Init(arg_3_0)
	setSlider(arg_3_0.loadProgress, 0, 1, 0)
	setActive(arg_3_0.loadDot, false)
	setActive(arg_3_0.loadLoading, false)
	onButton(arg_3_0, arg_3_0._tf, function()
		local var_4_9000

		if Live2dConst.GetLive2DArm32MatchAble() then
			Live2dConst.ShowLive2DArm32Tips()

			return
		end

		local var_4_0 = arg_3_0:GetDownloadGroup()

		if arg_3_0:isNeedUpdate() and pg.SettingsGroupMgr.GetInstance():GetState(var_4_0) ~= pg.SettingsGroupMgr.State.Updating then
			local var_4_1 = pg.SettingsGroupMgr.GetInstance()

			pg.MsgboxMgr.GetInstance().ShowMsgBox(var_4_1, {
				type = MSGBOX_TYPE_NORMAL,
				content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((var_4_1.GetTotalSize(var_4_9000, {
					var_4_0
				})))))),
				onYes = function()
					pg.SettingsGroupMgr.GetInstance():StartDownload(var_4_0, var_0)

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	if isActive(arg_3_0.delBtn) then
		onButton(arg_3_0, arg_3_0.delBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_CONFIRM,
				content = i18n(arg_3_0:getDelTipName(), (HashUtil.BytesToString(GroupHelper.GetGroupMgrByName((arg_3_0:GetDownloadGroup())):GetAllCacheFileSize()))),
				onYes = function()
					GroupHelper.SetGroupPrefsByName(var_0, DMFileChecker.Prefs.Min)

					local var_7_0 = HotfixHelper.GetAllShortPathArrInGroup(var_0)

					if var_7_0 and var_7_0.Length > 0 then
						HotfixHelper.DeleteFileByShortPathArr(var_0, var_7_0)
					end

					return
				end
			})

			return
		end, SFX_PANEL)
	end

	arg_3_0:Check()

	return
end

function var_0_0.InitPrefsBar(arg_8_0)
	arg_8_0.prefsBar = findTF(arg_8_0._tf, "PrefsBar")

	setText(findTF(arg_8_0.prefsBar, "Text"), i18n("setting_group_prefs_tip"))
	setActive(arg_8_0.prefsBar, true)

	local var_8_0 = arg_8_0:GetDownloadGroup()

	arg_8_0.hideTip = true

	onToggle(arg_8_0, arg_8_0.prefsBar, function(arg_9_0)
		if Live2dConst.GetLive2DArm32MatchAble() then
			if arg_9_0 then
				Live2dConst.ShowLive2DArm32Tips()
				triggerToggle(arg_8_0.prefsBar, false)
			end

			return
		end

		if arg_9_0 == true then
			GroupHelper.SetGroupPrefsByName(var_8_0, DMFileChecker.Prefs.Max)
		else
			GroupHelper.SetGroupPrefsByName(var_8_0, DMFileChecker.Prefs.Min)
		end

		if not arg_8_0.hideTip then
			pg.TipsMgr.GetInstance():ShowTips(i18n("group_prefs_switch_tip"))
		end

		return
	end, SFX_PANEL)
	triggerToggle(arg_8_0.prefsBar, GroupHelper.GetGroupPrefsByName(var_8_0) == DMFileChecker.Prefs.Max)

	arg_8_0.hideTip = false

	return
end

function var_0_0.Check(arg_10_0)
	arg_10_0.timer = Timer.New(function()
		arg_10_0:UpdateDownLoadState()

		return
	end, 0.5, -1)

	arg_10_0.timer:Start()
	arg_10_0:UpdateDownLoadState()

	return
end

function var_0_0.UpdateDownLoadState(arg_12_0)
	local var_12_0 = arg_12_0:GetDownloadGroup()
	local var_12_1 = BundleWizard.Inst:GetGroupMgr(var_12_0)
	local var_12_3
	local var_12_4
	local var_12_5
	local var_12_6
	local var_12_7 = false
	local var_12_8 = pg.SettingsGroupMgr.GetInstance():GetState(var_12_0)
	local var_12_9
	local var_12_11

	if IsUnityEditor then
		var_12_9 = 1
		var_12_11 = 1
	else
		var_12_9 = tonumber(var_12_1.localVersion.Build)
		var_12_11 = tonumber(var_12_1.serverVersion.Build)
	end

	if var_12_8 == pg.SettingsGroupMgr.State.None then
		if var_12_9 < var_12_11 then
			var_12_3 = i18n("word_maingroup_checktoupdate")
			var_12_4 = string.format("V.%d > V.%d", var_12_9, var_12_11)
			var_12_6 = true
		else
			var_12_3 = i18n("word_maingroup_updatesuccess")
			var_12_4 = string.format("V.%d", var_12_1.CurrentVersion.Build)
			var_12_6 = false
		end

		var_12_5 = 0
		var_12_7 = false
	elseif var_12_8 == pg.SettingsGroupMgr.State.Updating then
		local var_12_12, var_12_13 = pg.SettingsGroupMgr.GetInstance():GetCountProgress(var_12_0)

		var_12_3 = i18n("word_maingroup_updating")
		var_12_4 = string.format("(%d/%d)", var_12_12, var_12_13)
		var_12_5 = var_12_12 / math.max(var_12_13, 1)
		var_12_6 = false
		var_12_7 = true
	elseif var_12_8 == pg.SettingsGroupMgr.State.Success then
		var_12_3 = i18n("word_maingroup_updatesuccess")
		var_12_4 = "V." .. var_12_1.CurrentVersion.Build
		var_12_5 = 1
		var_12_6 = false
		var_12_7 = false
	elseif var_12_8 == pg.SettingsGroupMgr.State.Fail then
		var_12_3 = i18n("word_maingroup_updatefailure")
		var_12_4 = var_12_9 < var_12_11 and string.format("V.%d > V.%d", var_12_9, var_12_11) or string.format("V.%d", var_12_1.CurrentVersion.Build)
		var_12_5 = 0
		var_12_6 = true
		var_12_7 = false
	end

	setText(arg_12_0.loadInfo1, var_12_3)
	setText(arg_12_0.loadInfo2, var_12_4)
	setSlider(arg_12_0.loadProgress, 0, 1, var_12_5)
	setActive(arg_12_0.loadProgressHandle, var_12_5 ~= 0 and var_12_5 ~= 1)
	setActive(arg_12_0.loadDot, var_12_6)
	setActive(arg_12_0.loadLoading, var_12_7)
	setActive(arg_12_0.loadLabelNew, var_12_9 < var_12_11)

	return
end

function var_0_0.Dispose(arg_13_0)
	pg.DelegateInfo.Dispose(arg_13_0)

	if arg_13_0.timer then
		arg_13_0.timer:Stop()

		arg_13_0.timer = nil
	end

	return
end

function var_0_0.GetDownloadGroup(arg_14_0)
	assert(false, "overwrite me !!!")

	return
end

function var_0_0.GetTitle(arg_15_0)
	assert(false, "overwrite me !!!")

	return
end

function var_0_0.isNeedUpdate(arg_16_0)
	if IsUnityEditor then
		return false
	end

	local var_16_0 = BundleWizard.Inst:GetGroupMgr((arg_16_0:GetDownloadGroup()))

	return tonumber(var_16_0.localVersion.Build) < tonumber(var_16_0.serverVersion.Build)
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
