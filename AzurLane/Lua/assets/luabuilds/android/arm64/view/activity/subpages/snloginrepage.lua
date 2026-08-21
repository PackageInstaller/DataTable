local var_0_0 = class("SNLoginRePage", import(".TemplatePage.LoginTemplatePage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.bar = arg_1_0.bg:Find("bar")

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
			GetImageSpriteFromAtlasAsync("ui/activityuipage/snloginrepage_atlas", "DAY" .. arg_3_1 + 1, arg_3_2:Find("day"), true)
		elseif arg_3_0 == UIItemList.EventUpdate then
			local var_3_0 = arg_3_1 < arg_2_0.nday

			setActive(arg_3_2:Find("got"), arg_3_1 < arg_2_0.nday)
			setActive(arg_3_2:Find("get"), var_3_0)
			setActive(arg_3_2:Find("bg"), not var_3_0)
		end

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_5_0)
	var_0_0.super.OnUpdateFlush(arg_5_0)
	setFillAmount(arg_5_0.bar, arg_5_0.nday / arg_5_0.Day)

	return
end

function var_0_0.OnDestroy(arg_6_0)
	return
end

return var_0_0
