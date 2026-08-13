class = var_0_10000

local var_0_0 = var_0_10000("MainNotificationWindowSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10002(var_1_10003)
	local var_1_1 = var_2.getData(var_1_0)
	local var_1_2 = {}
	local var_1_3 = #var_1_1.buildShipNotification

	if 0 < var_1_3 then
		table = var_1_3

		var_1_3.insert(var_1_2, function(arg_2_0)
			local var_2_0 = {}

			getProxy = var_2_10002
			BayProxy = var_2_10003

			local var_2_1 = var_2_10002(var_2_10003)

			ipairs = var_2_10003
			getProxy = var_2_10004
			PlayerProxy = var_2_10005

			local var_2_2 = var_2_10004(var_2_10005)

			for iter_2_0, iter_2_1 in var_2_10003(var_4.getRawData(var_2_2).buildShipNotification) do
				local var_2_3 = var_2_1

				if var_2_1.getShipById(var_2_3, iter_2_1.uid) then
					var_8.virgin = iter_2_1.new
					table = var_2_3

					var_2_3.insert(var_2_0, var_8)
				else
					pg = var_2_3

					local var_2_4 = var_2_3.TipsMgr.GetInstance()

					var_9.ShowTips(var_2_4, "without ship data from uid:" .. iter_2_1.uid)
				end
			end

			pg = var_3

			local var_2_5 = var_3.m02
			local var_2_6 = var_3.sendNotification

			GAME = var_5

			var_2_6(var_2_5, var_5.CONFIRM_GET_SHIP, {
				ships = var_2_0,
				callback = arg_2_0
			})

			return
		end)
	end

	local var_1_4 = {}

	ipairs = var_6
	getProxy = var_1_10007
	BagProxy = var_1_10008

	local var_1_5 = var_1_10007(var_1_10008)
	local var_1_6 = var_7.getItemsByType

	Item = var_1_10009

	for iter_1_0, iter_1_1 in var_6(var_1_6(var_1_5, var_1_10009.SKIN_ASSIGNED_TYPE)) do
		var_1_10012 = iter_1_1

		if not var_1_4[iter_1_1.getConfig(var_1_10012, "usage_arg")[1]] then
			var_1_10012 = {}
		end

		var_1_4[var_1_10011] = var_1_10012
		table = var_1_10012
		var_1_10012 = var_1_10012.insert

		local var_1_7 = var_1_4[var_1_10011]
		local var_1_8 = {}

		DROP_TYPE_ITEM = var_1_10015
		var_1_8.type = var_1_10015
		var_1_8.id = iter_1_1.id
		var_1_8.count = iter_1_1.count

		var_1_10012(var_1_7, var_1_8)
	end

	pairs = var_6

	for iter_1_2, iter_1_3 in var_6(var_1_4) do
		getProxy = var_1_10011
		ActivityProxy = var_1_10012
		var_1_10012 = var_1_10011(var_1_10012)

		if var_1_10011.getActivityById(var_1_10012, iter_1_2) then
			local var_1_9 = var_1_10011

			if not var_1_10011.isEnd(var_1_9) then
				PlayerPrefs = var_1_10012
				var_1_10012 = var_1_10012.GetInt
				string = var_1_9
				var_1_10012 = var_1_10012(var_1_9.format("skin_select_item_act_%d_last_time", iter_1_2), 3)

				local var_1_10 = var_1_10011.stopTime

				pg = var_14

				local var_1_11 = var_14.TimeMgr.GetInstance()
				local var_1_12 = var_1_10 - var_14.GetServerTime(var_1_11)

				math = var_14

				if var_14.floor(var_1_12 / 0) < var_1_10012 then
					table = var_14

					var_14.insert(var_1_2, function(arg_3_0)
						PlayerPrefs = var_2_10001

						local var_3_0 = var_2_10001.SetInt

						string = var_2_10002

						local var_3_1 = var_2_10002.format("skin_select_item_act_%d_last_time", var_1_10011.id)

						math = var_3

						var_3_0(var_3_1, var_3.floor(var_1_12 / 0))

						pg = var_3_0

						local var_3_2 = var_3_0.MsgboxMgr.GetInstance()
						local var_3_3 = var_1.ShowMsgBox
						local var_3_4 = {}

						MSGBOX_TYPE_ITEM_BOX = var_4
						var_3_4.type = var_4
						i18n = var_4

						local var_3_5 = "skin_exchange_timelimit"

						pg = var_2_10006

						local var_3_6 = var_2_10006.TimeMgr.GetInstance()

						var_3_4.content = var_4(var_3_5, var_6.STimeDescS(var_3_6, var_1_10011.stopTime, "%m.%d"))
						var_3_4.items = iter_1_3

						function var_3_4.onYes()
							pg = var_3_10000

							local var_4_0 = var_3_10000.m02
							local var_4_1 = var_0.sendNotification

							GAME = var_3_10002

							local var_4_2 = var_3_10002.GO_SCENE

							SCENE = var_3_10003

							local var_4_3 = var_3_10003.EQUIPSCENE
							local var_4_4 = {}

							StoreHouseConst = var_3_10005
							var_4_4.warp = var_3_10005.WARP_TO_MATERIAL

							var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

							return
						end

						i18n = var_4
						var_3_4.yesText = var_4("msgbox_text_forward")
						var_3_4.onNo = arg_3_0

						var_3_3(var_3_2, var_3_4)

						return
					end)
				end
			end
		end
	end

	getProxy = var_6
	MailProxy = var_7

	if not var_6(var_7).overTip then
		PlayerPrefs = var_7

		local var_1_13 = var_7.GetString("mail_msg_tips", "")

		pg = var_8

		local var_1_14 = var_8.TimeMgr.GetInstance()

		if var_1_13 ~= var_8.CurrentSTimeDesc(var_1_14, "%Y/%m/%d") then
			local var_1_15 = var_6.total

			MAIL_COUNT_LIMIT = var_8

			if var_8 < var_1_15 then
				PlayerPrefs = var_1_15

				local var_1_16 = var_1_15.SetString
				local var_1_17 = "mail_msg_tips"

				pg = var_1_14

				local var_1_18 = var_1_14.TimeMgr.GetInstance()

				var_1_16(var_1_17, var_9.CurrentSTimeDesc(var_1_18, "%Y/%m/%d"))

				table = var_1_16

				var_1_16.insert(var_1_2, function(arg_5_0)
					pg = var_2_10001

					local var_5_0 = var_2_10001.m02
					local var_5_1 = var_1.sendNotification

					GAME = var_2_10003

					local var_5_2 = var_2_10003.LOAD_LAYERS
					local var_5_3 = {}

					getProxy = var_2_10005
					ContextProxy = var_2_10006

					local var_5_4 = var_2_10005(var_2_10006)

					var_5_3.parentContext = var_5.getCurrentContext(var_5_4)
					Context = var_5

					local var_5_5 = var_5.New
					local var_5_6 = {}

					MailTipsWindowMediator = var_2_10007
					var_5_6.mediator = var_2_10007
					MailTipsLayer = var_2_10007
					var_5_6.viewComponent = var_2_10007

					local var_5_7 = {
						onYes = function()
							pg = var_3_10000

							local var_6_0 = var_3_10000.m02
							local var_6_1 = var_0.sendNotification

							GAME = var_3_10002

							local var_6_2 = var_3_10002.GO_SCENE

							SCENE = var_3_10003

							var_6_1(var_6_0, var_6_2, var_3_10003.MAIL)

							return
						end
					}

					i18n = var_8
					var_5_7.content = var_8("warning_mail_max_3", var_0.total)
					var_5_6.data = var_5_7
					var_5_3.context = var_5_5(var_5_6)

					var_5_1(var_5_0, var_5_2, var_5_3)

					return
				end)
			end
		end
	end

	var_6.overTip = true
	seriesAsync = var_7

	var_7(var_1_2, arg_1_1)

	return
end

return var_0_0
