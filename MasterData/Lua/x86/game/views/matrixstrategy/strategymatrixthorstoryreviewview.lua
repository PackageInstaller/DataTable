local StrategyMatrixThorStoryReviewView = class("StrategyMatrixThorStoryReviewView", (import("game.views.matrixActivity.matrixActivity.ActivityMatrixStoryReviewView")))

function StrategyMatrixThorStoryReviewView:UIName()
	return "UI/EmptyDream/ThorRoguelike/ThorStoryReviewUI"
end

function StrategyMatrixThorStoryReviewView:OnEnter()
	self.storyList = {}

	if StrategyMatrixCfg[ActivityConst.STRATEGY_MATRIX_THOR].enter_story_id and StrategyMatrixCfg[ActivityConst.STRATEGY_MATRIX_THOR].enter_story_id ~= 0 and manager.story:IsStoryPlayed(StrategyMatrixCfg[ActivityConst.STRATEGY_MATRIX_THOR].enter_story_id) then
		table.insert(self.storyList, StrategyMatrixCfg[ActivityConst.STRATEGY_MATRIX_THOR].enter_story_id)
	end

	local var_2_0 = StrategyMatrixData:GetIsClearance(ActivityConst.STRATEGY_MATRIX_THOR)

	for iter_2_0, iter_2_1 in ipairs(StrategyMatrixCfg[ActivityConst.STRATEGY_MATRIX_THOR].tier_story_list) do
		if var_2_0 or manager.story:IsStoryPlayed(iter_2_1) then
			table.insert(self.storyList, iter_2_1)
		end
	end

	self:Refresh()
end

return StrategyMatrixThorStoryReviewView
