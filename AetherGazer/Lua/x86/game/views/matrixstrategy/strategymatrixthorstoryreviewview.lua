local var_0_0 = import("game.views.matrixActivity.matrixActivity.ActivityMatrixStoryReviewView")
local var_0_1 = class("StrategyMatrixThorStoryReviewView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/EmptyDream/ThorRoguelike/ThorStoryReviewUI"
end

function var_0_1.OnEnter(arg_2_0)
	local var_2_0 = ActivityConst.STRATEGY_MATRIX_THOR
	local var_2_1 = StrategyMatrixCfg[var_2_0]

	arg_2_0.storyList = {}

	local var_2_2 = var_2_1.enter_story_id

	if var_2_2 and var_2_2 ~= 0 and manager.story:IsStoryPlayed(var_2_2) then
		table.insert(arg_2_0.storyList, var_2_2)
	end

	local var_2_3 = StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR)

	for iter_2_0, iter_2_1 in ipairs(var_2_1.tier_story_list) do
		if var_2_3 or manager.story:IsStoryPlayed(iter_2_1) then
			table.insert(arg_2_0.storyList, iter_2_1)
		end
	end

	arg_2_0:Refresh()
end

return var_0_1
