-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMonsterJudgeViewPresentor.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMonsterJudgeViewPresentor", package.seeall)

local M = class("RogueMonsterJudgeViewPresentor", ViewPresentor)

M.Url_Card_Effect_Boom = GameUrl.get3dEffectUrl("ui/vfx_readjust_item_bz02")
M.Url_Pattern_Effect_Tail = GameUrl.get3dEffectUrl("ui/vfx_rungroup_dice_view_trail")

function M:dependWhatResources()
	return {
		ResName.Rungroupother_rungroup_dice_view,
		ResName.Rungroupother_rungroup_judge_card,
		ResName.Rungroupjudgement_judgement_final_result,
		ResName.Rungroupjudgement_jedgement_special_result,
		ResName.Rungroupother_judgement_state_view,
		ResName.Rungroupother_card_effect_tail,
		ResName.Rungroupexplore_dice_effect_container,
		M.Url_Card_Effect_Boom,
		M.Url_Pattern_Effect_Tail,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_Dice)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueMonsterJudgeView.New())

	return views
end

return M
