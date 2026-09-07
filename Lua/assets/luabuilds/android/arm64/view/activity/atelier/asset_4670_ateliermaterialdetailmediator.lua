local AtelierMaterialDetailMediator = class("AtelierMaterialDetailMediator", import("view.base.ContextMediator"))

AtelierMaterialDetailMediator.SHOW_DETAIL = "SHOW_DETAIL"
AtelierMaterialDetailMediator.GO_RECIPE = "GO_RECIPE"

function AtelierMaterialDetailMediator:register()
	self:bind(GAME.GO_SCENE, function(arg_2_0, arg_2_1, arg_2_2)
		self.viewComponent:closeView()
		self:sendNotification(GAME.GO_SCENE, arg_2_1, arg_2_2)

		return
	end)
	self:bind(AtelierMaterialDetailMediator.GO_RECIPE, function(arg_3_0, arg_3_1)
		self.viewComponent:closeView()
		self:sendNotification(GAME.GO_SCENE, SCENE.ATELIER_COMPOSITE, {
			formulaId = arg_3_1,
			activityID = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK).id
		})

		return
	end)

	return
end

function AtelierMaterialDetailMediator:listNotificationInterests()
	return {}
end

function AtelierMaterialDetailMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getBody()

	if arg_5_1:getName() == nil then
		-- block empty
	end

	return
end

function AtelierMaterialDetailMediator:remove()
	return
end

return AtelierMaterialDetailMediator
