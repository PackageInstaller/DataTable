class = var_0_10000

local var_0_0 = "RemasterAwardReceiveCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().chapterId
	local var_1_1 = var_2.pos
	local var_1_2

	if not var_2.actId then
		var_1_2 = 0
	end

	getProxy = var_1_10006
	ChapterProxy = var_1_10008

	local var_1_3 = var_1_10006(var_1_10008)

	if not var_6.getRemasterInfo(var_1_3, var_1_2, var_1_0, var_1_1) or var_7.receive then
		return
	end

	pg = var_1_10008

	local var_1_4 = var_1_10008.ConnectionMgr.GetInstance()

	var_8.Send(var_1_4, 13507, {
		chapter_id = var_1_0,
		pos = var_1_1,
		act_id = var_1_2
	}, 13508, function(arg_2_0)
		local var_2_1

		if arg_2_0.result == 0 then
			local var_2_0 = var_0

			var_2_1.markRemasterPassReceive(var_2_0, var_1_0, var_1_1, var_1_2)

			PlayerConst = var_2_1
			var_2_1 = var_2_1.addTranDrop(arg_2_0.drop_list)
			var_2_10004 = arg_1_0

			local var_2_2 = var_2.sendNotification

			GAME = var_5

			var_2_2(var_2_10004, var_5.CHAPTER_REMASTER_AWARD_RECEIVE_DONE, var_2_1)
		else
			pg = var_2_1

			local var_2_3 = var_2_1.TipsMgr.GetInstance()
			local var_2_4 = var_1.ShowTips

			errorTip = var_2_10004

			var_2_4(var_2_3, var_2_10004("", arg_2_0.result))
		end

		return
	end)

	return
end

return var_0_1
