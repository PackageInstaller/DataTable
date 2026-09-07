local CommanderManualLayer = class("CommanderManualLayer", import("..base.BaseUI"))

function CommanderManualLayer:getUIName()
	return "CommanderManualUI"
end

function CommanderManualLayer:init()
	self.backBtn = self._tf:Find("blur_panel/top/CommonTitleAndBack/back_btn")
	self.helpBtn = self._tf:Find("blur_panel/top/helpBtn")
	self.taskBtn = self._tf:Find("blur_panel/panel/pageBtns/taskBtn")
	self.techBtn = self._tf:Find("blur_panel/panel/pageBtns/techBtn")
	self.guideBtn = self._tf:Find("blur_panel/panel/pageBtns/guideBtn")
	self.topBtns = {
		self.taskBtn,
		self.techBtn,
		self.guideBtn
	}
	self.pages = self._tf:Find("blur_panel/panel/pages")
	self.taskPage = self._tf:Find("blur_panel/panel/pages/taskPage")
	self.techPage = self._tf:Find("blur_panel/panel/pages/techPage")
	self.guidePage = self._tf:Find("blur_panel/panel/pages/guidePage")
	self.blurPanel = self._tf:Find("blur_panel")
	self.pageBg = self._tf:Find("blur_panel/panel/mask/pageBg")

	self:OverlayPanel(self.blurPanel, {
		pbList = {
			self.pageBg
		}
	})
	setText(self._tf:Find("blur_panel/top/CommonTitleAndBack/title"), i18n("handbook_name"))
	setText(self._tf:Find("blur_panel/top/CommonTitleAndBack/title/en"), "HANDBOOK")
	setText(self.taskPage:Find("page/scroll/Viewport/Content/tpl/normal/go_btn/Text"), i18n("handbook_process"))
	setText(self.taskPage:Find("page/scroll/Viewport/Content/tpl/normal/get_btn/Text"), i18n("handbook_claim"))
	setText(self.taskPage:Find("page/scroll/Viewport/Content/tpl/normal/got_btn/Text"), i18n("handbook_finished"))
	setText(self.taskPage:Find("page/ptPanel/go_btn/Text"), i18n("handbook_process"))
	setText(self.taskPage:Find("page/ptPanel/get_btn/Text"), i18n("handbook_claim"))
	setText(self.taskPage:Find("page/ptPanel/got_btn/Text"), i18n("handbook_finished"))
	setText(self.techPage:Find("page/scroll/Viewport/Content/tpl/normal/go_btn/Text"), i18n("handbook_process"))
	setText(self.techPage:Find("page/scroll/Viewport/Content/tpl/normal/lock_btn/Text"), i18n("handbook_process"))
	setText(self.techPage:Find("page/scroll/Viewport/Content/tpl/normal/get_btn/Text"), i18n("handbook_claim"))
	setText(self.techPage:Find("page/scroll/Viewport/Content/tpl/normal/got_btn/Text"), i18n("handbook_finished"))
	setText(self.techPage:Find("page/ptPanel/go_btn/Text"), i18n("handbook_process"))
	setText(self.techPage:Find("page/ptPanel/get_btn/Text"), i18n("handbook_claim"))
	setText(self.techPage:Find("page/ptPanel/got_btn/Text"), i18n("handbook_finished"))
	setText(self.guidePage:Find("page/scroll/Viewport/Content/tpl/normal/content/descBg/go_btn/Text"), i18n("handbook_process"))
	setText(self.guidePage:Find("page/scroll/Viewport/Content/tpl/normal/content/descBg/get_btn/Text"), i18n("handbook_claim"))
	setText(self.guidePage:Find("page/scroll/Viewport/Content/tpl/normal/content/descBg/got_btn/Text"), i18n("handbook_finished"))
	setText(self.guidePage:Find("page/scroll/Viewport/Content/tpl/fold/descBg/go_btn/Text"), i18n("handbook_process"))
	setText(self.guidePage:Find("page/scroll/Viewport/Content/tpl/fold/descBg/get_btn/Text"), i18n("handbook_claim"))
	setText(self.guidePage:Find("page/scroll/Viewport/Content/tpl/fold/descBg/got_btn/Text"), i18n("handbook_finished"))
	setText(self.guidePage:Find("page/ptPanel/go_btn/Text"), i18n("handbook_process"))
	setText(self.guidePage:Find("page/ptPanel/get_btn/Text"), i18n("handbook_claim"))
	setText(self.guidePage:Find("page/ptPanel/got_btn/Text"), i18n("handbook_finished"))

	return
end

function CommanderManualLayer:didEnter()
	onButton(self, self.backBtn, function()
		self:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.handbook_gametip.tip
		})

		return
	end, SFX_PANEL)
	self:InitData()
	self:RefreshAll()

	return
end

function CommanderManualLayer:InitData()
	self.commanderManualProxy = getProxy(CommanderManualProxy)
	self.taskProxy = getProxy(TaskProxy)
	self.taskPages = self.commanderManualProxy:GetPagesByType(1)
	self.guidePages = self.commanderManualProxy:GetPagesByType(2)
	self.topTaskCfg = pg.tutorial_handbook[CommanderManualProxy.TOP_PAGE_TASK]
	self.topTechCfg = pg.tutorial_handbook[CommanderManualProxy.TOP_PAGE_TECH]
	self.topGuideCfg = pg.tutorial_handbook[CommanderManualProxy.TOP_PAGE_GUIDE]

	self:UpdateTechActivity()

	return
end

function CommanderManualLayer:UpdateTechActivity()
	self.techActivity = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FRESH_TEC_CATCHUP)

	if not self.techActivity or self.techActivity:isEnd() then
		return
	end

	local var_7_0 = self.techActivity

	self.allTechPhase = #self.techActivity:getConfig("config_data")[3] + 1

	if var_7_0.data1 == 0 then
		self.phaseId = "ready"
	else
		self.phaseId = var_7_0.data1

		if self.phaseId == 1 and var_7_0.data2 < 1 then
			self.phaseId = 0
		end
	end

	self.techFinishTaskId = self.phaseId ~= "ready" and var_7_0:getConfig("config_data")[3][math.max(1, self.phaseId)][2] or nil
	self.finishPhaseDic = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0.data1_list) do
		self.finishPhaseDic[iter_7_1] = true
	end

	self.finishPhaseDic[0] = self.finishPhaseDic[1]
	self.finishPhaseDic[1] = var_7_0.data2 == 1 and var_7_0.data1 ~= 1

	return
end

function CommanderManualLayer:RefreshAll()
	local var_8_0 = self.commanderManualProxy:IsTopUnlock(CommanderManualProxy.TOP_PAGE_TASK)
	local var_8_1 = self.commanderManualProxy:IsTopUnlock(CommanderManualProxy.TOP_PAGE_TECH)
	local var_8_2 = self.commanderManualProxy:IsTopUnlock(CommanderManualProxy.TOP_PAGE_GUIDE)

	setActive(self.taskBtn, not self.commanderManualProxy:IsTopPageComplete(1))

	local var_8_3, var_8_4 = TechnologyConst.isTecActOn()

	setActive(self.techBtn, var_8_3)
	setActive(self.taskBtn:Find("Text/lock"), not var_8_0)
	setActive(self.techBtn:Find("Text/lock"), not var_8_1)
	setActive(self.guideBtn:Find("Text/lock"), not var_8_2)
	setText(self.taskBtn:Find("Text"), (var_8_0 or nil) and (self.topTaskCfg.name or self.topTaskCfg.lock_name))
	setText(self.techBtn:Find("Text"), (var_8_1 or nil) and (self.topTechCfg.name or self.topTechCfg.lock_name))
	setText(self.guideBtn:Find("Text"), (var_8_2 or nil) and (self.topGuideCfg.name or self.topGuideCfg.lock_name))
	setText(self.taskBtn:Find("select/Text"), self.topTaskCfg.name)
	setText(self.techBtn:Find("select/Text"), self.topTechCfg.name)
	setText(self.guideBtn:Find("select/Text"), self.topGuideCfg.name)
	setText(self.taskBtn:Find("select/en"), self.topTaskCfg.eng_name)
	setText(self.techBtn:Find("select/en"), self.topTechCfg.eng_name)
	setText(self.guideBtn:Find("select/en"), self.topGuideCfg.eng_name)
	setActive(self.taskBtn:Find("tip"), self.commanderManualProxy:ShouldShowTipByType(1))
	setActive(self.techBtn:Find("tip"), var_8_4)
	setActive(self.guideBtn:Find("tip"), self.commanderManualProxy:ShouldShowTipByType(2))

	self.hasRefreshed = false

	onButton(self, self.taskBtn, function()
		if self.contextData.topIndex ~= 1 or not self.hasRefreshed then
			if var_8_0 then
				self.contextData.topIndex = 1

				if self.hasRefreshed then
					self.contextData.currentPageId = nil
				end

				self:SetPagesActive(1)
				self:ShowTaskPage()

				for iter_9_0, iter_9_1 in ipairs(self.topBtns) do
					setActive(iter_9_1:Find("select"), iter_9_1 == self.taskBtn)
				end
			else
				local var_9_0 = self.commanderManualProxy:GetLockTip(CommanderManualProxy.TOP_PAGE_TASK)

				if var_9_0 and var_9_0 ~= "" then
					pg.TipsMgr.GetInstance():ShowTips(var_9_0)
				end
			end
		end

		return
	end, SFX_PANEL)
	onButton(self, self.techBtn, function()
		if self.contextData.topIndex ~= 2 or not self.hasRefreshed then
			if var_8_1 then
				self.contextData.topIndex = 2

				if self.hasRefreshed then
					self.contextData.currentPageId = nil
				end

				self:SetPagesActive(2)
				self:ShowTechPage()

				for iter_10_0, iter_10_1 in ipairs(self.topBtns) do
					setActive(iter_10_1:Find("select"), iter_10_1 == self.techBtn)
				end
			else
				local var_10_0 = self.commanderManualProxy:GetLockTip(CommanderManualProxy.TOP_PAGE_TECH)

				if var_10_0 and var_10_0 ~= "" then
					pg.TipsMgr.GetInstance():ShowTips(var_10_0)
				end
			end
		end

		return
	end, SFX_PANEL)
	onButton(self, self.guideBtn, function()
		if self.contextData.topIndex ~= 3 or not self.hasRefreshed then
			if var_8_2 then
				self.contextData.topIndex = 3

				if self.hasRefreshed then
					self.contextData.currentPageId = nil
				end

				self:SetPagesActive(3)
				self:ShowGuidePage()

				for iter_11_0, iter_11_1 in ipairs(self.topBtns) do
					setActive(iter_11_1:Find("select"), iter_11_1 == self.guideBtn)
				end
			else
				local var_11_0 = self.commanderManualProxy:GetLockTip(CommanderManualProxy.TOP_PAGE_GUIDE)

				if var_11_0 and var_11_0 ~= "" then
					pg.TipsMgr.GetInstance():ShowTips(var_11_0)
				end
			end
		end

		return
	end, SFX_PANEL)

	if self.contextData.topIndex then
		triggerButton(self.topBtns[self.contextData.topIndex])

		self.hasRefreshed = true
	else
		local var_8_8 = false

		for iter_8_0, iter_8_1 in ipairs(self.topBtns) do
			if isActive(iter_8_1) and not isActive(iter_8_1:Find("Text/lock")) and isActive(iter_8_1:Find("tip")) then
				triggerButton(iter_8_1)

				var_8_8 = true
				self.hasRefreshed = true

				break
			end
		end

		if not var_8_8 then
			for iter_8_2, iter_8_3 in ipairs(self.topBtns) do
				if isActive(iter_8_3) and not isActive(iter_8_3:Find("Text/lock")) then
					triggerButton(iter_8_3)

					self.hasRefreshed = true

					break
				end
			end
		end
	end

	return
end

function CommanderManualLayer:SetPagesActive(arg_12_1)
	for iter_12_0 = 1, self.pages.childCount do
		setActive(self.pages:GetChild(iter_12_0 - 1), iter_12_0 == arg_12_1)
	end

	return
end

function CommanderManualLayer:ShowTaskPage()
	self.taskItemAnimTime = self.taskItemAnimTime or {}

	local var_13_0 = UIItemList.New(self.taskPage:Find("subPageScroll/Viewport/Content"), self.taskPage:Find("subPageScroll/Viewport/Content/subPageBtn"))
	local var_13_1 = UIItemList.New(self.taskPage:Find("page/scroll/Viewport/Content"), self.taskPage:Find("page/scroll/Viewport/Content/tpl"))
	local var_13_2 = false

	var_13_0:make(function(arg_14_0, arg_14_1, arg_14_2)
		if arg_14_0 == UIItemList.EventUpdate then
			local var_14_0 = self.taskPages[arg_14_1 + 1]

			setActive(arg_14_2:Find("name/lock"), not self.taskPages[arg_14_1 + 1].isUnlock)
			setActive(arg_14_2:Find("tip"), var_14_0:ShouldShowTip())
			setText(arg_14_2:Find("name"), var_14_0.isUnlock and var_14_0:getConfig("name") or var_14_0:getConfig("lock_name"))
			setText(arg_14_2:Find("name/en"), var_14_0:getConfig("eng_name"))
			setText(arg_14_2:Find("select/name"), var_14_0:getConfig("name"))
			setText(arg_14_2:Find("select/name/en"), var_14_0:getConfig("eng_name"))

			arg_14_2:GetComponent(typeof(CanvasGroup)).alpha = var_14_0.isUnlock and 1 or 0.5

			onButton(self, arg_14_2, function()
				if var_14_0.isUnlock then
					self.contextData.currentPageId = var_14_0.id

					for iter_15_0 = 1, self.taskPage:Find("subPageScroll/Viewport/Content").childCount do
						setActive(self.taskPage:Find("subPageScroll/Viewport/Content"):GetChild(iter_15_0 - 1):Find("select"), iter_15_0 == arg_14_1 + 1)
						setActive(self.taskPage:Find("subPageScroll/Viewport/Content"):GetChild(iter_15_0 - 1):Find("name"), iter_15_0 ~= arg_14_1 + 1)

						self.taskPage:Find("subPageScroll/Viewport/Content"):GetChild(iter_15_0 - 1):Find("tip").anchoredPosition = Vector2(iter_15_0 == arg_14_1 + 1 and -34.295 or 18, -2)
					end

					var_14_0:SortTaskIdList()
					var_13_1:make(function(arg_16_0, arg_16_1, arg_16_2)
						if arg_16_0 == UIItemList.EventUpdate then
							local var_16_0 = var_14_0.taskIdList[arg_16_1 + 1]
							local var_16_1 = self.taskProxy:getTaskById(var_14_0.taskIdList[arg_16_1 + 1])

							setText(arg_16_2:Find("normal/number"), string.format("NO.%02d", arg_16_1 + 1))
							setText(arg_16_2:Find("normal/desc"), pg.task_data_template[var_14_0.taskIdList[arg_16_1 + 1]].desc)

							local var_16_2 = arg_16_2:Find("normal/awards")

							self:updateTaskAwards(pg.task_data_template[var_14_0.taskIdList[arg_16_1 + 1]].award_display, var_16_2, (var_16_2:GetChild(0)))

							local var_16_3 = arg_16_2:Find("normal/go_btn")
							local var_16_4 = arg_16_2:Find("normal/get_btn")
							local var_16_5 = arg_16_2:Find("normal/got_btn")
							local var_16_6 = arg_16_2:Find("normal")
							local var_16_7 = arg_16_2:Find("lock")

							if var_16_1 then
								local var_16_8 = math.min(var_16_1:getProgress(), pg.task_data_template[var_14_0.taskIdList[arg_16_1 + 1]].target_num)

								setText(arg_16_2:Find("normal/progress"), var_16_8 .. "/" .. pg.task_data_template[var_14_0.taskIdList[arg_16_1 + 1]].target_num)
								setSlider(arg_16_2:Find("normal/slider"), 0, pg.task_data_template[var_14_0.taskIdList[arg_16_1 + 1]].target_num, var_16_8)

								if var_16_1:getTaskStatus() == 0 then
									setActive(var_16_3, true)
									setActive(var_16_4, false)
									setActive(var_16_5, false)
								elseif var_16_1:getTaskStatus() == 1 then
									setActive(var_16_3, false)
									setActive(var_16_4, true)
									setActive(var_16_5, false)
								elseif var_16_1:getTaskStatus() == 2 then
									setActive(var_16_3, false)
									setActive(var_16_4, false)
									setActive(var_16_5, true)
								end

								onButton(self, var_16_3, function()
									self:emit(CommanderManualMediator.ON_TASK_GO, var_16_1)

									return
								end, SFX_PANEL)
								onButton(self, var_16_4, function()
									self:TaskAwardsCheckAndSubmit(var_16_1)

									return
								end, SFX_PANEL)
								setActive(var_16_6, true)
								setActive(var_16_7, false)
							elseif var_14_0:IsTaskComplete(var_16_0) then
								setText(arg_16_2:Find("normal/progress"), pg.task_data_template[var_14_0.taskIdList[arg_16_1 + 1]].target_num .. "/" .. pg.task_data_template[var_14_0.taskIdList[arg_16_1 + 1]].target_num)
								setSlider(arg_16_2:Find("normal/slider"), 0, pg.task_data_template[var_14_0.taskIdList[arg_16_1 + 1]].target_num, pg.task_data_template[var_14_0.taskIdList[arg_16_1 + 1]].target_num)
								setActive(var_16_3, false)
								setActive(var_16_4, false)
								setActive(var_16_5, true)
								setActive(var_16_6, true)
								setActive(var_16_7, false)
							else
								setText(arg_16_2:Find("lock/lockBg/Text"), var_14_0:GetTaskLockTip(var_16_0))
								setActive(var_16_6, false)
								setActive(var_16_7, true)
							end

							if not self.taskItemAnimTime[var_16_0] or Time.realtimeSinceStartup - self.taskItemAnimTime[var_16_0] > 1 then
								arg_16_2:GetComponent(typeof(Animation)):Play("anim_CommanderManualUI_tpl_update")

								self.taskItemAnimTime[var_16_0] = Time.realtimeSinceStartup
							end
						end

						return
					end)
					var_13_1:align(#var_14_0.taskIdList)
					scrollTo(self.taskPage:Find("page/scroll"), 0, 1)
					self:SetPtPanel(self.taskPage:Find("page/ptPanel"), var_14_0)
				else
					local var_15_0 = var_14_0:GetLockTip()

					if var_15_0 and var_15_0 ~= "" then
						pg.TipsMgr.GetInstance():ShowTips(var_15_0)
					end
				end

				return
			end, SFX_PANEL)

			if self.contextData.currentPageId == var_14_0.id then
				var_13_2 = true

				triggerButton(arg_14_2)
			end

			if not self.contextData.currentPageId and var_14_0.isUnlock and isActive(arg_14_2:Find("tip")) then
				var_13_2 = true
				self.contextData.currentPageId = var_14_0.id

				triggerButton(arg_14_2)
			end
		end

		return
	end)
	var_13_0:align(#self.taskPages)

	if not false then
		for iter_13_0 = #self.taskPages, 1, -1 do
			if self.taskPages[iter_13_0].isUnlock then
				triggerButton(self.taskPage:Find("subPageScroll/Viewport/Content"):GetChild(iter_13_0 - 1))

				break
			end
		end
	end

	self:ShowBottomTip(self.taskPage, 1)
	onScroll(self, self.taskPage:Find("subPageScroll"), function(arg_19_0)
		self:ShowBottomTip(self.taskPage, arg_19_0.y)

		return
	end)

	return
end

function CommanderManualLayer:ShowGuidePage()
	local var_20_0 = UIItemList.New(self.guidePage:Find("subPageScroll/Viewport/Content"), self.guidePage:Find("subPageScroll/Viewport/Content/subPageBtn"))
	local var_20_1 = UIItemList.New(self.guidePage:Find("page/scroll/Viewport/Content"), self.guidePage:Find("page/scroll/Viewport/Content/tpl"))
	local var_20_2 = false

	var_20_0:make(function(arg_21_0, arg_21_1, arg_21_2)
		if arg_21_0 == UIItemList.EventUpdate then
			local var_21_0 = self.guidePages[arg_21_1 + 1]
			local var_21_1 = self.guidePages[arg_21_1 + 1]:getConfig("name")
			local var_21_2 = self.guidePages[arg_21_1 + 1]:getConfig("lock_name")

			setActive(arg_21_2:Find("lock0/lock"), not self.guidePages[arg_21_1 + 1].isUnlock)
			setActive(arg_21_2:Find("tip"), var_21_0:ShouldShowTip())
			arg_21_2:Find("mask/name"):GetComponent("ScrollText"):SetText(var_21_0.isUnlock and var_21_1 or var_21_2 or "")
			setText(arg_21_2:Find("en"), var_21_0:getConfig("eng_name"))
			arg_21_2:Find("select/mask/name"):GetComponent("ScrollText"):SetText(tostring(var_21_1 or ""))
			setText(arg_21_2:Find("select/en"), var_21_0:getConfig("eng_name"))

			arg_21_2:GetComponent(typeof(CanvasGroup)).alpha = var_21_0.isUnlock and 1 or 0.5

			onButton(self, arg_21_2, function()
				if var_21_0.isUnlock then
					self.contextData.currentPageId = var_21_0.id

					for iter_22_0 = 1, self.guidePage:Find("subPageScroll/Viewport/Content").childCount do
						setActive(self.guidePage:Find("subPageScroll/Viewport/Content"):GetChild(iter_22_0 - 1):Find("select"), iter_22_0 == arg_21_1 + 1)
						setActive(self.guidePage:Find("subPageScroll/Viewport/Content"):GetChild(iter_22_0 - 1):Find("lock0"), iter_22_0 ~= arg_21_1 + 1)
						setActive(self.guidePage:Find("subPageScroll/Viewport/Content"):GetChild(iter_22_0 - 1):Find("mask"), iter_22_0 ~= arg_21_1 + 1)
						setActive(self.guidePage:Find("subPageScroll/Viewport/Content"):GetChild(iter_22_0 - 1):Find("en"), iter_22_0 ~= arg_21_1 + 1)

						self.guidePage:Find("subPageScroll/Viewport/Content"):GetChild(iter_22_0 - 1):Find("tip").anchoredPosition = Vector2(iter_22_0 == arg_21_1 + 1 and -34.295 or 18, -2)
					end

					var_21_0:SortTaskIdList()
					var_20_1:make(function(arg_23_0, arg_23_1, arg_23_2)
						if arg_23_0 == UIItemList.EventUpdate then
							local var_23_0 = self.taskProxy:getTaskById(var_21_0.taskIdList[arg_23_1 + 1])

							setText(arg_23_2:Find("normal/number"), string.format("NO.%02d", arg_23_1 + 1))
							setText(arg_23_2:Find("normal/name"), pg.task_data_template[var_21_0.taskIdList[arg_23_1 + 1]].name)
							setText(arg_23_2:Find("normal/content/descBg/desc"), pg.task_data_template[var_21_0.taskIdList[arg_23_1 + 1]].desc)
							LoadImageSpriteAsync(pg.task_data_template[var_21_0.taskIdList[arg_23_1 + 1]].tutorial_handbook_pic, arg_23_2:Find("normal/content/picture"))
							setText(arg_23_2:Find("fold/number"), string.format("NO.%02d", arg_23_1 + 1))
							setText(arg_23_2:Find("fold/name"), pg.task_data_template[var_21_0.taskIdList[arg_23_1 + 1]].name)
							setText(arg_23_2:Find("fold/descBg/desc"), pg.task_data_template[var_21_0.taskIdList[arg_23_1 + 1]].desc)

							local var_23_1 = arg_23_2:Find("normal/content/descBg/go_btn")
							local var_23_2 = arg_23_2:Find("normal/content/descBg/get_btn")
							local var_23_3 = arg_23_2:Find("normal/content/descBg/got_btn")
							local var_23_4 = arg_23_2:Find("fold/descBg/go_btn")
							local var_23_5 = arg_23_2:Find("fold/descBg/get_btn")
							local var_23_6 = arg_23_2:Find("fold/descBg/got_btn")
							local var_23_7 = arg_23_2:Find("normal")
							local var_23_8 = arg_23_2:Find("fold")
							local var_23_9 = arg_23_2:Find("lock")
							local var_23_10 = arg_23_2:GetComponent(typeof(Animation))
							local var_23_11 = arg_23_2:GetComponent(typeof(DftAniEvent))

							if var_23_0 then
								if var_23_0:getTaskStatus() == 0 then
									setActive(var_23_1, true)
									setActive(var_23_2, false)
									setActive(var_23_3, false)
									setActive(var_23_4, true)
									setActive(var_23_5, false)
									setActive(var_23_6, false)
								elseif var_23_0:getTaskStatus() == 1 then
									setActive(var_23_1, false)
									setActive(var_23_2, true)
									setActive(var_23_3, false)
									setActive(var_23_4, false)
									setActive(var_23_5, true)
									setActive(var_23_6, false)
								elseif var_23_0:getTaskStatus() == 2 then
									setActive(var_23_1, false)
									setActive(var_23_2, false)
									setActive(var_23_3, true)
									setActive(var_23_4, false)
									setActive(var_23_5, false)
									setActive(var_23_6, true)
								end

								onButton(self, var_23_1, function()
									self:emit(CommanderManualMediator.ON_TASK_GO, var_23_0)

									return
								end, SFX_PANEL)
								onButton(self, var_23_2, function()
									self:TaskAwardsCheckAndSubmit(var_23_0)

									return
								end, SFX_PANEL)
								onButton(self, var_23_4, function()
									self:emit(CommanderManualMediator.ON_TASK_GO, var_23_0)

									return
								end, SFX_PANEL)
								onButton(self, var_23_5, function()
									self:TaskAwardsCheckAndSubmit(var_23_0)

									return
								end, SFX_PANEL)
								setActive(arg_23_2:Find("normal/content/descBg/triangle"), false)
								setActive(var_23_7, true)
								setActive(var_23_8, false)
								setActive(var_23_9, false)
							elseif var_21_0:IsTaskComplete(var_21_0.taskIdList[arg_23_1 + 1]) then
								setActive(var_23_1, false)
								setActive(var_23_2, false)
								setActive(var_23_3, true)
								setActive(var_23_4, false)
								setActive(var_23_5, false)
								setActive(var_23_6, true)
								setActive(arg_23_2:Find("normal/content/descBg/triangle"), true)
								onButton(self, arg_23_2:Find("normal/content/descBg/triangle"), function()
									setActive(var_23_7, true)
									var_23_11:SetEndEvent(function()
										setActive(var_23_7, false)
										setActive(var_23_8, true)

										return
									end)
									var_23_10:Play("anim_CommanderManualUI_tpl_guidePage_expand")

									return
								end, SFX_PANEL)
								onButton(self, arg_23_2:Find("fold/descBg/triangle"), function()
									setActive(var_23_7, true)
									var_23_11:SetEndEvent(function()
										setActive(var_23_8, false)

										return
									end)
									var_23_10:Play("anim_CommanderManualUI_tpl_guidePage_retract")

									return
								end, SFX_PANEL)
								setActive(var_23_7, false)
								setActive(var_23_8, true)
								setActive(var_23_9, false)
							else
								setText(arg_23_2:Find("lock/lockBg/Text"), var_21_0:GetTaskLockTip(var_21_0.taskIdList[arg_23_1 + 1]))
								setActive(var_23_7, false)
								setActive(var_23_8, false)
								setActive(var_23_9, true)
							end

							var_23_10:Play("anim_CommanderManualUI_tpl_guidePage")
						end

						return
					end)
					var_20_1:align(#var_21_0.taskIdList)
					scrollTo(self.guidePage:Find("page/scroll"), 0, 1)
					self:SetPtPanel(self.guidePage:Find("page/ptPanel"), var_21_0)
				else
					local var_22_0 = var_21_0:GetLockTip()

					if var_22_0 and var_22_0 ~= "" then
						pg.TipsMgr.GetInstance():ShowTips(var_22_0)
					end
				end

				return
			end, SFX_PANEL)

			if self.contextData.currentPageId == var_21_0.id then
				var_20_2 = true

				triggerButton(arg_21_2)
			end

			if not self.contextData.currentPageId and var_21_0.isUnlock and isActive(arg_21_2:Find("tip")) then
				var_20_2 = true
				self.contextData.currentPageId = var_21_0.id

				triggerButton(arg_21_2)
			end
		end

		return
	end)
	var_20_0:align(#self.guidePages)

	if not false then
		triggerButton(self.guidePage:Find("subPageScroll/Viewport/Content"):GetChild(0))
	end

	self:ShowBottomTip(self.guidePage, 1)
	onScroll(self, self.guidePage:Find("subPageScroll"), function(arg_32_0)
		self:ShowBottomTip(self.guidePage, arg_32_0.y)

		return
	end)

	return
end

function CommanderManualLayer:SetPtPanel(arg_33_1, arg_33_2)
	local var_33_0 = arg_33_2:getConfig("target")
	local var_33_1 = arg_33_2:getConfig("drop_client")

	setText(arg_33_1:Find("upgrade/progress/progress1"), arg_33_2.pt)
	setText(arg_33_1:Find("upgrade/progress/progress2"), "/" .. #arg_33_2.taskIdList)
	setSlider(arg_33_1:Find("slider"), 0, #arg_33_2.taskIdList, arg_33_2.pt)

	if arg_33_2.pt == #arg_33_2.taskIdList then
		arg_33_1:Find("upgrade"):GetComponent(typeof(Animation)):Play("anim_CommanderManualUI_ptPanel_upgrade")
	end

	local var_33_2 = arg_33_2:GetCurrentPtTarget()

	setText(arg_33_1:Find("desc"), i18n("handbook_unfinished", var_33_2))

	local var_33_3 = arg_33_1:Find("awards")

	self:updateTaskAwards(arg_33_2:GetCurrentPtAward(), var_33_3, (var_33_3:GetChild(0)))
	setActive(arg_33_1:Find("go_btn"), var_33_2 > arg_33_2.pt)
	setActive(arg_33_1:Find("get_btn"), var_33_2 <= arg_33_2.pt and arg_33_2.award < #arg_33_2:getConfig("target"))
	setActive(arg_33_1:Find("got_btn"), arg_33_2.award == #arg_33_2:getConfig("target"))
	onButton(self, arg_33_1:Find("get_btn"), function()
		self:PtAwardsCheckAndSubmit(arg_33_2)

		return
	end, SFX_PANEL)

	return
end

function CommanderManualLayer:updateTaskAwards(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = _.slice(arg_35_1, 1, 3)

	for iter_35_0 = arg_35_2.childCount, #var_35_0 - 1 do
		cloneTplTo(arg_35_3, arg_35_2)
	end

	for iter_35_1 = 1, arg_35_2.childCount do
		local var_35_1 = arg_35_2:GetChild(iter_35_1 - 1)
		local var_35_2 = iter_35_1 <= #var_35_0

		setActive(var_35_1, iter_35_1 <= #var_35_0)

		if var_35_2 then
			local var_35_3 = {
				type = var_35_0[iter_35_1][1],
				id = var_35_0[iter_35_1][2],
				count = var_35_0[iter_35_1][3]
			}

			updateDrop(var_35_1, var_35_3)
			onButton(self, var_35_1, function()
				self:emit(BaseUI.ON_DROP, var_35_3)

				return
			end, SFX_PANEL)
		end
	end

	return
end

function CommanderManualLayer:ShowTechPage()
	local var_37_0 = self.techPage:Find("subPageScroll/Viewport/Content")

	UIItemList.StaticAlign(var_37_0, var_37_0:GetChild(0), self.allTechPhase, function(arg_38_0, arg_38_1, arg_38_2)
		if arg_38_0 == UIItemList.EventUpdate then
			arg_38_2.name = "Phase" .. arg_38_1

			setText(arg_38_2:Find("name"), i18n("tec_catchup_" .. arg_38_1))
			setText(arg_38_2:Find("name/en"), "")
			setText(arg_38_2:Find("select/name"), i18n("tec_catchup_" .. arg_38_1))
			setText(arg_38_2:Find("select/name/en"), "")
			onToggle(self, arg_38_2, function(arg_39_0)
				setActive(arg_38_2:Find("select"), arg_39_0)
				setCanvasGroupAlpha(arg_38_2, not arg_39_0 and self.finishPhaseDic[arg_38_1] and 0.5 or 1)

				arg_38_2:Find("tip").anchoredPosition = Vector2(arg_39_0 and -34.295 or 18, -2)

				setActive(arg_38_2:Find("name"), not arg_39_0)

				if arg_39_0 then
					self:SetTechDisplayPage(arg_38_1)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	self:UpdateTechPageState()
	setActive(self.techPage:Find("page"), true)

	local var_37_2 = self.phaseId == "ready" and 0 or self.phaseId

	eachChild(var_37_0, function(arg_40_0, arg_40_1)
		triggerToggle(arg_40_0, arg_40_1 == var_37_2)

		return
	end)
	self:ShowBottomTip(self.techPage, 1)
	onScroll(self, self.techPage:Find("subPageScroll"), function(arg_41_0)
		self:ShowBottomTip(self.techPage, arg_41_0.y)

		return
	end)

	return
end

function CommanderManualLayer:GetTechTask(arg_42_1, arg_42_2)
	local var_42_0 = Task.New({
		id = arg_42_1
	})

	if arg_42_2 then
		var_42_0.progress = var_42_0:getConfig("target_num")
		var_42_0.submitTime = 1
	end

	return var_42_0
end

function CommanderManualLayer:SetTechDisplayPage(arg_43_1)
	local var_43_0 = arg_43_1 == self.phaseId
	local var_43_1 = self.finishPhaseDic[arg_43_1]

	setActive(self.techPage:Find("page/lock_mask"), not (arg_43_1 == self.phaseId))

	local var_43_2, var_43_3 = unpack(self.techActivity:getConfig("config_data")[3][math.max(1, arg_43_1)])
	local var_43_4 = underscore.map(var_43_2, function(arg_44_0)
		return self.taskProxy:getTaskVO(arg_44_0) or self:GetTechTask(arg_44_0, var_43_0 or var_43_1)
	end)

	table.sort(var_43_4, CompareFuncs({
		function(arg_45_0)
			return arg_45_0:isReceive() and 1 or 0
		end,
		function(arg_46_0)
			return arg_46_0:isFinish() and 0 or 1
		end,
		function(arg_47_0)
			return arg_47_0.id
		end
	}))

	local var_43_5 = self.techPage:Find("page/scroll/Viewport/Content")

	UIItemList.StaticAlign(var_43_5, var_43_5:Find("tpl"), #var_43_4, function(arg_48_0, arg_48_1, arg_48_2)
		arg_48_1 = arg_48_1 + 1

		if arg_48_0 == UIItemList.EventUpdate then
			local var_48_0 = var_43_4[arg_48_1]

			setText(arg_48_2:Find("normal/number"), string.format("NO.%02d", arg_48_1))
			setText(arg_48_2:Find("normal/desc"), var_48_0:getConfig("desc"))

			local var_48_1 = arg_48_2:Find("normal/awards")

			self:updateTaskAwards(var_48_0:getConfig("award_display"), var_48_1, (var_48_1:GetChild(0)))

			local var_48_2 = arg_48_2:Find("normal/go_btn")
			local var_48_3 = arg_48_2:Find("normal/get_btn")
			local var_48_4 = arg_48_2:Find("normal/got_btn")
			local var_48_5 = arg_48_2:Find("normal/lock_btn")
			local var_48_6 = arg_48_2:Find("normal")
			local var_48_7 = arg_48_2:Find("lock")
			local var_48_8 = var_48_0:getConfig("target_num")
			local var_48_9 = math.min(var_48_0:getProgress(), var_48_8)

			setText(arg_48_2:Find("normal/progress"), var_48_9 .. "/" .. var_48_8)
			setSlider(arg_48_2:Find("normal/slider"), 0, var_48_8, var_48_9)

			if not var_43_0 and not var_43_1 then
				setActive(var_48_2, false)
				setActive(var_48_3, false)
				setActive(var_48_4, false)
				setActive(var_48_5, true)
			else
				local var_48_10 = var_48_0:getTaskStatus()

				setActive(var_48_2, var_48_10 == 0)
				setActive(var_48_3, var_48_10 == 1)
				setActive(var_48_4, var_48_10 == 2)
				setActive(var_48_5, false)
			end

			onButton(self, var_48_2, function()
				self:emit(CommanderManualMediator.ON_TASK_GO, var_48_0)

				return
			end, SFX_PANEL)
			onButton(self, var_48_3, function()
				self:TaskAwardsCheckAndSubmit(var_48_0)

				return
			end, SFX_PANEL)
			setActive(var_48_6, true)
			setActive(var_48_7, false)
			arg_48_2:GetComponent(typeof(Animation)):Play("anim_CommanderManualUI_tpl_update")
		end

		return
	end)
	scrollTo(self.techPage:Find("page/scroll"), 0, 1)

	local var_43_6 = self.techPage:Find("page/ptPanel")
	local var_43_7

	if var_43_0 then
		var_43_7 = self.taskProxy:getTaskVO(var_43_3)
	elseif var_43_1 then
		var_43_7 = self:GetTechTask(var_43_3, var_43_1)
	end

	if var_43_7 then
		if var_43_7 and var_43_7:isClientTrigger() and not var_43_7:isFinish() then
			self:emit(CommanderManualMediator.ON_UPDATE, var_43_7)
		end

		local var_43_8 = var_43_7:getConfig("target_num")
		local var_43_9 = math.min(var_43_7:getProgress(), var_43_8)

		setText(var_43_6:Find("upgrade/progress/progress1"), var_43_9)
		setText(var_43_6:Find("upgrade/progress/progress2"), "/" .. var_43_8)
		setSlider(var_43_6:Find("slider"), 0, var_43_8, var_43_9)

		if var_43_9 == var_43_8 then
			var_43_6:Find("upgrade"):GetComponent(typeof(Animation)):Play("anim_CommanderManualUI_ptPanel_upgrade")
		end

		setText(var_43_6:Find("desc"), var_43_7:getConfig("desc"))

		local var_43_10 = var_43_6:Find("awards")

		self:updateTaskAwards(var_43_7:getConfig("award_display"), var_43_10, (var_43_10:GetChild(0)))

		local var_43_11 = var_43_6:Find("go_btn")
		local var_43_12 = var_43_6:Find("get_btn")
		local var_43_13 = var_43_6:Find("got_btn")
		local var_43_14 = var_43_7:getTaskStatus()

		setActive(var_43_11, var_43_14 == 0)
		setActive(var_43_12, var_43_14 == 1)
		setActive(var_43_13, var_43_14 == 2)
		setActive(var_43_6:Find("unlock_btn"), false)
		setActive(var_43_6:Find("wait_btn"), false)
		onButton(self, var_43_11, function()
			self:emit(CommanderManualMediator.ON_TASK_GO, var_43_7)

			return
		end, SFX_PANEL)
		onButton(self, var_43_12, function()
			self:TaskAwardsCheckAndSubmit(var_43_7)

			return
		end, SFX_PANEL)
	else
		local var_43_15 = #var_43_4
		local var_43_16 = var_43_0 and underscore.reduce(var_43_4, 0, function(arg_53_0, arg_53_1)
			return arg_53_0 + (arg_53_1:isReceive() and 1 or 0)
		end) or 0

		setText(var_43_6:Find("upgrade/progress/progress1"), var_43_16)
		setText(var_43_6:Find("upgrade/progress/progress2"), "/" .. var_43_15)
		setSlider(var_43_6:Find("slider"), 0, var_43_15, var_43_16)

		if var_43_16 == var_43_15 then
			var_43_6:Find("upgrade"):GetComponent(typeof(Animation)):Play("anim_CommanderManualUI_ptPanel_upgrade")
		end

		setText(var_43_6:Find("desc"), i18n("handbook_research_final_task_desc_locked", i18n("tec_catchup_" .. arg_43_1)))

		local var_43_17 = var_43_6:Find("awards")

		self:updateTaskAwards(pg.task_data_template[var_43_3].award_display, var_43_17, (var_43_17:GetChild(0)))
		setActive(var_43_6:Find("go_btn"), false)
		setActive(var_43_6:Find("get_btn"), false)
		setActive(var_43_6:Find("got_btn"), false)

		if var_43_15 <= var_43_16 then
			self:emit(CommanderManualMediator.ON_TRIGGER, {
				cmd = 2,
				activity_id = self.techActivity.id
			})
		end

		local var_43_18, var_43_19 = TechnologyConst.isTecActOn()
		local var_43_20 = self.techFinishTaskId
		local var_43_21

		if self.techFinishTaskId then
			var_43_20 = self.taskProxy:getTaskVO(self.techFinishTaskId)
			var_43_21 = not var_43_1 and not var_43_0
		end

		if self.phaseId == "ready" or var_43_18 and var_43_20 and var_43_20:isReceive() then
			::label_43_0::

			local var_43_22

			if arg_43_1 == 1 then
				var_43_22 = self.finishPhaseDic[0] or self.phaseId == 0
			end
		end

		local var_43_23 = var_43_6:Find("unlock_btn")
		local var_43_24 = var_43_6:Find("wait_btn")

		setText(var_43_23:Find("Text"), i18n("handbook_research_confirm", i18n("tec_catchup_" .. arg_43_1)))
		setText(var_43_24:Find("Text"), i18n("handbook_research_final_task_btn_locked"))
		setActive(var_43_23, var_43_21 and var_43_22)
		setActive(var_43_24, var_43_0 and var_43_16 < var_43_15)
		onButton(self, var_43_23, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("tec_catchup_confirm"),
				onYes = function()
					if arg_43_1 == 1 then
						self:emit(CommanderManualMediator.ON_TRIGGER, {
							cmd = 3,
							activity_id = self.techActivity.id
						})
					else
						self:emit(CommanderManualMediator.ON_TRIGGER, {
							cmd = 1,
							activity_id = self.techActivity.id,
							arg1 = math.max(arg_43_1, 1)
						})
					end

					return
				end
			})

			return
		end, SFX_CONFIRM)
		onButton(self, var_43_24, function()
			pg.TipsMgr.GetInstance():ShowTips(i18n("handbook_research_final_task_desc_locked", i18n("tec_catchup_" .. arg_43_1)))

			return
		end, SFX_CONFIRM)
	end

	return
end

function CommanderManualLayer:UpdateTechPageState()
	local var_57_0, var_57_1 = TechnologyConst.isTecActOn()
	local var_57_2 = self.techFinishTaskId and self.taskProxy:getTaskVO(self.techFinishTaskId)
	local var_57_3 = self.phaseId == "ready" or var_57_0 and var_57_2 and var_57_2:isReceive()

	eachChild(self.techPage:Find("subPageScroll/Viewport/Content"), function(arg_58_0, arg_58_1)
		local var_58_0 = not self.finishPhaseDic[arg_58_1] and self.phaseId ~= arg_58_1
		local var_58_1 = var_57_3

		if var_57_3 then
			if arg_58_1 == 1 then
				var_58_1 = self.finishPhaseDic[0] or self.phaseId == 0
			end
		end

		setActive(arg_58_0:Find("name/lock"), false)
		setActive(arg_58_0:Find("select/bg"), not self.finishPhaseDic[arg_58_1])
		setActive(arg_58_0:Find("select/bg_end"), self.finishPhaseDic[arg_58_1])

		if var_58_1 then
			setActive(arg_58_0:Find("tip"), var_58_0)
		else
			setActive(arg_58_0:Find("tip"), arg_58_1 == self.phaseId and var_57_1)
		end

		return
	end)

	return
end

function CommanderManualLayer:ShowBottomTip(arg_59_1, arg_59_2)
	local var_59_0 = arg_59_1:Find("subPageScroll")
	local var_59_1 = var_59_0:GetComponent(typeof(ScrollRect))
	local var_59_2 = arg_59_1:Find("subPageScroll/Viewport/Content")
	local var_59_3 = var_59_2:GetComponent(typeof(VerticalLayoutGroup))
	local var_59_4 = var_59_2:GetChild(0).rect.height
	local var_59_5 = arg_59_1:Find("subPageScroll/Viewport").rect.height

	if var_59_0.padding.top + var_59_3.padding.bottom + var_59_4 * var_59_2.childCount + var_59_3.spacing * (var_59_2.childCount - 1) < var_59_5 + var_59_3.spacing + var_59_4 then
		setActive(arg_59_1:Find("bottomTip"), false)

		return
	end

	local var_59_6 = math.floor(var_59_5 / (var_59_4 + var_59_3.spacing))
	local var_59_7 = math.ceil((var_59_2.childCount - var_59_6) * (1 - arg_59_2) + var_59_6)

	if var_59_7 < var_59_6 then
		var_59_7 = var_59_6
	end

	if var_59_7 > var_59_2.childCount - 1 then
		setActive(arg_59_1:Find("bottomTip"), false)

		return
	end

	setActive(arg_59_1:Find("bottomTip"), false)

	for iter_59_0 = var_59_7, var_59_2.childCount - 1 do
		if isActive(var_59_2:GetChild(iter_59_0):Find("tip")) then
			setActive(arg_59_1:Find("bottomTip"), true)

			break
		end
	end

	return
end

function CommanderManualLayer:TaskAwardsCheckAndSubmit(arg_60_1)
	local var_60_0 = {}
	local var_60_1 = arg_60_1:getConfig("award_display")
	local var_60_2 = getProxy(PlayerProxy):getRawData()
	local var_60_3, var_60_4 = Task.StaticJudgeOverflow(var_60_2.gold, var_60_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_60_1)

	if var_60_3 then
		table.insert(var_60_0, function(arg_61_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_60_4,
				onYes = arg_61_0
			})

			return
		end)
	end

	seriesAsync(var_60_0, function()
		self:emit(CommanderManualMediator.ON_TASK_SUBMIT, arg_60_1)

		return
	end)

	return
end

function CommanderManualLayer:PtAwardsCheckAndSubmit(arg_63_1)
	local var_63_0 = {}
	local var_63_1 = arg_63_1:GetCurrentPtAward()
	local var_63_2 = getProxy(PlayerProxy):getRawData()
	local var_63_3, var_63_4 = Task.StaticJudgeOverflow(var_63_2.gold, var_63_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, var_63_1)

	if var_63_3 then
		table.insert(var_63_0, function(arg_64_0)
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_ITEM_BOX,
				content = i18n("award_max_warning"),
				items = var_63_4,
				onYes = arg_64_0
			})

			return
		end)
	end

	seriesAsync(var_63_0, function()
		self:emit(CommanderManualMediator.GET_PT_AWARD, arg_63_1.id)

		return
	end)

	return
end

function CommanderManualLayer:willExit()
	self:UnOverlayPanel(self.blurPanel, self._tf)

	return
end

function CommanderManualLayer:onBackPressed()
	self:closeView()

	return
end

return CommanderManualLayer
