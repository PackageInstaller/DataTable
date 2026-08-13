class = var_0_10000

local var_0_0 = "NavalTacticsSkillInfoLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".SkillInfoLayer"))

function var_0_1.showBase(arg_1_0)
	var_0_1.super.showBase(arg_1_0)

	setActive = var_1

	var_1(arg_1_0.metaBtn, false)

	setActive = var_1

	var_1(arg_1_0.upgradeBtn, false)

	return
end

function var_0_1.showInfo(arg_2_0, arg_2_1)
	arg_2_0.isWorld = arg_2_1

	local var_2_0 = arg_2_0.contextData.skillId
	local var_2_1

	if not arg_2_0.contextData.skillOnShip or not var_3.level then
		var_2_1 = 1
	end

	setText = var_1_10005

	var_1_10005(arg_2_0.skillInfoLv, "Lv." .. var_2_1)

	setText = var_1_10005

	local var_2_2 = arg_2_0.skillInfoIntro

	Student = var_7

	var_1_10005(var_2_2, var_7.getSkillDesc(var_2_0, var_2_1, arg_2_1))

	return
end

return var_0_1
