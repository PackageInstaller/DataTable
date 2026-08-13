class = var_0_10000

local var_0_0 = "EquipCodeLikeCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().groupId
	local var_1_1 = var_2.shareId

	getProxy = var_1_10005
	CollectionProxy = var_1_10006

	local var_1_2 = var_1_10005(var_1_10006)
	local var_1_3 = var_5.getShipGroup(var_1_2, var_1_0)

	underscore = var_1_2

	local var_1_4 = var_1_2.detect(var_1_3:getEquipCodes(), function(arg_2_0)
		return arg_2_0.id == var_1_1
	end)

	pg = var_8

	local var_1_5 = var_8.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 17605, {
		shipgroup = var_1_0,
		shareid = var_1_1
	}, 17606, function(arg_3_0)
		if arg_3_0.result == 0 then
			var_1_4.afterLike = true
			var_1_4.like = var_1_4.like + 1

			local var_3_0 = var_0

			var_1.updateShipGroup(var_3_0, var_1_3)

			local var_3_1 = arg_1_0
			local var_3_2 = var_1.sendNotification

			GAME = var_2_10003

			var_3_2(var_3_1, var_2_10003.EQUIP_CODE_LIKE_DONE, {
				like = true,
				shareId = var_1_1
			})

			pg = var_3_2

			local var_3_3 = var_3_2.TipsMgr.GetInstance()
			local var_3_4 = var_1.ShowTips

			i18n = var_2_10003

			var_3_4(var_3_3, var_2_10003("equipcode_like_success"))
		else
			local var_3_5

			if arg_3_0.result == 7 then
				var_3_5 = var_1_4
				var_3_5.afterLike = true

				local var_3_6 = var_0

				var_3_5.updateShipGroup(var_3_6, var_1_3)

				local var_3_7 = arg_1_0

				var_3_5 = var_3_5.sendNotification
				GAME = var_2_10003

				var_3_5(var_3_7, var_2_10003.EQUIP_CODE_LIKE_DONE, {
					shareId = var_1_1
				})

				pg = var_3_5

				local var_3_8 = var_3_5.TipsMgr.GetInstance()

				var_3_5 = var_3_5.ShowTips
				i18n = var_2_10003

				var_3_5(var_3_8, var_2_10003("equipcode_like_limited"))
			else
				pg = var_3_5

				local var_3_9 = var_3_5.TipsMgr.GetInstance()
				local var_3_10 = var_1.ShowTips

				errorTip = var_2_10003

				var_3_10(var_3_9, var_2_10003("", arg_3_0.result))
			end
		end

		return
	end)

	return
end

return var_0_1
