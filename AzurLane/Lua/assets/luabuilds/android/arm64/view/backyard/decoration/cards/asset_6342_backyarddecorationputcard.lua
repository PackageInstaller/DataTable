class = var_0_10000

local var_0_0 = var_0_10000("BackYardDecorationPutCard")
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
	i18n = var_1_10001

	return var_1_10001(var_0_1[arg_1_0])
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0._go = arg_2_1
	tf = var_1_10002
	arg_2_0._tf = var_1_10002(arg_2_1)
	findTF = var_2

	local var_2_0 = var_2(arg_2_0._tf, "name")
	local var_2_1 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.nameTxt = var_2_1(var_2_0, var_5(var_1_10007))
	findTF = var_2

	local var_2_2 = var_2(arg_2_0._tf, "tag")
	local var_2_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_2_0.tagTxt = var_2_3(var_2_2, var_5(var_1_10007))
	findTF = var_2

	local var_2_4 = var_2(arg_2_0._tf, "icon")
	local var_2_5 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_2_0.icon = var_2_5(var_2_4, var_5(var_1_10007))
	findTF = var_2
	arg_2_0.mark = var_2(arg_2_0._tf, "mark")

	return
end

function var_0_0.MarkOrUnMark(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.mark, arg_3_0.furniture.id == arg_3_1)

	return
end

function var_0_0.Update(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.furniture = arg_4_1
	arg_4_0.nameTxt.text = arg_4_1:getConfig("name")
	arg_4_0.tagTxt.text = var_0_2(arg_4_1:getConfig("tag"))

	local var_4_0 = arg_4_0.icon

	LoadSprite = var_4
	var_4_0.sprite = var_4("furnitureicon/" .. arg_4_1:getConfig("icon"))

	arg_4_0:MarkOrUnMark(arg_4_2)

	return
end

function var_0_0.Clear(arg_5_0)
	arg_5_0:MarkOrUnMark(false)

	return
end

return var_0_0
