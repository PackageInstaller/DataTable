-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewPanelBase.lua

module("logic.extensions.season.view.SeasonNewPanelBase", package.seeall)

local M = class("SeasonNewPanelBase", DynamicFragmentView)

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
	local viewPager = self:getViewPage()
	local lastPageIndex = viewPager:getLastPageIndex()
	local curPageIndex = viewPager:getPage()
	local isNormal = true

	if self.params and self.params[1] and self.params[1].isNormal ~= nil then
		isNormal = self.params[1].isNormal
	end

	local animName = lastPageIndex and self:getReOpenAnimName() or self:getOpenAnimName()

	self:playGuiAni(animName, isNormal)
end

function M:getOpenAnimName()
	return "open"
end

function M:getReOpenAnimName()
	return "open"
end

function M:playGuiAni(name, isNormal)
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

	if self.mainGO.activeSelf and not string.nilorempty(name) then
		local timeLineMode = __isNormal and Astral.GUITimeLineMode.TimeToStart or Astral.GUITimeLineMode.TimeToEnd

		self._guiAnimationPage:PlayAniByName(name, timeLineMode)
	end
end

function M:_animationDoneListener(tagName, reason)
	self._guiAnimationPage:ClearAllBinding()
end

function M:setParam(subIndex)
	return
end

return M
