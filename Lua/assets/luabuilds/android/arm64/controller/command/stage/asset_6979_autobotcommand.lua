local AutoBotCommand = class("AutoBotCommand", pm.SimpleCommand)

function AutoBotCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.isActiveBot
	local var_1_2 = var_1_0.toggle
	local var_1_3 = var_1_0.system
	local var_1_4 = AutoBotCommand.GetAutoBotMark(var_1_0.system)

	self:sendNotification(BattleMediator.UPDATE_AUTO_COUNT, {
		isOn = var_1_0.isActiveBot
	})

	if AutoBotCommand.autoBotSatisfied() then
		if PlayerPrefs.GetInt("autoBotIsAcitve" .. var_1_4, 0) == not var_1_1 then
			-- block empty
		else
			PlayerPrefs.SetInt("autoBotIsAcitve" .. var_1_4, not var_1_1 and 1 or 0)
			AutoBotCommand.activeBotHelp(not var_1_1)
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
		local var_1_5 = getProxy(ChapterProxy)

		if var_1_5 then
			local var_1_6 = var_1_5:GetContinuousData(SYSTEM_SCENARIO)

			if var_1_6 then
				var_1_6:MarkClickStopAutoFlag()
			end
		end

		self:sendNotification(GAME.AUTO_SUB, {
			isActiveSub = true,
			system = var_1_3
		})
	end

	return
end

function AutoBotCommand.autoBotSatisfied()
	local var_3_0 = getProxy(ChapterProxy)

	return var_3_0 and var_3_0:getChapterById(AUTO_ENABLE_CHAPTER):isClear()
end

function AutoBotCommand:activeBotHelp()
	local var_4_0 = getProxy(PlayerProxy)

	if not self then
		if AutoBotCommand.autoBotHelp then
			pg.MsgboxMgr.GetInstance():hide()
		end

		return
	end

	if var_4_0.botHelp then
		return
	end

	AutoBotCommand.autoBotHelp = true

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
				AutoBotCommand.autoBotHelp = false

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

function AutoBotCommand:GetAutoBotMark()
	if self == SYSTEM_WORLD or self == SYSTEM_WORLD_BOSS then
		return "_" .. SYSTEM_WORLD
	elseif self == SYSTEM_GUILD then
		return "_" .. SYSTEM_GUILD
	else
		return ""
	end

	return
end

return AutoBotCommand
