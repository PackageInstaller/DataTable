class = var_0_10000

local var_0_0 = "ChangePlayerNameCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

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
	PlayerProxy = var_1_10007

	local var_1_3 = var_1_10006(var_1_10007)

	if not var_6.getData(var_1_3) then
		return
	end

	local var_1_5

	if var_1_0 == var_7.name then
		pg = var_1_5

		local var_1_4 = var_1_5.TipsMgr.GetInstance()

		var_1_5 = var_1_5.ShowTips
		i18n = var_1_10010

		var_1_5(var_1_4, var_1_10010("same_player_name_tip"))

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
	local var_2_0, var_2_1 = arg_2_1:canModifyName()

	if not var_2_0 then
		pg = var_1_10006
		var_1_10007 = var_1_10006.TipsMgr.GetInstance()

		var_1_10006.ShowTips(var_1_10007, var_2_1)

		return
	end

	getProxy = var_1_10006
	PlayerProxy = var_1_10007

	local var_2_2 = var_1_10006(var_1_10007)
	local var_2_3 = arg_2_1
	local var_2_4 = arg_2_1.getModifyNameComsume(var_2_3)

	getProxy = var_2_3
	BagProxy = var_1_10009

	local var_2_5 = var_2_3(var_1_10009)
	local var_2_6
	local var_2_7 = var_2_4[1]

	DROP_TYPE_RESOURCE = var_1_10011

	if var_2_7 == var_1_10011 then
		var_1_10011 = arg_2_1

		if arg_2_1.getResById(var_1_10011, var_2_4[2]) < var_2_4[3] then
			pg = var_1_10011
			var_1_10012 = var_1_10011.TipsMgr.GetInstance()
			var_1_10011 = var_1_10011.ShowTips
			i18n = var_1_10013

			var_1_10011(var_1_10012, var_1_10013("common_no_resource"))

			return
		end

		Drop = var_1_10011
		var_1_10011 = var_1_10011.New
		var_1_10012 = {}
		DROP_TYPE_ITEM = var_1_10013
		var_1_10012.type = var_1_10013
		id2ItemId = var_1_10013
		var_1_10012.id = var_1_10013(var_2_4[2])
		var_1_10012.count = var_2_4[3]
		var_2_6 = var_1_10011(var_1_10012)
	else
		var_2_7 = var_2_4[1]
		DROP_TYPE_ITEM = var_1_10011

		if var_2_7 == var_1_10011 then
			local var_2_8 = var_2_5

			if not var_2_5.getItemById(var_2_8, var_2_4[2]) or var_2_7.count < var_2_4[3] then
				pg = var_2_8
				var_1_10012 = var_2_8.TipsMgr.GetInstance()
				var_2_8 = var_2_8.ShowTips
				i18n = var_1_10013

				var_2_8(var_1_10012, var_1_10013("common_no_item_1"))

				return
			end

			Drop = var_2_8

			local var_2_9 = var_2_8.New

			var_1_10012 = {}
			DROP_TYPE_ITEM = var_1_10013
			var_1_10012.type = var_1_10013
			var_1_10012.id = var_2_4[2]
			var_1_10012.count = var_2_4[3]
			var_2_6 = var_2_9(var_1_10012)
		else
			assert = var_2_7

			var_2_7(false, "type is not supported >> " .. var_2_4[1])

			return
		end
	end

	pg = var_2_7

	local var_2_10 = var_2_7.gameset.player_name_cold_time.key_value

	local function var_2_11()
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

				var_4_0 = var_4_0.GetServerTime(var_4_1) + var_2_10
				var_3_10003 = arg_2_1

				var_2.updateModifyNameColdTime(var_3_10003, var_4_0)

				var_3_10003 = var_2_2

				var_2.updatePlayer(var_3_10003, arg_2_1)

				var_3_10003 = arg_2_0

				local var_4_2 = var_2.sendNotification

				GAME = var_4

				local var_4_3 = var_4.CONSUME_ITEM

				Drop = var_3_10005

				var_4_2(var_3_10003, var_4_3, var_3_10005.Create(var_2_4))

				if arg_2_3 then
					arg_2_3()
				end

				var_3_10003 = arg_2_0

				local var_4_4 = var_2.sendNotification

				GAME = var_4_3

				var_4_4(var_3_10003, var_4_3.CHANGE_PLAYER_NAME_DONE)

				pg = var_4_4
				var_3_10003 = var_4_4.TipsMgr.GetInstance()

				local var_4_5 = var_2.ShowTips

				i18n = var_4

				var_4_5(var_3_10003, var_4("player_changePlayerName_ok"))
			else
				pg = var_4_0

				local var_4_6 = var_4_0.TipsMgr.GetInstance()
				local var_4_7 = var_1.ShowTips

				errorTip = var_3_10003

				var_4_7(var_4_6, var_3_10003("player_changePlayerName", arg_4_0.result))
			end

			return
		end)

		return
	end

	pg = var_1_10012

	local var_2_12 = var_1_10012.MsgboxMgr.GetInstance()
	local var_2_13 = var_12.ShowMsgBox
	local var_2_14 = {}

	i18n = var_1_10015
	var_2_14.content = var_1_10015("player_name_change_warning", var_2_6.count, var_2_6:getConfig("name"), arg_2_2)

	function var_2_14.onYes()
		var_2_11()

		return
	end

	var_2_13(var_2_12, var_2_14)

	return
end

function var_0_1.ForceModifyName(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	getProxy = var_1_10004
	PlayerProxy = var_1_10005

	local var_6_0 = var_1_10004(var_1_10005)

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
			ILLEGALITY_PLAYER_NAME = var_2_10003

			var_7_0(var_7_1, var_2_10003)

			local var_7_2 = var_6_0

			var_7_0.updatePlayer(var_7_2, arg_6_1)

			if arg_6_3 then
				arg_6_3()
			end

			local var_7_3 = arg_6_0

			var_7_0 = var_7_0.sendNotification
			GAME = var_2_10003

			var_7_0(var_7_3, var_2_10003.CHANGE_PLAYER_NAME_DONE)

			pg = var_7_0

			local var_7_4 = var_7_0.TipsMgr.GetInstance()

			var_7_0 = var_7_0.ShowTips
			i18n = var_2_10003

			var_7_0(var_7_4, var_2_10003("player_changePlayerName_ok"))
		else
			pg = var_7_0

			local var_7_5 = var_7_0.TipsMgr.GetInstance()
			local var_7_6 = var_1.ShowTips

			errorTip = var_2_10003

			var_7_6(var_7_5, var_2_10003("player_changePlayerName", arg_7_0.result))
		end

		return
	end)

	return
end

return var_0_1
