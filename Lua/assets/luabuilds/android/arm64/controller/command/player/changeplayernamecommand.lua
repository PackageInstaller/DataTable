local var_0_0 = class("ChangePlayerNameCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.type or 1
	local var_1_2 = var_1_0.onSuccess

	if not var_1_0.name or var_1_0.name == "" then
		return
	end

	local var_1_3 = getProxy(PlayerProxy):getData()

	if not var_1_3 then
		return
	end

	if var_1_0.name == var_1_3.name then
		pg.TipsMgr.GetInstance():ShowTips(i18n("same_player_name_tip"))

		return
	end

	if not nameValidityCheck(var_1_0.name, 4, 14, {
		"spece_illegal_tip",
		"login_newPlayerScene_name_tooShort",
		"login_newPlayerScene_name_tooLong",
		"login_newPlayerScene_invalideName"
	}) then
		return
	end

	if var_1_1 == 1 then
		arg_1_0:ModifyNameByItem(var_1_3, var_1_0.name, var_1_2)
	elseif var_1_1 == 2 then
		arg_1_0:ForceModifyName(var_1_3, var_1_0.name, var_1_2)
	end

	return
end

function var_0_0.ModifyNameByItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0, var_2_1 = arg_2_1:canModifyName()

	if not var_2_0 then
		pg.TipsMgr.GetInstance():ShowTips(var_2_1)

		return
	end

	local var_2_2 = getProxy(PlayerProxy)
	local var_2_3 = arg_2_1:getModifyNameComsume()
	local var_2_4

	if var_2_3[1] == DROP_TYPE_RESOURCE then
		if arg_2_1:getResById(var_2_3[2]) < var_2_3[3] then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_resource"))

			return
		end

		var_2_4 = Drop.New({
			type = DROP_TYPE_ITEM,
			id = id2ItemId(var_2_3[2]),
			count = var_2_3[3]
		})
	elseif var_2_3[1] == DROP_TYPE_ITEM then
		local var_2_5 = getProxy(BagProxy):getItemById(var_2_3[2])

		if not var_2_5 or var_2_5.count < var_2_3[3] then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_no_item_1"))

			return
		end

		var_2_4 = Drop.New({
			type = DROP_TYPE_ITEM,
			id = var_2_3[2],
			count = var_2_3[3]
		})
	else
		assert(false, "type is not supported >> " .. var_2_3[1])

		return
	end

	local var_2_6 = pg.gameset.player_name_cold_time.key_value

	local function var_2_7()
		pg.ConnectionMgr.GetInstance():Send(11007, {
			type = 1,
			name = arg_2_2
		}, 11008, function(arg_4_0)
			if arg_4_0.result == 0 then
				arg_2_1.name = arg_2_2

				arg_2_1:updateModifyNameColdTime(pg.TimeMgr.GetInstance():GetServerTime() + var_2_6)
				var_2_2:updatePlayer(arg_2_1)
				arg_2_0:sendNotification(GAME.CONSUME_ITEM, Drop.Create(var_2_3))

				if arg_2_3 then
					arg_2_3()
				end

				arg_2_0:sendNotification(GAME.CHANGE_PLAYER_NAME_DONE)
				pg.TipsMgr.GetInstance():ShowTips(i18n("player_changePlayerName_ok"))
			else
				pg.TipsMgr.GetInstance():ShowTips(errorTip("player_changePlayerName", arg_4_0.result))
			end

			return
		end)

		return
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		content = i18n("player_name_change_warning", var_2_4.count, var_2_4:getConfig("name"), arg_2_2),
		onYes = function()
			var_2_7()

			return
		end
	})

	return
end

function var_0_0.ForceModifyName(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = getProxy(PlayerProxy)

	pg.ConnectionMgr.GetInstance():Send(11007, {
		type = 2,
		name = arg_6_2
	}, 11008, function(arg_7_0)
		if arg_7_0.result == 0 then
			arg_6_1.name = arg_6_2

			arg_6_1:CancelCommonFlag(ILLEGALITY_PLAYER_NAME)
			var_6_0:updatePlayer(arg_6_1)

			if arg_6_3 then
				arg_6_3()
			end

			arg_6_0:sendNotification(GAME.CHANGE_PLAYER_NAME_DONE)
			pg.TipsMgr.GetInstance():ShowTips(i18n("player_changePlayerName_ok"))
		else
			pg.TipsMgr.GetInstance():ShowTips(errorTip("player_changePlayerName", arg_7_0.result))
		end

		return
	end)

	return
end

return var_0_0
