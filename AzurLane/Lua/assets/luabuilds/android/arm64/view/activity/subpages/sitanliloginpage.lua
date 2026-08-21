local var_0_0 = class("SitanliLoginPage", import(".TemplatePage.LoginTemplatePage"))

function var_0_0.OnDataSetting(arg_1_0)
	arg_1_0.config = pg.activity_7_day_sign[arg_1_0.activity:getConfig("config_id")]
	arg_1_0.Day = 14

	return
end

function var_0_0.OnFirstFlush(arg_2_0)
	setActive(arg_2_0.item, false)
	arg_2_0.itemList:make(function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_0 == UIItemList.EventInit then
			updateDrop(arg_3_2:Find("item"), {
				type = arg_2_0.config.front_drops[arg_3_1 + 1][1],
				id = arg_2_0.config.front_drops[arg_3_1 + 1][2],
				count = arg_2_0.config.front_drops[arg_3_1 + 1][3]
			})
			onButton(arg_2_0, arg_3_2, function()
				arg_2_0:emit(BaseUI.ON_DROP, var_0)

				return
			end, SFX_PANEL)
		elseif arg_3_0 == UIItemList.EventUpdate then
			setActive(arg_3_2:Find("got"), arg_3_1 < arg_2_0.nday)
		end

		return
	end)

	return
end

return var_0_0
