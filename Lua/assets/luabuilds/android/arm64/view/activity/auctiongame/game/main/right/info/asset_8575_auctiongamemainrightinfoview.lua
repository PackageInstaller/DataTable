local AuctionGameMainRightInfoView = class("AuctionGameMainRightInfoView", import("view.base.BasePanel"))

AuctionGameMainRightInfoView.EVENT_INFO_UPDATE = "AuctionGameMainRightInfoView:EVENT_INFO_UPDATE"

function AuctionGameMainRightInfoView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainRightInfoView.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainRightInfoView:Init()
	self.itemList = {}

	return
end

function AuctionGameMainRightInfoView:didEnter()
	self.eventList = {
		self:bind(AuctionGameMainRightInfoView.EVENT_INFO_UPDATE, handler(self, self.OnUpdateEventInfo))
	}

	return
end

function AuctionGameMainRightInfoView:OnUpdateEventInfo()
	self:RefreshUI(self.filterPersonalFlag, self.filterCommonFlag)

	return
end

function AuctionGameMainRightInfoView:RefreshUI(arg_5_1, arg_5_2)
	self.filterPersonalFlag = arg_5_1
	self.filterCommonFlag = arg_5_2

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(getProxy(AuctionGameProxy):GetEventSummary()) do
		if iter_5_1.commonEventData then
			table.insert(var_5_0, 1, {
				type = AuctionGameConst.EVENT_TYPE_GROUP.COMMON,
				round = iter_5_0,
				eventData = iter_5_1.commonEventData
			})
		end

		if iter_5_1.personalEventData then
			table.insert(var_5_0, 1, {
				type = AuctionGameConst.EVENT_TYPE_GROUP.PERSONAL,
				round = iter_5_0,
				eventData = iter_5_1.personalEventData
			})
		end
	end

	for iter_5_2, iter_5_3 in ipairs(var_5_0) do
		self.itemList[iter_5_2] = self.itemList[iter_5_2] or AuctionGameMainRightInfoItem.New(Instantiate(self.uiItemTf, self.uiContentTf), self._parentClass)

		self.itemList[iter_5_2]:didEnter(iter_5_3, arg_5_1, arg_5_2)
	end

	return
end

function AuctionGameMainRightInfoView:willExit()
	for iter_6_0, iter_6_1 in ipairs(self.itemList) do
		iter_6_1:willExit()
	end

	self.itemList = nil

	for iter_6_2, iter_6_3 in ipairs(self.eventList) do
		self:disconnect(iter_6_3)
	end

	self.eventList = nil

	self:detach()

	return
end

return AuctionGameMainRightInfoView
