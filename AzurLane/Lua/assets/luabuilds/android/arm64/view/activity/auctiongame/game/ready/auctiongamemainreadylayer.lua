class = var_0_10000

local var_0_0 = "AuctionGameMainReadyLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "AuctionGameMainReadyUI"
end

function var_0_1.init(arg_2_0)
	setText = var_1_10001

	local var_2_0 = arg_2_0.uiContentText

	i18n = var_1_10004

	var_1_10001(var_2_0, var_1_10004("auction_ready"))

	return
end

function var_0_1.didEnter(arg_3_0)
	return
end

function var_0_1.willExit(arg_4_0)
	return
end

function var_0_1.onBackPressed(arg_5_0)
	return
end

return var_0_1
