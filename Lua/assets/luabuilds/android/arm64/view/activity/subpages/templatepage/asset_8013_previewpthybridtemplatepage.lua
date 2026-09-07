local PreviewPtHybridTemplatePage = class("PreviewPtHybridTemplatePage", import("view.base.BaseActivityPage"))

function PreviewPtHybridTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnList = self.bg:Find("btn_list")
	self.battleBtn = self.btnList:Find("fight")
	self.getBtn = self.btnList:Find("get_btn")
	self.gotBtn = self.btnList:Find("got_btn")
	self.ptList = self.bg:Find("pt_list")
	self.slider = self.ptList:Find("slider")
	self.step = self.ptList:Find("step")
	self.progress = self.ptList:Find("progress")
	self.awardTF = self.ptList:Find("award")

	return
end

function PreviewPtHybridTemplatePage:OnFirstFlush()
	self:initBtn()
	eachChild(self.btnList, function(arg_3_0)
		self.btnFuncList[arg_3_0.name](arg_3_0)

		return
	end)

	return
end

function PreviewPtHybridTemplatePage:OnDataSetting()
	if self.ptData then
		self.ptData:Update(self.activity)
	else
		self.ptData = ActivityPtData.New(self.activity)
	end

	return
end

function PreviewPtHybridTemplatePage:initBtn()
	local function var_5_0(arg_6_0)
		local var_6_0 = getProxy(ActivityProxy):getActivityById(arg_6_0)

		if not var_6_0 or var_6_0 and var_6_0:isEnd() then
			return true
		else
			return false
		end

		return
	end

	local var_5_1 = self.activity:getConfig("config_client")

	self.btnFuncList = {
		task = function(arg_7_0)
			onButton(self, arg_7_0, function()
				if var_5_1.taskLinkActID and var_5_0(var_5_1.taskLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = "activity"
				})

				return
			end)

			return
		end,
		shop = function(arg_9_0)
			onButton(self, arg_9_0, function()
				local var_10_0

				if var_5_1.shopLinkActID then
					var_10_0 = getProxy(ActivityProxy):getActivitiesById(var_5_1.shopLinkActID) or underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_11_0)
						return not arg_11_0:isEnd()
					end)

					if not var_10_0 or var_10_0:isEnd() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

						return
					end
				end

				self:emit(ActivityMediator.GO_SHOPS_LAYER, {
					warp = NewShopsScene.TYPE_ACTIVITY,
					actId = var_10_0.id
				})

				return
			end)

			return
		end,
		build = function(arg_12_0)
			onButton(self, arg_12_0, function()
				if var_5_1.buildLinkActID and var_5_0(var_5_1.buildLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
					page = BuildShipScene.PAGE_BUILD,
					projectName = BuildShipScene.PROJECTS.ACTIVITY
				})

				return
			end)

			return
		end,
		fight = function(arg_14_0)
			onButton(self, arg_14_0, function()
				if var_5_1.fightLinkActID and var_5_0(var_5_1.fightLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.BATTLE_OPERA)

				return
			end)

			return
		end,
		lottery = function(arg_16_0)
			onButton(self, arg_16_0, function()
				if var_5_1.lotteryLinkActID and var_5_0(var_5_1.lotteryLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				self:emit(ActivityMediator.GO_LOTTERY)

				return
			end)

			return
		end,
		memory = function(arg_18_0)
			return
		end,
		activity = function(arg_19_0)
			return
		end,
		mountain = function(arg_20_0)
			return
		end,
		skinshop = function(arg_21_0)
			onButton(self, arg_21_0, function()
				self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

				return
			end)

			return
		end,
		display_btn = function(arg_23_0)
			onButton(self, arg_23_0, function()
				self:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
					type = self.ptData.type,
					dropList = self.ptData.dropList,
					targets = self.ptData.targets,
					level = self.ptData.level,
					count = self.ptData.count,
					resId = self.ptData.resId,
					unlockStamps = self.ptData:GetDayUnlockStamps()
				})

				return
			end, SFX_PANEL)

			return
		end,
		get_btn = function(arg_25_0)
			onButton(self, arg_25_0, function()
				local var_26_0 = {}
				local var_26_1 = self.ptData:GetAward()
				local var_26_2 = getProxy(PlayerProxy):getRawData()
				local var_26_3, var_26_4 = Task.StaticJudgeOverflow(var_26_2.gold, var_26_2.oil, LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1]), true, true, {
					{
						var_26_1.type,
						var_26_1.id,
						var_26_1.count
					}
				})

				if var_26_3 then
					table.insert(var_26_0, function(arg_27_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							type = MSGBOX_TYPE_ITEM_BOX,
							content = i18n("award_max_warning"),
							items = var_26_4,
							onYes = arg_27_0
						})

						return
					end)
				end

				seriesAsync(var_26_0, function()
					local var_28_0, var_28_1 = self.ptData:GetResProgress()

					self:emit(ActivityMediator.EVENT_PT_OPERATION, {
						cmd = 1,
						activity_id = self.ptData:GetId(),
						arg1 = var_28_1
					})

					return
				end)

				return
			end, SFX_PANEL)

			return
		end,
		got_btn = function(arg_29_0)
			return
		end,
		boost_btn = function(arg_30_0)
			onButton(self, arg_30_0, function()
				if var_5_1.boostLinkActID and var_5_0(var_5_1.boostLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				local var_31_0 = getProxy(ActivityProxy)
				local var_31_1 = var_31_0:getActivityById(var_5_1.boostLinkActID)
				local var_31_2 = var_31_1:getConfig("config_id")
				local var_31_3 = var_31_1:getConfig("config_client").icon
				local var_31_4 = var_31_1:getConfig("config_client").name
				local var_31_5 = var_31_1:getConfig("config_client").desc

				if var_31_0 and var_31_4 and var_31_5 then
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						yesText = "text_confirm",
						hideNo = true,
						type = MSGBOX_TYPE_DROP_ITEM,
						content = i18n(var_31_5),
						name = i18n(var_31_4),
						iconPath = {
							"Props/" .. var_31_3,
							var_31_3
						}
					})
				end

				return
			end, SFX_PANEL)

			return
		end
	}

	return
end

function PreviewPtHybridTemplatePage:OnUpdateFlush()
	local var_32_0 = self.ptData:getTargetLevel()
	local var_32_1 = self.activity:getConfig("config_client").story

	if checkExist(var_32_1, {
		var_32_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_32_1[var_32_0][1])
	end

	if self.step then
		local var_32_2, var_32_3, var_32_4 = self.ptData:GetLevelProgress()

		setText(self.step, var_32_2 .. "/" .. var_32_3)
	end

	local var_32_5, var_32_6, var_32_7 = self.ptData:GetResProgress()

	setText(self.progress, (var_32_7 >= 1 and setColorStr(var_32_5, COLOR_GREEN) or var_32_5) .. "/" .. var_32_6)
	setSlider(self.slider, 0, 1, var_32_7)

	local var_32_8 = self.ptData:CanGetAward()
	local var_32_9 = self.ptData:CanGetNextAward()

	setActive(self.battleBtn, self.ptData:CanGetMorePt() and not var_32_8 and var_32_9)
	setActive(self.getBtn, var_32_8)
	setActive(self.gotBtn, not var_32_9)

	local var_32_10 = self.ptData:GetAward()

	updateDrop(self.awardTF, var_32_10)
	onButton(self, self.awardTF, function()
		self:emit(BaseUI.ON_DROP, var_32_10)

		return
	end, SFX_PANEL)

	return
end

function PreviewPtHybridTemplatePage:OnDestroy()
	return
end

function PreviewPtHybridTemplatePage:GetWorldPtData(arg_35_1)
	if arg_35_1 <= pg.TimeMgr.GetInstance():GetServerTime() - (ActivityMainScene.Data2Time or 0) then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = self.ptData:GetId()
		})
	end

	return
end

return PreviewPtHybridTemplatePage
