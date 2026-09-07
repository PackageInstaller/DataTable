local CheckLoveLetterItemMailCommand = class("CheckLoveLetterItemMailCommand", pm.SimpleCommand)

function CheckLoveLetterItemMailCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.item_id
	local var_1_2 = var_1_0.group_id

	pg.ConnectionMgr.GetInstance():Send(30016, {
		item_id = var_1_0.item_id,
		groupid = var_1_0.group_id
	}, 30017, function(arg_2_0)
		local var_2_0 = underscore.rest(arg_2_0.years, 1)

		getProxy(BagProxy):SetLoveLetterRepairInfo(var_1_1 .. "_" .. var_1_2, var_2_0)

		if #var_2_0 == 0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_recover_tip7"))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_recover_tip6", table.concat(var_2_0, "、")))
		end

		self:sendNotification(GAME.LOVE_ITEM_MAIL_CHECK_DONE, {
			itemId = var_1_1,
			groupId = var_1_2,
			list = var_2_0
		})

		return
	end)

	return
end

return CheckLoveLetterItemMailCommand
