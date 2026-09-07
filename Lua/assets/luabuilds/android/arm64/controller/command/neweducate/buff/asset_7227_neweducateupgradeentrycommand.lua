local NewEducateUpgradeEntryCommand = class("NewEducateUpgradeEntryCommand", pm.SimpleCommand)

function NewEducateUpgradeEntryCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.entryId

	pg.ConnectionMgr.GetInstance():Send(29122, {
		id = var_1_0.id,
		affixid = var_1_0.entryId
	}, 29123, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(NewEducateProxy):GetCurChar():GetFSM()

			var_2_0:GetPriorityState():MarkFinish()
			var_2_0:CheckPriorityStystem()
			self:sendNotification(GAME.NEW_EDUCATE_UPGRADE_ENTRY_DONE, {
				entryId = var_1_1,
				drops = NewEducateDropHelper.HandleDrops(arg_2_0.drop)
			})
		else
			pg.TipsMgr.GetInstance():ShowTips("NewEducate_UpgradeEntry_Error: " .. arg_2_0.result)
		end

		return
	end)

	return
end

return NewEducateUpgradeEntryCommand
