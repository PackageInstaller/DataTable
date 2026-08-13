class = var_0_10000

local var_0_0 = "IslandDrawAwardCountWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("Mod.Island.View.page.msgbox.window.IslandBaseMsgboxWindow"))

function var_0_1.getUIName(arg_1_0)
	return "IslandDrawAwardCountMsgBox"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	setText = var_1_10001

	local var_3_0 = arg_3_0.rtTitle

	i18n = var_1_10004

	var_1_10001(var_3_0, var_1_10004("island_draw_choice_title"))

	onButton = var_1_10001

	local var_3_1 = arg_3_0
	local var_3_2 = arg_3_0.btnClose

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_CANCEL = var_6

	var_1_10001(var_3_1, var_3_2, var_3_3, var_6)

	UIItemList = var_1_10001
	arg_3_0.toggleList = var_1_10001.New(arg_3_0.rtToggles, arg_3_0.rtToggleTpl)

	local var_3_4 = arg_3_0.toggleList

	var_1.make(var_3_4, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1
		UIItemList = var_2_10003

		if arg_5_0 == var_2_10003.EventUpdate then
			unpack = var_3

			local var_5_0, var_5_1 = var_3(arg_3_0.countAwardList[arg_5_1])

			pg = var_5

			local var_5_2 = var_5.island_draw_reward[var_5_0]

			Drop = var_2_10006

			local var_5_3 = var_2_10006.New({
				type = var_5_2.drop_type,
				id = var_5_2.drop_id
			})

			IslandShopDrawAwardPage = var_2_10007

			var_2_10007.ShowDropInfo(var_5_3, arg_5_2:Find("mask/Image"))

			setText = var_7

			var_7(arg_5_2:Find("name/Text"), var_5_3:getName())

			setText = var_7

			local var_5_4 = arg_5_2:Find("got/got/Text")

			i18n = var_10

			var_7(var_5_4, var_10("island_draw_get"))

			onToggle = var_7

			local var_5_5 = arg_3_0
			local var_5_6 = arg_5_2

			local function var_5_7(arg_6_0)
				if arg_6_0 then
					arg_3_0.selectedTarget = var_5_0
				elseif arg_3_0.selectedTarget == var_5_0 then
					arg_3_0.selectedTarget = nil
				end

				return
			end

			SFX_UI_CLICK = var_12

			var_7(var_5_5, var_5_6, var_5_7, var_12)

			triggerToggle = var_7

			var_7(arg_5_2, false)

			setToggleEnabled = var_7

			var_7(arg_5_2, var_5_1)

			setActive = var_7

			var_7(arg_5_2:Find("got"), not var_5_1)
		end

		return
	end)

	setText = var_1

	local var_3_5 = arg_3_0.btnConfirm
	local var_3_6 = var_3.Find(var_3_5, "Text")

	i18n = var_4

	var_1(var_3_6, var_4("word_take"))

	onButton = var_1

	local var_3_7 = arg_3_0
	local var_3_8 = arg_3_0.btnConfirm

	local function var_3_9()
		if arg_3_0.selectedTarget then
			local var_7_0 = arg_3_0.activity

			if not var_0.CanCountAward(var_7_0, arg_3_0.selectedTarget) then
				return
			end

			local var_7_1 = arg_3_0
			local var_7_2 = var_0.emit

			IslandMediator = var_2_10003

			var_7_2(var_7_1, var_2_10003.DRAW_AWARD_OPERATION, {
				op = "count_award",
				activity_id = arg_3_0.activity.id,
				target_id = arg_3_0.selectedTarget
			})

			local var_7_3 = arg_3_0

			var_0.Hide(var_7_3)

			return
		end
	end

	SFX_CONFIRM = var_6

	var_1(var_3_7, var_3_8, var_3_9, var_6)

	return
end

function var_0_1.OnShow(arg_8_0)
	var_0_1.super.OnShow(arg_8_0)
	arg_8_0:UpdateActivity(arg_8_0.settings.activity)

	return
end

function var_0_1.UpdateActivity(arg_9_0, arg_9_1)
	arg_9_0.activity = arg_9_1
	arg_9_0.countAwardList = arg_9_1:GetCountAwards()

	local var_9_0 = arg_9_0.toggleList

	var_2.align(var_9_0, #arg_9_0.countAwardList)

	local var_9_1 = arg_9_0.activity
	local var_9_2 = var_2.GetDrawCount(var_9_1)
	local var_9_3 = arg_9_0.activity
	local var_9_4

	if not var_3.GetNextCountAwardTimes(var_9_3) then
		var_9_4 = 0
	end

	setText = var_9_1

	local var_9_5 = arg_9_0.rtCountWord

	i18n = var_1_10007

	local var_9_6 = var_1_10007("island_draw_choice")

	string = var_1_10008

	var_9_1(var_9_5, var_9_6 .. var_1_10008.format("%d/%d", var_9_2, var_9_4))

	setGray = var_9_1

	local var_9_7 = arg_9_0.btnConfirm
	local var_9_8 = arg_9_0.activity

	var_9_1(var_9_7, not var_7.CanCountAward(var_9_8, arg_9_0.selectedTarget))

	return
end

return var_0_1
