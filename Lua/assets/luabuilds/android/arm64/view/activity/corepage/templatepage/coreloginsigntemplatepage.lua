local var_0_0 = class("CoreLoginSignTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.item = arg_1_0.bg:Find("item")
	arg_1_0.items = arg_1_0.bg:Find("items")
	arg_1_0.itemList = UIItemList.New(arg_1_0.items, arg_1_0.item)

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	arg_2_0.config = pg.activity_7_day_sign[arg_2_0.activity:getConfig("config_id")]
	arg_2_0.Day = #arg_2_0.config.front_drops

	return
end

function var_0_0.OnFirstFlush(arg_3_0)
	setActive(arg_3_0.item, false)
	arg_3_0.itemList:make(function(arg_4_0, arg_4_1, arg_4_2)
		if arg_4_0 == UIItemList.EventUpdate then
			updateDrop(arg_4_2:Find("item"), (Drop.Create(arg_3_0.config.front_drops[arg_4_1 + 1])))
			onButton(arg_3_0, arg_4_2, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			setActive(arg_4_2:Find("got"), arg_4_1 < arg_3_0.nday)

			local var_4_0 = arg_4_1 < arg_3_0.nday and i18n("word_status_inEventFinished") or i18n("which_day_2", arg_4_1 + 1)

			setText(arg_4_2:Find("day/Text"), var_4_0)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	arg_6_0.nday = arg_6_0.activity.data1

	arg_6_0.itemList:align(arg_6_0.Day)

	return
end

function var_0_0.OnDestroy(arg_7_0)
	removeAllChildren(arg_7_0.items)

	return
end

return var_0_0
