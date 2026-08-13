class = var_0_10000

local var_0_0 = "ChangePlayerNameCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().name
	local var_1_1

	if not var_2.type then
		var_1_1 = 1
	end

	local var_1_2 = var_2.onSuccess

	if not var_1_0 or var_1_0 == "" then
		return
	end

	getProxy = var_1_10006
	PlayerProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	if not var_6.getData(var_1_3) then
		return
	end

	local var_1_5

	if var_1_0 == var_7.name then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10011

		var_1_5(var_1_4, var_1_10011("same_player_name_tip"))

		return
	end

	nameValidityCheck = var_1_5

	if not var_1_5(var_1_0, 4, 14, {
		"spece_illegal_tip",
		"login_newPlayerScene_name_tooShort",
		"login_newPlayerScene_name_tooLong",
		"login_newPlayerScene_invalideName"
	}) then
		return
	end

	if var_1_1 == 1 then
		arg_1_0:ModifyNameByItem(var_7, var_1_0, var_1_2)
	elseif var_1_1 == 2 then
		arg_1_0:ForceModifyName(var_7, var_1_0, var_1_2)
	end

	return
end

function var_0_1.ModifyNameByItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = arg_2_1
	local var_2_1, var_2_2 = arg_2_1.canModifyName(var_2_0)

	if not var_2_1 then
		pg = var_2_0
		var_1_10008 = var_2_0.TipsMgr.GetInstance()

		var_2_0.ShowTips(var_1_10008, var_2_2)

		return
	end

	getProxy = var_2_0
	PlayerProxy = var_1_10008

	local var_2_3 = var_2_0(var_1_10008)
	local var_2_4 = arg_2_1:getModifyNameComsume()

	getProxy = var_1_10008
	BagProxy = var_1_10010

	local var_2_5 = var_1_10008(var_1_10010)
	local var_2_6
	local var_2_7 = var_2_4[1]

	DROP_TYPE_RESOURCE = var_1_10011

	if var_2_7 == var_1_10011 then
		var_1_10012 = arg_2_1

		if arg_2_1.getResById(var_1_10012, var_2_4[2]) < var_2_4[3] then
			pg = var_1_10011

			local var_2_8 = var_1_10011.TipsMgr.GetInstance()

			var_1_10011 = var_1_10011.ShowTips
			i18n = var_1_10014

			var_1_10011(var_2_8, var_1_10014("common_no_resource"))

			return
		end

		Drop = var_1_10011
		var_1_10011 = var_1_10011.New

		local var_2_9 = {}

		DROP_TYPE_ITEM = var_1_10014
		var_2_9.type = var_1_10014
		id2ItemId = var_1_10014
		var_2_9.id = var_1_10014(var_2_4[2])
		var_2_9.count = var_2_4[3]
		var_2_6 = var_1_10011(var_2_9)
	else
		var_2_7 = var_2_4[1]
		DROP_TYPE_ITEM = var_1_10011

		if var_2_7 == var_1_10011 then
			var_1_10012 = var_2_5

			if not var_2_5.getItemById(var_1_10012, var_2_4[2]) or var_2_7.count < var_2_4[3] then
				pg = var_1_10011

				local var_2_10 = var_1_10011.TipsMgr.GetInstance()

				var_1_10011 = var_1_10011.ShowTips
				i18n = var_1_10014

				var_1_10011(var_2_10, var_1_10014("common_no_item_1"))

				return
			end

			Drop = var_1_10011

			local var_2_11 = var_1_10011.New
			local var_2_12 = {}

			DROP_TYPE_ITEM = var_1_10014
			var_2_12.type = var_1_10014
			var_2_12.id = var_2_4[2]
			var_2_12.count = var_2_4[3]
			var_2_6 = var_2_11(var_2_12)
		else
			assert = var_2_7

			var_2_7(false, "type is not supported >> " .. var_2_4[1])

			return
		end
	end

	pg = var_2_7

	local var_2_13 = var_2_7.gameset.player_name_cold_time.key_value

	local function var_2_14()
		pg = var_2_10000

		local var_3_0 = var_2_10000.ConnectionMgr.GetInstance()

		var_0.Send(var_3_0, 11007, {
			type = 1,
			name = arg_2_2
		}, 11008, function(arg_4_0)
			local var_4_0

			if arg_4_0.result == 0 then
				var_4_0 = arg_2_1
				var_4_0.name = arg_2_2
				pg = var_4_0

				local var_4_1 = var_4_0.TimeMgr.GetInstance()

				var_4_0 = var_4_0.GetServerTime(var_4_1) + var_2_13
				var_3_10004 = arg_2_1

				var_2.updateModifyNameColdTime(var_3_10004, var_4_0)

				var_3_10004 = var_2_3

				var_2.updatePlayer(var_3_10004, arg_2_1)

				var_3_10004 = arg_2_0

				local var_4_2 = var_2.sendNotification

				GAME = var_5

				local var_4_3 = var_5.CONSUME_ITEM

				Drop = var_3_10006

				var_4_2(var_3_10004, var_4_3, var_3_10006.Create(var_2_4))

				if arg_2_3 then
					arg_2_3()
				end

				var_3_10004 = arg_2_0

				local var_4_4 = var_2.sendNotification

				GAME = var_4_3

				var_4_4(var_3_10004, var_4_3.CHANGE_PLAYER_NAME_DONE)

				pg = var_4_4
				var_3_10004 = var_4_4.TipsMgr.GetInstance()

				local var_4_5 = var_2.ShowTips

				i18n = var_5

				var_4_5(var_3_10004, var_5("player_changePlayerName_ok"))
			else
				pg = var_4_0

				local var_4_6 = var_4_0.TipsMgr.GetInstance()
				local var_4_7 = var_1.ShowTips

				errorTip = var_3_10004

				var_4_7(var_4_6, var_3_10004("player_changePlayerName", arg_4_0.result))
			end

			return
		end)

		return
	end

	pg = var_1_10012

	local var_2_15 = var_1_10012.MsgboxMgr.GetInstance()
	local var_2_16 = var_12.ShowMsgBox
	local var_2_17 = {}

	i18n = var_1_10016
	var_2_17.content = var_1_10016("player_name_change_warning", var_2_6.count, var_2_6:getConfig("name"), arg_2_2)

	function var_2_17.onYes()
		var_2_14()

		return
	end

	var_2_16(var_2_15, var_2_17)

	return
end

function var_0_1.ForceModifyName(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	getProxy = var_1_10004
	PlayerProxy = var_1_10006

	local var_6_0 = var_1_10004(var_1_10006)

	pg = var_1_10005

	local var_6_1 = var_1_10005.ConnectionMgr.GetInstance()

	var_5.Send(var_6_1, 11007, {
		type = 2,
		name = arg_6_2
	}, 11008, function(arg_7_0)
		local var_7_0

		if arg_7_0.result == 0 then
			var_7_0 = arg_6_1
			var_7_0.name = arg_6_2

			local var_7_1 = arg_6_1

			var_7_0 = var_7_0.CancelCommonFlag
			ILLEGALITY_PLAYER_NAME = var_2_10004

			var_7_0(var_7_1, var_2_10004)

			local var_7_2 = var_6_0

			var_7_0.updatePlayer(var_7_2, arg_6_1)

			if arg_6_3 then
				arg_6_3()
			end

			local var_7_3 = arg_6_0

			var_7_0 = var_7_0.sendNotification
			GAME = var_2_10004

			var_7_0(var_7_3, var_2_10004.CHANGE_PLAYER_NAME_DONE)

			pg = var_7_0

			local var_7_4 = var_7_0.TipsMgr.GetInstance()

			var_7_0 = var_7_0.ShowTips
			i18n = var_2_10004

			var_7_0(var_7_4, var_2_10004("player_changePlayerName_ok"))
		else
			pg = var_7_0

			local var_7_5 = var_7_0.TipsMgr.GetInstance()
			local var_7_6 = var_1.ShowTips

			errorTip = var_2_10004

			var_7_6(var_7_5, var_2_10004("player_changePlayerName", arg_7_0.result))
		end

		return
	end)

	return
end

return var_0_1
