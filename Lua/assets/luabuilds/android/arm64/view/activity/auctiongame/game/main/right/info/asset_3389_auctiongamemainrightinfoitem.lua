local AuctionGameMainRightInfoItem = class("AuctionGameMainRightInfoItem", import("view.base.BasePanel"))

function AuctionGameMainRightInfoItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainRightInfoItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainRightInfoItem:Init()
	return
end

function AuctionGameMainRightInfoItem:didEnter(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = pg.auction_round[arg_3_1.round].name

	if arg_3_1.type == AuctionGameConst.EVENT_TYPE_GROUP.COMMON then
		var_3_0 = var_3_0 .. i18n("auction_main_public_event")

		setActive(self._go, arg_3_3)
	else
		var_3_0 = var_3_0 .. i18n("auction_main_personal_event")

		setActive(self._go, arg_3_2)
	end

	setText(self.uiTitleText, var_3_0)

	local var_3_1 = getProxy(AuctionGameProxy):GetRound() == arg_3_1.round
	local var_3_2 = pg.auction_event[arg_3_1.eventData.eventID]
	local var_3_3 = var_3_1 and "#324bca" or "#676c7d"

	if pg.auction_event[arg_3_1.eventData.eventID].information_bar == 1 then
		setText(self.uiResultText, string.format("<color=%s>%s</color>", var_3_3, var_3_2.describe))
	else
		local var_3_4 = arg_3_1.eventData.value

		var_3_4 = var_3_2.type == AuctionGameConst.EVENT_TYPE.MAX_RARITY and i18n("auction_game_rarity_" .. var_3_4) or var_3_2.type == AuctionGameConst.EVENT_TYPE.RARITY_ITEMS_CELL_COUNT and var_3_4 / 100 or StringHelper.ForamtNumber(var_3_4)

		setText(self.uiResultText, string.format("<color=%s>%s</color>", var_3_3, var_3_2.describe .. "   " .. var_3_4))
	end

	local var_3_5 = self.uiResultBg.color

	var_3_5.a = var_3_1 and 0.3 or 0.1
	self.uiResultBg.color = var_3_5

	return
end

function AuctionGameMainRightInfoItem:willExit()
	self:detach()
	Object.Destroy(self._go)

	return
end

return AuctionGameMainRightInfoItem
