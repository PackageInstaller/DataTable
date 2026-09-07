local SettingsDownloadableBtn = class("SettingsDownloadableBtn")

function SettingsDownloadableBtn:InitTpl(arg_1_1)
	self._tf = cloneTplTo(arg_1_1.tpl, arg_1_1.container, self:GetDownloadGroup())
	self._go = self._tf.gameObject

	setImageSprite(self._tf:Find("icon"), arg_1_1.iconSP)

	return
end

function SettingsDownloadableBtn:Ctor(arg_2_1)
	self:InitTpl(arg_2_1)
	pg.DelegateInfo.New(self)

	self.loadProgress = findTF(self._tf, "progress")
	self.loadProgressHandle = findTF(self._tf, "progress/handle")
	self.loadInfo1 = findTF(self._tf, "status")
	self.loadInfo2 = findTF(self._tf, "version")
	self.loadLabelNew = findTF(self._tf, "version/new")
	self.loadDot = findTF(self._tf, "new")
	self.loadLoading = findTF(self._tf, "loading")

	setText(self._tf:Find("title"), self:GetTitle())

	local var_2_0 = arg_2_1.isDel or false

	self.delBtn = findTF(self._tf, "DelBtn")

	setActive(self.delBtn, var_2_0)
	setText(self.delBtn:Find("Text"), i18n("resource_clear_generaltext"))
	setActive(self._tf:Find("BG"), not var_2_0)
	setActive(self._tf:Find("BGDel"), var_2_0)

	local var_2_1 = self._tf:Find("version")

	setAnchoredPosition(self._tf:Find("status"), var_2_0 and {
		y = -106
	} or {
		y = -135
	})
	setAnchoredPosition(var_2_1, var_2_0 and {
		y = -160
	} or {
		y = -198
	})
	self:Init()
	self:InitPrefsBar()

	return
end

function SettingsDownloadableBtn:Init()
	setSlider(self.loadProgress, 0, 1, 0)
	setActive(self.loadDot, false)
	setActive(self.loadLoading, false)
	onButton(self, self._tf, function()
		if Live2dConst.GetLive2DArm32MatchAble() then
			Live2dConst.ShowLive2DArm32Tips()

			return
		end

		local var_4_0 = self:GetDownloadGroup()

		if self:isNeedUpdate() and pg.SettingsGroupMgr.GetInstance():GetState(var_4_0) ~= pg.SettingsGroupMgr.State.Updating then
			local var_4_1 = {
				var_4_0
			}

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_NORMAL,
				content = string.format(i18n("group_download_tip", (HashUtil.BytesToString((pg.SettingsGroupMgr.GetInstance():GetTotalSize(var_4_1)))))),
				onYes = function()
					pg.SettingsGroupMgr.GetInstance():StartDownload(var_4_0, var_4_1)

					return
				end
			})
		end

		return
	end, SFX_PANEL)

	if isActive(self.delBtn) then
		onButton(self, self.delBtn, function()
			local var_6_0 = self:GetDownloadGroup()

			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_CONFIRM,
				content = i18n(self:getDelTipName(), (HashUtil.BytesToString(GroupHelper.GetGroupMgrByName(var_6_0):GetAllCacheFileSize()))),
				onYes = function()
					GroupHelper.SetGroupPrefsByName(var_6_0, DMFileChecker.Prefs.Min)

					local var_7_0 = HotfixHelper.GetAllShortPathArrInGroup(var_6_0)

					if var_7_0 and var_7_0.Length > 0 then
						HotfixHelper.DeleteFileByShortPathArr(var_6_0, var_7_0)
					end

					return
				end
			})

			return
		end, SFX_PANEL)
	end

	self:Check()

	return
end

function SettingsDownloadableBtn:InitPrefsBar()
	self.prefsBar = findTF(self._tf, "PrefsBar")

	setText(findTF(self.prefsBar, "Text"), i18n("setting_group_prefs_tip"))
	setActive(self.prefsBar, true)

	local var_8_0 = self:GetDownloadGroup()

	self.hideTip = true

	onToggle(self, self.prefsBar, function(arg_9_0)
		if Live2dConst.GetLive2DArm32MatchAble() then
			if arg_9_0 then
				Live2dConst.ShowLive2DArm32Tips()
				triggerToggle(self.prefsBar, false)
			end

			return
		end

		if arg_9_0 == true then
			GroupHelper.SetGroupPrefsByName(var_8_0, DMFileChecker.Prefs.Max)
		else
			GroupHelper.SetGroupPrefsByName(var_8_0, DMFileChecker.Prefs.Min)
		end

		if not self.hideTip then
			pg.TipsMgr.GetInstance():ShowTips(i18n("group_prefs_switch_tip"))
		end

		return
	end, SFX_PANEL)
	triggerToggle(self.prefsBar, GroupHelper.GetGroupPrefsByName(var_8_0) == DMFileChecker.Prefs.Max)

	self.hideTip = false

	return
end

function SettingsDownloadableBtn:Check()
	self.timer = Timer.New(function()
		self:UpdateDownLoadState()

		return
	end, 0.5, -1)

	self.timer:Start()
	self:UpdateDownLoadState()

	return
end

function SettingsDownloadableBtn:UpdateDownLoadState()
	local var_12_0 = self:GetDownloadGroup()
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

	setText(self.loadInfo1, var_12_3)
	setText(self.loadInfo2, var_12_4)
	setSlider(self.loadProgress, 0, 1, var_12_5)
	setActive(self.loadProgressHandle, var_12_5 ~= 0 and var_12_5 ~= 1)
	setActive(self.loadDot, var_12_6)
	setActive(self.loadLoading, var_12_7)
	setActive(self.loadLabelNew, var_12_9 < var_12_11)

	return
end

function SettingsDownloadableBtn:Dispose()
	pg.DelegateInfo.Dispose(self)

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function SettingsDownloadableBtn:GetDownloadGroup()
	assert(false, "overwrite me !!!")

	return
end

function SettingsDownloadableBtn:GetTitle()
	assert(false, "overwrite me !!!")

	return
end

function SettingsDownloadableBtn:isNeedUpdate()
	if IsUnityEditor then
		return false
	end

	local var_16_0 = BundleWizard.Inst:GetGroupMgr((self:GetDownloadGroup()))

	return tonumber(var_16_0.localVersion.Build) < tonumber(var_16_0.serverVersion.Build)
end

function SettingsDownloadableBtn:getDelTipName()
	return ({
		DORM = "resource_clear_3ddorm",
		MANGA = "resource_clear_manga",
		GALLERY_PIC = "resource_clear_gallery",
		MAP = "resource_clear_3disland"
	})[self:GetDownloadGroup()]
end

return SettingsDownloadableBtn
