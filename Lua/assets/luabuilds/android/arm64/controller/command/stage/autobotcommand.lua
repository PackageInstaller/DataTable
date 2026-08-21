local var_0_0 = class("AutoBotCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.isActiveBot
	local var_1_2 = var_1_0.toggle
	local var_1_3 = var_1_0.system
	local var_1_4 = var_0_0.GetAutoBotMark(var_1_0.system)

	arg_1_0:sendNotification(BattleMediator.UPDATE_AUTO_COUNT, {
		isOn = var_1_0.isActiveBot
	})

	if var_0_0.autoBotSatisfied() then
		if PlayerPrefs.GetInt("autoBotIsAcitve" .. var_1_4, 0) == not var_1_1 then
			-- block empty
		else
			PlayerPrefs.SetInt("autoBotIsAcitve" .. var_1_4, not var_1_1 and 1 or 0)
			var_0_0.activeBotHelp(not var_1_1)
		end
	elseif not var_1_1 then
		if var_1_0.toggle then
			onDelayTick(function()
				GetComponent(var_1_2, typeof(Toggle)).isOn = false

				return
			end, 0.1)
		end

		pg.TipsMgr.GetInstance():ShowTips(i18n("auto_battle_limit_tip"))
	end

	if var_1_1 then
		arg_1_0:sendNotification(GAME.AUTO_SUB, {
			isActiveSub = true,
			system = var_1_3
		})
	end

	return
end

function var_0_0.autoBotSatisfied()
	local var_3_0 = getProxy(ChapterProxy)

	return var_3_0 and var_3_0:getChapterById(AUTO_ENABLE_CHAPTER):isClear()
end

function var_0_0.activeBotHelp(arg_4_0)
	local var_4_0 = getProxy(PlayerProxy)

	if not arg_4_0 then
		if var_0_0.autoBotHelp then
			pg.MsgboxMgr.GetInstance():hide()
		end

		return
	end

	if var_4_0.botHelp then
		return
	end

	var_0_0.autoBotHelp = true

	if getProxy(SettingsProxy):isTipAutoBattle() then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			toggleStatus = true,
			showStopRemind = true,
			type = MSGBOX_TYPE_HELP,
			helps = i18n("help_battle_auto"),
			custom = {
				{
					text = "text_iknow",
					sound = SFX_CANCEL,
					onCallback = function()
						if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
							getProxy(SettingsProxy):setAutoBattleTip()
						end

						return
					end
				}
			},
			onClose = function()
				var_0_0.autoBotHelp = false

				if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
					getProxy(SettingsProxy):setAutoBattleTip()
				end

				return
			end
		})
	end

	var_4_0.botHelp = true

	return
end

function var_0_0.GetAutoBotMark(arg_7_0)
	if arg_7_0 == SYSTEM_WORLD or arg_7_0 == SYSTEM_WORLD_BOSS then
		return "_" .. SYSTEM_WORLD
	elseif arg_7_0 == SYSTEM_GUILD then
		return "_" .. SYSTEM_GUILD
	else
		return ""
	end

	return
end

return var_0_0
