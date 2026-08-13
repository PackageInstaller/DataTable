class = var_0_10000

local var_0_0 = "CommissionInfoEventItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CommissionInfoItem"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_0._tf

	arg_1_0.lockTF = var_3.Find(var_1_0, "lock")
	setActive = var_3

	var_3(arg_1_0.lockTF, false)

	setText = var_3

	local var_1_1 = arg_1_0.lockTF
	local var_1_2 = var_4.Find(var_1_1, "Text")

	i18n = var_1_1

	var_3(var_1_2, var_1_1("commission_label_unlock_event_tip"))

	return
end

function var_0_1.CanOpen(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)

	return var_1.getData(var_2_0).level >= 12
end

function var_0_1.Init(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.CanOpen(var_3_0)

	setActive = var_3_0

	var_3_0(arg_3_0.lockTF, not var_3_1)

	setGray = var_3_0

	var_3_0(arg_3_0.toggle, not var_3_1, true)

	setActive = var_3_0

	var_3_0(arg_3_0.foldFlag, var_3_1)

	setActive = var_3_0

	var_3_0(arg_3_0.goBtn, var_3_1)

	EventPtBonus = var_3_0

	local var_3_2 = var_3_0.New
	local var_3_3 = arg_3_0.toggle

	arg_3_0.ptBonus = var_3_2(var_3.Find(var_3_3, "bonusPt"))

	var_0_1.super.Init(arg_3_0)

	return
end

function var_0_1.GetList(arg_4_0)
	assert = var_1_10001

	var_1_10001(arg_4_0.list, "why ???")

	table = var_1_10001

	local var_4_0 = var_1_10001.sort
	local var_4_1 = arg_4_0.list

	CompareFuncs = var_3

	var_4_0(var_4_1, var_3({
		function(arg_5_0)
			return -arg_5_0:GetState()
		end
	}))

	return arg_4_0.list, 4
end

function var_0_1.OnFlush(arg_6_0)
	getProxy = var_1_10001
	EventProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)
	local var_6_1, var_6_2, var_6_3, var_6_4 = var_1.GetEventListForCommossionInfo(var_6_0)

	arg_6_0.finishedCounter.text = var_6_2
	arg_6_0.ongoingCounter.text = var_6_3

	local var_6_5 = arg_6_0.leisureCounter

	var_6_5.text = var_6_4
	setActive = var_6_5

	var_6_5(arg_6_0.finishedCounterContainer, var_6_2 > 0)

	setActive = var_6_5

	var_6_5(arg_6_0.ongoingCounterContainer, var_6_3 > 0)

	setActive = var_6_5

	var_6_5(arg_6_0.leisureCounterContainer, var_6_4 > 0)

	setActive = var_6_5

	var_6_5(arg_6_0.goBtn, var_6_2 == 0)

	setActive = var_6_5

	var_6_5(arg_6_0.finishedBtn, var_6_2 > 0)

	arg_6_0.list = var_6_1

	return
end

function var_0_1.UpdateList(arg_7_0)
	var_0_1.super.UpdateList(arg_7_0)
	arg_7_0:UpdateActList()

	return
end

function var_0_1.UpdateActList(arg_8_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_8_0 = var_1_10001(var_1_10002)
	local var_8_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if var_8_1(var_8_0, var_1_10003.ACTIVITY_TYPE_COLLECTION_EVENT) then
		local var_8_2 = var_1

		if not var_1.isEnd(var_8_2) then
			getProxy = var_2
			EventProxy = var_8_2

			local var_8_3 = var_2(var_8_2)

			if var_2.GetEventByActivityId(var_8_3, var_1.id) then
				cloneTplTo = var_8_3

				local var_8_4 = var_8_3(arg_8_0.uilist.item, arg_8_0.uilist.container)

				var_3.SetAsFirstSibling(var_8_4)
				arg_8_0:UpdateEventInfo(var_3, var_2)

				setActive = var_4

				var_4(var_3:Find("unlock"), true)

				setActive = var_4

				var_4(var_3:Find("lock"), false)
				arg_8_0:UpdateStyle(var_3, true)
			end
		end
	end

	return
end

function var_0_1.GetChapterByCount(arg_9_0, arg_9_1)
	pg = var_1_10002

	local var_9_0 = var_1_10002.chapter_template

	pairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(var_9_0.all) do
		if var_9_0[iter_9_1].collection_team == arg_9_1 then
			return var_9_0[iter_9_1]
		end
	end

	return
end

function var_0_1.UpdateListItem(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	getProxy = var_1_10004
	EventProxy = var_1_10005

	if arg_10_1 > var_1_10004(var_1_10005).maxFleetNums then
		local var_10_0 = arg_10_0

		var_1_10006 = arg_10_0.GetChapterByCount(var_10_0, arg_10_1)
		assert = var_10_0

		var_10_0(var_1_10006, arg_10_1)

		getProxy = var_10_0
		SettingsProxy = var_8

		local var_10_1 = var_10_0(var_8)

		if var_7.IsMellowStyle(var_10_1) then
			setText = var_7

			local var_10_2 = arg_10_3
			local var_10_3 = arg_10_3.Find(var_10_2, "lock/Text")

			i18n = var_10_2

			var_7(var_10_3, var_10_2("commission_open_tip", var_1_10006.chapter_name))
		else
			setText = var_7

			local var_10_4 = arg_10_3
			local var_10_5 = arg_10_3.Find(var_10_4, "lock/Text")

			i18n = var_10_4

			local var_10_6 = var_10_4("commission_no_open")
			local var_10_7 = "\n"

			i18n = var_1_10011

			var_7(var_10_5, var_10_6 .. var_10_7 .. var_1_10011("commission_open_tip", var_1_10006.chapter_name))
		end
	else
		arg_10_0:UpdateEventInfo(arg_10_3, arg_10_2)
	end

	setActive = var_1_10006

	var_1_10006(arg_10_3:Find("unlock"), not var_5)

	setActive = var_1_10006

	var_1_10006(arg_10_3:Find("lock"), var_5)
	arg_10_0:UpdateStyle(arg_10_3, false, arg_10_2)

	return
end

function var_0_1.UpdateEventInfo(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_2 then
		var_1_10004 = arg_11_2

		if not arg_11_2.GetState(var_1_10004) then
			EventInfo = var_1_10003
			var_1_10003 = var_1_10003.StateNone
		end

		EventInfo = var_1_10004

		local var_11_15

		if var_1_10003 == var_1_10004.StateNone then
			setText = var_11_15

			local var_11_0 = arg_11_1
			local var_11_1 = arg_11_1.Find(var_11_0, "unlock/name_bg/Text")

			i18n = var_11_0

			var_11_15(var_11_1, var_11_0("commission_idle"))

			onButton = var_11_15

			local var_11_2 = arg_11_0
			local var_11_3 = arg_11_1:Find("unlock/leisure/go_btn")

			local function var_11_4()
				local var_12_0 = arg_11_0

				var_0.OnSkip(var_12_0)

				return
			end

			SFX_PANEL = var_8

			var_11_15(var_11_2, var_11_3, var_11_4, var_8)

			onButton = var_11_15

			local var_11_5 = arg_11_0
			local var_11_6 = arg_11_1

			local function var_11_7()
				triggerButton = var_2_10000

				local var_13_0 = arg_11_1

				var_2_10000(var_1.Find(var_13_0, "unlock/leisure/go_btn"))

				return
			end

			SFX_PANEL = var_8

			var_11_15(var_11_5, var_11_6, var_11_7, var_8)
		else
			EventInfo = var_11_15

			if var_1_10003 == var_11_15.StateFinish then
				setText = var_11_15

				var_11_15(arg_11_1:Find("unlock/name_bg/Text"), arg_11_2.template.title)

				onButton = var_11_15

				local var_11_8 = arg_11_0
				local var_11_9 = arg_11_1:Find("unlock/finished/finish_btn")

				local function var_11_10()
					local var_14_0 = arg_11_0
					local var_14_1 = var_0.emit

					CommissionInfoMediator = var_2_10002

					var_14_1(var_14_0, var_2_10002.FINISH_EVENT, arg_11_2)

					return
				end

				SFX_PANEL = var_8

				var_11_15(var_11_8, var_11_9, var_11_10, var_8)

				onButton = var_11_15

				local var_11_11 = arg_11_0
				local var_11_12 = arg_11_1

				local function var_11_13()
					triggerButton = var_2_10000

					local var_15_0 = arg_11_1

					var_2_10000(var_1.Find(var_15_0, "unlock/finished/finish_btn"))

					return
				end

				SFX_PANEL = var_8

				var_11_15(var_11_11, var_11_12, var_11_13, var_8)
			else
				EventInfo = var_11_15

				if var_1_10003 == var_11_15.StateActive then
					setText = var_11_15

					var_11_15(arg_11_1:Find("unlock/name_bg/Text"), arg_11_2.template.title)

					local var_11_14 = arg_11_1:Find("unlock/ongoging/time")

					var_11_15 = var_11_15.GetComponent
					typeof = var_6
					Text = var_7
					var_11_15 = var_11_15(var_11_14, var_6(var_7))

					arg_11_0:AddTimer(arg_11_2, var_11_15)
				end
			end
		end

		setActive = var_11_15

		local var_11_16 = arg_11_1
		local var_11_17 = arg_11_1.Find(var_11_16, "unlock/leisure")

		EventInfo = var_11_16

		var_11_15(var_11_17, var_1_10003 == var_11_16.StateNone)

		setActive = var_11_15

		local var_11_18 = arg_11_1
		local var_11_19 = arg_11_1.Find(var_11_18, "unlock/ongoging")

		EventInfo = var_11_18

		var_11_15(var_11_19, var_1_10003 == var_11_18.StateActive)

		setActive = var_11_15

		local var_11_20 = arg_11_1
		local var_11_21 = arg_11_1.Find(var_11_20, "unlock/finished")

		EventInfo = var_11_20

		var_11_15(var_11_21, var_1_10003 == var_11_20.StateFinish)

		return
	end
end

function var_0_1.AddTimer(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0:RemoveTimer(arg_16_1)

	local var_16_0 = arg_16_1.finishTime + 2
	local var_16_1 = arg_16_0.timers
	local var_16_2 = arg_16_1.id

	Timer = var_1_10006
	var_16_1[var_16_2] = var_1_10006.New(function()
		local var_17_0 = var_16_0

		pg = var_2_10001

		local var_17_1 = var_2_10001.TimeMgr.GetInstance()

		if var_17_0 - var_1.GetServerTime(var_17_1) <= 0 then
			var_17_1 = arg_16_0.timers[arg_16_1.id]

			var_1.Stop(var_17_1)

			arg_16_0.timers[arg_16_1.id] = nil
			var_17_1 = arg_16_0

			var_1.OnFlush(var_17_1)

			var_17_1 = arg_16_0

			var_1.UpdateList(var_17_1)
		else
			local var_17_2 = arg_16_2

			pg = var_17_1

			local var_17_3 = var_17_1.TimeMgr.GetInstance()

			var_17_2.text = var_2.DescCDTime(var_17_3, var_0)
		end

		return
	end, 1, -1)

	local var_16_3 = arg_16_0.timers[arg_16_1.id]

	var_4.Start(var_16_3)
	arg_16_0.timers[arg_16_1.id].func()

	return
end

function var_0_1.RemoveTimer(arg_18_0, arg_18_1)
	if arg_18_0.timers[arg_18_1.id] then
		local var_18_0 = arg_18_0.timers[arg_18_1.id]

		var_2.Stop(var_18_0)

		arg_18_0.timers[arg_18_1.id] = nil
	end

	return
end

function var_0_1.UpdateStyle(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_3 or not arg_19_3:GetState() then
		EventInfo = var_1_10004
		var_1_10004 = var_1_10004.StateNone
	end

	local var_19_0 = "icon_1"
	local var_19_1 = "icon_4"
	local var_19_2 = "icon_3"

	if arg_19_2 then
		var_19_0, var_19_1, var_19_2 = "icon_5", "icon_6", "icon_6"
	end

	;(function(arg_20_0, arg_20_1)
		local var_20_0 = arg_19_1
		local var_20_1 = var_2.Find

		string = var_2_10004

		local var_20_2 = var_20_1(var_20_0, var_2_10004.format("unlock/%s/icon", arg_20_0))

		GetSpriteFromAtlas = var_20_0

		local var_20_3 = var_20_0("ui/commissioninfoui_atlas", arg_20_1)

		if arg_19_2 then
			Vector3 = var_20_4

			local var_20_4

			if not var_20_4.one then
				Vector3 = var_20_4
				var_20_4 = var_20_4(1.2, 1.2, 1.2)
			end

			var_20_2.localScale = var_20_4

			local var_20_5 = var_20_2
			local var_20_6 = var_20_2.GetComponent

			typeof = var_6
			Image = var_2_10007
			var_20_6(var_20_5, var_6(var_2_10007)).sprite = var_20_3

			local var_20_7 = var_20_2
			local var_20_8 = var_20_2.GetComponent

			typeof = var_6
			Image = var_2_10007

			local var_20_9 = var_20_8(var_20_7, var_6(var_2_10007))

			var_4.SetNativeSize(var_20_9)

			return
		end
	end)("leisure", var_19_0)
	var_8("ongoging", var_19_1)
	var_8("finished", var_19_2)

	local var_19_3 = "event_ongoing"

	if arg_19_2 then
		var_19_3 = "event_bg_act"
	end

	getProxy = var_10
	SettingsProxy = var_11

	local var_19_4 = var_10(var_11)
	local var_19_6

	if var_10.IsMellowStyle(var_19_4) then
		var_19_3 = "frame_unlock"

		local var_19_5 = arg_19_1:Find("unlock/ongoging")

		var_19_6 = var_19_6.GetComponent
		typeof = var_12
		Image = var_1_10013
		var_19_6 = var_19_6(var_19_5, var_12(var_1_10013))
		GetSpriteFromAtlas = var_19_5
		var_19_6.sprite = var_19_5("ui/CommissionInfoUI4Mellow_atlas", var_19_3)

		local var_19_7 = arg_19_1:Find("unlock/finished")

		var_19_6 = var_19_6.GetComponent
		typeof = var_12
		Image = var_1_10013
		var_19_6 = var_19_6(var_19_7, var_12(var_1_10013))
		GetSpriteFromAtlas = var_19_7
		var_19_6.sprite = var_19_7("ui/CommissionInfoUI4Mellow_atlas", var_19_3)
	else
		local var_19_8 = arg_19_1:Find("unlock/ongoging")

		var_19_6 = var_19_6.GetComponent
		typeof = var_12
		Image = var_1_10013
		var_19_6 = var_19_6(var_19_8, var_12(var_1_10013))
		GetSpriteFromAtlas = var_19_8
		var_19_6.sprite = var_19_8("ui/commissioninfoui_atlas", var_19_3)

		local var_19_9 = arg_19_1:Find("unlock/finished")

		var_19_6 = var_19_6.GetComponent
		typeof = var_12
		Image = var_13
		var_19_6 = var_19_6(var_19_9, var_12(var_13))
		GetSpriteFromAtlas = var_19_9
		var_19_6.sprite = var_19_9("ui/commissioninfoui_atlas", var_19_3)
	end

	Color = var_19_6

	local var_19_10 = var_19_6.New(0.996078431372549, 0.7568627450980392, 0.9725490196078431, 1)
	local var_19_11

	if not arg_19_2 or not var_19_10 then
		::label_19_0::

		Color = var_19_11
		var_19_11 = var_19_11.New(0.6039215686274509, 0.7843137254901961, 0.9607843137254902, 1)
	end

	local var_19_12 = arg_19_1:Find("unlock/ongoging/print")
	local var_19_13 = var_12.GetComponent

	typeof = var_14
	Image = var_1_10015
	var_19_13(var_19_12, var_14(var_1_10015)).color = var_19_11

	local var_19_14 = arg_19_1:Find("unlock/finished/print")
	local var_19_15 = var_12.GetComponent

	typeof = var_14
	Image = var_1_10015

	local var_19_16 = var_19_15(var_19_14, var_14(var_1_10015))

	var_19_16.color = var_19_11
	setActive = var_19_16

	local var_19_17 = arg_19_1
	local var_19_18 = arg_19_1.Find(var_19_17, "unlock/act")

	EventInfo = var_19_17

	var_19_16(var_19_18, var_1_10004 == var_19_17.StateNone and arg_19_2)

	return
end

function var_0_1.OnSkip(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.emit

	CommissionInfoMediator = var_1_10003

	var_21_1(var_21_0, var_1_10003.ON_ACTIVE_EVENT)

	return
end

function var_0_1.OnFinishAll(arg_22_0)
	local var_22_0 = {}
	local var_22_1 = 0

	_ = var_1_10003

	var_1_10003.each(arg_22_0.list, function(arg_23_0)
		local var_23_0 = arg_23_0
		local var_23_1 = arg_23_0.GetState(var_23_0)

		EventInfo = var_23_0

		if var_23_1 == var_23_0.StateFinish then
			table = var_23_1

			var_23_1.insert(var_22_0, function(arg_24_0)
				local var_24_0 = arg_22_0
				local var_24_1 = var_1.emit

				CommissionInfoMediator = var_3_10003

				var_24_1(var_24_0, var_3_10003.FINISH_EVENT, arg_23_0, var_22_1, arg_24_0)

				return
			end)
		end

		return
	end)

	getProxy = var_3
	ActivityProxy = var_4

	local var_22_2 = var_3(var_4)
	local var_22_3 = var_3.getActivityByType

	ActivityConst = var_5

	if var_22_3(var_22_2, var_5.ACTIVITY_TYPE_COLLECTION_EVENT) then
		local var_22_4 = var_3

		if not var_3.isEnd(var_22_4) then
			getProxy = var_22_2
			EventProxy = var_22_4

			local var_22_5 = var_22_2(var_22_4)

			if var_22_2.GetEventByActivityId(var_22_5, var_3.id) then
				local var_22_6 = var_22_2
				local var_22_7 = var_22_2.GetState(var_22_6)

				EventInfo = var_22_6

				if var_22_7 == var_22_6.StateFinish then
					table = var_22_7

					var_22_7.insert(var_22_0, function(arg_25_0)
						local var_25_0 = arg_22_0
						local var_25_1 = var_1.emit

						CommissionInfoMediator = var_2_10003

						var_25_1(var_25_0, var_2_10003.FINISH_EVENT, var_22_2, var_22_1, arg_25_0)

						return
					end)
				end
			end
		end
	end

	var_22_1 = #var_22_0
	seriesAsync = var_22_2

	var_22_2(var_22_0)

	return
end

return var_0_1
