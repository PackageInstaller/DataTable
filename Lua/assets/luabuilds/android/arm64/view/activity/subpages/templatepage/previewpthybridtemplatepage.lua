local var_0_0 = class("PreviewPtHybridTemplatePage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.btnList = arg_1_0.bg:Find("btn_list")
	arg_1_0.battleBtn = arg_1_0.btnList:Find("fight")
	arg_1_0.getBtn = arg_1_0.btnList:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.btnList:Find("got_btn")
	arg_1_0.ptList = arg_1_0.bg:Find("pt_list")
	arg_1_0.slider = arg_1_0.ptList:Find("slider")
	arg_1_0.step = arg_1_0.ptList:Find("step")
	arg_1_0.progress = arg_1_0.ptList:Find("progress")
	arg_1_0.awardTF = arg_1_0.ptList:Find("award")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0:initBtn()
	eachChild(arg_2_0.btnList, function(arg_3_0)
		arg_2_0.btnFuncList[arg_3_0.name](arg_3_0)

		return
	end)

	return
end

function var_0_0.OnDataSetting(arg_4_0)
	if arg_4_0.ptData then
		arg_4_0.ptData:Update(arg_4_0.activity)
	else
		arg_4_0.ptData = ActivityPtData.New(arg_4_0.activity)
	end

	return
end

function var_0_0.initBtn(arg_5_0)
	local function var_5_0(arg_6_0)
		local var_6_0 = getProxy(ActivityProxy):getActivityById(arg_6_0)

		if not var_6_0 or var_6_0 and var_6_0:isEnd() then
			return true
		else
			return false
		end

		return
	end

	local var_5_1 = arg_5_0.activity:getConfig("config_client")

	arg_5_0.btnFuncList = {
		task = function(arg_7_0)
			onButton(arg_5_0, arg_7_0, function()
				if var_5_1.taskLinkActID and var_5_0(var_5_1.taskLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				arg_5_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.TASK, {
					page = "activity"
				})

				return
			end)

			return
		end,
		shop = function(arg_9_0)
			onButton(arg_5_0, arg_9_0, function()
				if var_5_1.shopLinkActID then
					local var_10_0 = getProxy(ActivityProxy):getActivitiesById(var_5_1.shopLinkActID) or underscore.detect(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP), function(arg_11_0)
						return not arg_11_0:isEnd()
					end)

					if not var_10_0 or var_10_0:isEnd() then
						pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

						return
					end

					arg_5_0:emit(ActivityMediator.GO_SHOPS_LAYER, {
						warp = NewShopsScene.TYPE_ACTIVITY,
						actId = var_10_0.id
					})

					return
				end
			end)

			return
		end,
		build = function(arg_12_0)
			onButton(arg_5_0, arg_12_0, function()
				if var_5_1.buildLinkActID and var_5_0(var_5_1.buildLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				arg_5_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.GETBOAT, {
					page = BuildShipScene.PAGE_BUILD,
					projectName = BuildShipScene.PROJECTS.ACTIVITY
				})

				return
			end)

			return
		end,
		fight = function(arg_14_0)
			onButton(arg_5_0, arg_14_0, function()
				if var_5_1.fightLinkActID and var_5_0(var_5_1.fightLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				arg_5_0:emit(ActivityMediator.BATTLE_OPERA)

				return
			end)

			return
		end,
		lottery = function(arg_16_0)
			onButton(arg_5_0, arg_16_0, function()
				if var_5_1.lotteryLinkActID and var_5_0(var_5_1.lotteryLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				arg_5_0:emit(ActivityMediator.GO_LOTTERY)

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
			onButton(arg_5_0, arg_21_0, function()
				arg_5_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.SKINSHOP)

				return
			end)

			return
		end,
		display_btn = function(arg_23_0)
			onButton(arg_5_0, arg_23_0, function()
				arg_5_0:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
					type = arg_5_0.ptData.type,
					dropList = arg_5_0.ptData.dropList,
					targets = arg_5_0.ptData.targets,
					level = arg_5_0.ptData.level,
					count = arg_5_0.ptData.count,
					resId = arg_5_0.ptData.resId,
					unlockStamps = arg_5_0.ptData:GetDayUnlockStamps()
				})

				return
			end, SFX_PANEL)

			return
		end,
		get_btn = function(arg_25_0)
			onButton(arg_5_0, arg_25_0, function()
				local var_26_0 = arg_5_0.ptData:GetAward()
				local var_26_1 = getProxy(PlayerProxy):getRawData()
				local var_26_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
				local var_26_3, var_26_4 = Task.StaticJudgeOverflow(var_26_1.gold, var_26_1.oil, var_26_2, true, true, {
					{
						var_26_0.type,
						var_26_0.id,
						var_26_0.count
					}
				})

				if var_26_3 then
					table.insert({}, function(arg_27_0)
						pg.MsgboxMgr.GetInstance():ShowMsgBox({
							type = MSGBOX_TYPE_ITEM_BOX,
							content = i18n("award_max_warning"),
							items = var_26_4,
							onYes = arg_27_0
						})

						return
					end)
				end

				seriesAsync({}, function()
					local var_28_0, var_28_1 = arg_5_0.ptData:GetResProgress()

					arg_5_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
						cmd = 1,
						activity_id = arg_5_0.ptData:GetId(),
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
			onButton(arg_5_0, arg_30_0, function()
				local var_31_9000

				if var_5_1.boostLinkActID and var_5_0(var_5_1.boostLinkActID) then
					pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_end"))

					return
				end

				local var_31_0 = getProxy(ActivityProxy)
				local var_31_1 = var_31_0.getActivityById(var_31_9000, var_5_1.boostLinkActID)
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

function var_0_0.OnUpdateFlush(arg_32_0)
	local var_32_0 = arg_32_0.ptData:getTargetLevel()
	local var_32_1 = arg_32_0.activity:getConfig("config_client").story

	if checkExist(var_32_1, {
		var_32_0
	}, {
		1
	}) then
		pg.NewStoryMgr.GetInstance():Play(var_32_1[var_32_0][1])
	end

	if arg_32_0.step then
		local var_32_2, var_32_3, var_32_4 = arg_32_0.ptData:GetLevelProgress()

		setText(arg_32_0.step, var_32_2 .. "/" .. var_32_3)
	end

	local var_32_5, var_32_6, var_32_7 = arg_32_0.ptData:GetResProgress()
	local var_32_8 = var_32_7 >= 1 and setColorStr(var_32_5, COLOR_GREEN) or var_32_5

	setText(arg_32_0.progress, var_32_8 .. "/" .. var_32_6)
	setSlider(arg_32_0.slider, 0, 1, var_32_7)

	local var_32_9 = arg_32_0.ptData:CanGetAward()
	local var_32_10 = arg_32_0.ptData:CanGetNextAward()

	setActive(arg_32_0.battleBtn, arg_32_0.ptData:CanGetMorePt() and not var_32_9 and var_32_10)
	setActive(arg_32_0.getBtn, var_32_9)
	setActive(arg_32_0.gotBtn, not var_32_10)
	updateDrop(arg_32_0.awardTF, (arg_32_0.ptData:GetAward()))
	onButton(arg_32_0, arg_32_0.awardTF, function()
		arg_32_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_34_0)
	return
end

function var_0_0.GetWorldPtData(arg_35_0, arg_35_1)
	local var_35_0 = ActivityMainScene.Data2Time or 0

	if arg_35_1 <= pg.TimeMgr.GetInstance():GetServerTime() - var_35_0 then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		arg_35_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = arg_35_0.ptData:GetId()
		})
	end

	return
end

return var_0_0
