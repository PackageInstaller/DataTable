local MainNotificationWindowSequence = class("MainNotificationWindowSequence")

function MainNotificationWindowSequence:Execute(arg_1_1)
	local var_1_0 = {}

	if #getProxy(PlayerProxy):getData().buildShipNotification > 0 then
		table.insert(var_1_0, function(arg_2_0)
			local var_2_0 = {}
			local var_2_1 = getProxy(BayProxy)

			for iter_2_0, iter_2_1 in ipairs(getProxy(PlayerProxy):getRawData().buildShipNotification) do
				local var_2_2 = var_2_1:getShipById(iter_2_1.uid)

				if var_2_2 then
					var_2_2.virgin = iter_2_1.new

					table.insert(var_2_0, var_2_2)
				else
					pg.TipsMgr.GetInstance():ShowTips("without ship data from uid:" .. iter_2_1.uid)
				end
			end

			pg.m02:sendNotification(GAME.CONFIRM_GET_SHIP, {
				ships = var_2_0,
				callback = arg_2_0
			})

			return
		end)
	end

	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(getProxy(BagProxy):getItemsByType(Item.SKIN_ASSIGNED_TYPE)) do
		local var_1_2 = iter_1_1:getConfig("usage_arg")[1]

		var_1_1[var_1_2] = var_1_1[var_1_2] or {}

		table.insert(var_1_1[var_1_2], {
			type = DROP_TYPE_ITEM,
			id = iter_1_1.id,
			count = iter_1_1.count
		})
	end

	for iter_1_2, iter_1_3 in pairs(var_1_1) do
		local var_1_3 = getProxy(ActivityProxy):getActivityById(iter_1_2)

		if var_1_3 and not var_1_3:isEnd() then
			local var_1_4 = var_1_3.stopTime - pg.TimeMgr.GetInstance():GetServerTime()

			if PlayerPrefs.GetInt(string.format("skin_select_item_act_%d_last_time", iter_1_2), 3) > math.floor(var_1_4 / 0) then
				table.insert(var_1_0, function(arg_3_0)
					PlayerPrefs.SetInt(string.format("skin_select_item_act_%d_last_time", var_1_3.id), math.floor(var_1_4 / 0))

					local var_3_0 = {
						type = MSGBOX_TYPE_ITEM_BOX
					}

					var_3_0.content = i18n("skin_exchange_timelimit", pg.TimeMgr.GetInstance():STimeDescS(var_1_3.stopTime, "%m.%d"))
					var_3_0.items = iter_1_3

					function var_3_0.onYes()
						pg.m02:sendNotification(GAME.GO_SCENE, SCENE.EQUIPSCENE, {
							warp = StoreHouseConst.WARP_TO_MATERIAL
						})

						return
					end

					var_3_0.yesText = i18n("msgbox_text_forward")
					var_3_0.onNo = arg_3_0

					pg.MsgboxMgr.GetInstance():ShowMsgBox(var_3_0)

					return
				end)
			end
		end
	end

	local var_1_5 = getProxy(MailProxy)

	if not var_1_5.overTip then
		if PlayerPrefs.GetString("mail_msg_tips", "") ~= pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d") and var_1_5.total > MAIL_COUNT_LIMIT then
			PlayerPrefs.SetString("mail_msg_tips", pg.TimeMgr.GetInstance():CurrentSTimeDesc("%Y/%m/%d"))
			table.insert(var_1_0, function(arg_5_0)
				local var_5_0 = {}

				var_5_0.parentContext = getProxy(ContextProxy):getCurrentContext()
				var_5_0.context = Context.New({
					mediator = MailTipsWindowMediator,
					viewComponent = MailTipsLayer,
					data = {
						onYes = function()
							pg.m02:sendNotification(GAME.GO_SCENE, SCENE.MAIL)

							return
						end,
						content = i18n("warning_mail_max_3", var_1_5.total)
					}
				})

				pg.m02:sendNotification(GAME.LOAD_LAYERS, var_5_0)

				return
			end)
		end
	end

	var_1_5.overTip = true

	seriesAsync(var_1_0, arg_1_1)

	return
end

return MainNotificationWindowSequence
