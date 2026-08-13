class = var_0_10000

local var_0_0 = "DealMailOperationCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().cmd
	local var_1_1 = var_2.filter
	local var_1_2 = var_2.ignoreTips
	local var_1_3 = var_2.noAttachTip

	switch = var_1_10007

	local var_1_4 = var_1_10007(var_1_1.type, {
		all = function()
			return {}
		end,
		ids = function()
			local var_3_0 = {}
			local var_3_1 = {
				type = 1
			}

			underscore = var_2_10002
			var_3_1.arg_list = var_2_10002.rest(var_1_1.list, 1)
			var_3_0[1] = var_3_1

			return var_3_0
		end,
		drops = function()
			local var_4_0 = {}
			local var_4_1 = {}

			ipairs = var_2_10002

			for iter_4_0, iter_4_1 in var_2_10002(var_1_1.list) do
				local var_4_2 = iter_4_1.type

				DROP_TYPE_RESOURCE = var_2_10008

				if var_4_2 == var_2_10008 then
					table = var_4_2

					var_4_2.insert(var_4_0, iter_4_1.id)
				else
					local var_4_3 = iter_4_1.type

					DROP_TYPE_ITEM = var_2_10008

					if var_4_3 == var_2_10008 then
						table = var_4_3

						var_4_3.insert(var_4_1, iter_4_1.id)
					else
						assert = var_4_3

						var_4_3(false)
					end
				end
			end

			return {
				{
					type = 2,
					arg_list = var_4_0
				},
				{
					type = 3,
					arg_list = var_4_1
				}
			}
		end
	})

	local function var_1_5(arg_5_0, arg_5_1)
		pg = var_2_10002

		local var_5_0 = var_2_10002.ConnectionMgr.GetInstance()
		local var_5_1 = var_2.Send
		local var_5_2 = 30006
		local var_5_3 = {}

		table = var_2_10007

		local var_5_4 = var_2_10007.indexof

		MailProxy = var_2_10009
		var_5_3.cmd = var_5_4(var_2_10009.DEAL_CMD_LIST, arg_5_0)
		var_5_3.match_list = var_1_4

		var_5_1(var_5_0, var_5_2, var_5_3, 30007, function(arg_6_0)
			if arg_6_0.result == 0 then
				getProxy = var_1
				MailProxy = var_3_10003

				local var_6_0 = var_1(var_3_10003)

				underscore = var_3_10002

				local var_6_1 = var_3_10002.rest(arg_6_0.mail_id_list, 1)

				table = var_3_10003

				local var_6_2 = var_3_10003.sort
				local var_6_3 = var_6_1

				CompareFuncs = var_3_10006

				var_6_2(var_6_3, var_3_10006({
					function(arg_7_0)
						return -arg_7_0
					end
				}))

				ipairs = var_6_2

				for iter_6_0, iter_6_1 in var_6_2(var_6_1) do
					var_6_0:DealMailOperation(iter_6_1, arg_5_0)
				end

				var_6_0:unpdateUnreadCount(arg_6_0.unread_number)
				arg_5_1(arg_6_0)
			else
				local var_6_5

				if arg_6_0.result == 6 then
					pg = var_6_5

					local var_6_4 = var_6_5.TipsMgr.GetInstance()

					var_6_5 = var_6_5.ShowTips
					i18n = var_3_10004

					var_6_5(var_6_4, var_3_10004("mail_moveto_markroom_max"))
				else
					pg = var_6_5

					local var_6_6 = var_6_5.TipsMgr.GetInstance()
					local var_6_7 = var_1.ShowTips

					errorTip = var_3_10004

					var_6_7(var_6_6, var_3_10004("", arg_6_0.result))
				end
			end

			return
		end)

		return
	end

	local var_1_6 = {}
	local var_1_7

	if var_1_0 == "attachment" or var_1_0 == "move" then
		var_1_7 = {}
		table = var_11

		var_11.insert(var_1_7, function(arg_8_0, arg_8_1)
			CheckEquipLimit = var_2_10002

			local var_8_0 = var_2_10002(arg_8_1)

			GetItemsOverflowDic = var_2_10003

			local var_8_1 = var_2_10003(arg_8_1)

			CheckOverflow = var_4

			local var_8_2, var_8_3 = var_4(var_8_1, true)

			if not var_8_2 then
				switch = var_6

				var_6(var_8_3, {
					gold = function()
						pg = var_3_10000

						local var_9_0 = var_3_10000.TipsMgr.GetInstance()
						local var_9_1 = var_0.ShowTips

						i18n = var_3_10003

						var_9_1(var_9_0, var_3_10003("gold_max_tip_title"))

						return
					end,
					oil = function()
						pg = var_3_10000

						local var_10_0 = var_3_10000.TipsMgr.GetInstance()
						local var_10_1 = var_0.ShowTips

						i18n = var_3_10003

						var_10_1(var_10_0, var_3_10003("oil_max_tip_title"))

						return
					end,
					equip = function()
						pg = var_3_10000

						local var_11_0 = var_3_10000.TipsMgr.GetInstance()
						local var_11_1 = var_0.ShowTips

						i18n = var_3_10003

						var_11_1(var_11_0, var_3_10003("mail_takeAttachment_error_magazine_full"))

						return
					end,
					ship = function()
						pg = var_3_10000

						local var_12_0 = var_3_10000.TipsMgr.GetInstance()
						local var_12_1 = var_0.ShowTips

						i18n = var_3_10003

						var_12_1(var_12_0, var_3_10003("mail_takeAttachment_error_dockYrad_full"))

						return
					end
				})
			else
				if var_8_0 then
					local var_8_4 = {}

					ipairs = var_7

					for iter_8_0, iter_8_1 in var_7(var_8_0) do
						var_2_10012 = iter_8_1[1]

						local var_8_5 = iter_8_1[2]

						table = var_2_10014
						var_2_10014 = var_2_10014.insert

						local var_8_6 = var_8_4

						Drop = var_2_10017
						var_2_10017 = var_2_10017.New

						local var_8_7 = {}

						DROP_TYPE_EQUIP = var_2_10020
						var_8_7.type = var_2_10020
						var_8_7.id = var_2_10012
						var_8_7.count = var_8_5

						var_2_10014(var_8_6, var_2_10017(var_8_7))
					end

					local var_8_8 = arg_1_0
					local var_8_9 = var_7.sendNotification

					GAME = iter_8_0

					local var_8_10 = iter_8_0.MAIL_DOUBLE_CONFIREMATION_MSGBOX
					local var_8_11 = {
						content = "mail_takeAttachment_error_equipment_overlimit"
					}

					MailProxy = var_2_10012
					var_8_11.type = var_2_10012.MailMessageBoxType.ReDropConfirm

					function var_8_11.onYes()
						arg_8_0(var_8_3)

						return
					end

					var_8_11.dropList = var_8_4

					var_8_9(var_8_8, var_8_10, var_8_11)

					return
				end

				arg_8_0(var_8_3)
			end

			return
		end)

		table = var_11

		var_11.insert(var_1_7, function(arg_14_0, arg_14_1)
			if arg_14_1.isStoreOverflow then
				table = var_2

				var_2.insert(var_1_7, function(arg_15_0)
					unpack = var_3_10001

					local var_15_0, var_15_1 = var_3_10001(arg_14_1.isStoreOverflow)
					local var_15_2 = {}

					if 0 < var_15_0 then
						table = var_4

						local var_15_3 = var_4.insert
						local var_15_4 = var_15_2

						Drop = var_3_10007
						var_3_10007 = var_3_10007.New
						var_3_10009 = {}
						DROP_TYPE_RESOURCE = var_3_10010
						var_3_10009.type = var_3_10010
						PlayerConst = var_3_10010
						var_3_10009.id = var_3_10010.ResGold
						var_3_10009.count = var_15_0

						var_15_3(var_15_4, var_3_10007(var_3_10009))
					end

					if 0 < var_15_1 then
						table = var_4

						local var_15_5 = var_4.insert
						local var_15_6 = var_15_2

						Drop = var_3_10007
						var_3_10007 = var_3_10007.New
						var_3_10009 = {}
						DROP_TYPE_RESOURCE = var_3_10010
						var_3_10009.type = var_3_10010
						PlayerConst = var_3_10010
						var_3_10009.id = var_3_10010.ResOil
						var_3_10009.count = var_15_1

						var_15_5(var_15_6, var_3_10007(var_3_10009))
					end

					local var_15_7 = arg_1_0
					local var_15_8 = var_4.sendNotification

					GAME = var_3_10007

					local var_15_9 = var_3_10007.MAIL_DOUBLE_CONFIREMATION_MSGBOX
					local var_15_10 = {}

					MailProxy = var_3_10009
					var_15_10.type = var_3_10009.MailMessageBoxType.OverflowConfirm
					i18n = var_9
					var_15_10.content = var_9("mail_storeroom_max_1")
					var_15_10.onYes = arg_15_0
					var_15_10.dropList = var_15_2

					var_15_8(var_15_7, var_15_9, var_15_10)

					return
				end)
			end

			ipairs = var_2

			for iter_14_0, iter_14_1 in var_2(arg_14_1.isExpBookOverflow) do
				table = var_2_10007

				var_2_10007.insert(var_1_7, function(arg_16_0)
					local var_16_0 = arg_1_0
					local var_16_1 = var_1.sendNotification

					GAME = var_3_10004

					local var_16_2 = var_3_10004.MAIL_DOUBLE_CONFIREMATION_MSGBOX
					local var_16_3 = {}

					MailProxy = var_3_10006
					var_16_3.type = var_3_10006.MailMessageBoxType.ShowTips
					i18n = var_6

					local var_16_4 = "player_expResource_mail_overflow"

					Item = var_3_10009
					var_16_3.content = var_6(var_16_4, var_3_10009.getConfigData(iter_14_1).name)
					var_16_3.onYes = arg_16_0

					var_16_1(var_16_0, var_16_2, var_16_3)

					return
				end)
			end

			arg_14_0()

			return
		end)

		if var_1_1.type == "ids" then
			table = var_11

			var_11.insert(var_1_6, function(arg_17_0)
				local var_17_0 = arg_17_0

				getProxy = var_2_10003
				MailProxy = var_2_10005

				local var_17_1 = var_2_10003(var_2_10005)

				var_17_0(var_3.GetMailsAttachments(var_17_1, var_1_1.list), var_1_1.list)

				return
			end)
		else
			table = var_11

			var_11.insert(var_1_6, function(arg_18_0)
				var_1_5("overflow", arg_18_0)

				return
			end)

			table = var_11

			var_11.insert(var_1_6, function(arg_19_0, arg_19_1)
				local var_19_0 = arg_19_0

				underscore = var_2_10004

				var_19_0(var_2_10004.map(arg_19_1.drop_list, function(arg_20_0)
					Drop = var_3_10001

					return var_3_10001.New({
						type = arg_20_0.type,
						id = arg_20_0.id,
						count = arg_20_0.number
					})
				end), arg_19_1.mail_id_list)

				return
			end)
		end

		if not var_1_3 then
			table = var_11

			var_11.insert(var_1_6, function(arg_21_0, arg_21_1, arg_21_2)
				if #arg_21_2 > 0 then
					local var_21_0 = arg_1_0
					local var_21_1 = var_3.sendNotification

					GAME = var_2_10006
					var_2_10006 = var_2_10006.MAIL_DOUBLE_CONFIREMATION_MSGBOX

					local var_21_2 = {}

					MailProxy = var_2_10008
					var_21_2.type = var_2_10008.MailMessageBoxType.ReceiveAward
					i18n = var_2_10008
					var_21_2.content = var_2_10008("mail_take_all_mail_msgbox")

					function var_21_2.onYes()
						arg_21_0(arg_21_1)

						return
					end

					var_21_2.items = arg_21_1
					var_21_2.mailids = arg_21_2

					var_21_1(var_21_0, var_2_10006, var_21_2)
				else
					local var_21_3 = arg_1_0
					local var_21_4 = var_3.sendNotification

					GAME = var_2_10006

					local var_21_5 = var_2_10006.MAIL_DOUBLE_CONFIREMATION_MSGBOX
					local var_21_6 = {}

					MailProxy = var_2_10008
					var_21_6.type = var_2_10008.MailMessageBoxType.ShowTips
					i18n = var_8
					var_21_6.content = var_8("mail_manage_3")

					var_21_4(var_21_3, var_21_5, var_21_6)
				end

				return
			end)
		end

		table = var_11

		var_11.insert(var_1_6, function(arg_23_0, arg_23_1)
			if arg_23_1 and #arg_23_1 > 0 then
				seriesAsyncExtend = var_2

				var_2(var_1_7, arg_23_0, arg_23_1)
			else
				arg_23_0()
			end

			return
		end)
	end

	table = var_1_7

	var_1_7.insert(var_1_6, function(arg_24_0)
		var_1_5(var_1_0, arg_24_0)

		return
	end)

	seriesAsync = var_10

	var_10(var_1_6, function(arg_25_0)
		PlayerConst = var_2_10001

		local var_25_0 = var_2_10001.addTranDrop(arg_25_0.drop_list)
		local var_25_1 = arg_1_0
		local var_25_2 = var_2.sendNotification

		GAME = var_2_10005

		local var_25_3 = var_2_10005.DEAL_MAIL_OPERATION_DONE
		local var_25_4 = {
			cmd = var_1_0
		}

		underscore = var_7
		var_25_4.ids = var_7.rest(arg_25_0.mail_id_list, 1)
		var_25_4.items = var_25_0
		var_25_4.ignoreTips = var_1_2

		var_25_2(var_25_1, var_25_3, var_25_4)

		return
	end)

	return
end

return var_0_1
