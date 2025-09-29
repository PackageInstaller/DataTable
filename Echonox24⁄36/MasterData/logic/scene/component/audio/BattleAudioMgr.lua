-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/component/audio/BattleAudioMgr.lua

module("logic.scene.component.audio.BattleAudioMgr", package.seeall)

local M = class("BattleAudioMgr", SceneComponentBase)
local regeMatchStr = "_block"

function M:onInit()
	self._bgmWithBlock = false
end

function M:onEnterScene(sceneId, bornX, bornZ)
	CriwareAudioFacade.instance:loadCueSheet("character_skill", "character_skill.acb", "character_skill.awb")
	CriwareAudioFacade.instance:loadCueSheet("music_battle", "music_battle.acb", "music_battle.awb")
	self:_setEvent(true)
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self:playBgmAndEnviroment()
end

function M:onExitScene()
	CriwareAudioFacade.instance:unloadCueSheet("character_skill")
	CriwareAudioFacade.instance:unloadCueSheet("music_battle")
	self:_setEvent(false)
end

function M:onLeaveScene()
	CriwareAudioFacade.instance:stopBgm()
	CriwareAudioFacade.instance:stopCurrentEnvironment()
end

function M:onReturnSceneFinished()
	self:playBgmAndEnviroment()
end

function M:playBgmAndEnviroment()
	CriwareAudioFacade.instance:stopBgm()
	CriwareAudioFacade.instance:stopCurrentEnvironment()

	self._bgmWithBlock = false

	local bgmCueName = BattleMgr.instance:getModel():getBattleMusicResName()
	local ambCueName = BattleMgr.instance:getModel():getBgmResName()

	if BattleLog.enableLog then
		BattleLog.log(string.format("current battle amb:%s, bmg:%s", ambCueName, bgmCueName))
	end

	if not string.nilorempty(bgmCueName) then
		if string.ends(bgmCueName, regeMatchStr) then
			self._bgmWithBlock = true
		end

		CriwareAudioFacade.instance:PlayBgmInnerBgName(bgmCueName)
	end

	if not string.nilorempty(ambCueName) then
		CriwareAudioFacade.instance:playEnvironmentByName(ambCueName)
	end
end

function M:_onBattleEnterFinish()
	self:_onPlayBlockIndex(0)
end

function M:_onBattleStart()
	self:_onPlayBlockIndex(1)
end

function M:_onPlayBlockIndex(index)
	if self._bgmWithBlock then
		if BattleLog.enableLog then
			BattleLog.log(string.format("riware switch block with music:%s:", index))
		end

		CriwareAudioFacade.instance:setBgmNextBlockIndex(index)
	elseif BattleLog.enableWarn then
		BattleLog.warn("当前播放的cue 暂时不支持 block切换,请更换 cue")
	end
end

function M:_onSwitchBlockByHack(evt, index)
	self:_onPlayBlockIndex(index)
end

function M:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBattleEnterFinish, self._onBattleEnterFinish, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleStart, self._onBattleStart, self)
		GlobalDispatcher:addEventListener(EventType.SWITCH_BLOCK_EVENT, self._onSwitchBlockByHack, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleEnterFinish, self._onBattleEnterFinish, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleStart, self._onBattleStart, self)
		GlobalDispatcher:removeEventListener(EventType.SWITCH_BLOCK_EVENT, self._onSwitchBlockByHack, self)
	end
end

return M
