local var_0_0 = class("DALAwardPage", import("view.activity.CorePage.BRS.HeiYanAwardPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.AD = arg_1_0._tf:Find("AD")
	arg_1_0.furmiturebtn = arg_1_0.AD:Find("btn/furmiturebtn")
	arg_1_0.commemoratebtn = arg_1_0.AD:Find("btn/commemoratebtn")
	arg_1_0.equipmentbtn = arg_1_0.AD:Find("btn/equipmentbtn")

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	arg_2_0:InitData()

	local var_2_0 = arg_2_0.activity:getConfig("config_client")

	onButton(arg_2_0, arg_2_0.furmiturebtn, function()
		arg_2_0:DoSkip(var_2_0.furniture_theme_link[1], var_2_0.furniture_theme_link[2])

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.commemoratebtn, function()
		arg_2_0:DoSkip(var_2_0.medal_link[1], var_2_0.medal_link[2])

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.equipmentbtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL,
			drop_type = var_2_0.equipskin_box_link.drop_type,
			drop_id = var_2_0.equipskin_box_link.drop_id,
			count = Drop.New({
				type = var_2_0.equipskin_box_link.drop_type,
				id = var_2_0.equipskin_box_link.drop_id
			}):getOwnedCount(),
			skipable_list = var_2_0.equipskin_box_link.list
		})

		return
	end, SFX_PANEL)

	return
end

function var_0_0.InitData(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.table_Top) do
		onToggle(arg_6_0, iter_6_1, function(arg_7_0)
			if arg_7_0 then
				arg_6_0.pageIndex = iter_6_0

				SetActive(arg_6_0.bg_1, false)
				SetActive(arg_6_0.bg_2, true)
				arg_6_0:DataList(iter_6_0 + 1)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.DataList(arg_8_0, arg_8_1)
	arg_8_0.showDataList = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.dataList) do
		if arg_8_0.guideConfig[iter_8_1.id].type == 3 and arg_8_1 == 2 then
			table.insert(arg_8_0.showDataList, iter_8_1)
		elseif arg_8_0.guideConfig[iter_8_1.id].type == 21 and arg_8_1 == 3 then
			table.insert(arg_8_0.showDataList, iter_8_1)
		end
	end

	table.sort(arg_8_0.showDataList, CompareFuncs({
		function(arg_9_0)
			return arg_9_0.config.order
		end,
		function(arg_10_0)
			return arg_10_0.id
		end
	}))
	arg_8_0:ShowCharaPage()

	return
end

function var_0_0.OnAnimation(arg_11_0, arg_11_1)
	return
end

function var_0_0.OnUpdateItem(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.showDataList[arg_12_1 + 1]
	local var_12_1 = arg_12_2:Find("icon_mask/icon")

	updateDrop(var_12_1, {
		type = arg_12_0.showDataList[arg_12_1 + 1].config.type,
		id = arg_12_0.showDataList[arg_12_1 + 1].config.drop_id
	})
	onButton(arg_12_0, var_12_1, function()
		arg_12_0:selectBoxbg({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
			drop_type = var_12_0.config.type,
			drop_id = var_12_0.config.drop_id,
			count = var_12_0.count,
			count_limit = var_12_0.config.count,
			skipable_list = var_12_0.config.link_params
		})
		arg_12_0:updateBoxPanel({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
			drop_type = var_12_0.config.type,
			drop_id = var_12_0.config.drop_id,
			count = var_12_0.count,
			count_limit = var_12_0.config.count,
			skipable_list = var_12_0.config.link_params
		})
		arg_12_0:showBoxPanel(true)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_12_2:Find("name_mask/name"), Drop.New({
		type = var_12_0.config.type,
		id = var_12_0.config.drop_id
	}):getName())
	setText(arg_12_2:Find("owner/number"), var_12_0.count .. "/" .. var_12_0.config.count)

	GetOrAddComponent(arg_12_2:Find("owner"), typeof(CanvasGroup)).alpha = var_12_0.count == var_12_0.config.count and 0.5 or 1

	setActive(arg_12_2:Find("got"), var_12_0.count == var_12_0.config.count)

	return
end

function var_0_0.UpdateView(arg_14_0)
	for iter_14_0 = 1, #arg_14_0.table_Top do
		if iter_14_0 == 1 then
			setText(arg_14_0.table_Top[iter_14_0]:Find("type_image/name"), i18n("yumia_award_1"))
			setText(arg_14_0.table_Top[iter_14_0]:Find("on/name"), i18n("yumia_award_1"))
			setText(arg_14_0.table_Top[iter_14_0]:Find("on/name2"), i18n("dal_AwardPage_name_1"))
		elseif iter_14_0 == 2 then
			setText(arg_14_0.table_Top[iter_14_0]:Find("type_image/name"), i18n("yumia_award_4"))
			setText(arg_14_0.table_Top[iter_14_0]:Find("on/name"), i18n("yumia_award_4"))
			setText(arg_14_0.table_Top[iter_14_0]:Find("on/name2"), i18n("dal_AwardPage_name_2"))
		end
	end

	local var_14_0 = arg_14_0.pageIndex or 1
	local var_14_1 = arg_14_0.table_Top[var_14_0]

	triggerToggle(var_14_1, true)

	return
end

function var_0_0.selectBoxbg(arg_15_0, arg_15_1)
	if table.getCount(arg_15_1.skipable_list) > 1 then
		setImageSprite(arg_15_0.boxTF:Find("Panel/BG"), LoadSprite("ui/DALAwardPage_atlas", "box_bg2"), true)
	elseif table.getCount(arg_15_1.skipable_list) == 1 then
		setImageSprite(arg_15_0.boxTF:Find("Panel/BG"), LoadSprite("ui/DALAwardPage_atlas", "box_bg1"), true)
	end

	return
end

function var_0_0.RefreshCountText(arg_16_0, arg_16_1, arg_16_2)
	setText(arg_16_2:Find("owner/number"), arg_16_1.count .. "/" .. arg_16_1.config.count)

	return
end

function var_0_0.showBoxPanel(arg_17_0, arg_17_1)
	setActive(arg_17_0.boxTF, arg_17_1)

	if arg_17_1 == true then
		pg.UIMgr.GetInstance():BlurPanel(arg_17_0.boxTF)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_17_0.boxTF, arg_17_0._tf)
	end

	return
end

function var_0_0.DoSkip(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE then
		local var_18_0 = arg_18_2[2] or {}

		pg.m02:sendNotification(GAME.GO_SCENE, arg_18_2[1], var_18_0)
	elseif arg_18_1 == Msgbox4LinkCollectGuide.SKIP_TYPE_ACTIVITY then
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_18_2
		})
	end

	return
end

function var_0_0.OnDestroy(arg_19_0)
	arg_19_0:showBoxPanel(false)

	return
end

return var_0_0
