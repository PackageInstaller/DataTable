local MineUniteSkillBtn = class("MineUniteSkillBtn", require("app.fairyGUI.mine.UI_MineUniteSkillBtn"))

function MineUniteSkillBtn:ctor()
	self.m_iconComp:setCtrlState("showUnitCost", {
		index = 0
	})
end

function MineUniteSkillBtn:update(arg_2_1)
	if arg_2_1.baseId then
		self.m_hasSkillController:setSelectedIndex(1)

		local var_2_0 = g.core.config.unite_token_info.get(arg_2_1.baseId).skill_id

		self._skillInfo = g.core.model.User.uniteTokenData:getTokenBaseInfo(var_2_0).skillInfo

		self.m_iconComp:updateIcon({
			skillId = var_2_0
		})
		self.m_iconComp:setCtrlState("showUnitCost", {
			index = 1
		})
	else
		self.m_iconComp:setCtrlState("showUnitCost", {
			index = 0
		})
		self.m_hasSkillController:setSelectedIndex(0)
	end
end

return MineUniteSkillBtn
