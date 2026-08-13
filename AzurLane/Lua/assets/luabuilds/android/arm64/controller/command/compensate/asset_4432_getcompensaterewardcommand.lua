class = var_0_10000

local var_0_0 = "GetCompensateRewardCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().callback
	local var_1_1 = var_2.reward_id

	local function var_1_2(arg_2_0)
		pg = var_2_10001

		local var_2_0 = var_2_10001.ConnectionMgr.GetInstance()

		var_1.Send(var_2_0, 30104, {
			reward_id = var_0.reward_id
		}, 30105, function(arg_3_0)
			if arg_3_0.result == 0 then
				getProxy = var_1
				CompensateProxy = var_3_10003
				var_3_10004 = var_1(var_3_10003)

				var_1.DealMailOperation(var_3_10004, var_1_1)

				var_3_10004 = var_1

				var_1.unpdateLatestTime(var_3_10004, arg_3_0.max_timestamp)

				var_3_10004 = var_1

				var_1.unpdateUnreadCount(var_3_10004, arg_3_0.number)
				arg_2_0(arg_3_0)
			else
				local var_3_1

				if arg_3_0.result == 6 then
					pg = var_3_1

					local var_3_0 = var_3_1.TipsMgr.GetInstance()

					var_3_1 = var_3_1.ShowTips
					i18n = var_3_10004

					var_3_1(var_3_0, var_3_10004("mail_moveto_markroom_max"))
				else
					pg = var_3_1

					local var_3_2 = var_3_1.TipsMgr.GetInstance()
					local var_3_3 = var_1.ShowTips

					errorTip = var_3_10004

					var_3_3(var_3_2, var_3_10004("", arg_3_0.result))
				end
			end

			return
		end)

		return
	end

	local var_1_3 = {}

	table = var_1_10007

	var_1_10007.insert(var_1_3, function(arg_4_0, arg_4_1)
		GetItemsOverflowDic = var_2_10002

		local var_4_0 = var_2_10002(arg_4_1)

		CheckOverflow = var_2_10003

		local var_4_1, var_4_2 = var_2_10003(var_4_0)

		if not var_4_1 then
			switch = var_5

			var_5(var_4_2, {
				gold = function()
					pg = var_3_10000

					local var_5_0 = var_3_10000.TipsMgr.GetInstance()
					local var_5_1 = var_0.ShowTips

					i18n = var_3_10003

					var_5_1(var_5_0, var_3_10003("gold_max_tip_title"))

					return
				end,
				oil = function()
					pg = var_3_10000

					local var_6_0 = var_3_10000.TipsMgr.GetInstance()
					local var_6_1 = var_0.ShowTips

					i18n = var_3_10003

					var_6_1(var_6_0, var_3_10003("oil_max_tip_title"))

					return
				end,
				equip = function()
					pg = var_3_10000

					local var_7_0 = var_3_10000.TipsMgr.GetInstance()
					local var_7_1 = var_0.ShowTips

					i18n = var_3_10003

					var_7_1(var_7_0, var_3_10003("mail_takeAttachment_error_magazine_full"))

					return
				end,
				ship = function()
					pg = var_3_10000

					local var_8_0 = var_3_10000.TipsMgr.GetInstance()
					local var_8_1 = var_0.ShowTips

					i18n = var_3_10003

					var_8_1(var_8_0, var_3_10003("mail_takeAttachment_error_dockYrad_full"))

					return
				end
			})
		else
			arg_4_0(var_4_2)
		end

		return
	end)

	table = var_7

	var_7.insert(var_1_3, function(arg_9_0, arg_9_1)
		ipairs = var_2_10002

		for iter_9_0, iter_9_1 in var_2_10002(arg_9_1.isExpBookOverflow) do
			table = var_2_10007

			var_2_10007.insert(var_1_3, function(arg_10_0)
				pg = var_3_10001

				local var_10_0 = var_3_10001.MsgboxMgr.GetInstance()
				local var_10_1 = var_1.ShowMsgBox
				local var_10_2 = {}

				i18n = var_3_10005

				local var_10_3 = "player_expResource_mail_overflow"

				Item = var_3_10008
				var_10_2.content = var_3_10005(var_10_3, var_3_10008.getConfigData(iter_9_1).name)
				var_10_2.onYes = arg_10_0

				var_10_1(var_10_0, var_10_2)

				return
			end)
		end

		arg_9_0()

		return
	end)

	local var_1_4 = {}

	table = var_1_10008

	var_1_10008.insert(var_1_4, function(arg_11_0)
		local var_11_0 = arg_11_0

		getProxy = var_2_10003
		CompensateProxy = var_2_10005

		local var_11_1 = var_2_10003(var_2_10005)

		var_11_0(var_3.GetCompensateAttachments(var_11_1, var_1_1))

		return
	end)

	table = var_8

	var_8.insert(var_1_4, function(arg_12_0, arg_12_1)
		if arg_12_1 and #arg_12_1 > 0 then
			seriesAsyncExtend = var_2

			var_2(var_1_3, arg_12_0, arg_12_1)
		else
			arg_12_0()
		end

		return
	end)

	table = var_8

	var_8.insert(var_1_4, function(arg_13_0)
		var_1_2(arg_13_0)

		return
	end)

	seriesAsync = var_8

	var_8(var_1_4, function(arg_14_0)
		PlayerConst = var_2_10001

		local var_14_0 = var_2_10001.addTranDrop(arg_14_0.drop_list)
		local var_14_1 = arg_1_0
		local var_14_2 = var_2.sendNotification

		GAME = var_2_10005

		var_14_2(var_14_1, var_2_10005.DEAL_COMPENSATE_REWARD_DONE, {
			items = var_14_0
		})

		return
	end)

	return
end

return var_0_1
