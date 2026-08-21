local var_0_0 = class("ChuixuePTRePage", import(".TemplatePage.PtTemplatePage"))

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)

	var_0_0.scrolltext = arg_1_0.awardTF:Find("name")

	onButton(arg_1_0, arg_1_0.battleBtn, function()
		arg_1_0:emit(ActivityMediator.GO_SHOPS_LAYER_STEEET, {
			warp = NewShopsScene.TYPE_SHOP_STREET
		})

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_3_0)
	var_0_0.super.OnUpdateFlush(arg_3_0)
	arg_3_0:SetAwardName()

	local var_3_0, var_3_1, var_3_2 = arg_3_0.ptData:GetResProgress()
	local var_3_3 = var_3_2 >= 1 and setColorStr(var_3_0, "#A2A2A2FF") or var_3_0

	setText(arg_3_0.progress, var_3_3 .. "/" .. var_3_1)

	return
end

function var_0_0.SetAwardName(arg_4_0)
	local var_4_0 = arg_4_0.ptData:GetAward()

	if Item.getConfigData(var_4_0.id) then
		changeToScrollText(var_0_0.scrolltext, var_4_0:getName())
	else
		setActive(arg_4_0.awardTF:Find("name"), false)
	end

	return
end

return var_0_0
