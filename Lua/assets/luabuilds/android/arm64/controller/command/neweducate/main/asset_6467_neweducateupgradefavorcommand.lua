local NewEducateUpgradeFavorCommand = class("NewEducateUpgradeFavorCommand", pm.SimpleCommand)

function NewEducateUpgradeFavorCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	if getProxy(NewEducateProxy):GetCurChar():GetFSM():CheckPriorityStystem() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("child2_priority_tip"))

		return
	end

	pg.ConnectionMgr.GetInstance():Send(29027, {
		id = var_1_0.id
	}, 29028, function(arg_2_0)
		if arg_2_0.result == 0 then
			getProxy(NewEducateProxy):GetCurChar():UpgradeFavor()
			self:sendNotification(GAME.NEW_EDUCATE_UPGRADE_FAVOR_DONE, {
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop),
				callback = var_1_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_UpgradeFavor: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateUpgradeFavorCommand
