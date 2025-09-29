-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/teachingdungeon/TeachingChapterView.lua

module("logic.extensions.dungeon.view.teachingdungeon.TeachingChapterView", package.seeall)

local kTeachingChapterTabState = {
	Done = 4,
	Unlock = 1,
	Lock = 2,
	None = 3
}
local TeachingChapterTab = class("TeachingChapterTab", SimpleCellComponent)

function TeachingChapterTab:buildUI()
	self._goStateDone = goutil.findChild(self._go, "stateDone")
	self._goStateNone = goutil.findChild(self._go, "stateNone")
	self._goStateLock = goutil.findChild(self._go, "stateLock")
	self._goSelect = goutil.findChild(self._go, "imgSelect")
	self._goPointOpen = goutil.findChild(self._go, "objDian/imgOpen")
	self._goPointClose = goutil.findChild(self._go, "objDian/imgClose")
	self._goRedPoint = goutil.findChild(self._go, "red_point")
	self._canvasGroup = goutil.addComponentOnce(self._go, ComponentType.CanvasGroup)
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "click"))
	self._goStates = {
		[kTeachingChapterTabState.Lock] = self._goStateLock,
		[kTeachingChapterTabState.None] = self._goStateNone,
		[kTeachingChapterTabState.Done] = self._goStateDone
	}
	self._goAlpha = {
		[kTeachingChapterTabState.Unlock] = 1,
		[kTeachingChapterTabState.Lock] = 0.14,
		[kTeachingChapterTabState.None] = 0.14,
		[kTeachingChapterTabState.Done] = 0.5
	}
end

function TeachingChapterTab:bindEvents()
	self._btnClick:AddClickListener(self.onClick, self)
end

function TeachingChapterTab:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function TeachingChapterTab:setSelect(isSelect)
	goutil.setActive(self._goSelect, isSelect)
end

function TeachingChapterTab:setState(state)
	if not state then
		return
	end

	for k, v in pairs(self._goStates) do
		goutil.setActive(v, k == state)
	end

	self._canvasGroup.alpha = self._goAlpha[state] or 1

	local isOpen = state == kTeachingChapterTabState.Unlock or state == kTeachingChapterTabState.Done

	goutil.setActive(self._goPointOpen, isOpen)
	goutil.setActive(self._goPointClose, not isOpen)
end

function TeachingChapterTab:setClickCallback(callback)
	self._clickCallback = callback
end

function TeachingChapterTab:onClick()
	if self._clickCallback then
		self._clickCallback()
	end
end

function TeachingChapterTab:updateData(data)
	self:setState(data.state)
	RedDotModel.instance:createDotView({
		dotNode = self._goRedPoint,
		keyList = {
			RedDotType.ERedDotKey.TEACHING_CHAPTER .. data.chapterId
		},
		parentKeyList = {
			RedDotType.ERedDotKey.TEACHING_CHAPTER
		}
	})
end

local M = class("TeachingChapterView", ViewComponent)

function M:buildUI()
	self._btnReturn = self:getBtn("1&title_view_-878360263")
	self._btnHome = self:getBtn("1&title_view_1398742689")
	self._chapterPanelTabList = {
		Astral.SimpleLuaComponentContainer.Add(self:getGo("teach_explore_main_view_-251422239"), TeachingChapterTab),
		Astral.SimpleLuaComponentContainer.Add(self:getGo("teach_explore_main_view_-125138510"), TeachingChapterTab),
		Astral.SimpleLuaComponentContainer.Add(self:getGo("teach_explore_main_view_-596481729"), TeachingChapterTab)
	}
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._fillImg1 = self:getImage("teach_explore_main_view_1422530967")
	self._cell1Go = self:getGo("teach_explore_main_view_1075062311")

	goutil.setActive(self._cell1Go, false)

	self._rewardCountTxtList = {}
	self._rewardCellList = {}
	self._rewardCellGo = {}
	self._passedCountTxt = self:getText("teach_explore_main_view_1817137658")
	self._scroll = self:getGo("teach_explore_main_view_402340977")
	self._loopListHelper = LoopListHelper.New(self._scroll)

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)

	self._firstOpen = true

	self:initTabItem()
end

function M:initTabItem()
	for k, v in pairs(self._chapterPanelTabList) do
		v:setClickCallback(function()
			self:_onClickChapter(k, true)
		end)
	end
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	GlobalDispatcher:addEventListener(EventType.JUMP_TO_TEACH_MAIN, self._playAllOpen, self)
	self:registerLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._dealTimelineListener, self)
end

function M:_dealTimelineListener(_, tagName, reason)
	return
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.JUMP_TO_TEACH_MAIN, self._playAllOpen, self)
	self:unregisterLocalNotify(EventType.FW_VIEW_ANIMATION_DONE_EVENT, self._dealTimelineListener, self)
end

function M:_onClickReturn()
	self._onReturning = true

	self:back()
end

function M:onExit()
	self:setEvent(false)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_TeachExplore)
	self._loopListHelper:ClearCells()
end

function M:onExitFinished()
	self._onReturning = false
end

function M:destroyUI()
	self._loopListHelper:Dispose()

	self._loopListHelper = nil

	if ViewMgr.instance:isOpen(ViewName.TeachingDungeon) then
		ViewMgr.instance:close(ViewName.TeachingDungeon)
	end
end

function M:onEnter()
	self:setEvent(true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_TeachExplore)
	self:_refreshView()
	self:_onClickChapter(self._chapterIdx or self:_getCurProgressIndex())
end

function M:_getCurProgressIndex()
	local index = 1

	for k, v in pairs(self._teachingChapterMoList) do
		local dungeonIds = self._teachingChapterMoList[k]:getDungeonIds()

		if #dungeonIds ~= 0 and self._teachingChapterMoList[k]:getIsChapterUnlock() then
			index = k
		end
	end

	return index
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.DUNGEON_STAR_REWARD_UPDATE, self._refreshRewardTakenPanel, self)
		GlobalDispatcher:addEventListener(EventType.TEACH_VIEW_UPDATE, self._updateView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.DUNGEON_STAR_REWARD_UPDATE, self._refreshRewardTakenPanel, self)
		GlobalDispatcher:removeEventListener(EventType.TEACH_VIEW_UPDATE, self._updateView, self)
	end
end

function M:_refreshView()
	self._teachingChapterMoList = {}

	local chapterList = DungeonTeachingChapterModel.instance:getAllChapter()

	for k, v in pairs(chapterList) do
		table.insert(self._teachingChapterMoList, v)
	end

	table.sort(self._teachingChapterMoList, function(moA, moB)
		return moA:getChapterId() < moB:getChapterId()
	end)

	if #self._teachingChapterMoList ~= 3 then
		FloatWordMgr.instance:show("配置错误 章节数不是3个")
	end

	for i, v in ipairs(self._teachingChapterMoList) do
		local cnt = #v:getDungeonIds()
		local formatStr = "<color=#b0b0b0><size=26>%s</size></color>/%s"

		if v:getChapterId() == 1002 then
			formatStr = "<color=#9663aa><size=26>%s</size></color>/%s"
		elseif v:getChapterId() == 1003 then
			formatStr = "<color=#ae3030><size=26>%s</size></color>/%s"
		end

		local dungeonIds = #v:getDungeonIds()
		local item = self._chapterPanelTabList[i]

		if item then
			local data = {}
			local state = kTeachingChapterTabState.Unlock

			if not v:getIsChapterUnlock() and dungeonIds > 0 then
				state = kTeachingChapterTabState.Lock
			elseif cnt <= v:getPassedDungeonCount() and v:getIsChapterUnlock() and dungeonIds > 0 then
				state = kTeachingChapterTabState.Done
			elseif dungeonIds == 0 then
				state = kTeachingChapterTabState.None
			end

			data.state = state
			data.chapterId = v:getChapterId()

			item:updateData(data)
		end

		self:updateChapterRedDot(v:getChapterId())
	end
end

function M:updateChapterRedDot(chapterId)
	local chapterMo = DungeonTeachingChapterModel.instance:getChapterMoByChapterId(chapterId)
	local passedCount = chapterMo:getPassedDungeonCount()
	local rewardList = chapterMo:getChapterReward()
	local hadNotGetReward = false

	for i, v in ipairs(rewardList) do
		local rewardConfig = RewardConfig.instance:getRewardCfgByCode(v.reward)

		if rewardConfig and rewardConfig.reward and rewardConfig.reward[1] then
			local status = CommEnum.RewardEnum.CanNotGot

			if chapterMo:getRewardTakenStatusByIndex(i) then
				status = CommEnum.RewardEnum.HasGot
			elseif passedCount >= v.count then
				status = CommEnum.RewardEnum.CanGot
				hadNotGetReward = true
			end
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.RED_DOT_UPDATE_EVENT, {
		key = RedDotType.ERedDotKey.TEACHING_CHAPTER .. chapterId,
		isActive = hadNotGetReward
	})
end

function M:_onClickHome()
	self._onReturning = true

	DungeonTeachingChapterModel.instance:setClickChapterIdAndDungeonIndex()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickChapter(index, isIgnoreSameIndex)
	if self._onReturning or isIgnoreSameIndex and index == self._chapterIdx then
		return
	end

	local dungeonIds = self._teachingChapterMoList[index]:getDungeonIds()

	if #dungeonIds == 0 then
		FloatWordMgr.instance:show(lang("tip_teaching_chapter_locked"))

		return
	end

	if self._teachingChapterMoList[index]:getIsChapterUnlock() then
		for k, v in pairs(self._chapterPanelTabList) do
			v:setSelect(index == k)
		end

		self:_updateView(self, self._teachingChapterMoList[index]:getChapterId())

		self._chapterIdx = index
	else
		FloatWordMgr.instance:show(lang("tip_pass_pre_chapter_unlock"))
	end
end

function M:_updateView(_, chapterId)
	self._chapterId = chapterId
	self._chapterMo = DungeonTeachingChapterModel.instance:getChapterMoByChapterId(self._chapterId)
	self._focusIndex = self._chapterMo:getFirstNotPassedDungeonIndex() - 2

	self:_refreshChapterView()
	self:_refreshRewardTakenPanel()
	self._loopListHelper:MoveToItemIndex(self._focusIndex)

	self._loopList = self._loopListHelper:GetLoopListView()
end

function M:_refreshChapterView()
	self._dungeonIds = self._chapterMo:getDungeonIds()

	self._loopListHelper:SetListItemCount(#self._dungeonIds, true)
end

function M:_refreshRewardTakenPanel()
	local passedCount = self._chapterMo:getPassedDungeonCount()
	local totalCount = #self._chapterMo:getDungeonIds()

	self:updateChapterRedDot(self._chapterMo:getChapterId())

	self._passedCountTxt.text = string.format("<color=#ffffff><size=32>%d</size></color>/%d", passedCount, totalCount)

	local rewardList = self._chapterMo:getChapterReward()
	local getReward = self._chapterMo:getRewardTakenStatusByIndex(#rewardList)

	for k, v in pairs(self._rewardCellGo) do
		goutil.setActive(v, false)
	end

	for i, v in ipairs(rewardList) do
		local rewardConfig = RewardConfig.instance:getRewardCfgByCode(v.reward)

		if rewardConfig and rewardConfig.reward and rewardConfig.reward[1] then
			local reward = rewardConfig.reward[1]
			local canGot = passedCount >= v.count
			local status = CommEnum.RewardEnum.CanNotGot

			if self._chapterMo:getRewardTakenStatusByIndex(i) then
				status = CommEnum.RewardEnum.HasGot
			elseif passedCount >= v.count then
				status = CommEnum.RewardEnum.CanGot
			end

			local itemData = ItemData.New({
				itemId = reward.code,
				count = reward.num
			})
			local cell = self._rewardCellList[i]

			if not cell then
				local go = goutil.cloneAndSetParent(self._cell1Go, self._cell1Go.transform.parent)
				local child = goutil.findChild(go, "cell/backpack_item")

				cell = Astral.LuaComponentContainer.Add(child, TeachingDungeonItemCell)
				self._rewardCellList[i] = cell
				self._rewardCellGo[i] = go
			end

			cell:Awake()
			cell:updateData(itemData)
			cell:setShowSelectedEffect(false)
			cell:getComponent("reward"):setRewardStatus(status)
			cell:getComponent("normal"):setClickListener(self._clickReward, self)
			cell:getComponent("reward"):setIndex(i)

			local rewardGo = cell:getGo()

			if not self._rewardCountTxtList[i] then
				self._rewardCountTxtList[i] = goutil.findChildTextComponent(self._rewardCellGo[i], "txtProgress")
			end

			self._rewardCountTxtList[i].text = v.count

			local stateReveiveGo = goutil.findChild(self._rewardCellGo[i], "cell/stateReveive")
			local receivedGo = goutil.findChild(rewardGo.transform.parent.gameObject, "stateReceived")
			local canvasGroup = rewardGo:GetComponent(ComponentType.CanvasGroup)
			local isGetReward = self._chapterMo:getRewardTakenStatusByIndex(i)
			local fillImg = goutil.findChildImageComponent(self._rewardCellGo[i], "fill1/fill")
			local lastPassCount = rewardList[i - 1] and rewardList[i - 1].count or 0
			local curPassCount = rewardList[i].count - lastPassCount
			local passProgress = passedCount >= rewardList[i].count and 1 or (passedCount - lastPassCount) / curPassCount

			fillImg:DOFillAmount(passProgress, 0.2)

			canvasGroup.alpha = isGetReward and 0.5 or 1

			goutil.setActive(receivedGo, isGetReward)
			goutil.setActive(stateReveiveGo, canGot)
			goutil.setActive(self._rewardCellGo[i], true)
		end
	end
end

function M:_clickReward(cell)
	local index = cell:getComponent("reward"):getIndex()

	if self._chapterMo:getRewardTakenStatusByIndex(index) then
		cell:dealSelect()

		return true
	end

	local passedCount = self._chapterMo:getPassedDungeonCount()
	local rewardList = self._chapterMo:getChapterReward()

	if passedCount >= rewardList[index].count then
		DungeonAgent.instance:SendTakeTrainingRewardRequest(self._chapterId, index - 1)
	else
		cell:dealSelect()

		return true
	end
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local dungeonId = self._dungeonIds[curIndex]
	local item = self._loopListHelper:NewListViewItem("case_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, TeachingDungeonCell)

	shower:setData(dungeonId)
	shower:setClickFightCallBack(self._onClickFight, self)

	return item
end

function M:_onClickFight(dungeonId)
	local dungeonMo = DungeonTeachingChapterModel.instance:getDungeonMoById(dungeonId)

	if dungeonMo:getIsUnlock() then
		local index = 1

		for i, v in ipairs(self._chapterMo:getDungeonIds()) do
			if v == dungeonId then
				index = i
			end
		end

		DungeonTeachingChapterModel.instance:setClickChapterIdAndDungeonIndex(self._chapterId, index)

		local info = {}

		info.dungeonCode = dungeonId
		info.afflatusBuff = false
		info.isShowPlot = true
		info.multiCount = 1
		info.dungeonIndex = self._curDungeonIndex
		info.gamePlay = BattleEnum.GamePlayType.NORMAL

		DungeonController.instance:startDungeonBattle(info)
	else
		FloatWordMgr.instance:show(lang("tip_chapter_lock"))
	end
end

function M:_playAllOpen()
	ViewBlockMgr.instance:blockClick(true, ViewBlockKey.Anim)

	self._playingAni = true

	self._guiAnimation:PlayAniByName("abc_open")
	self:_refreshView()
end

return M
