class = var_0_10000

local var_0_0 = var_0_10000("MainActDataExpirationReminderSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	seriesAsync = var_1_10002

	var_1_10002({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.CheckSkinCouponActivity(var_2_0, arg_2_0)

			return
		end
	}, arg_1_1)

	return
end

function var_0_0.CheckSkinCouponActivity(arg_3_0, arg_3_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10003

	local var_3_0 = var_1_10002(var_1_10003)
	local var_3_1 = var_2.getActivitiesByType

	ActivityConst = var_1_10004

	if not var_3_1(var_3_0, var_1_10004.ACTIVITY_TYPE_SKIN_COUPON) or #var_2 == 0 then
		arg_3_1()

		return
	end

	local var_3_2 = {}

	ipairs = var_4

	for iter_3_0, iter_3_1 in var_4(var_2) do
		if iter_3_1:ShouldTipUsage() then
			table = var_9

			var_9.insert(var_3_2, function(arg_4_0)
				local var_4_0 = iter_3_1

				var_1.SaveTipTime(var_4_0)

				local var_4_1 = arg_3_0

				var_1.ShowTipMsg(var_4_1, iter_3_1, arg_4_0)

				return
			end)
		end
	end

	seriesAsync = var_4

	var_4(var_3_2, arg_3_1)

	return
end

function var_0_0.ShowTipMsg(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_1:GetCanUsageCnt()
	local var_5_1 = arg_5_1:GetItemConfig()
	local var_5_2 = {}
	local var_5_3 = {}

	DROP_TYPE_ITEM = var_1_10007
	var_5_3.type = var_1_10007
	var_5_3.id = var_5_1.id
	var_5_3.count = var_5_0
	var_5_2[1] = var_5_3

	local var_5_4 = arg_5_1
	local var_5_5 = arg_5_1.GetItemName(var_5_4)

	pg = var_5_4

	local var_5_6 = var_5_4.TimeMgr.GetInstance()
	local var_5_7 = var_7.STimeDescS(var_5_6, arg_5_1.stopTime, "%m.%d")

	pg = var_5_6

	local var_5_8 = var_5_6.MsgboxMgr.GetInstance()
	local var_5_9 = var_8.ShowMsgBox
	local var_5_10 = {
		hideNo = true
	}

	MSGBOX_TYPE_ITEM_BOX = var_1_10011
	var_5_10.type = var_1_10011
	i18n = var_1_10011
	var_5_10.content = var_1_10011("skin_discount_timelimit", var_5_5, var_5_7)
	var_5_10.items = var_5_2
	var_5_10.onYes = arg_5_2

	var_5_9(var_5_8, var_5_10)

	return
end

return var_0_0
