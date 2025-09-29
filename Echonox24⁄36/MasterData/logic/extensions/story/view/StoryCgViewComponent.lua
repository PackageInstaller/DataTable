-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/StoryCgViewComponent.lua

module("logic.extensions.story.view.StoryCgViewComponent", package.seeall)

local M = class("StoryCgViewComponent", ViewComponent)

function M:buildUI()
	return
end

function M:onEnter()
	StoryDispatcher:addEventListener(StoryNotifyName.UICgClose, self._onCgClose, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UICgShow, self._onCgShow, self)
	StoryDispatcher:addEventListener(StoryNotifyName.UICgSkip, self._onCgSkip, self)
end

function M:onExit()
	StoryDispatcher:removeEventListener(StoryNotifyName.UICgClose, self._onCgClose, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UICgShow, self._onCgShow, self)
	StoryDispatcher:removeEventListener(StoryNotifyName.UICgSkip, self._onCgSkip, self)
	self:_clearParamTweener()
	self:_clearAlphaTweener()
	self:_removeFadeOutTimer()
end

function M:destroyUI()
	self:_clearParamTweener()
	self:_clearAlphaTweener()
	self:_removeFadeOutTimer()
end

function M:_clearParamTweener()
	if self._paramTweener then
		self._paramTweener:Kill(false)
	end

	self._paramTweener = nil
end

function M:_clearAlphaTweener()
	if self._alphaTweener then
		self._alphaTweener:Kill(false)
	end

	self._alphaTweener = nil
end

function M:_removeFadeOutTimer()
	removetimer(self._onFadeOutFinish, self)
end

function M:_onFadeOut(from, to, time)
	self:_clearAlphaTweener()

	self._alphaTweener = Pjg.CSTweenUtils.DOTweenFade(self._canvasGroup.transform, from, to, time, nil, nil)
end

function M:_onCgClose()
	self:_clearParamTweener()
	self:_clearAlphaTweener()
	goutil.setActive(self._goCg, false)
end

function M:_onCgShow(_, _url, _duration, _fadeInTime, _fadeOutTime, paramData)
	goutil.setActive(self._goCg, true)
	self._imgBg:ClearImage()
	self._imgBg:SetImage(_url)

	self._fadeOutTime = _fadeOutTime

	self:_onFadeOut(0, 1, _fadeInTime)
	self:_startFadeOut(_fadeInTime + _duration)
	self:_clearParamTweener()

	self._paramTweener = self:_generateTweener(paramData, _fadeInTime)
end

function M:_onCgSkip(_, paramData)
	self:_clearParamTweener()

	self._paramTweener = self:_generateTweener(paramData, 0)
end

function M:_generateTweener(paramData, _fadeInTime)
	if not paramData then
		return
	end
end

function M:_startFadeOut(val)
	self:_removeFadeOutTimer()
	settimer(val, self._onFadeOutFinish, self, false)
end

function M:_onFadeOutFinish()
	self:_removeFadeOutTimer()
	self:_onFadeOut(1, 0, self._fadeOutTime)
end

function M:_splitParam(paramStr)
	local _arr = string.split(paramStr, "#")

	if #_arr ~= 2 then
		printError("cgparam 配置错误,缺乏类型.", paramStr)

		return nil
	end

	local _t = tonumber(_arr[1])
	local _arr2 = string.split(_arr[2], ",")
	local _tb = {}

	table.insert(_tb, _t)

	for _, value in ipairs(_arr2) do
		table.insert(_tb, value)
	end

	return _tb
end

return M
