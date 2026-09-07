local EducateUpgradeFavorCommand = class("EducateUpgradeFavorCommand", pm.SimpleCommand)

function EducateUpgradeFavorCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback
	local var_1_2 = getProxy(EducateProxy):GetCharData():GetFavorPerformIds()

	pg.ConnectionMgr.GetInstance():Send(27006, {
		type = 0
	}, 27007, function(arg_2_0)
		if arg_2_0.result == 0 then
			EducateHelper.UpdateDropsData(arg_2_0.drops)
			getProxy(EducateProxy):GetCharData():UpgradeFavor()
			self:sendNotification(GAME.EDUCATE_UPGRADE_FAVOR_DONE, {
				drops = arg_2_0.drops,
				performs = var_1_2,
				cb = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("educate upgrad favor error: ", arg_2_0.result))
		end

		return
	end)

	return
end

return EducateUpgradeFavorCommand
