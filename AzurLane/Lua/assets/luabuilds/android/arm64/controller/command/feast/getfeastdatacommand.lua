class = var_0_10000

local var_0_0 = "GetFeastDataCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = var_2.activityId

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 26156, {
		act_id = var_1_1
	}, 26157, function(arg_2_0)
		local var_2_0

		if arg_2_0.ret == 0 then
			FeastDorm = var_2_0
			var_2_0 = var_2_0.New({
				id = 4
			}, arg_2_0)
			var_2_10004 = arg_1_0

			var_2.FixStoryList(var_2_10004, var_2_0)

			getProxy = var_2
			FeastProxy = var_2_10004
			var_2_10004 = var_2(var_2_10004)

			var_2.SetData(var_2_10004, var_2_0)

			var_2_10004 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_5

			var_2_1(var_2_10004, var_5.GET_FEAST_DATA_DONE)
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_2_3(var_2_2, var_2_10004[arg_2_0.result] .. arg_2_0.result)
		end

		if var_1_0 then
			var_1_0()
		end

		return
	end)

	return
end

function var_0_1.FixStoryList(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1
	local var_3_1 = arg_3_1.GetInvitedFeastShips(var_3_0)
	local var_3_2 = {}

	pairs = var_3_0

	for iter_3_0, iter_3_1 in var_3_0(var_3_1) do
		var_1_10011 = iter_3_1

		if iter_3_1.GotTicket(var_1_10011) then
			table = var_9

			var_9.insert(var_3_2, iter_3_1:GetInvitationStory())
		end

		var_1_10011 = iter_3_1

		if iter_3_1.GotGift(var_1_10011) then
			table = var_9

			var_9.insert(var_3_2, iter_3_1:GetGiftStory())
		end
	end

	if #var_3_2 <= 0 then
		return
	end

	local var_3_3 = {}

	pairs = var_5

	for iter_3_2, iter_3_3 in var_5(var_3_2) do
		pg = var_1_10010

		local var_3_4 = var_1_10010.NewStoryMgr.GetInstance()

		if not var_1_10010.IsPlayed(var_3_4, iter_3_3) then
			table = var_1_10011

			var_1_10011.insert(var_3_3, iter_3_3)
		end
	end

	if #var_3_3 > 0 then
		ipairs = var_5

		for iter_3_4, iter_3_5 in var_5(var_3_3) do
			pg = var_1_10010

			local var_3_5 = var_1_10010.m02

			var_1_10010 = var_1_10010.sendNotification
			GAME = var_1_10013

			var_1_10010(var_3_5, var_1_10013.STORY_UPDATE, {
				storyId = iter_3_5
			})
		end
	end

	return
end

return var_0_1
