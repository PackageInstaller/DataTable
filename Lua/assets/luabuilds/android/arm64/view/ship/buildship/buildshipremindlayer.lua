local var_0_0 = class("BuildShipRemindLayer", import("...base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "BuildShipRemindUI"
end

function var_0_0.setShips(arg_2_0, arg_2_1)
	arg_2_0.ships = arg_2_1

	return
end

function var_0_0.init(arg_3_0)
	local var_3_0 = arg_3_0._tf:Find("window")

	setText(var_3_0:Find("top/bg/infomation/title"), i18n("title_info"))

	arg_3_0.btnBack = var_3_0:Find("top/btnBack")
	arg_3_0.btnConfirm = var_3_0:Find("button_container/confirm")

	setText(arg_3_0.btnConfirm:Find("pic"), i18n("text_confirm"))

	local var_3_1 = var_3_0:Find("item_panel")

	setText(var_3_1:Find("word/Text"), i18n("last_building_not_shown"))

	arg_3_0.toggleLock = var_3_1:Find("lock_toggle")

	local var_3_2 = var_3_1:Find("scrollview")

	arg_3_0.shipItemList = UIItemList.New(var_3_2, var_3_2:Find("item_tpl"))

	arg_3_0.shipItemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		arg_4_1 = arg_4_1 + 1

		if arg_4_0 == UIItemList.EventUpdate then
			updateDrop(arg_4_2:Find("IconTpl"), {
				count = 1,
				type = DROP_TYPE_SHIP,
				id = arg_3_0.ships[arg_4_1].configId,
				virgin = arg_3_0.ships[arg_4_1].virgin
			})
			onButton(arg_3_0, arg_4_2, function()
				arg_3_0:emit(var_0_0.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			onLongPressTrigger(arg_3_0, arg_4_2, function()
				arg_3_0:emit(BuildShipRemindMediator.SHOW_NEW_SHIP, var_0)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function var_0_0.didEnter(arg_7_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_7_0._tf)
	onButton(arg_7_0, arg_7_0.btnBack, function()
		arg_7_0:exitCheck()

		return
	end, SFX_CANCEL)
	onButton(arg_7_0, arg_7_0.btnConfirm, function()
		arg_7_0:exitCheck()

		return
	end, SFX_CONFIRM)
	onToggle(arg_7_0, arg_7_0.toggleLock, function(arg_10_0)
		arg_7_0.isLockNew = arg_10_0

		return
	end, SFX_PANEL)
	triggerToggle(arg_7_0.toggleLock, false)
	arg_7_0.shipItemList:align(#arg_7_0.ships)

	return
end

function var_0_0.exitCheck(arg_11_0)
	if arg_11_0.isLockNew then
		if #underscore(arg_11_0.ships):chain():filter(function(arg_12_0)
			return arg_12_0.virgin
		end):map(function(arg_13_0)
			return arg_13_0.id
		end):value() > 0 then
			table.insert({}, function(arg_14_0)
				arg_11_0:emit(BuildShipRemindMediator.ON_LOCK, var_0, Ship.LOCK_STATE_LOCK, arg_14_0)

				return
			end)
		end
	end

	seriesAsync({}, function()
		arg_11_0:closeView()

		return
	end)

	return
end

function var_0_0.onBackPressed(arg_16_0)
	return
end

function var_0_0.willExit(arg_17_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_17_0._tf)

	return
end

return var_0_0
