class = var_0_10000

local var_0_0 = var_0_10000("NewEducateTarotCard")

var_0_0.TYPE = {
	CURRENT = 1,
	CHOICE = 2,
	REPLACE = 3
}

local var_0_1 = {}
local var_0_2 = var_0_0.TYPE.CURRENT

i18n = var_0_10003
var_0_1[var_0_2] = var_0_10003("child2_tarot_tag_current")
var_0_1[var_0_0.TYPE.CHOICE] = ""

local var_0_3 = var_0_0.TYPE.REPLACE

i18n = var_3
var_0_1[var_0_3] = var_3("child2_tarot_tag_replace")
var_0_0.TYPE2TAG = var_0_1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform

	local var_1_0 = arg_1_0._tf

	arg_1_0.whiteBgTF = var_2.Find(var_1_0, "bg_white")

	local var_1_1 = arg_1_0._tf

	arg_1_0.blueBgTF = var_2.Find(var_1_1, "bg_blue")

	local var_1_2 = arg_1_0._tf

	arg_1_0.iconTF = var_2.Find(var_1_2, "icon")

	local var_1_3 = arg_1_0._tf

	arg_1_0.simpleTF = var_2.Find(var_1_3, "simple")

	local var_1_4 = arg_1_0.simpleTF

	arg_1_0.tagTF = var_2.Find(var_1_4, "tag")

	local var_1_5 = arg_1_0.tagTF
	local var_1_6 = var_2.Find(var_1_5, "Text")
	local var_1_7 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.tagText = var_1_7(var_1_6, var_5(var_1_10007))

	local var_1_8 = arg_1_0.simpleTF
	local var_1_9 = var_2.Find(var_1_8, "name/Text")
	local var_1_10 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.simpleNameText = var_1_10(var_1_9, var_5(var_1_10007))

	local var_1_11 = arg_1_0.simpleTF
	local var_1_12 = var_2.Find(var_1_11, "desc/Text")
	local var_1_13 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.simpleDescText = var_1_13(var_1_12, var_5(var_1_10007))

	local var_1_14 = arg_1_0._tf

	arg_1_0.detailTF = var_2.Find(var_1_14, "detail")

	local var_1_15 = arg_1_0.detailTF
	local var_1_16 = var_2.Find(var_1_15, "name")
	local var_1_17 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.detailNameText = var_1_17(var_1_16, var_5(var_1_10007))

	local var_1_18 = arg_1_0.detailTF
	local var_1_19 = var_2.Find(var_1_18, "desc/Text")
	local var_1_20 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.detailDescText = var_1_20(var_1_19, var_5(var_1_10007))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.type = arg_2_2 or var_0_0.TYPE.CHOICE
	arg_2_0.id = arg_2_1
	pg = var_3
	arg_2_0.config = var_3.child2_benefit_list[arg_2_1]
	arg_2_0.simpleNameText.text = arg_2_0.config.name
	arg_2_0.detailNameText.text = arg_2_0.config.name
	arg_2_0.simpleDescText.text = arg_2_0.config.simple_desc

	local var_2_0 = arg_2_0.detailDescText

	var_2_0.text = arg_2_0.config.desc
	LoadImageSpriteAsync = var_2_0

	var_2_0("neweducateicon/" .. arg_2_0.config.item_icon, arg_2_0.iconTF)

	setActive = var_2_0

	var_2_0(arg_2_0.blueBgTF, arg_2_0.type == var_0_0.TYPE.CURRENT)

	setActive = var_2_0

	var_2_0(arg_2_0.whiteBgTF, arg_2_0.type == var_0_0.TYPE.CHOICE or arg_2_0.type == var_0_0.TYPE.REPLACE)

	setActive = var_2_0

	var_2_0(arg_2_0.tagTF, arg_2_0.type ~= var_0_0.TYPE.CHOICE)

	arg_2_0.tagText.text = var_0_0.TYPE2TAG[arg_2_0.type]

	return
end

function var_0_0.UpdateDescMode(arg_3_0, arg_3_1)
	setActive = var_1_10002

	var_1_10002(arg_3_0.simpleTF, not arg_3_1)

	setActive = var_1_10002

	var_1_10002(arg_3_0.detailTF, arg_3_1)

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

function var_0_0.StaticShow(arg_5_0, arg_5_1)
	pg = var_1_10002

	local var_5_0 = var_1_10002.child2_benefit_list[arg_5_1]

	setText = var_1_10003

	var_1_10003(arg_5_0:Find("simple/name/Text"), var_5_0.name)

	setText = var_1_10003

	var_1_10003(arg_5_0:Find("detail/name"), var_5_0.name)

	setText = var_1_10003

	var_1_10003(arg_5_0:Find("simple/desc/Text"), var_5_0.simple_desc)

	setText = var_1_10003

	var_1_10003(arg_5_0:Find("detail/desc/Text"), var_5_0.desc)

	LoadImageSpriteAsync = var_1_10003

	var_1_10003("neweducateicon/" .. var_5_0.item_icon, arg_5_0:Find("icon"))

	return
end

return var_0_0
