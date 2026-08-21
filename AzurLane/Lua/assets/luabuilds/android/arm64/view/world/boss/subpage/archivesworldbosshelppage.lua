local var_0_0 = class("ArchivesWorldBossHelpPage", import(".WorldBossHelpPage"))

function var_0_0.OnLoaded(arg_1_0)
	var_0_0.super.OnLoaded(arg_1_0)
	setActive(arg_1_0.worldBtn, false)

	return
end

return var_0_0
