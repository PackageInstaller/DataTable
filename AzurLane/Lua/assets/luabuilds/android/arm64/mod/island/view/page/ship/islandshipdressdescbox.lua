class = var_0_10000

local var_0_0 = "IslandShipDressDescBox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.TYPE = {
	SKIN = 2,
	DRESS = 1
}
var_0_1.DRESS_TGA_TWINS = 1
var_0_1.DRESS_TAG_SP_ANIMATOR = 2

local var_0_2 = {}
local var_0_3 = var_0_1.DRESS_TGA_TWINS

i18n = var_3
var_0_2[var_0_3] = var_3("island_dress_tag_twins")

local var_0_4 = var_0_1.DRESS_TAG_SP_ANIMATOR

i18n = var_3
var_0_2[var_0_4] = var_3("island_dress_tag_sp_animator")
var_0_1.TAG2NAME = var_0_2

function var_0_1.getUIName(arg_1_0)
	return "IslandShipDressDescUI"
end

function var_0_1.OnLoaded(arg_2_0)
	UIItemList = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0.uiTagsTF
	local var_2_2 = arg_2_0.uiTagsTF

	arg_2_0.tagUIList = var_2_0(var_2_1, var_4.Find(var_2_2, "tpl"))

	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0.tagUIList

	var_1.make(var_3_0, function(arg_4_0, arg_4_1, arg_4_2)
		UIItemList = var_2_10003

		if arg_4_0 == var_2_10003.EventUpdate then
			local var_4_0 = arg_3_0.tagList[arg_4_1 + 1]

			setScrollText = var_4

			var_4(arg_4_2:Find("mask/Text"), var_0_1.TAG2NAME[var_4_0])
		end

		return
	end)

	return
end

function var_0_1.Show(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	setAnchoredPosition = var_1_10004

	var_1_10004(arg_5_0.uiPanelTF, arg_5_3)

	arg_5_0.type = arg_5_1
	arg_5_0.id = arg_5_2

	if arg_5_0.type == var_0_1.TYPE.DRESS then
		pg = var_5_0

		local var_5_0

		if not var_5_0.island_dress_template[arg_5_2] then
			pg = var_5_0
			var_5_0 = var_5_0.island_skin_template[arg_5_2]
		end

		arg_5_0.cfg = var_5_0
		setText = var_5_0

		var_5_0(arg_5_0.uiNameText, arg_5_0.cfg.name)

		setText = var_5_0

		var_5_0(arg_5_0.uiDescText, arg_5_0.cfg.desc)

		arg_5_0.tagList = {}

		if arg_5_0.cfg.tag then
			type = var_4

			if var_4(arg_5_0.cfg.tag) == "table" then
				ipairs = var_4

				for iter_5_0, iter_5_1 in var_4(arg_5_0.cfg.tag) do
					table = var_1_10009

					var_1_10009.insert(arg_5_0.tagList, iter_5_1)
				end
			end
		end

		setActive = var_4

		var_4(arg_5_0.uiTagsTF, #arg_5_0.tagList > 0)

		local var_5_1 = arg_5_0.tagUIList

		var_4.align(var_5_1, #arg_5_0.tagList)
		arg_5_0.super.Show(arg_5_0)

		return
	end
end

return var_0_1
