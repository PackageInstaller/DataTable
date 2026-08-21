local var_0_0 = class("BuildingUpgradeLayer", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "BuildingUpgradePanel"
end

function var_0_0.init(arg_2_0)
	arg_2_0.btnUpgrade = arg_2_0._tf:Find("window/frame/upgrade_btn")

	setText(arg_2_0._tf:Find("window/frame/costback/label"), i18n("word_consume"))
	setText(arg_2_0._tf:Find("window/frame/upgrade_btn/Image"), i18n("msgbox_text_upgrade"))

	arg_2_0.loader = AutoLoader.New()

	return
end

function var_0_0.UpdateActivity(arg_3_0, arg_3_1)
	arg_3_0.activity = arg_3_1

	return
end

function var_0_0.didEnter(arg_4_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)
	onButton(arg_4_0, arg_4_0._tf:Find("window/top/btnBack"), function()
		arg_4_0:closeView()

		return
	end)
	onButton(arg_4_0, arg_4_0._tf:Find("mengban"), function()
		arg_4_0:closeView()

		return
	end)
	arg_4_0:Set(arg_4_0.activity)

	return
end

function var_0_0.Set(arg_7_0, arg_7_1, arg_7_2)
	arg_7_2 = arg_7_2 or arg_7_0.contextData.buildingID

	local var_7_0 = pg.activity_event_building[arg_7_2]

	assert(pg.activity_event_building[arg_7_2], "Can't Find activity_event_building Config ID: " .. arg_7_2)

	arg_7_0.contextData.buildingID = arg_7_2

	local var_7_1 = #var_7_0.buff
	local var_7_2 = arg_7_1.data1KeyValueList[2][arg_7_2] or 1
	local var_7_3 = var_7_0.material[var_7_2]
	local var_7_4 = var_7_1 <= var_7_2
	local var_7_5 = 0
	local var_7_6 = false

	if var_7_1 > var_7_2 then
		var_7_5 = var_7_3[1][2]

		local var_7_7 = arg_7_1.data1KeyValueList[1][var_7_3[1][2]] or 0

		var_7_6 = var_7_4 or var_7_7 >= var_7_3[1][3]
	end

	setText(arg_7_0._tf:Find("window/top/name"), var_7_0.name)
	setText(arg_7_0._tf:Find("window/top/name/lv"), "Lv." .. var_7_2)
	setScrollText(arg_7_0._tf:Find("window/frame/describe/text"), var_7_0.desc)
	setText(arg_7_0._tf:Find("window/frame/content/title/lv/current"), "Lv." .. var_7_2)
	setActive(arg_7_0._tf:Find("window/frame/content/title/lv/next"), not var_7_4)

	if not var_7_4 then
		setText(arg_7_0._tf:Find("window/frame/content/title/lv/next"), "Lv." .. var_7_2 + 1)
	end

	assert(pg.benefit_buff_template[var_7_0.buff[var_7_2]], "Can't Find benefit_buff_template Config ID: " .. var_7_0.buff[var_7_2])
	setText(arg_7_0._tf:Find("window/frame/content/preview/current"), pg.benefit_buff_template[var_7_0.buff[var_7_2]].desc)
	setActive(arg_7_0._tf:Find("window/frame/content/preview/arrow"), not var_7_4)
	setActive(arg_7_0._tf:Find("window/frame/content/preview/next"), not var_7_4)

	if not var_7_4 then
		assert(pg.benefit_buff_template[var_7_0.buff[var_7_2 + 1]], "Can't Find benefit_buff_template Config ID: " .. var_7_0.buff[var_7_2 + 1])
		setText(arg_7_0._tf:Find("window/frame/content/preview/next"), pg.benefit_buff_template[var_7_0.buff[var_7_2 + 1]].desc)
		arg_7_0.loader:GetSprite(Item.getConfigData(var_7_5).icon, "", arg_7_0._tf:Find("window/frame/costback/icon"))
	end

	local var_7_9 = arg_7_0._tf:Find("window/frame/costback/cost")

	if not var_7_4 then
		local var_7_10 = var_7_0.material[var_7_2][1][3] or 0

		var_7_8(var_7_9, var_7_10)
		onButton(arg_7_0, arg_7_0.btnUpgrade, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("building_upgrade_tip"),
				onYes = function()
					if var_7_4 then
						return
					elseif var_7_6 then
						arg_7_0:emit(BuildingUpgradeMediator.ACTIVITY_OPERATION, {
							cmd = 1,
							activity_id = arg_7_0.activity.id,
							arg1 = arg_7_2
						})
					else
						pg.TipsMgr.GetInstance():ShowTips(i18n("building_tip"))
					end

					return
				end
			})

			return
		end)
		setGray(arg_7_0.btnUpgrade, var_7_4)
		setButtonEnabled(arg_7_0.btnUpgrade, not var_7_4)

		return
	end
end

function var_0_0.willExit(arg_10_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_10_0._tf)

	return
end

return var_0_0
