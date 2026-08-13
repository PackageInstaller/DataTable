class = var_0_10000

local var_0_0 = "NewTrackingCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody().type
	local var_1_1 = var_2.eventId
	local var_1_2

	if not var_2.para1 then
		var_1_2 = ""
	end

	local var_1_3

	if not var_2.para2 then
		var_1_3 = ""
	end

	local var_1_4

	if not var_2.para3 then
		var_1_4 = ""
	end

	print = var_1_10008

	var_1_10008(var_1_0, var_1_1, var_1_2, var_1_3)

	pg = var_1_10008

	local var_1_5 = var_1_10008.ConnectionMgr.GetInstance()

	var_8.Send(var_1_5, 10992, {
		track_type = var_1_0,
		event_id = var_1_1,
		para1 = var_1_2,
		para2 = var_1_3,
		para3 = var_1_4
	})

	return
end

return var_0_1
