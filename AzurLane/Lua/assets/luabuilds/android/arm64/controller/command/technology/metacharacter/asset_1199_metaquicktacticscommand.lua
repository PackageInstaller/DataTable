class = var_0_10000

local var_0_0 = "MetaQuickTacticsCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipID
	local var_1_1 = var_2.skillID
	local var_1_2 = var_2.useCountDict
	local var_1_3 = ""
	local var_1_4 = {
		ship_id = var_1_0,
		skill_id = var_1_1,
		books = {}
	}

	pairs = var_8

	for iter_1_0, iter_1_1 in var_8(var_1_2) do
		local var_1_5 = {
			id = iter_1_0,
			num = iter_1_1
		}

		table = var_1_10014

		var_1_10014.insert(var_1_4.books, var_1_5)

		var_1_3 = var_1_3 .. iter_1_0 .. "-" .. iter_1_1 .. ","
	end

	print = var_8

	var_8("63319 send qucik tactics data", var_1_0, var_1_1, var_1_3)

	pg = var_8

	local var_1_6 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_6, 63319, var_1_4, 63320, function(arg_2_0)
		print = var_2_10001

		var_2_10001("63320 qucik tactics done:", arg_2_0.ret)

		local var_2_0

		if arg_2_0.ret == 0 then
			print = var_2_0

			var_2_0("after quick", arg_2_0.level, arg_2_0.exp)

			getProxy = var_2_0
			BayProxy = var_3
			var_2_0 = var_2_0(var_3)
			getProxy = var_2_10002
			BagProxy = var_4

			local var_2_1 = var_2_10002(var_4)

			getProxy = var_3
			MetaCharacterProxy = var_5

			local var_2_2 = var_3(var_5)
			local var_2_3 = var_2_0:getShipById(var_1_0)
			local var_2_4 = var_4.getMetaSkillLevelBySkillID(var_2_3, var_1_1) < arg_2_0.level

			var_4:updateSkill({
				skill_id = var_1_1,
				skill_lv = arg_2_0.level,
				skill_exp = arg_2_0.exp
			})
			var_2_0:updateShip(var_4)

			local var_2_5 = var_2_2:getMetaTacticsInfoByShipID(var_1_0)

			var_7.setNewExp(var_2_5, var_1_1, arg_2_0.exp)

			pairs = var_7

			for iter_2_0, iter_2_1 in var_7(var_1_2) do
				if iter_2_1 > 0 then
					var_2_1:removeItemById(iter_2_0, iter_2_1)
				end
			end

			local var_2_6 = arg_1_0
			local var_2_7 = var_7.sendNotification

			GAME = iter_2_0

			var_2_7(var_2_6, iter_2_0.META_QUICK_TACTICS_DONE, {
				skillID = var_1_1,
				skillLevel = arg_2_0.level,
				skillExp = arg_2_0.exp,
				isLevelUp = var_2_4
			})
		else
			pg = var_2_0

			local var_2_8 = var_2_0.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			errorTip = var_4

			var_2_9(var_2_8, var_4("", arg_2_0.ret))
		end

		return
	end)

	return
end

return var_0_1
