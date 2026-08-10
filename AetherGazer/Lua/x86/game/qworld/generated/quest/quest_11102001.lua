return {
	trackingEntityIdList = {
		10004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.PlayStory(11004, function()
			_GRAPH_API.ThingCreate(10004)
			_GRAPH_API.FollowNpc(10004, 10005, 0, 5, function()
				return
			end, function()
				_GRAPH_API.PlayTalk(11005006, function()
					return
				end)
				_GRAPH_API.ThingCreate(10004)
				_GRAPH_API.FollowNpc(10004, 10016, 1, 5, function()
					return
				end, function()
					_GRAPH_API.ThingDestroy(10004)
					_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
				end)
			end, {
				enableInteraction = true,
				mode = 3
			})
			_GRAPH_API.PlayTalkList({
				11005001,
				11005002,
				11005003,
				11005004,
				11005005
			}, function()
				return
			end)
		end, nil)
	end
}
