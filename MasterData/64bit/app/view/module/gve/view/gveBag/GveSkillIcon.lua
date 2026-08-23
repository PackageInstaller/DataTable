local var_0_1 = g.core.model.User.gveDataMgr:getGveBagData()
local GveSkillIcon = class("GveSkillIcon", require("app.fairyGUI.gve.UI_GveSkillIcon"))

function GveSkillIcon:ctor(arg_1_1)
	var_0_1 = g.core.model.User.gveDataMgr:getGveBagData()
	self._skillId = nil
	self._unlock = false

	self:_initView()
end

function GveSkillIcon:_initView()
	self:addClickListener(handler(self, self._onClickIcon))
end

function GveSkillIcon:onLoad()
	return
end

function GveSkillIcon:updateView(arg_4_1)
	self._skillId = arg_4_1.skillId

	local var_4_0 = g.core.config.gve_equipment_skill_info.get(arg_4_1.skillId)

	self.m_icon:setURL((g.core.common.Path:getHalidomSkillIconById(var_4_0.main_skill_icon)))
	self.m_unlockLevelText:setText(g.core.lang:get(100535, {
		lv = var_4_0.main_skill_unlock_level
	}))

	if var_4_0.main_skill_unlock_level <= var_0_1:getCoreHalidomLevel() then
		self._unlock = true

		self.m_unlockStatusController:setSelectedIndex(0)
		self.m_icon:setGrayed(false)
	else
		self._unlock = false

		self.m_unlockStatusController:setSelectedIndex(1)
		self.m_icon:setGrayed(true)
	end
end

function GveSkillIcon:_onClickIcon()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.gve.view.gveBag.GveSkillPop").new({
		skillId = self._skillId,
		unlock = self._unlock
	}))
end

function GveSkillIcon:receiveCompEvent(arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or {}
end

function GveSkillIcon:onUnload()
	return
end

return GveSkillIcon
