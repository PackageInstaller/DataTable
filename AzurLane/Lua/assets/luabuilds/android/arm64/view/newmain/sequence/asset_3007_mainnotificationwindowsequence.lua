class = var_0_10000

local var_0_0 = var_0_10000("MainNotificationWindowSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.getData(var_1_0)
	local var_1_2 = {}
	local var_1_3 = #var_1_1.buildShipNotification

	if 0 < var_1_3 then
		table = var_1_3

		var_1_3.insert(var_1_2, function(arg_2_0)
			local var_2_0 = {}

			getProxy = var_2_10002
			BayProxy = var_2_10004

			local var_2_1 = var_2_10002(var_2_10004)

			ipairs = var_2_10003
			getProxy = var_2_10005
			PlayerProxy = var_2_10007

			local var_2_2 = var_2_10005(var_2_10007)

			for iter_2_0, iter_2_1 in var_2_10003(var_5.getRawData(var_2_2).buildShipNotification) do
				if var_2_1:getShipById(iter_2_1.uid) then
					var_8.virgin = iter_2_1.new
					table = var_2_10009

					var_2_10009.insert(var_2_0, var_8)
				else
					pg = var_2_10009

					local var_2_3 = var_2_10009.TipsMgr.GetInstance()

					var_2_10009.ShowTips(var_2_3, "without ship data from uid:" .. iter_2_1.uid)
				end
			end

			pg = var_3

			local var_2_4 = var_3.m02
			local var_2_5 = var_3.sendNotification

			GAME = iter_2_0

			var_2_5(var_2_4, iter_2_0.CONFIRM_GET_SHIP, {
				ships = var_2_0,
				callback = arg_2_0
			})

			return
		end)
	end

	local var_1_4 = {}

	ipairs = var_6
	getProxy = var_1_10008
	BagProxy = var_1_10010

	local var_1_5 = var_1_10008(var_1_10010)
	local var_1_6 = var_8.getItemsByType

	Item = var_1_10011

	for iter_1_0, iter_1_1 in var_6(var_1_6(var_1_5, var_1_10011.SKIN_ASSIGNED_TYPE)) do
		var_1_10013 = iter_1_1

		local var_1_7

		if not var_1_4[iter_1_1.getConfig(var_1_10013, "usage_arg")[1]] then
			var_1_7 = {}
		end

		var_1_4[var_11] = var_1_7
		table = var_1_7

		local var_1_8 = var_1_7.insert
		local var_1_9 = var_1_4[var_11]
		local var_1_10 = {}

		DROP_TYPE_ITEM = var_1_10016
		var_1_10.type = var_1_10016
		var_1_10.id = iter_1_1.id
		var_1_10.count = iter_1_1.count

		var_1_8(var_1_9, var_1_10)
	end

	pairs = var_6

	for iter_1_2, iter_1_3 in var_6(var_1_4) do
		getProxy = var_11
		ActivityProxy = var_1_10013
		var_1_10013 = var_11(var_1_10013)

		if var_11.getActivityById(var_1_10013, iter_1_2) then
			local var_1_11 = var_11

			if not var_11.isEnd(var_1_11) then
				PlayerPrefs = var_12

				local var_1_12 = var_12.GetInt

				string = var_1_11

				local var_1_13 = var_1_12(var_1_11.format("skin_select_item_act_%d_last_time", iter_1_2), 3)

				var_1_10013 = var_11.stopTime
				pg = var_14

				local var_1_14 = var_14.TimeMgr.GetInstance()

				var_1_10013 = var_1_10013 - var_14.GetServerTime(var_1_14)
				math = var_14

				if var_14.floor(var_1_10013 / 0) < var_1_13 then
					table = var_14

					var_14.insert(var_1_2, function(arg_3_0)
						PlayerPrefs = var_2_10001

						local var_3_0 = var_2_10001.SetInt

						string = var_2_10003

						local var_3_1 = var_2_10003.format("skin_select_item_act_%d_last_time", var_0.id)

						math = var_2_10004

						var_3_0(var_3_1, var_2_10004.floor(var_1_10013 / 0))

						pg = var_3_0

						local var_3_2 = var_3_0.MsgboxMgr.GetInstance()
						local var_3_3 = var_1.ShowMsgBox
						local var_3_4 = {}

						MSGBOX_TYPE_ITEM_BOX = var_5
						var_3_4.type = var_5
						i18n = var_5

						local var_3_5 = "skin_exchange_timelimit"

						pg = var_2_10008

						local var_3_6 = var_2_10008.TimeMgr.GetInstance()

						var_3_4.content = var_5(var_3_5, var_8.STimeDescS(var_3_6, var_0.stopTime, "%m.%d"))
						var_3_4.items = iter_1_3

						function var_3_4.onYes()
							pg = var_3_10000

							local var_4_0 = var_3_10000.m02
							local var_4_1 = var_0.sendNotification

							GAME = var_3_10003

							local var_4_2 = var_3_10003.GO_SCENE

							SCENE = var_3_10004

							local var_4_3 = var_3_10004.EQUIPSCENE
							local var_4_4 = {}

							StoreHouseConst = var_3_10006
							var_4_4.warp = var_3_10006.WARP_TO_MATERIAL

							var_4_1(var_4_0, var_4_2, var_4_3, var_4_4)

							return
						end

						i18n = var_5
						var_3_4.yesText = var_5("msgbox_text_forward")
						var_3_4.onNo = arg_3_0

						var_3_3(var_3_2, var_3_4)

						return
					end)
				end
			end
		end
	end

	getProxy = var_6
	MailProxy = var_8

	if not var_6(var_8).overTip then
		PlayerPrefs = var_7

		local var_1_15 = var_7.GetString("mail_msg_tips", "")

		pg = var_8

		local var_1_16 = var_8.TimeMgr.GetInstance()

		if var_1_15 ~= var_8.CurrentSTimeDesc(var_1_16, "%Y/%m/%d") then
			local var_1_17 = var_6.total

			MAIL_COUNT_LIMIT = var_8

			if var_8 < var_1_17 then
				PlayerPrefs = var_1_17

				local var_1_18 = var_1_17.SetString
				local var_1_19 = "mail_msg_tips"

				pg = var_1_16

				local var_1_20 = var_1_16.TimeMgr.GetInstance()

				var_1_18(var_1_19, var_10.CurrentSTimeDesc(var_1_20, "%Y/%m/%d"))

				table = var_1_18

				var_1_18.insert(var_1_2, function(arg_5_0)
					pg = var_2_10001

					local var_5_0 = var_2_10001.m02
					local var_5_1 = var_1.sendNotification

					GAME = var_2_10004

					local var_5_2 = var_2_10004.LOAD_LAYERS
					local var_5_3 = {}

					getProxy = var_2_10006
					ContextProxy = var_2_10008

					local var_5_4 = var_2_10006(var_2_10008)

					var_5_3.parentContext = var_6.getCurrentContext(var_5_4)
					Context = var_6

					local var_5_5 = var_6.New
					local var_5_6 = {}

					MailTipsWindowMediator = var_2_10009
					var_5_6.mediator = var_2_10009
					MailTipsLayer = var_2_10009
					var_5_6.viewComponent = var_2_10009

					local var_5_7 = {
						onYes = function()
							pg = var_3_10000

							local var_6_0 = var_3_10000.m02
							local var_6_1 = var_0.sendNotification

							GAME = var_3_10003

							local var_6_2 = var_3_10003.GO_SCENE

							SCENE = var_3_10004

							var_6_1(var_6_0, var_6_2, var_3_10004.MAIL)

							return
						end
					}

					i18n = var_10
					var_5_7.content = var_10("warning_mail_max_3", var_0.total)
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
