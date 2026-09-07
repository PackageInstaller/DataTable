local AtelierMediator = class("AtelierMediator", import("view.base.ContextMediator"))

function AtelierMediator:register()
	self:bind(GAME.UPDATE_ATELIER_BUFF, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.UPDATE_ATELIER_BUFF, arg_2_1)

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

	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ATELIER_LINK)

	assert(var_1_0 and not var_1_0:isEnd())
	self.viewComponent:SetActivity(var_1_0)

	return
end

function AtelierMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.UPDATE_ATELIER_BUFF_DONE
	}
end

function AtelierMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == nil then
		-- block empty
	elseif var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_ATELIER_LINK then
			self.viewComponent:SetActivity(var_5_1)
		end
	elseif var_5_0 == GAME.UPDATE_ATELIER_BUFF_DONE then
		self.viewComponent:OnUpdateAtelierBuff()
	end

	return
end

function AtelierMediator:remove()
	return
end

return AtelierMediator
