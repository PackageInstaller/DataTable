class = var_0_10000

local var_0_0 = "CommissionInfoTechnologyItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CommissionInfoItem"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	local var_1_0 = arg_1_0._tf

	arg_1_0.commingTF = var_3.Find(var_1_0, "comming")

	local var_1_1 = arg_1_0._tf

	arg_1_0.techFrame = var_3.Find(var_1_1, "frame")

	local var_1_2 = arg_1_0._tf

	arg_1_0.lockTF = var_3.Find(var_1_2, "lock")
	setActive = var_3

	var_3(arg_1_0.lockTF, false)

	setText = var_3

	local var_1_3 = arg_1_0.lockTF
	local var_1_4 = var_4.Find(var_1_3, "Text")

	i18n = var_1_3

	var_3(var_1_4, var_1_3("commission_label_unlock_tech_tip"))

	return
end

function var_0_1.CanOpen(arg_2_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_2_0 = var_1_10001(var_1_10002)
	local var_2_1

	if var_1.getData(var_2_0).level >= 30 then
		LOCK_TECHNOLOGY = var_1
		var_2_1 = not var_1
	else
		var_2_1 = false
	end

	if false then
		var_2_1 = true
	end

	return var_2_1
end

function var_0_1.Init(arg_3_0)
	LOCK_TECHNOLOGY = var_1_10001

	if var_1_10001 then
		setActive = var_1_10001

		local var_3_0 = arg_3_0._tf

		var_1_10001(var_2.Find(var_3_0, "frame"), false)

		setActive = var_1_10001

		var_1_10001(arg_3_0.lockTF, false)

		setActive = var_1_10001

		var_1_10001(arg_3_0.commingTF, true)
	else
		setActive = var_1_10001

		local var_3_1 = arg_3_0._tf

		var_1_10001(var_2.Find(var_3_1, "frame"), true)

		setActive = var_1_10001

		var_1_10001(arg_3_0.lockTF, false)

		setActive = var_1_10001

		var_1_10001(arg_3_0.commingTF, false)

		local var_3_2 = arg_3_0
		local var_3_3 = arg_3_0.CanOpen(var_3_2)

		setActive = var_3_2

		var_3_2(arg_3_0.lockTF, not var_3_3)

		setGray = var_3_2

		var_3_2(arg_3_0.toggle, not var_3_3, true)

		setActive = var_3_2

		var_3_2(arg_3_0.foldFlag, false)

		setActive = var_3_2

		var_3_2(arg_3_0.goBtn, var_3_3)
		var_0_1.super.Init(arg_3_0)
	end

	return
end

function var_0_1.OnFlush(arg_4_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)
	local var_4_1 = var_1.getPlanningTechnologys(var_4_0)

	arg_4_0.list = {}

	local var_4_2 = {
		ongoing = 0,
		finished = 0
	}

	TechnologyConst = var_1_10003
	var_4_2.leisure = var_1_10003.QUEUE_TOTAL_COUNT + 1
	ipairs = var_3

	for iter_4_0, iter_4_1 in var_3(var_4_1) do
		if iter_4_1:isCompleted() then
			var_4_2.leisure = var_4_2.leisure - 1
			var_4_2.finished = var_4_2.finished + 1
		elseif iter_4_1:isActivate() then
			var_4_2.leisure = var_4_2.leisure - 1
			var_4_2.ongoing = var_4_2.ongoing + 1
		end
	end

	eachChild = var_3

	local var_4_3 = arg_4_0._tf

	var_3(var_4.Find(var_4_3, "frame/counter"), function(arg_5_0)
		setActive = var_2_10001

		var_2_10001(arg_5_0, var_4_2[arg_5_0.name] > 0)

		setText = var_2_10001

		var_2_10001(arg_5_0:Find("Text"), var_4_2[arg_5_0.name])

		return
	end)

	setActive = var_3

	var_3(arg_4_0.goBtn, var_4_2.finished == 0)

	setActive = var_3

	var_3(arg_4_0.finishedBtn, var_4_2.finished > 0)

	return
end

function var_0_1.UpdateListItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2

	pg = var_1_10005

	local var_6_1 = var_1_10005.TimeMgr.GetInstance()
	local var_6_2 = var_5.GetServerTime(var_6_1)
	local var_6_3 = var_6_0:getConfig("time")
	local var_6_16

	if var_6_0.time == 0 then
		setText = var_6_16

		local var_6_4 = arg_6_3
		local var_6_5 = arg_6_3.Find(var_6_4, "unlock/desc/name_bg/Text")

		i18n = var_6_4

		var_6_16(var_6_5, var_6_4("commission_idle"))

		onButton = var_6_16

		local var_6_6 = arg_6_0
		local var_6_7 = arg_6_3:Find("unlock/leisure/go_btn")

		local function var_6_8()
			local var_7_0 = arg_6_0

			var_0.OnSkip(var_7_0)

			return
		end

		SFX_PANEL = var_12

		var_6_16(var_6_6, var_6_7, var_6_8, var_12)

		onButton = var_6_16

		local var_6_9 = arg_6_0
		local var_6_10 = arg_6_3

		local function var_6_11()
			local var_8_0 = arg_6_0

			var_0.OnSkip(var_8_0)

			return
		end

		SFX_PANEL = var_12

		var_6_16(var_6_9, var_6_10, var_6_11, var_12)
	elseif var_6_2 < var_7 - var_6_3 then
		arg_6_0:UpdateTechnology(arg_6_3, var_6_0)

		setText = var_6_16

		local var_6_12 = arg_6_3
		local var_6_13 = arg_6_3.Find(var_6_12, "unlock/ongoging/time")

		pg = var_6_12

		local var_6_14 = var_6_12.TimeMgr.GetInstance()

		var_6_16(var_6_13, var_10.DescCDTime(var_6_14, var_6_3))
	elseif var_6_2 < var_7 then
		arg_6_0:UpdateTechnology(arg_6_3, var_6_0)
		arg_6_0:AddTimer(var_6_0, arg_6_3)
	else
		arg_6_0:UpdateTechnology(arg_6_3, var_6_0)

		if var_6_0:finishCondition() then
			local var_6_15 = arg_6_3

			var_6_16 = arg_6_3.Find(var_6_15, "unlock/finished/finish_btn")
			onButton = var_6_15

			local var_6_17 = arg_6_0
			local var_6_18 = var_6_16

			local function var_6_19()
				local var_9_0 = arg_6_0
				local var_9_1 = var_0.emit

				CommissionInfoMediator = var_2_10002

				var_9_1(var_9_0, var_2_10002.ON_TECH_FINISHED, {
					id = var_6_0.id,
					pool_id = var_6_0.poolId
				})

				return
			end

			SFX_PANEL = var_1_10013

			var_6_15(var_6_17, var_6_18, var_6_19, var_1_10013)

			onButton = var_6_15

			local var_6_20 = arg_6_0
			local var_6_21 = arg_6_3

			local function var_6_22()
				triggerButton = var_2_10000

				var_2_10000(var_6_16)

				return
			end

			SFX_PANEL = var_1_10013

			var_6_15(var_6_20, var_6_21, var_6_22, var_1_10013)
		else
			setText = var_6_16

			var_6_16(arg_6_3:Find("unlock/ongoging/time"), "00:00:00")
		end
	end

	setActive = var_6_16

	var_6_16(arg_6_3:Find("unlock"), true)

	setActive = var_6_16

	var_6_16(arg_6_3:Find("lock"), false)

	setActive = var_6_16

	var_6_16(arg_6_3:Find("unlock/leisure"), not var_6_0:isActivate())

	setActive = var_6_16

	local var_6_23 = arg_6_3:Find("unlock/ongoging")
	local var_6_24

	if var_6_0:isActivate() then
		var_6_24 = not var_6_0:isCompleted()
	end

	var_6_16(var_6_23, var_6_24)

	setActive = var_6_16

	var_6_16(arg_6_3:Find("unlock/finished"), var_6_0:isCompleted())

	setActive = var_6_16

	local var_6_25 = arg_6_3:Find("unlock/desc/task_bg")
	local var_6_26

	if var_6_0:isActivate() then
		var_6_26 = var_6_0:getConfig("condition") > 0
	end

	var_6_16(var_6_25, var_6_26)

	return
end

function var_0_1.AddTimer(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:Find("unlock/ongoging/time")
	local var_11_1 = var_3.GetComponent

	typeof = var_5
	Text = var_1_10006

	local var_11_2 = var_11_1(var_11_0, var_5(var_1_10006))
	local var_11_3 = arg_11_0.timers
	local var_11_4 = arg_11_1.id

	Timer = var_1_10006
	var_11_3[var_11_4] = var_1_10006.New(function()
		local var_12_0 = arg_11_1
		local var_12_1 = var_0.getFinishTime(var_12_0)

		pg = var_12_0

		local var_12_2 = var_12_0.TimeMgr.GetInstance()

		if var_12_1 - var_1.GetServerTime(var_12_2) > 0 then
			local var_12_3 = var_11_2

			pg = var_12_2

			local var_12_4 = var_12_2.TimeMgr.GetInstance()

			var_12_3.text = var_2.DescCDTime(var_12_4, var_0)
		else
			local var_12_5 = arg_11_0

			var_1.RemoveTimer(var_12_5, arg_11_1)

			local var_12_6 = arg_11_0

			var_1.OnFlush(var_12_6)

			local var_12_7 = arg_11_0

			var_1.UpdateList(var_12_7)
		end

		return
	end, 1, -1)

	local var_11_5 = arg_11_0.timers[arg_11_1.id]

	var_4.Start(var_11_5)
	arg_11_0.timers[arg_11_1.id].func()

	return
end

function var_0_1.RemoveTimer(arg_13_0, arg_13_1)
	if arg_13_0.timers[arg_13_1.id] then
		local var_13_0 = arg_13_0.timers[arg_13_1.id]

		var_2.Stop(var_13_0)

		arg_13_0.timers[arg_13_1.id] = nil
	end

	return
end

function var_0_1.UpdateTechnology(arg_14_0, arg_14_1, arg_14_2)
	setText = var_1_10003

	var_1_10003(arg_14_1:Find("unlock/desc/name_bg/Text"), arg_14_2:getConfig("name"))

	local var_14_0 = arg_14_2:getConfig("condition")

	if 0 < var_14_0 then
		getProxy = var_4
		TaskProxy = var_5

		local var_14_1 = var_4(var_5)
		local var_14_2 = var_4.getTaskVO(var_14_1, var_14_0)
		local var_14_3 = var_4.getConfig(var_14_2, "desc") .. "(" .. var_4:getProgress() .. "/" .. var_4:getConfig("target_num") .. ")"

		setText = var_6

		local var_14_4 = arg_14_1
		local var_14_5 = arg_14_1.Find(var_14_4, "unlock/desc/task_bg/Text")

		shortenString = var_14_4

		var_6(var_14_5, var_14_4(var_14_3, 10))
	end

	return
end

function var_0_1.GetList(arg_15_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_15_0 = var_1_10001(var_1_10002)
	local var_15_1 = var_1.getRawData(var_15_0)

	pg = var_15_0

	local var_15_2 = var_15_0.SystemOpenMgr.GetInstance()
	local var_15_3 = var_2.isOpenSystem(var_15_2, var_15_1.level, "TechnologyMediator")
	local var_15_4 = arg_15_0.list

	if var_15_3 then
		TechnologyConst = var_4

		local var_15_5

		if not (var_4.QUEUE_TOTAL_COUNT + 1) then
			var_15_5 = 0
		end

		return var_15_4, var_15_5
	end
end

function var_0_1.OnSkip(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.emit

	CommissionInfoMediator = var_1_10003

	var_16_1(var_16_0, var_1_10003.ON_ACTIVE_TECH)

	return
end

function var_0_1.OnFinishAll(arg_17_0)
	getProxy = var_1_10001
	TechnologyProxy = var_1_10002

	if var_1_10001(var_1_10002).queue[1] then
		local var_17_0 = var_1.queue[1]

		if var_2.isCompleted(var_17_0) then
			local var_17_1 = arg_17_0
			local var_17_2 = arg_17_0.emit

			CommissionInfoMediator = var_1_10004

			var_17_2(var_17_1, var_1_10004.ON_TECH_QUEUE_FINISH)

			goto label_17_0
		end
	end

	do
		local var_17_3 = var_1:getActivateTechnology()
		local var_17_4 = arg_17_0
		local var_17_5 = arg_17_0.emit

		CommissionInfoMediator = var_1_10005

		var_17_5(var_17_4, var_1_10005.ON_TECH_FINISHED, {
			id = var_17_3.id,
			pool_id = var_17_3.poolId
		})
	end

	::label_17_0::

	return
end

return var_0_1
