class = var_0_10000

local var_0_0 = "ApartmentInstagramOpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getBody(var_1_0).op

	getProxy = var_1_0
	Dorm3dInsProxy = var_1_10006

	local var_1_2 = var_1_0(var_1_10006)
	local var_1_3 = var_4.GetInstagramList(var_1_2, var_2.shipId)

	_ = var_1_10005

	if not var_1_10005.detect(var_1_3, function(arg_2_0)
		return arg_2_0.id == var_0.id
	end) then
		return
	end

	Instagram3Dorm = var_1_2

	if var_1_1 == var_1_2.OP_DISCUSS then
		arg_1_0:HandleDiscuss(var_5, var_2)
	else
		Instagram3Dorm = var_6

		if var_1_1 == var_6.OP_READ then
			arg_1_0:HandleRead(var_5, var_2)
		else
			Instagram3Dorm = var_6

			if var_1_1 == var_6.OP_LIKE then
				arg_1_0:HandleLike(var_5, var_2)
			else
				Instagram3Dorm = var_6

				if var_1_1 == var_6.OP_SHARE then
					arg_1_0:HandleShare(var_5, var_2)
				else
					Instagram3Dorm = var_6

					if var_1_1 == var_6.OP_EXIT then
						arg_1_0:HandleExit(var_5, var_2)
					end
				end
			end
		end
	end

	return
end

function var_0_1.HandleDiscuss(arg_3_0, arg_3_1, arg_3_2)
	pg = var_1_10003

	local var_3_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_3_0, 28028, {
		ship_id = arg_3_2.shipId,
		type = arg_3_2.op,
		id = arg_3_2.id,
		chat_id = arg_3_2.commentId,
		value = arg_3_2.index
	}, 28029, function(arg_4_0)
		local var_4_2

		if arg_4_0.result == 0 then
			local var_4_0 = arg_3_1

			var_4_2.MarkReply(var_4_0, arg_3_2.commentId, arg_3_2.index)

			local var_4_1 = arg_3_0

			var_4_2 = var_4_2.sendNotification
			GAME = var_2_10004

			var_4_2(var_4_1, var_2_10004.APARTMENT_INS_OP_DONE, {
				op = arg_3_2.op
			})
		else
			pg = var_4_2

			local var_4_3 = var_4_2.TipsMgr.GetInstance()
			local var_4_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_4_4(var_4_3, var_2_10004[arg_4_0.result] .. arg_4_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleRead(arg_5_0, arg_5_1, arg_5_2)
	pg = var_1_10003

	local var_5_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_5_0, 28026, {
		ship_id = arg_5_2.shipId,
		type = arg_5_2.op,
		id_list = {
			arg_5_2.id
		}
	}, 28027, function(arg_6_0)
		local var_6_2

		if arg_6_0.result == 0 then
			local var_6_0 = arg_5_1

			var_6_2.MarkRead(var_6_0)

			local var_6_1 = arg_5_0

			var_6_2 = var_6_2.sendNotification
			GAME = var_2_10004

			var_6_2(var_6_1, var_2_10004.APARTMENT_INS_OP_DONE, {
				op = arg_5_2.op
			})
		else
			pg = var_6_2

			local var_6_3 = var_6_2.TipsMgr.GetInstance()
			local var_6_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_6_4(var_6_3, var_2_10004[arg_6_0.result] .. arg_6_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleLike(arg_7_0, arg_7_1, arg_7_2)
	pg = var_1_10003

	local var_7_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_7_0, 28026, {
		ship_id = arg_7_2.shipId,
		type = arg_7_2.op,
		id_list = {
			arg_7_2.id
		}
	}, 28027, function(arg_8_0)
		local var_8_2

		if arg_8_0.result == 0 then
			local var_8_0 = arg_7_1

			var_8_2.MarkLike(var_8_0)

			local var_8_1 = arg_7_0

			var_8_2 = var_8_2.sendNotification
			GAME = var_2_10004

			var_8_2(var_8_1, var_2_10004.APARTMENT_INS_OP_DONE, {
				op = arg_7_2.op
			})
		else
			pg = var_8_2

			local var_8_3 = var_8_2.TipsMgr.GetInstance()
			local var_8_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_8_4(var_8_3, var_2_10004[arg_8_0.result] .. arg_8_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleShare(arg_9_0, arg_9_1, arg_9_2)
	pg = var_1_10003

	local var_9_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_9_0, 28026, {
		ship_id = arg_9_2.shipId,
		type = arg_9_2.op,
		id_list = {
			arg_9_2.id
		}
	}, 28027, function(arg_10_0)
		local var_10_1

		if arg_10_0.result == 0 then
			pg = var_10_1

			local var_10_0 = var_10_1.ShareMgr.GetInstance()

			var_10_1 = var_10_1.Share
			pg = var_2_10004

			var_10_1(var_10_0, var_2_10004.ShareMgr.TypeInstagram)

			local var_10_2 = arg_9_0

			var_10_1 = var_10_1.sendNotification
			GAME = var_2_10004

			var_10_1(var_10_2, var_2_10004.APARTMENT_INS_OP_DONE, {
				op = arg_9_2.op
			})
		else
			pg = var_10_1

			local var_10_3 = var_10_1.TipsMgr.GetInstance()
			local var_10_4 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_10_4(var_10_3, var_2_10004[arg_10_0.result] .. arg_10_0.result)
		end

		return
	end)

	return
end

function var_0_1.HandleExit(arg_11_0, arg_11_1, arg_11_2)
	pg = var_1_10003

	local var_11_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.Send(var_11_0, 28026, {
		ship_id = arg_11_2.shipId,
		type = arg_11_2.op,
		id_list = {
			arg_11_2.id
		}
	}, 28027, function(arg_12_0)
		local var_12_1

		if arg_12_0.result == 0 then
			local var_12_0 = arg_11_1

			var_12_1 = var_12_1.SetExitTime
			pg = var_2_10004

			local var_12_2 = var_2_10004.TimeMgr.GetInstance()

			var_12_1(var_12_0, var_2_10004.GetServerTime(var_12_2))

			local var_12_3 = arg_11_0

			var_12_1 = var_12_1.sendNotification
			GAME = var_2_10004

			var_12_1(var_12_3, var_2_10004.APARTMENT_INS_OP_DONE, {
				op = arg_11_2.op
			})
		else
			pg = var_12_1

			local var_12_4 = var_12_1.TipsMgr.GetInstance()
			local var_12_5 = var_1.ShowTips

			ERROR_MESSAGE = var_2_10004

			var_12_5(var_12_4, var_2_10004[arg_12_0.result] .. arg_12_0.result)
		end

		return
	end)

	return
end

return var_0_1
