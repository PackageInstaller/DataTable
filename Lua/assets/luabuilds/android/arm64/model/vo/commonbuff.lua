local var_0_0 = class("CommonBuff", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.timestamp = arg_1_1.timestamp

	return
end

function var_0_0.IsActiveType(arg_2_0)
	return false
end

function var_0_0.bindConfigTable(arg_3_0)
	return pg.benefit_buff_template
end

function var_0_0.checkShow(arg_4_0)
	return arg_4_0:getConfig("hide") ~= 1
end

function var_0_0.isActivate(arg_5_0)
	local var_5_0 = pg.TimeMgr.GetInstance()

	return var_5_0:GetServerTime() <= arg_5_0.timestamp
end

function var_0_0.getLeftTime(arg_6_0)
	return arg_6_0.timestamp - pg.TimeMgr.GetInstance():GetServerTime()
end

return var_0_0
