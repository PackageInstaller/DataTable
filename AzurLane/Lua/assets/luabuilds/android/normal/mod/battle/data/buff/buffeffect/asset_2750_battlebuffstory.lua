ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffStory = var_0_10002("BattleBuffStory", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffStory.__name = "BattleBuffStory"

local var_0_2 = var_0.Battle.BattleBuffStory

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._storyID = arg_2_0._tempData.arg_list.story_id
	arg_2_0._countType = var_3.countType

	return
end

function var_0_2.doOnHPRatioUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	pg = var_1_10004

	local var_3_0 = var_1_10004.NewStoryMgr.GetInstance()

	var_4.Play(var_3_0, arg_3_0._storyID)

	return
end

return
