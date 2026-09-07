local IslandSyncCommand = class("IslandSyncCommand", pm.SimpleCommand)

local function var_0_1(...)
	return
end

function IslandSyncCommand:execute(arg_2_1)
	local var_2_0 = arg_2_1:getBody()

	var_0_1("send")
	_.each(var_2_0.data, function(arg_4_0)
		var_0_1(arg_4_0:toString())

		return
	end)
	pg.ConnectionMgr.GetInstance():Send(21211, {
		island_id = var_2_0.islandId,
		sync_ob_list = _.map(var_2_0.data, function(arg_3_0)
			return arg_3_0:Pack()
		end)
	})

	return
end

return IslandSyncCommand
