local var_0_0 = class("AEBCSAwardPage", import("view.activity.CorePage.BRS.HeiYanAwardPage"))

function var_0_0.InitData(arg_1_0)
	for iter_1_0, iter_1_1 in ipairs(arg_1_0.table_Top) do
		onToggle(arg_1_0, iter_1_1, function(arg_2_0)
			if arg_2_0 then
				arg_1_0.pageIndex = iter_1_0

				SetActive(arg_1_0.bg_1, iter_1_0 == 1)
				SetActive(arg_1_0.bg_2, iter_1_0 ~= 1)
				arg_1_0:OnAnimation(iter_1_0)
				arg_1_0:DataList(iter_1_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.OnAnimation(arg_3_0, arg_3_1)
	if arg_3_1 ~= 1 then
		arg_3_0.bg_2:GetComponent(typeof(Animation)):Play("AEBCSAwardPage_list_in")
	end

	return
end

function var_0_0.OnUpdateItem(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_2:Find("icon_mask/icon")

	updateDrop(var_4_0, {
		type = arg_4_0.showDataList[arg_4_1 + 1].config.type,
		id = arg_4_0.showDataList[arg_4_1 + 1].config.drop_id
	})
	onButton(arg_4_0, var_4_0, function()
		arg_4_0:selectBoxbg({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
			drop_type = var_0.config.type,
			drop_id = var_0.config.drop_id,
			count = var_0.count,
			count_limit = var_0.config.count,
			skipable_list = var_0.config.link_params
		})
		arg_4_0:updateBoxPanel({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
			drop_type = var_0.config.type,
			drop_id = var_0.config.drop_id,
			count = var_0.count,
			count_limit = var_0.config.count,
			skipable_list = var_0.config.link_params
		})
		arg_4_0:showBoxPanel(true)

		return
	end, SFX_PANEL)
	arg_4_0.super.OnUpdateItem(arg_4_0, arg_4_1, arg_4_2)

	return
end

function var_0_0.UpdateView(arg_6_0)
	for iter_6_0 = 1, #arg_6_0.table_Top do
		setText(arg_6_0.table_Top[iter_6_0]:Find("Label"), arg_6_0:OnGetCount(iter_6_0) .. "/" .. arg_6_0:OnCount(iter_6_0))
		setText(arg_6_0.table_Top[iter_6_0]:Find("type_image/name"), i18n("danmachi_award_" .. iter_6_0))
	end

	local var_6_0 = arg_6_0.pageIndex or 1
	local var_6_1 = arg_6_0.table_Top[var_6_0]

	triggerToggle(var_6_1, true)

	return
end

function var_0_0.selectBoxbg(arg_7_0, arg_7_1)
	if table.getCount(arg_7_1.skipable_list) > 1 then
		setImageSprite(arg_7_0.boxTF:Find("Panel/BG"), LoadSprite("ui/AEBCSAwardPage_atlas", "box_bg1"), true)
	elseif table.getCount(arg_7_1.skipable_list) == 1 then
		setImageSprite(arg_7_0.boxTF:Find("Panel/BG"), LoadSprite("ui/AEBCSAwardPage_atlas", "box_bg2"), true)
	end

	return
end

function var_0_0.RefreshCountText(arg_8_0, arg_8_1, arg_8_2)
	setText(arg_8_2:Find("owner/number"), arg_8_1.count .. "/" .. arg_8_1.config.count)

	return
end

function var_0_0.showBoxPanel(arg_9_0, arg_9_1)
	setActive(arg_9_0.boxTF, arg_9_1)

	if arg_9_1 == true then
		pg.UIMgr.GetInstance():BlurPanel(arg_9_0.boxTF)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0.boxTF, arg_9_0._tf)
	end

	return
end

function var_0_0.OnDestroy(arg_10_0)
	arg_10_0:showBoxPanel(false)

	return
end

return var_0_0
