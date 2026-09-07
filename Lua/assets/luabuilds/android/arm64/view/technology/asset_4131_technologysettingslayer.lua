local TechnologySettingsLayer = class("TechnologySettingsLayer", import("..base.BaseUI"))

TechnologySettingsLayer.TEC_PAGE_TENDENCY = 1
TechnologySettingsLayer.TEC_PAGE_CATCHUP_TARGET1 = 2
TechnologySettingsLayer.TEC_PAGE_CATCHUP_TARGET2 = 3
TechnologySettingsLayer.TEC_PAGE_CATCHUP_TARGET3 = 4
TechnologySettingsLayer.TEC_PAGE_CATCHUP_TARGET4 = 5
TechnologySettingsLayer.TEC_PAGE_CATCHUP_TARGET5 = 6
TechnologySettingsLayer.TEC_PAGE_CATCHUP_TARGET6 = 7
TechnologySettingsLayer.TEC_PAGE_CATCHUP_TARGET7 = 8
TechnologySettingsLayer.TEC_PAGE_CATCHUP_ACT = 99
TechnologySettingsLayer.PANEL_INTO_TIME = 0.15
TechnologySettingsLayer.SELECT_TENDENCY_FADE_TIME = 0.3
TechnologySettingsLayer.SELECT_CHAR_LIGHT_FADE_TIME = 0.3
TechnologySettingsLayer.CATCHUP_CLASSES = {
	import("view.technology.TargetCatchup.TargetCatchupPanel1"),
	import("view.technology.TargetCatchup.TargetCatchupPanel2"),
	import("view.technology.TargetCatchup.TargetCatchupPanel3"),
	import("view.technology.TargetCatchup.TargetCatchupPanel4"),
	import("view.technology.TargetCatchup.TargetCatchupPanel5"),
	import("view.technology.TargetCatchup.TargetCatchupPanel6"),
	import("view.technology.TargetCatchup.TargetCatchupPanel7")
}
TechnologySettingsLayer.CATCHUP_VERSION = 7

function TechnologySettingsLayer:getUIName()
	return "TechnologySettingsUI"
end

function TechnologySettingsLayer:init()
	self:initData()
	self:findUI()
	self:addListener()
	self:initTendencyPage()
	self:initActCatchupPage()

	return
end

function TechnologySettingsLayer:didEnter()
	pg.UIMgr.GetInstance():BlurPanel(self._tf)
	self:resetLeftBtnUnsel()
	self:updateTendencyBtn(self.curTendency)
	self:updateTargetCatchupBtns()
	self:updateActCatchupBtn()
	triggerButton(self.leftBtnList[1])
	triggerToggle(self.showFinish, self.showFinishFlag == 1 and true or false)
	getProxy(CommanderManualProxy):TaskProgressAdd(2024, 1)

	return
end

function TechnologySettingsLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	if self.actCatchupTimer then
		self.actCatchupTimer:Stop()

		self.actCatchupTimer = nil
	end

	for iter_4_0, iter_4_1 in pairs(self.catchupPanels) do
		iter_4_1:willExit()
	end

	self.loader:Clear()

	return
end

function TechnologySettingsLayer:initData()
	self.technologyProxy = getProxy(TechnologyProxy)
	self.bayProxy = getProxy(BayProxy)
	self.bagProxy = getProxy(BagProxy)
	self.curPageID = 0
	self.curTendency = self.technologyProxy:getTendency(2)
	self.curSelectedIndex = 0
	self.reSelectTag = false
	self.actCatchup = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLUEPRINT_CATCHUP)
	self.isShowActCatchup = self.actCatchup and not self.actCatchup:isEnd()
	self.loader = AutoLoader.New()

	return
end

function TechnologySettingsLayer:findUI()
	self.bg = self._tf:Find("BG")

	setText(self.bg:Find("BackTips/ClickText"), i18n("click_back_tip"))

	local var_6_0 = self._tf:Find("Panel")
	local var_6_1 = var_6_0:Find("LeftScrollViewMask/LeftScrollView/LeftBtnList")

	self.leftBtnList = {}
	self.tendencyBtn = var_6_1:Find("TendencyBtn")
	self.leftBtnList[TechnologySettingsLayer.TEC_PAGE_TENDENCY] = self.tendencyBtn
	self.catchupBtns = {}

	for iter_6_0 = 1, TechnologySettingsLayer.CATCHUP_VERSION do
		self.catchupBtns[iter_6_0] = cloneTplTo(var_6_1:Find("TargetCatchupBtn_tpl"), var_6_1)
		self.leftBtnList[iter_6_0 + 1] = self.catchupBtns[iter_6_0]
	end

	self.actCatchupBtn = var_6_1:Find("ActCatchupBtn")

	self.actCatchupBtn:SetAsLastSibling()

	self.leftBtnList[TechnologySettingsLayer.TEC_PAGE_CATCHUP_ACT] = self.actCatchupBtn

	local var_6_2 = var_6_0:Find("RightPanelContainer")

	self.rightPageTFList = {}
	self.tendencyPanel = var_6_2:Find("TecTendencyPanel")
	self.rightPageTFList[TechnologySettingsLayer.TEC_PAGE_TENDENCY] = self.tendencyPanel
	self.catchupPanels = {}
	self.actCatchupPanel = var_6_2:Find("ActCatchupPanel")
	self.rightPageTFList[TechnologySettingsLayer.TEC_PAGE_CATCHUP_ACT] = self.actCatchupPanel
	self.showFinish = self._tf:Find("ShowFinishToggle")

	setText(self.showFinish:Find("Label"), i18n("tec_target_catchup_show_the_finished_version"))

	self.showFinishFlag = PlayerPrefs.GetInt("isShowFinishCatchupVersion") or 0

	if TechnologySettingsLayer.CATCHUP_VERSION < 1 then
		setActive(self.showFinish, false)
	end

	return
end

function TechnologySettingsLayer:addListener()
	onButton(self, self.bg, function()
		self:closeView()

		return
	end, SFX_PANEL)

	for iter_7_0, iter_7_1 in pairs(self.leftBtnList) do
		onButton(self, iter_7_1, function()
			if self.onPageSwitchAnim then
				return
			end

			if self.curPageID ~= iter_7_0 then
				self:resetLeftBtnUnsel()
				setActive(iter_7_1:Find("Selected"), true)
				self:switchRightPage(iter_7_0)
			end

			return
		end, SFX_PANEL)
	end

	onToggle(self, self.showFinish, function(arg_10_0)
		if TechnologySettingsLayer.CATCHUP_VERSION < 1 then
			return
		end

		for iter_10_0, iter_10_1 in pairs(self.catchupBtns) do
			if iter_10_0 <= TechnologySettingsLayer.CATCHUP_VERSION then
				if self.technologyProxy:getCatchupState(iter_10_0) == TechnologyCatchup.STATE_FINISHED_ALL and not arg_10_0 then
					setActive(iter_10_1, false)
				else
					setActive(iter_10_1, true)
				end
			end
		end

		self.showFinishFlag = arg_10_0 and 1 or 0

		PlayerPrefs.SetInt("isShowFinishCatchupVersion", self.showFinishFlag)
		triggerButton(self.leftBtnList[1])

		return
	end, SFX_PANEL)

	return
end

function TechnologySettingsLayer:resetLeftBtnUnsel()
	for iter_11_0, iter_11_1 in pairs(self.leftBtnList) do
		setActive(iter_11_1:Find("Selected"), false)
	end

	return
end

function TechnologySettingsLayer:switchRightPage(arg_12_1)
	seriesAsync({
		function(arg_13_0)
			if not self.rightPageTFList[arg_12_1] then
				local var_13_0 = arg_12_1 - 1
				local var_13_1 = self._tf:Find("Panel/RightPanelContainer")

				self.catchupPanels[arg_12_1 - 1] = TechnologySettingsLayer.CATCHUP_CLASSES[arg_12_1 - 1].New(nil, function()
					self.rightPageTFList[arg_12_1] = self.catchupPanels[var_13_0]._go

					setActive(self.rightPageTFList[arg_12_1], false)
					SetParent(self.rightPageTFList[arg_12_1], var_13_1, false)
					arg_13_0()

					return
				end)
			else
				arg_13_0()
			end

			return
		end,
		function(arg_15_0)
			local var_15_0 = self.rightPageTFList[self.curPageID]

			setActive(self.rightPageTFList[arg_12_1], true)

			self.onPageSwitchAnim = true

			self:managedTween(LeanTween.alphaCanvas, function()
				self.onPageSwitchAnim = false

				return
			end, GetOrAddComponent(self.rightPageTFList[arg_12_1], typeof(CanvasGroup)), 1, TechnologySettingsLayer.PANEL_INTO_TIME):setFrom(0)

			if self.rightPageTFList[self.curPageID] then
				self:managedTween(LeanTween.alphaCanvas, function()
					setActive(var_15_0, false)

					return
				end, GetOrAddComponent(self.rightPageTFList[self.curPageID], typeof(CanvasGroup)), 0, TechnologySettingsLayer.PANEL_INTO_TIME):setFrom(1)
			end

			self.curPageID = arg_12_1

			if arg_12_1 == TechnologySettingsLayer.TEC_PAGE_TENDENCY then
				self:updateTendencyPage(self.curTendency)
			elseif arg_12_1 == TechnologySettingsLayer.TEC_PAGE_CATCHUP_ACT then
				self:updateActCatchupPage()
			else
				self:updateTargetCatchupPage(arg_12_1 - 1)
			end

			return
		end
	})

	return
end

function TechnologySettingsLayer:initTendencyPage()
	local var_18_0 = getProxy(TechnologyProxy)
	local var_18_1 = self.tendencyPanel:Find("TecItemList")
	local var_18_2 = UIItemList.New(var_18_1, var_18_1:Find("tpl"))

	var_18_2.make(var_18_0, function(arg_19_0, arg_19_1, arg_19_2)
		if arg_19_0 == UIItemList.EventUpdate then
			local var_19_0 = arg_19_1 > 0 and i18n("tec_tendency_x", i18n("number_" .. arg_19_1)) or i18n("tec_tendency_0")

			setText(arg_19_2:Find("UnSelect/Text"), var_19_0)
			setText(arg_19_2:Find("Selected/Text"), var_19_0)
			onButton(self, arg_19_2, function()
				if self.curTendency ~= arg_19_1 then
					self:emit(TechnologySettingsMediator.CHANGE_TENDENCY, arg_19_1)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	var_18_2:align(var_18_0:getConfigMaxVersion() + 1)

	return
end

function TechnologySettingsLayer:updateTendencyPage(arg_21_1)
	local var_21_0 = self.tendencyPanel:Find("TecItemList")

	setActive(var_21_0:GetChild(self.curTendency):Find("Selected"), false)

	local var_21_1 = var_21_0:GetChild(arg_21_1):Find("Selected")

	setActive(var_21_1, true)
	setImageAlpha(var_21_1:Find("Image"), 0)
	self:managedTween(LeanTween.alpha, nil, var_21_1:Find("Image"), 1, TechnologySettingsLayer.SELECT_TENDENCY_FADE_TIME):setFrom(0)

	local var_21_2 = self.tendencyPanel:Find("TendencyNum")

	setImageAlpha(var_21_2:Find("Image"), 0)

	if arg_21_1 > 0 then
		GetImageSpriteFromAtlasAsync("ui/technologysettingsui_atlas", "right_tendency_num_" .. arg_21_1, var_21_2:Find("Image"), true)
		self:managedTween(LeanTween.alpha, nil, var_21_2:Find("Image"), 1, TechnologySettingsLayer.SELECT_TENDENCY_FADE_TIME):setFrom(0)
	end

	self.curTendency = arg_21_1

	return
end

function TechnologySettingsLayer:updateTendencyBtn(arg_22_1)
	local var_22_0 = arg_22_1 > 0 and i18n("tec_tendency_cur_x", i18n("number_" .. arg_22_1)) or i18n("tec_tendency_cur_0")

	setText(self.tendencyBtn:Find("UnSelect/Text"), var_22_0)
	setText(self.tendencyBtn:Find("Selected/Text"), var_22_0)

	return
end

function TechnologySettingsLayer:updateTargetCatchupPage(arg_23_1)
	self.catchupPanels[arg_23_1]:updateTargetCatchupPage()

	return
end

function TechnologySettingsLayer:updateTargetCatchupBtns()
	for iter_24_0, iter_24_1 in pairs(self.catchupBtns) do
		if iter_24_0 <= TechnologySettingsLayer.CATCHUP_VERSION then
			local var_24_0 = self.technologyProxy:getCatchupState(iter_24_0)
			local var_24_1 = var_24_0 == TechnologyCatchup.STATE_CATCHUPING
			local var_24_2 = iter_24_1:Find("UnSelect/Text")
			local var_24_3 = iter_24_1:Find("Selected/Text")
			local var_24_4 = iter_24_1:Find("UnSelect/CharImg")
			local var_24_5 = iter_24_1:Find("Selected/CharImg")
			local var_24_6 = var_24_4:Find("ProgressText")
			local var_24_7 = var_24_5:Find("ProgressText")

			setActive(var_24_4, var_24_0 == TechnologyCatchup.STATE_CATCHUPING)
			setActive(var_24_5, var_24_1)

			if var_24_1 then
				local var_24_8 = iter_24_0 > 0 and i18n("tec_target_catchup_selected_x", i18n("number_" .. iter_24_0)) or i18n("tec_target_catchup_selected_0")

				setText(var_24_2, var_24_8)
				setText(var_24_3, var_24_8)

				local var_24_9 = self.technologyProxy:getCurCatchupTecInfo()
				local var_24_10 = var_24_9.groupID
				local var_24_11 = var_24_9.printNum
				local var_24_12

				if self.technologyProxy:getCatchupData(var_24_9.tecID):isUr(var_24_9.groupID) then
					var_24_12 = pg.technology_catchup_template[var_24_9.tecID].obtain_max_per_ur or pg.technology_catchup_template[var_24_9.tecID].obtain_max
				end

				setImageSprite(var_24_4, LoadSprite("TecCatchup/QChar" .. var_24_10, tostring(var_24_10)))
				setImageSprite(var_24_5, LoadSprite("TecCatchup/QChar" .. var_24_10, tostring(var_24_10)))
				setText(var_24_6, var_24_11 .. "/" .. var_24_12)
				setText(var_24_7, var_24_11 .. "/" .. var_24_12)
			elseif var_24_0 == TechnologyCatchup.STATE_UNSELECT then
				local var_24_13 = iter_24_0 > 0 and i18n("tec_target_catchup_none_x", i18n("number_" .. iter_24_0)) or i18n("tec_target_catchup_none_0")

				setText(var_24_2, var_24_13)
				setText(var_24_3, var_24_13)
			elseif var_24_0 == TechnologyCatchup.STATE_FINISHED_ALL then
				local var_24_14 = iter_24_0 > 0 and i18n("tec_target_catchup_finish_x", i18n("number_" .. iter_24_0)) or i18n("tec_target_catchup_finish_0")

				setText(var_24_2, var_24_14)
				setText(var_24_3, var_24_14)
			end
		end
	end

	return
end

function TechnologySettingsLayer:initActCatchupPage()
	if self.isShowActCatchup then
		self.loader:GetPrefab("ui/" .. self.actCatchup:getConfig("page_info").ui_name, "", function(arg_26_0)
			setParent(arg_26_0, self.actCatchupPanel)
			setLocalScale(arg_26_0, {
				x = 0.925,
				y = 0.923
			})
			setAnchoredPosition(arg_26_0, Vector2.zero)

			self.actCatchupTF = tf(arg_26_0):Find("AD")
			self.actCatchupItemTF = self.actCatchupTF:Find("Award")
			self.actCatchupSliderTF = self.actCatchupTF:Find("Slider")
			self.actCatchupProgressText = self.actCatchupTF:Find("Progress")

			local var_26_0 = self.actCatchupTF:Find("GoBtn")

			if var_26_0 then
				setActive(var_26_0, false)
			end

			local var_26_1 = self.actCatchupTF:Find("FinishBtn")

			if var_26_1 then
				setActive(var_26_1, false)
			end

			local var_26_2 = self.actCatchup.data1
			local var_26_3 = pg.activity_event_blueprint_catchup[self.actCatchup:getConfig("config_id")].obtain_max
			local var_26_4 = {
				type = DROP_TYPE_ITEM,
				id = self.actCatchup:getConfig("config_client").itemid
			}

			updateDrop(self.actCatchupItemTF, var_26_4)
			onButton(self, self.actCatchupItemTF, function()
				self:emit(BaseUI.ON_DROP, var_26_4)

				return
			end, SFX_PANEL)
			setSlider(self.actCatchupSliderTF, 0, var_26_3, var_26_2)
			setText(self.actCatchupProgressText, var_26_2 .. "/" .. var_26_3)
			setActive(arg_26_0, true)

			return
		end)
	end

	return
end

function TechnologySettingsLayer:updateActCatchupPage()
	return
end

function TechnologySettingsLayer:updateActCatchupBtn()
	setText(self.actCatchupBtn:Find("UnSelect/Text"), i18n("tec_act_catchup_btn_word"))
	setText(self.actCatchupBtn:Find("Selected/Text"), i18n("tec_act_catchup_btn_word"))

	local var_29_0 = self.actCatchupBtn:Find("UnSelect/CharImg")
	local var_29_1 = self.actCatchupBtn:Find("Selected/CharImg")
	local var_29_2 = false
	local var_29_3 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLUEPRINT_CATCHUP)

	if var_29_3 and not var_29_3:isEnd() then
		local var_29_4 = var_29_3:getConfig("config_id")

		setImageSprite(var_29_0, LoadSprite("TecCatchup/QChar" .. pg.activity_event_blueprint_catchup[var_29_4].char_choice, tostring(pg.activity_event_blueprint_catchup[var_29_4].char_choice)))
		setImageSprite(var_29_1, LoadSprite("TecCatchup/QChar" .. pg.activity_event_blueprint_catchup[var_29_4].char_choice, tostring(pg.activity_event_blueprint_catchup[var_29_4].char_choice)))
		setText(var_29_0:Find("ProgressText"), var_29_3.data1 .. "/" .. pg.activity_event_blueprint_catchup[var_29_4].obtain_max)
		setText(var_29_1:Find("ProgressText"), var_29_3.data1 .. "/" .. pg.activity_event_blueprint_catchup[var_29_4].obtain_max)

		local var_29_5 = var_29_3.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

		if self.actCatchupTimer then
			self.actCatchupTimer:Stop()

			self.actCatchupTimer = nil
		end

		local var_29_6 = self.actCatchupBtn:Find("TimeLeft/Day")
		local var_29_7 = self.actCatchupBtn:Find("TimeLeft/Hour")
		local var_29_8 = self.actCatchupBtn:Find("TimeLeft/Min")
		local var_29_9 = self.actCatchupBtn:Find("TimeLeft/NumText")

		self.actCatchupTimer = Timer.New(function()
			local var_30_0, var_30_1, var_30_2, var_30_3 = pg.TimeMgr.GetInstance():parseTimeFrom(var_29_5)

			var_29_5 = var_29_5 - 1

			if var_30_0 >= 1 then
				setActive(var_29_6, true)
				setActive(var_29_7, false)
				setActive(var_29_8, false)
				setText(var_29_9, var_30_0)
			elseif var_30_0 <= 0 and var_30_1 > 0 then
				setActive(var_29_6, false)
				setActive(var_29_7, true)
				setActive(var_29_8, false)
				setText(var_29_9, var_30_1)
			elseif var_30_0 <= 0 and var_30_1 <= 0 and (var_30_2 > 0 or var_30_3 > 0) then
				setActive(var_29_6, false)
				setActive(var_29_7, false)
				setActive(var_29_8, true)
				setText(var_29_9, math.max(var_30_2, 1))
			elseif var_30_0 <= 0 and var_30_1 <= 0 and var_30_2 <= 0 and var_30_3 <= 0 and self.actCatchupTimer then
				self.actCatchupTimer:Stop()

				self.actCatchupTimer = nil

				self:switchRightPage(TechnologySettingsLayer.TEC_PAGE_TENDENCY)
				setActive(self.actCatchupBtn, false)
			end

			return
		end, 1, -1, 1)

		self.actCatchupTimer:Start()
		self.actCatchupTimer.func()

		var_29_2 = true
	end

	setActive(self.actCatchupBtn, var_29_2)

	return
end

return TechnologySettingsLayer
