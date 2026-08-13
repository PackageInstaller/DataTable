class = var_0_10000

local var_0_0 = "VoteScheduleMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GO_RANK = "VoteScheduleMediator:GO_RANK"
var_0_1.FETCH_RANK = "VoteScheduleMediator:FETCH_RANK"
var_0_1.ON_VOTE = "VoteScheduleMediator:ON_VOTE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_VOTE, function()
		getProxy = var_2_10000
		VoteProxy = var_2_10002

		local var_2_0 = var_2_10000(var_2_10002)
		local var_2_2

		if not var_0.GetOpeningNonFunVoteGroup(var_2_0) then
			getProxy = var_2_2
			VoteProxy = var_2_0

			local var_2_1 = var_2_2(var_2_0)

			var_2_2 = var_2_2.GetOpeningFunVoteGroup(var_2_1)
		end

		if not var_2_2 then
			pg = var_2_10001

			local var_2_3 = var_2_10001.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			i18n = var_2_10004

			var_2_4(var_2_3, var_2_10004("common_activity_notStartOrEnd"))

			return
		end

		local var_2_5 = arg_1_0
		local var_2_6 = var_1.sendNotification

		GAME = var_2_10004

		local var_2_7 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_2_6(var_2_5, var_2_7, var_2_10005.VOTE, {
			voteGroup = var_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.FETCH_RANK, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.FETCH_VOTE_RANK, {
			voteId = arg_3_1,
			callback = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_RANK, function(arg_4_0, arg_4_1)
		seriesAsync = var_2_10002

		var_2_10002({
			function(arg_5_0)
				local var_5_0 = arg_1_0

				var_1.CheckPaintingRes(var_5_0, arg_4_1, arg_5_0)

				return
			end
		}, function()
			local var_6_0 = arg_1_0
			local var_6_1 = var_0.addSubLayers

			Context = var_3_10003

			local var_6_2 = var_3_10003.New
			local var_6_3 = {}

			ContextMediator = var_3_10006
			var_6_3.mediator = var_3_10006
			VoteRankScene = var_3_10006
			var_6_3.viewComponent = var_3_10006
			var_6_3.data = {
				voteGroup = arg_4_1
			}

			var_6_1(var_6_0, var_6_2(var_6_3))

			return
		end)

		return
	end)

	return
end

function var_0_1.CheckPaintingRes(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 and arg_7_1:isFinalsRace() or arg_7_1:IsFunRace() then
		local var_7_0 = arg_7_1:GetRankList()[1]
		local var_7_1 = var_3[2]
		local var_7_2 = var_3[3]
		local var_7_3 = var_7_0:getPainting()
		local var_7_4 = var_7_1:getPainting()
		local var_7_5 = var_7_2:getPainting()
		local var_7_6 = {
			var_7_3,
			var_7_4,
			var_7_5
		}
		local var_7_7 = {}

		ipairs = var_1_10012

		for iter_7_0, iter_7_1 in var_1_10012(var_7_6) do
			PaintingGroupConst = var_1_10017

			var_1_10017.AddPaintingNameWithFilteMap(var_7_7, iter_7_1)
		end

		PaintingGroupConst = var_12

		var_12.PaintingDownload({
			isShowBox = true,
			paintingNameList = var_7_7,
			finishFunc = arg_7_2
		})
	else
		arg_7_2()
	end

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	return {}
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	return
end

return var_0_1
