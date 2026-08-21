local var_0_0 = class("MedalCollectionTemplateView", import("view.base.BaseUI"))

var_0_0.MEDAL_STATUS_UNACTIVATED = 1
var_0_0.MEDAL_STATUS_ACTIVATED = 2
var_0_0.MEDAL_STATUS_ACTIVATABLE = 3

function var_0_0.UpdateActivity(arg_1_0, arg_1_1)
	arg_1_0.activityData = arg_1_1
	arg_1_0.allIDList = arg_1_0.activityData:GetPicturePuzzleIds()
	arg_1_0.activatableIDList = arg_1_0.activityData.data1_list
	arg_1_0.activeIDList = arg_1_0.activityData.data2_list

	return
end

function var_0_0.didEnter(arg_2_0)
	arg_2_0:CheckAward()

	return
end

function var_0_0.UpdateAfterSubmit(arg_3_0, arg_3_1)
	arg_3_0:CheckAward()

	return
end

function var_0_0.UpdateAfterFinalMedal(arg_4_0)
	return
end

function var_0_0.CheckAward(arg_5_0)
	if #arg_5_0.activeIDList == #arg_5_0.allIDList and arg_5_0.activityData.data1 ~= 1 then
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_5_0.activityData.id
		})
	end

	return
end

return var_0_0
