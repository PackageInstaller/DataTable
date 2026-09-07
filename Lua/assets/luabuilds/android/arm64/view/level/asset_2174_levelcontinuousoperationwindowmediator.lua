local LevelContinuousOperationWindowMediator = class("LevelContinuousOperationWindowMediator", import("view.base.ContextMediator"))

function LevelContinuousOperationWindowMediator:register()
	self:bind(PreCombatMediator.CONTINUOUS_OPERATION, function(arg_2_0)
		self:sendNotification(LevelUIConst.CONTINUOUS_OPERATION, {
			battleTimes = math.min(self.contextData.battleTimes, 10)
		})

		return
	end)
	self:bind(LevelMediator2.ON_SPITEM_CHANGED, function(arg_3_0, arg_3_1)
		self:sendNotification(LevelMediator2.ON_SPITEM_CHANGED, arg_3_1)

		return
	end)

	return
end

function LevelContinuousOperationWindowMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED
	}
end

function LevelContinuousOperationWindowMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	if var_5_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_5_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
			self.viewComponent:SetActivity(var_5_1)
		end
	elseif var_5_0 == PlayerProxy.UPDATED then
		self.viewComponent:UpdateContent()
	end

	return
end

function LevelContinuousOperationWindowMediator:remove()
	return
end

return LevelContinuousOperationWindowMediator
