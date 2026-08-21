local var_0_0 = {
	trackingEntityIdList = {
		60006
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(60008)
		_GRAPH_API.ThingCreate(60009)
		_GRAPH_API.ThingCreate(60010)
		_GRAPH_API.ThingCreate(60015)
		_GRAPH_API.ZoneEnable(60006)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(60008)
		_GRAPH_API.ThingDestroy(60009)
		_GRAPH_API.ThingDestroy(60010)
		_GRAPH_API.ThingDestroy(60015)
	end,
	OnEnterZone_60006 = function(arg_3_0)
		_GRAPH_API.ZoneDisable(60006)
		_GRAPH_API.AddTag(11010703, 4)
		_GRAPH_API.PlayStory(11038, function()
			return
		end, 4)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 60006)

return var_0_0
