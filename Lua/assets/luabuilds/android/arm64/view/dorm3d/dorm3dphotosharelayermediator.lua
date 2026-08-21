local var_0_0 = class("Dorm3dPhotoShareLayerMediator", import("view.base.ContextMediator"))

var_0_0.SELECTFRAME = "Dorm3dPhotoShareLayerMediator:SELECTFRAME"
var_0_0.EXIT_SHARE = "Dorm3dPhotoShareLayerMediator:EXIT_SHARE"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SELECTFRAME, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = Dorm3dPhotoSelectFrameMediator,
			viewComponent = Dorm3dPhotoSelectFrame,
			data = {
				photoTex = arg_2_1,
				photoData = arg_2_2
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.EXIT_SHARE, function()
		arg_1_0:sendNotification(var_0_0.EXIT_SHARE)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_4_0)
	arg_4_0.handleDic = {
		[Dorm3dPhotoSelectFrameMediator.CONFIRMFRAME] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:AfterSelectFrame((arg_5_1:getBody()))

			return
		end
	}

	return
end

return var_0_0
