local var_0_0 = {
	trackingEntityIdList = {
		10004
	},
	OnClickBubble_10004 = function(arg_1_0)
		_GRAPH_API.AddTag(11010701, 4)
		_GRAPH_API.PlayStory(11003, function()
			return
		end, 4)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 10004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[10004] = 1

function var_0_0.OnQuestUnmeet(arg_3_0)
	_GRAPH_API.ThingCreate(10004)
end

return var_0_0
