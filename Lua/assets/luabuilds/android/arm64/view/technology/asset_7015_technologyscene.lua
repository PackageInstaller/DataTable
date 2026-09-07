local TechnologyScene = class("TechnologyScene", import("..base.BaseUI"))

TechnologyScene.PageBase = 1
TechnologyScene.PageQueue = 2
TechnologyScene.rarityColor = {
	["1"] = {
		"#4B7BC6FF",
		{
			0.06274509803921569,
			0.29411764705882354,
			0.8745098039215686,
			0.6705882352941176
		}
	},
	["2"] = {
		"#776AB0FF",
		{
			0.29411764705882354,
			0.23529411764705882,
			0.5764705882352941,
			0.6705882352941176
		}
	},
	["3"] = {
		"#B76642FF",
		{
			0.7490196078431373,
			0.28627450980392155,
			0.06274509803921569,
			0.6705882352941176
		}
	},
	["4"] = {
		"#368B78FF",
		{
			0.12941176470588237,
			0.4980392156862745,
			0.5019607843137255,
			0.6705882352941176
		}
	}
}

function TechnologyScene:getUIName()
	return "TechnologyUI"
end

function TechnologyScene:onBackPressed()
	if self.contextData.selectedIndex then
		self:cancelSelected()

		return
	end

	if self.contextData.page == TechnologyScene.PageQueue then
		self:setPage(TechnologyScene.PageBase)

		return
	end

	TechnologyScene.super.onBackPressed(self)

	return
end

function TechnologyScene:ResUISettings()
	return true
end

function TechnologyScene:setTechnologys(arg_4_1, arg_4_2)
	self.technologyVOs = arg_4_1
	self.technologyQueue = arg_4_2

	return
end

function TechnologyScene:setRefreshFlag(arg_5_1)
	self.flag = arg_5_1

	return
end

function TechnologyScene:setPlayer(arg_6_1)
	self.player = arg_6_1

	return
end

function TechnologyScene:init()
	self.backBtn = self._tf:Find("blur_panel/adapt/top/back")
	self.basePage = self._tf:Find("main/base_page")
	self.srcollView = self.basePage:Find("srcoll_rect/content")
	self.srcollViewCG = self.srcollView:GetComponent(typeof(CanvasGroup))
	self.helpBtn = self.basePage:Find("help_btn")
	self.refreshBtn = self.basePage:Find("refresh_btn")

	setText(self.refreshBtn:Find("Text"), i18n("technology_daily_refresh"))

	self.settingsBtn = self.basePage:Find("settings_btn")
	self.selectetPanel = self.basePage:Find("selecte_panel")

	setActive(self.selectetPanel, false)
	setText(self.selectetPanel:Find("consume_panel/bg/label/Text"), i18n("technology_consume"))
	setText(self.selectetPanel:Find("consume_panel/bg/task_panel/label/Text"), i18n("technology_request"))

	self.arrLeftBtn = self.selectetPanel:Find("left_arr_btn")
	self.arrRightBtn = self.selectetPanel:Find("right_arr_btn")
	self.technologyTpl = self.selectetPanel:Find("technology_card")
	self.descTxt = self.selectetPanel:Find("desc/bg/Text"):GetComponent(typeof(Text))
	self.timerTxt = self.selectetPanel:Find("timer/bg/Text"):GetComponent(typeof(Text))
	self.itemContainer = self.selectetPanel:Find("consume_panel/bg/container")
	self.itemTpl = self.itemContainer:Find("item_tpl")
	self.emptyTF = self.selectetPanel:Find("consume_panel/bg/empty")
	self.taskPanel = self.selectetPanel:Find("consume_panel/bg/task_panel")
	self.taskSlider = self.taskPanel:Find("slider"):GetComponent(typeof(Slider))
	self.taskDesc = self.taskPanel:Find("slider/Text"):GetComponent(typeof(Text))
	self.descBG = self.selectetPanel:Find("desc/bg"):GetComponent(typeof(Image))
	self.queuePage = self._tf:Find("main/queue_page")
	self.queueView = self.queuePage:Find("queue_rect/content")

	local var_7_0 = self._tf:Find("blur_panel/adapt/right")

	self.btnAwardQueue = var_7_0:Find("btn_award")

	setText(self.btnAwardQueue:Find("Text"), i18n("technology_queue_getaward"))

	self.btnAwardQueueDisable = var_7_0:Find("btn_award_disable")

	setText(self.btnAwardQueueDisable:Find("Text"), i18n("technology_queue_getaward"))

	self.btnQueue = self._tf:Find("blur_panel/adapt/left/btn_queue")
	self.cardtimer = {}
	self.queueTimer = {}
	self.queueCardTimer = {}

	return
end

function TechnologyScene:updateSettingsBtn()
	local var_8_0 = self.settingsBtn:Find("RedPoint")

	setText(self.settingsBtn:Find("TipText"), i18n("tec_settings_btn_word"))

	local var_8_1 = self.settingsBtn:Find("TargetCatchup")
	local var_8_2 = var_8_1:Find("Selected")
	local var_8_3 = self.settingsBtn:Find("ActCatchup")

	self:updateSettingBtnVersion()

	local var_8_4 = false
	local var_8_5 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_BLUEPRINT_CATCHUP)

	if var_8_5 and not var_8_5:isEnd() then
		local var_8_6 = var_8_5:getConfig("config_id")

		if var_8_5.data1 < pg.activity_event_blueprint_catchup[var_8_6].obtain_max then
			setImageSprite(var_8_3:Find("Selected/CharImg"), LoadSprite("TecCatchup/QChar" .. pg.activity_event_blueprint_catchup[var_8_6].char_choice, tostring(pg.activity_event_blueprint_catchup[var_8_6].char_choice)))
			setText(var_8_3:Find("Selected/ProgressText"), var_8_5.data1 .. "/" .. pg.activity_event_blueprint_catchup[var_8_6].obtain_max)

			local var_8_7 = var_8_5.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

			if self.actCatchupTimer then
				self.actCatchupTimer:Stop()

				self.actCatchupTimer = nil
			end

			local var_8_8 = var_8_3:Find("TimeLeft/Day")
			local var_8_9 = var_8_3:Find("TimeLeft/Hour")
			local var_8_10 = var_8_3:Find("TimeLeft/Min")
			local var_8_11 = var_8_3:Find("TimeLeft/NumText")

			self.actCatchupTimer = Timer.New(function()
				local var_9_0, var_9_1, var_9_2, var_9_3 = pg.TimeMgr.GetInstance():parseTimeFrom(var_8_7)

				var_8_7 = var_8_7 - 1

				if var_9_0 >= 1 then
					setActive(var_8_8, true)
					setActive(var_8_9, false)
					setActive(var_8_10, false)
					setText(var_8_11, var_9_0)
				elseif var_9_0 <= 0 and var_9_1 > 0 then
					setActive(var_8_8, false)
					setActive(var_8_9, true)
					setActive(var_8_10, false)
					setText(var_8_11, var_9_1)
				elseif var_9_0 <= 0 and var_9_1 <= 0 and (var_9_2 > 0 or var_9_3 > 0) then
					setActive(var_8_8, false)
					setActive(var_8_9, false)
					setActive(var_8_10, true)
					setText(var_8_11, math.max(var_9_2, 1))
				elseif var_9_0 <= 0 and var_9_1 <= 0 and var_9_2 <= 0 and var_9_3 <= 0 and self.actCatchupTimer then
					self.actCatchupTimer:Stop()

					self.actCatchupTimer = nil

					setActive(var_8_3, false)
				end

				return
			end, 1, -1, 1)

			self.actCatchupTimer:Start()
			self.actCatchupTimer.func()

			var_8_4 = true
		end
	end

	setActive(var_8_3, var_8_4)
	setActive(var_8_1, true)

	local var_8_12 = getProxy(TechnologyProxy)

	if var_8_12:isOpenTargetCatchup() then
		if not var_8_12:isOnCatchup() then
			setActive(var_8_2, false)
			setActive(var_8_0, true)
		else
			local var_8_13 = var_8_12:getCurCatchupTecInfo()
			local var_8_14 = var_8_13.groupID
			local var_8_15 = var_8_13.printNum
			local var_8_16

			if var_8_12:getCatchupData(var_8_13.tecID):isUr(var_8_13.groupID) then
				var_8_16 = pg.technology_catchup_template[var_8_13.tecID].obtain_max_per_ur or pg.technology_catchup_template[var_8_13.tecID].obtain_max

				if var_8_16 <= var_8_15 then
					setActive(var_8_2, false)
					setActive(var_8_0, false)

					goto label_8_0
				end
			end

			setActive(var_8_2, true)
			setActive(var_8_0, false)
			setImageSprite(var_8_2:Find("CharImg"), LoadSprite("TecCatchup/QChar" .. var_8_14, tostring(var_8_14)))
			setText(var_8_2:Find("ProgressText"), var_8_15 .. "/" .. var_8_16)
		end
	else
		setActive(var_8_2, false)
		setActive(var_8_0, false)
	end

	::label_8_0::

	return
end

function TechnologyScene:updateSettingBtnVersion()
	local var_10_0 = getProxy(TechnologyProxy):getTendency(2)
	local var_10_1 = self.settingsBtn:Find("tag")

	setActive(var_10_1, var_10_0 > 0)

	if var_10_0 > 0 then
		GetImageSpriteFromAtlasAsync("technologycard", "version_" .. var_10_0, var_10_1:Find("Image"), true)
	end

	return
end

function TechnologyScene:setPage(arg_11_1)
	self.contextData.page = arg_11_1

	setActive(self.basePage, arg_11_1 == TechnologyScene.PageBase)
	setActive(self.queuePage, arg_11_1 == TechnologyScene.PageQueue)
	setActive(self._tf:Find("blur_panel/adapt/top/title"), arg_11_1 == TechnologyScene.PageBase)
	setActive(self._tf:Find("blur_panel/adapt/left"), arg_11_1 == TechnologyScene.PageBase)
	setActive(self._tf:Find("blur_panel/adapt/top/title_queue"), arg_11_1 == TechnologyScene.PageQueue)
	setActive(self._tf:Find("blur_panel/adapt/right"), arg_11_1 == TechnologyScene.PageQueue)

	if arg_11_1 == TechnologyScene.PageBase then
		for iter_11_0, iter_11_1 in ipairs(self.technologyVOs) do
			if iter_11_1:isActivate() then
				if self.enhancelTimer then
					self.enhancelTimer:Stop()
				end

				self.enhancelTimer = Timer.New(function()
					self.srcollView:GetComponent("EnhancelScrollView"):SetHorizontalTargetItemIndex(self.technologyCards[iter_11_0]:GetComponent("EnhanceItem").scrollViewItemIndex)

					self.enhancelTimer = nil

					return
				end, 0.35, 1)

				self.enhancelTimer:Start()

				break
			end
		end
	end

	return
end

function TechnologyScene:didEnter()
	self:initTechnologys()
	self:initQueue()
	self:setPage(self.contextData.page or TechnologyScene.PageBase)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.technology_help_text.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.refreshBtn, function()
		if tobool(getProxy(TechnologyProxy):getActivateTechnology()) then
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("technology_canot_refresh")
			})

			return
		end

		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("technology_refresh_tip"),
			onYes = function()
				self:emit(TechnologyMediator.ON_REFRESH)

				return
			end
		})

		return
	end, SFX_PANEL)

	local var_13_0 = getProxy(TechnologyProxy):getConfigMaxVersion()

	onButton(self, self.settingsBtn, function()
		self:emit(TechnologyMediator.ON_CLICK_SETTINGS_BTN)

		return
	end, SFX_PANEL)
	onButton(self, self.backBtn, function()
		self:onBackPressed()

		return
	end, SOUND_BACK)
	onButton(self, self.selectetPanel, function()
		self:cancelSelected()

		return
	end, SFX_PANEL)
	self:updateRefreshBtn(self.flag)
	self:updateSettingsBtn()

	return
end

function TechnologyScene:initTechnologys()
	self.technologyCards = {}
	self.lastButtonListener = self.lastButtonListener or {}

	if not self.itemList then
		self.itemList = UIItemList.New(self.srcollView, self.srcollView:GetChild(0))

		self.itemList:make(function(arg_21_0, arg_21_1, arg_21_2)
			arg_21_1 = arg_21_1 + 1

			if arg_21_0 == UIItemList.EventUpdate then
				arg_21_2.name = arg_21_1
				self.technologyCards[arg_21_1] = arg_21_2

				self:updateTechnologyTF(arg_21_2, arg_21_1, "base")

				local var_21_0 = GetOrAddComponent(arg_21_2, typeof(Button)).onClick

				if self.lastButtonListener[arg_21_2] then
					var_21_0:RemoveListener(self.lastButtonListener[arg_21_2])
				end

				self.lastButtonListener[arg_21_2] = function()
					pg.CriMgr.GetInstance():PlaySoundEffect_V3(SFX_PANEL)

					if self.technologyVOs[arg_21_1]:isCompleted() then
						self:emit(TechnologyMediator.ON_FINISHED, {
							id = self.technologyVOs[arg_21_1].id,
							pool_id = self.technologyVOs[arg_21_1].poolId
						})
					else
						self:onSelected(arg_21_2, arg_21_1)
					end

					return
				end

				var_21_0:AddListener(self.lastButtonListener[arg_21_2])
			end

			return
		end)
	end

	self.itemList:align(#self.technologyVOs)
	setActive(self.srcollView, true)

	return
end

function TechnologyScene:initQueue()
	if not self.queueItemList then
		self.queueItemList = UIItemList.New(self.btnQueue, self.btnQueue:GetChild(0))

		self.queueItemList:make(function(arg_24_0, arg_24_1, arg_24_2)
			arg_24_1 = arg_24_1 + 1

			if arg_24_0 == UIItemList.EventUpdate then
				arg_24_2.name = arg_24_1

				if self.queueTimer[arg_24_1] then
					self.queueTimer[arg_24_1]:Stop()

					self.queueTimer[arg_24_1] = nil
				end

				local var_24_0 = {}

				if not self.technologyQueue[arg_24_1] then
					var_24_0.empty = true
				else
					local var_24_1 = pg.TimeMgr.GetInstance()
					local var_24_2 = var_24_1:GetServerTime()
					local var_24_3 = self.technologyQueue[arg_24_1].time
					local var_24_4 = self.technologyQueue[arg_24_1]:getConfig("time")

					if var_24_2 < self.technologyQueue[arg_24_1].time - var_24_1 then
						var_24_0.waiting = true
					elseif var_24_2 < self.technologyQueue[arg_24_1].time then
						var_24_0.doing = true
						self.queueTimer[arg_24_1] = Timer.New(function()
							local var_25_0 = pg.TimeMgr.GetInstance():GetServerTime()

							if var_25_0 < var_24_3 then
								setSlider(arg_24_2:Find("doing"), 0, var_24_4, var_24_4 - var_24_3 + var_25_0)
							else
								self:updateQueueChange()
							end

							return
						end, 1, -1)

						self.queueTimer[arg_24_1]:Start()
						self.queueTimer[arg_24_1].func()
					else
						var_24_0.complete = true
					end
				end

				eachChild(arg_24_2, function(arg_26_0)
					setActive(arg_26_0, var_24_0[arg_26_0.name])

					return
				end)
			end

			return
		end)
	end

	self.queueItemList:align(TechnologyConst.QUEUE_TOTAL_COUNT)
	onButton(self, self.btnQueue, function()
		self:setPage(TechnologyScene.PageQueue)

		return
	end, SFX_PANEL)

	if not self.queueCardItemList then
		self.queueCardItemList = UIItemList.New(self.queueView, self.queueView:GetChild(0))

		self.queueCardItemList:make(function(arg_28_0, arg_28_1, arg_28_2)
			arg_28_1 = arg_28_1 + 1

			if arg_28_0 == UIItemList.EventUpdate then
				arg_28_2.name = arg_28_1

				self:updateTechnologyTF(arg_28_2, arg_28_1, "queue")
			end

			return
		end)
	end

	self.queueCardItemList:align(TechnologyConst.QUEUE_TOTAL_COUNT)
	onButton(self, self.btnAwardQueue, function()
		if self.technologyQueue[1] and self.technologyQueue[1]:isCompleted() then
			self:emit(TechnologyMediator.ON_FINISH_QUEUE)
		end

		return
	end, SFX_CONFIRM)
	setActive(self.btnAwardQueue, self.technologyQueue[1] and self.technologyQueue[1]:isCompleted())
	setActive(self.btnAwardQueueDisable, not isActive(self.btnAwardQueue))

	return
end

function TechnologyScene:updateRefreshBtn(arg_30_1)
	setButtonEnabled(self.refreshBtn, arg_30_1 == 0)

	return
end

function TechnologyScene:onSelected(arg_31_1, arg_31_2)
	if not arg_31_2 then
		return
	end

	if not self.technologyVOs[arg_31_2] then
		return
	end

	self.contextData.selectedIndex = arg_31_2

	self:updateTechnologyTF(self.technologyTpl, arg_31_2, "desc")

	self.srcollViewCG.alpha = 0.3

	setActive(arg_31_1, false)
	setActive(self.selectetPanel, true)

	local var_31_0 = {}

	eachChild(self.srcollView, function(arg_32_0)
		var_31_0[tonumber(arg_32_0.name)] = arg_32_0

		return
	end)

	local function var_31_1(arg_33_0, arg_33_1)
		local var_33_0 = {}
		local var_33_1 = arg_33_0

		for iter_33_0, iter_33_1 in ipairs(var_31_0) do
			var_33_0[iter_33_0] = var_31_0[iter_33_0].localPosition.x - var_31_0[arg_33_0].localPosition.x
		end

		for iter_33_2, iter_33_3 in ipairs(var_33_0) do
			if iter_33_3 ~= 0 and (var_33_0[var_33_1] == 0 or arg_33_1 and (iter_33_3 > 0 and var_33_0[var_33_1] > 0 and iter_33_3 > var_33_0[var_33_1] or iter_33_3 < 0 and (var_33_0[var_33_1] > 0 or iter_33_3 > var_33_0[var_33_1])) or not arg_33_1 and (iter_33_3 < 0 and var_33_0[var_33_1] < 0 and iter_33_3 < var_33_0[var_33_1] or iter_33_3 > 0 and (var_33_0[var_33_1] < 0 or iter_33_3 < var_33_0[var_33_1]))) then
				var_33_1 = iter_33_2
			end
		end

		return var_31_0[var_33_1]
	end

	onButton(self, self.arrLeftBtn, function()
		if self.inAnim then
			return
		end

		self:cancelSelected()
		triggerButton(var_31_1(arg_31_2, true))

		return
	end, SFX_PANEL)
	onButton(self, self.arrRightBtn, function()
		if self.inAnim then
			return
		end

		self:cancelSelected()
		triggerButton(var_31_1(arg_31_2, false))

		return
	end, SFX_PANEL)

	return
end

function TechnologyScene:cancelSelected()
	if not self.technologyVOs[self.contextData.selectedIndex or 0] then
		return
	end

	self.contextData.selectedIndex = nil

	setActive(self.technologyCards[self.contextData.selectedIndex], true)
	removeOnButton(self.arrLeftBtn)
	removeOnButton(self.arrRightBtn)
	setActive(self.selectetPanel, false)

	self.srcollViewCG.alpha = 1
	self.inAnim = true

	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	self.timer = Timer.New(function()
		self.inAnim = nil

		return
	end, 0.2, 1)

	self.timer:Start()

	if self.extraTimer then
		self.extraTimer:Stop()

		self.extraTimer = nil
	end

	return
end

function TechnologyScene:updateTechnology(arg_38_1)
	local var_38_0

	for iter_38_0, iter_38_1 in ipairs(self.technologyVOs) do
		if iter_38_1.id == arg_38_1.id then
			self.technologyVOs[iter_38_0] = arg_38_1
			var_38_0 = iter_38_0

			break
		end
	end

	self:updateTechnologyTF(self.technologyCards[var_38_0], var_38_0, "base")

	if self.contextData.selectedIndex and self.technologyVOs[self.contextData.selectedIndex].id == arg_38_1.id then
		self:updateTechnologyTF(self.technologyTpl, var_38_0, "desc")
	end

	return
end

function TechnologyScene:updateQueueChange()
	self.queueItemList:align(#self.technologyQueue)
	self.queueCardItemList:align(TechnologyConst.QUEUE_TOTAL_COUNT)
	setActive(self.btnAwardQueue, self.technologyQueue[1] and self.technologyQueue[1]:isCompleted())
	setActive(self.btnAwardQueueDisable, not isActive(self.btnAwardQueue))

	local var_39_0 = getProxy(TechnologyProxy):getActivateTechnology()

	if var_39_0 then
		self:updateTechnology(var_39_0)
	end

	return
end

function TechnologyScene:updateTechnologyTF(arg_40_1, arg_40_2, arg_40_3)
	local var_40_0

	if arg_40_3 == "queue" then
		var_40_0 = self.technologyQueue[arg_40_2]

		local var_40_1 = not tobool(self.technologyQueue[arg_40_2])

		setActive(arg_40_1:Find("frame"), not var_40_1)
		setActive(arg_40_1:Find("empty"), var_40_1)

		if var_40_1 then
			return
		end
	else
		var_40_0 = self.technologyVOs[arg_40_2]
	end

	self:updateInfo(arg_40_1, var_40_0, arg_40_3)
	self:updateInfoVersionPickUp(arg_40_1, var_40_0)

	local var_40_2 = var_40_0:getConfig("time")
	local var_40_3 = pg.TimeMgr.GetInstance():GetServerTime()
	local var_40_4 = var_40_0.time

	switch(arg_40_3, {
		base = function()
			if self.cardtimer[arg_40_2] then
				self.cardtimer[arg_40_2]:Stop()

				self.cardtimer[arg_40_2] = nil
			end

			local var_41_0 = arg_40_1:Find("frame/marks/time")
			local var_41_1 = arg_40_1:Find("frame/marks/Text")
			local var_41_2 = TechnologyScene.rarityColor[var_40_0:getConfig("bg")]

			GetComponent(var_41_0, "Shadow").effectColor = Color.New(unpack(var_41_2[2]))

			local var_41_3 = {}

			if var_40_4 <= 0 then
				var_41_3.blue = true

				setText(var_41_1, setColorStr(i18n("technology_detail"), var_41_2[1]))
				setText(var_41_0, pg.TimeMgr.GetInstance():DescCDTime(var_40_0:getConfig("time")))
			elseif var_40_3 < var_40_4 - var_40_2 then
				var_41_3.blue = true

				setText(var_41_1, setColorStr(i18n("technology_queue_waiting"), var_41_2[1]))
				setText(var_41_0, pg.TimeMgr.GetInstance():DescCDTime(var_40_0:getConfig("time")))

				self.cardtimer[arg_40_2] = Timer.New(function()
					self:updateTechnology(var_40_0)

					return
				end, var_40_4 - var_40_2 - var_40_3)

				self.cardtimer[arg_40_2]:Start()
			elseif var_40_3 < var_40_4 then
				var_41_3.blue = true

				setText(var_41_1, setColorStr(i18n("technology_queue_processing"), var_41_2[1]))

				self.cardtimer[arg_40_2] = Timer.New(function()
					local var_43_0 = pg.TimeMgr.GetInstance():GetServerTime()

					if var_43_0 < var_40_0.time then
						setText(var_41_0, pg.TimeMgr.GetInstance():DescCDTime(var_40_0.time - var_43_0))
					else
						self:updateTechnology(var_40_0)
					end

					return
				end, 1, -1)

				self.cardtimer[arg_40_2]:Start()
				self.cardtimer[arg_40_2].func()
			else
				var_41_3.green = true

				if var_40_0:isCompleted() then
					setText(var_41_1, setColorStr(i18n("technology_queue_complete"), var_41_2[1]))
				else
					setText(var_41_1, setColorStr(i18n("technology_mission_unfinish"), var_41_2[1]))
				end

				setText(var_41_0, "00:00:00")
			end

			eachChild(arg_40_1:Find("frame/marks/line"), function(arg_44_0)
				setActive(arg_44_0, var_41_3[arg_44_0.name])

				return
			end)

			return
		end,
		queue = function()
			if self.queueCardTimer[arg_40_2] then
				self.queueCardTimer[arg_40_2]:Stop()

				self.queueCardTimer[arg_40_2] = nil
			end

			local var_45_0 = arg_40_1:Find("frame/marks/time")
			local var_45_1 = arg_40_1:Find("frame/marks/Text")
			local var_45_2 = TechnologyScene.rarityColor[var_40_0:getConfig("bg")]

			GetComponent(var_45_0, "Shadow").effectColor = Color.New(unpack(var_45_2[2]))

			local var_45_3 = {}

			if var_40_4 <= 0 then
				assert(false, "error queue")
			elseif var_40_3 < var_40_4 - var_40_2 then
				var_45_3.blue = true

				setText(var_45_1, setColorStr(i18n("technology_queue_waiting"), var_45_2[1]))
				setText(var_45_0, pg.TimeMgr.GetInstance():DescCDTime(var_40_0:getConfig("time")))
			elseif var_40_3 < var_40_4 then
				var_45_3.blue = true

				setText(var_45_1, setColorStr(i18n("technology_queue_processing"), var_45_2[1]))

				self.queueCardTimer[arg_40_2] = Timer.New(function()
					local var_46_0 = pg.TimeMgr.GetInstance():GetServerTime()

					if var_46_0 < var_40_0.time then
						setText(var_45_0, pg.TimeMgr.GetInstance():DescCDTime(var_40_0.time - var_46_0))
					end

					return
				end, 1, -1)

				self.queueCardTimer[arg_40_2]:Start()
				self.queueCardTimer[arg_40_2].func()
			else
				var_45_3.green = true

				setText(var_45_1, setColorStr(i18n("technology_queue_complete"), var_45_2[1]))
				setText(var_45_0, "00:00:00")
			end

			eachChild(arg_40_1:Find("frame/marks/line"), function(arg_47_0)
				setActive(arg_47_0, var_45_3[arg_47_0.name])

				return
			end)
			setActive(arg_40_1:Find("frame/mask"), var_40_4 > 0 and var_40_3 < var_40_4 - var_40_2)

			return
		end,
		desc = function()
			self.descTxt.text = var_40_0:getConfig("desc")
			self.descBG.sprite = GetSpriteFromAtlas("ui/TechnologyUI_atlas", var_40_0:getConfig("rarity"))

			local var_48_0 = var_40_0:getConfig("consume")
			local var_48_1 = UIItemList.New(self.itemContainer, self.itemTpl)

			var_48_1:make(function(arg_49_0, arg_49_1, arg_49_2)
				arg_49_1 = arg_49_1 + 1

				if arg_49_0 == UIItemList.EventUpdate then
					self:updateItem(arg_49_2, var_40_0, var_48_0[arg_49_1])
					setActive(arg_49_2:Find("check"), var_40_0:isActivate())
					setActive(arg_49_2:Find("icon_bg/count"), not var_40_0:isActivate())
				end

				return
			end)
			var_48_1:align(#var_48_0)
			setActive(self.emptyTF, not var_48_0 or #var_48_0 <= 0)

			local var_48_2 = var_40_0:getConfig("condition")

			if var_48_2 > 0 then
				local var_48_3 = getProxy(TaskProxy):getTaskById(var_48_2)

				var_48_3 = var_48_3 or Task.New({
					id = var_48_2
				})
				self.taskSlider.value = var_48_3.progress / var_48_3:getConfig("target_num")
				self.taskDesc.text = var_48_3:getConfig("desc") .. "(" .. var_48_3.progress .. "/" .. var_48_3:getConfig("target_num") .. ")"
			else
				self.taskDesc.text = i18n("technology_task_none_tip")
				self.taskSlider.value = 0
			end

			if self.extraTimer then
				self.extraTimer:Stop()

				self.extraTimer = nil
			end

			local var_48_4 = {}

			if var_40_4 <= 0 then
				var_48_4.start_btn = true
				self.timerTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_40_2)
			elseif var_40_3 < var_40_4 - var_40_2 then
				var_48_4.stop_btn = true
				var_48_4.join_btn = var_40_0:finishCondition()
				var_48_4.lock_join_btn = not var_48_4.join_btn
				self.timerTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_40_2)
			elseif var_40_3 < var_40_4 then
				var_48_4.stop_btn = true
				var_48_4.join_btn = var_40_0:finishCondition()
				var_48_4.lock_join_btn = not var_48_4.join_btn
				self.extraTimer = Timer.New(function()
					local var_50_0 = pg.TimeMgr.GetInstance():GetServerTime()

					if var_50_0 < var_40_4 then
						self.timerTxt.text = pg.TimeMgr.GetInstance():DescCDTime(var_40_4 - var_50_0)
					end

					return
				end, 1, -1)

				self.extraTimer:Start()
				self.extraTimer.func()
			else
				if var_40_0:isCompleted() then
					var_48_4.finish_btn = true
				else
					var_48_4.stop_btn = true
					var_48_4.lock_join_btn = true
				end

				self.timerTxt.text = "00:00:00"
			end

			eachChild(arg_40_1:Find("frame/btns"), function(arg_51_0)
				setActive(arg_51_0, var_48_4[arg_51_0.name])

				return
			end)

			local var_48_5 = arg_40_1:Find("frame/btns/start_btn")

			onButton(self, var_48_5, function()
				if getProxy(TechnologyProxy):getActivateTechnology() then
					pg.TipsMgr.GetInstance():ShowTips(i18n("technology_is_actived"))

					return
				end

				local var_52_0 = var_40_0:getConfig("consume")

				if #var_52_0 > 0 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("technology_task_build_tip", (getDropInfo(var_52_0))),
						onYes = function()
							self:emit(TechnologyMediator.ON_START, {
								id = var_40_0.id,
								pool_id = var_40_0.poolId
							})

							return
						end
					})
				else
					self:emit(TechnologyMediator.ON_START, {
						id = var_40_0.id,
						pool_id = var_40_0.poolId
					})
				end

				return
			end, SFX_PANEL)
			setButtonEnabled(var_48_5, var_40_0:hasResToStart())
			onButton(self, arg_40_1:Find("frame/btns/stop_btn"), function()
				if not var_40_0:isActivate() then
					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("technology_stop_tip"),
					onYes = function()
						self:emit(TechnologyMediator.ON_STOP, {
							id = var_40_0.id,
							pool_id = var_40_0.poolId
						})

						return
					end
				})

				return
			end, SFX_PANEL)
			onButton(self, arg_40_1:Find("frame/btns/join_btn"), function()
				if #self.technologyQueue == TechnologyConst.QUEUE_TOTAL_COUNT then
					pg.TipsMgr.GetInstance():ShowTips(i18n("technology_queue_full"))

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("technology_queue_in_doublecheck"),
					onYes = function()
						self:emit(TechnologyMediator.ON_JOIN_QUEUE, {
							id = var_40_0.id,
							pool_id = var_40_0.poolId
						})

						return
					end
				})

				return
			end, SFX_PANEL)
			onButton(self, arg_40_1:Find("frame/btns/lock_join_btn"), function()
				pg.TipsMgr.GetInstance():ShowTips(i18n("technology_queue_in_mission_incomplete"))

				return
			end, SFX_PANEL)
			onButton(self, arg_40_1:Find("frame/btns/finish_btn"), function()
				self:emit(TechnologyMediator.ON_FINISHED, {
					id = var_40_0.id,
					pool_id = var_40_0.poolId
				})

				return
			end, SFX_PANEL)

			return
		end
	})

	return
end

function TechnologyScene:dfs(arg_60_1, arg_60_2)
	if arg_60_1.name ~= "item_tpl" then
		for iter_60_0 = 1, arg_60_1.childCount do
			self:dfs(arg_60_1:GetChild(iter_60_0 - 1), arg_60_2)
		end
	else
		arg_60_2(arg_60_1)
	end

	return
end

local var_0_1 = {
	tag_red = "F15F34FF",
	tag_blue = "2541E3FF"
}

function TechnologyScene:updateInfo(arg_61_1, arg_61_2, arg_61_3)
	setImageSprite(arg_61_1:Find("frame"), GetSpriteFromAtlas("technologycard", arg_61_2:getConfig("bg") .. (arg_61_3 == "desc" and "_l" or "")))
	setImageSprite(arg_61_1:Find("frame/icon_mask/icon"), GetSpriteFromAtlas("technologyshipicon/" .. arg_61_2:getConfig("bg_icon"), arg_61_2:getConfig("bg_icon")), true)
	setImageSprite(arg_61_1:Find("frame/top/label"), GetSpriteFromAtlas("technologycard", arg_61_2:getConfig("label")))
	setImageSprite(arg_61_1:Find("frame/top/label/text"), GetSpriteFromAtlas("technologycard", arg_61_2:getConfig("label_color")), true)
	setImageSprite(arg_61_1:Find("frame/top/label/version"), GetSpriteFromAtlas("technologycard", "version_" .. arg_61_2:getConfig("blueprint_version")), true)
	setImageColor(arg_61_1:Find("frame/top/pick_up"), Color.NewHex(var_0_1[arg_61_2:getConfig("label")]))
	setText(arg_61_1:Find("frame/name_bg/Text"), arg_61_2:getConfig("name"))
	setText(arg_61_1:Find("frame/sub_name"), arg_61_2:getConfig("sub_name") or "")

	local var_61_0 = arg_61_2:getConfig("drop_client")
	local var_61_1 = arg_61_1:Find("frame/item_container")
	local var_61_2 = 0

	self:dfs(var_61_1, function(arg_62_0)
		var_61_2 = var_61_2 + 1

		setActive(arg_62_0, var_61_2 <= #var_61_0)

		if var_61_2 <= #var_61_0 then
			self:updateItem(arg_62_0, arg_61_2, var_61_0[var_61_2])
		end

		return
	end)
	switch(arg_61_3, {
		desc = function()
			return
		end
	}, function()
		setActive(var_61_1:GetChild(1), #var_61_0 > 2)

		var_61_1:GetChild(0):GetComponent("HorizontalLayoutGroup").padding.right = #var_61_0 == 4 and 25 or 0
		var_61_1:GetChild(1):GetComponent("HorizontalLayoutGroup").padding.left = #var_61_0 == 4 and 25 or 0

		return
	end)

	return
end

function TechnologyScene:updateInfoVersionPickUp(arg_65_1, arg_65_2)
	setActive(arg_65_1:Find("frame/top/pick_up"), getProxy(TechnologyProxy):getTendency(2) == arg_65_2:getConfig("blueprint_version"))

	return
end

function TechnologyScene:updateItem(arg_66_1, arg_66_2, arg_66_3)
	local var_66_0 = Drop.Create(arg_66_3)

	updateDrop(arg_66_1, setmetatable({
		count = 0
	}, {
		__index = var_66_0
	}))

	local var_66_1 = arg_66_1:Find("icon_bg/count")

	if not IsNil(var_66_1) then
		setColorCount(var_66_1, var_66_0:getOwnedCount(), var_66_0.count)
	end

	onButton(self, arg_66_1, function()
		local var_67_0 = var_66_0:getConfig("display_icon") or {}

		if #var_67_0 > 0 then
			local var_67_1 = {
				type = MSGBOX_TYPE_ITEM_BOX,
				items = _.map(var_67_0, function(arg_68_0)
					return {
						type = arg_68_0[1],
						id = arg_68_0[2]
					}
				end),
				content = var_66_0:getConfig("display")
			}

			function var_67_1.itemFunc(arg_69_0)
				self:emit(TechnologyScene.ON_DROP, arg_69_0, function()
					pg.MsgboxMgr.GetInstance():ShowMsgBox(var_67_1)

					return
				end)

				return
			end

			pg.MsgboxMgr.GetInstance():ShowMsgBox(var_67_1)
		else
			self:emit(TechnologyScene.ON_DROP, var_66_0)
		end

		return
	end, SFX_PANEL)

	return
end

function TechnologyScene:updatePickUpVersionChange()
	self:updateSettingBtnVersion()

	for iter_71_0, iter_71_1 in ipairs(self.technologyCards) do
		self:updateInfoVersionPickUp(iter_71_1, self.technologyVOs[iter_71_0])
	end

	for iter_71_2, iter_71_3 in ipairs(self.technologyQueue) do
		self:updateInfoVersionPickUp(self.queueCardItemList.container:GetChild(iter_71_2 - 1), iter_71_3)
	end

	return
end

function TechnologyScene:clearTimer(...)
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	if self.extraTimer then
		self.extraTimer:Stop()

		self.extraTimer = nil
	end

	if self.enhancelTimer then
		self.enhancelTimer:Stop()

		self.enhancelTimer = nil
	end

	for iter_72_0, iter_72_1 in pairs(self.cardtimer) do
		iter_72_1:Stop()
	end

	self.cardtimer = {}

	for iter_72_2, iter_72_3 in pairs(self.queueTimer) do
		iter_72_3:Stop()
	end

	self.queueTimer = {}

	for iter_72_4, iter_72_5 in pairs(self.queueCardTimer) do
		iter_72_5:Stop()
	end

	self.queueCardTimer = {}

	if self.actCatchupTimer then
		self.actCatchupTimer:Stop()

		self.actCatchupTimer = nil
	end

	return
end

function TechnologyScene:willExit()
	self:clearTimer()

	self.cardtimer = nil
	self.queueTimer = nil
	self.queueCardTimer = nil

	return
end

return TechnologyScene
