local var_0_0 = class("AuctionGameMainEventItem", import("view.base.BasePanel"))

var_0_0.AUCTION_GAME_SELECTED_EVENT = "AuctionGameMainEventItem::AUCTION_GAME_SELECTED_EVENT"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1.gameObject

	var_0_0.super.Ctor(arg_1_0, arg_1_0._go)

	arg_1_0._parentClass = arg_1_2

	arg_1_0:attach(arg_1_2)
	arg_1_0:Init()

	return
end

function var_0_0.Init(arg_2_0)
	onButton(arg_2_0, arg_2_0.uiBtn, function()
		if getProxy(AuctionGameProxy):GetPersonalEventSelectedID() ~= 0 then
			return
		end

		arg_2_0:emit(var_0_0.AUCTION_GAME_SELECTED_EVENT, arg_2_0.id)

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.didEnter(arg_4_0, arg_4_1)
	arg_4_0.id = arg_4_1

	setText(arg_4_0.uiNameText, shortenString(pg.auction_event[arg_4_1].name, 9))
	setText(arg_4_0.uiDescText, pg.auction_event[arg_4_1].describe)
	LoadSpriteAsync(pg.auction_event[arg_4_1].icon, function(arg_5_0)
		if IsNil(arg_4_0.uiIconImage) then
			return
		end

		arg_4_0.uiIconImage.sprite = arg_5_0

		return
	end)

	return
end

function var_0_0.SetSelected(arg_6_0, arg_6_1)
	setActive(arg_6_0.uiSelectedGo, arg_6_0.id == arg_6_1)

	return
end

function var_0_0.willExit(arg_7_0)
	arg_7_0:detach()

	return
end

return var_0_0
