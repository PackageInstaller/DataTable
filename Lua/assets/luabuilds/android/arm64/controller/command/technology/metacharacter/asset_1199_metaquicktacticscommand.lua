local MetaQuickTacticsCommand = class("MetaQuickTacticsCommand", pm.SimpleCommand)

function MetaQuickTacticsCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.shipID
	local var_1_2 = var_1_0.skillID
	local var_1_3 = var_1_0.useCountDict
	local var_1_4 = ""
	local var_1_5 = {
		ship_id = var_1_0.shipID,
		skill_id = var_1_0.skillID,
		books = {}
	}

	for iter_1_0, iter_1_1 in pairs(var_1_0.useCountDict) do
		table.insert(var_1_5.books, {
			id = iter_1_0,
			num = iter_1_1
		})

		var_1_4 = var_1_4 .. iter_1_0 .. "-" .. iter_1_1 .. ","
	end

	print("63319 send qucik tactics data", var_1_0.shipID, var_1_0.skillID, var_1_4)
	pg.ConnectionMgr.GetInstance():Send(63319, var_1_5, 63320, function(arg_2_0)
		print("63320 qucik tactics done:", arg_2_0.ret)

		if arg_2_0.ret == 0 then
			print("after quick", arg_2_0.level, arg_2_0.exp)

			local var_2_0 = getProxy(BayProxy)
			local var_2_1 = getProxy(BagProxy)
			local var_2_2 = getProxy(MetaCharacterProxy)
			local var_2_3 = var_2_0:getShipById(var_1_1)
			local var_2_4 = var_2_3:getMetaSkillLevelBySkillID(var_1_2) < arg_2_0.level

			var_2_3:updateSkill({
				skill_id = var_1_2,
				skill_lv = arg_2_0.level,
				skill_exp = arg_2_0.exp
			})
			var_2_0:updateShip(var_2_3)
			var_2_2:getMetaTacticsInfoByShipID(var_1_1):setNewExp(var_1_2, arg_2_0.exp)

			for iter_2_0, iter_2_1 in pairs(var_1_3) do
				if iter_2_1 > 0 then
					var_2_1:removeItemById(iter_2_0, iter_2_1)
				end
			end

			self:sendNotification(GAME.META_QUICK_TACTICS_DONE, {
				skillID = var_1_2,
				skillLevel = arg_2_0.level,
				skillExp = arg_2_0.exp,
				isLevelUp = var_2_4
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("", arg_2_0.ret))
		end

		return
	end)

	return
end

return MetaQuickTacticsCommand
