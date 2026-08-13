class = var_0_10000

local var_0_0 = "MallUpgradeBox"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "MallUpgradeBox"
end

function var_0_1.OnLoaded(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiTitleText

	i18n = var_1_10004

	var_1_10001(var_2_0, var_1_10004("mall_upgrade_title"))

	setText = var_1_10001

	local var_2_1 = arg_2_0.uiSureText

	i18n = var_4

	var_1_10001(var_2_1, var_4("text_confirm"))

	setText = var_1_10001

	local var_2_2 = arg_2_0.uiLevelHeaderText

	i18n = var_4

	var_1_10001(var_2_2, var_4("mall_level_header"))

	return
end

function var_0_1.OnInit(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)

	onButton = var_1_10001

	local var_3_3 = arg_3_0
	local var_3_4 = arg_3_0.uiSureBtn

	local function var_3_5()
		local var_5_0 = arg_3_0

		var_0.Hide(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_3_3, var_3_4, var_3_5, var_1_10006)

	UIItemList = var_1_10001

	local var_3_6 = var_1_10001.New
	local var_3_7 = arg_3_0.uiContentTF
	local var_3_8 = arg_3_0.uiContentTF

	arg_3_0.unlockUIList = var_3_6(var_3_7, var_4.Find(var_3_8, "tpl"))

	local var_3_9 = arg_3_0.unlockUIList

	var_1.make(var_3_9, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 == var_2_10003.EventUpdate then
			setText = var_3

			local var_6_0 = arg_6_2:Find("header")

			i18n = var_2_10006

			var_3(var_6_0, var_2_10006("word_unlock"))

			setText = var_3

			var_3(arg_6_2:Find("Text"), arg_3_0.unlockNameList[arg_6_1 + 1])
		end

		return
	end)

	arg_3_0.lv2FloorIds = {}
	ipairs = var_1
	pg = var_3_9

	for iter_3_0, iter_3_1 in var_1(var_3_9.activity_mall_template.all) do
		pg = var_3_8
		var_3_8 = var_3_8.activity_mall_template[iter_3_1].need_mall_level

		local var_3_10

		if not arg_3_0.lv2FloorIds[var_3_8] then
			var_3_10 = arg_3_0.lv2FloorIds
			var_3_10[var_3_8] = {}
		end

		table = var_3_10

		var_3_10.insert(arg_3_0.lv2FloorIds[var_3_8], iter_3_1)
	end

	return
end

function var_0_1.Show(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_1.super.Show(arg_7_0)

	pg = var_4

	local var_7_0 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_7_0, arg_7_0._tf)

	arg_7_0.onHide = arg_7_3
	setText = var_4

	var_4(arg_7_0.uiOldLevelText, arg_7_1)

	setText = var_4

	var_4(arg_7_0.uiNewLevelText, arg_7_2)

	arg_7_0.unlockNameList = {}

	for iter_7_0 = arg_7_1 + 1, arg_7_2 do
		if arg_7_0.lv2FloorIds[iter_7_0] then
			ipairs = var_8

			for iter_7_1, iter_7_2 in var_8(arg_7_0.lv2FloorIds[iter_7_0]) do
				pg = var_1_10013
				var_1_10013 = var_1_10013.activity_mall_template[iter_7_2].name
				table = var_1_10014

				var_1_10014.insert(arg_7_0.unlockNameList, var_1_10013)
			end
		end
	end

	local var_7_1 = arg_7_0.unlockUIList

	var_4.align(var_7_1, #arg_7_0.unlockNameList)

	return
end

function var_0_1.Hide(arg_8_0)
	var_0_1.super.Hide(arg_8_0)

	pg = var_1

	local var_8_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_8_0, arg_8_0._tf)

	existCall = var_1

	var_1(arg_8_0.onHide)

	arg_8_0.onHide = nil

	return
end

function var_0_1.OnDestroy(arg_9_0)
	return
end

return var_0_1
