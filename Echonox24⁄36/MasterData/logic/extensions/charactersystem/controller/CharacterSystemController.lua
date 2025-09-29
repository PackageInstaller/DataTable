-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/controller/CharacterSystemController.lua

module("logic.extensions.charactersystem.controller.CharacterSystemController", package.seeall)

local M = class("CharacterSystemController", BaseController)

M.AUTO_YANGCHENG_VOICE_STEP = 12
M.CharacterView = {
	[ViewName.CharacterDepotMainViewNew] = 1,
	[ViewName.CharacterMainSystemViewNew] = 1,
	[ViewName.CharacterSkinView] = 1
}

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._characterSysRandomVoice = {}

	self:onReset()
	GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_TO_MAIN, self._handleJumpViewToMain, self)
	GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_VIEW_CAM_CTRL, self.checkInCharacterView, self)
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_OPEN_OVER_EVENT, self.checkInCharacterView, self)
	GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKSECOND, self._onSecondUpdate, self)
	GlobalDispatcher:addEventListener(EventType.ON_VOICE_STOP, self._handleOnVoiceStop, self)
	GlobalDispatcher:addEventListener(EventType.ON_VOICE_PLAY, self._handleOnVoicePlay, self)
	GlobalDispatcher:addEventListener(EventType.ON_SET_CHARACTER_DEPOT_VIEW_PAGE_MO, self._handleSetHeroDepotViewPageMo, self)
	GlobalDispatcher:addEventListener(EventType.ON_CHARACTER_SYS_PAGE_CHANGE, self._handleCharacterSysPageChange, self)
end

function M:onReset()
	table.clear(self._characterSysRandomVoice)

	self._curVoiceTime = 0

	self:_setCanPlayYangChengVoice(false)
	self:setIsInCharacterView(false)
end

function M:_handleJumpViewToMain()
	self:setIsInCharacterView(false)
end

function M:_onSecondUpdate(e)
	self:_tryPlayVoice()
end

function M:_handleOnVoiceStop()
	self._curVoiceTime = 0
	self._voiceTimer = 0
end

function M:_handleOnVoicePlay(e, voiceRes, voiceId, time)
	self._curVoiceTime = time
	self._curVoiceTime = self._curVoiceTime < 0 and 0 or self._curVoiceTime
end

function M:_handleSetHeroDepotViewPageMo(e)
	local heroId = HeroDepotModel.instance:getCurViewPageHeroId()
	local hasHero = heroId and heroId > 0
	local inCharacterView = self:getIsInCharacterView()

	self:_setCanPlayYangChengVoice(hasHero and inCharacterView)
end

function M:_handleCharacterSysPageChange(e, pageIndex)
	self._voiceTimer = 0
end

function M:getIsInCharacterView()
	return self._isInCharacterView
end

function M:setIsInCharacterView(inView)
	local isChange = self._isInCharacterView ~= inView

	self._isInCharacterView = inView

	self:_setCanPlayYangChengVoice(inView)

	if isChange then
		GlobalDispatcher:dispatchEvent(EventType.ON_IN_CHARACTER_VIEW_CHANGE, inView)
	end
end

function M:checkInCharacterView()
	local inView = false

	for viewName, _ in pairs(M.CharacterView) do
		if not inView and ViewMgr.instance:isOpen(viewName) then
			inView = true
		end
	end

	self:setIsInCharacterView(inView)
end

function M:_setCanPlayYangChengVoice(canPlay)
	self._canPlayYangChengVoice = canPlay
	self._voiceTimer = 0
end

function M:_tryPlayVoice()
	if not self._canPlayYangChengVoice then
		return
	end

	self._voiceTimer = self._voiceTimer + 1

	if self._voiceTimer < M.AUTO_YANGCHENG_VOICE_STEP + self._curVoiceTime then
		return
	end

	self._voiceTimer = 0

	local heroId = HeroDepotModel.instance:getCurViewPageHeroId()

	if not heroId or heroId <= 0 then
		table.clear(self._characterSysRandomVoice)

		return
	end

	if #self._characterSysRandomVoice == 0 then
		self._characterSysRandomVoice = {
			CharacterInfoEnum.VoiceResKey.yangcheng_01,
			CharacterInfoEnum.VoiceResKey.yangcheng_02,
			CharacterInfoEnum.VoiceResKey.yangcheng_03
		}

		for i = 1, #self._characterSysRandomVoice do
			local rIndex = math.random(1, #self._characterSysRandomVoice)
			local _a = self._characterSysRandomVoice[i]
			local _b = self._characterSysRandomVoice[rIndex]

			self._characterSysRandomVoice[i] = _b
			self._characterSysRandomVoice[rIndex] = _a
		end
	end

	if #self._characterSysRandomVoice > 0 then
		local voiceResKey = table.remove(self._characterSysRandomVoice, 1)
		local voiceRes = string.format(CharacterInfoEnum.VoiceRes[voiceResKey], heroId)
		local isPlaySuc = CriwareAudioFacade.instance:playVoiceByAudioId(voiceResKey, heroId)

		self._curVoiceTime = CriwareAudioFacade.instance:getCueTotalTimeByName(voiceRes)
		self._curVoiceTime = self._curVoiceTime < 0 and 0 or self._curVoiceTime

		if Astral.OSDef.isEditor then
			printWarn(string.format("tryPlayVoice[%s]%s, voiceTime:%s, suc:%s", voiceResKey, voiceRes, self._curVoiceTime, isPlaySuc))
		end
	end
end

M.instance = M.New()

return M
