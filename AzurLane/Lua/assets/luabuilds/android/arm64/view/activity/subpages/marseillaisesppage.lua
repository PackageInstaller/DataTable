class = var_0_10000

local var_0_0 = "MarseillaiseSpPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.SpTemplatePage"))

Vector2 = var_0_10001

local var_0_2 = var_0_10001(225, -270)

Vector2 = var_0_0

local var_0_3 = var_0_0(515, -270)

function var_0_1.OnFirstFlush(arg_1_0)
	var_0_1.super.OnFirstFlush(arg_1_0)

	local var_1_0 = arg_1_0.activity
	local var_1_1

	if not var_1.getConfig(var_1_0, "config_client").linkPoolActID then
		pg = var_1_10002
		var_1_1 = var_1_10002.TipsMgr.GetInstance()

		var_1_10002.ShowTips(var_1_1, "未配置linkPoolActID！！！")
	else
		getProxy = var_1_10002
		ActivityProxy = var_1_1

		local var_1_2 = var_1_10002(var_1_1)
		local var_1_3 = var_2.getActivityById(var_1_2, var_1)
		local var_1_4 = var_0_2

		if var_1_3 and not var_1_3:isEnd() then
			var_1_4 = var_0_2
		else
			var_1_4 = var_0_3
		end

		setLocalPosition = var_1_2

		var_1_2(arg_1_0.getBtn, var_1_4)

		setLocalPosition = var_1_2

		var_1_2(arg_1_0.gotBtn, var_1_4)

		setLocalPosition = var_1_2

		var_1_2(arg_1_0.battleBtn, var_1_4)
	end

	return
end

return var_0_1
