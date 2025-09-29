-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/GameplaySubViewBase.lua

module("logic.extensions.dungeon.view.entrance.GameplaySubViewBase", package.seeall)

local M = class("GameplaySubViewBase", DynamicFragmentView)

function M:getPageIndex()
	return 0
end

function M:buildUI()
	local mainGO = self._registry:getMainGO()

	self._guiAnimationPage = goutil.addComponentOnce(mainGO, typeof(Astral.GUITimelineAniLua))

	self._guiAnimationPage:AddListener(self._animationDoneListener, self)
end

function M:destroyUI()
	if self._guiAnimationPage then
		self._guiAnimationPage:RemoveListener()

		self._guiAnimationPage = nil
	end
end

function M:onEnter()
	local lastPageIndex, curPageIndex = self:getLastAndCurPage()
	local isNormal = self:getIsNormal()
	local animName = lastPageIndex and self:getReOpenAnimName() or self:getOpenAnimName()

	self:playGuiAni(animName, isNormal)
end

function M:getIsNormal()
	local isNormal = true

	if self.params and self.params[1] and self.params[1].isNormal ~= nil then
		isNormal = self.params[1].isNormal
	end

	return isNormal
end

function M:getLastAndCurPage()
	local viewPager = self:getViewPage()
	local lastPageIndex = viewPager:getLastPageIndex()
	local curPageIndex = viewPager:getPage()

	return lastPageIndex, curPageIndex
end

function M:getOpenAnimName()
	return "open"
end

function M:getReOpenAnimName()
	return "open"
end

function M:playGuiAni(name, isNormal)
	if not self._guiAnimationPage or goutil.isNil(self._guiAnimationPage) then
		return
	end

	self._guiAnimationPage:RemoveListener()
	self._guiAnimationPage:StopTimelineAni()
	self._guiAnimationPage:ClearAllBinding()
	self._guiAnimationPage:SetAniTime(0)
	self._guiAnimationPage:AddListener(self._animationDoneListener, self)

	if string.nilorempty(name) then
		return
	end

	local __isNormal = true

	if isNormal ~= nil then
		__isNormal = isNormal
	end

	if not string.nilorempty(name) and self.mainGO and self.mainGO.activeSelf then
		local timeLineMode = __isNormal and Astral.GUITimeLineMode.TimeToStart or Astral.GUITimeLineMode.TimeToEnd

		self._guiAnimationPage:PlayAniByName(name, timeLineMode)
	end
end

function M:_animationDoneListener(tagName, reason)
	self._guiAnimationPage:ClearAllBinding()
	GlobalDispatcher:dispatchEvent(EventType.CHARACTER_SUB_PAGE_ANI_FINISH, self:getPageIndex(), tagName, reason)
end

function M:_checkCanOpen(entrySystemEnum)
	if not SystemOpenFacade.instance:isOpen(entrySystemEnum, true) then
		return false
	end

	if not SystemOpenModel.instance:getSystemIsOnline(entrySystemEnum, true) then
		FloatWordMgr.instance:show(lang("tip_system_open_not_online"))

		return false
	end

	return true
end

function M:_getCanOpen(entrySystemEnum)
	return SystemOpenFacade.instance:isOpen(entrySystemEnum) and SystemOpenModel.instance:getSystemIsOnline(entrySystemEnum, true)
end

function M:_formatRemainTime(longTS, shortTS)
	local remainTime = ServerTime.getDateTimeDiff(longTS, shortTS)
	local remainTimeStr

	if remainTime.month > 0 then
		remainTimeStr = langF(TextFormatterConst.MONTH_FORMAT_PATTERN, remainTime.month)
	elseif remainTime.day > 0 then
		remainTimeStr = langF(TextFormatterConst.DAY_FORMAT_PATTERN, remainTime.day)
	elseif remainTime.hour > 0 then
		remainTimeStr = langF(TextFormatterConst.HOUR_FORMAT_PATTERN, remainTime.hour)
	elseif remainTime.min > 0 then
		remainTimeStr = langF("tip_minute_format", remainTime.min)
	else
		remainTimeStr = langF("tip_minute_format", 0)
	end

	return remainTimeStr
end

return M
