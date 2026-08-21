local var_0_0 = {
	trackingEntityIdList = {
		40003
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(40003)
		_GRAPH_API.ThingCreate(40006)
		_GRAPH_API.ThingCreate(40009)
		_GRAPH_API.ThingDestroy(40007)
	end,
	OnClickBubble_40003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(40003)
		_GRAPH_API.PlayCommonStory(104180601, function()
			_GRAPH_API.AddTag(11010702, 4)
			_GRAPH_API.GotoTag(11010702, 4)
		end)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 40003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[40003] = 1

return var_0_0
