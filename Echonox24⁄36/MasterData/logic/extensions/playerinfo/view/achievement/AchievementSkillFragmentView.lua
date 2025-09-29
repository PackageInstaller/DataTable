-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/achievement/AchievementSkillFragmentView.lua

module("logic.extensions.playerinfo.view.achievement.AchievementSkillFragmentView", package.seeall)

local M = class("AchievementSkillFragmentView", PlayerInfoBaseFragmentView)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	local mainGo = self._registry:getMainGO()

	self._txtCount = goutil.findChildTextComponent(mainGo, "txtNum")
	self._scroll = goutil.findChildComponent(mainGo, "scroll", UIComponentType.ScrollRect)
	self._loopGridView = LoopGridViewHelper.New(self._scroll.gameObject)

	self._loopGridView:InitGridView(0, self._onCellUpdate, self)

	self._guiAnimation = goutil.addComponentOnce(self._registry:getMainGO(), typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self._loopGridView:Dispose()

	self._loopGridView = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_addEvents()
	GlobalDispatcher:addEventListener(EventType.UPDATA_ACHIEVEMENT, self._updateNormal, self)
	GlobalDispatcher:addEventListener(EventType.RED_DOT_VIEW_EVENT, self._updateNormal, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_ACHIEVEMENT_REFRESH, self._onClickItem, self)
end

function M:_removeEvents()
	GlobalDispatcher:removeEventListener(EventType.UPDATA_ACHIEVEMENT, self._updateNormal, self)
	GlobalDispatcher:removeEventListener(EventType.RED_DOT_VIEW_EVENT, self._updateNormal, self)
	GlobalDispatcher:removeEventListener(EventType.PLAYER_ACHIEVEMENT_REFRESH, self._onClickItem, self)
end

function M:onEnter()
	self:_addEvents()

	self._hasRefreshScroll = false

	AchievementAgent.instance:sendGetAllAchievementRequest()

	self._curSelectIndex = 1
	self._data = AchievementModel.instance:getAchievementSkillListModel():getMoList()[self._curSelectIndex]

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
end

function M:onExit()
	self:_removeEvents()
	self:_playItemOpenAni(false)
	self._loopGridView:ClearCells()

	self._hasRefreshScroll = false
end

function M:_updateNormal()
	local resetPos = not self._hasRefreshScroll
	local needPlayAnim = not self._hasRefreshScroll

	self:_updateInfo(resetPos, needPlayAnim)

	local moList = AchievementModel.instance:getAchievementSkillListModel():getMoList()
	local taskTotalCount = 0

	for i, v in ipairs(moList) do
		taskTotalCount = taskTotalCount + v:getFinishCnt()
	end

	if self._txtCount then
		self._txtCount.text = taskTotalCount
	end
end

function M:_onClickItem(_, index)
	self._curSelectIndex = index
	self._data = AchievementModel.instance:getAchievementSkillListModel():getMoList()[self._curSelectIndex]

	self:_updateInfo(false, false)
end

function M:_updateInfo(resetPos, needPlayAnim)
	self:_refreshScrollView(resetPos, needPlayAnim)
end

function M:_refreshScrollView(resetPos, needPlayAnim)
	self._needPlayItemCellOpenAni = needPlayAnim
	self._needPlayItemAniMaxIndex = 12
	self._itemShowerCache = {}

	local mo = AchievementModel.instance:getAchievementSkillListModel():getMoList()
	local count = mo and #mo or 0

	self._loopGridView:SetListItemCount(count, resetPos)
	self._loopGridView:RefreshAllShownItem()
	self:_playItemOpenAni(needPlayAnim)

	self._hasRefreshScroll = true
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local class = AchievementSkillIFragmentItem
	local item = self._loopGridView:NewListViewItem("achievement_list_item")
	local data = AchievementModel.instance:getAchievementSkillListModel():getMoList()[curIndex]
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, class)

	shower:updateData(data, curIndex)
	shower:showSelect(self._curSelectIndex == curIndex)

	if self._needPlayItemCellOpenAni and curIndex <= self._needPlayItemAniMaxIndex then
		self._itemShowerCache[curIndex] = shower

		shower:setAlpha(0)
	else
		shower:setAlpha(1)
	end

	return item
end

function M:_playItemOpenAni(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	if play then
		local maxDelay = 1

		self._scroll.enabled = false

		for index, shower in ipairs(self._itemShowerCache or {}) do
			local delay = (index - 1) * 0.1

			delay = delay > 1 and 1 or delay
			maxDelay = maxDelay < delay and delay or maxDelay

			shower:setAlpha(0)

			if delay > 0 then
				local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
					shower:setAlpha(1)
					shower:playOpenAni()
				end)

				table.insert(self._cacheTweenLst, tweenDelay)
			else
				shower:setAlpha(1)
				shower:playOpenAni()
			end
		end

		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay, function()
			self._scroll.enabled = true
		end))
	else
		for index, shower in ipairs(self._itemShowerCache or {}) do
			shower:setAlpha(1)
		end

		self._cacheTweenLst = nil
		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false
		self._scroll.enabled = true
	end
end

return M
