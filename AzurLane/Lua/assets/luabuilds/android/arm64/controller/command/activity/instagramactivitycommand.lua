local var_0_0 = class("InstagramActivityCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = getProxy(InstagramProxy)

	if ActivityConst.INSTAGRAM_OP_ACTIVE == var_1_0.cmd then
		pg.ConnectionMgr.GetInstance():Send(11701, {
			cmd = 1,
			id = var_1_0.arg1
		}, 11702, function(arg_2_0)
			if arg_2_0.result == 0 then
				var_1_1:UpdateMessage((Instagram.New(arg_2_0.data)))
				var_1_1:AddInstagramTimer()
				arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_OP_DONE, {
					cmd = var_1_0.cmd,
					id = var_1_0.arg1
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_2_0.result] .. arg_2_0.result)
			end

			return
		end)
	elseif ActivityConst.INSTAGRAM_OP_LIKE == var_1_0.cmd or ActivityConst.INSTAGRAM_OP_MARK_READ == var_1_0.cmd or ActivityConst.INSTAGRAM_OP_UPDATE == var_1_0.cmd or ActivityConst.INSTAGRAM_OP_SHARE == var_1_0.cmd then
		pg.ConnectionMgr.GetInstance():Send(11701, {
			id = var_1_0.arg1,
			cmd = var_1_0.cmd
		}, 11702, function(arg_3_0)
			if arg_3_0.result == 0 then
				if ActivityConst.INSTAGRAM_OP_MARK_READ == var_1_0.cmd then
					local var_3_0 = pg.activity_ins_template[var_1_0.arg1].type == InstagramConst.INSTAGRAM_TYPE.OFFICIAL_ACCOUNT and var_1_1:GetOfficialAccounts()[var_1_0.arg1] or var_1_1:GetMessageById(var_1_0.arg1)

					var_3_0.isRead = true

					var_1_1:UpdateMessage(var_3_0)
				elseif ActivityConst.INSTAGRAM_OP_SHARE ~= var_1_0.cmd then
					var_1_1:UpdateMessage((Instagram.New(arg_3_0.data)))
				end

				arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_OP_DONE, {
					cmd = var_1_0.cmd,
					id = var_1_0.arg1
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_3_0.result] .. arg_3_0.result)
			end

			return
		end)
	elseif ActivityConst.INSTAGRAM_OP_COMMENT == var_1_0.cmd then
		pg.ConnectionMgr.GetInstance():Send(11703, {
			id = var_1_0.arg1,
			discuss = var_1_0.arg2,
			index = var_1_0.arg3
		}, 11704, function(arg_4_0)
			if arg_4_0.result == 0 then
				var_1_1:UpdateMessage((Instagram.New(arg_4_0.data)))
				arg_1_0:sendNotification(GAME.ACT_INSTAGRAM_OP_DONE, {
					cmd = var_1_0.cmd,
					id = var_1_0.arg1
				})

				if var_1_0.callback then
					var_1_0.callback()
				end
			else
				pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_4_0.result] .. arg_4_0.result)
			end

			return
		end)
	end

	return
end

return var_0_0
