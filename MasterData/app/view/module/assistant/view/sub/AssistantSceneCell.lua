local AssistantSceneCell = class("AssistantSceneCell", require("app.fairyGUI.assistant.UI_AssistantSceneCell"))
local var_0_1 = g.core.common.Path

function AssistantSceneCell:ctor()
	self.getSharedTrans(self, "listCardAUiRightIn02", "CombineBagList", self)
end

function AssistantSceneCell:updateComp(arg_2_1, arg_2_2)
	if arg_2_1.cfg.pic ~= "" and arg_2_1.cfg.pic ~= "0" then
		self.m_scenePicLoader:setURL(var_0_1:getMainSceneIcon(arg_2_1.cfg.pic))
	end

	self.m_isUnlockController:setSelectedIndex(arg_2_1.isUnlock and 1 or 0)
	self.m_isUseController:setSelectedIndex(0)

	if arg_2_1.isUnlock then
		local var_2_0 = g.core.model.User.userActiveSceneData:getSceneId()

		if arg_2_1.cfg.id == ((arg_2_2 or nil) and g.core.model.User:getNominateInfo(arg_2_2).bg) then
			self.m_isUseController:setSelectedIndex(1)
		end
	else
		self.m_unlockText:setText(arg_2_1.cfg.lock_direction)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			sceneId = arg_2_1.cfg.id
		}
	})
end

return AssistantSceneCell
