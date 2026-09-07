local AuctionGameMainNoticeBoardItem = class("AuctionGameMainNoticeBoardItem", import("view.base.BasePanel"))

function AuctionGameMainNoticeBoardItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainNoticeBoardItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainNoticeBoardItem:Init()
	onButton(self, self.uiEventBtn, function()
		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New({
			viewComponent = AuctionGameMainEventMsgLayer,
			mediator = AuctionGameMainEventMsgMediator,
			data = {
				eventID = self.data.eventID
			}
		}))

		return
	end, SFX_PANEL)

	return
end

function AuctionGameMainNoticeBoardItem:didEnter(arg_4_1)
	self.data = arg_4_1

	if arg_4_1 == nil then
		return
	end

	setText(self.uiBidText, StringHelper.ForamtNumber(arg_4_1.bidValue or 0))

	if arg_4_1.eventID ~= nil then
		LoadSpriteAsync(pg.auction_event[arg_4_1.eventID].icon, function(arg_5_0)
			if not IsNil(self.uiEventImage) then
				self.uiEventImage.sprite = arg_5_0
			end

			return
		end)
	end

	return
end

function AuctionGameMainNoticeBoardItem:willExit()
	self:detach()
	Object.Destroy(self._go)

	return
end

return AuctionGameMainNoticeBoardItem
