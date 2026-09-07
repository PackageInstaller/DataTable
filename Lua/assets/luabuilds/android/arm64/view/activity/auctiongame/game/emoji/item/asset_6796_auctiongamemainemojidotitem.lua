local AuctionGameMainEmojiDotItem = class("AuctionGameMainEmojiDotItem", import("view.base.BasePanel"))

function AuctionGameMainEmojiDotItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainEmojiDotItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainEmojiDotItem:Init()
	return
end

function AuctionGameMainEmojiDotItem:didEnter(arg_3_1)
	setActive(self.uiSelectedGo, arg_3_1)

	return
end

function AuctionGameMainEmojiDotItem:willExit()
	self:detach()
	Object.Destroy(self._go)

	return
end

return AuctionGameMainEmojiDotItem
