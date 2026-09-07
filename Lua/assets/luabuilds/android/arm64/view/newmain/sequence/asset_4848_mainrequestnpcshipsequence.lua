local MainRequestNPCShipSequence = class("MainRequestNPCShipSequence")

function MainRequestNPCShipSequence:Execute(arg_1_1)
	local var_1_0 = {}

	for iter_1_0, iter_1_1 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_NPC_COLLECTION)) do
		local var_1_1 = iter_1_1:GetConfigClientSetting("story_id")

		if noEmptyStr(var_1_1) then
			if not pg.NewStoryMgr.GetInstance():IsPlayed(var_1_1) then
				table.insert(var_1_0, function(arg_2_0)
					pg.NewStoryMgr.GetInstance():Play(var_1_1, arg_2_0, true, true)

					return
				end)
			end
		end

		if iter_1_1.data1 == 0 then
			table.insert(var_1_0, function(arg_3_0)
				pg.m02:sendNotification(GAME.FETCH_NPC_SHIP_ACTIVITY, {
					activity_id = iter_1_1.id,
					callback = arg_3_0
				})

				return
			end)
		end
	end

	seriesAsync(var_1_0, arg_1_1)

	return
end

return MainRequestNPCShipSequence
