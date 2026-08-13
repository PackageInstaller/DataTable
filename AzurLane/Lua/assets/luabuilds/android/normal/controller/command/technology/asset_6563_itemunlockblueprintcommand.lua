class = var_0_10000

local var_0_0 = "ItemUnlockBluePrintCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().id
	local var_1_1 = var_2.itemId

	getProxy = var_1_10005
	TechnologyProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getBluePrintById(var_1_2, var_1_0)

	getProxy = var_1_2
	BagProxy = var_8

	local var_1_4 = var_1_2(var_8)

	if not var_1_3 or not var_1_4:getItemCountById(var_1_1) then
		return
	end

	pg = var_8

	local var_1_5 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 63214, {
		group = var_1_0,
		itemid = var_1_1
	}, 63215, function(arg_2_0)
		local var_2_0

		if arg_2_0.result == 0 then
			Ship = var_2_0
			var_2_0 = var_2_0.New(arg_2_0.ship)
			getProxy = var_2
			BayProxy = var_2_10003
			var_2_10003 = var_2(var_2_10003)

			var_2.addShip(var_2_10003, var_2_0)

			var_2_10003 = var_1_3

			var_2.unlock(var_2_10003, var_2_0.id)

			var_2_10003 = var_0

			var_2.updateBluePrint(var_2_10003, var_1_3)

			var_2_10003 = var_1_4

			var_2.removeItemById(var_2_10003, var_1_1, 1)

			var_2_10003 = arg_1_0

			local var_2_1 = var_2.sendNotification

			GAME = var_4

			var_2_1(var_2_10003, var_4.ITEM_LOCK_SHIP_BLUPRINT_DONE, {
				ship = var_2_0
			})
		else
			pg = var_2_0

			local var_2_2 = var_2_0.TipsMgr.GetInstance()
			local var_2_3 = var_1.ShowTips

			i18n = var_2_10003

			var_2_3(var_2_2, var_2_10003("printblue_build_erro") .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
