class = var_0_10000

local var_0_0 = var_0_10000("EventPtBonus")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.tr = arg_1_1
	findTF = var_1_10002

	local var_1_0 = var_1_10002(arg_1_0.tr, "Image")
	local var_1_1 = var_2.GetComponent

	typeof = var_5
	Image = var_1_10007
	arg_1_0.resIcon = var_1_1(var_1_0, var_5(var_1_10007))
	findTF = var_2

	local var_1_2 = var_2(arg_1_0.tr, "Text")
	local var_1_3 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	arg_1_0.resName = var_1_3(var_1_2, var_5(var_1_10007))
	setActive = var_2

	var_2(arg_1_0.tr, false)
	arg_1_0:Update()

	return
end

function var_0_0.Update(arg_2_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_2_0 = var_1_10001(var_1_10003)
	local var_2_1 = var_1.getAliveActivityByType

	ActivityConst = var_1_10004

	if var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_EVENT) and var_1:getConfig("config_client").shopActID then
		setActive = var_2_0

		var_2_0(arg_2_0.tr, true)
	end

	return
end

return var_0_0
