-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/unit/comp/map/RogueUnitCompBubble.lua

module("logic.extensions.roguelike.unit.comp.map.RogueUnitCompBubble", package.seeall)

local M = class("RogueUnitCompBubble", RogueUnitCompBase)
local BubbleWordItem = class("BubbleWordItem")

function BubbleWordItem:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	local animGO = goutil.findChild(self._mainGO, "root")

	self._anim = goutil.addComponentOnce(animGO, ComponentType.Animation)
	self._txtContent = goutil.findChildTextComponent(animGO, "txtContent")
end

function BubbleWordItem:setVisible(visible)
	goutil.setActive(self._mainGO, visible)
end

function BubbleWordItem:isPlaying()
	return self._anim.isPlaying
end

function BubbleWordItem:play(name)
	self._anim:Play(name)
end

function BubbleWordItem:setContent(str)
	self._txtContent.text = str
end

local BubbleType = SceneEnum.BubbleType
local kPrefabUrl = ResName.Rungroupexplore_npc_talk
local kAniNameTalkOpen = "npc_talk_type1_open"
local kAniNameTalkClose = "npc_talk_type1_close"
local kAniNameEmoji = "npc_talk_type3"
local kAniNameWord = "npc_talk_type2"
local kContinueTimeTalk = 4
local kEndWaitTimeTalk = 2
local kEmojiBubbleTime = 2
local kWordCount = 4

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._bubbleSequeue = false

	self:_resetData()

	self._resLoader = false
end

function M:onInit()
	if self._isInit then
		return
	end

	self._bubbleSequeue = Queue.create()
	self._nextBubbleTimer = SchedulerCtrl.New(self._showNext, self)
	self._talkBubbleTimer = SchedulerCtrl.New(self._endTalkBubble, self)
	self._emojiBubbleTimer = SchedulerCtrl.New(self._endEmojiBubble, self)

	self:_resetData()

	local rootGo = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)
	local talkGo = goutil.create("talk", true)

	goutil.addChildToParent(talkGo, rootGo)

	self._goTalk = talkGo
	self._resLoader = PrefabLoader.Get(talkGo)
	self._followUIComp = self._unit.uiFollow
	self._viewElementsRegistry = ViewElementsRegistry.New()

	self:setPanelResPath(kPrefabUrl)

	self._isInit = true
end

function M:onReuse()
	M.super.onReuse(self)
	self:setPanelResPath(kPrefabUrl)

	self._isInit = false
end

function M:setPanelResPath(resPath)
	if self._resLoader and self._loadPath == nil then
		self._resLoader:load(resPath, self._onResLoaded, self, true)

		self._loadPath = resPath
	end
end

function M:_onResLoaded(loader)
	self._loadPath = nil
	self._mainGo = self._resLoader:getInst()

	if self._mainGo == nil then
		return
	end

	self._followUIComp:addTopFollowGameObject(self._mainGo)
	self._viewElementsRegistry:setMainGO(self._mainGo)
	self:onBuildUI()
end

function M:onReset()
	M.super.onReset(self)
	self._nextBubbleTimer:stop()
	self._talkBubbleTimer:stop()
	self._emojiBubbleTimer:stop()
	self._bubbleSequeue:clear()
	self:_resetData()
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._nextBubbleTimer:clear()

	self._nextBubbleTimer = nil

	self._talkBubbleTimer:clear()

	self._talkBubbleTimer = nil

	self._emojiBubbleTimer:clear()

	self._emojiBubbleTimer = nil
	self._bubbleSequeue = false

	self:_resetData()

	if self._goTalk then
		goutil.destroy(self._goTalk)
	end
end

function M:_resetData()
	self._loop = false
	self._currBubbleData = false
	self._typeMapRootGO = false
	self._goTalkRoot = false
	self._goWordRoot = false
	self._goEmojiRoot = false
	self._txtTalkContent = false
	self._txtWordContent = false
	self._imgEmoji = false
	self._wordItemList = false
	self._talkAnima = false
	self._emojiAnima = false
	self._hasBuildUI = false
	self._wordLimitCount = kWordCount
end

function M:onBuildUI()
	self._goTalkRoot = self._viewElementsRegistry:findUIElement("npc_talk_top_813338642")
	self._goNameRoot = self._viewElementsRegistry:findUIElement("npc_talk_top_rogue_-483093677")
	self._talkAnima = goutil.addComponentOnce(self._goTalkRoot, ComponentType.Animation)
	self._goWordRoot = self._viewElementsRegistry:findUIElement("npc_talk_top_-892090260")
	self._goEmojiRoot = self._viewElementsRegistry:findUIElement("npc_talk_top_-434930127")
	self._emojiAnima = goutil.addComponentOnce(self._goEmojiRoot, ComponentType.Animation)
	self._typeMapRootGO = {
		[BubbleType.Talk] = self._goTalkRoot,
		[BubbleType.Word] = self._goWordRoot,
		[BubbleType.Emoji] = self._goEmojiRoot
	}
	self._txtTalkContent = self._viewElementsRegistry:findUIElement("npc_talk_top_-477908731", UIComponentType.TextMeshProUGUI)
	self._txtNameContent = self._viewElementsRegistry:findUIElement("npc_talk_top_rogue_1919372289", UIComponentType.Text)
	self._imgEmoji = self._viewElementsRegistry:findUIElement("npc_talk_top_-659601998", UIComponentType.Image)
	self._wordItemList = {}

	for i = 1, kWordCount do
		local go = goutil.findChild(self._goWordRoot, string.format("word_%s", i))
		local item = Astral.LuaComponentContainer.Add(go, BubbleWordItem)

		table.insert(self._wordItemList, item)
	end

	self._hasBuildUI = true

	self:_showNext()
end

function M:endBubble()
	self._talkBubbleTimer:stop()
	self._nextBubbleTimer:stop()
	self._emojiBubbleTimer:stop()
	self._bubbleSequeue:clear()

	if self._typeMapRootGO then
		for type, rootGO in pairs(self._typeMapRootGO) do
			goutil.setActive(rootGO, false)
		end
	end

	if self._wordItemList then
		for _, item in ipairs(self._wordItemList) do
			item:setVisible(false)
		end
	end

	self:_resumeLowMood()
end

function M:setAsLastSibling()
	local rootGO = self._resLoader:getGO()

	rootGO.transform:SetAsLastSibling()
end

function M:setWordLimitCount(count)
	self._wordLimitCount = count
end

function M:hasUsefulWord()
	local usefulList = {}

	for i, item in ipairs(self._wordItemList) do
		if not item:isPlaying() then
			table.insert(usefulList, i)
		end
	end

	return #usefulList > kWordCount - self._wordLimitCount, usefulList
end

function M:_pauseLowMood()
	if self._unit.progressBar then
		self._unit.progressBar:pauseShowLowMood()
	end
end

function M:_resumeLowMood()
	if self._unit.progressBar then
		self._unit.progressBar:resumeShowLowMood()
	end
end

function M:show(bubbleData)
	self._bubbleSequeue:enqueue(bubbleData)
	self:_showNext()
end

function M:showName(enable, name)
	self._txtNameContent.text = name

	goutil.setActive(self._goNameRoot, enable)
end

function M:_showNext()
	if not self._hasBuildUI or self._bubbleSequeue:size() <= 0 then
		return
	end

	self:setAsLastSibling()

	local bubbleData = self._bubbleSequeue:dequeue()

	self._currBubbleData = bubbleData

	if self._loop then
		self._bubbleSequeue:enqueue(bubbleData)
	end

	for type, rootGO in pairs(self._typeMapRootGO) do
		goutil.setActive(rootGO, type == bubbleData.type)
	end

	self._talkBubbleTimer:stop()
	self._nextBubbleTimer:stop()
	self._emojiBubbleTimer:stop()

	if bubbleData.type == BubbleType.Talk then
		self:_showTalkBubble(bubbleData)
	elseif bubbleData.type == BubbleType.Emoji then
		self:_showEmojiBubble(bubbleData)
	elseif bubbleData.type == BubbleType.Word then
		self:_showWordBubble(bubbleData)
	end

	self:_pauseLowMood()
end

function M:_showTalkBubble(bubbleData)
	self._txtTalkContent.text = StringUtil.replaceTMPBlackBlock(bubbleData.content)

	RectTransformUtils.ForceRebuildLayoutImmediate(self._txtTalkContent.gameObject.transform)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._txtTalkContent.gameObject.transform.parent)
	goutil.setActive(self._txtTalkContent.gameObject, true)
	self._talkAnima:Stop()
	self._talkAnima:Play(kAniNameTalkOpen)

	local time = bubbleData.continueTime or kContinueTimeTalk

	self._talkBubbleTimer:restart(time, false)
end

function M:_endTalkBubble()
	self._talkAnima:Stop()
	self._talkAnima:Play(kAniNameTalkClose)
	goutil.setActive(self._txtTalkContent.gameObject, false)
	self:_dispatchFinishEvent()
	self:_waitToShowNext()
	self:_resumeLowMood()
end

function M:_showEmojiBubble(bubbleData)
	local iconName = string.format("emoji2_%s", bubbleData.content)

	IconLoader.setSprite(self._imgEmoji, IconType.Emoji2, iconName)
	self._emojiAnima:Stop()
	self._emojiAnima:Play(kAniNameEmoji)
	self._emojiBubbleTimer:restart(kEmojiBubbleTime, false)
end

function M:_endEmojiBubble()
	self:_dispatchFinishEvent()
	self:_waitToShowNext()
	self:_resumeLowMood()
end

function M:_showWordBubble(bubbleData)
	local hasUseful, usefulList = self:hasUsefulWord()

	if hasUseful then
		local idx = usefulList[math.random(1, #usefulList)]
		local item = self._wordItemList[idx]

		item:setVisible(true)
		item:setContent(bubbleData.content)
		item:play(kAniNameWord)
	end
end

function M:_dispatchFinishEvent()
	self._unit:dispatchInnerEvent(UnitActionType.FinishBubble, self._currBubbleData.type)
end

function M:_waitToShowNext()
	local time = self._currBubbleData.endWaitTime or kEndWaitTimeTalk

	self._nextBubbleTimer:restart(time, false)
end

return M
