local var_0_0 = class("IslandDrawAwardCountWindow", import("Mod.Island.View.page.msgbox.window.IslandBaseMsgboxWindow"))

function var_0_0.getUIName(arg_1_0)
	return "IslandDrawAwardCountMsgBox"
end

function var_0_0.OnLoaded(arg_2_0)
	return
end

function var_0_0.OnInit(arg_3_0)
	setText(arg_3_0.rtTitle, i18n("island_draw_choice_title"))
	onButton(arg_3_0, arg_3_0.btnClose, function()
		arg_3_0:Hide()

		return
	end, SFX_CANCEL)

	arg_3_0.toggleList = UIItemList.New(arg_3_0.rtToggles, arg_3_0.rtToggleTpl)

	arg_3_0.toggleList:make(function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_1 = arg_5_1 + 1

		if arg_5_0 == UIItemList.EventUpdate then
			local var_5_0, var_5_1 = unpack(arg_3_0.countAwardList[arg_5_1])
			local var_5_2 = Drop.New({
				type = pg.island_draw_reward[var_5_0].drop_type,
				id = pg.island_draw_reward[var_5_0].drop_id
			})

			IslandShopDrawAwardPage.ShowDropInfo(var_5_2, arg_5_2:Find("mask/Image"))
			setText(arg_5_2:Find("name/Text"), var_5_2:getName())
			setText(arg_5_2:Find("got/got/Text"), i18n("island_draw_get"))
			onToggle(arg_3_0, arg_5_2, function(arg_6_0)
				if arg_6_0 then
					arg_3_0.selectedTarget = var_5_0
				elseif arg_3_0.selectedTarget == var_5_0 then
					arg_3_0.selectedTarget = nil
				end

				return
			end, SFX_UI_CLICK)
			triggerToggle(arg_5_2, false)
			setToggleEnabled(arg_5_2, var_5_1)
			setActive(arg_5_2:Find("got"), not var_5_1)
		end

		return
	end)
	setText(arg_3_0.btnConfirm:Find("Text"), i18n("word_take"))
	onButton(arg_3_0, arg_3_0.btnConfirm, function()
		if not arg_3_0.selectedTarget or not arg_3_0.activity:CanCountAward(arg_3_0.selectedTarget) then
			return
		end

		arg_3_0:emit(IslandMediator.DRAW_AWARD_OPERATION, {
			op = "count_award",
			activity_id = arg_3_0.activity.id,
			target_id = arg_3_0.selectedTarget
		})
		arg_3_0:Hide()

		return
	end, SFX_CONFIRM)

	return
end

function var_0_0.OnShow(arg_8_0)
	var_0_0.super.OnShow(arg_8_0)
	arg_8_0:UpdateActivity(arg_8_0.settings.activity)

	return
end

function var_0_0.UpdateActivity(arg_9_0, arg_9_1)
	arg_9_0.activity = arg_9_1
	arg_9_0.countAwardList = arg_9_1:GetCountAwards()

	arg_9_0.toggleList:align(#arg_9_0.countAwardList)

	local var_9_0 = arg_9_0.activity:GetNextCountAwardTimes() or 0

	setText(arg_9_0.rtCountWord, i18n("island_draw_choice") .. string.format("%d/%d", arg_9_0.activity:GetDrawCount(), var_9_0))
	setGray(arg_9_0.btnConfirm, not arg_9_0.activity:CanCountAward(arg_9_0.selectedTarget))

	return
end

return var_0_0
