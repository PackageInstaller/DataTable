local BackYardDecorationPutCard = class("BackYardDecorationPutCard")
local var_0_1 = {
	"word_furniture",
	"word_decorate",
	"word_wallpaper",
	"word_floorpaper",
	"word_wall",
	"word_collection",
	"word_shipskin"
}

local function var_0_2(arg_1_0)
	return i18n(var_0_1[arg_1_0])
end

function BackYardDecorationPutCard:Ctor(arg_2_1)
	self._go = arg_2_1
	self._tf = tf(arg_2_1)
	self.nameTxt = findTF(self._tf, "name"):GetComponent(typeof(Text))
	self.tagTxt = findTF(self._tf, "tag"):GetComponent(typeof(Text))
	self.icon = findTF(self._tf, "icon"):GetComponent(typeof(Image))
	self.mark = findTF(self._tf, "mark")

	return
end

function BackYardDecorationPutCard:MarkOrUnMark(arg_3_1)
	setActive(self.mark, self.furniture.id == arg_3_1)

	return
end

function BackYardDecorationPutCard:Update(arg_4_1, arg_4_2)
	self.furniture = arg_4_1
	self.nameTxt.text = arg_4_1:getConfig("name")
	self.tagTxt.text = var_0_2(arg_4_1:getConfig("tag"))
	self.icon.sprite = LoadSprite("furnitureicon/" .. arg_4_1:getConfig("icon"))

	self:MarkOrUnMark(arg_4_2)

	return
end

function BackYardDecorationPutCard:Clear()
	self:MarkOrUnMark(false)

	return
end

return BackYardDecorationPutCard
