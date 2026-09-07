local ClassOverCommand = class("ClassOverCommand", pm.SimpleCommand)

function ClassOverCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.courseID
	local var_1_2 = var_1_0.slotVO

	pg.ConnectionMgr.GetInstance():Send(22006, {
		room_id = var_1_0.courseID,
		ship_id = var_1_0.slotVO:GetShip().id
	}, 22007, function(arg_2_0)
		if arg_2_0.result == 0 then
			local var_2_0 = getProxy(BayProxy)
			local var_2_1 = var_1_2:GetShip()
			local var_2_2 = {}

			for iter_2_0, iter_2_1 in pairs((var_1_2:GetAttrList())) do
				var_2_1:addAttr(iter_2_0, iter_2_1)
				var_2_0:updateShip(var_2_1)

				var_2_2[#var_2_2 + 1] = {
					pg.attribute_info_by_type[iter_2_0].condition,
					iter_2_1
				}
			end

			local var_2_3 = var_2_1:getConfig("name")

			if #var_2_2 == 2 then
				pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_quest_Classover_long", var_2_3, var_2_2[1][1], var_2_2[1][2], var_2_2[2][1], var_2_2[2][2]))
			else
				for iter_2_2, iter_2_3 in ipairs(var_2_2) do
					pg.TipsMgr.GetInstance():ShowTips(i18n("main_navalAcademyScene_quest_Classover_short", var_2_3, iter_2_3[1], iter_2_3[2]))
				end
			end

			getProxy(NavalAcademyProxy):GetReward(var_1_1, var_2_1.id)
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("lesson_classOver", arg_2_0.result))
		end

		return
	end)

	return
end

return ClassOverCommand
