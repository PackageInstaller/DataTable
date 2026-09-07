local MetaCharacterRepairMediator = class("MetaCharacterRepairMediator", import("...base.ContextMediator"))

function MetaCharacterRepairMediator:register()
	return
end

function MetaCharacterRepairMediator:listNotificationInterests()
	return {
		GAME.REPAIR_META_CHARACTER_DONE
	}
end

function MetaCharacterRepairMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.REPAIR_META_CHARACTER_DONE then
		self.viewComponent:checkSpecialEffect()
		self.viewComponent:updateData()
		self.viewComponent:doRepairProgressPanelAni()
		self.viewComponent:updateAttrItem(self.viewComponent.attrTFList[self.viewComponent.curAttrName], self.viewComponent.curAttrName)
		self.viewComponent:updateRepairBtn()
		self.viewComponent:updateDetailPanel()
	end

	return
end

return MetaCharacterRepairMediator
