local AuctionGameCellItem = class("AuctionGameCellItem", import("view.base.BasePanel"))

function AuctionGameCellItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameCellItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameCellItem:Init()
	return
end

function AuctionGameCellItem:didEnter()
	return
end

function AuctionGameCellItem:Show(arg_4_1)
	setActive(self._go, arg_4_1)

	return
end

function AuctionGameCellItem:GetPosition()
	return self.uiItemTf.anchoredPosition
end

function AuctionGameCellItem:willExit()
	self:detach()
	Object.Destroy(self._go)

	return
end

return AuctionGameCellItem
