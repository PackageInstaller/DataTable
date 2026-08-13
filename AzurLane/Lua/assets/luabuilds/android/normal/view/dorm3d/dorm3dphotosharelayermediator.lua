class = var_0_10000

local var_0_0 = "Dorm3dPhotoShareLayerMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.SELECTFRAME = "Dorm3dPhotoShareLayerMediator:SELECTFRAME"
var_0_1.EXIT_SHARE = "Dorm3dPhotoShareLayerMediator:EXIT_SHARE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.SELECTFRAME, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		Dorm3dPhotoSelectFrameMediator = var_2_10007
		var_2_3.mediator = var_2_10007
		Dorm3dPhotoSelectFrame = var_2_10007
		var_2_3.viewComponent = var_2_10007
		var_2_3.data = {
			photoTex = arg_2_1,
			photoData = arg_2_2
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.EXIT_SHARE, function()
		local var_3_0 = arg_1_0

		var_0.sendNotification(var_3_0, var_0_1.EXIT_SHARE)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_4_0)
	local var_4_0 = {}

	Dorm3dPhotoSelectFrameMediator = var_1_10002
	var_4_0[var_1_10002.CONFIRMFRAME] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_5_1:getBody()
		local var_5_1 = arg_5_0.viewComponent

		var_3.AfterSelectFrame(var_5_1, var_5_0)

		return
	end
	arg_4_0.handleDic = var_4_0

	return
end

return var_0_1
