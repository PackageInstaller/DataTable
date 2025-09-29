-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/dungeonbattleflow/DungeonBattleWorkReturnDungeon.lua

module("logic.extensions.dungeon.view.dungeonbattleflow.DungeonBattleWorkReturnDungeon", package.seeall)

local M = class("DungeonBattleWorkReturnDungeon", WorkBase)

function M:onEnter(context)
	DungeonAgent.instance:SendFinishPostwarPlotRequest()

	local returnByJump = BattleCalculateMgr.instance:getBattleReturnJumpData()

	if not returnByJump then
		local dungeonType = context.model:getDungeonType()

		if dungeonType == CommEnum.DungeonType.Mainline or dungeonType == CommEnum.DungeonType.Branchline then
			local curSceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

			if curSceneFlowTyp and curSceneFlowTyp ~= SceneType.Battle then
				DungeonModel.instance:setIsInBattle(false)
				DungeonMainLineChapterModel.instance:tryEnterChapterScene(nil, DungeonMainLineChapterModel.instance:getDungeonSceneChpaterInfo())
			else
				ViewMgr.instance:close(ViewName.MainlineDungeonView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
				self:_backScene()
				DungeonModel.instance:setIsInBattle(false)
			end
		elseif dungeonType == CommEnum.DungeonType.Material or dungeonType == CommEnum.DungeonType.Gold or dungeonType == CommEnum.DungeonType.Exp then
			ViewMgr.instance:close(ViewName.StableAreaChapterView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
			self:_backScene()
		elseif dungeonType == CommEnum.DungeonType.Teaching then
			local chapterId, index = DungeonTeachingChapterModel.instance:getClickChapterIdAndDungeonIndex()

			DungeonTeachingChapterModel.instance:setClickChapterIdAndDungeonIndex()
			ViewMgr.instance:close(ViewName.TeachingChapter, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
			self:_backScene()
		elseif dungeonType == CommEnum.DungeonType.EquipExplore then
			ViewMgr.instance:close(ViewName.RedMistChapterView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
			self:_backScene()
		elseif dungeonType == CommEnum.DungeonType.LightTower then
			ViewMgr.instance:close(ViewName.ClimbingTowerEntryView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
			ClimbingTowerModel.instance:setEntryViewEnterTyp(ClimbingTowerEnum.PageTyp.BrightSide)
			ClimbingTowerModel.instance:cacheEntryViewPageType(ClimbingTowerEnum.PageTyp.BrightSide)
			self:_backScene()
		elseif dungeonType == CommEnum.DungeonType.DarkTower then
			local lastBattleDarkInfo = ClimbingTowerDarkModel.instance:getLastDungeonBattleInfo()
			local lastBattleDarkRound = lastBattleDarkInfo and lastBattleDarkInfo.darkRound or -1
			local entryTyp = ClimbingTowerEnum.PageTyp.Moon
			local floatMsg

			if ClimbingTowerDarkModel.instance:getDarkRound() == lastBattleDarkRound then
				entryTyp = ClimbingTowerEnum.PageTyp.DarkSide
			else
				floatMsg = lang("tip_dark_round_refresh")

				DungeonAgent.instance:sendGetDungeonInfoRequest()
			end

			ViewMgr.instance:close(ViewName.ClimbingTowerEntryView, false, WindowType.WindowCloseReasonType.QuickCloseType, true)
			ClimbingTowerModel.instance:setEntryViewEnterTyp(entryTyp)
			ClimbingTowerModel.instance:setEntryViewFloatMsg(floatMsg)
			ClimbingTowerModel.instance:cacheEntryViewPageType(entryTyp)
			self:_backScene()
		elseif dungeonType == CommEnum.DungeonType.ControlAction or dungeonType == CommEnum.DungeonType.ControlActionTeaching or dungeonType == CommEnum.DungeonType.HeroEarlyAccess then
			ControlActionModel.instance:exitBattle()
			self:_backScene()
		elseif dungeonType == CommEnum.DungeonType.PowerChallenge then
			self:_backScene()
		end
	else
		BattleEnterUtil.exitByJump()
	end

	DungeonModel.instance:setIsInBattle(false)
	self:onDone(WorkResult.Succeed)
end

function M:_backScene()
	local backSceneInfo = SceneFace.instance:getCurrBackInfo()
	local backSceneTyp = backSceneInfo and backSceneInfo.sceneType or SceneType.Room

	if backSceneTyp == SceneType.Room then
		local mainSceneLoading
		local notOpenMainUI = true
		local isBackScene = true

		SceneFace.instance._curSceneFlow = nil

		SceneFace.instance:enterRoomScene(mainSceneLoading, notOpenMainUI, isBackScene)
	else
		backSceneInfo = TableUtil.deepCopy(backSceneInfo)

		SceneFace.instance:clearEnterSceneInfo()
		SceneFace.instance:enterScene(backSceneInfo, true)
	end
end

return M
