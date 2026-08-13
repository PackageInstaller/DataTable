class = var_0_10000

local var_0_0 = var_0_10000("MainCrusingActSequence")
local var_0_1 = false

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.getAliveActivityByType

	ActivityConst = var_1_10006

	local var_1_2 = var_1_1(var_1_0, var_1_10006.ACTIVITY_TYPE_PT_CRUSING)
	local var_1_3 = {}

	if var_1_2 and not var_1_2:isEnd() then
		table = var_1_0

		var_1_0.insert(var_1_3, function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.CheckCrusingAct(var_2_0, var_1_2, arg_2_0)

			return
		end)

		PlayerPrefs = var_1_0

		if var_1_0.GetInt("cursing_first_enter_scene:" .. var_1_2.id, 0) == 0 then
			table = var_1_0

			var_1_0.insert(var_1_3, function(arg_3_0)
				PlayerPrefs = var_2_10001

				var_2_10001.SetInt("cursing_first_enter_scene:" .. var_1_2.id, 1)

				local var_3_0 = arg_1_0

				var_1.ShowWindow(var_3_0, arg_3_0)

				return
			end)
		end

		table = var_1_0

		var_1_0.insert(var_1_3, function(arg_4_0)
			if var_0_1 then
				arg_4_0()

				return
			end

			local var_4_0 = var_1_2.stopTime

			pg = var_2_10002

			local var_4_1 = var_2_10002.TimeMgr.GetInstance()
			local var_4_2 = var_4_0 - var_2.GetServerTime(var_4_1)

			math = var_2

			local var_4_3 = var_2.floor(var_4_2 / 0)

			PlayerPrefs = var_2_10003

			if var_2_10003.GetInt("crusing_last_remind_day_" .. var_4_3) == 1 then
				arg_4_0()

				return
			end

			var_0_1 = true
			pg = var_4

			local var_4_4 = var_4.battlepass_event_pt[var_1_2.id].map_name

			i18n = var_5

			local var_4_5 = var_5("cruise_title_" .. var_4_4)

			pg = var_6

			if var_4_3 <= var_6.gameset.world_cruise_due_days.key_value then
				pg = var_6

				local var_4_6 = var_6.MsgboxMgr.GetInstance()
				local var_4_7 = var_6.ShowMsgBox
				local var_4_8 = {
					hideNo = true,
					showStopRemind = true,
					toggleStatus = true
				}

				i18n = var_2_10010
				var_4_8.content = var_2_10010("world_cruise_due_tips", var_4_5, var_4_3)

				function var_4_8.onYes()
					pg = var_3_10000

					if var_3_10000.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
						PlayerPrefs = var_3_10001

						var_3_10001.SetInt("crusing_last_remind_day_" .. var_4_3, 1)
					end

					arg_4_0()

					return
				end

				function var_4_8.onClose()
					pg = var_3_10000

					if var_3_10000.MsgboxMgr.GetInstance().stopRemindToggle.isOn then
						PlayerPrefs = var_3_10001

						var_3_10001.SetInt("crusing_last_remind_day_" .. var_4_3, 1)
					end

					arg_4_0()

					return
				end

				var_4_7(var_4_6, var_4_8)
			else
				arg_4_0()
			end

			return
		end)
	end

	seriesAsync = var_1_0

	var_1_0(var_1_3, arg_1_1)

	return
end

function var_0_0.ShowWindow(arg_7_0, arg_7_1)
	pg = var_1_10002

	local var_7_0 = var_1_10002.m02
	local var_7_1 = var_2.sendNotification

	GAME = var_1_10005

	local var_7_2 = var_1_10005.LOAD_LAYERS
	local var_7_3 = {}

	getProxy = var_1_10007
	ContextProxy = var_1_10009

	local var_7_4 = var_1_10007(var_1_10009)

	var_7_3.parentContext = var_7.getCurrentContext(var_7_4)
	Context = var_7

	local var_7_5 = var_7.New
	local var_7_6 = {}

	CrusingWindowMediator = var_1_10010
	var_7_6.mediator = var_1_10010
	CrusingWindowLayer2 = var_1_10010
	var_7_6.viewComponent = var_1_10010
	var_7_6.data = {
		onClose = arg_7_1
	}
	var_7_3.context = var_7_5(var_7_6)

	var_7_1(var_7_0, var_7_2, var_7_3)

	return
end

function var_0_0.CheckCrusingAct(arg_8_0, arg_8_1, arg_8_2)
	PlayerPrefs = var_1_10003

	local var_8_0 = var_1_10003.GetInt

	string = var_1_10005

	local var_8_1 = var_8_0(var_1_10005.format("crusing_%d_last_time", arg_8_1.id), 3)
	local var_8_2 = arg_8_1.stopTime

	pg = var_5

	local var_8_3 = var_5.TimeMgr.GetInstance()
	local var_8_4 = var_8_2 - var_5.GetServerTime(var_8_3)

	if #arg_8_1:GetCrusingUnreceiveAward() > 0 then
		math = var_6

		if var_6.floor(var_8_4 / 0) < var_8_1 then
			PlayerPrefs = var_6

			local var_8_5 = var_6.SetInt

			string = var_8

			local var_8_6 = var_8.format("crusing_%d_last_time", arg_8_1.id)

			math = var_1_10009

			var_8_5(var_8_6, var_1_10009.floor(var_8_4 / 0))
			arg_8_0:ShowMsg(var_5, var_8_4, arg_8_2)

			goto label_8_0
		end
	end

	arg_8_2()

	::label_8_0::

	return
end

function var_0_0.ShowMsg(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_1

	if arg_9_2 < 0 then
		pg = var_9_1

		local var_9_0 = var_9_1.MsgboxMgr.GetInstance()

		var_9_1 = var_9_1.ShowMsgBox

		local var_9_2 = {
			hideNo = true
		}

		MSGBOX_TYPE_ITEM_BOX = var_1_10008
		var_9_2.type = var_1_10008
		i18n = var_1_10008

		local var_9_3 = "battlepass_acquire_attention"

		math = var_1_10011
		var_1_10011 = var_1_10011.floor(arg_9_2 / 0)
		math = var_1_10012
		var_9_2.content = var_1_10008(var_9_3, var_1_10011, var_1_10012.floor(arg_9_2 % 0 / 16))
		var_9_2.items = arg_9_1

		function var_9_2.onYes()
			pg = var_2_10000

			local var_10_0 = var_2_10000.m02
			local var_10_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_10_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_10_1(var_10_0, var_10_2, var_2_10004.CRUSING)

			return
		end

		i18n = var_1_10008
		var_9_2.yesText = var_1_10008("msgbox_text_forward")

		function var_9_2.onNo()
			pg = var_2_10000

			local var_11_0 = var_2_10000.m02
			local var_11_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_11_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_11_1(var_11_0, var_11_2, var_2_10004.CRUSING)

			return
		end

		var_9_1(var_9_0, var_9_2)
	else
		pg = var_9_1

		local var_9_4 = var_9_1.MsgboxMgr.GetInstance()
		local var_9_5 = var_4.ShowMsgBox
		local var_9_6 = {}

		MSGBOX_TYPE_ITEM_BOX = var_1_10008
		var_9_6.type = var_1_10008
		i18n = var_1_10008

		local var_9_7 = "battlepass_acquire_attention"

		math = var_1_10011

		local var_9_8 = var_1_10011.floor(arg_9_2 / 0)

		math = var_1_10012
		var_9_6.content = var_1_10008(var_9_7, var_9_8, var_1_10012.floor(arg_9_2 % 0 / 16))
		var_9_6.items = arg_9_1

		function var_9_6.onYes()
			pg = var_2_10000

			local var_12_0 = var_2_10000.m02
			local var_12_1 = var_0.sendNotification

			GAME = var_2_10003

			local var_12_2 = var_2_10003.GO_SCENE

			SCENE = var_2_10004

			var_12_1(var_12_0, var_12_2, var_2_10004.CRUSING)

			return
		end

		i18n = var_8
		var_9_6.yesText = var_8("msgbox_text_forward")
		var_9_6.onNo = arg_9_3

		var_9_5(var_9_4, var_9_6)
	end

	return
end

return var_0_0
