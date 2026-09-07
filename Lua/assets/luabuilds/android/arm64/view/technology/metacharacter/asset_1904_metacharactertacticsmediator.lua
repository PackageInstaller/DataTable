local MetaCharacterTacticsMediator = class("MetaCharacterTacticsMediator", import("...base.ContextMediator"))

MetaCharacterTacticsMediator.GO_TASK = "MetaCharacterTacticsMediator:GO_TASK"
MetaCharacterTacticsMediator.ON_SUBMIT = "MetaCharacterTacticsMediator:ON_SUBMIT"
MetaCharacterTacticsMediator.ON_TRIGGER = "MetaCharacterTacticsMediator:ON_TRIGGER"
MetaCharacterTacticsMediator.ON_SKILL = "MetaCharacterTacticsMediator:ON_SKILL"
MetaCharacterTacticsMediator.ON_QUICK = "MetaCharacterTacticsMediator:ON_QUICK"

function MetaCharacterTacticsMediator:register()
	self:requestTacticsData()
	self:bindEvent()

	return
end

function MetaCharacterTacticsMediator:listNotificationInterests()
	return {
		GAME.TACTICS_META_INFO_REQUEST_DONE,
		GAME.TACTICS_META_UNLOCK_SKILL_DONE,
		GAME.TACTICS_META_SWITCH_SKILL_DONE,
		GAME.TACTICS_META_LEVELUP_SKILL_DONE,
		GAME.META_QUICK_TACTICS_DONE
	}
end

function MetaCharacterTacticsMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == GAME.TACTICS_META_INFO_REQUEST_DONE then
		self.viewComponent:setTacticsData(var_3_1)
		self.viewComponent:updateTacticsRedTag()
		self.viewComponent:updateExpPanel()
		self.viewComponent:updateMain()
		self.viewComponent:updateSkillTFLearning()
	elseif var_3_0 == GAME.TACTICS_META_UNLOCK_SKILL_DONE then
		self.viewComponent:updateData()
		self.viewComponent:updateSkillListPanel()
		self.viewComponent:updateMain()

		if self.viewComponent:isAllSkillLock() then
			self.viewComponent:tryLearnSkillAfterFirstUnlock()
		end

		self.viewComponent:closeUnlockSkillPanel()
	elseif var_3_0 == GAME.TACTICS_META_SWITCH_SKILL_DONE then
		self.viewComponent:switchTacticsSkillData(var_3_1.skillID, var_3_1.leftSwitchCount)
		self.viewComponent:updateExpPanel()
		self.viewComponent:updateTaskPanel(var_3_1.skillID)
		self.viewComponent:updateSkillTFLearning()
	elseif var_3_0 == GAME.TACTICS_META_LEVELUP_SKILL_DONE then
		self.viewComponent:updateData()
		self.viewComponent:levelupTacticsSkillData(var_3_1.skillID, var_3_1.leftSwitchCount)
		self.viewComponent:updateTacticsRedTag()
		self.viewComponent:updateSkillListPanel()
		self.viewComponent:updateTaskPanel(var_3_1.skillID)
	elseif var_3_0 == GAME.META_QUICK_TACTICS_DONE then
		if var_3_1.isLevelUp then
			self.viewComponent:clearTaskInfo(var_3_1.skillID)
		end

		self.viewComponent:updateSkillExp(var_3_1.skillID, var_3_1.skillExp)
		self.viewComponent:updateData()
		self.viewComponent:updateTacticsRedTag()
		self.viewComponent:updateSkillListPanel()
		self.viewComponent:updateTaskPanel(var_3_1.skillID)
	end

	return
end

function MetaCharacterTacticsMediator:bindEvent()
	self:bind(MetaCharacterTacticsMediator.ON_QUICK, function(arg_5_0, arg_5_1, arg_5_2)
		self:addSubLayers(Context.New({
			mediator = MetaQuickTacticsMediator,
			viewComponent = MetaQuickTacticsLayer,
			data = {
				shipID = arg_5_1,
				skillID = arg_5_2
			}
		}))

		return
	end)

	return
end

function MetaCharacterTacticsMediator:requestTacticsData()
	self:sendNotification(GAME.TACTICS_META_INFO_REQUEST, {
		id = self.contextData.shipID
	})

	return
end

return MetaCharacterTacticsMediator
