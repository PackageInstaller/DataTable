class = var_0_10000

local var_0_0 = "AuctionGameMainRightInfoView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BasePanel"))

var_0_1.EVENT_INFO_UPDATE = "AuctionGameMainRightInfoView:EVENT_INFO_UPDATE"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_1.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_1.Init(arg_2_0)
	arg_2_0.itemList = {}

	return
end

function var_0_1.didEnter(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.bind
	local var_3_3 = var_0_1.EVENT_INFO_UPDATE

	handler = var_1_10006
	var_3_0[1] = var_3_2(var_3_1, var_3_3, var_1_10006(arg_3_0, arg_3_0.OnUpdateEventInfo))
	arg_3_0.eventList = var_3_0

	return
end

function var_0_1.OnUpdateEventInfo(arg_4_0)
	arg_4_0:RefreshUI(arg_4_0.filterPersonalFlag, arg_4_0.filterCommonFlag)

	return
end

function var_0_1.RefreshUI(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.filterPersonalFlag = arg_5_1
	arg_5_0.filterCommonFlag = arg_5_2
	getProxy = var_1_10003
	AuctionGameProxy = var_1_10005

	local var_5_0 = var_1_10003(var_1_10005)
	local var_5_1 = {}

	ipairs = var_1_10005

	for iter_5_0, iter_5_1 in var_1_10005(var_5_0:GetEventSummary()) do
		if iter_5_1.commonEventData then
			table = var_10

			local var_5_2 = var_10.insert
			local var_5_3 = var_5_1

			var_1_10013 = 1

			local var_5_4 = {}

			AuctionGameConst = var_1_10015
			var_5_4.type = var_1_10015.EVENT_TYPE_GROUP.COMMON
			var_5_4.round = iter_5_0
			var_5_4.eventData = iter_5_1.commonEventData

			var_5_2(var_5_3, var_1_10013, var_5_4)
		end

		if iter_5_1.personalEventData then
			table = var_10

			local var_5_5 = var_10.insert
			local var_5_6 = var_5_1

			var_1_10013 = 1

			local var_5_7 = {}

			AuctionGameConst = var_1_10015
			var_5_7.type = var_1_10015.EVENT_TYPE_GROUP.PERSONAL
			var_5_7.round = iter_5_0
			var_5_7.eventData = iter_5_1.personalEventData

			var_5_5(var_5_6, var_1_10013, var_5_7)
		end
	end

	ipairs = var_5

	for iter_5_2, iter_5_3 in var_5(var_5_1) do
		local var_5_8 = arg_5_0.itemList
		local var_5_9

		if not arg_5_0.itemList[iter_5_2] then
			AuctionGameMainRightInfoItem = var_5_9
			var_5_9 = var_5_9.New
			Instantiate = var_1_10013
			var_5_9 = var_5_9(var_1_10013(arg_5_0.uiItemTf, arg_5_0.uiContentTf), arg_5_0._parentClass)
		end

		var_5_8[iter_5_2] = var_5_9

		local var_5_10 = arg_5_0.itemList[iter_5_2]

		var_10.didEnter(var_5_10, iter_5_3, arg_5_1, arg_5_2)
	end

	return
end

function var_0_1.willExit(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.itemList) do
		iter_6_1:willExit()
	end

	arg_6_0.itemList = nil
	ipairs = var_1

	for iter_6_2, iter_6_3 in var_1(arg_6_0.eventList) do
		arg_6_0:disconnect(iter_6_3)
	end

	arg_6_0.eventList = nil

	arg_6_0:detach()

	return
end

return var_0_1
