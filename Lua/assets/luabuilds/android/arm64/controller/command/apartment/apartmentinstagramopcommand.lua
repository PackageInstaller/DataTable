local var_0_0 = class("ApartmentInstagramOpCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = _.detect(getProxy(Dorm3dInsProxy):GetInstagramList(var_1_0.shipId), function(arg_2_0)
		return arg_2_0.id == var_1_0.id
	end)

	if not var_1_1 then
		return
	end

	if var_1_0.op == Instagram3Dorm.OP_DISCUSS then
		arg_1_0:HandleDiscuss(var_1_1, var_1_0)
	elseif var_1_0.op == Instagram3Dorm.OP_READ then
		arg_1_0:HandleRead(var_1_1, var_1_0)
	elseif var_1_0.op == Instagram3Dorm.OP_LIKE then
		arg_1_0:HandleLike(var_1_1, var_1_0)
	elseif var_1_0.op == Instagram3Dorm.OP_SHARE then
		arg_1_0:HandleShare(var_1_1, var_1_0)
	elseif var_1_0.op == Instagram3Dorm.OP_EXIT then
		arg_1_0:HandleExit(var_1_1, var_1_0)
	end

	return
end

function var_0_0.HandleDiscuss(arg_3_0, arg_3_1, arg_3_2)
	pg.ConnectionMgr.GetInstance():Send(28028, {
		ship_id = arg_3_2.shipId,
		type = arg_3_2.op,
		id = arg_3_2.id,
		chat_id = arg_3_2.commentId,
		value = arg_3_2.index
	}, 28029, function(arg_4_0)
		if arg_4_0.result == 0 then
			arg_3_1:MarkReply(arg_3_2.commentId, arg_3_2.index)
			arg_3_0:sendNotification(GAME.APARTMENT_INS_OP_DONE, {
				op = arg_3_2.op
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_4_0.result] .. arg_4_0.result)
		end

		return
	end)

	return
end

function var_0_0.HandleRead(arg_5_0, arg_5_1, arg_5_2)
	pg.ConnectionMgr.GetInstance():Send(28026, {
		ship_id = arg_5_2.shipId,
		type = arg_5_2.op,
		id_list = {
			arg_5_2.id
		}
	}, 28027, function(arg_6_0)
		if arg_6_0.result == 0 then
			arg_5_1:MarkRead()
			arg_5_0:sendNotification(GAME.APARTMENT_INS_OP_DONE, {
				op = arg_5_2.op
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_6_0.result] .. arg_6_0.result)
		end

		return
	end)

	return
end

function var_0_0.HandleLike(arg_7_0, arg_7_1, arg_7_2)
	pg.ConnectionMgr.GetInstance():Send(28026, {
		ship_id = arg_7_2.shipId,
		type = arg_7_2.op,
		id_list = {
			arg_7_2.id
		}
	}, 28027, function(arg_8_0)
		if arg_8_0.result == 0 then
			arg_7_1:MarkLike()
			arg_7_0:sendNotification(GAME.APARTMENT_INS_OP_DONE, {
				op = arg_7_2.op
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_8_0.result] .. arg_8_0.result)
		end

		return
	end)

	return
end

function var_0_0.HandleShare(arg_9_0, arg_9_1, arg_9_2)
	pg.ConnectionMgr.GetInstance():Send(28026, {
		ship_id = arg_9_2.shipId,
		type = arg_9_2.op,
		id_list = {
			arg_9_2.id
		}
	}, 28027, function(arg_10_0)
		if arg_10_0.result == 0 then
			pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeInstagram)
			arg_9_0:sendNotification(GAME.APARTMENT_INS_OP_DONE, {
				op = arg_9_2.op
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_10_0.result] .. arg_10_0.result)
		end

		return
	end)

	return
end

function var_0_0.HandleExit(arg_11_0, arg_11_1, arg_11_2)
	pg.ConnectionMgr.GetInstance():Send(28026, {
		ship_id = arg_11_2.shipId,
		type = arg_11_2.op,
		id_list = {
			arg_11_2.id
		}
	}, 28027, function(arg_12_0)
		if arg_12_0.result == 0 then
			arg_11_1:SetExitTime(pg.TimeMgr.GetInstance():GetServerTime())
			arg_11_0:sendNotification(GAME.APARTMENT_INS_OP_DONE, {
				op = arg_11_2.op
			})
		else
			pg.TipsMgr.GetInstance():ShowTips(ERROR_MESSAGE[arg_12_0.result] .. arg_12_0.result)
		end

		return
	end)

	return
end

return var_0_0
