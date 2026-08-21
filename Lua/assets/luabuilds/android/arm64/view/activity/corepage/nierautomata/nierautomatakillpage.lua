local var_0_0 = class("NieRAutomataKillPage", import("..CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.title = arg_1_0.bg:Find("title")
	arg_1_0.desc1 = arg_1_0.title:Find("desc1")
	arg_1_0.desc2 = arg_1_0.title:Find("desc2")
	arg_1_0.rtTask = arg_1_0.bg:Find("task")
	arg_1_0.step = arg_1_0.rtTask:Find("step")
	arg_1_0.nowday = arg_1_0.step:Find("nowday")
	arg_1_0.aimday = arg_1_0.step:Find("aimday")
	arg_1_0.progress = arg_1_0.rtTask:Find("progress")
	arg_1_0.slider = arg_1_0.progress:Find("slider")
	arg_1_0.awardTF = arg_1_0.progress:Find("award")
	arg_1_0.progressStep = arg_1_0.progress:Find("step")
	arg_1_0.progressRule = arg_1_0.progress:Find("rule")
	arg_1_0.BtnGroup = arg_1_0.rtTask:Find("BtnGroup")
	arg_1_0.displayBtn = arg_1_0.BtnGroup:Find("Check_btn")
	arg_1_0.battleBtn = arg_1_0.BtnGroup:Find("battle_btn")
	arg_1_0.getBtn = arg_1_0.BtnGroup:Find("get_btn")
	arg_1_0.gotBtn = arg_1_0.BtnGroup:Find("got_btn")
	arg_1_0.displayText = arg_1_0.displayBtn:Find("Text")
	arg_1_0.finishAll = false

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	if arg_2_0.ptData then
		arg_2_0.ptData:Update(arg_2_0.activity)
	else
		arg_2_0.ptData = ActivityPtData.New(arg_2_0.activity)
	end

	return
end

function var_0_0.LocalInit(arg_3_0)
	setText(arg_3_0.displayText, i18n("nier_core_award_check"))
	setText(arg_3_0.progressRule, i18n("nier_core_task_desc"))

	return
end

function var_0_0.LocalFresh(arg_4_0)
	local var_4_0, var_4_1, var_4_2 = arg_4_0.ptData:GetLevelProgress()
	local var_4_3 = "nier_2b_text_block_day"
	local var_4_4 = arg_4_0.ptData:CanGetNextAward()
	local var_4_5

	arg_4_0.finishAll = var_4_0 >= 7 and not var_4_4

	if arg_4_0.finishAll then
		var_4_5 = i18n(var_4_3 .. "_fin")

		setActive(arg_4_0.desc1, false)
	else
		var_4_5 = i18n(var_4_3 .. var_4_0)

		setText(arg_4_0.desc1, var_4_5[1].info)
	end

	setText(arg_4_0.desc2, var_4_5[2].info)
	setActive(arg_4_0.desc2, false)
	arg_4_0:Playwriter()

	return
end

function var_0_0.InitBtn(arg_5_0)
	onButton(arg_5_0, arg_5_0.displayBtn, function()
		arg_5_0:emit(ActivityMediator.SHOW_AWARD_WINDOW, PtAwardWindow, {
			blur = true,
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
	onButton(arg_5_0, arg_5_0.battleBtn, function()
		arg_5_0:emit(ActivityMediator.GO_Activity_level)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.getBtn, function()
		local var_8_0 = arg_5_0.ptData:GetAward()
		local var_8_1 = getProxy(PlayerProxy):getRawData()
		local var_8_2 = LOCK_UR_SHIP and 0 or getProxy(BagProxy):GetLimitCntById(pg.gameset.urpt_chapter_max.description[1])
		local var_8_3, var_8_4 = Task.StaticJudgeOverflow(var_8_1.gold, var_8_1.oil, var_8_2, true, true, {
			{
				var_8_0.type,
				var_8_0.id,
				var_8_0.count
			}
		})

		if var_8_3 then
			table.insert({}, function(arg_9_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					type = MSGBOX_TYPE_ITEM_BOX,
					content = i18n("award_max_warning"),
					items = var_8_4,
					onYes = arg_9_0
				})

				return
			end)
		end

		seriesAsync({}, function()
			local var_10_0, var_10_1 = arg_5_0.ptData:GetResProgress()

			arg_5_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
				cmd = 1,
				activity_id = arg_5_0.ptData:GetId(),
				arg1 = var_10_1
			})

			return
		end)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.GetTypewriterSpeed(arg_11_0)
	local var_11_0 = arg_11_0.activity:getConfig("config_client").typewriterSpeed

	return var_11_0 and var_11_0 or 0.1
end

function var_0_0.InvalidateWriter(arg_12_0)
	local var_12_0 = arg_12_0.writerToken or 0

	arg_12_0.writerToken = var_12_0 + 1

	if arg_12_0.desc1 then
		GetOrAddComponent(arg_12_0.desc1, typeof(Typewriter)).endFunc = nil
	end

	if arg_12_0.desc2 then
		GetOrAddComponent(arg_12_0.desc2, typeof(Typewriter)).endFunc = nil
	end

	return
end

function var_0_0.Playwriter(arg_13_0)
	arg_13_0:InvalidateWriter()

	local var_13_0 = arg_13_0.writerToken

	local function var_13_1()
		local var_14_0 = arg_13_0.writerToken == var_13_0 and arg_13_0._go and isActive(arg_13_0._go) or false

		if false then
			var_14_0 = true
		end

		return var_14_0
	end

	local var_13_2 = {}

	if not arg_13_0.finishAll then
		table.insert(var_13_2, function(arg_15_0)
			if not var_13_1() then
				return
			end

			local var_15_0 = GetOrAddComponent(arg_13_0.desc1, typeof(Typewriter))

			function var_15_0.endFunc()
				if not var_13_1() then
					return
				end

				arg_15_0()

				return
			end

			var_15_0:setSpeed(arg_13_0:GetTypewriterSpeed())
			var_15_0:Play()

			return
		end)
	else
		local var_13_3, var_13_4, var_13_5 = arg_13_0.ptData:GetLevelProgress()

		table.insert(var_13_2, function(arg_17_0)
			local var_17_0 = checkExist(arg_13_0.activity:getConfig("config_client").story, {
				var_13_3
			}, {
				1
			})

			if var_17_0 then
				if not pg.NewStoryMgr.GetInstance():IsPlayed(var_17_0) then
					pg.NewStoryMgr.GetInstance():Play(var_17_0, function()
						if not var_13_1() then
							return
						end

						arg_17_0()

						return
					end)

					goto label_17_0
				end
			end

			arg_17_0()

			::label_17_0::

			return
		end)
	end

	table.insert(var_13_2, function(arg_19_0)
		if not var_13_1() then
			return
		end

		local var_19_0 = arg_13_0.desc2

		setActive(arg_13_0.desc2, true)

		local var_19_1 = GetOrAddComponent(var_19_0, typeof(Typewriter))

		function var_19_1.endFunc()
			if not var_13_1() then
				return
			end

			arg_19_0()

			return
		end

		var_19_1:setSpeed(arg_13_0:GetTypewriterSpeed())
		var_19_1:Play()

		return
	end)
	seriesAsync(var_13_2)

	return
end

function var_0_0.OnFirstFlush(arg_21_0)
	arg_21_0:LocalInit()
	arg_21_0:LocalFresh()
	arg_21_0:InitBtn()
	arg_21_0:Hx4Channel()

	return
end

function var_0_0.OnUpdateFlush(arg_22_0)
	local var_22_0 = arg_22_0.ptData:getTargetLevel()
	local var_22_1, var_22_2, var_22_3 = arg_22_0.ptData:GetLevelProgress()

	setText(arg_22_0.nowday, string.format("%s", var_22_1))
	setText(arg_22_0.aimday, string.format("/%s", var_22_2))
	arg_22_0:LocalFresh()

	local var_22_4, var_22_5, var_22_6 = arg_22_0.ptData:GetResProgress()
	local var_22_7 = var_22_6 >= 1 and setColorStr(var_22_4, COLOR_GREEN) or var_22_4

	setText(arg_22_0.progressStep, string.format("%s<color=#ffffff33>/%s</color>", var_22_7, var_22_5))
	setSlider(arg_22_0.slider, 0, 1, var_22_6)

	local var_22_8 = arg_22_0.ptData:CanGetAward()
	local var_22_9 = arg_22_0.ptData:CanGetNextAward()

	setActive(arg_22_0.battleBtn, arg_22_0.ptData:CanGetMorePt() and not var_22_8 and var_22_9)
	setActive(arg_22_0.getBtn, var_22_8)
	setActive(arg_22_0.gotBtn, not var_22_9)
	updateDrop(arg_22_0.awardTF, (arg_22_0.ptData:GetAward()))
	onButton(arg_22_0, arg_22_0.awardTF, function()
		arg_22_0:emit(BaseUI.ON_DROP, var_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnDestroy(arg_24_0)
	return
end

function var_0_0.GetWorldPtData(arg_25_0, arg_25_1)
	local var_25_0 = ActivityMainScene.Data2Time or 0

	if arg_25_1 <= pg.TimeMgr.GetInstance():GetServerTime() - var_25_0 then
		ActivityMainScene.Data2Time = pg.TimeMgr.GetInstance():GetServerTime()

		arg_25_0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 2,
			activity_id = arg_25_0.ptData:GetId()
		})
	end

	return
end

local function var_0_1(arg_26_0)
	return (arg_26_0._tf:Find("rw/hx_ch" .. pg.SdkMgr.GetInstance():GetChannelUIDIncludeHarmony()))
end

function var_0_0.Hx4Channel(arg_27_0)
	local var_27_0 = var_0_1(arg_27_0)

	if not IsNil(var_27_0) then
		setActive(var_27_0, HXSet.isHx())
	end

	return
end

function var_0_0.OnHideFlush(arg_28_0)
	arg_28_0:InvalidateWriter()

	return
end

function var_0_0.OnDestroy(arg_29_0)
	arg_29_0:InvalidateWriter()

	return
end

return var_0_0
