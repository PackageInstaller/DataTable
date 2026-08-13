class = var_0_10000

local var_0_0 = "CourtYardFeastStoreyModule"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".CourtYardStoreyModule"))

function var_0_1.GetDefaultBgm(arg_1_0)
	pg = var_1_10001

	return var_1_10001.voice_bgm.FeastScene.default_bgm
end

function var_0_1.InitPedestalModule(arg_2_0)
	CourtYardFeastPedestalModule = var_1_10001
	arg_2_0.pedestalModule = var_1_10001.New(arg_2_0.data, arg_2_0.bg)

	return
end

return var_0_1
