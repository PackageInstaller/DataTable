local var_0_0 = class("MarseillaiseSpRePage", import(".TemplatePage.SpTemplatePage"))
local var_0_1 = Vector2(225, -270)
local var_0_2 = Vector2(515, -270)

function var_0_0.OnFirstFlush(arg_1_0)
	var_0_0.super.OnFirstFlush(arg_1_0)

	local var_1_0 = arg_1_0.activity:getConfig("config_client").linkPoolActID

	if not var_1_0 then
		pg.TipsMgr.GetInstance():ShowTips("未配置linkPoolActID！！！")
	else
		local var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0)
		local var_1_2 = var_0_1

		var_1_2 = var_1_1 and not var_1_1:isEnd() and var_0_1 or var_0_2

		setLocalPosition(arg_1_0.getBtn, var_1_2)
		setLocalPosition(arg_1_0.gotBtn, var_1_2)
		setLocalPosition(arg_1_0.battleBtn, var_1_2)
	end

	return
end

return var_0_0
