local var_0_0 = class("EscapeManorCollectPage", import("view.activity.CorePage.DOA.DOACoreActivityCollectPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.btnList = arg_1_0.bg:Find("btn_list")
	arg_1_0.itemPanel = arg_1_0.bg:Find("item_panel")
	arg_1_0.togglesTF = arg_1_0.itemPanel:Find("toggles")
	arg_1_0.content = arg_1_0.itemPanel:Find("item_list/content")
	arg_1_0.itemList = UIItemList.New(arg_1_0.content, arg_1_0.content:Find("tpl"))
	arg_1_0.msgBox = EscapeManorCollectMsgBox.New(arg_1_0._tf, arg_1_0.event)

	return
end

function var_0_0.AddSpecialBtnListener(arg_2_0)
	local var_2_0 = arg_2_0.activity:getConfig("config_client")

	arg_2_0.furnitureThemeBtn = arg_2_0.btnList:Find("furniture_theme")

	if arg_2_0.furnitureThemeBtn and var_2_0.furniture_theme_link then
		onButton(arg_2_0, arg_2_0.furnitureThemeBtn, function()
			arg_2_0:DoSkip(var_2_0.furniture_theme_link[1], var_2_0.furniture_theme_link[2])

			return
		end, SFX_PANEL)
	end

	arg_2_0.equipSkinBoxBtn = arg_2_0.btnList:Find("equip_skin_box")

	if arg_2_0.equipSkinBoxBtn and var_2_0.equipskin_box_link then
		local var_2_1 = Drop.New({
			type = var_2_0.equipskin_box_link.drop_type,
			id = var_2_0.equipskin_box_link.drop_id
		}):getOwnedCount()

		onButton(arg_2_0, arg_2_0.equipSkinBoxBtn, function()
			arg_2_0.msgBox:ExecuteAction("Show", {
				drop_type = var_2_0.equipskin_box_link.drop_type,
				drop_id = var_2_0.equipskin_box_link.drop_id,
				count = var_2_1,
				skipable_list = var_2_0.equipskin_box_link.list
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.UpdatePage(arg_5_0, arg_5_1)
	arg_5_0.curPage = arg_5_1
	arg_5_0.showDataList = Clone(arg_5_0.dataList)

	table.sort(arg_5_0.showDataList, CompareFuncs({
		function(arg_6_0)
			return arg_6_0.count < arg_6_0.config.count and 0 or 1
		end,
		function(arg_7_0)
			return arg_7_0.config.order
		end,
		function(arg_8_0)
			return arg_8_0.id
		end
	}))
	arg_5_0.itemList:align(#arg_5_0.showDataList)

	return
end

function var_0_0.OnUpdateItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.showDataList[arg_9_1 + 1]
	local var_9_1 = arg_9_2:Find("icon_mask/icon")
	local var_9_2 = {
		type = arg_9_0.showDataList[arg_9_1 + 1].config.type,
		id = arg_9_0.showDataList[arg_9_1 + 1].config.drop_id
	}

	updateDrop(var_9_1, {
		type = arg_9_0.showDataList[arg_9_1 + 1].config.type,
		id = arg_9_0.showDataList[arg_9_1 + 1].config.drop_id
	})
	onButton(arg_9_0, var_9_1, function()
		arg_9_0:OnClickItem(var_9_0)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_9_2:Find("name_mask/name"), Drop.New({
		type = var_9_0.config.type,
		id = var_9_0.config.drop_id
	}):getName())
	arg_9_0:RefreshCountText(var_9_0, arg_9_2)

	GetOrAddComponent(arg_9_2:Find("owner"), typeof(CanvasGroup)).alpha = var_9_0.count == var_9_0.config.count and 0.5 or 1

	setActive(arg_9_2:Find("new"), var_9_0.config.is_new == "1")

	if var_9_2.type == 4 then
		setActive(arg_9_2:Find("got"), var_9_0.count >= 1)
	else
		setActive(arg_9_2:Find("got"), var_9_0.count == var_9_0.config.count)
	end

	return
end

return var_0_0
