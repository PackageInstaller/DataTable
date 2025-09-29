-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/component/MainSceneMusicMgr.lua

module("logic.extensions.mainui.scene.component.MainSceneMusicMgr", package.seeall)

local M = class("MainSceneMusicMgr", SceneComponentBase)

M.View2Music = {
	[ViewName.CharacterDepotMainViewNew] = {
		aisacVal = 1,
		aisac = "main_lowpass",
		bgm = CriwareAudioEnum.music_main_shoumiren
	},
	[ViewName.CharacterMainSystemViewNew] = {
		aisacVal = 0.2,
		aisac = "main_lowpass",
		bgm = CriwareAudioEnum.music_main_shoumiren
	},
	[ViewName.DungeonEntranceView] = {
		aisacVal = 1,
		aisac = "main_lowpass",
		bgm = CriwareAudioEnum.music_main_huodong
	},
	[ViewName.MainlineDungeonView] = {
		aisacVal = 1,
		aisac = "main_lowpass",
		bgm = CriwareAudioEnum.music_main_huodong
	},
	[ViewName.SeasonNewMain] = {
		aisac = "main_lowpass",
		aisacVal = 0.2
	}
}

function M:ctor(scene)
	M.super.ctor(self, scene)
end

function M:onInit()
	return
end

function M:onEnterScene(sceneId, bornX, bornZ)
	return
end

function M:onEnterSceneFinished(sceneId, bornX, bornZ)
	self:setEvent(true)
end

function M:onExitScene()
	self:setEvent(false)
end

function M:onLeaveScene()
	self:onExitScene()
end

function M:onReturnScene()
	self:setEvent(true)
end

function M:onReturnSceneFinished()
	return
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewOpenOverEvent, self)
		GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._handleViewCloseOverEvent, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_ARITIGHT_STATE_CHANGE, self._handleAritightStateChange, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self._handleViewOpenOverEvent, self)
		GlobalDispatcher:removeEventListener(EventType.FW_VIEW_CLOSING_EVENT, self._handleViewCloseOverEvent, self)
	end
end

function M:_handleAritightStateChange(e, isInAirtightTime, airtightEndTS)
	GlobalDispatcher:dispatchEvent(EventType.ON_CUR_BGMAMBCLOSE)
end

function M:_handleViewOpenOverEvent(e, viewName, opTyp)
	local config = M.View2Music[viewName]

	if config then
		GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BGMAMBCHANGE, config.bgm, config.se)

		if config.aisac then
			local key = config.aisac
			local val = config.aisacVal

			CriwareAudioFacade.instance:setAisacControl(key, key, val)
		end
	end
end

function M:_handleViewCloseOverEvent(e, viewName, opTyp)
	if M.View2Music[viewName] then
		GlobalDispatcher:dispatchEvent(EventType.ON_CUR_BGMAMBCLOSE)
	end
end

return M
