local IslandUpdateAchvCommand = class("IslandUpdateAchvCommand", pm.SimpleCommand)

function IslandUpdateAchvCommand:execute(arg_1_1)
	pg.ConnectionMgr.GetInstance():Send(21052, {
		event_list = arg_1_1:getBody().records
	})

	return
end

return IslandUpdateAchvCommand
