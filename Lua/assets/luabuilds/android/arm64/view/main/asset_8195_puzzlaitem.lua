local PuzzlaItem = class("PuzzlaItem")

function PuzzlaItem:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self.img = arg_1_1:GetComponent(typeof(Image))
	self.btn = arg_1_1:AddComponent(typeof(Button))
	self._go = arg_1_1
	self._tr = rtf(self._go)
	self._tr.pivot = Vector2(0, 1)
	self.width = 0
	self.height = 0
	self.position = nil
	self.index = arg_1_2
	self.isWhite = false
	self.currIndex = nil
	self.isOpen = arg_1_3
	self.desc = arg_1_4
	self.mask = GameObject("mask")
	self.maskImg = self.mask:AddComponent(typeof(Image))

	setParent(self.mask, self._go)

	tf(self.mask).pivot = Vector2(0, 1)
	self.maskImg.color = Color.New(0, 0, 0, 0.85)
	self.textTF = GameObject("Text")
	self.textTFText = self.textTF:AddComponent(typeof(Text))

	setParent(self.textTF, self.mask)

	tf(self.textTF).pivot = Vector2(0, 1)
	self.textTFText.font = LoadAny("font/zhunyuan", "", nil)
	self.textTFText.fontSize = 18
	self.textTFText.alignment = TextAnchor.MiddleCenter

	return
end

function PuzzlaItem:activeMask(arg_2_1)
	setActive(self.mask, arg_2_1)

	return
end

function PuzzlaItem:activeDesc(arg_3_1)
	setActive(self.textTF, arg_3_1)

	return
end

function PuzzlaItem:setDesc(arg_4_1)
	self.textTFText.text = arg_4_1

	return
end

function PuzzlaItem:setCurrIndex(arg_5_1)
	self.currIndex = arg_5_1

	return
end

function PuzzlaItem:isBlock()
	return self.isWhite
end

function PuzzlaItem:isRestoration()
	return self.currIndex == self.index and self.isOpen
end

function PuzzlaItem:update(arg_8_1, arg_8_2, arg_8_3)
	self:setSprite(arg_8_1)
	self:setPosition(arg_8_2, self.index)

	if arg_8_3 then
		self:setBlock()

		self.isWhite = true
		self.isOpen = true
	end

	self:activeMask(not self.isOpen)
	self:activeDesc(self.desc)

	if self.desc then
		self:setDesc(self.desc)
	end

	return
end

function PuzzlaItem:setHightLight()
	self.img.color = Color.New(1, 1, 1, 1)

	return
end

function PuzzlaItem:setBlock()
	self.img.color = Color.New(1, 1, 1, 0)

	return
end

function PuzzlaItem:setSprite(arg_11_1)
	self.img.sprite = arg_11_1

	self.img:SetNativeSize()

	self.width = arg_11_1.rect.width
	self.height = arg_11_1.rect.height
	tf(self.mask).sizeDelta = Vector2(self.width, self.height)
	tf(self.mask).localPosition = Vector2(0, 0)
	tf(self.textTF).sizeDelta = Vector2(self.width, self.height)
	tf(self.textTF).localPosition = Vector2(0, 0)

	return
end

function PuzzlaItem:setPosition(arg_12_1, arg_12_2)
	self.position = arg_12_1
	self.currIndex = arg_12_2

	return
end

function PuzzlaItem:getPosition()
	return self.position
end

function PuzzlaItem:getCurrIndex()
	return self.currIndex
end

function PuzzlaItem:setLocalPosition(arg_15_1)
	self._tr.localPosition = arg_15_1

	return
end

function PuzzlaItem:getLocalPosition()
	return self._tr.localPosition
end

function PuzzlaItem:getSurroundPosition()
	local var_17_0 = {}

	table.insert(var_17_0, Vector2(self.position.x, self.position.y + 1))
	table.insert(var_17_0, Vector2(self.position.x, self.position.y - 1))
	table.insert(var_17_0, Vector2(self.position.x - 1, self.position.y))
	table.insert(var_17_0, Vector2(self.position.x + 1, self.position.y))

	return var_17_0
end

return PuzzlaItem
