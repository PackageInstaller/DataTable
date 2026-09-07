local VoteScheduleMediator = class("VoteScheduleMediator", import("view.base.ContextMediator"))

VoteScheduleMediator.GO_RANK = "VoteScheduleMediator:GO_RANK"
VoteScheduleMediator.FETCH_RANK = "VoteScheduleMediator:FETCH_RANK"
VoteScheduleMediator.ON_VOTE = "VoteScheduleMediator:ON_VOTE"

function VoteScheduleMediator:register()
	self:bind(VoteScheduleMediator.ON_VOTE, function()
		local var_2_0 = getProxy(VoteProxy):GetOpeningNonFunVoteGroup()

		var_2_0 = var_2_0 or getProxy(VoteProxy):GetOpeningFunVoteGroup()

		if not var_2_0 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_notStartOrEnd"))

			return
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.VOTE, {
			voteGroup = var_2_0
		})

		return
	end)
	self:bind(VoteScheduleMediator.FETCH_RANK, function(arg_3_0, arg_3_1, arg_3_2)
		self:sendNotification(GAME.FETCH_VOTE_RANK, {
			voteId = arg_3_1,
			callback = arg_3_2
		})

		return
	end)
	self:bind(VoteScheduleMediator.GO_RANK, function(arg_4_0, arg_4_1)
		seriesAsync({
			function(arg_5_0)
				self:CheckPaintingRes(arg_4_1, arg_5_0)

				return
			end
		}, function()
			self:addSubLayers(Context.New({
				mediator = ContextMediator,
				viewComponent = VoteRankScene,
				data = {
					voteGroup = arg_4_1
				}
			}))

			return
		end)

		return
	end)

	return
end

function VoteScheduleMediator:CheckPaintingRes(arg_7_1, arg_7_2)
	if arg_7_1 and arg_7_1:isFinalsRace() or arg_7_1:IsFunRace() then
		local var_7_0 = arg_7_1:GetRankList()
		local var_7_1 = {}

		for iter_7_0, iter_7_1 in ipairs({
			var_7_0[1]:getPainting(),
			var_7_0[2]:getPainting(),
			(var_7_0[3]:getPainting())
		}) do
			PaintingGroupConst.AddPaintingNameWithFilteMap(var_7_1, iter_7_1)
		end

		PaintingGroupConst.PaintingDownload({
			isShowBox = true,
			paintingNameList = var_7_1,
			finishFunc = arg_7_2
		})
	else
		arg_7_2()
	end

	return
end

function VoteScheduleMediator:listNotificationInterests()
	return {}
end

function VoteScheduleMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	return
end

return VoteScheduleMediator
