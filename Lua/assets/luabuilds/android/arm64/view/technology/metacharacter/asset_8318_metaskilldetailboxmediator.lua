local MetaSkillDetailBoxMediator = class("MetaSkillDetailBoxMediator", import("...base.ContextMediator"))

function MetaSkillDetailBoxMediator:register()
	return
end

function MetaSkillDetailBoxMediator:listNotificationInterests()
	return {
		GAME.TACTICS_META_UNLOCK_SKILL_DONE,
		GAME.TACTICS_META_SWITCH_SKILL_DONE
	}
end

function MetaSkillDetailBoxMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == GAME.TACTICS_META_UNLOCK_SKILL_DONE or var_3_0 == GAME.TACTICS_META_SWITCH_SKILL_DONE then
		if var_3_0 == GAME.TACTICS_META_SWITCH_SKILL_DONE then
			if self.contextData.expInfoList and #self.contextData.expInfoList > 0 then
				local var_3_2

				for iter_3_0, iter_3_1 in ipairs(self.contextData.expInfoList) do
					if iter_3_1.shipID == self.contextData.metaShipID and iter_3_1.isUpLevel and iter_3_1.isMaxLevel then
						var_3_2 = iter_3_0
					end
				end

				if var_3_2 then
					self.contextData.expInfoList[var_3_2].isUpLevel = false
					self.contextData.expInfoList[var_3_2].isMaxLevel = false
				end
			end
		end

		self.viewComponent:updateSkillList()
	end

	return
end

return MetaSkillDetailBoxMediator
