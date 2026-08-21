local var_0_0 = class("IslandShipDressDescBox", import("view.base.BaseSubView"))

var_0_0.TYPE = {
	SKIN = 2,
	DRESS = 1
}
var_0_0.DRESS_TGA_TWINS = 1
var_0_0.DRESS_TAG_SP_ANIMATOR = 2
var_0_0.TAG2NAME = {
	[var_0_0.DRESS_TGA_TWINS] = i18n("island_dress_tag_twins"),
	[var_0_0.DRESS_TAG_SP_ANIMATOR] = i18n("island_dress_tag_sp_animator")
}

function var_0_0.getUIName(arg_1_0)
	return "IslandShipDressDescUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.tagUIList = UIItemList.New(arg_2_0.uiTagsTF, arg_2_0.uiTagsTF:Find("tpl"))

	return
end

function var_0_0.OnInit(arg_3_0)
	arg_3_0.tagUIList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			setScrollText(arg_4_2:Find("mask/Text"), var_0_0.TAG2NAME[arg_3_0.tagList[arg_4_1 + 1]])
		end

		return
	end)

	return
end

function var_0_0.Show(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	setAnchoredPosition(arg_5_0.uiPanelTF, arg_5_3)

	arg_5_0.type = arg_5_1
	arg_5_0.id = arg_5_2

	if arg_5_0.type == var_0_0.TYPE.DRESS then
		arg_5_0.cfg = pg.island_dress_template[arg_5_2] or pg.island_skin_template[arg_5_2]

		setText(arg_5_0.uiNameText, arg_5_0.cfg.name)
		setText(arg_5_0.uiDescText, arg_5_0.cfg.desc)

		arg_5_0.tagList = {}

		if arg_5_0.cfg.tag and type(arg_5_0.cfg.tag) == "table" then
			for iter_5_0, iter_5_1 in ipairs(arg_5_0.cfg.tag) do
				table.insert(arg_5_0.tagList, iter_5_1)
			end
		end

		setActive(arg_5_0.uiTagsTF, #arg_5_0.tagList > 0)
		arg_5_0.tagUIList:align(#arg_5_0.tagList)
		arg_5_0.super.Show(arg_5_0)

		return
	end
end

return var_0_0
