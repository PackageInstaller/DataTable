local AtelierCompositeMediator = class("AtelierCompositeMediator", import("view.base.ContextMediator"))

AtelierCompositeMediator.OPEN_FORMULA = "OPEN_FORMULA"

function AtelierCompositeMediator:register()
	self:bind(GAME.COMPOSITE_ATELIER_RECIPE, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.COMPOSITE_ATELIER_RECIPE, {
			formulaId = self.contextData.formulaId,
			items = arg_2_1,
			repeats = arg_2_2
		})

		return
	end)
	self:bind(AtelierMaterialDetailMediator.SHOW_DETAIL, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_1:GetVersion() == 1 and AtelierMaterialDetailLayer or AtelierMaterialDetailYumiaLayer

		self:addSubLayers(Context.New({
			mediator = AtelierMaterialDetailMediator,
			viewComponent = var_3_0,
			data = {
				material = arg_3_1
			}
		}))

		return
	end)
	self.viewComponent:InitView()

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

	self.viewComponent:SetEnabled((AtelierTools.IsUnlockAtelier(var_1_0, self.contextData.versionIndex or 1)))
	self.viewComponent:SetActivity(var_1_0)

	return
end

function AtelierCompositeMediator:listNotificationInterests()
	return {
		GAME.COMPOSITE_ATELIER_RECIPE_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		AtelierCompositeMediator.OPEN_FORMULA
	}
end

function AtelierCompositeMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == GAME.COMPOSITE_ATELIER_RECIPE_DONE then
		self.viewComponent:OnCompositeResult(var_5_1)
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_ATELIER_LINK then
			self.viewComponent:SetActivity(var_5_1)
		end
	elseif var_5_0 == AtelierCompositeMediator.OPEN_FORMULA then
		self.viewComponent:OnReceiveFormualRequest(var_5_1)
	end

	return
end

function AtelierCompositeMediator:remove()
	return
end

return AtelierCompositeMediator
