local TowerDefenseSelectCtrl = class("TowerDefenseSelectCtrl", BaseCtrl)
local barMinX = -365
local barMaxX = 0
local scrollType = {levelIndex = 1, pos = 2}
TowerDefenseSelectCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  txt_story = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Story"
  },
  redDotStory = {},
  btn_Story = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Story"
  },
  txt_guide = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_Guide"
  },
  btn_Guide = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Guide"
  },
  txt_quest = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_QuestTitle"
  },
  redDotQuest = {},
  btn_quest = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Quest"
  },
  txt_mainProcess = {sComponentName = "TMP_Text"},
  imgMainBarFill = {
    sComponentName = "RectTransform"
  },
  txt_LevelTab1 = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_LevelTab1"
  },
  imgSelected1 = {},
  btn_LevelTab1 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_LevelTab1"
  },
  redDotTab1 = {},
  txt_LevelTab2 = {
    sComponentName = "TMP_Text",
    sLanguageId = "TowerDef_LevelTab2"
  },
  imgSelected2 = {},
  btn_LevelTab2 = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_LevelTab2"
  },
  redDotTab2 = {},
  loopSv = {
    sNodeName = "sv",
    sComponentName = "LoopScrollView"
  },
  blur = {},
  guidPanel = {
    sNodeName = "TowerDefenseGuidePanel",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseGuideCtrl"
  },
  storyPanel = {
    sNodeName = "TowerDefenseStory",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseStoryCtrl"
  },
  questPanel = {
    sNodeName = "TowerDefenseQuest",
    sCtrlName = "Game.UI.TowerDefense.TowerDefenseQuestCtrl"
  },
  animator = {
    sNodeName = "----SafeAreaRoot---",
    sComponentName = "Animator"
  }
}
TowerDefenseSelectCtrl._mapEventConfig = {
  TowerDefenseLevelCell_OnSelected = "OnEvent_LevelSelected",
  CloseTowerDefenseGuidePanel = "OnEvent_CloseTowerDefenseGuidePanel",
  CloseTowerDefenseStoryPanel = "OnEvent_CloseTowerDefenseStoryPanel",
  CloseTowerDefenseQuestPanel = "OnEvent_CloseTowerDefenseQuestPanel",
  TowerDefenseQuestUpdate = "InitQuest"
}
TowerDefenseSelectCtrl._mapRedDotConfig = {
  [RedDotDefine.Activity_TowerDefense_AllQuest] = {
    sNodeName = "redDotQuest"
  },
  [RedDotDefine.Activity_TowerDefense_AllStory] = {
    sNodeName = "redDotStory"
  }
}

function TowerDefenseSelectCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
  end
  self.TowerDefenseData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self._mapNode.guidPanel.gameObject:SetActive(false)
  self._mapNode.storyPanel.gameObject:SetActive(false)
  self._mapNode.questPanel.gameObject:SetActive(false)
  self._mapNode.blur.gameObject:SetActive(false)
  self._mapNode.animator:Play("TowerDefenseSelectBg_in")
  self.scrollType = scrollType.pos
  self.nScrollIndex = 0
  self.scrollPos = 1
end

function TowerDefenseSelectCtrl:OnEnable()
  if self._panel.nSelectedTabIndex == 0 then
    self._panel.nSelectedTabIndex = 1
  end
  if self._panel.nlevelId ~= 0 then
    local tempData = self.TowerDefenseData:GetTempData()
    if tempData ~= nil and tempData.nLevelId == self._panel.nlevelId and tempData.bResult then
      for index, value in ipairs(self.tbLevel) do
        if value.nLevelId == self._panel.nlevelId then
          self.nScrollIndex = index
          break
        end
      end
      if self.nScrollIndex == #self.tbLevel and self._panel.nSelectedTabIndex == 1 then
        self._panel.nSelectedTabIndex = 2
        self.nScrollIndex = 0
        self.scrollType = scrollType.pos
        self.scrollPos = 1
      else
        self.scrollType = scrollType.levelIndex
      end
      self.TowerDefenseData:ClearTempData()
    end
  end
  self:Init()
end

function TowerDefenseSelectCtrl:OnDisable()
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self.tbGridCtrl = {}
end

function TowerDefenseSelectCtrl:OnDestroy()
  self.TowerDefenseData:RefreshRedDotbyTab(self._panel.nSelectedTabIndex)
end

function TowerDefenseSelectCtrl:Init()
  self.tblevel = {}
  self.tbGridCtrl = {}
  RedDotManager.RegisterNode(RedDotDefine.Activity_TowerDefense_LevelTab, {1}, self._mapNode.redDotTab1)
  RedDotManager.RegisterNode(RedDotDefine.Activity_TowerDefense_LevelTab, {2}, self._mapNode.redDotTab2)
  self:UpdateLevel()
  self:InitQuest()
  self:SetTabUI()
end

function TowerDefenseSelectCtrl:InitQuest()
  local allCount = self.TowerDefenseData:GetAllQuestCount()
  local receivedCount = self.TowerDefenseData:GetAllReceivedCount()
  NovaAPI.SetTMPText(self._mapNode.txt_mainProcess, receivedCount .. "/" .. allCount)
  self._mapNode.imgMainBarFill.anchoredPosition = Vector2(barMinX + (barMaxX - barMinX) * (receivedCount / allCount), self._mapNode.imgMainBarFill.anchoredPosition.y)
end

function TowerDefenseSelectCtrl:SetTabUI()
  self._mapNode.imgSelected1:SetActive(self._panel.nSelectedTabIndex == 1)
  self._mapNode.imgSelected2:SetActive(self._panel.nSelectedTabIndex == 2)
  local selectedColor = Color(0.9803921568627451, 0.9803921568627451, 0.9803921568627451)
  local normalColor = Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764)
  if self._panel.nSelectedTabIndex == 1 then
    NovaAPI.SetTMPColor(self._mapNode.txt_LevelTab1, selectedColor)
    NovaAPI.SetTMPColor(self._mapNode.txt_LevelTab2, normalColor)
  elseif self._panel.nSelectedTabIndex == 2 then
    NovaAPI.SetTMPColor(self._mapNode.txt_LevelTab1, normalColor)
    NovaAPI.SetTMPColor(self._mapNode.txt_LevelTab2, selectedColor)
  end
end

function TowerDefenseSelectCtrl:UpdateLevel()
  self.tbLevel = self.TowerDefenseData:GetLevelsByTab(self._panel.nSelectedTabIndex)
  
  local function sortFunc(a, b)
    local aConfig = ConfigTable.GetData("TowerDefenseLevel", a.nLevelId)
    local bConfig = ConfigTable.GetData("TowerDefenseLevel", b.nLevelId)
    return aConfig.Id < bConfig.Id
  end
  
  table.sort(self.tbLevel, sortFunc)
  for nInstanceId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[nInstanceId] = nil
  end
  self._mapNode.loopSv:Init(#self.tbLevel, self, self.OnRefreshGrid)
  if self.scrollType == scrollType.levelIndex then
    self._mapNode.loopSv:SetScrollGridPos(self.nScrollIndex, 0)
  elseif self.scrollType == scrollType.pos then
    self._mapNode.loopSv:SetScrollPos(self.scrollPos, 0)
  end
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self:PlayGridAnim()
  end
  
  cs_coroutine.start(wait)
end

function TowerDefenseSelectCtrl:OnRefreshGrid(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.TowerDefense.TowerDefenseLevelCellCtrl")
  end
  self.tbGridCtrl[nInstanceId]:SetData(self.nActId, self.tbLevel[nIndex])
end

function TowerDefenseSelectCtrl:PlayGridAnim()
  local listInUse = {}
  listInUse = self._mapNode.loopSv:GetInUseGridIndex()
  local tbGridInUse = {}
  for i = 0, listInUse.Count - 1 do
    table.insert(tbGridInUse, listInUse[i])
  end
  for k, v in ipairs(tbGridInUse) do
    local goGrid = self._mapNode.loopSv.transform:Find("Viewport/Content/" .. v)
    local animRoot = goGrid:GetComponent("Animator")
    local delayTime = (k - 1) * 0.1
    animRoot:Play("ready")
    if 0 < delayTime then
      self:AddTimer(1, delayTime, function()
        animRoot:Play("go")
      end, true, true, true)
    else
      animRoot:Play("go")
    end
  end
end

function TowerDefenseSelectCtrl:OnBtnClick_Guide()
  if not self.TowerDefenseData:CheckActivityOpen() then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_End_Notice"),
      callbackConfirm = function()
        PanelManager.Home()
      end
    })
    return
  end
  self._mapNode.blur.gameObject:SetActive(true)
  self._mapNode.guidPanel.gameObject:SetActive(true)
  self._mapNode.guidPanel:SetData(self.nActId)
end

function TowerDefenseSelectCtrl:OnBtnClick_LevelTab1()
  if self._panel.nSelectedTabIndex == 1 then
    return
  end
  self.scrollPos = 1
  self._panel.nlevelId = 0
  self.scrollType = scrollType.pos
  self.TowerDefenseData:RefreshRedDotbyTab(self._panel.nSelectedTabIndex)
  self._panel.nSelectedTabIndex = 1
  self:SetTabUI()
  self:UpdateLevel()
end

function TowerDefenseSelectCtrl:OnBtnClick_LevelTab2()
  if self._panel.nSelectedTabIndex == 2 then
    return
  end
  self.scrollPos = 1
  self._panel.nlevelId = 0
  self.scrollType = scrollType.pos
  self.TowerDefenseData:RefreshRedDotbyTab(self._panel.nSelectedTabIndex)
  self._panel.nSelectedTabIndex = 2
  self:SetTabUI()
  self:UpdateLevel()
end

function TowerDefenseSelectCtrl:OnBtnClick_Story()
  self._mapNode.blur.gameObject:SetActive(true)
  self._mapNode.storyPanel.gameObject:SetActive(true)
  self._mapNode.storyPanel:SetData(self.nActId)
end

function TowerDefenseSelectCtrl:OnBtnClick_Quest()
  if not self.TowerDefenseData:CheckActivityOpen() then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_End_Notice"),
      callbackConfirm = function()
        PanelManager.Home()
      end
    })
    return
  end
  self._mapNode.blur.gameObject:SetActive(true)
  self._mapNode.questPanel.gameObject:SetActive(true)
  self._mapNode.questPanel:PlayAnim_In()
  self._mapNode.questPanel:SetData(self.nActId, true)
end

function TowerDefenseSelectCtrl:OnEvent_LevelSelected(nLevelId)
  if not self.TowerDefenseData:CheckActivityOpen() then
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Alert,
      sContent = ConfigTable.GetUIText("Activity_End_Notice"),
      callbackConfirm = function()
        PanelManager.Home()
      end
    })
    return
  end
  if not self.TowerDefenseData:IsLevelUnlock(nLevelId) then
    return
  end
  if not self.TowerDefenseData:IsPreLevelPass(nLevelId) then
    return
  end
  self.scrollPos = self._mapNode.loopSv:GetScrollPos()
  self._panel.nlevelId = nLevelId
  self.TowerDefenseData:EnterLevelSelect(nLevelId)
  EventManager.Hit(EventId.OpenPanel, PanelId.TowerDefenseLevelDetailPanel, self.nActId, nLevelId)
end

function TowerDefenseSelectCtrl:OnEvent_CloseTowerDefenseGuidePanel()
  self._mapNode.guidPanel.gameObject:SetActive(false)
  self._mapNode.blur.gameObject:SetActive(false)
end

function TowerDefenseSelectCtrl:OnEvent_CloseTowerDefenseStoryPanel()
  self._mapNode.storyPanel.gameObject:SetActive(false)
  self._mapNode.blur.gameObject:SetActive(false)
end

function TowerDefenseSelectCtrl:OnEvent_CloseTowerDefenseQuestPanel()
  self._mapNode.questPanel.gameObject:SetActive(false)
  self._mapNode.blur.gameObject:SetActive(false)
end

return TowerDefenseSelectCtrl
