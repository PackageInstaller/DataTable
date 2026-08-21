local var_0_0 = class("BackYardDecorationPutCard")
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

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	arg_2_0._tf = tf(arg_2_1)
	arg_2_0.nameTxt = findTF(arg_2_0._tf, "name"):GetComponent(typeof(Text))
	arg_2_0.tagTxt = findTF(arg_2_0._tf, "tag"):GetComponent(typeof(Text))
	arg_2_0.icon = findTF(arg_2_0._tf, "icon"):GetComponent(typeof(Image))
	arg_2_0.mark = findTF(arg_2_0._tf, "mark")

	return
end

function var_0_0.MarkOrUnMark(arg_3_0, arg_3_1)
	setActive(arg_3_0.mark, arg_3_0.furniture.id == arg_3_1)

	return
end

function var_0_0.Update(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.furniture = arg_4_1
	arg_4_0.nameTxt.text = arg_4_1:getConfig("name")
	arg_4_0.tagTxt.text = var_0_2(arg_4_1:getConfig("tag"))
	arg_4_0.icon.sprite = LoadSprite("furnitureicon/" .. arg_4_1:getConfig("icon"))

	arg_4_0:MarkOrUnMark(arg_4_2)

	return
end

function var_0_0.Clear(arg_5_0)
	arg_5_0:MarkOrUnMark(false)

	return
end

return var_0_0
