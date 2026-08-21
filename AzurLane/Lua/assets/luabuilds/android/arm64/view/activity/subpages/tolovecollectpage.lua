local var_0_0 = class("ToloveCollectPage", import(".TemplatePage.LinkCollectTemplatePage"))

var_0_0.SKIP_TYPE_MINIGAME = 7

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)
	arg_1_0:findUI()

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	var_0_0.super.OnFirstFlush(arg_2_0)
	arg_2_0:rewriteEquipSkinBtn()

	return
end

function var_0_0.findUI(arg_3_0)
	setImageRaycastTarget(arg_3_0.content:Find("tpl/Frame"), false)

	arg_3_0.boxTF = arg_3_0._tf:Find("Box")
	arg_3_0.boxBG = arg_3_0.boxTF:Find("BG")
	arg_3_0.panel = arg_3_0.boxTF:Find("Panel")
	arg_3_0.infoTF = arg_3_0.panel:Find("Info")
	arg_3_0.boxCloseBtn = arg_3_0.infoTF:Find("CloseBtn")
	arg_3_0.boxIconTF = arg_3_0.infoTF:Find("Icon/Mask/IconTpl")
	arg_3_0.boxNameText = arg_3_0.infoTF:Find("NameText")
	arg_3_0.boxNumTF = arg_3_0.infoTF:Find("Num")
	arg_3_0.boxNumTip = arg_3_0.boxNumTF:Find("Text")
	arg_3_0.boxNumText = arg_3_0.boxNumTF:Find("NumText")
	arg_3_0.boxDescText = arg_3_0.infoTF:Find("DescText")
	arg_3_0.boxSrcText = arg_3_0.infoTF:Find("SrcText")

	onButton(arg_3_0, arg_3_0.boxBG, function()
		arg_3_0:showBoxPanel(false)

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.boxCloseBtn, function()
		arg_3_0:showBoxPanel(false)

		return
	end, SFX_PANEL)

	arg_3_0.boxSrcContent = arg_3_0.panel:Find("Content")
	arg_3_0.boxSrcTpl = arg_3_0.boxSrcContent:Find("SrcTpl")

	GetComponent(arg_3_0.btnList:Find("furniture_theme/Title"), "Image"):SetNativeSize()
	GetComponent(arg_3_0.btnList:Find("equip_skin_box/Title"), "Image"):SetNativeSize()
	GetComponent(arg_3_0.btnList:Find("medal/Title"), "Image"):SetNativeSize()

	return
end

function var_0_0.rewriteEquipSkinBtn(arg_6_0)
	onButton(arg_6_0, arg_6_0.equipSkinBoxBtn, function()
		local var_7_0 = arg_6_0.activity:getConfig("config_client")

		arg_6_0:updateBoxPanel({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL,
			drop_type = var_7_0.equipskin_box_link.drop_type,
			drop_id = var_7_0.equipskin_box_link.drop_id,
			count = Drop.New({
				type = var_7_0.equipskin_box_link.drop_type,
				id = var_7_0.equipskin_box_link.drop_id
			}):getOwnedCount(),
			skipable_list = var_7_0.equipskin_box_link.list
		})
		arg_6_0:showBoxPanel(true)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.updateBoxPanel(arg_8_0, arg_8_1)
	local var_8_0 = Drop.New({
		type = arg_8_1.drop_type,
		id = arg_8_1.drop_id
	})

	updateDrop(arg_8_0.boxIconTF, var_8_0)
	changeToScrollText(arg_8_0.boxNameText, var_8_0.cfg.name)
	setText(arg_8_0.boxDescText, SwitchSpecialChar(var_8_0.desc))
	setText(arg_8_0.boxNumTip, i18n("word_own1"))

	if arg_8_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL then
		setText(arg_8_0.boxNumText, arg_8_1.count)
	elseif arg_8_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT then
		local var_8_1 = arg_8_1.count_limit or 0

		setText(arg_8_0.boxNumText, arg_8_1.count .. "/" .. var_8_1)
	end

	UIItemList.StaticAlign(arg_8_0.boxSrcContent, arg_8_0.boxSrcTpl, #arg_8_1.skipable_list, function(arg_9_0, arg_9_1, arg_9_2)
		if arg_9_0 == UIItemList.EventUpdate then
			local var_9_0 = arg_8_1.skipable_list[arg_9_1 + 1][1]
			local var_9_1 = arg_8_1.skipable_list[arg_9_1 + 1][2]

			changeToScrollText(arg_9_2:Find("SrcText"), arg_8_1.skipable_list[arg_9_1 + 1][3])
			onButton(arg_8_0, arg_9_2:Find("GoBtn"), function()
				if var_9_0 == Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE then
					local var_10_0 = var_9_1[2] or {}

					pg.m02:sendNotification(GAME.GO_SCENE, var_9_1[1], var_10_0)
				elseif var_9_0 == Msgbox4LinkCollectGuide.SKIP_TYPE_ACTIVITY then
					pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
						id = var_9_1
					})
				elseif var_9_0 == var_0_0.SKIP_TYPE_MINIGAME then
					pg.m02:sendNotification(GAME.GO_MINI_GAME, var_9_1[1])
				end

				arg_8_0:showBoxPanel(false)

				return
			end, SFX_PANEL)
			Canvas.ForceUpdateCanvases()
		end

		return
	end)

	return
end

function var_0_0.showBoxPanel(arg_11_0, arg_11_1)
	setActive(arg_11_0.boxTF, arg_11_1)

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
	setActive(arg_12_2:Find("new"), var_12_0.config.is_new == "1")

	return
end

return var_0_0
