local QuestWorldClassCtrl = class("QuestWorldClassCtrl", BaseCtrl)
local LayoutRebuilder = CS.UnityEngine.UI.LayoutRebuilder
QuestWorldClassCtrl._mapNodeConfig = {
  rtLevel = {},
  bgLevelUp = {},
  bgAdvance = {},
  txtTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_Advance_Tip"
  },
  txtLevel = {sComponentName = "TMP_Text", nCount = 2},
  txtLevelCn = {
    sComponentName = "TMP_Text",
    nCount = 2,
    sLanguageId = "WorldClass_Level_Title"
  },
  imgExpBar = {sComponentName = "Image"},
  txtExp = {sComponentName = "TMP_Text"},
  goAssistant = {
    sCtrlName = "Game.UI.Quest.Assistant.AssistantCtrl"
  },
  txtAssistant = {sComponentName = "TMP_Text"},
  imgHeadBg = {sComponentName = "Image"},
  rtWorldClassList = {},
  animWorldClassList = {
    sNodeName = "rtWorldClassList",
    sComponentName = "Animator"
  },
  worldClassLsv = {
    sComponentName = "LoopScrollView"
  },
  rtWorldClassLsv = {
    sNodeName = "worldClassLsv",
    sComponentName = "RectTransform"
  },
  imgAllReceive = {},
  txtAllReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "WorldClass_AllReceive_Tip"
  },
  rtLevelInfo = {},
  btnLevelItem = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_LevelItem"
  },
  goLevelItem = {
    sCtrlName = "Game.UI.Quest.WorldClass.WorldClassItemCtrl"
  },
  rtLevelLsv = {
    sComponentName = "RectTransform"
  },
  levelLsv = {
    sComponentName = "LoopScrollView"
  },
  rtQuestLsv = {},
  questLsv = {
    sComponentName = "LoopScrollView"
  },
  txtContentSize = {sComponentName = "TMP_Text"},
  rectContentSize = {
    sNodeName = "txtContentSize",
    sComponentName = "RectTransform"
  },
  btnFastReceive = {sComponentName = "UIButton"},
  txtBtnFastReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  },
  btnFastReceiveGray = {sComponentName = "UIButton"},
  txtBtnFastReceiveGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  }
}
QuestWorldClassCtrl._mapEventConfig = {
  ReceiveWorldClassLevelReward = "OnEvent_ReceiveWorldClassLevelReward",
  [EventId.UpdateWorldClass] = "OnEvent_UpdateWorldClass",
  DemonAdvanceSuccess = "OnEvent_DemonAdvanceSuccess",
  Guide_DisableScrollView = "OnEvent_DisableScrollView"
}
QuestWorldClassCtrl._mapRedDotConfig = {}
local levelInfoGridHeight = {
  FuncOpen = 59.13,
  FuncChange = 20,
  LevelReward = 165,
  InfoTopBottom = 14,
  InfoSpacing = 6
}
local worldClassLsvPosY_1 = 118
local worldClassLsvPosY_2 = 65

function QuestWorldClassCtrl:Refresh()
  self.nCurWorldClass = PlayerData.Base:GetWorldClass()
  self:RefreshDemonList()
  self._mapNode.animWorldClassList:Play("rtGuideQuest_in", 0, 0)
  local curType = self:RefreshWorldClass()
  local mapData = self.tbWorldClass[#self.tbWorldClass]
  local bMax = mapData.nMaxLevel == self.nCurWorldClass
  self:RefreshLevelInfo(self.nCurIndex)
  return curType
end

function QuestWorldClassCtrl:RefreshWorldClass()
  local nCurExp = PlayerData.Base:GetWorldExp()
  local mapCfg = ConfigTable.GetData("WorldClass", self.nCurWorldClass + 1, true)
  local nFullExp = 0
  if mapCfg then
    nFullExp = mapCfg.Exp
  end
  NovaAPI.SetTMPText(self._mapNode.txtLevel[1], self.nCurWorldClass)
  NovaAPI.SetTMPText(self._mapNode.txtLevel[2], self.nCurWorldClass)
  NovaAPI.SetTMPText(self._mapNode.txtExp, string.format("%d/%d", nCurExp, nFullExp))
  NovaAPI.SetImageFillAmount(self._mapNode.imgExpBar, nCurExp / nFullExp)
  local curData = self.tbWorldClass[self.nCurIndex]
  if curData ~= nil then
    self._mapNode.bgLevelUp.gameObject:SetActive(curData.nType == AllEnum.WorldClassType.LevelUp)
    self._mapNode.bgAdvance.gameObject:SetActive(curData.nType == AllEnum.WorldClassType.Advance)
    EventManager.Hit("RefreshWorldClassBg", curData.nType == AllEnum.WorldClassType.LevelUp)
    return curData.nType
  end
end

function QuestWorldClassCtrl:RefreshDemonList()
  self.bFold = true
  self._mapNode.rtLevelInfo.gameObject:SetActive(false)
  self._mapNode.rtWorldClassList.gameObject:SetActive(true)
  self.nCurIndex = 0
  self.nRewardIndex = 0
  self.nCurIndex = PlayerData.Base:GetCurWorldClassStageIndex()
  for nIdx, v in ipairs(self.tbWorldClass) do
    if v.nType == AllEnum.WorldClassType.LevelUp and RedDotManager.GetValid(RedDotDefine.WorldClass_LevelUp, v.nId) and self.nRewardIndex == 0 then
      self.nRewardIndex = nIdx
    end
  end
  for nInstanceId, v in pairs(self.tbGridWorldClass) do
    self:UnbindCtrlByNode(v)
    self.tbGridWorldClass[nInstanceId] = nil
  end
  self._mapNode.worldClassLsv:Init(#self.tbWorldClass, self, self.OnWorldClassGridRefresh, self.OnWorldClassGridClick, true)
  local mapData = self.tbWorldClass[#self.tbWorldClass]
  local bMax = mapData.nMaxLevel == self.nCurWorldClass
  self._mapNode.imgAllReceive.gameObject:SetActive(bMax)
  self._mapNode.txtExp.gameObject:SetActive(not bMax)
  local posX = self._mapNode.rtWorldClassLsv.anchoredPosition.x
  local posY = bMax and worldClassLsvPosY_1 or worldClassLsvPosY_2
  self._mapNode.rtWorldClassLsv.anchoredPosition = Vector2(posX, posY)
  self:RefreshFastReceiveBtn()
end

function QuestWorldClassCtrl:RefreshFastReceiveBtn()
  self.tbWorldClassFastReceive = {}
  for _, mapData in ipairs(self.tbWorldClass or {}) do
    if mapData.nType == AllEnum.WorldClassType.LevelUp then
      local nMin = mapData.nMinLevel or 1
      local nMax = math.min(mapData.nMaxLevel or self.nCurWorldClass, self.nCurWorldClass)
      for nLv = nMin, nMax do
        if PlayerData.Base:GetWorldClassState(nLv) then
          table.insert(self.tbWorldClassFastReceive, nLv)
        end
      end
    end
  end
  local bCanReceive = #self.tbWorldClassFastReceive > 0
  if self._mapNode.btnFastReceive ~= nil then
    self._mapNode.btnFastReceive.gameObject:SetActive(bCanReceive)
  end
  if self._mapNode.btnFastReceiveGray ~= nil then
    self._mapNode.btnFastReceiveGray.gameObject:SetActive(not bCanReceive)
  end
end

function QuestWorldClassCtrl:OnWorldClassGridRefresh(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if nil == self.tbGridWorldClass[nInstanceId] then
    self.tbGridWorldClass[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Quest.WorldClass.WorldClassItemCtrl")
  end
  local data = self.tbWorldClass[nIndex]
  if data ~= nil then
    self.tbGridWorldClass[nInstanceId]:SetItem(data)
  end
end

function QuestWorldClassCtrl:OnWorldClassGridClick(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  self.nCurSelectIndex = nIndex
  self:RefreshLevelInfo(nIndex)
end

function QuestWorldClassCtrl:RefreshLevelInfo(nIndex)
  self.bFold = false
  self._mapNode.rtLevelInfo.gameObject:SetActive(true)
  self._mapNode.rtWorldClassList.gameObject:SetActive(false)
  local data = self.tbWorldClass[nIndex]
  if data ~= nil then
    local goBtnFastReceive = self._mapNode.btnFastReceive
    local goBtnFastReceiveGray = self._mapNode.btnFastReceiveGray
    local rtLevelLsv = self._mapNode.rtLevelLsv
    self._mapNode.goLevelItem:SetItem(data, goBtnFastReceive, goBtnFastReceiveGray, rtLevelLsv)
    if data.nType == AllEnum.WorldClassType.LevelUp then
      self._mapNode.rtLevelLsv.gameObject:SetActive(true)
      self._mapNode.rtQuestLsv.gameObject:SetActive(false)
      self:RefreshLevelUpInfo(data)
    elseif data.nType == AllEnum.WorldClassType.Advance then
      self._mapNode.rtLevelLsv.gameObject:SetActive(false)
      self._mapNode.rtQuestLsv.gameObject:SetActive(true)
      self:RefreshAdvanceInfo(data.nId)
    end
  end
end

function QuestWorldClassCtrl:CalRecordInfoGridSize(sContent)
  if sContent == nil or sContent == "" then
    return 0
  end
  self._mapNode.txtContentSize.gameObject:SetActive(true)
  NovaAPI.SetTMPText(self._mapNode.txtContentSize, sContent)
  LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.rectContentSize)
  return self._mapNode.rectContentSize.rect.height
end

function QuestWorldClassCtrl:RefreshLevelUpInfo(data)
  local nMinLevel = data.nMinLevel
  local nMaxLevel = data.nMaxLevel
  self.tbLevelInfo = {}
  self.tbLevelGridHeight = {}
  local nIndex = 0
  for i = nMinLevel, nMaxLevel do
    if i == self.nCurWorldClass then
      nIndex = i - nMinLevel + 1
    end
    table.insert(self.tbLevelInfo, i)
    local nHeight = levelInfoGridHeight.LevelReward
    local worldClassCfg = ConfigTable.GetData("WorldClass", i)
    if worldClassCfg ~= nil then
      local nCount = 0
      if 0 < #worldClassCfg.OpenFunc then
        for _, v in ipairs(worldClassCfg.OpenFunc) do
          local openFuncCfg = ConfigTable.GetData("OpenFunc", v)
          if openFuncCfg ~= nil then
            nCount = nCount + 1
            nHeight = nHeight + levelInfoGridHeight.FuncOpen + self:CalRecordInfoGridSize(openFuncCfg.Desc)
          end
        end
      end
      for i = 1, 3 do
        if worldClassCfg["FuncChangeText" .. i] ~= "" then
          nCount = nCount + 1
          nHeight = nHeight + levelInfoGridHeight.FuncChange + self:CalRecordInfoGridSize(worldClassCfg["FuncChangeText" .. i])
        end
      end
      if 0 < nCount then
        nHeight = nHeight + (nCount - 1) * levelInfoGridHeight.InfoSpacing + levelInfoGridHeight.InfoTopBottom
      end
    end
    table.insert(self.tbLevelGridHeight, nHeight)
  end
  for nInstanceId, v in pairs(self.tbGridLevel) do
    self:UnbindCtrlByNode(v)
    self.tbGridLevel[nInstanceId] = nil
  end
  self._mapNode.levelLsv:InitEx(self.tbLevelGridHeight, self, self.OnLevelGridRefresh)
  if 1 < nIndex then
    self:AddTimer(1, 0.15, function()
      if PlayerData.Guide:CheckInGuideGroup(9) then
        nIndex = 2
      end
      self._mapNode.levelLsv:SetScrollGridPosEx(self.tbLevelGridHeight, nIndex, 0.2)
    end, true, true, true)
  end
end

function QuestWorldClassCtrl:OnLevelGridRefresh(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if nil == self.tbGridLevel[nInstanceId] then
    self.tbGridLevel[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Quest.WorldClass.WorldClassLevelItemCtrl")
  end
  local nLevel = self.tbLevelInfo[nIndex]
  if nLevel ~= nil then
    local data = self.tbWorldClass[self.nCurSelectIndex]
    local bUnOpen = false
    if data ~= nil then
      bUnOpen = self.nCurWorldClass < data.nMinLevel
    end
    self.tbGridLevel[nInstanceId]:SetItem(nLevel, bUnOpen)
  end
end

function QuestWorldClassCtrl:RefreshAdvanceInfo(nId)
  local mapCfg = ConfigTable.GetData("DemonAdvance", nId)
  if mapCfg ~= nil then
    local nQuestGroupId = mapCfg.AdvanceQuestGroup
    self.tbQuestList = PlayerData.Quest:GetDemonQuestData(nQuestGroupId, nId)
    for nInstanceId, v in pairs(self.tbGridQuest) do
      self:UnbindCtrlByNode(v)
      self.tbGridQuest[nInstanceId] = nil
    end
    self._mapNode.questLsv:Init(#self.tbQuestList, self, self.OnQuestGridRefresh)
  end
end

function QuestWorldClassCtrl:OnQuestGridRefresh(goGrid, nGridIndex)
  local nIndex = nGridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if nil == self.tbGridQuest[nInstanceId] then
    self.tbGridQuest[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.Quest.WorldClass.WorldClassQuestItemCtrl")
  end
  local data = self.tbQuestList[nIndex]
  if data ~= nil then
    local itemData = self.tbWorldClass[self.nCurSelectIndex]
    local bUnOpen = false
    if itemData ~= nil then
      bUnOpen = self.nCurWorldClass < itemData.nMinLevel
    end
    self.tbGridQuest[nInstanceId]:SetItem(data, bUnOpen)
  end
end

function QuestWorldClassCtrl:FoldList()
  self.bFold = true
  self._mapNode.rtLevelInfo.gameObject:SetActive(false)
  self._mapNode.rtWorldClassList.gameObject:SetActive(true)
end

function QuestWorldClassCtrl:Awake()
  self.bFold = true
  self.tbGridWorldClass = {}
  self.tbGridQuest = {}
  self.tbGridLevel = {}
  self.tbLevelGridHeight = {}
  self.nCurIndex = 0
  self.nCurSelectIndex = 0
  self.tbWorldClass = CacheTable.Get("_DemonAdvance")
end

function QuestWorldClassCtrl:FadeIn()
end

function QuestWorldClassCtrl:FadeOut()
end

function QuestWorldClassCtrl:OnEnable()
end

function QuestWorldClassCtrl:OnDisable()
  for _, v in pairs(self.tbGridWorldClass) do
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbGridWorldClass = {}
  for _, v in pairs(self.tbGridLevel) do
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbGridLevel = {}
  for _, v in pairs(self.tbGridQuest) do
    local obj = v.gameObject
    self:UnbindCtrlByNode(v)
    destroy(obj)
  end
  self.tbGridQuest = {}
  self._mapNode.btnFastReceive.onClick:RemoveAllListeners()
  self._mapNode.btnFastReceiveGray.onClick:RemoveAllListeners()
end

function QuestWorldClassCtrl:OnDestroy()
end

function QuestWorldClassCtrl:OnRelease()
end

function QuestWorldClassCtrl:OnBtnClick_LevelItem()
end

function QuestWorldClassCtrl:OnEvent_ReceiveWorldClassLevelReward()
  if not self.bFold then
    self._mapNode.levelLsv:InitEx(self.tbLevelGridHeight, self, self.OnLevelGridRefresh, nil, true)
  end
end

function QuestWorldClassCtrl:OnEvent_UpdateWorldClass()
  self.nCurWorldClass = PlayerData.Base:GetWorldClass()
  self:RefreshDemonList()
  self:RefreshWorldClass()
  if not self.bFold then
    self:RefreshLevelInfo(self.nCurIndex)
  end
end

function QuestWorldClassCtrl:OnEvent_DemonAdvanceSuccess()
  self.nCurWorldClass = PlayerData.Base:GetWorldClass()
  self.nCurIndex = PlayerData.Base:GetCurWorldClassStageIndex()
  if self.bFold then
    self:RefreshDemonList()
  else
    self:RefreshLevelInfo(self.nCurIndex)
  end
  self:RefreshWorldClass()
  local data = self.tbWorldClass[self.nCurIndex]
  if data ~= nil then
    self._mapNode.goLevelItem:SetItem(data)
  end
end

function QuestWorldClassCtrl:OnEvent_DisableScrollView(bDisable)
  NovaAPI.SetScrollRectVertical(self._mapNode.levelLsv, not bDisable)
end

function QuestWorldClassCtrl:OnBtnClick_FastReceive()
  if self.tbWorldClassFastReceive == nil or #self.tbWorldClassFastReceive == 0 then
    return
  end
  PlayerData.Base:SendPlayerWorldClassRewardReceiveReq(nil, nil, function()
    self:RefreshFastReceiveBtn()
  end, 1)
end

function QuestWorldClassCtrl:OnBtnClick_FastReceiveGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("DoubleDrop_Reward_Receive_Tip"))
end

return QuestWorldClassCtrl
