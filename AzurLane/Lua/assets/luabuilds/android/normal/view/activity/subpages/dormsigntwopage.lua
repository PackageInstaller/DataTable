class = var_0_10000

local var_0_0 = "DormSignTwoPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseActivityPage"))

function var_0_1.getUIName(arg_1_0)
	return "DormSignTwoPage"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.bg = var_1.Find(var_2_0, "AD")

	local var_2_1 = arg_2_0.bg

	arg_2_0.items = var_1.Find(var_2_1, "items")
	UIItemList = var_1

	local var_2_2 = var_1.New
	local var_2_3 = arg_2_0.items
	local var_2_4 = arg_2_0.items

	arg_2_0.uilist = var_2_2(var_2_3, var_3.Find(var_2_4, "tpl"))

	local var_2_5 = arg_2_0.bg

	arg_2_0.goBtn = var_1.Find(var_2_5, "btn_go")

	local var_2_6 = arg_2_0.bg

	arg_2_0.lockTF = var_1.Find(var_2_6, "lock")

	return
end

function var_0_1.OnDataSetting(arg_3_0)
	getProxy = var_1_10001
	ActivityTaskProxy = var_1_10002
	arg_3_0.actTaskProxy = var_1_10001(var_1_10002)
	underscore = var_1

	local var_3_0 = var_1.flatten
	local var_3_1 = arg_3_0.activity

	arg_3_0.taskGroup = var_3_0(var_2.getConfig(var_3_1, "config_data"))
	pg = var_1
	arg_3_0.taskConfig = var_1.task_data_template

	return
end

function var_0_1.UpdateTaskData(arg_4_0)
	local var_4_0 = arg_4_0.actTaskProxy

	arg_4_0.taskVOs = var_1.getTaskById(var_4_0, arg_4_0.activity.id)

	local var_4_1 = arg_4_0.actTaskProxy

	arg_4_0.finishTaksVOs = var_1.getFinishTaskById(var_4_1, arg_4_0.activity.id)
	arg_4_0.taskDic = {}
	_ = var_1

	var_1.each(arg_4_0.taskVOs, function(arg_5_0)
		arg_4_0.taskDic[arg_5_0.id] = arg_5_0

		return
	end)

	_ = var_1

	var_1.each(arg_4_0.finishTaksVOs, function(arg_6_0)
		arg_4_0.taskDic[arg_6_0.id] = arg_6_0

		return
	end)

	return
end

function var_0_1.OnFirstFlush(arg_7_0)
	local var_7_0 = arg_7_0.uilist

	var_1.make(var_7_0, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		local var_8_0

		if arg_8_0 == var_2_10003.EventInit then
			var_8_0 = arg_8_1 + 1

			local var_8_1 = arg_7_0.taskGroup[var_8_0]

			var_2_10006 = arg_8_2

			local var_8_2 = arg_8_2.Find(var_2_10006, "item")

			Drop = var_2_10006
			var_2_10006 = var_2_10006.Create(arg_7_0.taskConfig[var_8_1].award_display[1])

			if 1 < var_8_0 then
				updateDrop = var_7

				var_7(var_8_2, var_2_10006)
			end

			onButton = var_7

			local var_8_3 = arg_7_0
			local var_8_4 = arg_8_2

			local function var_8_5()
				if arg_7_0.taskDic[var_8_1] then
					local var_9_0 = arg_7_0.taskDic[var_8_1]

					if var_0.getTaskStatus(var_9_0) == 1 then
						local var_9_1 = arg_7_0.taskDic[var_8_1]

						if not var_0.isOver(var_9_1) then
							local var_9_2 = arg_7_0
							local var_9_3 = var_0.emit

							ActivityMediator = var_3_10002

							var_9_3(var_9_2, var_3_10002.ON_ACTIVITY_TASK_SUBMIT, {
								activityId = arg_7_0.activity.id,
								id = var_8_1
							})

							goto label_9_0
						end
					end
				end

				do
					local var_9_4 = arg_7_0
					local var_9_5 = var_0.emit

					BaseUI = var_3_10002

					var_9_5(var_9_4, var_3_10002.ON_DROP, var_2_10006)
				end

				::label_9_0::

				return
			end

			SFX_PANEL = var_2_10011

			var_7(var_8_3, var_8_4, var_8_5, var_2_10011)
		else
			UIItemList = var_8_0

			if arg_8_0 == var_8_0.EventUpdate then
				local var_8_6 = arg_8_1 + 1
				local var_8_7 = arg_7_0.taskGroup[var_8_6]
				local var_8_8 = arg_7_0.taskDic[var_8_7]

				setActive = var_2_10006

				var_2_10006(arg_8_2:Find("got"), var_8_8 and var_8_8:isOver())

				setActive = var_2_10006

				var_2_10006(arg_8_2:Find("get_bg"), var_8_8 and var_8_8:getTaskStatus() == 1 and not var_8_8:isOver())
			end
		end

		return
	end)

	onButton = var_1

	local var_7_1 = arg_7_0
	local var_7_2 = arg_7_0.goBtn

	local function var_7_3()
		local var_10_0 = arg_7_0
		local var_10_1 = var_0.emit

		ActivityMediator = var_2_10002

		local var_10_2 = var_2_10002.EVENT_GO_SCENE

		SCENE = var_2_10003

		var_10_1(var_10_0, var_10_2, var_2_10003.DORM3DSELECT)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_7_1, var_7_2, var_7_3, var_1_10005)

	pg = var_1

	local var_7_4 = var_1.SystemOpenMgr.GetInstance()
	local var_7_5 = var_1.isOpenSystem

	getProxy = var_7_2
	PlayerProxy = var_7_3

	local var_7_6 = var_7_2(var_7_3)
	local var_7_7 = var_7_5(var_7_4, var_3.getRawData(var_7_6).level, "SelectDorm3DMediator")

	setActive = var_7_4

	var_7_4(arg_7_0.goBtn, var_7_7)

	setActive = var_7_4

	var_7_4(arg_7_0.lockTF, not var_7_7)

	PlayerPrefs = var_7_4

	var_7_4.SetString("DormSignTwoPage", var_0_1.GetDate())

	return
end

function var_0_1.OnUpdateFlush(arg_11_0)
	arg_11_0:UpdateTaskData()

	local var_11_0 = arg_11_0.uilist

	var_1.align(var_11_0, #arg_11_0.taskGroup)

	return
end

function var_0_1.GetDate()
	pg = var_1_10000

	local var_12_0 = var_1_10000.TimeMgr.GetInstance()
	local var_12_1 = var_0.STimeDescC

	pg = var_1_10002

	local var_12_2 = var_1_10002.TimeMgr.GetInstance()

	return var_12_1(var_12_0, var_2.GetServerTime(var_12_2), "%Y/%m/%d")
end

function var_0_1.IsShowRed()
	local var_13_0

	if not var_0_1.IsShowGoRed() then
		var_13_0 = var_0_1.IsShowAwardRed()
	end

	return var_13_0
end

function var_0_1.IsShowGoRed()
	PlayerPrefs = var_1_10000

	return var_1_10000.GetString("DormSignTwoPage", "") ~= var_0_1.GetDate()
end

function var_0_1.IsShowAwardRed()
	getProxy = var_1_10000
	ActivityTaskProxy = var_1_10001

	local var_15_0 = var_1_10000(var_1_10001)
	local var_15_1 = var_0.getTaskById

	ActivityConst = var_1_10002

	local var_15_2 = var_15_1(var_15_0, var_1_10002.DORM_SIGN_ID_2)

	_ = var_15_0

	return var_15_0.any(var_15_2, function(arg_16_0)
		return arg_16_0:getTaskStatus() == 1
	end)
end

return var_0_1
