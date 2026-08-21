local var_0_0 = class("VipCard", import(".BaseVO"))

var_0_0.MONTH = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.type
	arg_1_0.type = arg_1_1.type
	arg_1_0.leftDate = arg_1_1.left_date
	arg_1_0.data = arg_1_1.data

	return
end

function var_0_0.getLeftDate(arg_2_0)
	if arg_2_0.type == var_0_0.MONTH then
		return arg_2_0.leftDate + 0
	end

	return
end

function var_0_0.GetLeftDay(arg_3_0)
	return (math.floor((arg_3_0:getLeftDate() - pg.TimeMgr.GetInstance():GetServerTime()) / 0))
end

function var_0_0.isExpire(arg_4_0)
	if arg_4_0.type == var_0_0.MONTH then
		local var_4_0 = pg.TimeMgr.GetInstance()

		return arg_4_0:getLeftDate() <= var_4_0:GetServerTime()
	end

	return
end

return var_0_0
