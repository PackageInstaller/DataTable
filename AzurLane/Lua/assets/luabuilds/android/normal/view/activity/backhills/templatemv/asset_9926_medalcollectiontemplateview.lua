class = var_0_10000

local var_0_0 = "MedalCollectionTemplateView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

var_0_1.MEDAL_STATUS_UNACTIVATED = 1
var_0_1.MEDAL_STATUS_ACTIVATED = 2
var_0_1.MEDAL_STATUS_ACTIVATABLE = 3

function var_0_1.UpdateActivity(arg_1_0, arg_1_1)
	arg_1_0.activityData = arg_1_1

	local var_1_0 = arg_1_0.activityData

	arg_1_0.allIDList = var_2.GetPicturePuzzleIds(var_1_0)
	arg_1_0.activatableIDList = arg_1_0.activityData.data1_list
	arg_1_0.activeIDList = arg_1_0.activityData.data2_list

	return
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0:CheckAward()

	return
end

function var_0_1.UpdateAfterSubmit(arg_3_0, arg_3_1)
	arg_3_0:CheckAward()

	return
end

function var_0_1.UpdateAfterFinalMedal(arg_4_0)
	return
end

function var_0_1.CheckAward(arg_5_0)
	if #arg_5_0.activeIDList == #arg_5_0.allIDList and arg_5_0.activityData.data1 ~= 1 then
		pg = var_1

		local var_5_0 = var_1.m02
		local var_5_1 = var_1.sendNotification

		GAME = var_1_10003

		var_5_1(var_5_0, var_1_10003.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_5_0.activityData.id
		})
	end

	return
end

return var_0_1
