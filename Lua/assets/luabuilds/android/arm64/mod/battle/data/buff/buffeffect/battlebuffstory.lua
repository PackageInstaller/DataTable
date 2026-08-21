ys = ys or {}
ys.Battle.BattleBuffStory = class("BattleBuffStory", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffStory.__name = "BattleBuffStory"

local var_0_0 = ys.Battle.BattleBuffStory

function ys.Battle.BattleBuffStory.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffStory.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._storyID = arg_2_0._tempData.arg_list.story_id
	arg_2_0._countType = arg_2_0._tempData.arg_list.countType

	return
end

function ys.Battle.BattleBuffStory.doOnHPRatioUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	pg.NewStoryMgr.GetInstance():Play(arg_3_0._storyID)

	return
end

return
