class = var_0_10000

local var_0_0 = var_0_10000("MainRequestNewInstagramDataSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	InstagramProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)

	if var_2.IsReqNewInstagramData(var_1_0) then
		arg_1_1()

		return
	end

	getProxy = var_2
	InstagramProxy = var_1_0

	local var_1_1 = var_2(var_1_0)
	local var_1_2 = var_2.GetNewInstagramIds(var_1_1)

	pg = var_1_10003

	local var_1_3 = var_1_10003.m02
	local var_1_4 = var_3.sendNotification

	GAME = var_1_10006

	var_1_4(var_1_3, var_1_10006.REQ_NEW_INSTAGRAM_DATA, {
		idList = var_1_2,
		callback = arg_1_1
	})

	return
end

return var_0_0
