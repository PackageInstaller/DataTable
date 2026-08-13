class = var_0_10000

local var_0_0 = "MainUrShipReFetchSequence"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.ON_TIME_UP = "MainUrShipReFetchSequence:ON_TIME_UP"

function var_0_1.Ctor(arg_1_0)
	local var_1_0 = var_0_1.super.Ctor
	local var_1_1 = arg_1_0

	BaseEventLogic = var_1_10004

	var_1_0(var_1_1, var_1_10004.New())

	pg = var_1_0

	local var_1_2 = var_1_0.m02

	var_1.registerMediator(var_1_2, arg_1_0)

	return
end

function var_0_1.Execute(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.getActivitiesByType

	ActivityConst = var_1_10006

	if #var_2_1(var_2_0, var_1_10006.ACTIVITY_TYPE_GRAFTING) == 0 then
		arg_2_1()

		return
	end

	arg_2_0:CheckUrShipAct(var_3, arg_2_1)

	return
end

local function var_0_2(arg_3_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10001(var_1_10003)

	return var_1.getActivityById(var_3_0, arg_3_0) and not var_2:isEnd()
end

local function var_0_3(arg_4_0)
	ActivityConst = var_1_10001

	local var_4_0

	if arg_4_0 ~= var_1_10001.ACTIVITY_TYPE_BUILDSHIP_1 then
		ActivityConst = var_1

		if arg_4_0 ~= var_1.ACTIVITY_TYPE_BUILD then
			ActivityConst = var_1

			if arg_4_0 ~= var_1.ACTIVITY_TYPE_NEWSERVER_BUILD then
				var_4_0 = false

				goto label_4_0
			end
		end
	end

	var_4_0 = true

	::label_4_0::

	return var_4_0
end

local function var_0_4(arg_5_0)
	if not arg_5_0 or arg_5_0:isEnd() then
		return false
	end

	local var_5_0 = arg_5_0:getConfig("config_id")

	if var_0_2(var_5_0) then
		return false
	end

	pg = var_2

	return var_2.activity_template[var_5_0] and var_0_3(var_2.type)
end

function var_0_1.CheckUrShipAct(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}

	pairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(arg_6_1) do
		if var_0_4(iter_6_1) then
			table = var_9

			var_9.insert(var_6_0, function(arg_7_0)
				local var_7_0 = arg_6_0

				var_1.TryFetchUrShips(var_7_0, iter_6_1, arg_7_0)

				return
			end)
		end
	end

	seriesAsync = var_4

	var_4(var_6_0, arg_6_2)

	return
end

local function var_0_5(arg_8_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_8_0 = var_1_10001(var_1_10003)

	if not var_1.getActivityById(var_8_0, arg_8_0) or var_2:isEnd() then
		return false
	end

	local var_8_1 = var_2:getConfig("config_id")

	pg = var_8_0

	local var_8_2 = var_8_0.ship_data_create_exchange[var_8_1].exchange_request
	local var_8_3 = var_4.exchange_available_times
	local var_8_4 = var_2.data1
	local var_8_5 = var_2.data2

	math = var_1_10009

	local var_8_6 = var_1_10009.min(var_8_3, var_8_5 + 1) * var_8_2

	return var_8_5 < var_8_3 and var_8_6 <= var_8_4
end

function var_0_1.TryFetchUrShips(arg_9_0, arg_9_1, arg_9_2)
	local function var_9_0()
		local var_10_0 = arg_9_0

		var_0.TryFetchUrShips(var_10_0, arg_9_1, arg_9_2)

		return
	end

	if var_0_5(arg_9_1.id) then
		arg_9_0:ShowFetchShipMsgbox(arg_9_1.id, var_9_0)
	else
		arg_9_2()
	end

	return
end

function var_0_1.ShowFetchShipMsgbox(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0.callback = arg_11_2
	UrShipRefetchWindow = var_1_10003

	local var_11_0 = var_1_10003.New

	pg = var_1_10005
	arg_11_0.page = var_11_0(var_1_10005.UIMgr.GetInstance().UIMain)

	local var_11_1 = arg_11_0.page

	var_3.ExecuteAction(var_11_1, "Show", arg_11_1)

	return
end

function var_0_1.listNotificationInterests(arg_12_0)
	local var_12_0 = {}

	GAME = var_1_10002
	var_12_0[1] = var_1_10002.GRAFTING_ACT_OP_DONE
	MainUrShipReFetchSequence = var_2
	var_12_0[2] = var_2.ON_TIME_UP

	return var_12_0
end

function var_0_1.handleNotification(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1
	local var_13_1 = arg_13_1.getName(var_13_0)
	local var_13_2 = arg_13_1:getBody()

	GAME = var_13_0

	local var_13_4

	if var_13_1 == var_13_0.GRAFTING_ACT_OP_DONE and var_0_3(var_13_2.linkActType) then
		if #var_13_2.awards > 0 then
			local var_13_3 = arg_13_0.viewComponent

			var_13_4 = var_13_4.emit
			BaseUI = var_1_10007

			var_13_4(var_13_3, var_1_10007.ON_ACHIEVE, var_13_2.awards, arg_13_0.callback)
		else
			arg_13_0.callback()
		end

		if arg_13_0.page then
			local var_13_5 = arg_13_0.page

			if var_13_4.GetLoaded(var_13_5) then
				local var_13_6 = arg_13_0.page

				if var_13_4.isShowing(var_13_6) then
					local var_13_7 = arg_13_0.page

					var_13_4.Hide(var_13_7)
				end
			end
		end

		arg_13_0.callback = nil
	else
		MainUrShipReFetchSequence = var_13_4

		if var_13_1 == var_13_4.ON_TIME_UP then
			if arg_13_0.page then
				local var_13_8 = arg_13_0.page

				if var_4.GetLoaded(var_13_8) then
					local var_13_9 = arg_13_0.page

					if var_4.isShowing(var_13_9) then
						local var_13_10 = arg_13_0.page

						var_4.Hide(var_13_10)
					end
				end
			end

			if arg_13_0.callback then
				arg_13_0.callback()

				arg_13_0.callback = nil
			end
		end
	end

	return
end

function var_0_1.Clear(arg_14_0)
	if arg_14_0.page then
		local var_14_0 = arg_14_0.page

		var_1.Destroy(var_14_0)

		arg_14_0.page = nil
	end

	return
end

function var_0_1.Dispose(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.m02

	var_1.removeMediator(var_15_0, arg_15_0.__cname)
	arg_15_0:Clear()

	return
end

function var_0_1.addSubLayers(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	assert = var_1_10004
	isa = var_1_10006

	local var_16_0 = arg_16_1

	Context = var_1_10009

	var_1_10004(var_1_10006(var_16_0, var_1_10009), "should be an instance of Context")

	getProxy = var_1_10004
	ContextProxy = var_6

	local var_16_1 = var_1_10004(var_6)
	local var_16_2 = var_4.getCurrentContext(var_16_1)
	local var_16_3 = var_5.getContextByMediator

	NewMainMediator = var_1_10009

	local var_16_4 = var_16_3(var_16_2, var_1_10009)

	if arg_16_2 then
		while var_16_4.parent do
			var_16_4 = var_16_4.parent
		end
	end

	pg = var_16_1

	local var_16_5 = var_16_1.m02
	local var_16_6 = var_7.sendNotification

	GAME = var_1_10010

	var_16_6(var_16_5, var_1_10010.LOAD_LAYERS, {
		parentContext = var_16_4,
		context = arg_16_1,
		callback = arg_16_3
	})

	return
end

return var_0_1
