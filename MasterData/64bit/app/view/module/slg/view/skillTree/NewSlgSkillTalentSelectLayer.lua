local NewSlgSkillTalentSelectLayer = class("NewSlgSkillTalentSelectLayer", require("app.fairyGUI.newSlg.UI_NewSlgSkillTalentSelectLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgSkillTalentSelectLayer",
		pkgName = "newSlg",
		isFullScreen = true
	}, ...)
end)

function NewSlgSkillTalentSelectLayer:ctor()
	self:addBg("bg/newSlg/bg_hzts_zhucheng.jpg")
	self.m_buildBtn:addClickListener(handler(self, self._onBuildClick))
	self.m_farmBtn:addClickListener(handler(self, self._onFarmClick))
	self.m_fightBtn:addClickListener(handler(self, self._onFightClick))
	self.m_troopBtn:addClickListener(handler(self, self._onTroopClick))
end

function NewSlgSkillTalentSelectLayer:_onBuildClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_SKILL_TREE, {
		skillType = 1
	})
end

function NewSlgSkillTalentSelectLayer:_onFarmClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_SKILL_TREE, {
		skillType = 2
	})
end

function NewSlgSkillTalentSelectLayer:_onFightClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_SKILL_TREE, {
		skillType = 3
	})
end

function NewSlgSkillTalentSelectLayer:_onTroopClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_SKILL_TREE, {
		skillType = 4
	})
end

return NewSlgSkillTalentSelectLayer
