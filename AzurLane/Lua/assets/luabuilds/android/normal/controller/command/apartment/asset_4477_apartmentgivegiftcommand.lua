class = var_0_10000

local var_0_0 = "ApartmentGiveGiftCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.giftId
	local var_1_2 = var_2.count

	getProxy = var_1_10006
	ApartmentProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	if var_6.getGiftCount(var_1_3, var_1_1) < var_1_2 then
		pg = var_7

		local var_1_4 = var_7.TipsMgr.GetInstance()
		local var_1_5 = var_7.ShowTips

		i18n = var_9

		var_1_5(var_1_4, var_9("common_no_item_1"))

		return
	end

	local var_1_6 = var_6
	local var_1_7 = var_6.getApartment(var_1_6, var_1_0)

	pg = var_1_6

	local var_1_8 = var_1_6.ConnectionMgr.GetInstance()

	var_8.Send(var_1_8, 28009, {
		ship_group = var_1_0,
		gifts = {
			{
				gift_id = var_1_1,
				number = var_1_2
			}
		}
	}, 28010, function(arg_2_0)
		local var_2_2

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_2.addGiftGiveCount(var_2_0, var_1_1, var_1_2)

			local var_2_1 = var_0

			var_2_2.changeGiftCount(var_2_1, var_1_1, -var_1_2)

			pg = var_2_2
			var_2_2 = var_2_2.dorm3d_gift[var_1_1].favor_trigger_id
			var_2_10003 = var_0

			local var_2_3

			var_2_3, var_2_10003 = var_2.triggerFavor(var_2_10003, var_1_0, var_2_2, var_1_2)

			local var_2_4 = arg_1_0
			local var_2_5 = var_4.sendNotification

			GAME = var_6

			var_2_5(var_2_4, var_6.APARTMENT_TRIGGER_FAVOR_DONE, {
				isGift = true,
				triggerId = var_2_2,
				cost = var_2_10003,
				delta = var_2_3,
				apartment = var_1_7
			})

			local var_2_6 = arg_1_0
			local var_2_7 = var_4.sendNotification

			GAME = var_6

			var_2_7(var_2_6, var_6.APARTMENT_GIVE_GIFT_DONE, {
				groupId = var_1_0,
				giftId = var_1_1
			})
		else
			pg = var_2_2

			local var_2_8 = var_2_2.TipsMgr.GetInstance()
			local var_2_9 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10003

			var_2_9(var_2_8, var_2_10003[arg_2_0.result] .. arg_2_0.result)
		end

		return
	end)

	return
end

return var_0_1
