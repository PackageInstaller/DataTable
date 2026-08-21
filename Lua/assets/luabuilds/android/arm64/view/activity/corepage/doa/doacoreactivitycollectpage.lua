local var_0_0 = class("DOACoreActivityCollectPage", import("view.activity.CorePage.templatePage.CoreAwardTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.btnList = arg_1_0.bg:Find("btn_list")
	arg_1_0.itemPanel = arg_1_0.bg:Find("item_panel")
	arg_1_0.togglesTF = arg_1_0.itemPanel:Find("toggles")
	arg_1_0.content = arg_1_0.itemPanel:Find("item_list/content")
	arg_1_0.itemList = UIItemList.New(arg_1_0.content, arg_1_0.content:Find("tpl"))
	arg_1_0.msgBox = DOACoreActivityMsgBox.New(arg_1_0._tf, arg_1_0.event)

	return
end

function var_0_0.GetTogglesDropTypes(arg_2_0)
	return {
		DROP_TYPE_EQUIP,
		DROP_TYPE_SPWEAPON
	}
end

function var_0_0.OnClickItem(arg_3_0, arg_3_1)
	arg_3_0.msgBox:ExecuteAction("Show", {
		drop_type = arg_3_1.config.type,
		drop_id = arg_3_1.config.drop_id,
		count = arg_3_1.count,
		count_limit = arg_3_1.config.count,
		skipable_list = arg_3_1.config.link_params
	})

	return
end

function var_0_0.AddSpecialBtnListener(arg_4_0)
	local var_4_0 = arg_4_0.activity:getConfig("config_client")

	arg_4_0.furnitureThemeBtn = arg_4_0.btnList:Find("furniture_theme")

	if arg_4_0.furnitureThemeBtn and var_4_0.furniture_theme_link then
		onButton(arg_4_0, arg_4_0.furnitureThemeBtn, function()
			arg_4_0:DoSkip(var_4_0.furniture_theme_link[1], var_4_0.furniture_theme_link[2])

			return
		end, SFX_PANEL)
	end

	arg_4_0.medalBtn = arg_4_0.btnList:Find("medal")

	if arg_4_0.medalBtn and var_4_0.medal_link then
		onButton(arg_4_0, arg_4_0.medalBtn, function()
			arg_4_0:DoSkip(var_4_0.medal_link[1], var_4_0.medal_link[2])

			return
		end, SFX_PANEL)
	end

	arg_4_0.equipSkinBoxBtn = arg_4_0.btnList:Find("equip_skin_box")

	if arg_4_0.equipSkinBoxBtn and var_4_0.equipskin_box_link then
		local var_4_1 = Drop.New({
			type = var_4_0.equipskin_box_link.drop_type,
			id = var_4_0.equipskin_box_link.drop_id
		}):getOwnedCount()

		onButton(arg_4_0, arg_4_0.equipSkinBoxBtn, function()
			arg_4_0.msgBox:ExecuteAction("Show", {
				drop_type = var_4_0.equipskin_box_link.drop_type,
				drop_id = var_4_0.equipskin_box_link.drop_id,
				count = var_4_1,
				skipable_list = var_4_0.equipskin_box_link.list
			})

			return
		end, SFX_PANEL)
	end

	return
end

function var_0_0.OnHideFlush(arg_8_0)
	if arg_8_0.msgBox:isShowing() then
		arg_8_0.msgBox:Hide()
	end

	return
end

function var_0_0.OnDestroy(arg_9_0)
	if arg_9_0.msgBox then
		arg_9_0.msgBox:Hide()
		arg_9_0.msgBox:Destroy()

		arg_9_0.msgBox = nil
	end

	return
end

return var_0_0
