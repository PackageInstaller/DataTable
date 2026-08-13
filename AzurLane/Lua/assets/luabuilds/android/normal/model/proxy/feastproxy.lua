class = var_0_10000

local var_0_0 = "FeastProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.proxy.NetProxy"))

function var_0_1.register(arg_1_0)
	return
end

local function var_0_2(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_0:getRawData() ~= nil then
		arg_2_2()

		return
	end

	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.sendNotification

	GAME = var_1_10005

	var_2_1(var_2_0, var_1_10005.GET_FEAST_DATA, {
		activityId = arg_2_1.id,
		callback = arg_2_2
	})

	return
end

local function var_0_3(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_1:getConfig("config_data")[1] then
		var_3_0 = 5
	end

	local var_3_1 = arg_3_0:getRawData()

	if not var_5.ShouldRandomShips(var_3_1) then
		arg_3_2()

		return
	end

	local var_3_2

	if not var_3[3] then
		var_3_2 = {}
	end

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.RandomShips(var_3_3, var_3_2, var_3_0)

	_ = var_3_3

	local var_3_5 = var_3_3.map(var_3_4, function(arg_4_0)
		return arg_4_0.id
	end)
	local var_3_6 = arg_3_0
	local var_3_7 = arg_3_0.sendNotification

	GAME = var_1_10011

	local var_3_8 = var_1_10011.FEAST_OP
	local var_3_9 = {
		activityId = arg_3_1.id
	}

	FeastDorm = var_13
	var_3_9.cmd = var_13.OP_RANDOM_SHIPS
	var_3_9.argList = var_3_5
	var_3_9.callback = arg_3_2

	var_3_7(var_3_6, var_3_8, var_3_9)

	return
end

function var_0_1.RequestData(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_5_0 = var_1_10002(var_1_10003)
	local var_5_1 = var_2.getActivityByType

	ActivityConst = var_1_10004

	if not var_5_1(var_5_0, var_1_10004.ACTIVITY_TYPE_FEAST) or var_2:isEnd() then
		arg_5_1()

		return
	end

	seriesAsync = var_5_0

	var_5_0({
		function(arg_6_0)
			var_0_2(arg_5_0, var_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			var_0_3(arg_5_0, var_0, arg_7_0)

			return
		end
	}, arg_5_1)

	return
end

function var_0_1.SetData(arg_8_0, arg_8_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_8_0 = arg_8_1

	FeastDorm = var_1_10005

	var_1_10002(var_1_10003(var_8_0, var_1_10005))

	arg_8_0.data = arg_8_1

	arg_8_0:AddRefreshTimer()

	return
end

function var_0_1.UpdateData(arg_9_0, arg_9_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_9_0 = arg_9_1

	FeastDorm = var_1_10005

	var_1_10002(var_1_10003(var_9_0, var_1_10005))

	arg_9_0.data = arg_9_1

	return
end

function var_0_1.GetConsumeList(arg_10_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_10_0 = var_1_10001(var_1_10002)
	local var_10_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_10_2 = var_10_1(var_10_0, var_1_10003.ACTIVITY_TYPE_FEAST)
	local var_10_3

	if not var_1.getConfig(var_10_2, "config_data")[3] then
		var_10_3 = {}
	end

	local var_10_4 = var_10_3[1]

	pg = var_1_10005

	local var_10_5 = var_1_10005.activity_partyinvitation_template[var_10_4].invitationID[2]
	local var_10_6 = var_5.giftID[2]

	return var_10_5, var_10_6
end

local function var_0_4(arg_11_0)
	_ = var_1_10001

	local var_11_0 = var_1_10001.filter

	pg = var_1_10002

	local var_11_1 = var_11_0(var_1_10002.ship_data_group.all, function(arg_12_0)
		pg = var_2_10001

		return var_2_10001.ship_data_group[arg_12_0].handbook_type ~= 1
	end)
	local var_11_2 = {}
	local var_11_3 = {}

	ipairs = var_1_10004

	for iter_11_0, iter_11_1 in var_1_10004(var_11_1) do
		pg = var_1_10009

		if arg_11_0[var_1_10009.ship_data_group[iter_11_1].group_type] then
			table = var_1_10011

			var_1_10011.insert(var_11_2, var_10)
		else
			table = var_1_10011
			var_1_10011 = var_1_10011.insert

			local var_11_4 = var_11_2

			ShipGroup = var_1_10013

			var_1_10011(var_11_4, var_1_10013.New({
				id = var_1_10009.group_type
			}))
		end
	end

	return var_11_2, var_11_3
end

local function var_0_5(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = {}

	pairs = var_1_10005

	for iter_13_0, iter_13_1 in var_1_10005(arg_13_0) do
		table = var_1_10010

		if not var_1_10010.contains(arg_13_1, iter_13_1.id) then
			table = var_1_10010

			var_1_10010.insert(var_13_0, iter_13_1)
		end
	end

	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}

	ipairs = iter_13_0

	for iter_13_2, iter_13_3 in iter_13_0(var_13_0) do
		ShipGroup = var_1_10013
		var_1_10013 = var_1_10013.getSkinList(iter_13_3.id)
		ipairs = var_14

		for iter_13_4, iter_13_5 in var_14(var_1_10013) do
			ShipSkin = var_1_10019

			local var_13_4 = var_1_10019.GetShopTypeIdBySkinId(iter_13_5.id, var_13_3) == 7 and var_13_1 or var_13_2

			table = var_21

			var_21.insert(var_13_4, iter_13_3)
		end
	end

	shuffle = var_8

	var_8(var_13_1)

	shuffle = var_8

	var_8(var_13_2)

	ipairs = var_8

	for iter_13_6, iter_13_7 in var_8(var_13_1) do
		table = var_1_10013

		if var_1_10013.getCount(arg_13_2) == arg_13_3 then
			break
		end

		arg_13_2[iter_13_7.id] = iter_13_7
	end

	ipairs = var_8

	for iter_13_8, iter_13_9 in var_8(var_13_2) do
		table = var_1_10013

		if var_1_10013.getCount(arg_13_2) == arg_13_3 then
			break
		end

		arg_13_2[iter_13_9.id] = iter_13_9
	end

	return
end

function var_0_1.RandomShips(arg_14_0, arg_14_1, arg_14_2)
	pg = var_1_10003

	local var_14_0

	if not var_1_10003.activity_partyinvitation_template then
		var_14_0 = {}
	end

	local var_14_1 = {}

	ipairs = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10005(arg_14_1) do
		table = var_1_10010

		var_1_10010.insert(var_14_1, var_14_0[iter_14_1].groupid)
	end

	local var_14_2 = arg_14_0:getRawData()
	local var_14_3 = var_5.GetFeastShipList(var_14_2)

	pairs = var_14_2

	for iter_14_2, iter_14_3 in var_14_2(var_14_3) do
		table = var_1_10011

		if not var_1_10011.contains(var_14_1, iter_14_2) then
			table = var_1_10011

			var_1_10011.insert(var_14_1, iter_14_2)
		end
	end

	getProxy = var_6
	CollectionProxy = var_7

	local var_14_4 = var_6(var_7)
	local var_14_5 = var_6.RawgetGroups(var_14_4)
	local var_14_6, var_14_7 = var_0_4(var_14_5)
	local var_14_8 = {}

	var_0_5(var_14_6, var_14_1, var_14_8, arg_14_2)
	var_0_5(var_14_7, var_14_1, var_14_8, arg_14_2)

	local var_14_9 = {}

	pairs = var_11

	for iter_14_4, iter_14_5 in var_11(var_14_8) do
		table = var_1_10016

		var_1_10016.insert(var_14_9, iter_14_5)
	end

	return var_14_9
end

function var_0_1.AddRefreshTimer(arg_15_0)
	arg_15_0:RemoveRefreshTimer()

	pg = var_1

	local var_15_0 = var_1.TimeMgr.GetInstance()
	local var_15_1 = var_1.GetServerTime(var_15_0)

	GetZeroTime = var_15_0

	local var_15_2 = var_15_0() - var_15_1

	Timer = var_1_10004
	arg_15_0.timer = var_1_10004.New(function()
		local var_16_0 = arg_15_0

		var_0.RemoveRefreshTimer(var_16_0)

		getProxy = var_0
		ActivityProxy = var_16_0

		local var_16_1 = var_0(var_16_0)
		local var_16_2 = var_0.getActivityByType

		ActivityConst = var_2_10002

		if var_16_2(var_16_1, var_2_10002.ACTIVITY_TYPE_FEAST) and not var_0:isEnd() then
			var_0_3(arg_15_0, var_0, function()
				return
			end)
		end

		return
	end, var_15_2 + 1, 1)

	local var_15_3 = arg_15_0.timer

	var_4.Start(var_15_3)

	return
end

function var_0_1.RemoveRefreshTimer(arg_18_0)
	if arg_18_0.timer then
		local var_18_0 = arg_18_0.timer

		var_1.Stop(var_18_0)

		arg_18_0.timer = nil
	end

	return
end

function var_0_1.remove(arg_19_0)
	arg_19_0:RemoveRefreshTimer()

	return
end

function var_0_1.GetBuffList(arg_20_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_20_0 = var_1_10001(var_1_10002)
	local var_20_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	if not var_20_1(var_20_0, var_1_10003.FEAST_PT_ACT) or var_1:isEnd() then
		return {}
	end

	return var_1:GetBuffList()
end

function var_0_1.GetTaskList(arg_21_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_21_0 = var_1_10001(var_1_10002)
	local var_21_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_21_2 = var_21_1(var_21_0, var_1_10003.FEAST_TASK_ACT)

	assert = var_21_0

	var_21_0(var_21_2)

	local var_21_3 = {}

	getProxy = var_3
	TaskProxy = var_1_10004

	local var_21_4 = var_3(var_1_10004)

	ipairs = var_1_10004

	for iter_21_0, iter_21_1 in var_1_10004(var_21_2:getConfig("config_data")) do
		local var_21_5 = var_21_4
		local var_21_6

		if not var_21_4.getTaskById(var_21_5, iter_21_1) then
			var_21_5 = var_21_4
			var_21_6 = var_21_4.getFinishTaskById(var_21_5, iter_21_1)
		end

		if var_21_6 then
			table = var_21_5

			var_21_5.insert(var_21_3, iter_21_1)
		end
	end

	return var_21_3
end

function var_0_1.GetPtActData(arg_22_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_22_0 = var_1_10001(var_1_10002)
	local var_22_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	local var_22_2 = var_22_1(var_22_0, var_1_10003.FEAST_PT_ACT)

	assert = var_22_0

	var_22_0(var_22_2)

	ActivityPtData = var_22_0

	return (var_22_0.New(var_22_2))
end

function var_0_1.GetSubmittedTaskStories(arg_23_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_23_0 = var_1_10001(var_1_10002)
	local var_23_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	if not var_23_1(var_23_0, var_1_10003.ACTIVITY_TYPE_FEAST) or var_1:isEnd() then
		return {}
	end

	local var_23_2 = var_1:getConfig("config_client")
	local var_23_3 = {
		var_23_2[8],
		var_23_2[9]
	}
	local var_23_4 = {}

	ipairs = var_1_10005

	for iter_23_0, iter_23_1 in var_1_10005(var_23_3) do
		local var_23_5 = iter_23_1[1]
		local var_23_6 = iter_23_1[2]

		pg = var_1_10012

		local var_23_7 = var_1_10012.NewStoryMgr.GetInstance()

		if not var_1_10012.IsPlayed(var_23_7, var_23_6) then
			var_23_4[var_23_5] = var_23_6
		end
	end

	return var_23_4
end

function var_0_1.ShouldTipPt(arg_24_0)
	local var_24_0 = arg_24_0:GetPtActData()

	if var_1.AnyAwardCanGet(var_24_0) then
		return true
	end

	return false
end

function var_0_1.ShouldTipFeastTask(arg_25_0)
	getProxy = var_1_10001
	TaskProxy = var_1_10002

	local var_25_0 = var_1_10001(var_1_10002)
	local var_25_1 = arg_25_0
	local var_25_2 = arg_25_0.GetTaskList(var_25_1)

	ipairs = var_25_1

	for iter_25_0, iter_25_1 in var_25_1(var_25_2) do
		if var_25_0:getTaskById(iter_25_1) and var_8:isFinish() and not var_8:isReceive() then
			return true
		end
	end

	return false
end

function var_0_1.ShouldTipTask(arg_26_0)
	if arg_26_0:ShouldTipPt() then
		return true
	end

	if arg_26_0:ShouldTipFeastTask() then
		return true
	end

	return false
end

function var_0_1.ShouldTipInvitation(arg_27_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_27_0 = var_1_10001(var_1_10002)
	local var_27_1 = var_1.getActivityByType

	ActivityConst = var_1_10003

	local var_27_2 = var_27_1(var_27_0, var_1_10003.ACTIVITY_TYPE_VIRTUAL_BAG)
	local var_27_3, var_27_4 = arg_27_0:GetConsumeList()
	local var_27_5 = var_27_2:getVitemNumber(var_27_3)
	local var_27_6 = var_27_2:getVitemNumber(var_27_4)
	local var_27_7 = arg_27_0.data
	local var_27_8 = var_6.GetInvitedFeastShipList(var_27_7)

	ipairs = var_27_7

	for iter_27_0, iter_27_1 in var_27_7(var_27_8) do
		if not iter_27_1:GotGift() and var_27_6 > 0 or not iter_27_1:GotTicket() and var_27_5 > 0 then
			return true
		end
	end

	return false
end

function var_0_1.ShouldTip(arg_28_0)
	if not arg_28_0.data then
		return false
	end

	getProxy = var_1
	ActivityProxy = var_1_10002

	local var_28_0 = var_1(var_1_10002)
	local var_28_1 = var_1.getActivityById

	ActivityConst = var_1_10003

	if var_28_1(var_28_0, var_1_10003.FEAST_TASK_ACT) then
		local var_28_2 = var_1

		if var_1.isEnd(var_28_2) then
			return false
		end

		getProxy = var_28_0
		ActivityProxy = var_28_2

		local var_28_3 = var_28_0(var_28_2)
		local var_28_4 = var_2.getActivityById

		ActivityConst = var_1_10004

		if var_28_4(var_28_3, var_1_10004.FEAST_PT_ACT) then
			local var_28_5 = var_2

			if var_2.isEnd(var_28_5) then
				return false
			end

			getProxy = var_28_3
			ActivityProxy = var_28_5

			local var_28_6 = var_28_3(var_28_5)
			local var_28_7 = var_3.getActivityByType

			ActivityConst = var_1_10005

			if not var_28_7(var_28_6, var_1_10005.ACTIVITY_TYPE_VIRTUAL_BAG) or var_3:isEnd() then
				return false
			end

			if arg_28_0.data == nil then
				return false
			end

			local var_28_8 = arg_28_0.data
			local var_28_9 = var_4.GetFeastShipList(var_28_8)

			pairs = var_28_8

			for iter_28_0, iter_28_1 in var_28_8(var_28_9) do
				if iter_28_1:HasBubble() then
					return true
				end
			end

			if arg_28_0:ShouldTipTask() then
				return true
			end

			if arg_28_0:ShouldTipInvitation() then
				return true
			end

			return false
		end
	end
end

function var_0_1.HandleTaskStories(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_0

	if arg_29_0.GetSubmittedTaskStories(var_29_0) then
		table = var_29_0

		if var_29_0.getCount(var_3) == 0 then
			if arg_29_2 then
				arg_29_2()
			end

			return
		end

		local var_29_1 = {}

		ipairs = var_1_10005

		for iter_29_0, iter_29_1 in var_1_10005(arg_29_1) do
			if var_3[iter_29_1] ~= nil then
				table = var_10

				var_10.insert(var_29_1, var_3[iter_29_1])
			end
		end

		if #var_29_1 > 0 then
			if arg_29_2 then
				pg = var_5

				local var_29_2 = var_5.NewStoryMgr.GetInstance()

				var_5.SeriesPlay(var_29_2, var_29_1, arg_29_2)
			else
				pg = var_5

				local var_29_3 = var_5.NewStoryMgr.GetInstance()

				var_5.SeriesPlay(var_29_3, var_29_1)
			end
		end

		return
	end
end

return var_0_1
