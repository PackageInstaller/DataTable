-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/entrance/fragment/GameplayMainlineFragmentView.lua

module("logic.extensions.dungeon.view.entrance.fragment.GameplayMainlineFragmentView", package.seeall)

local M = class("GameplayMainlineFragmentView", GameplaySubViewBase)
local kEmptyChapterWidth = 525
local kNormalChapterWidth = 546
local kItemSpace = 0
local kItemPaddingRight = 0
local kLastEmptyWidth = 525
local kStopOffsetX = 0.1
local kDefaultItemScale = 0.7

function M:buildUI()
	M.super.buildUI(self)

	self._goContent = self._registry:getGo("fight_entry_mainline_panel_-165193550")
	self._goContentNormal = self._registry:getGo("fight_entry_mainline_panel_-820242911")
	self._goLight = self._registry:getGo("fight_entry_mainline_panel_625775338")
	self._traContent = self._goContent.transform
	self._rectTraContent = self._goContentNormal:GetComponent(UIComponentType.RectTransform)

	local mainGo = self._registry:getMainGO()

	self._goItemPrefab = goutil.findChild(mainGo, "scrollView/viewport/fight_entry_chapter_item")
	self._allItems = {}
end

function M:destroyUI()
	M.super.destroyUI(self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	M.super.onEnter(self)
	self:_setEvent(true)

	self._chapterId = 0

	self:_initView()
	self:_refreshView()
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BGMAMBCHANGE, CriwareAudioEnum.music_main_huodong)
	FrameUpdate:addListener(self)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._rectTraContent)
	settimer(0, self._delayEnter, self, false)
end

function M:_delayEnter()
	if self._lastIndex then
		self:_moveToIndex(self._lastIndex, true)
	else
		self:_moveToIndex(#self._allItems, true)
	end
end

function M:onExit()
	M.super.onExit(self)
	self:_setEvent(false)
	FrameUpdate:removeListener(self)

	self._inMove = false
	self._isPointerPressed = false
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.INPUT_POINTER_PRESSED, self._getPointerPressed, self)
		GlobalDispatcher:addEventListener(EventType.INPUT_POINTER_RELEASE, self._getPointerRelease, self)
	else
		GlobalDispatcher:removeEventListener(EventType.INPUT_POINTER_PRESSED, self._getPointerPressed, self)
		GlobalDispatcher:removeEventListener(EventType.INPUT_POINTER_RELEASE, self._getPointerRelease, self)
	end
end

function M:_getPointerPressed()
	self._isPointerPressed = true
	self._pressedPos = MainPlayerInputFacade.instance:getScreenPosition()
end

function M:_getPointerRelease()
	self._isPointerPressed = false
	self._releasePos = MainPlayerInputFacade.instance:getScreenPosition()

	self:_moveToTarget()
end

function M:_onContentEndDrag()
	if self._isPointerPressed then
		return
	end

	self:_moveToTarget()
end

function M:luaUpdate(deltaTime)
	self:_calcItemScale()
end

function M:_calcItemScale()
	local lightPos = self._goLight.transform.position

	for k, v in pairs(self._allItems) do
		local pos = v._go.transform.position
		local offsetX = math.abs(pos.x - lightPos.x)
		local scale = offsetX == 0 and 1 or kDefaultItemScale
		local realWidth = 5

		if offsetX < realWidth then
			scale = kDefaultItemScale + (realWidth - offsetX) / realWidth * (1 - kDefaultItemScale)
		end

		v._go.transform.localScale = Vector3.one * scale
	end
end

function M:_moveToTarget()
	if self._inMove then
		return
	end

	local calcIndex = 1
	local curPos = self._rectTraContent.position
	local lightPos = self._goLight.transform.position
	local minOffset = 1000
	local minIndex = -1

	for k, v in pairs(self._allItems) do
		local pos = v._go.transform.position
		local offsetX = math.abs(pos.x - lightPos.x)

		if offsetX < minOffset then
			minOffset = offsetX
			minIndex = k
		end
	end

	if minIndex ~= -1 then
		local offsetX = lightPos.x - self._allItems[minIndex]._go.transform.position.x

		self._rectTraContent:DOKill(true)

		local moveSpeed = 5
		local moveTime = math.abs(offsetX) / moveSpeed

		self._rectTraContent:DOMoveX(curPos.x + offsetX, moveTime):OnComplete(self._onMoveFinish, self):SetEase(DG.Tweening.Ease.Linear)

		self._inMove = true

		if self._lastIndex ~= nil then
			self._lastIndex = minIndex
		end

		self:_setHighLightItem(minIndex)
	end
end

function M:_moveToIndex(idx, isIgnoreAni)
	local curPos = self._rectTraContent.position
	local lightPos = self._goLight.transform.position
	local offsetX = lightPos.x - self._allItems[idx]._go.transform.position.x

	if isIgnoreAni then
		self._rectTraContent:DOKill(true)

		curPos.x = curPos.x + offsetX
		self._rectTraContent.position = curPos
	else
		self._rectTraContent:DOKill(true)

		local moveSpeed = 10
		local moveTime = math.abs(offsetX) / moveSpeed

		self._rectTraContent:DOMoveX(curPos.x + offsetX, moveTime):OnComplete(self._onMoveFinish, self):SetEase(DG.Tweening.Ease.Linear)

		self._inMove = true
	end

	self:_setHighLightItem(idx)

	self._lastIndex = idx
end

function M:_setHighLightItem(idx)
	for k, v in pairs(self._allItems) do
		v:setHighLight(k == idx)
	end
end

function M:_onMoveFinish()
	self._inMove = false
end

function M:_checkScrollStop()
	if self._inMove then
		return
	end

	local pos = self._rectTraContent.position

	if self._lastContentPos then
		local offsetX = math.abs(pos.x - self._lastContentPos.x)

		if offsetX <= kStopOffsetX then
			if self._isInDrag then
				self:_onContentEndDrag()
			end

			self._isInDrag = false
		else
			self._isInDrag = true
		end
	end

	self._lastContentPos = pos
end

function M:_initView()
	local chapterMOList = DungeonMainLineChapterModel.instance:getAllMainlineChapter()

	self._unlockChapterMOList = {}

	for i, chapterMO in ipairs(chapterMOList) do
		if chapterMO[1]:isPreChapterPassed() then
			table.insert(self._unlockChapterMOList, chapterMO)
		end
	end

	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nowTime)
end

function M:_refreshView()
	local showIndex = 0
	local difficulty = DungeonEnum.Difficulty.Easy

	for index, chapterMoMap in ipairs(self._unlockChapterMOList) do
		if chapterMoMap[difficulty]:getChapterId() == self._chapterId then
			showIndex = index - 1

			break
		end
	end

	local width = #self._unlockChapterMOList * kNormalChapterWidth + (#self._unlockChapterMOList - 1) * (kItemPaddingRight + kItemSpace) + kEmptyChapterWidth + kLastEmptyWidth

	if #self._unlockChapterMOList == 1 then
		width = width + kLastEmptyWidth
	end

	local size = self._rectTraContent.sizeDelta

	self._rectTraContent.sizeDelta = Vector2.New(width, size.y)

	for k, v in pairs(self._unlockChapterMOList) do
		local item = self._allItems[k]

		if not item then
			local go = goutil.cloneAndSetParent(self._goItemPrefab, self._goContentNormal.transform)

			item = Astral.SimpleLuaComponentContainer.Add(go, GameplayChapterItem)
			self._allItems[k] = item
		end

		local data = {}

		data.mo = v

		local index = k

		function data.callback()
			self:_onItemClick(index)
		end

		item:updateData(data)
	end

	for _, chapterMoMap in ipairs(self._unlockChapterMOList) do
		DungeonMainLineChapterModel.instance:setDungeonChapterCache(chapterMoMap[difficulty]:getChapterId())
	end
end

function M:_onUpdateData(idx, dataIndex)
	if idx >= self._traContent.childCount then
		return
	end

	local go = self._traContent:GetChild(idx).gameObject
	local itemData = self._unlockChapterMOList[dataIndex + 1]
	local item = Astral.SimpleLuaComponentContainer.Add(go, GameplayChapterItem)
	local data = {}

	data.mo = itemData

	item:updateData(data)
end

function M:_onItemClick(dataIndex)
	settimer(0, function()
		if self._pressedPos and self._releasePos then
			local distance = math.abs(self._pressedPos.x - self._releasePos.x) + math.abs(self._pressedPos.y - self._releasePos.y)

			if distance > 25 then
				return
			end
		end

		local item = self._allItems[dataIndex]

		if item:getHighLight() then
			item:execClick()
		else
			self:_moveToIndex(dataIndex)
		end
	end, self, false)
end

return M
