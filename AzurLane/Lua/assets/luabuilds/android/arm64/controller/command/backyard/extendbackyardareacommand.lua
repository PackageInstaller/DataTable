class = var_0_10000

local var_0_0 = "ExtendBackYardAreaCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	DormProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.getData(var_1_0)

	var_3.levelUp(var_1_1)

	local var_1_2 = var_2
	local var_1_3 = var_2.updateDrom
	local var_1_4 = var_3

	BackYardConst = var_1_10008

	var_1_3(var_1_2, var_1_4, var_1_10008.DORM_UPDATE_TYPE_LEVEL)

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.sendNotification

	GAME = var_1_4

	var_1_6(var_1_5, var_1_4.EXTEND_BACKYARD_AREA_DONE)

	pg = var_1_6

	local var_1_7 = var_1_6.TipsMgr.GetInstance()
	local var_1_8 = var_4.ShowTips

	i18n = var_7

	var_1_8(var_1_7, var_7("backyard_extendArea_ok"))

	return
end

return var_0_1
