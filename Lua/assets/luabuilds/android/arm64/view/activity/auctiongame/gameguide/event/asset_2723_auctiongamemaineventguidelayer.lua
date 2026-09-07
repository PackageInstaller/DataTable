AuctionGameMainEventLayer = import("view.activity.AuctionGame.game.event.AuctionGameMainEventLayer")

local AuctionGameMainEventGuideLayer = class("AuctionGameMainEventGuideLayer", AuctionGameMainEventLayer)

function AuctionGameMainEventGuideLayer:init()
	AuctionGameMainEventGuideLayer.super.init(self)
	onButton(self, self.uiBgBtn, function()
		if getProxy(AuctionGameProxy):GetPersonalEventSelectedID() ~= 0 then
			self:closeView()
		end

		return
	end, SOUND_BACK)
	onButton(self, self.uiOkBtn, function()
		if getProxy(AuctionGameProxy):GetPersonalEventSelectedID() ~= 0 then
			return
		end

		if self.selectedID == 0 then
			return
		end

		AuctionGameTools.GuideSelectedEvent(self.selectedID)

		return
	end, SFX_CONFIRM)

	return
end

return AuctionGameMainEventGuideLayer
