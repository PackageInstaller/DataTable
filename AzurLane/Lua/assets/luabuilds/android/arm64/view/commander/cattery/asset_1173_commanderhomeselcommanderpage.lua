class = var_0_10000

local var_0_0 = "CommanderHomeSelCommanderPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CommanderHomeBaseSelPage"))

function var_0_1.getUIName(arg_1_0)
	return "CommanderHomeSelCommanderPage"
end

function var_0_1.OnCatteryUpdate(arg_2_0, arg_2_1)
	arg_2_0.cattery = arg_2_1

	arg_2_0:Update(arg_2_0.home, arg_2_1)

	return
end

function var_0_1.OnInit(arg_3_0)
	var_0_1.super.OnInit(arg_3_0)

	arg_3_0.selectedID = -1
	onButton = var_1

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.okBtn

	local function var_3_2()
		if arg_3_0.selectedID >= 0 then
			local var_4_0 = arg_3_0
			local var_4_1 = var_0.emit

			CommanderHomeMediator = var_2_10003

			var_4_1(var_4_0, var_2_10003.ON_SEL_COMMANDER, arg_3_0.cattery.id, arg_3_0.selectedID)
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_3_0, var_3_1, var_3_2, var_1_10006)

	return
end

function var_0_1.OnSelected(arg_5_0, arg_5_1)
	if arg_5_1.commanderVO then
		local var_5_0 = arg_5_1.commanderVO.id
		local var_5_1 = arg_5_0
		local var_5_2, var_5_3 = arg_5_0.Check(var_5_1, var_5_0)

		if var_5_2 then
			if arg_5_0.mark then
				setActive = var_5_1

				var_5_1(arg_5_0.mark, false)
			end

			if arg_5_0.selectedID == var_5_0 then
				arg_5_0.selectedID = 0
				arg_5_0.mark = nil

				local var_5_4 = arg_5_0

				var_5_1 = arg_5_0.emit
				CatteryDescPage = var_1_10008

				var_5_1(var_5_4, var_1_10008.CHANGE_COMMANDER, nil)
			else
				setActive = var_5_1

				var_5_1(arg_5_1.mark2, true)

				arg_5_0.mark = arg_5_1.mark2
				arg_5_0.selectedID = var_5_0

				local var_5_5 = arg_5_0

				var_5_1 = arg_5_0.emit
				CatteryDescPage = var_8

				var_5_1(var_5_5, var_8.CHANGE_COMMANDER, arg_5_1.commanderVO)
			end
		else
			pg = var_5_1

			local var_5_6 = var_5_1.TipsMgr.GetInstance()

			var_5.ShowTips(var_5_6, var_5_3)
		end
	end

	return
end

function var_0_1.Check(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.home
	local var_6_1 = var_2.GetCatteries(var_6_0)

	ipairs = var_1_10003

	for iter_6_0, iter_6_1 in var_1_10003(var_6_1) do
		if iter_6_1:GetCommanderId() == arg_6_1 and iter_6_1.id ~= arg_6_0.cattery.id then
			local var_6_2 = false

			i18n = var_9

			local var_6_3 = var_9("commander_is_in_cattery")

			return
		end
	end

	return true
end

function var_0_1.CheckIncludeSelf(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.home
	local var_7_1 = var_2.GetCatteries(var_7_0)

	ipairs = var_1_10003

	for iter_7_0, iter_7_1 in var_1_10003(var_7_1) do
		if iter_7_1:GetCommanderId() == arg_7_1 then
			return false
		end
	end

	return true
end

function var_0_1.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)
	var_0_1.super.OnUpdateItem(arg_8_0, arg_8_1, arg_8_2)

	local var_8_0 = arg_8_1 + 1
	local var_8_1 = arg_8_0.displays[var_8_0]
	local var_8_2 = arg_8_0.cards[arg_8_2]

	if var_8_1 then
		local var_8_3 = arg_8_0.selectedID == var_8_1.id

		setActive = var_7

		var_7(var_8_2.mark2, var_8_3)

		if var_8_3 then
			arg_8_0.mark = var_8_2.mark2
		end

		local var_8_4 = arg_8_0:CheckIncludeSelf(var_8_1.id)

		setActive = var_1_10008

		local var_8_5 = var_8_2._tf

		var_1_10008(var_10.Find(var_8_5, "info/home"), not var_8_4)
	end

	return
end

function var_0_1.Update(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:Show()

	arg_9_0.home = arg_9_1
	arg_9_0.cattery = arg_9_2

	if arg_9_2:GetCommanderId() ~= 0 then
		arg_9_0.selectedID = var_3
	end

	var_0_1.super.Update(arg_9_0)

	return
end

function var_0_1.Hide(arg_10_0)
	var_0_1.super.Hide(arg_10_0)

	arg_10_0.selectedID = -1
	arg_10_0.mark = nil

	return
end

return var_0_1
