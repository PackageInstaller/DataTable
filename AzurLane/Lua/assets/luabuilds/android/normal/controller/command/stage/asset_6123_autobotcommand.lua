class = var_0_10000

local var_0_0 = "AutoBotCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().isActiveBot
	local var_1_1 = var_2.toggle
	local var_1_2 = var_2.system
	local var_1_3 = var_0_1.GetAutoBotMark(var_1_2)
	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.sendNotification

	BattleMediator = var_1_10009

	var_1_5(var_1_4, var_1_10009.UPDATE_AUTO_COUNT, {
		isOn = var_1_0
	})

	if var_0_1.autoBotSatisfied() then
		PlayerPrefs = var_7

		if var_7.GetInt("autoBotIsAcitve" .. var_1_3, 0) == not var_1_0 then
			-- block empty
		else
			PlayerPrefs = var_8

			var_8.SetInt("autoBotIsAcitve" .. var_1_3, not var_1_0 and 1 or 0)
			var_0_1.activeBotHelp(not var_1_0)
		end
	elseif not var_1_0 then
		if var_1_1 then
			onDelayTick = var_7

			var_7(function()
				GetComponent = var_2_10000

				local var_2_0 = var_1_1

				typeof = var_2_10002
				Toggle = var_2_10003
				var_2_10000(var_2_0, var_2_10002(var_2_10003)).isOn = false

				return
			end, 0.1)
		end

		pg = var_7

		local var_1_6 = var_7.TipsMgr.GetInstance()
		local var_1_7 = var_7.ShowTips

		i18n = var_9

		var_1_7(var_1_6, var_9("auto_battle_limit_tip"))
	end

	if var_1_0 then
		local var_1_8 = arg_1_0
		local var_1_9 = arg_1_0.sendNotification

		GAME = var_9

		var_1_9(var_1_8, var_9.AUTO_SUB, {
			isActiveSub = true,
			system = var_1_2
		})
	end

	return
end

function var_0_1.autoBotSatisfied()
	getProxy = var_1_10000
	ChapterProxy = var_1_10001

	if var_1_10000(var_1_10001) then
		::label_3_0::

		local var_3_0 = var_0

		var_1_10001 = var_0.getChapterById
		AUTO_ENABLE_CHAPTER = var_1_10003

		local var_3_1 = var_1_10001(var_3_0, var_1_10003)

		var_1_10001 = var_1_10001.isClear(var_3_1)
	end

	return var_1_10001
end

function var_0_1.activeBotHelp(arg_4_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_4_0 = var_1_10001(var_1_10002)

	if not arg_4_0 then
		if var_0_1.autoBotHelp then
			pg = var_2

			local var_4_1 = var_2.MsgboxMgr.GetInstance()

			var_2.hide(var_4_1)
		end

		return
	end

	if var_4_0.botHelp then
		return
	end

	local var_4_2 = var_0_1

	var_4_2.autoBotHelp = true
	getProxy = var_4_2
	SettingsProxy = var_3

	local var_4_3 = var_4_2(var_3)

	if var_2.isTipAutoBattle(var_4_3) then
		pg = var_2

		local var_4_4 = var_2.MsgboxMgr.GetInstance()
		local var_4_5 = var_2.ShowMsgBox
		local var_4_6 = {
			toggleStatus = true,
			showStopRemind = true
		}

		MSGBOX_TYPE_HELP = var_1_10005
		var_4_6.type = var_1_10005
		i18n = var_1_10005
		var_4_6.helps = var_1_10005("help_battle_auto")

		local var_4_7 = {}
		local var_4_8 = {
			text = "text_iknow"
		}

		SFX_CANCEL = var_1_10007
		var_4_8.sound = var_1_10007

		function var_4_8.onCallback()
			pg = var_2_10000

			if var_2_10000.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
				getProxy = var_2_10001
				SettingsProxy = var_2_10002

				local var_5_0 = var_2_10001(var_2_10002)

				var_1.setAutoBattleTip(var_5_0)
			end

			return
		end

		var_4_7[1] = var_4_8
		var_4_6.custom = var_4_7

		function var_4_6.onClose()
			local var_6_0 = var_0_1

			var_6_0.autoBotHelp = false
			pg = var_6_0

			if var_6_0.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
				getProxy = var_1
				SettingsProxy = var_2_10002

				local var_6_1 = var_1(var_2_10002)

				var_1.setAutoBattleTip(var_6_1)
			end

			return
		end

		var_4_5(var_4_4, var_4_6)
	end

	var_4_0.botHelp = true

	return
end

function var_0_1.GetAutoBotMark(arg_7_0)
	SYSTEM_WORLD = var_1_10001

	if arg_7_0 ~= var_1_10001 then
		SYSTEM_WORLD_BOSS = var_1_10001

		if arg_7_0 == var_1_10001 then
			var_1_10001 = "_"
			SYSTEM_WORLD = var_1_10002

			return var_1_10001 .. var_1_10002
		else
			SYSTEM_GUILD = var_1_10001

			if arg_7_0 == var_1_10001 then
				local var_7_0 = "_"

				SYSTEM_GUILD = var_1_10002

				return var_7_0 .. var_1_10002
			else
				return ""
			end
		end

		return
	end
end

return var_0_1
