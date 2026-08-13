class = var_0_10000

local var_0_0 = "ActivityLinerOPCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_1_1 = var_1_10004(var_1_10005)

	if var_4.getActivityById(var_1_1, var_2.activity_id) then
		local var_1_2 = var_5

		if var_5.isEnd(var_1_2) then
			return
		end

		if var_2.drop then
			getProxy = var_1_2
			PlayerProxy = var_1_10008

			local var_1_3 = var_1_2(var_1_10008)

			var_1_2 = var_1_2.getData(var_1_3)

			local var_1_4 = var_6.type

			DROP_TYPE_RESOURCE = var_1_10009

			if var_1_4 == var_1_10009 and var_6.id == 1 then
				var_1_10009 = var_1_2

				if var_1_2.GoldMax(var_1_10009, var_6.count) then
					pg = var_8
					var_1_10009 = var_8.TipsMgr.GetInstance()

					local var_1_5 = var_8.ShowTips

					i18n = var_1_10010

					var_1_5(var_1_10009, var_1_10010("gold_max_tip_title"))

					return
				end
			end

			local var_1_6 = var_6.type

			DROP_TYPE_RESOURCE = var_1_10009

			if var_1_6 == var_1_10009 and var_6.id == 2 then
				var_1_10009 = var_1_2

				if var_1_2.OilMax(var_1_10009, var_6.count) then
					pg = var_8
					var_1_10009 = var_8.TipsMgr.GetInstance()

					local var_1_7 = var_8.ShowTips

					i18n = var_1_10010

					var_1_7(var_1_10009, var_1_10010("oil_max_tip_title"))

					return
				end
			end

			local var_1_8 = var_6.type

			DROP_TYPE_ITEM = var_1_10009

			if var_1_8 == var_1_10009 then
				Item = var_1_8

				local var_1_9 = var_1_8.getConfigData(var_6.id).type

				Item = var_1_10010

				if var_1_9 == var_1_10010.EXP_BOOK_TYPE then
					getProxy = var_1_9
					BagProxy = var_10

					local var_1_10 = var_1_9(var_10)

					if var_9.getItemCountById(var_1_10, var_6.id) + var_6.count > var_8.max_num then
						pg = var_11

						local var_1_11 = var_11.TipsMgr.GetInstance()
						local var_1_12 = var_11.ShowTips

						i18n = var_1_10013

						var_1_12(var_1_11, var_1_10013("expbook_max_tip_title"))

						return
					end
				end
			end
		end

		pg = var_1_2

		local var_1_13 = var_1_2.ConnectionMgr.GetInstance()
		local var_1_14 = var_7.Send
		local var_1_15 = 11202
		local var_1_16 = {
			activity_id = var_2.activity_id
		}
		local var_1_17

		if not var_2.cmd then
			var_1_17 = 0
		end

		var_1_16.cmd = var_1_17

		local var_1_18

		if not var_2.arg1 then
			var_1_18 = 0
		end

		var_1_16.arg1 = var_1_18

		local var_1_19

		if not var_2.arg2 then
			var_1_19 = 0
		end

		var_1_16.arg2 = var_1_19
		var_1_16.arg_list = {}

		var_1_14(var_1_13, var_1_15, var_1_16, 11203, function(arg_2_0)
			local var_2_0

			if arg_2_0.result == 0 then
				var_2_0 = {}
				PlayerConst = var_2_10002
				var_2_0 = var_2_10002.addTranDrop(arg_2_0.award_list)

				if var_0.cmd == 1 then
					var_2_10003 = var_0

					local var_2_1 = var_2.GetCurTime(var_2_10003)

					switch = var_2_10003

					local var_2_2 = var_2_1:GetType()
					local var_2_3 = {}

					LinerTime = var_2_10006
					var_2_3[var_2_10006.TYPE.TARGET] = function()
						return
					end
					LinerTime = var_6
					var_2_3[var_6.TYPE.EXPLORE] = function()
						local var_4_0 = var_0

						var_0.AddExploredRoom(var_4_0, var_0.arg1)

						return
					end
					LinerTime = var_6
					var_2_3[var_6.TYPE.EVENT] = function()
						local var_5_0 = var_0

						var_0.AddEvent(var_5_0, var_0.arg1, var_0.arg2)

						return
					end
					LinerTime = var_6
					var_2_3[var_6.TYPE.STORY] = function()
						return
					end

					var_2_10003(var_2_2, var_2_3)

					local var_2_4 = var_0

					if var_2_10003.CheckTimeFinish(var_2_4) then
						local var_2_5 = var_0

						var_2_10003.UpdateTimeIdx(var_2_5)

						local var_2_6 = var_0

						var_2_10003.UpdateRoomIdx(var_2_6, true)
					end

					local var_2_7 = var_0

					if var_2_10003.CheckRoomFinish(var_2_7) then
						local var_2_8 = var_0

						var_2_10003.UpdateRoomIdx(var_2_8, false)
					end
				elseif var_0.cmd == 2 then
					var_2_10003 = var_0

					var_2.AddTimeAwardFlag(var_2_10003, var_0.arg1)
				elseif var_0.cmd == 3 then
					var_2_10003 = var_0

					var_2.AddRoomAwardFlag(var_2_10003, var_0.arg1)
				elseif var_0.cmd == 4 then
					var_2_10003 = var_0

					var_2.AddEventAwardFlag(var_2_10003, var_0.arg1, var_0.arg2)
				end

				var_2_10003 = var_0

				var_2.updateActivity(var_2_10003, var_0)

				if var_1_0 then
					var_1_0()
				end

				var_2_10003 = arg_1_0

				local var_2_9 = var_2.sendNotification

				GAME = var_4

				var_2_9(var_2_10003, var_4.ACTIVITY_LINER_OP_DONE, {
					awards = var_2_0
				})
			else
				pg = var_2_0

				local var_2_10 = var_2_0.TipsMgr.GetInstance()
				local var_2_11 = var_1.ShowTips

				ERROR_MESSAGE = var_2_10003

				var_2_11(var_2_10, var_2_10003[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)

		return
	end
end

return var_0_1
