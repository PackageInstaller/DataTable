local var_0_0 = class("MainCrusingActSequence")
local var_0_1 = false

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)

	if var_1_0 and not var_1_0:isEnd() then
		table.insert({}, function(arg_2_0)
			arg_1_0:CheckCrusingAct(var_1_0, arg_2_0)

			return
		end)

		if PlayerPrefs.GetInt("cursing_first_enter_scene:" .. var_1_0.id, 0) == 0 then
			table.insert({}, function(arg_3_0)
				PlayerPrefs.SetInt("cursing_first_enter_scene:" .. var_1_0.id, 1)
				arg_1_0:ShowWindow(arg_3_0)

				return
			end)
		end

		table.insert({}, function(arg_4_0)
			if var_0_1 then
				arg_4_0()

				return
			end

			local var_4_0 = math.floor((var_1_0.stopTime - pg.TimeMgr.GetInstance():GetServerTime()) / 0)

			if PlayerPrefs.GetInt("crusing_last_remind_day_" .. var_4_0) == 1 then
				arg_4_0()

				return
			end

			var_0_1 = true

			if var_4_0 <= pg.gameset.world_cruise_due_days.key_value then
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					hideNo = true,
					showStopRemind = true,
					toggleStatus = true,
					content = i18n("world_cruise_due_tips", i18n("cruise_title_" .. pg.battlepass_event_pt[var_1_0.id].map_name), var_4_0),
					onYes = function()
						if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
							PlayerPrefs.SetInt("crusing_last_remind_day_" .. var_4_0, 1)
						end

						arg_4_0()

						return
					end,
					onClose = function()
						if pg.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
							PlayerPrefs.SetInt("crusing_last_remind_day_" .. var_4_0, 1)
						end

						arg_4_0()

						return
					end
				})
			else
				arg_4_0()
			end

			return
		end)
	end

	seriesAsync({}, arg_1_1)

	return
end

function var_0_0.ShowWindow(arg_7_0, arg_7_1)
	({}).parentContext = getProxy(ContextProxy):getCurrentContext()
	;({}).context = Context.New({
		mediator = CrusingWindowMediator,
		viewComponent = CrusingWindowLayer2,
		data = {
			onClose = arg_7_1
		}
	})

	pg.m02:sendNotification(GAME.LOAD_LAYERS, {})

	return
end

function var_0_0.CheckCrusingAct(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_1.stopTime - pg.TimeMgr.GetInstance():GetServerTime()
	local var_8_1 = arg_8_1:GetCrusingUnreceiveAward()

	if #var_8_1 > 0 and PlayerPrefs.GetInt(string.format("crusing_%d_last_time", arg_8_1.id), 3) > math.floor(var_8_0 / 0) then
		PlayerPrefs.SetInt(string.format("crusing_%d_last_time", arg_8_1.id), math.floor(var_8_0 / 0))
		arg_8_0:ShowMsg(var_8_1, var_8_0, arg_8_2)
	else
		arg_8_2()
	end

	return
end

function var_0_0.ShowMsg(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 < 0 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("battlepass_acquire_attention", math.floor(arg_9_2 / 0), math.floor(arg_9_2 % 0 / 16)),
			items = arg_9_1,
			onYes = function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)

				return
			end,
			yesText = i18n("msgbox_text_forward"),
			onNo = function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)

				return
			end
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_ITEM_BOX,
			content = i18n("battlepass_acquire_attention", math.floor(arg_9_2 / 0), math.floor(arg_9_2 % 0 / 16)),
			items = arg_9_1,
			onYes = function()
				pg.m02:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)

				return
			end,
			yesText = i18n("msgbox_text_forward"),
			onNo = arg_9_3
		})
	end

	return
end

return var_0_0
