local NewMainScene = class("NewMainScene", import("..base.BaseUI"))

NewMainScene.THEME_CLASSIC = 1
NewMainScene.THEME_MELLOW = 2
NewMainScene.OPEN_LIVEAREA = "NewMainScene.OPEN_LIVEAREA"
NewMainScene.UPDATE_COVER = "NewMainScene.UPDATE_COVER"
NewMainScene.FOLD = "NewMainScene.FOLD"
NewMainScene.HIDE = "NewMainScene.HIDE"
NewMainScene.CHAT_STATE_CHANGE = "NewMainScene.CHAT_STATE_CHANGE"
NewMainScene.ON_CHANGE_SKIN = "NewMainScene.ON_CHANGE_SKIN"
NewMainScene.ON_BUFF_DESC = "NewMainScene.ON_BUFF_DESC"
NewMainScene.ON_SKIN_FREEUSAGE_DESC = "NewMainScene.ON_SKIN_FREEUSAGE_DESC"
NewMainScene.ENABLE_PAITING_MOVE = "NewMainScene.ENABLE_PAITING_MOVE"
NewMainScene.ENABLE_PAITING_SCALE = "NewMainScene.ENABLE_PAITING_SCALE"
NewMainScene.SAVE_PART_SCALE = "NewMainScene.SAVE_PART_SCALE"
NewMainScene.RESET_PAITING_SCALE = "NewMainScene.RESET_PAITING_SCALE"
NewMainScene.SET_SCALE_PART_CONTENT = "NewMainScene.SET_SCALE_PART_CONTENT"
NewMainScene.ON_ENTER_DONE = "NewMainScene.ON_ENTER_DONE"
NewMainScene.ENTER_SILENT_VIEW = "NewMainScene.ENTER_SILENT_VIEW"
NewMainScene.EXIT_SILENT_VIEW = "NewMainScene.EXIT_SILENT_VIEW"
NewMainScene.L2D_BOUND_CHANGE = "NewMainScene.L2D_BOUND_CHANGE"
NewMainScene.RESET_L2D = "NewMainScene.RESET_L2D"

function NewMainScene:getUIName()
	return "NewMainUI"
end

function NewMainScene:getResource()
	return ResPathSupport.MergeLuaArr({
		"ui/newmainui",
		"commonbg/bg_main_night",
		"commonbg/bg_main_twilight",
		"commonbg/bg_main_day",
		"ui/mainbgview",
		"ui/lihui_qiehuan01",
		"ui/lihui_qiehuan02",
		"spinematerials",
		"effect/jiehuntexiao",
		"ui/mainuibuffdescwindow",
		"ui/maincalibrationui",
		"clutter/mainui_calibration",
		"clutter/mainui_calibration_mellow",
		"ui/mainsilentviewui",
		"ui/mainui_atlas",
		"ui/exskinlistui",
		"ui/mainliveareaoldui",
		"ui/mainliveareaui",
		"ui/livingareacoverui",
		"ui/newmainclassictheme",
		"clutter/mainui_calibration",
		"ui/mainui_atlas",
		"ui/newmainmellowtheme",
		"clutter/mainui_calibration_mellow",
		"ui/respanel",
		"ui/goldexchangewindow"
	}, (function()
		local var_3_0, var_3_1 = MainBGView.GetBgAndBgm()

		return (ResPathSupport.MergeLuaArr({}, ResPathSupport.GetSoundResList(var_3_1), (ResPathSupport.GetSoundResList((NewMainScene.super.getBGM(self))))))
	end)(), (function()
		local var_4_0, var_4_1 = MainBGView.GetBgAndBgm()

		return (ResPathSupport.MergeLuaArr({}, {
			ResPathSupport.CombinePath(ResPathSupport.ConstPath.BG.CommonBG, var_4_0)
		}))
	end)(), (function()
		local var_5_0 = {}
		local var_5_1 = getProxy(LivingAreaCoverProxy)
		local var_5_2 = ResPathSupport.ConstPath.UI.LivingAreaCover

		_.each(var_5_1:GetUnlockList(), function(arg_6_0)
			table.insert(var_5_0, ResPathSupport.CombinePath(var_5_2, (arg_6_0:GetIcon())))

			return
		end)
		_.each(var_5_1:GetLockList(), function(arg_7_0)
			table.insert(var_5_0, ResPathSupport.CombinePath(var_5_2, (arg_7_0:GetIcon())))

			return
		end)

		return var_5_0
	end)(), (function()
		local var_8_0 = {}

		_.each(getProxy(ActivityProxy):getBannerDisplays(), function(arg_9_0)
			table.insert(var_8_0, ResPathSupport.CombinePath(NewMainScene.ConstPath.UI.ActivityBanner, arg_9_0.pic))

			return
		end)

		return var_8_0
	end)(), (function()
		local var_10_0 = {}

		_.each(MainActivityBtnView.GetActivityBtnList(), function(arg_11_0)
			local var_11_0 = arg_11_0.New()
			local var_11_1 = var_11_0:ResPath()
			local var_11_2 = var_11_0:GetLinkConfig()

			if var_11_2 then
				if var_11_2.pic and #var_11_2.pic > 0 then
					table.insert(var_10_0, (string.lower((ResPathSupport.CombinePath(var_11_1, var_11_2.pic)))))
				end

				local var_11_3 = var_11_2.text_pic

				if var_11_2.text_pic and #var_11_3 > 0 then
					table.insert(var_10_0, (string.lower((ResPathSupport.CombinePath(var_11_1, var_11_3)))))
				end
			end

			local var_11_4 = ResPathSupport.ConstPath.UI.LinkButton
			local var_11_5 = var_11_0:GetTipImage()

			if var_11_5 and #var_11_5 > 0 then
				table.insert(var_10_0, (string.lower((ResPathSupport.CombinePath(var_11_4, var_11_5)))))
			end

			return
		end)
		_.each(MainActivityBtnView.GetSpecailBtns(), function(arg_12_0)
			local var_12_0 = arg_12_0.New():GetUIName()

			if var_12_0 and #var_12_0 > 0 then
				local var_12_1 = string.lower((ResPathSupport.CombinePath(ResPathSupport.ConstPath.UI.Base, var_12_0)))

				table.insert(var_10_0, var_12_1)
				table.insert(var_10_0, var_12_1 .. "4mellow")
			end

			return
		end)

		return var_10_0
	end)(), (function()
		local var_13_0 = {}

		_.each(MainBuffView.CollectBuffs(), function(arg_14_0)
			table.insert(var_13_0, (string.lower(arg_14_0:getConfig("icon"))))

			return
		end)

		return var_13_0
	end)(), ((function()
		local var_15_0 = {}
		local var_15_1 = getProxy(PlayerProxy):getData()

		for iter_15_0 = 1, PlayerVitaeShipsPage.GetAllUnlockSlotCnt() do
			table.insert(var_15_0, (ResPathSupport.GetShipAllRes((var_15_1:GetFlagShip()))))
		end

		return _.flatten(var_15_0)
	end)()))
end

function NewMainScene:needCache()
	return true
end

function NewMainScene:forceGC()
	return true
end

function NewMainScene:GetThemeStyle()
	return getProxy(SettingsProxy):GetMainSceneThemeStyle()
end

function NewMainScene:PlayBGM()
	return
end

function NewMainScene:GetFlagShip()
	return (getProxy(PlayerProxy):getRawData():GetFlagShip())
end

function NewMainScene:RevertAsmrShip()
	getProxy(BayProxy):ClearChangeSkinAsmr()

	return
end

function NewMainScene:PlayBgm(arg_22_1)
	local var_22_0
	local var_22_1

	if underscore.any({
		function()
			if arg_22_1:IsBgmSkin() then
				if getProxy(SettingsProxy):IsBGMEnable() then
					var_22_0 = arg_22_1:GetSkinBgm()
				end
			end

			return tobool(var_22_0)
		end,
		function()
			if getProxy(SettingsProxy):IsEnableMainMusicPlayer() then
				if getProxy(AppreciateProxy):CanPlayMainMusicPlayer() then
					var_22_0 = "MainMusicPlayer"

					local var_24_0 = {}

					var_24_0.loopType = getProxy(AppreciateProxy):getMusicPlayerLoopType()
					var_24_0.albumName = getProxy(AppreciateProxy):getMainPlayerAlbumName()
					var_22_1 = var_24_0
				end
			end

			return tobool(var_22_0)
		end,
		function()
			local var_25_0, var_25_1 = MainBGView.GetBgAndBgm()

			var_22_0 = var_25_1

			return tobool(var_22_0)
		end,
		function()
			var_22_0 = NewMainScene.super.getBGM(self)

			return tobool(var_22_0)
		end
	}, function(arg_27_0)
		return arg_27_0()
	end) then
		pg.BgmMgr.GetInstance():Push(self.__cname, nil, nil)
	end

	return
end

function NewMainScene:ResUISettings()
	return {
		showType = PlayerResUI.TYPE_ALL,
		anim = not self.resAnimFlag
	}
end

function NewMainScene:ShowOrHideResUI(arg_29_1)
	if not self.isInit then
		return
	end

	NewMainScene.super.ShowOrHideResUI(self, arg_29_1)

	return
end

function NewMainScene:init()
	self.mainCG = GetOrAddComponent(self._tf, typeof(CanvasGroup))
	self.bgView = MainBGView.New(self._tf:Find("Sea/bg"))
	self.paintingView = MainPaintingView.New(self._tf:Find("paint"), self._tf:Find("paintBg"), self.event)
	self.effectView = MainEffectView.New(self._tf:Find("paint/effect"))
	self.buffDescPage = MainBuffDescPage.New(self._tf, self.event)
	self.calibrationPage = MainCalibrationPage.New(self._tf, self.event, self.contextData)
	self.silentView = MainSilentView.New(self._tf, self.event, self.contextData)
	self.silentChecker = MainSilentChecker.New(self.event)
	self.skinExperienceDisplayPage = SkinExperienceDiplayPage.New(self._tf, self.event)
	self.liveAreaPage = USE_OLD_MAIN_LIVE_AREA_UI and MainLiveAreaOldPage.New(self._tf, self.event) or MainLiveAreaPage.New(self._tf, self.event)
	self.subMediator = MainReddotMediator.New()

	pg.m02:registerMediator(self.subMediator)

	self.sequenceView = MainSequenceView.New()
	self.awakeSequenceView = MainAwakeSequenceView.New()
	self.themes = {
		[NewMainScene.THEME_CLASSIC] = NewMainClassicTheme.New(self._tf, self.event, self.contextData),
		[NewMainScene.THEME_MELLOW] = NewMainMellowTheme.New(self._tf, self.event, self.contextData)
	}

	for iter_30_0, iter_30_1 in pairs(self.themes) do
		iter_30_1:RegisterView(self)
	end

	self:RevertAsmrShip()

	return
end

function NewMainScene:didEnter()
	self:bind(NewMainScene.FOLD, function(arg_32_0, arg_32_1)
		self:FoldPanels(arg_32_1)

		if not self.paintingView.ship then
			return
		end

		self.calibrationPage:ExecuteAction("ShowOrHide", arg_32_1, self.bgView.ship, self.theme:GetPaintingOffset(self.paintingView.ship), self.theme:GetCalibrationBG())

		return
	end)
	self:bind(NewMainScene.HIDE, function(arg_33_0, arg_33_1)
		self:HidePanel(arg_33_1)

		if not self.paintingView.ship then
			return
		end

		self.calibrationPage:ExecuteAction("ShowOrHide", arg_33_1, self.bgView.ship, self.theme:GetPaintingOffset(self.paintingView.ship), self.theme:GetCalibrationBG())

		return
	end)
	self:bind(NewMainScene.ON_CHANGE_SKIN, function(arg_34_0)
		self:SwitchToNextShip()

		return
	end)
	self:bind(NewMainScene.ENTER_SILENT_VIEW, function()
		self:ExitCalibrationView()
		self:FoldPanels(true)
		self.silentView:ExecuteAction("Show")

		return
	end)
	self:bind(GAME.WILL_LOGOUT, function()
		self:GameLogout()

		return
	end)
	self:bind(NewMainScene.EXIT_SILENT_VIEW, function()
		self:ExitSilentView()
		self:SetUpSilentChecker()

		return
	end)
	self:bind(NewMainScene.ON_SKIN_FREEUSAGE_DESC, function(arg_38_0, arg_38_1)
		self.skinExperienceDisplayPage:ExecuteAction("Show", arg_38_1)

		return
	end)
	self:bind(NewMainScene.OPEN_LIVEAREA, function(arg_39_0)
		self.liveAreaPage:ExecuteAction("Show")

		return
	end)
	self:bind(NewMainScene.L2D_BOUND_CHANGE, function(arg_40_0)
		self.paintingView:OnBoundChange()

		return
	end)
	self:SetUp(false, true)

	return
end

function NewMainScene:SetUp(arg_41_1, arg_41_2)
	self.mainCG.blocksRaycasts = false
	self.isInit = false
	self.resAnimFlag = false

	local var_41_0

	seriesAsync({
		function(arg_42_0)
			if self:CheckDebugBattleLoop() then
				return
			else
				arg_42_0()
			end

			return
		end,
		function(arg_43_0)
			self.awakeSequenceView:Execute(arg_43_0)

			return
		end,
		function(arg_44_0)
			var_41_0 = self:GetFlagShip()

			self.bgView:Init(var_41_0)
			onNextTick(arg_44_0)

			return
		end,
		function(arg_45_0)
			self.theme = self.themes[self:GetThemeStyle()]

			self.theme:ExecuteAction("Show", arg_45_0)

			return
		end,
		function(arg_46_0)
			onNextTick(arg_46_0)

			return
		end,
		function(arg_47_0)
			self.isInit = true

			self.theme:PlayEnterAnimation(var_41_0, arg_47_0)
			self.paintingView:Init(var_41_0, self.theme:GetPaintingOffset(var_41_0), arg_41_1)

			self.resAnimFlag = true

			return
		end,
		function(arg_48_0)
			self:PlayBgm(var_41_0)
			self.effectView:Init(var_41_0)
			self.theme:init(var_41_0)
			onNextTick(arg_48_0)

			return
		end,
		function(arg_49_0)
			self:ShowOrHideResUI(self.theme:ApplyDefaultResUI())
			self.sequenceView:Execute(arg_49_0)

			return
		end
	}, function()
		self:SetUpSilentChecker()
		self:emit(NewMainScene.ON_ENTER_DONE)

		self.mainCG.blocksRaycasts = true

		if arg_41_2 then
			gcAll()
		end

		return
	end)

	return
end

function NewMainScene:SetUpSilentChecker()
	self.defaultSleepTimeout = Screen.sleepTimeout
	Screen.sleepTimeout = getProxy(SettingsProxy):GetMainSceneScreenSleepTime()

	if SettingsMainScenePanel.IsEnableStandbyMode() then
		self.silentChecker:SetUp()
	end

	return
end

function NewMainScene:RevertSleepTimeout()
	if self.defaultSleepTimeout and Screen.sleepTimeout ~= self.defaultSleepTimeout then
		Screen.sleepTimeout = self.defaultSleepTimeout
	end

	self.defaultSleepTimeout = nil

	return
end

function NewMainScene:FoldPanels(arg_53_1)
	if not self.theme then
		return
	end

	self.foldFlag = arg_53_1

	self.theme:OnFoldPanels(arg_53_1)
	self.paintingView:Fold(arg_53_1, 0.5)
	pg.playerResUI:Fold(arg_53_1, 0.5)
	self:SetEffectPanelVisible(not arg_53_1)

	return
end

function NewMainScene:HidePanel(arg_54_1)
	if not self.theme then
		return
	end

	if self.foldFlag == arg_54_1 then
		return
	end

	self.foldFlag = arg_54_1

	self.theme:OnFoldPanels(arg_54_1)

	if self._asmrTurnning then
		if self.foldFlag == true then
			pg.playerResUI:Fold(arg_54_1, 0.5)
		end
	else
		pg.playerResUI:Fold(arg_54_1, 0.5)
	end

	if not arg_54_1 and self._asmrTurnning then
		self:SetEffectPanelVisible(false)
	else
		self:SetEffectPanelVisible(not arg_54_1)
	end

	return
end

function NewMainScene:AsmrTurning(arg_55_1)
	self._asmrTurnning = arg_55_1

	self.paintingView:OnAsmrTurnning(arg_55_1)
	self.theme:OnAsmrTurnning(arg_55_1)
	self.silentChecker:SetSilentRun(not arg_55_1)

	if not self._asmrTurnning then
		self:SetUpSilentChecker()
		pg.BgmMgr.GetInstance():ContinuePlay()
	else
		pg.BgmMgr.GetInstance():StopPlay()
	end

	return
end

function NewMainScene:SwitchToNextShip()
	if self.paintingView:IsLoading() or self.bgView:IsLoading() or not self.theme then
		return
	end

	local var_56_0 = getProxy(PlayerProxy):getRawData():GetNextFlagShip()

	if self.bgView.ship:getSkinId() ~= var_56_0:getSkinId() or self.bgView.ship.id ~= var_56_0.id then
		self.bgView:Refresh(var_56_0)
		self:PlayBgm(var_56_0)
		self.paintingView:Refresh(var_56_0, self.theme:GetPaintingOffset(var_56_0))
		self.effectView:Refresh(var_56_0)
		self.theme:OnSwitchToNextShip(var_56_0)
	end

	return
end

function NewMainScene:UpdateFlagShip(arg_57_1, arg_57_2)
	if self.paintingView:IsLoading() or self.bgView:IsLoading() or not self.theme then
		return
	end

	local var_57_0 = arg_57_2.callback

	self.bgView:Refresh(arg_57_1)
	self:PlayBgm(arg_57_1)
	self.paintingView:SetOnceLoadedCall(var_57_0)
	self.paintingView:Refresh(arg_57_1, self.theme:GetPaintingOffset(arg_57_1))
	self.effectView:Refresh(arg_57_1)
	self.theme:OnSwitchToNextShip(arg_57_1)

	return
end

function NewMainScene:CheckDebugBattleLoop()
	if not InDebugBattleLoop then
		return false
	end

	local var_58_0 = InDebugBattleLoop

	if #InDebugBattleLoop.tempList == 0 then
		if #var_58_0.loopStages > 0 then
			local var_58_1 = table.remove(var_58_0.loopStages, 1)

			for iter_58_0 = 1, var_58_0.loopCount do
				table.insert(var_58_0.tempList, var_58_1)
			end
		else
			InDebugBattleLoop = nil

			pg.TipsMgr.GetInstance():ShowTips("finish")

			return false
		end
	end

	local var_58_2 = table.remove(var_58_0.tempList, 1)

	print(string.format("【正在执行关卡%s的第%d次战斗循环】", var_58_2, var_58_0.loopCount - #var_58_0.tempList))
	self:emit(NewMainMediator.DEBUG_BATTLE_LOOP, var_58_2)

	return true
end

function NewMainScene:PlayChangeSkinActionOut(arg_59_1)
	self.paintingView:PlayChangeSkinActionOut(arg_59_1)

	return
end

function NewMainScene:PlayChangeSkinActionIn(arg_60_1)
	self.paintingView:PlayChangeSkinActionIn(arg_60_1)

	return
end

function NewMainScene:CheckAndReplayBgm()
	local var_61_0 = self:GetFlagShip()

	self.theme:Refresh(var_61_0)
	self:PlayBgm(var_61_0)

	return
end

function NewMainScene:SetEffectPanelVisible(arg_62_1)
	if self.theme then
		self.theme:SetEffectPanelVisible(arg_62_1)
	end

	return
end

function NewMainScene:OnVisible()
	self:RevertAsmrShip()

	if not (not self.theme or self.themes[self:GetThemeStyle()] ~= self.theme) then
		self:Refresh()
	else
		self:UnloadTheme()
		self:SetUp(true)
	end

	return
end

function NewMainScene:Refresh()
	self.mainCG.blocksRaycasts = false

	seriesAsync({
		function(arg_65_0)
			if self:CheckDebugBattleLoop() then
				return
			else
				arg_65_0()
			end

			return
		end,
		function(arg_66_0)
			self.awakeSequenceView:Execute(arg_66_0)

			return
		end,
		function(arg_67_0)
			self.isInit = true

			self:ShowOrHideResUI(self.theme:ApplyDefaultResUI())

			local var_67_0 = self:GetFlagShip()

			self.bgView:Refresh(var_67_0)
			self.paintingView:Refresh(var_67_0, self.theme:GetPaintingOffset(var_67_0))
			self.effectView:Refresh(var_67_0)
			self.theme:Refresh(var_67_0)
			self:PlayBgm(var_67_0)
			arg_67_0()

			return
		end,
		function(arg_68_0)
			self.sequenceView:Execute(arg_68_0)

			return
		end
	}, function()
		self:SetUpSilentChecker()
		self:emit(NewMainScene.ON_ENTER_DONE)

		self.mainCG.blocksRaycasts = true

		return
	end)

	return
end

function NewMainScene:OnDisVisible()
	self:FoldPanels(false)
	self.paintingView:Disable()
	self.bgView:Disable()
	self.sequenceView:Disable()
	self.awakeSequenceView:Disable()

	if self.theme then
		self.theme:Disable()
	end

	self.buffDescPage:Disable()
	self.silentChecker:Disable()

	if self.silentView and self.silentView:isShowing() then
		self:ExitSilentView()
	end

	self.calibrationPage:Destroy()
	self.calibrationPage:Reset()
	self.skinExperienceDisplayPage:Destroy()
	self.skinExperienceDisplayPage:Reset()
	self.liveAreaPage:Destroy()
	self.liveAreaPage:Reset()

	self.isInit = false

	self:RevertSleepTimeout()
	self:RevertAsmrShip()

	return
end

function NewMainScene:UnloadTheme()
	if self.theme then
		self.theme:Destroy()
		self.theme:Reset()

		self.theme = nil
	end

	return
end

function NewMainScene:ExitCalibrationView()
	if self.calibrationPage and self.calibrationPage:GetLoaded() and self.calibrationPage:isShowing() then
		triggerButton(self.calibrationPage.backBtn)
	end

	return
end

function NewMainScene:ExitSilentView()
	if self.silentView and self.silentView:isShowing() then
		self:FoldPanels(false)
		self.silentView:Destroy()
		self.silentView:Reset()
	end

	return
end

function NewMainScene:GameLogout()
	self:ExitCalibrationView()
	self:ExitSilentView()

	return
end

function NewMainScene:OnPlayerUpdated()
	if self.theme and self.theme:GetLoaded() then
		self.theme:OnPlayerUpdated()
	end

	return
end

function NewMainScene:onBackPressed()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_CANCEL)

	if self.silentView and self.silentView:isShowing() then
		self:ExitSilentView()

		return
	end

	if self.liveAreaPage and self.liveAreaPage:GetLoaded() and self.liveAreaPage:isShowing() then
		self.liveAreaPage:Hide()

		return
	end

	if self.calibrationPage and self.calibrationPage:GetLoaded() and self.calibrationPage:isShowing() then
		triggerButton(self.calibrationPage._parentTf)

		return
	end

	pg.SdkMgr.GetInstance():OnAndoridBackPress()
	pg.PushNotificationMgr.GetInstance():PushAll()

	return
end

function NewMainScene:willExit()
	self.bgView:Dispose()

	self.bgView = nil

	self:UnloadTheme()

	if self.calibrationPage then
		self.calibrationPage:Destroy()

		self.calibrationPage = nil
	end

	if self.silentView then
		self.silentView:Destroy()

		self.silentView = nil
	end

	self.paintingView:Dispose()

	self.paintingView = nil

	self.liveAreaPage:Destroy()

	self.liveAreaPage = nil

	self.sequenceView:Dispose()

	self.sequenceView = nil

	self.awakeSequenceView:Dispose()

	self.awakeSequenceView = nil

	self.effectView:Dispose()

	self.effectView = nil

	pg.m02:removeMediator(self.subMediator.__cname)

	self.subMediator = nil

	self.buffDescPage:Destroy()

	self.buffDescPage = nil

	self.silentChecker:Dispose()

	self.silentChecker = nil

	self.skinExperienceDisplayPage:Destroy()

	self.skinExperienceDisplayPage = nil

	self:RevertSleepTimeout()

	return
end

return NewMainScene
