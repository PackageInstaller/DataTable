class = var_0_10000

local var_0_0 = "ActivityCrusingLastTimeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().awards
	local var_1_1 = var_2.time
	local var_1_2 = var_2.closeFunc
	local var_1_4

	if var_1_1 < 0 then
		pg = var_1_4

		local var_1_3 = var_1_4.MsgboxMgr.GetInstance()

		var_1_4 = var_1_4.ShowMsgBox

		local var_1_5 = {
			hideNo = true
		}

		MSGBOX_TYPE_ITEM_BOX = var_1_10009
		var_1_5.type = var_1_10009
		i18n = var_1_10009

		local var_1_6 = "battlepass_acquire_attention"

		math = var_1_10011
		var_1_10011 = var_1_10011.floor(var_1_1 / 0)
		math = var_12
		var_1_5.content = var_1_10009(var_1_6, var_1_10011, var_12.floor(var_1_1 % 0 / 16))
		var_1_5.items = var_1_0

		function var_1_5.onYes()
			local var_2_0 = arg_1_0
			local var_2_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_2_2 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_2_1(var_2_0, var_2_2, var_2_10003.CRUSING)

			return
		end

		i18n = var_1_10009
		var_1_5.yesText = var_1_10009("msgbox_text_forward")

		function var_1_5.onNo()
			local var_3_0 = arg_1_0
			local var_3_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_3_2 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_3_1(var_3_0, var_3_2, var_2_10003.CRUSING)

			return
		end

		var_1_4(var_1_3, var_1_5)
	else
		pg = var_1_4

		local var_1_7 = var_1_4.MsgboxMgr.GetInstance()
		local var_1_8 = var_6.ShowMsgBox
		local var_1_9 = {}

		MSGBOX_TYPE_ITEM_BOX = var_1_10009
		var_1_9.type = var_1_10009
		i18n = var_1_10009

		local var_1_10 = "battlepass_acquire_attention"

		math = var_1_10011

		local var_1_11 = var_1_10011.floor(var_1_1 / 0)

		math = var_12
		var_1_9.content = var_1_10009(var_1_10, var_1_11, var_12.floor(var_1_1 % 0 / 16))
		var_1_9.items = var_1_0

		function var_1_9.onYes()
			local var_4_0 = arg_1_0
			local var_4_1 = var_0.sendNotification

			GAME = var_2_10002

			local var_4_2 = var_2_10002.GO_SCENE

			SCENE = var_2_10003

			var_4_1(var_4_0, var_4_2, var_2_10003.CRUSING)

			return
		end

		i18n = var_9
		var_1_9.yesText = var_9("msgbox_text_forward")
		var_1_9.onNo = var_1_2

		var_1_8(var_1_7, var_1_9)
	end

	return
end

return var_0_1
