local Dorm3dPhotoShareLayerMediator = class("Dorm3dPhotoShareLayerMediator", import("view.base.ContextMediator"))

Dorm3dPhotoShareLayerMediator.SELECTFRAME = "Dorm3dPhotoShareLayerMediator:SELECTFRAME"
Dorm3dPhotoShareLayerMediator.EXIT_SHARE = "Dorm3dPhotoShareLayerMediator:EXIT_SHARE"

function Dorm3dPhotoShareLayerMediator:register()
	self:bind(Dorm3dPhotoShareLayerMediator.SELECTFRAME, function(arg_2_0, arg_2_1, arg_2_2)
		self:addSubLayers(Context.New({
			mediator = Dorm3dPhotoSelectFrameMediator,
			viewComponent = Dorm3dPhotoSelectFrame,
			data = {
				photoTex = arg_2_1,
				photoData = arg_2_2
			}
		}))

		return
	end)
	self:bind(Dorm3dPhotoShareLayerMediator.EXIT_SHARE, function()
		self:sendNotification(Dorm3dPhotoShareLayerMediator.EXIT_SHARE)

		return
	end)

	return
end

function Dorm3dPhotoShareLayerMediator:initNotificationHandleDic()
	self.handleDic = {
		[Dorm3dPhotoSelectFrameMediator.CONFIRMFRAME] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:AfterSelectFrame((arg_5_1:getBody()))

			return
		end
	}

	return
end

return Dorm3dPhotoShareLayerMediator
