local var_0_0 = class("LightLoginTemplatePage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.bar = arg_1_0.bg:Find("bar")
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
		if arg_4_0 == UIItemList.EventInit then
			updateDrop(arg_4_2:Find("item"), (Drop.Create(arg_3_0.config.front_drops[arg_4_1 + 1])))
			onButton(arg_3_0, arg_4_2, function()
				arg_3_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
			GetImageSpriteFromAtlasAsync("ui/share/light_login_atlas", "DAY" .. arg_4_1 + 1, arg_4_2:Find("day"), true)
		elseif arg_4_0 == UIItemList.EventUpdate then
			local var_4_0 = arg_4_1 < arg_3_0.nday

			setActive(arg_4_2:Find("got"), arg_4_1 < arg_3_0.nday)
			setActive(arg_4_2:Find("get"), var_4_0)
			setActive(arg_4_2:Find("bg"), not var_4_0)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_6_0)
	arg_6_0.nday = arg_6_0.activity.data1

	arg_6_0.itemList:align(arg_6_0.Day)
	setFillAmount(arg_6_0.bar, arg_6_0.nday / arg_6_0.Day)

	return
end

function var_0_0.OnDestroy(arg_7_0)
	clearImageSprite(arg_7_0.bg)
	removeAllChildren(arg_7_0.items)

	return
end

return var_0_0
