-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleMainViewPresentor.lua

module("logic.extensions.battle.view.BattleMainViewPresentor", package.seeall)

local BattleMainViewPresentor = class("BattleMainViewPresentor", ViewWithGuidePresentor)

BattleMainViewPresentor.AutochessTopRes = "ui/views/autochess/autochesstopextview.prefab"
BattleMainViewPresentor.KingjiTopRes = CommonResPath.BattleTimeLimitedChallenge

function BattleMainViewPresentor:attachToWhichRoot()
	return ViewRootType.Hud
end

function BattleMainViewPresentor:dependWhatResources()
	local res = {
		CommonResPath.BattleMain,
		CommonResPath.BattleDragParent,
		CommonResPath.BattleFaimilyBoss,
		CommonResPath.BattleWorldBoss,
		CommonResPath.BattleHeroTrial,
		CommonResPath.BattleTimeLimitedChallenge,
		BattleMainViewPresentor.AutochessTopRes,
		CommonResPath.BattleFamilyHoudingClgView
	}

	if BattleModel.instance.kingJiChallengeType == GameEnum.KingjiChallengeType.Shizhe then
		table.insert(res, BattleMainViewPresentor.KingjiTopRes)
	end

	return res
end

function BattleMainViewPresentor:buildViews()
	local views = {}
	local battleView = BattleMainView.New()
	local mainchatview = MainChatView.New()

	table.insert(views, battleView)
	table.insert(views, mainchatview)
	table.insert(views, BattleWinnerOpView.New())
	table.insert(views, BattleTaskView.New())
	table.insert(views, BattlePsychicSkillView.New())
	table.insert(views, BattleGenesisSkillView.New())
	table.insert(views, BattleSpiritInvocationSkillView.New())
	table.insert(views, BattleTopView.New())

	return views
end

function BattleMainViewPresentor:getTempResources()
	local battleUserInterfaceSkinId = BattleController.instance:getBattleUserInterfaceSkinId()

	return {
		string.format("ui/views/battle/mainviewsub/actionsbg%s.prefab", battleUserInterfaceSkinId),
		string.format("ui/views/battle/mainviewsub/roundbg%s.prefab", battleUserInterfaceSkinId)
	}
end

return BattleMainViewPresentor
