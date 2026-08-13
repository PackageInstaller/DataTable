class = var_0_10000

local var_0_0 = "LinerLogSchedulePage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseSubView"))

var_0_1.SHOW_TIME_LIST = {
	{
		3,
		8
	},
	{
		8,
		12
	},
	{
		12,
		14
	},
	{
		14,
		18
	},
	{
		18,
		20
	},
	{
		20,
		25
	},
	{
		25,
		27
	}
}

function var_0_1.getUIName(arg_1_0)
	return "LinerLogSchedulePage"
end

function var_0_1.OnLoaded(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.togglesTF = var_1.Find(var_2_0, "toggles")

	local var_2_1 = arg_2_0._tf

	arg_2_0.contentTF = var_1.Find(var_2_1, "content")

	local var_2_2 = arg_2_0.contentTF
	local var_2_3 = var_1.GetComponent

	typeof = var_3
	Animation = var_1_10004
	arg_2_0.anim = var_2_3(var_2_2, var_3(var_1_10004))

	local var_2_4 = arg_2_0._tf

	arg_2_0.awardTF = var_1.Find(var_2_4, "award/mask/IconTpl")

	local var_2_5 = arg_2_0._tf

	arg_2_0.awardDesc = var_1.Find(var_2_5, "award/Text")

	local var_2_6 = arg_2_0._tf

	arg_2_0.goBtn = var_1.Find(var_2_6, "award/go")

	local var_2_7 = arg_2_0._tf

	arg_2_0.getBtn = var_1.Find(var_2_7, "award/get")

	local var_2_8 = arg_2_0._tf

	arg_2_0.gotTF = var_1.Find(var_2_8, "award/got")

	return
end

function var_0_1.OnInit(arg_3_0)
	arg_3_0:UpdateActivity()

	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.getBtn

	local function var_3_2()
		local var_4_0 = arg_3_0
		local var_4_1 = var_0.emit

		LinerLogBookMediator = var_2_10002

		local var_4_2 = var_2_10002.GET_SCHEDULE_AWARD
		local var_4_3 = arg_3_0.activity.id
		local var_4_4 = arg_3_0.curIdx
		local var_4_5 = arg_3_0.groups[arg_3_0.curIdx]

		var_4_1(var_4_0, var_4_2, var_4_3, var_4_4, var_5.GetDrop(var_4_5))

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_3_0, var_3_1, var_3_2, var_1_10005)

	onButton = var_1

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.goBtn

	local function var_3_5()
		local var_5_0 = arg_3_0
		local var_5_1 = var_0.emit

		LinerLogBookMediator = var_2_10002

		var_5_1(var_5_0, var_2_10002.ON_CLOSE)

		return
	end

	SFX_CONFIRM = var_1_10005

	var_1(var_3_3, var_3_4, var_3_5, var_1_10005)

	local var_3_6 = arg_3_0.activity

	arg_3_0.groupIds = var_1.getConfig(var_3_6, "config_data")[1]
	arg_3_0.groups = {}
	ipairs = var_1

	for iter_3_0, iter_3_1 in var_1(arg_3_0.groupIds) do
		local var_3_7 = arg_3_0.groups

		LinerTimeGroup = var_1_10007
		var_3_7[iter_3_0] = var_1_10007.New(iter_3_1)
	end

	UIItemList = var_1

	local var_3_8 = var_1.New
	local var_3_9 = arg_3_0.contentTF
	local var_3_10 = arg_3_0.contentTF

	arg_3_0.itemUIList = var_3_8(var_3_9, var_3.Find(var_3_10, "tpl"))

	local var_3_11 = arg_3_0.itemUIList

	var_1.make(var_3_11, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			local var_6_0 = arg_3_0

			var_3.UpdateItem(var_6_0, arg_6_1, arg_6_2)
		end

		return
	end)

	UIItemList = var_1

	local var_3_12 = var_1.New
	local var_3_13 = arg_3_0.togglesTF
	local var_3_14 = arg_3_0.togglesTF

	arg_3_0.toggleUIList = var_3_12(var_3_13, var_3.Find(var_3_14, "tpl"))

	local var_3_15 = arg_3_0.toggleUIList

	var_1.make(var_3_15, function(arg_7_0, arg_7_1, arg_7_2)
		UIItemList = var_2_10003

		if arg_7_0 == var_2_10003.EventInit then
			arg_7_2.name = arg_7_1 + 1

			local var_7_0 = "DAY "

			string = var_2_10005

			local var_7_1 = var_7_0 .. var_2_10005.format("%02d", var_3)

			setText = var_5

			var_5(arg_7_2:Find("Text"), var_7_1)

			setText = var_5

			var_5(arg_7_2:Find("selected/Text"), var_7_1)

			onToggle = var_5

			local var_7_2 = arg_3_0
			local var_7_3 = arg_7_2

			local function var_7_4(arg_8_0)
				if arg_8_0 then
					if arg_3_0.curIdx and arg_3_0.curIdx == var_0 then
						return
					end

					arg_3_0.curIdx = var_0

					local var_8_0 = arg_3_0

					var_1.FlushPage(var_8_0, true)
				end

				return
			end

			SFX_CONFIRM = var_2_10009

			var_5(var_7_2, var_7_3, var_7_4, var_2_10009)
		else
			UIItemList = var_3

			if arg_7_0 == var_3.EventUpdate then
				tonumber = var_3

				local var_7_5 = var_3(arg_7_2.name)
				local var_7_6 = arg_3_0.curDay < var_7_5

				setActive = var_4

				var_4(arg_7_2:Find("lock"), var_7_6)

				SetCompomentEnabled = var_4

				local var_7_7 = arg_7_2

				typeof = var_6
				Toggle = var_7

				var_4(var_7_7, var_6(var_7), not var_7_6)

				if var_7_6 then
					setActive = var_4

					var_4(arg_7_2:Find("selected"), false)

					setActive = var_4

					var_4(arg_7_2:Find("tip"), false)
				else
					setActive = var_4

					var_4(arg_7_2:Find("tip"), var_0_1.IsTipWithGroupId(arg_3_0.activity, arg_3_0.groups[arg_7_1 + 1].id))
				end
			end
		end

		return
	end)

	local var_3_16 = arg_3_0.toggleUIList

	var_1.align(var_3_16, #arg_3_0.groupIds)

	triggerToggle = var_1

	local var_3_17 = arg_3_0._tf
	local var_3_18 = var_2.Find

	tostring = var_3_14

	var_1(var_3_18(var_3_17, var_3_14(arg_3_0.curDay), arg_3_0.toggleUIList.container), true)

	return
end

function var_0_1.UpdateActivity(arg_9_0, arg_9_1)
	local var_9_1

	if not arg_9_1 then
		::label_9_0::

		getProxy = var_9_1
		ActivityProxy = var_1_10003

		local var_9_0 = var_9_1(var_1_10003)

		var_9_1 = var_9_1.getActivityByType
		ActivityConst = var_1_10004
		var_9_1 = var_9_1(var_9_0, var_1_10004.ACTIVITY_TYPE_LINER)
	end

	arg_9_0.activity = var_9_1
	assert = var_9_1

	local var_9_3

	if arg_9_0.activity then
		local var_9_2 = arg_9_0.activity

		var_9_3 = not var_3.isEnd(var_9_2)
	end

	local var_9_4 = "not exist liner act, type: "

	ActivityConst = var_1_10005

	var_9_1(var_9_3, var_9_4 .. var_1_10005.ACTIVITY_TYPE_LINER)

	local var_9_5 = arg_9_0.activity

	arg_9_0.finishTimeIds = var_2.GetFinishTimeIds(var_9_5)

	local var_9_6 = arg_9_0.activity

	arg_9_0.timeId2ExploredIds = var_2.GetTimeId2ExploredIds(var_9_6)

	local var_9_7 = arg_9_0.activity
	local var_9_8 = var_2.GetDayByIdx
	local var_9_9 = arg_9_0.activity

	arg_9_0.curDay = var_9_8(var_9_7, var_4.GetCurIdx(var_9_9))

	return
end

function var_0_1._getLogDesc(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1[1]
	local var_10_1 = arg_10_1[2] - 1

	if var_10_0 >= 24 then
		var_10_0 = var_10_0 - 24
	end

	if var_10_1 >= 24 then
		var_10_1 = var_10_1 - 24
	end

	local var_10_2 = var_10_0 < 12 and "AM" or "PM"
	local var_10_3 = var_10_1 < 12 and "AM" or "PM"
	local var_10_4

	if not (var_10_0 > 12) or not (var_10_0 - 12) then
		var_10_4 = var_10_0
	end

	var_10_1 = var_10_1 > 12 and var_10_1 - 12 or var_10_1

	local var_10_5 = var_10_4

	string = var_10_4

	return var_10_4.format("%d:00 %s~%d:59 %s", var_10_5, var_10_2, var_10_1, var_10_3)
end

function var_0_1._getReallyTime(arg_11_0, arg_11_1)
	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.times) do
		local var_11_0 = iter_11_1:GetTime()[1]
		local var_11_1 = iter_11_1:GetTime()[2]

		if var_11_0 < 3 then
			var_11_0 = var_11_0 + 24
		end

		if var_11_1 <= 3 then
			var_11_1 = var_11_1 + 24
		end

		if var_11_0 <= arg_11_1[1] and var_11_1 >= arg_11_1[2] then
			return iter_11_1
		end
	end

	return
end

function var_0_1.UpdateItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1 + 1
	local var_12_1 = var_0_1.SHOW_TIME_LIST[var_12_0]

	setText = var_1_10005

	var_1_10005(arg_12_2:Find("time/Text"), arg_12_0:_getLogDesc(var_12_1))

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0._getReallyTime(var_12_2, var_12_1)

	table = var_12_2

	local var_12_4 = var_12_2.contains(arg_12_0.finishTimeIds, var_12_3.id)
	local var_12_5 = arg_12_2:Find("desc")

	if var_12_4 then
		local var_12_6 = var_12_3
		local var_12_7

		if not var_12_3.GetAfterDesc(var_12_6, var_12_0) then
			var_12_6 = var_12_3
			var_12_7 = var_12_3.GetBeforDesc(var_12_6, var_12_0)
		end

		if var_12_4 then
			local var_12_8 = var_12_3

			var_12_6 = var_12_3.GetType(var_12_8)
			LinerTime = var_12_8

			if var_12_6 == var_12_8.TYPE.EXPLORE then
				underscore = var_12_6
				var_12_6 = var_12_6.map(arg_12_0.timeId2ExploredIds[var_12_3.id], function(arg_13_0)
					pg = var_2_10001

					return var_2_10001.activity_liner_room[arg_13_0].name
				end)
				string = var_10

				local var_12_9 = var_10.gsub
				local var_12_10 = var_12_7
				local var_12_11 = "$1"

				table = var_1_10013
				var_12_7 = var_12_9(var_12_10, var_12_11, var_1_10013.concat(var_12_6, "、"))
			end
		end

		setText = var_12_6

		var_12_6(var_12_5, var_12_7)

		setActive = var_12_6

		var_12_6(arg_12_2:Find("time/finish"), var_12_4)

		setActive = var_12_6

		var_12_6(var_12_5, arg_12_0.curIdx <= arg_12_0.curDay)

		return
	end
end

function var_0_1.FlushPage(arg_14_0)
	local var_14_0 = arg_14_0.anim

	var_1.Play(var_14_0)

	local var_14_1 = arg_14_0.toggleUIList

	var_1.align(var_14_1, #arg_14_0.groupIds)

	local var_14_2 = arg_14_0.groups[arg_14_0.curIdx]

	arg_14_0.times = var_1.GetTimeList(var_14_2)
	table = var_1

	local var_14_3 = var_1.sort
	local var_14_4 = arg_14_0.times

	CompareFuncs = var_3

	var_14_3(var_14_4, var_3({
		function(arg_15_0)
			return arg_15_0.id
		end
	}))

	local var_14_5 = arg_14_0.itemUIList

	var_1.align(var_14_5, #var_0_1.SHOW_TIME_LIST)

	local var_14_6 = arg_14_0.groups[arg_14_0.curIdx]
	local var_14_7 = var_1.GetDrop(var_14_6)

	updateDrop = var_14_6

	var_14_6(arg_14_0.awardTF, var_14_7)

	onButton = var_14_6

	local var_14_8 = arg_14_0
	local var_14_9 = arg_14_0.awardTF

	local function var_14_10()
		local var_16_0 = arg_14_0
		local var_16_1 = var_0.emit

		BaseUI = var_2_10002

		var_16_1(var_16_0, var_2_10002.ON_DROP, var_14_7)

		return
	end

	SFX_PANEL = var_1_10006

	var_14_6(var_14_8, var_14_9, var_14_10, var_1_10006)

	local var_14_11 = arg_14_0.activity
	local var_14_12 = var_2.IsGotTimeAward(var_14_11, arg_14_0.curIdx)
	local var_14_13 = arg_14_0.groups[arg_14_0.curIdx].id
	local var_14_14 = var_0_1.IsTipWithGroupId(arg_14_0.activity, var_14_13)

	setActive = var_14_16

	var_14_16(arg_14_0.goBtn, not var_14_12 and not var_14_14)

	setActive = var_14_16

	var_14_16(arg_14_0.gotTF, var_14_12)

	setActive = var_14_16

	local var_14_15 = arg_14_0.awardTF

	var_14_16(var_6.Find(var_14_15, "mask"), var_14_12)

	if var_14_12 then
		i18n = var_14_16

		local var_14_16

		if not var_14_16("liner_schedule_award_tip2", arg_14_0.curIdx) then
			i18n = var_14_16
			var_14_16 = var_14_16("liner_schedule_award_tip1")
		end

		setText = var_6

		var_6(arg_14_0.awardDesc, var_14_16)

		setActive = var_6

		var_6(arg_14_0.getBtn, var_14_14)
		arg_14_0:Show()

		return
	end
end

function var_0_1.OnDestroy(arg_17_0)
	return
end

function var_0_1.IsTipWithGroupId(arg_18_0, arg_18_1)
	table = var_1_10002

	local var_18_0 = var_1_10002.indexof(arg_18_0:GetTimeGroupIds(), arg_18_1)

	if arg_18_0:IsGotTimeAward(var_18_0) then
		return false
	end

	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_0.GetFinishTimeIds(var_18_1)

	underscore = var_18_1

	local var_18_3 = var_18_1.all

	pg = var_5

	return var_18_3(var_5.activity_liner_time_group[arg_18_1].ids, function(arg_19_0)
		table = var_2_10001

		return var_2_10001.contains(var_18_2, arg_19_0)
	end)
end

function var_0_1.IsTip()
	getProxy = var_1_10000
	ActivityProxy = var_1_10001

	local var_20_0 = var_1_10000(var_1_10001)
	local var_20_1 = var_0.getActivityByType

	ActivityConst = var_1_10002

	local var_20_2 = var_20_1(var_20_0, var_1_10002.ACTIVITY_TYPE_LINER)

	assert = var_20_0

	local var_20_3 = var_20_2 and not var_20_2:isEnd()
	local var_20_4 = "not exist liner act, type: "

	ActivityConst = var_1_10004

	var_20_0(var_20_3, var_20_4 .. var_1_10004.ACTIVITY_TYPE_LINER)

	local var_20_5 = var_20_2
	local var_20_6 = var_20_2.GetTimeGroupIds(var_20_5)

	underscore = var_20_5

	return var_20_5.any(var_20_6, function(arg_21_0)
		return var_0_1.IsTipWithGroupId(var_20_2, arg_21_0)
	end)
end

return var_0_1
