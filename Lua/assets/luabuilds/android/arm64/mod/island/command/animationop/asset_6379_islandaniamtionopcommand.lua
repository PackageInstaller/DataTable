local IslandAniamtionOpCommand = class("IslandAniamtionOpCommand", pm.SimpleCommand)

function IslandAniamtionOpCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()

	pg.ConnectionMgr.GetInstance():Send(21700, {
		island_id = var_1_0.islandId,
		target_id = var_1_0.targetId,
		action_id = var_1_0.actionId
	})

	return
end

return IslandAniamtionOpCommand
