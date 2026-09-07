local WSInventoryItem = class("WSInventoryItem")

function WSInventoryItem:Ctor(arg_1_1)
	self.go = arg_1_1
	self.bg = findTF(arg_1_1, "bg")
	self.countTF = findTF(arg_1_1, "bg/icon_bg/count")
	self.nameTF = findTF(arg_1_1, "bg/name")

	return
end

function WSInventoryItem:update(arg_2_1)
	self.itemVO = arg_2_1

	updateWorldItem(rtf(self.bg), arg_2_1)

	self.go.name = tostring(arg_2_1.id)

	setText(self.countTF, (arg_2_1.count > 0 or nil) and (arg_2_1.count or ""))
	setText(self.nameTF, shortenString(getText(findTF(self.bg, "name")), 7))

	return
end

function WSInventoryItem:clear()
	return
end

function WSInventoryItem:dispose()
	return
end

return WSInventoryItem
