local var_0_0 = class("CourtYardFeastStoreyModule", import(".CourtYardStoreyModule"))

function var_0_0.GetDefaultBgm(arg_1_0)
	return pg.voice_bgm.FeastScene.default_bgm
end

function var_0_0.InitPedestalModule(arg_2_0)
	arg_2_0.pedestalModule = CourtYardFeastPedestalModule.New(arg_2_0.data, arg_2_0.bg)

	return
end

return var_0_0
