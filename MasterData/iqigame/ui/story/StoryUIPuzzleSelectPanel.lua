-- chunkname: @IQIGame\\UI\\Story\\StoryUIPuzzleSelectPanel.lua

local StoryUIPuzzleSelectPanel = class(nil, BaseChildrenPanel)
local PuzzleSelectPanelClueItemClass = require("IQIGame.UI.Story.PuzzleSelectPanelClueItem")
local clueCount = 6

function StoryUIPuzzleSelectPanel.New(go, mainView)
	local o = Clone(StoryUIPuzzleSelectPanel)

	o:Initialize(go, mainView)

	return o
end

function StoryUIPuzzleSelectPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.canClose = true

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function StoryUIPuzzleSelectPanel:InitComponent()
	self.objectClueViewList = {}

	local childCount = clueCount + 1

	for i = 2, childCount do
		local trans = LuaUtility.GetChild(self.clueContent.transform, i - 1)
		local item = PuzzleSelectPanelClueItemClass.New(LuaUtility.GetChild(trans.transform, 0).gameObject, self)

		table.insert(self.objectClueViewList, item)
	end

	self.FloatEffectComponent = LuaUtility.GameObjectGetOrAddComponent(self.clueContent, typeof(IQIGame.Onigao.Game.FloatEffectComponent))

	local publicParametersData = CfgUtil.GetPublicParametersData()
	local AsideViewFloatOffset = publicParametersData.AsideViewFloatOffset
	local v = Vector3.New(AsideViewFloatOffset.x, AsideViewFloatOffset.y, 0)

	self.FloatEffectComponent:Init(v, publicParametersData.AsideViewFloatFrequency)

	self.FloatEffectComponent.enabled = true
	self.clueContentRect = self.clueContent:GetComponent("RectTransform")
	self.StoryUIRect = self.MainUI:GetComponent("RectTransform")
end

function StoryUIPuzzleSelectPanel:InitDelegate()
	function self.buttonMaskDelegate()
		self:OnButtonMaskClick()
	end
end

function StoryUIPuzzleSelectPanel:AddListener()
	self.buttonMask:GetComponent("Button").onClick:AddListener(self.buttonMaskDelegate)
end

function StoryUIPuzzleSelectPanel:RemoveListener()
	self.buttonMask:GetComponent("Button").onClick:RemoveListener(self.buttonMaskDelegate)
end

function StoryUIPuzzleSelectPanel:OnOpen()
	LuaUtility.PlayAnimation(self.clueContent, "selectContent_In", nil, function()
		self.isPlayingAnimation = false
	end)

	self.isPlayingAnimation = true
end

function StoryUIPuzzleSelectPanel:OnDestroy()
	self:RemoveListener()

	for i = 1, #self.objectClueViewList do
		self.objectClueViewList[i]:OnDestroy()

		self.objectClueViewList[i] = nil
	end

	self.objectClueViewList = {}

	LuaUtility.UnLoadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
end

function StoryUIPuzzleSelectPanel:OnButtonMaskClick()
	if not self.canClose then
		return
	end

	if self.isPlayingAnimation then
		return
	end

	self:ActionClose(false, 0)
	self:Close()
end

function StoryUIPuzzleSelectPanel:ActionClose(isTaskComplete, optionNum)
	if isTaskComplete then
		self.currentShowCluesTask:SetReturnNum(optionNum)
		self.currentShowCluesTask:TaskComplete()
	else
		self.currentShowCluesTask:TaskFailure()
	end
end

function StoryUIPuzzleSelectPanel:Refresh(npcID, selectCfgID, ShowCluesTask)
	self.selectCfgID = selectCfgID

	local storyNPC = BehaviorTreeUtility.GetNPCByNPCID(npcID)

	if LuaUtility.StrIsNullOrEmpty(storyNPC.stringShowClueFollower) then
		logError("【剧情】试图打开线索触发界面,但是NPC没有配置线索触发挂点,npcID = %s,npcName = %s", npcID, storyNPC:GetName())

		return
	end

	local objectTrans = storyNPC.transform:Find(storyNPC.stringShowClueFollower)

	if not objectTrans then
		logError(string.format("【剧情】npc %s ID = %s 没有找到线索触发挂点名 = %s", storyNPC:GetName(), npcID, storyNPC.stringShowClueFollower))

		return
	end

	self.currentShowCluesTask = ShowCluesTask

	self:SetFollowNpc(objectTrans.transform.position)
	self:RefreshClues(selectCfgID)
	LuaUtility.LimitUIPosToScreen(self.StoryUIRect, self.clueContentRect, 30, 20)
end

function StoryUIPuzzleSelectPanel:RefreshClues(selectCfgID)
	local selectCfg = CfgUtil.GetCfgStoryOptionDataWithID(selectCfgID)

	if selectCfg.OptionType ~= Constant.StoryOptionType.ClueTrigger then
		logError(string.format("【剧情】试图开启线索选项，但是配置的类型错误，配置类型为 %s。正确类型应该为 %s", selectCfg.OptionType, Constant.StoryOptionType.ClueTrigger))

		return
	end

	local needShowList = {}

	for i = 1, #selectCfg.Options do
		if PuzzleModule.GetClueIsHad(selectCfg.Options[i]) and StoryModule.CheckOptionIsShow(selectCfg.Id, selectCfg.Options[i]) then
			table.insert(needShowList, selectCfg.Options[i])
		end
	end

	local index = 1

	for i = 1, #needShowList do
		if i <= #self.objectClueViewList then
			self.objectClueViewList[i]:Refresh(needShowList[i], selectCfgID)
			self.objectClueViewList[i]:Show()
		end

		index = i
	end

	index = index + 1

	for i = index, #self.objectClueViewList do
		self.objectClueViewList[i]:Hide()
	end

	LuaUtility.SetText(self.questionText, selectCfg.Des)
	self:SetCanClose(selectCfg.CanQuit)
end

function StoryUIPuzzleSelectPanel:SetFollowNpc(npcPos)
	local screenPos = LuaUtility.WorldToScreenPos(StoryModule.mainCamera, npcPos)
	local worldPos = LuaUtility.ScreenToWorldPos(GameEntry.UICamera, screenPos, 100)

	LuaUtility.SetPositionWithGameObject(self.clueContent, worldPos.x, worldPos.y, worldPos.z)
end

function StoryUIPuzzleSelectPanel:OnClueClick(num)
	self:ActionClose(true, num)
	StoryModule.SetTriggerOption(self.selectCfgID, num)
end

function StoryUIPuzzleSelectPanel:SetCanClose(canClose)
	self.canClose = canClose
end

function StoryUIPuzzleSelectPanel:PlayHideSelectAnimation(except)
	for i = 1, #self.objectClueViewList do
		if self.objectClueViewList[i].Data ~= except then
			self.objectClueViewList[i]:PlayHideAnimation()
		end
	end

	LuaUtility.PlayAnimation(self.clueContent, "selectContent_Out")

	self.isPlayingAnimation = true
end

return StoryUIPuzzleSelectPanel
