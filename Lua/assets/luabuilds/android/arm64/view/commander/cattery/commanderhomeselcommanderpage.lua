local var_0_0 = class("CommanderHomeSelCommanderPage", import(".CommanderHomeBaseSelPage"))

function var_0_0.getUIName(arg_1_0)
	return "CommanderHomeSelCommanderPage"
end

function var_0_0.OnCatteryUpdate(arg_2_0, arg_2_1)
	arg_2_0.cattery = arg_2_1

	arg_2_0:Update(arg_2_0.home, arg_2_1)

	return
end

function var_0_0.OnInit(arg_3_0)
	var_0_0.super.OnInit(arg_3_0)

	arg_3_0.selectedID = -1

	onButton(arg_3_0, arg_3_0.okBtn, function()
		if arg_3_0.selectedID >= 0 then
			arg_3_0:emit(CommanderHomeMediator.ON_SEL_COMMANDER, arg_3_0.cattery.id, arg_3_0.selectedID)
		end

		return
	end, SFX_PANEL)

	return
end

function var_0_0.OnSelected(arg_5_0, arg_5_1)
	if arg_5_1.commanderVO then
		local var_5_0, var_5_1 = arg_5_0:Check(arg_5_1.commanderVO.id)

		if var_5_0 then
			if arg_5_0.mark then
				setActive(arg_5_0.mark, false)
			end

			if arg_5_0.selectedID == arg_5_1.commanderVO.id then
				arg_5_0.selectedID = 0
				arg_5_0.mark = nil

				arg_5_0:emit(CatteryDescPage.CHANGE_COMMANDER, nil)
			else
				setActive(arg_5_1.mark2, true)

				arg_5_0.mark = arg_5_1.mark2
				arg_5_0.selectedID = arg_5_1.commanderVO.id

				arg_5_0:emit(CatteryDescPage.CHANGE_COMMANDER, arg_5_1.commanderVO)
			end
		else
			pg.TipsMgr.GetInstance():ShowTips(var_5_1)
		end
	end

	return
end

function var_0_0.Check(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs((arg_6_0.home:GetCatteries())) do
		if iter_6_1:GetCommanderId() == arg_6_1 and iter_6_1.id ~= arg_6_0.cattery.id then
			local var_6_1 = i18n("commander_is_in_cattery")

			return
		end
	end

	return true
end

function var_0_0.CheckIncludeSelf(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs((arg_7_0.home:GetCatteries())) do
		if iter_7_1:GetCommanderId() == arg_7_1 then
			return false
		end
	end

	return true
end

function var_0_0.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	var_0_0.super.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)

	local var_8_0 = arg_8_0.displays[arg_8_1 + 1]
	local var_8_1 = arg_8_0.cards[arg_8_2]

	if arg_8_0.displays[arg_8_1 + 1] then
		local var_8_2 = arg_8_0.selectedID == var_8_0.id

		setActive(var_8_1.mark2, arg_8_0.selectedID == var_8_0.id)

		if var_8_2 then
			arg_8_0.mark = var_8_1.mark2
		end

		setActive(var_8_1._tf:Find("info/home"), not arg_8_0:CheckIncludeSelf(var_8_0.id))
	end

	return
end

function var_0_0.Update(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:Show()

	arg_9_0.home = arg_9_1
	arg_9_0.cattery = arg_9_2

	local var_9_0 = arg_9_2:GetCommanderId()

	if var_9_0 ~= 0 then
		arg_9_0.selectedID = var_9_0
	end

	var_0_0.super.Update(arg_9_0)

	return
end

function var_0_0.Hide(arg_10_0)
	var_0_0.super.Hide(arg_10_0)

	arg_10_0.selectedID = -1
	arg_10_0.mark = nil

	return
end

return var_0_0
