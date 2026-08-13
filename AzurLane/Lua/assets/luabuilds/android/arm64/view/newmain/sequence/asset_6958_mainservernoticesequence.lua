class = var_0_10000

local var_0_0 = "MainServerNoticeSequence"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MainSublayerSequence"))

function var_0_1.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	ServerNoticeProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)

	if #var_2.getServerNotices(var_1_0, false) > 0 and var_2:needAutoOpen() then
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_0.AddSubLayers

		Context = var_1_10007

		local var_1_3 = var_1_10007.New
		local var_1_4 = {}

		NewBulletinBoardMediator = var_1_10010
		var_1_4.mediator = var_1_10010
		NewBulletinBoardLayer = var_1_10010
		var_1_4.viewComponent = var_1_10010
		var_1_4.onRemoved = arg_1_1

		var_1_2(var_1_1, var_1_3(var_1_4))
	else
		arg_1_1()
	end

	return
end

return var_0_1
