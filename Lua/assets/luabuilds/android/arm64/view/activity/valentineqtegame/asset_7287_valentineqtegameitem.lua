local ValentineQteGameItem = class("ValentineQteGameItem")
local var_0_1 = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6"
}

function ValentineQteGameItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1
	self._tf = arg_1_1.transform
	self.rect = self._tf.rect
	self.image = self._go:GetComponent(typeof(Image))

	self:SetTime(arg_1_3)
	self:SetPosition(arg_1_2)

	self.bound = getBounds(self._tf)
	self.image.sprite = GetSpriteFromAtlas("ui/minigameui/valentineqtegame_atlas", var_0_1[math.random(1, #var_0_1)])

	self.image:SetNativeSize()

	return
end

function ValentineQteGameItem:SetTime(arg_2_1)
	self.genTime = arg_2_1

	return
end

function ValentineQteGameItem:SetPosition(arg_3_1)
	self.genPos = arg_3_1
	self._tf.localPosition = arg_3_1

	return
end

function ValentineQteGameItem:ShouldDisapper(arg_4_1)
	if self.genTime - arg_4_1 >= ValentineQteGameConst.ITEM_DISAPPEAR_TIME then
		return true
	end

	return false
end

function ValentineQteGameItem:IsOverlap(arg_5_1)
	return self.bound:Intersects((getBounds(arg_5_1)))
end

function ValentineQteGameItem:IsSufficientLength(arg_6_1, arg_6_2)
	return arg_6_2 < math.abs(self._tf.localPosition.x - arg_6_1)
end

function ValentineQteGameItem:Destroy()
	self.image.sprite = nil

	return
end

return ValentineQteGameItem
