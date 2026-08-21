AuctionGameMainEventLayer = import("view.activity.AuctionGame.game.event.AuctionGameMainEventLayer")

local var_0_0 = class("AuctionGameMainEventGuideLayer", AuctionGameMainEventLayer)

function var_0_0.init(arg_1_0)
	var_0_0.super.init(arg_1_0)
	onButton(arg_1_0, arg_1_0.uiBgBtn, function()
		if getProxy(AuctionGameProxy):GetPersonalEventSelectedID() ~= 0 then
			arg_1_0:closeView()
		end

		return
	end, SOUND_BACK)
	onButton(arg_1_0, arg_1_0.uiOkBtn, function()
		if getProxy(AuctionGameProxy):GetPersonalEventSelectedID() ~= 0 then
			return
		end

		if arg_1_0.selectedID == 0 then
			return
		end

		AuctionGameTools.GuideSelectedEvent(arg_1_0.selectedID)

		return
	end, SFX_CONFIRM)

	return
end

return var_0_0
