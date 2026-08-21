local var_0_0 = class("DealMailOperationCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.cmd
	local var_1_2 = var_1_0.filter
	local var_1_3 = var_1_0.ignoreTips
	local var_1_4 = var_1_0.noAttachTip
	local var_1_5 = switch(var_1_0.filter.type, {
		all = function()
			return {}
		end,
		ids = function()
			return {
				{
					type = 1,
					arg_list = underscore.rest(var_1_2.list, 1)
				}
			}
		end,
		drops = function()
			for iter_4_0, iter_4_1 in ipairs(var_1_2.list) do
				if iter_4_1.type == DROP_TYPE_RESOURCE then
					table.insert({}, iter_4_1.id)
				elseif iter_4_1.type == DROP_TYPE_ITEM then
					table.insert({}, iter_4_1.id)
				else
					assert(false)
				end
			end

			return {
				{
					type = 2,
					arg_list = {}
				},
				{
					type = 3,
					arg_list = {}
				}
			}
		end
	})

	local function var_1_6(arg_5_0, arg_5_1)
		pg.ConnectionMgr.GetInstance():Send(30006, {
			cmd = table.indexof(MailProxy.DEAL_CMD_LIST, arg_5_0),
			match_list = var_1_5
		}, 30007, function(arg_6_0)
			if arg_6_0.result == 0 then
				local var_6_0 = getProxy(MailProxy)
				local var_6_1 = underscore.rest(arg_6_0.mail_id_list, 1)

				table.sort(var_6_1, CompareFuncs({
					function(arg_7_0)
						return -arg_7_0
					end
				}))

				for iter_6_0, iter_6_1 in ipairs(var_6_1) do
					var_6_0:DealMailOperation(iter_6_1, arg_5_0)
				end

				var_6_0:unpdateUnreadCount(arg_6_0.unread_number)
				arg_5_1(arg_6_0)
			elseif arg_6_0.result == 6 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("mail_moveto_markroom_max"))
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_6_0.result))
			end

			return
		end)

		return
	end

	local var_1_7 = {}

	if var_1_0.cmd == "attachment" or var_1_0.cmd == "move" then
		local var_1_8 = {}

		table.insert({}, function(arg_8_0, arg_8_1)
			local var_8_0 = CheckEquipLimit(arg_8_1)
			local var_8_1, var_8_2 = CheckOverflow(GetItemsOverflowDic(arg_8_1), true)

			if not var_8_1 then
				switch(var_8_2, {
					gold = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("gold_max_tip_title"))

						return
					end,
					oil = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("oil_max_tip_title"))

						return
					end,
					equip = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("mail_takeAttachment_error_magazine_full"))

						return
					end,
					ship = function()
						pg.TipsMgr.GetInstance():ShowTips(i18n("mail_takeAttachment_error_dockYrad_full"))

						return
					end
				})
			else
				if var_8_0 then
					for iter_8_0, iter_8_1 in ipairs(var_8_0) do
						table.insert({}, Drop.New({
							type = DROP_TYPE_EQUIP,
							id = iter_8_1[1],
							count = iter_8_1[2]
						}))
					end

					arg_1_0:sendNotification(GAME.MAIL_DOUBLE_CONFIREMATION_MSGBOX, {
						content = "mail_takeAttachment_error_equipment_overlimit",
						type = MailProxy.MailMessageBoxType.ReDropConfirm,
						onYes = function()
							arg_8_0(var_8_2)

							return
						end,
						dropList = {}
					})

					return
				end

				arg_8_0(var_8_2)
			end

			return
		end)
		table.insert(var_1_8, function(arg_14_0, arg_14_1)
			if arg_14_1.isStoreOverflow then
				table.insert(var_1_8, function(arg_15_0)
					local var_15_0, var_15_1 = unpack(arg_14_1.isStoreOverflow)

					if var_15_0 > 0 then
						table.insert({}, Drop.New({
							type = DROP_TYPE_RESOURCE,
							id = PlayerConst.ResGold,
							count = var_15_0
						}))
					end

					if var_15_1 > 0 then
						table.insert({}, Drop.New({
							type = DROP_TYPE_RESOURCE,
							id = PlayerConst.ResOil,
							count = var_15_1
						}))
					end

					arg_1_0:sendNotification(GAME.MAIL_DOUBLE_CONFIREMATION_MSGBOX, {
						type = MailProxy.MailMessageBoxType.OverflowConfirm,
						content = i18n("mail_storeroom_max_1"),
						onYes = arg_15_0,
						dropList = {}
					})

					return
				end)
			end

			for iter_14_0, iter_14_1 in ipairs(arg_14_1.isExpBookOverflow) do
				table.insert(var_1_8, function(arg_16_0)
					arg_1_0:sendNotification(GAME.MAIL_DOUBLE_CONFIREMATION_MSGBOX, {
						type = MailProxy.MailMessageBoxType.ShowTips,
						content = i18n("player_expResource_mail_overflow", Item.getConfigData(iter_14_1).name),
						onYes = arg_16_0
					})

					return
				end)
			end

			arg_14_0()

			return
		end)

		if var_1_0.filter.type == "ids" then
			table.insert(var_1_7, function(arg_17_0)
				arg_17_0(getProxy(MailProxy):GetMailsAttachments(var_1_2.list), var_1_2.list)

				return
			end)
		else
			table.insert(var_1_7, function(arg_18_0)
				var_1_6("overflow", arg_18_0)

				return
			end)
			table.insert(var_1_7, function(arg_19_0, arg_19_1)
				arg_19_0(underscore.map(arg_19_1.drop_list, function(arg_20_0)
					return Drop.New({
						type = arg_20_0.type,
						id = arg_20_0.id,
						count = arg_20_0.number
					})
				end), arg_19_1.mail_id_list)

				return
			end)
		end

		if not var_1_4 then
			table.insert(var_1_7, function(arg_21_0, arg_21_1, arg_21_2)
				if #arg_21_2 > 0 then
					arg_1_0:sendNotification(GAME.MAIL_DOUBLE_CONFIREMATION_MSGBOX, {
						type = MailProxy.MailMessageBoxType.ReceiveAward,
						content = i18n("mail_take_all_mail_msgbox"),
						onYes = function()
							arg_21_0(arg_21_1)

							return
						end,
						items = arg_21_1,
						mailids = arg_21_2
					})
				else
					arg_1_0:sendNotification(GAME.MAIL_DOUBLE_CONFIREMATION_MSGBOX, {
						type = MailProxy.MailMessageBoxType.ShowTips,
						content = i18n("mail_manage_3")
					})
				end

				return
			end)
		end

		table.insert(var_1_7, function(arg_23_0, arg_23_1)
			if arg_23_1 and #arg_23_1 > 0 then
				seriesAsyncExtend(var_1_8, arg_23_0, arg_23_1)
			else
				arg_23_0()
			end

			return
		end)
	end

	table.insert(var_1_7, function(arg_24_0)
		var_1_6(var_1_1, arg_24_0)

		return
	end)
	seriesAsync(var_1_7, function(arg_25_0)
		arg_1_0:sendNotification(GAME.DEAL_MAIL_OPERATION_DONE, {
			cmd = var_1_1,
			ids = underscore.rest(arg_25_0.mail_id_list, 1),
			items = PlayerConst.addTranDrop(arg_25_0.drop_list),
			ignoreTips = var_1_3
		})

		return
	end)

	return
end

return var_0_0
