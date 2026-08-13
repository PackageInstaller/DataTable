class = var_0_10000

local var_0_0 = "EducateSchedulePerformLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".base.EducateBaseUI"))
local var_0_2 = {
	"FFFFFF",
	"79D3FE",
	"818183"
}
local var_0_3 = {
	"39BFFF",
	"39BFFF",
	"2D2E2F"
}

function var_0_1.getUIName(arg_1_0)
	return "EducateSchedulePerformUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()

	return
end

function var_0_1.initData(arg_3_0)
	getProxy = var_1_10001
	EducateProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)
	local var_3_1 = var_1.GetCharData(var_3_0)

	arg_3_0.planCnt = var_1.GetNextWeekPlanCnt(var_3_1)
	arg_3_0.curDay = 1
	arg_3_0.curIndex = 1
	arg_3_0.events = arg_3_0.contextData.events
	arg_3_0.drops = {}
	arg_3_0.isSkip = arg_3_0.contextData.skip
	arg_3_0.isSkipEvent = arg_3_0.contextData.skipEvent
	underscore = var_1

	var_1.each(arg_3_0.contextData.plan_results, function(arg_4_0)
		if not arg_3_0.drops[arg_4_0.day] then
			arg_3_0.drops[arg_4_0.day] = {}
		end

		arg_3_0.drops[arg_4_0.day][arg_4_0.index] = {
			plan_drops = arg_4_0.plan_drops,
			event_drops = arg_4_0.event_drops,
			spec_event_drops = arg_4_0.spec_event_drops
		}

		return
	end)

	arg_3_0.showGrids = arg_3_0.contextData.gridData
	arg_3_0.showEventIds = {}
	underscore = var_1

	var_1.each(arg_3_0.events, function(arg_5_0)
		if not arg_3_0.showEventIds[arg_5_0.day] then
			arg_3_0.showEventIds[arg_5_0.day] = {}
		end

		arg_3_0.showEventIds[arg_5_0.day][arg_5_0.index] = arg_5_0.value[1].event_id

		return
	end)

	return
end

function var_0_1.findUI(arg_6_0)
	local var_6_0 = arg_6_0._tf

	arg_6_0.windowsTF = var_1.Find(var_6_0, "anim_root/window")

	local var_6_1 = arg_6_0.windowsTF

	arg_6_0.leftTF = var_1.Find(var_6_1, "left")
	setText = var_1

	local var_6_2 = arg_6_0.leftTF
	local var_6_3 = var_3.Find(var_6_2, "title/Text")

	i18n = var_4

	var_1(var_6_3, var_4("child_plan_perform_title"))

	UIItemList = var_1

	local var_6_4 = var_1.New
	local var_6_5 = arg_6_0.leftTF
	local var_6_6 = var_3.Find(var_6_5, "content")
	local var_6_7 = arg_6_0.leftTF

	arg_6_0.dayUIList = var_6_4(var_6_6, var_4.Find(var_6_7, "content/day_tpl"))

	local var_6_8 = arg_6_0.windowsTF

	arg_6_0.rightTF = var_1.Find(var_6_8, "right")

	local var_6_9 = arg_6_0.rightTF

	arg_6_0.planNameTF = var_1.Find(var_6_9, "name")

	return
end

function var_0_1.didEnter(arg_7_0)
	arg_7_0:OverlayPanel(arg_7_0._tf, {
		groupDelta = 1
	})

	pg = var_1

	local var_7_0 = var_1.PerformMgr.GetInstance()

	var_1.SetParamForUI(var_7_0, arg_7_0.__cname)
	arg_7_0:initDayList()
	arg_7_0:playWeek(function()
		local var_8_0 = arg_7_0

		var_0.emit(var_8_0, var_0_1.ON_CLOSE)

		return
	end)

	return
end

function var_0_1.initDayList(arg_9_0)
	local var_9_0 = arg_9_0.dayUIList

	var_1.make(var_9_0, function(arg_10_0, arg_10_1, arg_10_2)
		UIItemList = var_2_10003

		if arg_10_0 == var_2_10003.EventInit then
			arg_10_2.name = arg_10_1 + 1
			setText = var_2_10004

			local var_10_0 = arg_10_2:Find("Text")

			EducateHelper = var_2_10007

			var_2_10004(var_10_0, var_2_10007.GetWeekStrByNumber(var_3))

			for iter_10_0 = 1, 3 do
				var_2_10010 = arg_10_2

				local var_10_1 = arg_10_2.Find(var_2_10010, "phase" .. iter_10_0)

				setActive = var_9

				var_9(var_10_1, iter_10_0 == arg_9_0.planCnt)
			end
		else
			UIItemList = var_3

			if arg_10_0 == var_3.EventUpdate then
				local var_10_2 = arg_10_1 + 1

				setActive = var_2_10004

				var_2_10004(arg_10_2:Find("selected"), arg_9_0.curDay == var_10_2)

				local var_10_3 = arg_10_2:Find("Text")
				local var_10_4 = "FFFFFF"
				local var_10_5 = "FFFFFF"

				if var_10_2 < arg_9_0.curDay then
					var_10_4 = var_0_2[1]
					var_10_5 = var_0_3[1]
				elseif arg_9_0.curDay == var_10_2 then
					var_10_4 = var_0_2[2]
					var_10_5 = var_0_3[3]
				else
					var_10_4 = var_0_2[3]
					var_10_5 = var_0_3[3]
				end

				setTextColor = var_7

				local var_10_6 = var_10_3

				Color = var_2_10010

				var_7(var_10_6, var_2_10010.NewHex(var_10_4))

				local var_10_7 = arg_10_2:Find("phase" .. arg_9_0.planCnt)

				for iter_10_1 = 1, var_10_7.childCount do
					local var_10_8 = var_10_5

					if arg_9_0.curDay == var_10_2 and iter_10_1 <= arg_9_0.curIndex then
						var_10_8 = var_0_3[2]
					end

					setImageColor = var_13

					local var_10_9 = var_10_7:GetChild(iter_10_1 - 1)

					Color = var_2_10016

					var_13(var_10_9, var_2_10016.NewHex(var_10_8))
				end
			end
		end

		return
	end)
	arg_9_0:updateLeft()

	return
end

function var_0_1.updateLeft(arg_11_0)
	local var_11_0 = arg_11_0.dayUIList

	var_1.align(var_11_0, 6)

	return
end

function var_0_1.playWeek(arg_12_0, arg_12_1)
	arg_12_0.curDay = 1
	arg_12_0.curIndex = 1

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.emit

	EducateSchedulePerformMediator = var_1_10005

	var_12_1(var_12_0, var_1_10005.WEEKDAY_UPDATE, arg_12_0.curDay)

	local var_12_2 = {}

	for iter_12_0 = 1, 6 do
		for iter_12_1 = 1, 3 do
			local var_12_3

			if not arg_12_0.drops[iter_12_0][iter_12_1] then
				var_12_3 = {}
			end

			local var_12_4

			if arg_12_0.showEventIds[iter_12_0] and arg_12_0.showEventIds[iter_12_0][iter_12_1] then
				var_12_4 = arg_12_0.showEventIds[iter_12_0][iter_12_1] ~= 0
			end

			if arg_12_0.showGrids[iter_12_0] and arg_12_0.showGrids[iter_12_0][iter_12_1] then
				local var_12_5 = arg_12_0.showGrids[iter_12_0][iter_12_1]

				table = var_1_10014

				var_1_10014.insert(var_12_2, function(arg_13_0)
					arg_12_0.curDay = iter_12_0
					arg_12_0.curIndex = iter_12_1

					local var_13_0 = arg_12_0
					local var_13_1 = var_1.emit

					EducateSchedulePerformMediator = var_2_10004

					var_13_1(var_13_0, var_2_10004.WEEKDAY_UPDATE, arg_12_0.curDay)

					local var_13_2 = arg_12_0

					var_1.updateLeft(var_13_2)

					setText = var_1

					local var_13_3 = arg_12_0.planNameTF
					local var_13_4 = var_12_5

					var_1(var_13_3, var_4.GetName(var_13_4))

					local var_13_5 = var_12_5
					local var_13_6

					if not var_1.IsPlan(var_13_5) or not var_12_3.plan_drops then
						var_13_6 = var_12_3.spec_event_drops
					end

					local var_13_7 = var_12_5
					local var_13_8 = not var_2.IsPlan(var_13_7) or var_12_4

					if arg_12_0.isSkip then
						if var_13_8 and not arg_12_0.isSkipEvent then
							pg = var_3

							local var_13_9 = var_3.PerformMgr.GetInstance()
							local var_13_10 = var_3.PlayGroupNoHide
							local var_13_11 = var_12_5

							var_13_10(var_13_9, var_6.GetPerformance(var_13_11), arg_13_0, var_13_6 or {})
						else
							arg_13_0()
						end
					else
						local var_13_12 = var_12_5

						if not var_3.IsPlan(var_13_12) and arg_12_0.isSkipEvent then
							arg_13_0()
						else
							pg = var_3

							local var_13_13 = var_3.PerformMgr.GetInstance()
							local var_13_14 = var_3.PlayGroupNoHide
							local var_13_15 = var_12_5

							var_13_14(var_13_13, var_6.GetPerformance(var_13_15), arg_13_0, var_13_6 or {})
						end
					end

					return
				end)
			end

			if var_12_4 and not arg_12_0.isSkipEvent then
				local var_12_6 = arg_12_0.showEventIds[iter_12_0][iter_12_1]

				table = var_1_10014

				var_1_10014.insert(var_12_2, function(arg_14_0)
					pg = var_2_10001

					local var_14_0 = var_2_10001.PerformMgr.GetInstance()
					local var_14_1 = var_1.PlayGroupNoHide

					pg = var_2_10004

					local var_14_2 = var_2_10004.child_event[var_12_6].performance
					local var_14_3 = arg_14_0
					local var_14_4

					if not var_12_3.event_drops then
						var_14_4 = {}
					end

					var_14_1(var_14_0, var_14_2, var_14_3, var_14_4)

					return
				end)
			end
		end
	end

	pg = var_3

	local var_12_7 = var_3.PerformMgr.GetInstance()

	var_3.Show(var_12_7)

	seriesAsync = var_3

	var_3(var_12_2, function()
		pg = var_2_10000

		local var_15_0 = var_2_10000.PerformMgr.GetInstance()

		var_0.Hide(var_15_0)

		onNextTick = var_0

		var_0(function()
			if arg_12_1 then
				arg_12_1()
			end

			return
		end)

		return
	end)

	return
end

function var_0_1.onBackPressed(arg_17_0)
	return
end

function var_0_1.willExit(arg_18_0)
	arg_18_0:UnOverlayPanel(arg_18_0._tf)

	pg = var_1

	local var_18_0 = var_1.PerformMgr.GetInstance()

	var_1.SetParamForUI(var_18_0, "Default")

	if arg_18_0.contextData.onExit then
		arg_18_0.contextData.onExit()
	end

	return
end

return var_0_1
