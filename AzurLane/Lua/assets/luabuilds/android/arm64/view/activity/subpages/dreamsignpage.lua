class = var_0_10000

local var_0_0 = "DreamSignPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	PLATFORM_CODE = var_1_10001
	PLATFORM_CH = var_1_10002
	var_1_10001 = var_1_10001 == var_1_10002 and var_1_10001
	arg_1_0.lockNamed = var_1_10001

	local var_1_0 = arg_1_0._tf

	arg_1_0.bg = var_1.Find(var_1_0, "AD")

	local var_1_1 = arg_1_0.bg

	arg_1_0.signTF = var_1.Find(var_1_1, "sign")

	local var_1_2 = arg_1_0.signTF

	arg_1_0.items = var_1.Find(var_1_2, "items")
	UIItemList = var_1

	local var_1_3 = var_1.New
	local var_1_4 = arg_1_0.items
	local var_1_5 = arg_1_0.items

	arg_1_0.uilist = var_1_3(var_1_4, var_4.Find(var_1_5, "tpl"))

	local var_1_6 = arg_1_0.signTF

	arg_1_0.signBtn = var_1.Find(var_1_6, "get")

	local var_1_7 = arg_1_0.signTF

	arg_1_0.goBtn = var_1.Find(var_1_7, "go")

	local var_1_8 = arg_1_0.signTF

	arg_1_0.lock = var_1.Find(var_1_8, "lock")

	local var_1_9 = arg_1_0.signBtn

	arg_1_0.countText = var_1.Find(var_1_9, "count")

	local var_1_10 = arg_1_0.signBtn

	arg_1_0.signRed = var_1.Find(var_1_10, "tip")

	local var_1_11 = arg_1_0.goBtn

	arg_1_0.dreamRed = var_1.Find(var_1_11, "tip")

	return
end

function var_0_1.OnDataSetting(arg_2_0)
	arg_2_0.nday = 0
	getProxy = var_1
	TaskProxy = var_1_10003
	arg_2_0.taskProxy = var_1(var_1_10003)
	underscore = var_1

	local var_2_0 = var_1.flatten
	local var_2_1 = arg_2_0.activity

	arg_2_0.taskGroup = var_2_0(var_3.getConfig(var_2_1, "config_data"))
	pg = var_1
	arg_2_0.taskConfig = var_1.task_data_template
	updateActivityTaskStatus = var_1

	return var_1(arg_2_0.activity)
end

function var_0_1.OnFirstFlush(arg_3_0)
	local var_3_0 = arg_3_0.uilist

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		local var_4_0

		if arg_4_0 == var_2_10003.EventInit then
			var_4_0 = arg_4_1 + 1

			local var_4_1 = arg_3_0.taskGroup[var_4_0]
			local var_4_2 = arg_4_2
			local var_4_3 = arg_4_2.Find(var_4_2, "item_mask/item")

			Drop = var_2_10006
			var_2_10006 = var_2_10006.Create(arg_3_0.taskConfig[var_4_1].award_display[1])
			updateDrop = var_4_2

			var_4_2(var_4_3, var_2_10006)

			onButton = var_4_2

			local var_4_4 = arg_3_0
			local var_4_5 = arg_4_2

			local function var_4_6()
				local var_5_0 = arg_3_0
				local var_5_1 = var_0.emit

				BaseUI = var_3_10003

				var_5_1(var_5_0, var_3_10003.ON_DROP, var_2_10006)

				return
			end

			SFX_PANEL = var_2_10012

			var_4_2(var_4_4, var_4_5, var_4_6, var_2_10012)
		else
			UIItemList = var_4_0

			if arg_4_0 == var_4_0.EventUpdate then
				local var_4_7 = arg_4_1 + 1
				local var_4_8 = arg_3_0.taskGroup[var_4_7]
				local var_4_9 = arg_3_0.taskProxy
				local var_4_11

				if not var_5.getTaskById(var_4_9, var_4_8) then
					local var_4_10 = arg_3_0.taskProxy

					var_4_11 = var_5.getFinishTaskById(var_4_10, var_4_8)
				end

				setActive = var_2_10006

				var_2_10006(arg_4_2:Find("got"), var_4_7 < arg_3_0.nday or var_4_11 and var_4_11:getTaskStatus() == 2)
			end
		end

		return
	end)

	onButton = var_1

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.signBtn

	local function var_3_3()
		if not arg_3_0.remainCnt or arg_3_0.remainCnt <= 0 then
			return
		end

		seriesAsync = var_0

		var_0({
			function(arg_7_0)
				local var_7_0 = arg_3_0.activity
				local var_7_1 = var_1.getConfig(var_7_0, "config_client").story

				checkExist = var_3_10002

				if var_3_10002(var_7_1, {
					arg_3_0.nday
				}, {
					1
				}) then
					pg = var_2

					local var_7_2 = var_2.NewStoryMgr.GetInstance()

					var_2.Play(var_7_2, var_7_1[arg_3_0.nday][1], arg_7_0)
				else
					arg_7_0()
				end

				return
			end,
			function(arg_8_0)
				local var_8_0 = arg_3_0.curTaskVO

				if var_1.getTaskStatus(var_8_0) == 1 then
					local var_8_1 = arg_3_0
					local var_8_2 = var_1.emit

					ActivityMediator = var_3_10004

					var_8_2(var_8_1, var_3_10004.ON_TASK_SUBMIT, arg_3_0.curTaskVO, arg_8_0)
				else
					arg_8_0()
				end

				return
			end
		})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_1, var_3_2, var_3_3, var_1_10006)

	onButton = var_1

	local var_3_4 = arg_3_0
	local var_3_5 = arg_3_0.goBtn

	local function var_3_6()
		local var_9_0 = arg_3_0

		if var_0.IsLock(var_9_0) then
			return
		end

		local var_9_1 = arg_3_0
		local var_9_2 = var_0.emit

		ActivityMediator = var_2_10003

		local var_9_3 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_9_2(var_9_1, var_9_3, var_2_10004.DREAMLAND)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_4, var_3_5, var_3_6, var_1_10006)

	return
end

function var_0_1.OnUpdateFlush(arg_10_0)
	arg_10_0.nday = arg_10_0.activity.data3

	local var_10_0 = arg_10_0.taskGroup[arg_10_0.nday]
	local var_10_1 = arg_10_0.taskProxy
	local var_10_3

	if not var_2.getTaskById(var_10_1, var_10_0) then
		local var_10_2 = arg_10_0.taskProxy

		var_10_3 = var_2.getFinishTaskById(var_10_2, var_10_0)
	end

	arg_10_0.curTaskVO = var_10_3
	math = var_10_3

	local var_10_4 = var_10_3.min
	local var_10_5 = arg_10_0.activity

	arg_10_0.remainCnt = var_10_4(var_4.getDayIndex(var_10_5), #arg_10_0.taskGroup) - arg_10_0.nday

	local var_10_6 = arg_10_0.curTaskVO

	if var_3.getTaskStatus(var_10_6) == 1 then
		arg_10_0.remainCnt = arg_10_0.remainCnt + 1
	end

	local var_10_7 = arg_10_0:IsFinishSign()

	setActive = var_4

	var_4(arg_10_0.signBtn, not var_10_7)

	setActive = var_4

	var_4(arg_10_0.goBtn, var_10_7)

	setActive = var_4

	var_4(arg_10_0.lock, var_10_7 and arg_10_0:IsLock())

	setActive = var_4

	var_4(arg_10_0.signRed, arg_10_0.remainCnt > 0)

	setActive = var_4

	local var_10_8 = arg_10_0.dreamRed

	DreamlandFullPreviewScene = var_7

	var_4(var_10_8, var_7.DreamlandTip())

	setText = var_4

	local var_10_9 = arg_10_0.countText

	i18n = var_7

	var_4(var_10_9, var_7("liner_sign_cnt_tip") .. arg_10_0.remainCnt)

	local var_10_10 = arg_10_0.uilist

	var_4.align(var_10_10, #arg_10_0.taskGroup)

	return
end

function var_0_1.IsFinishSign(arg_11_0)
	local var_11_0 = arg_11_0.taskGroup[#arg_11_0.taskGroup]
	local var_11_1 = arg_11_0.taskProxy
	local var_11_3

	if not var_2.getTaskById(var_11_1, var_11_0) then
		local var_11_2 = arg_11_0.taskProxy

		var_11_3 = var_2.getFinishTaskById(var_11_2, var_11_0)
	end

	return var_11_3 and var_11_3:getTaskStatus() == 2
end

function var_0_1.IsLock(arg_12_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_12_0 = var_1_10001(var_1_10003)
	local var_12_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	return not var_12_1(var_12_0, var_1_10004.DREAMLAND_JP_ID) or var_1:isEnd()
end

return var_0_1
