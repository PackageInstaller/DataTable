class = var_0_10000

local var_0_0 = "AnniversaryNineHwahJahSkinPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.activity.CorePage.OutPost.OutPostOmenPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "bg")

	local var_1_1 = arg_1_0.bg

	arg_1_0.dayTF = var_1.Find(var_1_1, "total_progress/day")

	local var_1_2 = arg_1_0.bg

	arg_1_0.maxDayTF = var_1.Find(var_1_2, "total_progress/max_day")

	local var_1_3 = arg_1_0.bg

	arg_1_0.item = var_1.Find(var_1_3, "item")

	local var_1_4 = arg_1_0.bg

	arg_1_0.items = var_1.Find(var_1_4, "items")
	UIItemList = var_1
	arg_1_0.uilist = var_1.New(arg_1_0.items, arg_1_0.item)

	local var_1_5 = arg_1_0.bg

	arg_1_0.btnDetail = var_1.Find(var_1_5, "btn_detail")

	local var_1_6 = arg_1_0.btnDetail

	arg_1_0.txtDetail = var_1.Find(var_1_6, "detail")

	local var_1_7 = arg_1_0.bg

	arg_1_0.btnStory = var_1.Find(var_1_7, "btn_story")
	AnniversaryNineHwahJahTaskWindow = var_1
	arg_1_0.taskWindow = var_1.New(arg_1_0._tf, arg_1_0.event)
	setActive = var_1

	var_1(arg_1_0.item, false)

	local var_1_8 = arg_1_0.bg

	arg_1_0.progressLabel = var_1.Find(var_1_8, "total_progress/label_1")
	setText = var_1

	local var_1_9 = arg_1_0.progressLabel

	i18n = var_3

	var_1(var_1_9, var_3("Outpost_20250904_Progress"))

	setText = var_1

	local var_1_10 = arg_1_0.txtDetail

	i18n = var_3

	var_1(var_1_10, var_3("Outpost_20260514_Detail"))

	return
end

function var_0_1.OnFirstFlush(arg_2_0)
	var_0_1.super.OnFirstFlush(arg_2_0)
	arg_2_0:playStory()

	return
end

function var_0_1.OnUpdateFlush(arg_3_0)
	local var_3_0 = #arg_3_0.taskGroup

	arg_3_0.nday = arg_3_0:getTaskIdx(arg_3_0.activity)

	arg_3_0:PlayStory()

	if arg_3_0.dayTF then
		setText = var_2

		var_2(arg_3_0.dayTF, arg_3_0.nday)

		setText = var_2

		var_2(arg_3_0.maxDayTF, "/" .. var_3_0)
	end

	local var_3_1 = arg_3_0.uilist

	var_2.align(var_3_1, #arg_3_0.taskGroup[arg_3_0.nday])

	local var_3_2 = arg_3_0.taskWindow

	if var_2.isShowing(var_3_2) then
		local var_3_3 = arg_3_0.taskWindow

		var_2.ExecuteAction(var_3_3, "Show", arg_3_0.activity)
	end

	return
end

function var_0_1.UpdateTask(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1 + 1
	local var_4_1 = arg_4_2:Find("item")
	local var_4_2 = arg_4_0.taskGroup[arg_4_0.nday][var_4_0]
	local var_4_3 = arg_4_0.taskProxy
	local var_4_4

	if not var_6.getTaskById(var_4_3, var_4_2) then
		var_4_3 = arg_4_0.taskProxy
		var_4_4 = var_6.getFinishTaskById(var_4_3, var_4_2)
	end

	assert = var_4_3

	var_4_3(var_4_4, "without this task by id: " .. var_4_2)

	Drop = var_4_3

	local var_4_5 = var_4_3.Create(var_4_4:getConfig("award_display")[1])

	updateDrop = var_8

	var_8(var_4_1, var_4_5)

	onButton = var_8

	local var_4_6 = arg_4_0
	local var_4_7 = var_4_1

	local function var_4_8()
		local var_5_0 = arg_4_0
		local var_5_1 = var_0.emit

		BaseUI = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_DROP, var_4_5)

		return
	end

	SFX_PANEL = var_1_10012

	var_8(var_4_6, var_4_7, var_4_8, var_1_10012)

	local var_4_9 = var_4_4:getProgress()
	local var_4_10 = var_4_4:getConfig("target_num")
	local var_4_11 = var_4_4
	local var_4_12 = var_4_4.getConfig(var_4_11, "desc")

	utf8 = var_4_11

	if var_4_11.len(var_4_12) >= 11 then
		setScrollText = var_11
		var_1_10013 = arg_4_2

		var_11(arg_4_2.Find(var_1_10013, "mask/description"), var_4_12)
	else
		setText = var_11
		var_1_10013 = arg_4_2

		var_11(arg_4_2.Find(var_1_10013, "mask/description"), var_4_12)
	end

	local var_4_13, var_4_14 = arg_4_0:GetProgressColor()

	if var_4_13 then
		setColorStr = var_1_10013

		local var_4_15

		if not var_1_10013(var_4_9, var_4_13) then
			::label_4_0::

			var_4_15 = var_4_9
		end

		if var_4_14 then
			setColorStr = var_1_10013

			local var_4_16

			if not var_1_10013("/" .. var_4_10, var_4_14) then
				::label_4_1::

				var_4_16 = "/" .. var_4_10
			end

			setText = var_1_10013

			var_1_10013(arg_4_2:Find("progressText"), var_4_15 .. var_4_16)

			setSlider = var_1_10013

			var_1_10013(arg_4_2:Find("progress"), 0, var_4_10, var_4_9)

			local var_4_17 = arg_4_2:Find("go_btn")
			local var_4_18 = arg_4_2:Find("get_btn")
			local var_4_19 = arg_4_2:Find("got_btn")
			local var_4_20 = var_4_4
			local var_4_21 = var_4_4.getTaskStatus(var_4_20)

			setActive = var_4_20

			var_4_20(var_4_17, var_4_21 == 0)

			setActive = var_4_20

			var_4_20(var_4_18, var_4_21 == 1)

			setActive = var_4_20

			var_4_20(var_4_19, var_4_21 == 2)

			onButton = var_4_20

			local var_4_22 = arg_4_0
			local var_4_23 = var_4_17

			local function var_4_24()
				local var_6_0 = arg_4_0
				local var_6_1 = var_0.emit

				ActivityMediator = var_2_10002

				var_6_1(var_6_0, var_2_10002.ON_TASK_GO, var_4_4)

				return
			end

			SFX_PANEL = var_1_10021

			var_4_20(var_4_22, var_4_23, var_4_24, var_1_10021)

			onButton = var_4_20

			local var_4_25 = arg_4_0
			local var_4_26 = var_4_18

			local function var_4_27()
				local var_7_0 = {}
				local var_7_1 = var_4_4
				local var_7_2 = var_1.getConfig(var_7_1, "award_display")

				getProxy = var_7_1
				PlayerProxy = var_3

				local var_7_3 = var_7_1(var_3)
				local var_7_4 = var_2.getRawData(var_7_3)

				pg = var_7_3

				local var_7_5 = var_7_3.gameset.urpt_chapter_max.description[1]

				LOCK_UR_SHIP = var_2_10005

				if var_2_10005 then
					var_2_10005 = 0
				else
					getProxy = var_2_10005
					BagProxy = var_2_10006
					var_2_10006 = var_2_10005(var_2_10006)
					var_2_10005 = var_2_10005.GetLimitCntById(var_2_10006, var_7_5)
				end

				Task = var_2_10006

				local var_7_6, var_7_7 = var_2_10006.StaticJudgeOverflow(var_7_4.gold, var_7_4.oil, var_2_10005, true, true, var_7_2)

				if var_7_6 then
					table = var_8

					var_8.insert(var_7_0, function(arg_8_0)
						pg = var_3_10001

						local var_8_0 = var_3_10001.MsgboxMgr.GetInstance()
						local var_8_1 = var_1.ShowMsgBox
						local var_8_2 = {}

						MSGBOX_TYPE_ITEM_BOX = var_3_10004
						var_8_2.type = var_3_10004
						i18n = var_3_10004
						var_8_2.content = var_3_10004("award_max_warning")
						var_8_2.items = var_7_7
						var_8_2.onYes = arg_8_0

						var_8_1(var_8_0, var_8_2)

						return
					end)
				end

				seriesAsync = var_8

				var_8(var_7_0, function()
					local var_9_0 = arg_4_0
					local var_9_1 = var_0.emit

					ActivityMediator = var_3_10002

					var_9_1(var_9_0, var_3_10002.ON_TASK_SUBMIT, var_4_4)

					return
				end)

				return
			end

			SFX_PANEL = var_1_10021

			var_4_20(var_4_25, var_4_26, var_4_27, var_1_10021)

			return
		end
	end
end

function var_0_1.playStory(arg_10_0)
	local var_10_0 = arg_10_0.activity

	arg_10_0.storyList = var_1.getConfig(var_10_0, "config_client").story
	pg = var_1

	local var_10_1 = var_1.NewStoryMgr.GetInstance()

	if not var_1.IsPlayed(var_10_1, arg_10_0.storyList[1][1]) then
		pg = var_10_1

		local var_10_2 = var_10_1.NewStoryMgr.GetInstance()
		local var_10_3, var_10_4 = var_2.StoryName2StoryId(var_10_2, arg_10_0.storyList[1][1])

		pg = var_4

		local var_10_5 = var_4.m02
		local var_10_6 = var_4.sendNotification

		GAME = var_1_10006

		var_10_6(var_10_5, var_1_10006.STORY_UPDATE_LIST, {
			storyIds = {
				var_10_3
			}
		})
	end

	return
end

return var_0_1
