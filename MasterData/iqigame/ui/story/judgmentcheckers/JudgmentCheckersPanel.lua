-- chunkname: @IQIGame\\UI\\Story\\JudgmentCheckers\\JudgmentCheckersPanel.lua

local JudgmentCheckersPanel = {}
local cluesPanel = require("IQIGame/UI/Story/JudgmentCheckers/JudgmentCluesPanel")
local mapItemClass = require("IQIGame/UI/Story/JudgmentCheckers/JudgmentCheckersPanel_MapItem")

function JudgmentCheckersPanel.New(go, mainView)
	local o = Clone(JudgmentCheckersPanel)

	o:Initialize(go, mainView)

	return o
end

function JudgmentCheckersPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.mapItemList = {}

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function JudgmentCheckersPanel:InitComponent()
	self.cluePanel = cluesPanel.New(self.judgmentCluesPanel, self)

	self.cluePanel:Hide()
end

function JudgmentCheckersPanel:InitDelegate()
	function self.showProblemEvent(indexDic, ShowCheckersProblemTask)
		self:ShowProblem(indexDic, ShowCheckersProblemTask)
	end

	function self.setPlayerPosEvent(posIndex)
		self:SetPlayerPos(posIndex)
	end

	function self.showCluesPanelEvent(index, textId, ShowCheckersCluePanelTask)
		self:ShowCluesPanel(index, textId, ShowCheckersCluePanelTask)
	end

	function self.setClueEvent(index, clueId)
		self:SetClue(index, clueId)
	end

	function self.hideCluePanelEvent()
		self.cluePanel:Hide()
	end
end

function JudgmentCheckersPanel:AddListener()
	EventDispatcher.AddEventListener(EventID.JudgmentCheckersPanel_ShowProblemEvent, self.showProblemEvent)
	EventDispatcher.AddEventListener(EventID.JudgmentCheckersPanel_SetPlayerPosEvent, self.setPlayerPosEvent)
	EventDispatcher.AddEventListener(EventID.JudgmentCheckersPanel_ShowCluesEvent, self.showCluesPanelEvent)
	EventDispatcher.AddEventListener(EventID.JudgmentCheckersPanel_SetClueEvent, self.setClueEvent)
	EventDispatcher.AddEventListener(EventID.JudgmentCheckersPanel_HideCluePanelEvent, self.hideCluePanelEvent)
end

function JudgmentCheckersPanel:RemoveListener()
	EventDispatcher.RemoveEventListener(EventID.JudgmentCheckersPanel_ShowProblemEvent, self.showProblemEvent)
	EventDispatcher.RemoveEventListener(EventID.JudgmentCheckersPanel_SetPlayerPosEvent, self.setPlayerPosEvent)
	EventDispatcher.RemoveEventListener(EventID.JudgmentCheckersPanel_ShowCluesEvent, self.showCluesPanelEvent)
	EventDispatcher.RemoveEventListener(EventID.JudgmentCheckersPanel_SetClueEvent, self.setClueEvent)
	EventDispatcher.RemoveEventListener(EventID.JudgmentCheckersPanel_HideCluePanelEvent, self.hideCluePanelEvent)
end

function JudgmentCheckersPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function JudgmentCheckersPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function JudgmentCheckersPanel:Refresh(resourceId, playerIndex, StartJudgmentCheckersTask)
	self.playerIndex = playerIndex
	self.StartJudgmentCheckersTask = StartJudgmentCheckersTask

	AssetUtil.LoadAsset(self, CfgUtil.GetStoryResourceWithID(resourceId), self.OnMapLoadSuccess)
end

function JudgmentCheckersPanel:OnMapLoadSuccess(assetName, asset, duration, userData)
	self.mapPrefab = GameObject.Instantiate(asset, self.gameObject.transform)
	self.mapItemContent = self.mapPrefab.transform:Find("itemContent")

	if not self.mapItemContent then
		logError("【剧情】审讯跳棋预制体中没有 itemContent 物体")

		return
	end

	local len = LuaUtility.GetChildCount(self.mapItemContent)

	for i = 1, len do
		local trans = LuaUtility.GetChild(self.mapItemContent, i - 1)
		local item = mapItemClass.New(trans.gameObject, self)
		local id = tonumber(trans.gameObject.name)

		item.id = id
		self.mapItemList[id] = item

		if id == self.playerIndex then
			self.currentPlayerItem = self.mapItemList[id]

			self.currentPlayerItem:SwitchPlayer()
		end
	end

	if not self.currentPlayerItem then
		logError("【剧情】当前审讯跳棋预制体中没有设置角色")

		return
	end

	if self.StartJudgmentCheckersTask then
		self.StartJudgmentCheckersTask:Complete()

		self.StartJudgmentCheckersTask = nil
	end
end

function JudgmentCheckersPanel:ShowProblem(indexDic, ShowCheckersProblemTask)
	self.showCheckersProblemTask = ShowCheckersProblemTask

	for index, textId in pairs(indexDic) do
		if self.mapItemList[index] then
			self.mapItemList[index]:ShowProblem(textId)
		end
	end
end

function JudgmentCheckersPanel:OnProblemSelected(index)
	if self.showCheckersProblemTask then
		self.showCheckersProblemTask:SetComplete(index)
	end

	self:HideAllProblem()
end

function JudgmentCheckersPanel:SetPlayerPos(posIndex)
	if self.currentPlayerItem then
		self.currentPlayerItem:SwitchNull()

		self.currentPlayerItem = nil
	end

	local item = self.mapItemList[posIndex]

	if not item then
		logError(string.format("【剧情】审讯跳棋，设置角色位置，没有 id = %s 的棋子", posIndex))

		return
	end

	self.currentPlayerItem = item

	self.currentPlayerItem:SwitchPlayer()
end

function JudgmentCheckersPanel:SetClue(index, clueId)
	local item = self.mapItemList[index]

	if not item then
		logError(string.format("【剧情】审讯跳棋，设置线索，没有 id = %s 的棋子", index))

		return
	end

	item:SwitchClue(clueId)
end

function JudgmentCheckersPanel:ShowCluesPanel(index, textId, ShowCheckersCluePanelTask)
	local item = self.mapItemList[index]

	if not item then
		logError(string.format("【剧情】审讯跳棋，显示线索问题，没有 id = %s 的棋子", index))

		return
	end

	item:ShowProblem(textId)
	self.cluePanel:Show()
	self.cluePanel:Refresh(ShowCheckersCluePanelTask)
end

function JudgmentCheckersPanel:HideAllProblem()
	for _, v in pairs(self.mapItemList) do
		v:HideProblem()
	end
end

function JudgmentCheckersPanel:OnDestroy()
	self:RemoveListener()
end

return JudgmentCheckersPanel
