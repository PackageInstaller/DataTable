local var_0_0 = class("NewEducateTarotCard")

var_0_0.TYPE = {
	CURRENT = 1,
	CHOICE = 2,
	REPLACE = 3
}
var_0_0.TYPE2TAG = {
	[var_0_0.TYPE.CURRENT] = i18n("child2_tarot_tag_current"),
	[var_0_0.TYPE.CHOICE] = "",
	[var_0_0.TYPE.REPLACE] = i18n("child2_tarot_tag_replace")
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_1.transform
	arg_1_0.whiteBgTF = arg_1_0._tf:Find("bg_white")
	arg_1_0.blueBgTF = arg_1_0._tf:Find("bg_blue")
	arg_1_0.iconTF = arg_1_0._tf:Find("icon")
	arg_1_0.simpleTF = arg_1_0._tf:Find("simple")
	arg_1_0.tagTF = arg_1_0.simpleTF:Find("tag")
	arg_1_0.tagText = arg_1_0.tagTF:Find("Text"):GetComponent(typeof(Text))
	arg_1_0.simpleNameText = arg_1_0.simpleTF:Find("name/Text"):GetComponent(typeof(Text))
	arg_1_0.simpleDescText = arg_1_0.simpleTF:Find("desc/Text"):GetComponent(typeof(Text))
	arg_1_0.detailTF = arg_1_0._tf:Find("detail")
	arg_1_0.detailNameText = arg_1_0.detailTF:Find("name"):GetComponent(typeof(Text))
	arg_1_0.detailDescText = arg_1_0.detailTF:Find("desc/Text"):GetComponent(typeof(Text))

	return
end

function var_0_0.Update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.type = arg_2_2 or var_0_0.TYPE.CHOICE
	arg_2_0.id = arg_2_1
	arg_2_0.config = pg.child2_benefit_list[arg_2_1]
	arg_2_0.simpleNameText.text = arg_2_0.config.name
	arg_2_0.detailNameText.text = arg_2_0.config.name
	arg_2_0.simpleDescText.text = arg_2_0.config.simple_desc
	arg_2_0.detailDescText.text = arg_2_0.config.desc

	LoadImageSpriteAsync("neweducateicon/" .. arg_2_0.config.item_icon, arg_2_0.iconTF)
	setActive(arg_2_0.blueBgTF, arg_2_0.type == var_0_0.TYPE.CURRENT)
	setActive(arg_2_0.whiteBgTF, arg_2_0.type == var_0_0.TYPE.CHOICE or arg_2_0.type == var_0_0.TYPE.REPLACE)
	setActive(arg_2_0.tagTF, arg_2_0.type ~= var_0_0.TYPE.CHOICE)

	arg_2_0.tagText.text = var_0_0.TYPE2TAG[arg_2_0.type]

	return
end

function var_0_0.UpdateDescMode(arg_3_0, arg_3_1)
	setActive(arg_3_0.simpleTF, not arg_3_1)
	setActive(arg_3_0.detailTF, arg_3_1)

	return
end

function var_0_0.Dispose(arg_4_0)
	return
end

function var_0_0.StaticShow(arg_5_0, arg_5_1)
	setText(arg_5_0:Find("simple/name/Text"), pg.child2_benefit_list[arg_5_1].name)
	setText(arg_5_0:Find("detail/name"), pg.child2_benefit_list[arg_5_1].name)
	setText(arg_5_0:Find("simple/desc/Text"), pg.child2_benefit_list[arg_5_1].simple_desc)
	setText(arg_5_0:Find("detail/desc/Text"), pg.child2_benefit_list[arg_5_1].desc)
	LoadImageSpriteAsync("neweducateicon/" .. pg.child2_benefit_list[arg_5_1].item_icon, arg_5_0:Find("icon"))

	return
end

return var_0_0
