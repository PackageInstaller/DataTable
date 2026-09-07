local AuctionGameMainEmojiListItem = class("AuctionGameMainEmojiListItem", import("view.base.BasePanel"))

function AuctionGameMainEmojiListItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameMainEmojiListItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameMainEmojiListItem:Init()
	self.itemList = {}

	return
end

function AuctionGameMainEmojiListItem:didEnter(arg_3_1)
	for iter_3_0 = 1, #arg_3_1 do
		self.itemList[iter_3_0] = self.itemList[iter_3_0] or AuctionGameMainEmojiItem.New(Instantiate(self.uiEmojiItem, self._tf), self)

		self.itemList[iter_3_0]:didEnter(arg_3_1[iter_3_0])
	end

	for iter_3_1 = #arg_3_1 + 1, #self.itemList do
		self.itemList[iter_3_1]:Show(false)
	end

	return
end

function AuctionGameMainEmojiListItem:willExit()
	for iter_4_0, iter_4_1 in ipairs(self.itemList) do
		iter_4_1:willExit()
	end

	self.itemList = nil

	self:detach()

	return
end

return AuctionGameMainEmojiListItem
