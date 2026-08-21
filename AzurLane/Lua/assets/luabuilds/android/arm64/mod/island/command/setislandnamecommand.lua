local var_0_0 = class("SetIslandNameCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0.name
	local var_1_2 = var_1_0.currency

	if not getProxy(IslandProxy):GetIsland():CanModifyName() then
		return
	end

	if not nameValidityCheck(var_1_0.name, 1, 18, {
		"island_name_exist_special_word",
		"island_name_too_long_or_too_short",
		"island_name_too_long_or_too_short",
		"island_name_exist_ban_word"
	}) then
		return
	end

	if var_1_0.currency == 2 then
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("island_rename_tip"),
			onYes = function()
				arg_1_0:Send(var_1_1, var_1_2)

				return
			end
		})
	else
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			content = i18n("island_rename_confirm", var_1_0.name),
			onYes = function()
				arg_1_0:Send(var_1_1, var_1_2)

				return
			end
		})
	end

	return
end

function var_0_0.Send(arg_4_0, arg_4_1, arg_4_2)
	pg.ConnectionMgr.GetInstance():Send(21004, {
		name = arg_4_1,
		type = arg_4_2
	}, 21005, function(arg_5_0)
		if arg_5_0.ret == 0 then
			local var_5_0 = getProxy(IslandProxy):GetIsland()

			if not var_5_0:IsNew() then
				-- block empty
			end

			var_5_0:SetName(arg_4_1)
			arg_4_0:sendNotification(GAME.ISLAND_SET_NAME_DONE, {
				name = arg_4_1
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_5_0.ret] .. arg_5_0.ret)
		end

		return
	end)

	return
end

return var_0_0
