local var_0_0 = class("NavalTacticsSkillInfoLayer", import(".SkillInfoLayer"))

function var_0_0.showBase(arg_1_0)
	var_0_0.super.showBase(arg_1_0)
	setActive(arg_1_0.metaBtn, false)
	setActive(arg_1_0.upgradeBtn, false)

	return
end

function var_0_0.showInfo(arg_2_0, arg_2_1)
	arg_2_0.isWorld = arg_2_1

	if arg_2_0.contextData.skillOnShip then
		local var_2_1 = arg_2_0.contextData.skillOnShip.level or 1

		setText(arg_2_0.skillInfoLv, "Lv." .. var_2_1)
		setText(arg_2_0.skillInfoIntro, Student.getSkillDesc(var_2_0, var_2_1, arg_2_1))

		return
	end
end

return var_0_0
