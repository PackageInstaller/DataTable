local var_0_0 = class("GetCompensateRewardCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_2 = var_1_0.reward_id

	local function var_1_3(arg_2_0)
		pg.ConnectionMgr.GetInstance():Send(30104, {
			reward_id = var_1_0.reward_id
		}, 30105, function(arg_3_0)
			if arg_3_0.result == 0 then
				local var_3_0 = getProxy(CompensateProxy)

				var_3_0:DealMailOperation(var_1_2)
				var_3_0:unpdateLatestTime(arg_3_0.max_timestamp)
				var_3_0:unpdateUnreadCount(arg_3_0.number)
				arg_2_0(arg_3_0)
			elseif arg_3_0.result == 6 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("mail_moveto_markroom_max"))
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_3_0.result))
			end

			return
		end)

		return
	end

	local var_1_4 = {}

	table.insert({}, function(arg_4_0, arg_4_1)
		local var_4_0, var_4_1 = CheckOverflow((GetItemsOverflowDic(arg_4_1)))

		if not var_4_0 then
			switch(var_4_1, {
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
			arg_4_0(var_4_1)
		end

		return
	end)
	table.insert({}, function(arg_9_0, arg_9_1)
		for iter_9_0, iter_9_1 in ipairs(arg_9_1.isExpBookOverflow) do
			table.insert(var_1_4, function(arg_10_0)
				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("player_expResource_mail_overflow", Item.getConfigData(iter_9_1).name),
					onYes = arg_10_0
				})

				return
			end)
		end

		arg_9_0()

		return
	end)
	table.insert({}, function(arg_11_0)
		arg_11_0(getProxy(CompensateProxy):GetCompensateAttachments(var_1_2))

		return
	end)
	table.insert({}, function(arg_12_0, arg_12_1)
		if arg_12_1 and #arg_12_1 > 0 then
			seriesAsyncExtend(var_1_4, arg_12_0, arg_12_1)
		else
			arg_12_0()
		end

		return
	end)
	table.insert({}, function(arg_13_0)
		var_1_3(arg_13_0)

		return
	end)
	seriesAsync({}, function(arg_14_0)
		arg_1_0:sendNotification(GAME.DEAL_COMPENSATE_REWARD_DONE, {
			items = PlayerConst.addTranDrop(arg_14_0.drop_list)
		})

		return
	end)

	return
end

return var_0_0
