local AuctionGameMainEventLayer = class("AuctionGameMainEventLayer", import("view.base.BaseUI"))

function AuctionGameMainEventLayer:getUIName()
	return "AuctionGameMainEventUI"
end

function AuctionGameMainEventLayer:init()
	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiOkBtn, function()
		local var_4_0 = getProxy(AuctionGameProxy)

		if var_4_0:GetPersonalEventSelectedID() ~= 0 then
			return
		end

		if self.selectedID == 0 then
			return
		end

		pg.GameTrackerMgr.GetInstance():Record(GameTrackerBuilder.BuildAuctionChooseEvent(var_4_0:GetAuctionID(), var_4_0:GetRound(), pg.gameset.auction_event_choose_time.key_value - (var_4_0:GetTimestamp() - pg.TimeMgr.GetInstance():GetServerTime()), self.selectedID))
		self:emit(AuctionGameMainEventMediator.EVENT_SELECTED_ID, self.selectedID)

		return
	end, SFX_CONFIRM)

	self.eventItemList = {}

	return
end

function AuctionGameMainEventLayer:didEnter()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.EXPAND_POPUP)
	self:OverlayPanel(self._tf, {
		pbList = {
			self.uiBg
		}
	})

	local var_5_0 = getProxy(AuctionGameProxy)

	for iter_5_0, iter_5_1 in ipairs((var_5_0:GetPersonalEventList())) do
		self.eventItemList[iter_5_0] = AuctionGameMainEventItem.New(self[string.format("uiEventItemTf%s", iter_5_0)], self)

		self.eventItemList[iter_5_0]:didEnter(iter_5_1)
	end

	self:OnSelectedID(_, var_5_0:GetPersonalEventSelectedID())

	self.eventList = {
		self:bind(AuctionGameMainEventItem.AUCTION_GAME_SELECTED_EVENT, handler(self, self.OnSelectedID))
	}

	return
end

function AuctionGameMainEventLayer:OnSelectedID(arg_6_1, arg_6_2)
	self.selectedID = arg_6_2

	for iter_6_0, iter_6_1 in ipairs(self.eventItemList) do
		iter_6_1:SetSelected(arg_6_2)
	end

	self:RefreshOkBtn()

	return
end

function AuctionGameMainEventLayer:RefreshOkBtn()
	if getProxy(AuctionGameProxy):GetPersonalEventSelectedID() ~= 0 then
		return
	end

	return
end

function AuctionGameMainEventLayer:willExit()
	pg.CriMgr.GetInstance():PlaySoundEffect_V3(AuctionGameConst.SOUND_EFFECT.COLLAPSE_POPUP)
	self:UnOverlayPanel(self._tf)

	for iter_8_0, iter_8_1 in ipairs(self.eventList) do
		self:disconnect(iter_8_1)
	end

	self.eventList = nil

	for iter_8_2, iter_8_3 in ipairs(self.eventItemList) do
		iter_8_3:willExit()
	end

	self.eventItemList = nil

	return
end

return AuctionGameMainEventLayer
