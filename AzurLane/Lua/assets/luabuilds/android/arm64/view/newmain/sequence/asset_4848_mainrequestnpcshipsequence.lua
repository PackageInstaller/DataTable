class = var_0_10000

local var_0_0 = var_0_10000("MainRequestNPCShipSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	local var_1_0 = {}

	ipairs = var_1_10003
	getProxy = var_1_10005
	ActivityProxy = var_1_10007

	local var_1_1 = var_1_10005(var_1_10007)
	local var_1_2 = var_5.getActivitiesByType

	ActivityConst = var_1_10008

	for iter_1_0, iter_1_1 in var_1_10003(var_1_2(var_1_1, var_1_10008.ACTIVITY_TYPE_NPC_COLLECTION)) do
		local var_1_3 = iter_1_1:GetConfigClientSetting("story_id")

		noEmptyStr = var_1_10009

		if var_1_10009(var_1_3) then
			pg = var_1_10009

			local var_1_4 = var_1_10009.NewStoryMgr.GetInstance()

			if not var_1_10009.IsPlayed(var_1_4, var_1_3) then
				table = var_1_10009

				var_1_10009.insert(var_1_0, function(arg_2_0)
					pg = var_2_10001

					local var_2_0 = var_2_10001.NewStoryMgr.GetInstance()

					var_1.Play(var_2_0, var_1_3, arg_2_0, true, true)

					return
				end)
			end
		end

		if iter_1_1.data1 == 0 then
			table = var_1_10009

			var_1_10009.insert(var_1_0, function(arg_3_0)
				pg = var_2_10001

				local var_3_0 = var_2_10001.m02
				local var_3_1 = var_1.sendNotification

				GAME = var_2_10004

				var_3_1(var_3_0, var_2_10004.FETCH_NPC_SHIP_ACTIVITY, {
					activity_id = iter_1_1.id,
					callback = arg_3_0
				})

				return
			end)
		end
	end

	seriesAsync = var_3

	var_3(var_1_0, arg_1_1)

	return
end

return var_0_0
