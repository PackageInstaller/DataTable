class = var_0_10000

local var_0_0 = "UpgradeIslandCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	arg_1_0:DoUpgrade(var_1_0)

	return
end

function var_0_1.DoUpgrade(arg_2_0, arg_2_1)
	getProxy = var_1_10002
	IslandProxy = var_1_10004

	local var_2_0 = var_1_10002(var_1_10004)
	local var_2_1 = var_2.GetIsland(var_2_0)

	if not var_2.CanLevelUp(var_2_1) then
		arg_2_1()

		return
	end

	pg = var_3

	local var_2_2 = var_3.ConnectionMgr.GetInstance()

	var_3.Send(var_2_2, 21000, {
		type = 0
	}, 21001, function(arg_3_0)
		if arg_3_0.ret == 0 then
			getProxy = var_1
			IslandProxy = var_2_10003

			local var_3_0 = var_1(var_2_10003)

			var_2_10004 = var_1.GetIsland(var_3_0)

			var_1.Upgrade(var_2_10004)

			IslandDropHelper = var_2

			local var_3_1 = var_2.AddItems(arg_3_0)

			IslandTaskHelper = var_3_0

			local var_3_2 = var_3_0.UpdateRuntimeTaskByTargetType

			IslandTaskTargetType = var_2_10005

			var_3_2(var_2_10005.ISLAND_LV)

			IslandAchievementHelper = var_3_2

			local var_3_3 = var_3_2.UpdateRecord

			IslandAchievementType = var_5

			var_3_3(var_5.ISLAND_LV, 0, var_1:GetLevel())

			local var_3_4 = arg_2_0
			local var_3_5 = var_3.sendNotification

			GAME = var_6

			var_3_5(var_3_4, var_6.ISLAND_UPGRADE_DONE, {
				dropData = var_3_1,
				callback = function()
					local var_4_0 = arg_2_0

					var_0.DoUpgrade(var_4_0, arg_2_1)

					return
				end
			})

			pg = var_3_5

			local var_3_6 = var_3_5.GameTrackerMgr.GetInstance()
			local var_3_7 = var_3.Record

			GameTrackerBuilder = var_6

			var_3_7(var_3_6, var_6.BuildIslandUpgrade(var_1:GetLevel()))

			local var_3_8 = var_1:GetTechnologyAgency()

			var_3.TryAutoUnlock(var_3_8)
		else
			pg = var_1

			local var_3_9 = var_1.TipsMgr.GetInstance()
			local var_3_10 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_3_10(var_3_9, var_2_10004[arg_3_0.ret] .. arg_3_0.ret)
		end

		return
	end)

	return
end

return var_0_1
