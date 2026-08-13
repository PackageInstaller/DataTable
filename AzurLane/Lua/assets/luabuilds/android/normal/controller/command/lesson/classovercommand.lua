class = var_0_10000

local var_0_0 = "ClassOverCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().courseID
	local var_1_1 = var_2.slotVO

	pg = var_1_10005

	local var_1_2 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_1_2, 22006, {
		room_id = var_1_0,
		ship_id = var_1_1:GetShip().id
	}, 22007, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			getProxy = var_2_0
			BayProxy = var_2_10002
			var_2_0 = var_2_0(var_2_10002)
			var_2_10003 = var_1_1

			local var_2_1 = var_2.GetShip(var_2_10003)
			local var_2_2 = var_1_1

			var_2_10003 = var_2_10003.GetAttrList(var_2_2)

			local var_2_3 = {}

			pairs = var_2_10005

			for iter_2_0, iter_2_1 in var_2_10005(var_2_10003) do
				var_2_10011 = var_2_1

				var_2_1.addAttr(var_2_10011, iter_2_0, iter_2_1)

				var_2_10011 = var_2_0

				var_2_0.updateShip(var_2_10011, var_2_1)

				local var_2_4 = #var_2_3 + 1

				var_2_10011 = {}
				pg = var_12
				var_2_10011[1] = var_12.attribute_info_by_type[iter_2_0].condition
				var_2_10011[2] = iter_2_1
				var_2_3[var_2_4] = var_2_10011
			end

			local var_2_5 = var_2_1:getConfig("name")
			local var_2_6, var_2_7

			if #var_2_3 == 2 then
				pg = var_2_7
				var_2_6 = var_2_7.TipsMgr.GetInstance()
				var_2_7 = var_2_7.ShowTips
				i18n = iter_2_0

				var_2_7(var_2_6, iter_2_0("main_navalAcademyScene_quest_Classover_long", var_2_5, var_2_3[1][1], var_2_3[1][2], var_2_3[2][1], var_2_3[2][2]))
			else
				ipairs = var_2_7

				for iter_2_2, iter_2_3 in var_2_7(var_2_3) do
					pg = var_2_10011

					local var_2_8 = var_2_10011.TipsMgr.GetInstance()

					var_2_10011 = var_2_10011.ShowTips
					i18n = var_2_10013

					var_2_10011(var_2_8, var_2_10013("main_navalAcademyScene_quest_Classover_short", var_2_5, iter_2_3[1], iter_2_3[2]))
				end
			end

			getProxy = var_2_7
			NavalAcademyProxy = var_2_6

			local var_2_9 = var_2_7(var_2_6)

			var_6.GetReward(var_2_9, var_1_0, var_2_1.id)
		else
			pg = var_2_0

			local var_2_10 = var_2_0.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			errorTip = var_2_10003

			var_2_11(var_2_10, var_2_10003("lesson_classOver", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
