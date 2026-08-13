class = var_0_10000

local var_0_0 = "MetaCharacterRepairCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().shipID
	local var_1_1 = var_2.attr

	getProxy = var_1_10005
	BayProxy = var_1_10007

	local var_1_2 = var_1_10005(var_1_10007)
	local var_1_3 = var_5.getShipById(var_1_2, var_1_0)
	local var_1_4 = var_6.getMetaCharacter(var_1_3)
	local var_1_5 = var_7.getAttrVO(var_1_4, var_1_1)
	local var_1_6 = var_8.getItem(var_1_5)
	local var_1_7 = var_9.getTotalCnt(var_1_6)
	local var_1_8 = var_9:getItemId()

	getProxy = var_1_6
	BagProxy = var_1_10014

	local var_1_9 = var_1_6(var_1_10014)

	if var_1_7 > var_12.getItemCountById(var_1_9, var_1_8) then
		return
	end

	if var_8:isMaxLevel() then
		return
	end

	print = var_14

	var_14("63301 meta repair:", var_1_0, var_9.id)

	pg = var_14

	local var_1_10 = var_14.ConnectionMgr.GetInstance()

	var_14.Send(var_1_10, 63301, {
		ship_id = var_1_0,
		repair_id = var_9.id
	}, 63302, function(arg_2_0)
		if arg_2_0.result == 0 then
			print = var_1

			var_1("63302 meta repair success:")

			local var_2_0 = var_0

			var_1.levelUp(var_2_0)

			local var_2_1 = var_0

			var_1.updateShip(var_2_1, var_0)

			getProxy = var_1
			MetaCharacterProxy = var_2_1
			var_2_10004 = var_1(var_2_1)

			local var_2_2 = var_1.getMetaProgressVOByID(var_2_10004, var_0.id)

			var_2.updateShip(var_2_2, var_0)

			local var_2_3 = arg_1_0
			local var_2_4 = var_3.sendNotification

			GAME = var_6

			local var_2_5 = var_6.CONSUME_ITEM

			Drop = var_2_10007

			local var_2_6 = var_2_10007.New
			local var_2_7 = {}

			DROP_TYPE_ITEM = var_2_10010
			var_2_7.type = var_2_10010
			var_2_7.id = var_1_8
			var_2_7.count = var_1_7

			var_2_4(var_2_3, var_2_5, var_2_6(var_2_7))

			local var_2_8 = arg_1_0
			local var_2_9 = var_3.sendNotification

			GAME = var_2_5

			var_2_9(var_2_8, var_2_5.REPAIR_META_CHARACTER_DONE)
		else
			pg = var_1

			local var_2_10 = var_1.TipsMgr.GetInstance()
			local var_2_11 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_11(var_2_10, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
