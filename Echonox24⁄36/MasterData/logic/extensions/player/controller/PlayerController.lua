-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/player/controller/PlayerController.lua

module("logic.extensions.player.controller.PlayerController", package.seeall)

local M = class("PlayerController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:setEvent(true)
	self:onReset()
end

function M:onLateInit()
	return
end

function M:onReset()
	self:_initCheckGuideData()
	self:setNeedShowUpgradePanel(false)

	self._blockPlayerUpgradeShow = nil
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.PLAYER_LEVEL_UP, self._handlePlayerLevelUp, self)
		GlobalDispatcher:addEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._handleShowMainViewFinish, self)
		GlobalDispatcher:addEventListener(EventType.START_GAME_REQUEST, self._handleGetStartRequest, self)
		GlobalDispatcher:addEventListener(EventType.LOAD_PLAYER_DATA_FINISH, self._handleGetPlayerDataFinish, self)
		GlobalDispatcher:addEventListener(EventType.LOAD_GUIDE_DATA_FINISH, self._handleGetGuideDataFinish, self)
		GlobalDispatcher:addEventListener(EventType.LOAD_DUNGEON_DATA_FINISH, self._handleGetDungeonDataFinish, self)
	else
		GlobalDispatcher:removeEventListener(EventType.PLAYER_LEVEL_UP, self._handlePlayerLevelUp, self)
		GlobalDispatcher:removeEventListener(EventType.SHOW_MAIN_VIEW_FINISH, self._handleShowMainViewFinish, self)
		GlobalDispatcher:removeEventListener(EventType.START_GAME_REQUEST, self._handleGetStartRequest, self)
		GlobalDispatcher:removeEventListener(EventType.LOAD_PLAYER_DATA_FINISH, self._handleGetPlayerDataFinish, self)
		GlobalDispatcher:removeEventListener(EventType.LOAD_GUIDE_DATA_FINISH, self._handleGetGuideDataFinish, self)
		GlobalDispatcher:removeEventListener(EventType.LOAD_DUNGEON_DATA_FINISH, self._handleGetDungeonDataFinish, self)
	end
end

function M:blockPlayerUpgradeShow(block)
	self._blockPlayerUpgradeShow = block

	if not block then
		self:showPlayerUpgradePanel()
	end
end

function M:setNeedShowUpgradePanel(needShow, info)
	self._needShowUpgradePanel = needShow
	self._upgradeInfo = info

	if not needShow then
		TipsBlockController.instance:cancelOpenView(ViewName.PlayerUpgradeShowView2)
	end
end

function M:getUpgradeInfoCache()
	return self._upgradeInfo
end

function M:getNeedShowUpgradePanel()
	return self._needShowUpgradePanel
end

function M:showPlayerUpgradePanel(callback, handle)
	if self:getNeedShowUpgradePanel() and not self._blockPlayerUpgradeShow then
		ToolTipsMgr.showPlayerUpgradeShowView(self:getUpgradeInfoCache(), true)
	end
end

function M:_handlePlayerLevelUp(e, info)
	self:setNeedShowUpgradePanel(true, info)

	local sceneFlowTyp = SceneFace.instance:getCurSceneFlowTyp()

	if sceneFlowTyp and sceneFlowTyp == SceneType.Room then
		self:showPlayerUpgradePanel()
	end
end

function M:_handleBattleCalculateSwitchNextPage(e)
	self:showPlayerUpgradePanel()
end

function M:_handleShowMainViewFinish(e, mainUIEnter)
	if mainUIEnter then
		self:showPlayerUpgradePanel()
	end
end

function M:_initCheckGuideData()
	self._hasRequest = false
	self._hasGetGuideData = false
	self._hasGetPlayerData = false
	self._hasGetDungeonData = false
end

function M:_handleGetStartRequest()
	self._hasRequest = true

	self:_forceFinishGuide()
end

function M:_handleGetPlayerDataFinish()
	self._hasGetPlayerData = true

	self:_forceFinishGuide()
end

function M:_handleGetGuideDataFinish()
	self._hasGetGuideData = true

	self:_forceFinishGuide()
end

function M:_handleGetDungeonDataFinish()
	self._hasGetDungeonData = true

	self:_forceFinishGuide()
end

function M:_forceFinishGuide()
	if self._hasRequest and self._hasGetGuideData and self._hasGetPlayerData and self._hasGetDungeonData then
		GuideController.instance:tryForceFinishGuide()
		self:_initCheckGuideData()
	end
end

M.instance = M.New()

return M
