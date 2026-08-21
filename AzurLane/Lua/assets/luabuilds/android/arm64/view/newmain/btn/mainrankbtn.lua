local var_0_0 = class("MainRankBtn", import(".MainBaseBtn"))

function var_0_0.OnClick(arg_1_0)
	arg_1_0:emit(NewMainMediator.GO_SCENE, SCENE.BILLBOARD, {
		index = PowerRank.TYPE_POWER
	})

	return
end

function var_0_0.Flush(arg_2_0)
	setActive(arg_2_0._tf, (arg_2_0:IsActive()))

	return
end

function var_0_0.IsActive(arg_3_0)
	local var_3_0 = getProxy(PlayerProxy):getRawData().level

	return var_3_0 >= pg.open_systems_limited[6].level
end

return var_0_0
