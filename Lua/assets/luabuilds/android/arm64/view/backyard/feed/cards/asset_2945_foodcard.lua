local FoodCard = class("FoodCard")

function FoodCard:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = tf(arg_1_1)
	self.mask = self._tf:Find("mask")
	self.count = self._tf:Find("icon_bg/count"):GetComponent(typeof(Text))
	self.nameTxt = self._tf:Find("Text"):GetComponent(typeof(Text))
	self.addTF = self._tf:Find("add")
	self.icon = self._tf:Find("icon_bg/icon")
	self.startPos = self._tf.anchoredPosition
	self.width = self._tf.sizeDelta.x
	self.space = 36

	return
end

function FoodCard:UpdatePositin(arg_2_1)
	self._tf.anchoredPosition3D = Vector3(self.startPos.x + arg_2_1 * (self.width + self.space), self.startPos.y, 0)

	return
end

function FoodCard:Update(arg_3_1, arg_3_2)
	self.foodId = arg_3_1
	self.name = i18n("word_food") .. Item.getConfigData(arg_3_1).usage_arg[1]

	self:UpdateCnt(arg_3_2)

	self._go.name = "food_" .. arg_3_1

	updateItem(self._tf, Item.New({
		id = arg_3_1,
		cnt = arg_3_2
	}))

	return
end

function FoodCard:UpdateCnt(arg_4_1)
	self.count.text = arg_4_1

	setActive(self.mask, arg_4_1 == 0)

	self.count.text = arg_4_1
	self.nameTxt.text = self.name

	return
end

function FoodCard:Dispose()
	return
end

return FoodCard
