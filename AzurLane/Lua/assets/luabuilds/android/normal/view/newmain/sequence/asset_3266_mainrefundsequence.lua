class = var_0_10000

local var_0_0 = var_0_10000("MainRefundSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	UserProxy = var_1_10003

	if var_1_10002(var_1_10003).data.limitServerIds and #var_2.data.limitServerIds > 0 then
		pg = var_3

		local var_1_0 = var_3.m02
		local var_1_1 = var_3.sendNotification

		GAME = var_1_10005

		var_1_1(var_1_0, var_1_10005.GET_REFUND_INFO, {
			callback = function()
				local var_2_0 = arg_1_0

				var_0.ShowTip(var_2_0, arg_1_1)

				return
			end
		})
	else
		arg_1_1()
	end

	return
end

function var_0_0.ShowTip(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_3_0 = var_1_10002(var_1_10003)

	if var_2.getRefundInfo(var_3_0) then
		getProxy = var_3
		ServerProxy = var_3_0

		local var_3_1 = var_3(var_3_0)
		local var_3_2 = true

		pg = var_1_10005

		local var_3_3 = var_1_10005.MsgboxMgr.GetInstance()
		local var_3_4 = var_5.ShowMsgBox
		local var_3_5 = {
			modal = true,
			hideClose = true
		}

		i18n = var_1_10008
		var_3_5.content = var_1_10008("Supplement_pay1")

		function var_3_5.onYes()
			local var_4_1

			if var_3_2 then
				pg = var_4_1

				local var_4_0 = var_4_1.m02

				var_4_1 = var_4_1.sendNotification
				GAME = var_2_10002

				local var_4_2 = var_2_10002.GO_SCENE

				SCENE = var_2_10003

				var_4_1(var_4_0, var_4_2, var_2_10003.BACK_CHARGE)
			else
				Application = var_4_1

				var_4_1.Quit()
			end

			return
		end

		function var_3_5.onNo()
			pg = var_2_10000

			local var_5_0 = var_2_10000.m02
			local var_5_1 = var_0.sendNotification

			GAME = var_2_10002

			var_5_1(var_5_0, var_2_10002.LOGOUT, {
				code = 0
			})

			return
		end

		i18n = var_8
		var_3_5.yesText = var_8("Supplement_pay4")
		i18n = var_8
		var_3_5.noText = var_8("word_back")

		var_3_4(var_3_3, var_3_5)
	else
		arg_3_1()
	end

	return
end

return var_0_0
