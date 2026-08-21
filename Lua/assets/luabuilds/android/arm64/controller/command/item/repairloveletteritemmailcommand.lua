local var_0_0 = class("RepairLoveLetterItemMailCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.group_id

	;({
		item_id = var_1_0.item_id
	}).year = var_1_0.year or 0
	;({
		item_id = var_1_0.item_id
	}).groupid = var_1_0.group_id or 0

	pg.ConnectionMgr.GetInstance():Send(30018, {
		item_id = var_1_0.item_id
	}, 30019, function(arg_2_0)
		if arg_2_0.ret == 0 then
			getProxy(BagProxy):SetLoveLetterRepairInfo(var_0 .. "_" .. var_1_1, nil)
			getProxy(BagProxy):removeItemById(var_0, 1, var_1_1)

			getProxy(MailProxy).collectionIds = nil

			arg_1_0:sendNotification(GAME.LOVE_ITEM_MAIL_REPAIR_DONE, {
				awards = underscore.filter(PlayerConst.addTranDrop(arg_2_0.drop_list), function(arg_3_0)
					return not arg_3_0:isLoveLetter()
				end)
			})
		elseif arg_2_0.ret == 6 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_recover_tip5"))
		elseif arg_2_0.ret == 7 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("loveletter_recover_tip3"))
		elseif arg_2_0.ret == 40 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("player_harvestResource_error_fullBag"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.ret))
		end

		return
	end)

	return
end

return var_0_0
