-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueEventJudgeViewPresentor.lua

module("logic.extensions.roguelike.view.judgesystem.RogueEventJudgeViewPresentor", package.seeall)

local M = class("RogueEventJudgeViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_rungroup_dice_view,
		ResName.Rungroupother_rungroup_judge_card,
		ResName.Rungroupjudgement_judgement_final_result,
		ResName.Rungroupjudgement_jedgement_special_result,
		ResName.Rungroupother_judgement_type_view,
		ResName.Rungroupother_judgement_state_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueEventJudgeView.New())

	return views
end

return M
