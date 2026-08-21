local var_0_0 = class("AuctionGameMainRightInfoView", import("view.base.BasePanel"))

var_0_0.EVENT_INFO_UPDATE = "AuctionGameMainRightInfoView:EVENT_INFO_UPDATE"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	arg_2_0.itemList = {}

	return
end

function var_0_0.didEnter(arg_3_0)
	arg_3_0.eventList = {
		arg_3_0:bind(var_0_0.EVENT_INFO_UPDATE, handler(arg_3_0, arg_3_0.OnUpdateEventInfo))
	}

	return
end

function var_0_0.OnUpdateEventInfo(arg_4_0)
	arg_4_0:RefreshUI(arg_4_0.filterPersonalFlag, arg_4_0.filterCommonFlag)

	return
end

function var_0_0.RefreshUI(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.filterPersonalFlag = arg_5_1
	arg_5_0.filterCommonFlag = arg_5_2

	for iter_5_0, iter_5_1 in ipairs(getProxy(AuctionGameProxy):GetEventSummary()) do
		if iter_5_1.commonEventData then
			table.insert({}, 1, {
				type = AuctionGameConst.EVENT_TYPE_GROUP.COMMON,
				round = iter_5_0,
				eventData = iter_5_1.commonEventData
			})
		end

		if iter_5_1.personalEventData then
			table.insert({}, 1, {
				type = AuctionGameConst.EVENT_TYPE_GROUP.PERSONAL,
				round = iter_5_0,
				eventData = iter_5_1.personalEventData
			})
		end
	end

	for iter_5_2, iter_5_3 in ipairs({}) do
		arg_5_0.itemList[iter_5_2] = arg_5_0.itemList[iter_5_2] or AuctionGameMainRightInfoItem.New(Instantiate(arg_5_0.uiItemTf, arg_5_0.uiContentTf), arg_5_0._parentClass)

		arg_5_0.itemList[iter_5_2]:didEnter(iter_5_3, arg_5_1, arg_5_2)
	end

	return
end

function var_0_0.willExit(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.itemList) do
		iter_6_1:willExit()
	end

	arg_6_0.itemList = nil

	for iter_6_2, iter_6_3 in ipairs(arg_6_0.eventList) do
		arg_6_0:disconnect(iter_6_3)
	end

	arg_6_0.eventList = nil

	arg_6_0:detach()

	return
end

return var_0_0
