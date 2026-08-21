local var_0_0 = class("MallUpgradeBox", import("view.base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "MallUpgradeBox"
end

function var_0_0.OnLoaded(arg_2_0)
	setText(arg_2_0.uiTitleText, i18n("mall_upgrade_title"))
	setText(arg_2_0.uiSureText, i18n("text_confirm"))
	setText(arg_2_0.uiLevelHeaderText, i18n("mall_level_header"))

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.uiSureBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	arg_3_0.unlockUIList = UIItemList.New(arg_3_0.uiContentTF, arg_3_0.uiContentTF:Find("tpl"))

	arg_3_0.unlockUIList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			setText(arg_6_2:Find("header"), i18n("word_unlock"))
			setText(arg_6_2:Find("Text"), arg_3_0.unlockNameList[arg_6_1 + 1])
		end

		return
	end)

	arg_3_0.lv2FloorIds = {}

	for iter_3_0, iter_3_1 in ipairs(pg.activity_mall_template.all) do
		arg_3_0.lv2FloorIds[pg.activity_mall_template[iter_3_1].need_mall_level] = arg_3_0.lv2FloorIds[pg.activity_mall_template[iter_3_1].need_mall_level] or {}

		table.insert(arg_3_0.lv2FloorIds[pg.activity_mall_template[iter_3_1].need_mall_level], iter_3_1)
	end

	return
end

function var_0_0.Show(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	var_0_0.super.Show(arg_7_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)

	arg_7_0.onHide = arg_7_3

	setText(arg_7_0.uiOldLevelText, arg_7_1)
	setText(arg_7_0.uiNewLevelText, arg_7_2)

	arg_7_0.unlockNameList = {}

	for iter_7_0 = arg_7_1 + 1, arg_7_2 do
		if arg_7_0.lv2FloorIds[iter_7_0] then
			for iter_7_1, iter_7_2 in ipairs(arg_7_0.lv2FloorIds[iter_7_0]) do
				table.insert(arg_7_0.unlockNameList, pg.activity_mall_template[iter_7_2].name)
			end
		end
	end

	arg_7_0.unlockUIList:align(#arg_7_0.unlockNameList)

	return
end

function var_0_0.Hide(arg_8_0)
	var_0_0.super.Hide(arg_8_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_8_0._tf)
	existCall(arg_8_0.onHide)

	arg_8_0.onHide = nil

	return
end

function var_0_0.OnDestroy(arg_9_0)
	return
end

return var_0_0
