return {
	trackingEntityIdList = {
		30048
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30048)
		_GRAPH_API.EntityInteractDisable(30048)
		_GRAPH_API.CreateDrop(40004, false, function()
			_GRAPH_API.PlayStory(10016, function()
				_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
			end, 30048)
			_GRAPH_API.EntityInteractEnable(30048)
		end)
	end
}
