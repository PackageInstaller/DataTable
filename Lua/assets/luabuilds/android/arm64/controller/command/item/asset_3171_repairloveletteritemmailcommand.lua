local RepairLoveLetterItemMailCommand = class("RepairLoveLetterItemMailCommand", pm.SimpleCommand)

function RepairLoveLetterItemMailCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.item_id
	local var_1_2 = var_1_0.group_id
	local var_1_3 = {
		item_id = var_1_0.item_id
	}

	var_1_3.year = var_1_0.year or 0
	var_1_3.groupid = var_1_0.group_id or 0

	pg.ConnectionMgr.GetInstance():Send(30018, var_1_3, 30019, function(arg_2_0)
		if arg_2_0.ret == 0 then
			getProxy(BagProxy):SetLoveLetterRepairInfo(var_1_1 .. "_" .. var_1_2, nil)
			getProxy(BagProxy):removeItemById(var_1_1, 1, var_1_2)

			getProxy(MailProxy).collectionIds = nil

			self:sendNotification(GAME.LOVE_ITEM_MAIL_REPAIR_DONE, {
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

return RepairLoveLetterItemMailCommand
