local ComposeItemCommand = class("ComposeItemCommand", pm.SimpleCommand)

function ComposeItemCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.id
	local var_1_2 = var_1_0.count
	local var_1_3 = getProxy(BagProxy)
	local var_1_4 = var_1_3:getItemById(var_1_0.id)

	if var_1_0.count == 0 then
		return
	end

	local var_1_5 = var_1_4:getConfig("target_id")
	local var_1_6 = var_1_4:getConfig("compose_number")

	if var_1_0.count > var_1_4.count / var_1_6 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(15006, {
		id = var_1_0.id,
		num = var_1_0.count
	}, 15007, function(arg_2_0)
		if arg_2_0.result == 0 then
			var_1_3:removeItemById(var_1_1, var_1_2 * var_1_6)

			local var_2_0 = Drop.New({
				type = DROP_TYPE_ITEM,
				id = var_1_5,
				count = var_1_2
			})

			self:sendNotification(GAME.ADD_ITEM, var_2_0)
			self:sendNotification(GAME.USE_ITEM_DONE, {
				drops = {
					var_2_0
				}
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.result))
		end

		return
	end)

	return
end

return ComposeItemCommand
