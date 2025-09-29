-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcondition/BattleConditionsView.lua

module("logic.extensions.battle.viewcondition.BattleConditionsView", package.seeall)

local BattleConditionsView = class("BattleConditionsView", ViewComponent)
local kSpacing = 9.72
local kInternal = 0.1

function BattleConditionsView:buildUI()
	self._goImgBattle = goutil.findChild(self.mainGO, "imgbattle")
	self._goImgChange = goutil.findChild(self.mainGO, "imgChange")
	self._goContent = goutil.findChild(self.mainGO, "content/lay")
	self._goItemCacheRoot = goutil.findChild(self.mainGO, "content/item")
	self._goTemplate = goutil.findChild(self.mainGO, "content/item/item1")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._itemList = {}
	self._itemCaches = {}
	self._baseTags = {}
	self._addedTags = {}
	self._removedTags = {}
	self._timelineTask = TimelineTask.New()
end

function BattleConditionsView:destroyUI()
	self._goImgBattle = nil
	self._goImgChange = nil
	self._goContent = nil
	self._goTemplate = nil
	self._goItemCacheRoot = nil
	self._itemList = nil
	self._itemCaches = nil
end

function BattleConditionsView:onEnter()
	local isChanged = self:getFirstParam()

	BattleTableUtil.insertto(self._baseTags, self:getOpenParam()[2])
	BattleTableUtil.insertto(self._addedTags, self:getOpenParam()[3])
	BattleTableUtil.insertto(self._removedTags, self:getOpenParam()[4])
	self:_updateBaseView(isChanged)

	if isChanged then
		self:_updateAsChangedView()
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open02")
	else
		self._guiAnimation:StopTimelineAni()
		self._guiAnimation:PlayAniByName("open01")
	end

	BattleAudioUtil.playSEByName("ui_battle_shenglitiaojian")
end

function BattleConditionsView:onExit()
	self:_clearAllItem()
	BattleTableUtil.clearTable(self._baseTags)
	BattleTableUtil.clearTable(self._addedTags)
	BattleTableUtil.clearTable(self._removedTags)
end

function BattleConditionsView:_updateBaseView(isChanged)
	local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()
	local dungeonBattleInfoCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(activeBattleFlow:getBattleLevelCode())
	local winCondition = BattleMgr.instance:getWinCondition()
	local extraWinCondition = winCondition:getExtraWinConditionDesc() or ""

	goutil.setActive(self._goImgBattle, not isChanged)
	goutil.setActive(self._goImgChange, isChanged)

	local winConditionTags = isChanged and self._baseTags or winCondition:getAdditionalWinConditionTags()

	for _, tag in pairs(winConditionTags) do
		local desc = dungeonBattleInfoCOWrapper:getConditionDescription(tag)

		if not string.nilorempty(extraWinCondition) then
			desc = string.format("%s<color=#FFFFFF>或</color>%s", desc, extraWinCondition)
		end

		if not string.nilorempty(desc) then
			local item = self:_getOrCreateItem(tag, desc)

			goutil.addChildToParent(item.mainGO, self._goContent)
			table.insert(self._itemList, item)
		end
	end
end

function BattleConditionsView:_updateAsChangedView()
	self._timelineTask:clear()
	self._timelineTask:addTask(1)

	if #self._removedTags > 0 then
		local waitTime = math.max(0.8, #self._itemList * kInternal)

		self._timelineTask:addTask(0, self._tProcessRemovedTags, self)
		self._timelineTask:addTask(waitTime, self._tClearRemovedItems, self)
	end

	if #self._addedTags > 0 then
		local waitTime = math.max(0.8, #self._addedTags * kInternal)

		self._timelineTask:addTask(0, self._tProcessAddedTags, self)
		self._timelineTask:addTask(waitTime)
	end

	self._timelineTask:start()
end

function BattleConditionsView:_tProcessRemovedTags()
	local deltaY = 0
	local itemList = self._itemList
	local removedTags = self._removedTags
	local delay = 0
	local flyToList = BattleTableUtil.getTempList()

	for _, item in pairs(itemList) do
		if table.indexof(removedTags, item:getTag()) then
			item:flyout(delay)

			delay = delay + kInternal
			deltaY = deltaY + item:getHeight() + kSpacing
		else
			table.insert(flyToList, item)
		end
	end

	for _, item in ipairs(flyToList) do
		delay = delay + kInternal

		item:flyTo(delay, deltaY)
	end

	BattleTableUtil.releaseTempList(flyToList)
end

function BattleConditionsView:_tClearRemovedItems()
	local itemList = self._itemList
	local removedTags = self._removedTags

	for index = #itemList, 1, -1 do
		local item = itemList[index]

		if table.indexof(removedTags, item:getTag()) then
			self:_destroyItem(item)
			table.remove(itemList, index)
		else
			item:stopAnimation()
		end
	end
end

function BattleConditionsView:_tProcessAddedTags()
	local activeBattleFlow = BattleMgr.instance:getActiveBattleFlow()
	local dungeonBattleInfoCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(activeBattleFlow:getBattleLevelCode())
	local addedTags = self._addedTags
	local delay = 0

	for _, tag in pairs(addedTags) do
		local desc = dungeonBattleInfoCOWrapper:getConditionDescription(tag)

		if not string.nilorempty(desc) then
			local item = self:_getOrCreateItem(tag, desc)

			goutil.addChildToParent(item.mainGO, self._goContent)
			table.insert(self._itemList, item)
			item:flyin(delay)

			delay = delay + kInternal
		end
	end
end

function BattleConditionsView:_getOrCreateItem(tag, content)
	local item = table.remove(self._itemCaches)

	if not item then
		local goItem = goutil.clone(self._goTemplate)

		item = BattleConditionItem.New(goItem)
	end

	item:setTag(tag)
	item:setContent(content)

	return item
end

function BattleConditionsView:_clearAllItem()
	for _, item in ipairs(self._itemList) do
		self:_destroyItem(item)
	end

	BattleTableUtil.clearTable(self._itemList)
end

function BattleConditionsView:_destroyItem(item)
	table.insert(self._itemCaches, item)
	goutil.addChildToParent(item.mainGO, self._goItemCacheRoot)
end

return BattleConditionsView
