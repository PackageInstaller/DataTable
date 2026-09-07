local NavalTacticsSkillInfoLayer = class("NavalTacticsSkillInfoLayer", import(".SkillInfoLayer"))

function NavalTacticsSkillInfoLayer:showBase()
	NavalTacticsSkillInfoLayer.super.showBase(self)
	setActive(self.metaBtn, false)
	setActive(self.upgradeBtn, false)

	return
end

function NavalTacticsSkillInfoLayer:showInfo(arg_2_1)
	self.isWorld = arg_2_1

	local var_2_0 = self.contextData.skillId
	local var_2_1

	if self.contextData.skillOnShip then
		var_2_1 = self.contextData.skillOnShip.level or 1
	end

	setText(self.skillInfoLv, "Lv." .. var_2_1)
	setText(self.skillInfoIntro, Student.getSkillDesc(var_2_0, var_2_1, arg_2_1))

	return
end

return NavalTacticsSkillInfoLayer
