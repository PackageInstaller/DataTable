local QuestNewbieFormationCtrl = class("QuestNewbieFormationCtrl", BaseCtrl)
local LocalData = require("GameCore.Data.LocalData")
local Event = require("GameCore.Event.Event")

local function appendOrStack(tbDst, mapItem, sIdKey, sQtyKey, sExtraKey)
  if mapItem == nil then
    return
  end
  for _, v in ipairs(tbDst) do
    if v[sIdKey] == mapItem[sIdKey] and v[sExtraKey] == mapItem[sExtraKey] then
      v[sQtyKey] = (v[sQtyKey] or 0) + (mapItem[sQtyKey] or 0)
      return
    end
  end
  table.insert(tbDst, mapItem)
end

QuestNewbieFormationCtrl._mapNodeConfig = {
  goTeamSelect = {},
  ctrlTeam = {
    sNodeName = "btnTeam",
    nCount = 2,
    sCtrlName = "Game.UI.QuestNewbie.TeamFormation.QuestNewbieTeamCtrl"
  },
  btnTeam = {
    nCount = 2,
    sComponentName = "UIButton",
    callback = "OnBtnClick_TeamFormation"
  },
  goFixTeams = {},
  LSVTeams = {
    sComponentName = "LoopScrollView"
  },
  goQuestList = {},
  imgEFF = {sComponentName = "Image"},
  txtTeamTitle = {sComponentName = "TMP_Text"},
  txtTeamFormationQuestDesc = {
    sComponentName = "TMP_Text",
    sLanguageId = "TeamFormation_Quest_Desc"
  },
  animMaskRoot = {sNodeName = "MaskRoot", sComponentName = "Animator"},
  btnCharList = {nCount = 3, sComponentName = "UIButton"},
  imgCharHead = {nCount = 3, sComponentName = "Image"},
  txtCharName = {nCount = 3, sComponentName = "TMP_Text"},
  goCharStar = {
    nCount = 3,
    sCtrlName = "Game.UI.TemplateEx.TemplateStarCtrl"
  },
  txtCharDesc = {nCount = 3, sComponentName = "TMP_Text"},
  imgClassBg = {nCount = 3, sComponentName = "Image"},
  txtCharClass = {nCount = 3, sComponentName = "TMP_Text"},
  imgAttackTypeBg = {nCount = 3, sComponentName = "Image"},
  imgAttackType = {nCount = 3, sComponentName = "Image"},
  txtChapter = {sComponentName = "TMP_Text"},
  btnRewardItem = {
    nCount = 5,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardItem"
  },
  rewardItem = {
    nCount = 5,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  imgEmpty = {nCount = 5},
  btnReceiveChapter = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ReceiveChapter"
  },
  txtBtnReceiveChapter = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  txtActComplete = {
    sComponentName = "TMP_Text",
    sLanguageId = "Daily_Quest_All_Received"
  },
  btnReceiveChapterGray = {sComponentName = "UIButton"},
  txtBtnReceiveChapterGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Receive"
  },
  BtnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  BtnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  formationQuestLSV = {
    sComponentName = "LoopScrollView"
  },
  btnFastReceive = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastReceive"
  },
  txtBtnFastReceive = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  },
  btnFastReceiveGray = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastReceiveGray"
  },
  txtBtnFastReceiveGray = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Fast_Receive_Btn_Text"
  },
  btnBackToTeamSelect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_BackToTeamSelect"
  },
  txtBtnBackToTeamSelect = {
    sComponentName = "TMP_Text",
    sLanguageId = "Quest_Back_To_Team_Select"
  }
}
QuestNewbieFormationCtrl._mapEventConfig = {
  UpdateTeamFormationGroup = "OnEvent_UpdateTeamFormationGroup",
  Guide_GetNewQuestTaskIndex = "OnEvent_Guide_GetNewQuestTaskIndex"
}
QuestNewbieFormationCtrl._mapRedDotConfig = {}
local statusOrder = {
  [0] = 1,
  [1] = 2,
  [2] = 0
}

function QuestNewbieFormationCtrl:Refresh(bClick)
  self:InitData()
  local nLastestAttributeId = PlayerData.Quest:GetOngoingAttributeId()
  local nTeamSelected = tonumber(LocalData.GetPlayerLocalData("TeamFormationQuestSelected"))
  if not bClick and nTeamSelected ~= nil then
    if nLastestAttributeId ~= 0 then
      nTeamSelected = nLastestAttributeId
      LocalData.SetPlayerLocalData("TeamFormationQuestSelected", nLastestAttributeId)
    else
      nTeamSelected = nil
    end
  end
  if nTeamSelected ~= nil and PlayerData.Quest:CheckTeamFormationAttributeUnlocked(nTeamSelected) == true then
    self.nCurGroup = PlayerData.Quest:GetCurTeamFormationQuestGroup(nTeamSelected)
    self._mapNode.goQuestList:SetActive(true)
    self._mapNode.goTeamSelect:SetActive(false)
    self:RefreshQuestList(self.mapAllTeamFormationQuest[self.nCurGroup], self.nCurGroup)
    self:RefreshCharInfo(self.tbAttr[nTeamSelected])
    self._mapNode.animMaskRoot:Play("MaskRoot_in", 0, 0)
  else
    self:RefreshTeamSelect()
  end
end

function QuestNewbieFormationCtrl:RefreshTeamSelect()
  self._mapNode.goQuestList:SetActive(false)
  local nAttrCount = #self.tbAttr
  if nAttrCount == 0 then
    self._mapNode.goTeamSelect:SetActive(false)
    return
  end
  self._mapNode.goTeamSelect:SetActive(true)
  if nAttrCount <= 2 then
    self._mapNode.goFixTeams:SetActive(true)
    self._mapNode.LSVTeams.gameObject:SetActive(false)
    for i = 1, #self._mapNode.ctrlTeam do
      self._mapNode.ctrlTeam[i].gameObject:SetActive(false)
      if i <= nAttrCount then
        local mapData = ConfigTable.GetData("AssistAttribute", i)
        self._mapNode.ctrlTeam[i].gameObject:SetActive(mapData ~= nil)
        if mapData ~= nil then
          local mapPrevData
          if 1 < i then
            mapPrevData = ConfigTable.GetData("AssistAttribute", i - 1)
          end
          self._mapNode.ctrlTeam[i]:Init(mapData, mapPrevData)
        end
      end
    end
  else
    self._mapNode.goFixTeams:SetActive(false)
    self._mapNode.LSVTeams.gameObject:SetActive(true)
    if self.tbAttrGridCtrl == nil then
      self.tbAttrGridCtrl = {}
    else
      for insId, objCtrl in pairs(self.tbAttrGridCtrl) do
        self:UnbindCtrlByNode(objCtrl)
        self.tbAttrGridCtrl[insId] = nil
      end
    end
    self._mapNode.LSVTeams:Init(nAttrCount, self, self.OnGridRefresh, self.OnGridBtnClick)
  end
end

function QuestNewbieFormationCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local mapData = self.tbAttr[nIndex]
  local prevMapData
  if 1 < nIndex then
    prevMapData = self.tbAttr[nIndex - 1]
  end
  local nInstanceId = goGrid:GetInstanceID()
  if self.tbAttrGridCtrl[nInstanceId] ~= nil then
    self:UnbindCtrlByNode(self.tbAttrGridCtrl[nInstanceId])
    self.tbAttrGridCtrl[nInstanceId] = nil
  end
  self.tbAttrGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.QuestNewbie.TeamFormation.QuestNewbieTeamCtrl")
  self.tbAttrGridCtrl[nInstanceId]:Init(mapData, prevMapData)
end

function QuestNewbieFormationCtrl:OnGridBtnClick(goGrid, gridIndex)
  if self.tbAttr == nil then
    return
  end
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if PlayerData.Quest:CheckTeamFormationAttributeUnlocked(nIndex) == false and 1 < nIndex then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("FormationQuest_UnLock"), ConfigTable.GetUIText("T_Element_Attr_" .. self.tbAttr[nIndex - 1].EET)))
    return
  end
  LocalData.SetPlayerLocalData("TeamFormationQuestSelected", tostring(nIndex))
  PlayerData.Quest:UpdateTeamFormationRedDot()
  self.nCurGroup = PlayerData.Quest:GetCurTeamFormationQuestGroup(nIndex)
  self:Refresh(true)
end

function QuestNewbieFormationCtrl:OnBtnClick_TeamFormation(btn, nTeamIndex)
  if nTeamIndex == nil then
    return
  end
  if PlayerData.Quest:CheckTeamFormationAttributeUnlocked(nTeamIndex) == false and 1 < nTeamIndex then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("FormationQuest_UnLock"), ConfigTable.GetUIText("T_Element_Attr_" .. self.tbAttr[nTeamIndex - 1].EET)))
    return
  end
  LocalData.SetPlayerLocalData("TeamFormationQuestSelected", tostring(nTeamIndex))
  PlayerData.Quest:UpdateTeamFormationRedDot()
  self.nCurGroup = PlayerData.Quest:GetCurTeamFormationQuestGroup(nTeamIndex)
  self:Refresh(true)
end

function QuestNewbieFormationCtrl:RefreshCharInfo(mapData)
  if mapData == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.txtTeamTitle, mapData.TeamTitle)
  self:SetAtlasSprite(self._mapNode.imgEFF, "12_rare", AllEnum.ElementIconType.Icon .. mapData.EET)
  for i = 1, 3 do
    local nChar = mapData["Char" .. i]
    if nChar ~= nil and 0 < nChar then
      do
        local mapCharacter = ConfigTable.GetData_Character(nChar)
        local sIconPath = "Icon/Head/head_" .. nChar .. "01"
        self:SetPngSprite(self._mapNode.imgCharHead[i], sIconPath, AllEnum.CharHeadIconSurfix.S)
        NovaAPI.SetTMPText(self._mapNode.txtCharName[i], mapCharacter.Name)
        self._mapNode.goCharStar[i]:SetStar(0, 6 - mapCharacter.Grade)
        NovaAPI.SetTMPText(self._mapNode.txtCharDesc[i], mapData["CharDesc" .. i])
        NovaAPI.SetTMPText(self._mapNode.txtCharClass[i], ConfigTable.GetUIText("Char_JobClass_" .. mapCharacter.Class))
        if mapCharacter.CharacterAttackType == GameEnum.characterAttackType.MELEE then
          self:SetAtlasSprite(self._mapNode.imgAttackType[i], "10_ico", "zs_list_near")
        elseif mapCharacter.CharacterAttackType == GameEnum.characterAttackType.RANGED then
          self:SetAtlasSprite(self._mapNode.imgAttackType[i], "10_ico", "zs_list_far")
        end
        if mapCharacter.Class == GameEnum.characterJobClass.Vanguard then
          self:SetAtlasSprite(self._mapNode.imgClassBg[i], "08_db", "db_list_herald")
        elseif mapCharacter.Class == GameEnum.characterJobClass.Balance then
          self:SetAtlasSprite(self._mapNode.imgClassBg[i], "08_db", "db_list_equal")
        elseif mapCharacter.Class == GameEnum.characterJobClass.Support then
          self:SetAtlasSprite(self._mapNode.imgClassBg[i], "08_db", "db_list_assist")
        end
        local btnChar = self._mapNode.btnCharList[i]
        btnChar.onClick:RemoveAllListeners()
        btnChar.onClick:AddListener(function()
          local mapCharData = PlayerData.Char:GetCharDataByTid(nChar)
          if mapCharData == nil then
            EventManager.Hit(EventId.OpenPanel, PanelId.CharBgTrialPanel, PanelId.CharInfoTrial, nChar)
          else
            EventManager.Hit(EventId.OpenPanel, PanelId.CharBgPanel, PanelId.CharInfo, nChar, {nChar})
          end
        end)
      end
    end
  end
end

function QuestNewbieFormationCtrl:RefreshQuestList(mapGuideQuest, nCurGroup)
  local tbQuestStatus = {}
  for _, mapQuestData in pairs(mapGuideQuest) do
    local mapStatus = self.mapAllTeamFormationQuestStatus[mapQuestData.Id]
    if mapStatus ~= nil then
      if mapStatus.nStatus == 1 then
        mapStatus.nCurProgress = mapStatus.nGoal
      end
      table.insert(tbQuestStatus, mapStatus)
    end
  end
  self.mapCurQuests = tbQuestStatus
  table.sort(self.mapCurQuests, function(a, b)
    if a.nStatus == b.nStatus then
      return a.nTid < b.nTid
    end
    return statusOrder[a.nStatus] > statusOrder[b.nStatus]
  end)
  self.nCurGroup = nCurGroup
  if self.nCurGroup == 0 then
    self.nCurGroup = self.tbAllGroup[#self.tbAllGroup].Id
  end
  if self.mapCurQuests == nil or #self.mapCurQuests == 0 then
    self.mapCurQuests = {}
    for _, mapQuestCfgData in ipairs(self.mapAllTeamFormationQuest[self.nCurGroup]) do
      table.insert(self.mapCurQuests, {
        nTid = mapQuestCfgData.Id,
        nGoal = 1,
        nCurProgress = 1,
        nStatus = 2,
        nExpire = 0
      })
    end
  end
  self.nCurPage = 0
  self.mapCurPageQuest = self.mapCurQuests
  self:RefreshShow(self.nCurGroup)
end

function QuestNewbieFormationCtrl:RefreshShow(nCurGroup)
  self.curShowGroup = nCurGroup
  self.nCurShowGroupIdxInAttr = PlayerData.Quest:GetTeamFormationGroupIndexInAttribute(nCurGroup)
  self.nAttributeIdx = PlayerData.Quest:GetAttributeIdByGroupId(nCurGroup)
  self.nCurAttrQuestGroupStartIdx = PlayerData.Quest:GetTeamFormationGroupStartIndex(self.nAttributeIdx)
  self.nCurAttrQuestGroupEndIdx = PlayerData.Quest:GetTeamFormationGroupEndIndex(self.nAttributeIdx)
  local curGroupId = PlayerData.Quest:GetCurTeamFormationQuestGroup(self.nAttributeIdx)
  local curGroupIdxInAttr = PlayerData.Quest:GetTeamFormationGroupIndexInAttribute(curGroupId)
  local curShowGroupIdx = 0
  local curShowGroupInAttri = 0
  for idx, mapGroupData in ipairs(self.tbAllGroup) do
    if self.curShowGroup == mapGroupData.Id then
      curShowGroupIdx = idx
      if mapGroupData.AttributeId == self.nAttributeIdx then
        curShowGroupInAttri = curShowGroupInAttri + 1
      end
    end
  end
  local questGroupCfg = self.tbAllGroup[curShowGroupIdx]
  self.tbChapterReward = {}
  if questGroupCfg ~= nil then
    for i = 1, 5 do
      if questGroupCfg["Item" .. i] ~= 0 then
        table.insert(self.tbChapterReward, {
          nTid = questGroupCfg["Item" .. i],
          nCount = questGroupCfg["Qty" .. i]
        })
      end
    end
    NovaAPI.SetTMPText(self._mapNode.txtChapter, string.format("%02d", self.nCurShowGroupIdxInAttr))
  end
  local nStartIdx = 1
  if questGroupCfg ~= nil and questGroupCfg.ShowBuildId ~= 0 then
    nStartIdx = 2
    self._mapNode.rewardItem[1].gameObject:SetActive(true)
    self._mapNode.imgEmpty[1].gameObject:SetActive(false)
    self._mapNode.rewardItem[1]:SetItem(questGroupCfg.ShowBuildId, nil, 1, nil, nil, nil, nil, true)
  end
  local nItemIdx = 1
  for k = nStartIdx, #self._mapNode.rewardItem do
    self._mapNode.rewardItem[k].gameObject:SetActive(nItemIdx <= #self.tbChapterReward)
    if nItemIdx <= #self.tbChapterReward then
      self._mapNode.rewardItem[k]:SetItem(self.tbChapterReward[nItemIdx].nTid, nil, self.tbChapterReward[nItemIdx].nCount, nil, nil, nil, nil, true)
    end
    if self._mapNode.imgEmpty[k] ~= nil then
      self._mapNode.imgEmpty[k].gameObject:SetActive(nItemIdx > #self.tbChapterReward)
    end
    nItemIdx = nItemIdx + 1
  end
  local bFastReceive = false
  local bAllReceive = true
  if curGroupIdxInAttr == self.nCurShowGroupIdxInAttr then
    for _, mapData in pairs(self.mapCurPageQuest) do
      if mapData.nStatus == 1 then
        bFastReceive = true
      end
      if mapData.nStatus ~= 2 then
        bAllReceive = false
      end
    end
  end
  local bGroupReceived = PlayerData.Quest:CheckTeamFormationGroupReward(self.nAttributeIdx, self.nCurShowGroupIdxInAttr)
  local bCanReceive = bAllReceive and not bGroupReceived
  self._bChapterCanReceive = bCanReceive
  self._bListCanReceive = bFastReceive
  bFastReceive = bFastReceive or bCanReceive
  self._mapNode.btnReceiveChapter.gameObject:SetActive(bCanReceive)
  self._mapNode.btnReceiveChapterGray.gameObject:SetActive(not bCanReceive and not bGroupReceived)
  self._mapNode.txtActComplete.gameObject:SetActive(bGroupReceived)
  self._mapNode.btnFastReceive.gameObject:SetActive(bFastReceive)
  self._mapNode.btnFastReceiveGray.gameObject:SetActive(not bFastReceive)
  self._mapNode.BtnLeft.gameObject:SetActive(curShowGroupIdx > self.nCurAttrQuestGroupStartIdx)
  self._mapNode.BtnRight.gameObject:SetActive(curShowGroupIdx < self.nCurAttrQuestGroupEndIdx)
  if self.nCurPage == 1 then
    self.nCurPage = 2
  else
    self.nCurPage = 1
  end
  if self.mapQuestsGrids ~= nil then
    for nInstanceId, objCtrl in pairs(self.mapQuestsGrids) do
      self:UnbindCtrlByNode(objCtrl)
      self.mapQuestsGrids[nInstanceId] = nil
    end
  end
  self.mapQuestsGrids = {}
  self._mapNode.formationQuestLSV.gameObject:SetActive(true)
  self._mapNode.formationQuestLSV:SetAnim(0.08)
  self._mapNode.formationQuestLSV:Init(#self.mapCurPageQuest, self, self.OnQuestGridRefresh)
end

function QuestNewbieFormationCtrl:OnQuestGridRefresh(goGrid, gridIndex)
  local nInstanceId = goGrid:GetInstanceID()
  if self.mapQuestsGrids[nInstanceId] ~= nil then
    self:UnbindCtrlByNode(self.mapQuestsGrids[nInstanceId])
    self.mapQuestsGrids[nInstanceId] = nil
  end
  self.mapQuestsGrids[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.QuestNewbie.TeamFormation.FormationQuestGridCtrl")
  local nIdx = gridIndex + 1
  self.mapQuestsGrids[nInstanceId]:Refresh(self.mapCurPageQuest[nIdx])
end

function QuestNewbieFormationCtrl:OnBtnClick_Right()
  local curShowGroupIdx = 0
  for idx, mapGroupData in ipairs(self.tbAllGroup) do
    if self.curShowGroup == mapGroupData.Id then
      curShowGroupIdx = idx
    end
  end
  local nAfterGroupIdx = curShowGroupIdx + 1
  local nAfterGroup = self.tbAllGroup[nAfterGroupIdx].Id
  if nAfterGroup == self.nCurGroup then
    self.mapCurPageQuest = self.mapCurQuests
    self:RefreshShow(self.nCurGroup)
    return
  end
  self.mapCurPageQuest = {}
  for _, mapQuestCfgData in ipairs(self.mapAllTeamFormationQuest[nAfterGroup]) do
    table.insert(self.mapCurPageQuest, {
      nTid = mapQuestCfgData.Id,
      nGoal = 1,
      nCurProgress = 1,
      nStatus = 2,
      nExpire = 0
    })
  end
  self:RefreshShow(nAfterGroup)
end

function QuestNewbieFormationCtrl:OnBtnClick_Left()
  local curShowGroupIdx = 0
  for idx, mapGroupData in ipairs(self.tbAllGroup) do
    if self.curShowGroup == mapGroupData.Id then
      curShowGroupIdx = idx
    end
  end
  local nAfterGroupIdx = curShowGroupIdx - 1
  local nAfterGroup = self.tbAllGroup[nAfterGroupIdx].Id
  self.mapCurPageQuest = {}
  for _, mapQuestCfgData in ipairs(self.mapAllTeamFormationQuest[nAfterGroup]) do
    table.insert(self.mapCurPageQuest, {
      nTid = mapQuestCfgData.Id,
      nGoal = 1,
      nCurProgress = 1,
      nStatus = 2,
      nExpire = 0
    })
  end
  self:RefreshShow(nAfterGroup)
end

function QuestNewbieFormationCtrl:InitData()
  self.mapAllTeamFormationQuestStatus = PlayerData.Quest:GetTeamFormationQuestData()
  self.mapAllTeamFormationQuest = {}
  
  local function foreachFormationQuest(mapData)
    if self.mapAllTeamFormationQuest[mapData.QuestGroup] == nil then
      self.mapAllTeamFormationQuest[mapData.QuestGroup] = {}
    end
    table.insert(self.mapAllTeamFormationQuest[mapData.QuestGroup], mapData)
  end
  
  ForEachTableLine(DataTable.AssistQuest, foreachFormationQuest)
  self.tbAllGroup = {}
  
  local function foreachFormationQuestGroup(mapData)
    table.insert(self.tbAllGroup, mapData)
  end
  
  ForEachTableLine(DataTable.AssistQuestGroup, foreachFormationQuestGroup)
  
  local function sortQuestGroup(a, b)
    return a.Id < b.Id
  end
  
  table.sort(self.tbAllGroup, sortQuestGroup)
  self.tbAttr = {}
  
  local function foreachFormationQuestAttr(mapData)
    table.insert(self.tbAttr, mapData)
  end
  
  ForEachTableLine(DataTable.AssistAttribute, foreachFormationQuestAttr)
  self.mapQuestsGrids = {}
  self.mapCurPageQuest = {}
end

function QuestNewbieFormationCtrl:OnEnable()
end

function QuestNewbieFormationCtrl:OnDisable()
  if self.mapQuestsGrids ~= nil then
    for nInstanceId, objCtrl in pairs(self.mapQuestsGrids) do
      self:UnbindCtrlByNode(objCtrl)
      self.mapQuestsGrids[nInstanceId] = nil
    end
  end
  if self.tbAttrGridCtrl ~= nil then
    for insId, objCtrl in pairs(self.tbAttrGridCtrl) do
      self:UnbindCtrlByNode(objCtrl)
      self.tbAttrGridCtrl[insId] = nil
    end
  end
  self.mapQuestsGrids = {}
  self.mapCurPageQuest = {}
end

function QuestNewbieFormationCtrl:OnBtnClick_ReceiveChapter()
  local bReceived = PlayerData.Quest:CheckTeamFormationGroupReward(self.nAttributeIdx, self.nCurShowGroupIdxInAttr)
  if bReceived then
    return
  end
  local curShowGroupIdx = 0
  for idx, mapGroupData in ipairs(self.tbAllGroup) do
    if self.curShowGroup == mapGroupData.Id then
      curShowGroupIdx = idx
    end
  end
  local questGroupCfg = self.tbAllGroup[curShowGroupIdx]
  if questGroupCfg == nil then
    return
  end
  local bDropBuild = questGroupCfg.ShowBuildId ~= nil and 0 < questGroupCfg.ShowBuildId
  if bDropBuild then
    local function CheckBuildCountCallBack(nBuildCount)
      local nMaxBuildCount = ConfigTable.GetConfigNumber("StarTowerBuildNumberMax")
      
      local bCanReceive = nBuildCount < nMaxBuildCount
      if bCanReceive then
        PlayerData.Quest:ReceiveTeamFormationGroupReward(questGroupCfg.Id, self.nAttributeIdx, nil)
      else
        local function confirmCallback()
          EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildBriefList)
        end
        
        local msg = {
          nType = AllEnum.MessageBox.Confirm,
          sContent = ConfigTable.GetUIText("BUILD_04"),
          sConfirm = ConfigTable.GetUIText("RoguelikeBuild_BuildCount_BtnManage"),
          callbackConfirm = confirmCallback
        }
        EventManager.Hit(EventId.OpenMessageBox, msg)
      end
    end
    
    PlayerData.Build:GetBuildCount(CheckBuildCountCallBack)
  else
    PlayerData.Quest:ReceiveTeamFormationGroupReward(questGroupCfg.Id, self.nAttributeIdx, nil)
  end
end

function QuestNewbieFormationCtrl:OnBtnClick_FastReceive()
  local curShowGroupIdx = 0
  for idx, mapGroupData in ipairs(self.tbAllGroup) do
    if self.curShowGroup == mapGroupData.Id then
      curShowGroupIdx = idx
    end
  end
  local questGroupCfg = self.tbAllGroup[curShowGroupIdx]
  local nId = 0
  if questGroupCfg ~= nil then
    nId = questGroupCfg.Id
  end
  local bListCanReceive = self._bListCanReceive
  local bChapterCanReceive = self._bChapterCanReceive
  if not bListCanReceive and not bChapterCanReceive then
    return
  end
  if bListCanReceive then
    PlayerData.Quest:ReceiveTeamFormationReward(0, nId, nil)
  else
    self:_DoReceiveChapter(questGroupCfg, nil)
  end
end

function QuestNewbieFormationCtrl:_CheckChapterUnlockedAfterList()
  if PlayerData.Quest:CheckTeamFormationGroupReward(self.nAttributeIdx, self.nCurShowGroupIdxInAttr) then
    return false
  end
  if self.mapCurPageQuest == nil then
    return false
  end
  for _, mapData in ipairs(self.mapCurPageQuest) do
    if mapData.nStatus ~= 2 then
      return false
    end
  end
  return true
end

function QuestNewbieFormationCtrl:_AccumulateDisplayItem(tbItem, mapChangeInput)
  if tbItem == nil and mapChangeInput == nil then
    return
  end
  local mapTrans = PlayerData.Item:ProcessTransChangeInfo(mapChangeInput)
  local tbReward, tbSpReward = PlayerData.Item:ProcessRewardDisplayItem(tbItem, mapTrans)
  if tbReward ~= nil then
    for _, v in ipairs(tbReward) do
      appendOrStack(self._mapMergedReward.tbReward, v, "id", "count", "rewardType")
    end
  end
  if tbSpReward ~= nil then
    for _, v in ipairs(tbSpReward) do
      table.insert(self._mapMergedReward.tbSpReward, v)
    end
  end
  if mapTrans ~= nil then
    for _, v in ipairs(mapTrans.tbSrc or {}) do
      appendOrStack(self._mapMergedReward.tbSrc, v, "Tid", "Qty")
    end
    for _, v in ipairs(mapTrans.tbDst or {}) do
      appendOrStack(self._mapMergedReward.tbDst, v, "Tid", "Qty")
    end
  end
end

function QuestNewbieFormationCtrl:_DoReceiveChapter(questGroupCfg, callback)
  if questGroupCfg == nil then
    if callback ~= nil then
      callback(nil)
    end
    return
  end
  local bDropBuild = questGroupCfg.ShowBuildId ~= nil and questGroupCfg.ShowBuildId > 0
  if bDropBuild then
    local function CheckBuildCountCallBack(nBuildCount)
      local nMaxBuildCount = ConfigTable.GetConfigNumber("StarTowerBuildNumberMax")
      
      local bCanReceive = nBuildCount < nMaxBuildCount
      if bCanReceive then
        PlayerData.Quest:ReceiveTeamFormationGroupReward(questGroupCfg.Id, self.nAttributeIdx, callback)
      else
        if callback ~= nil then
          callback(nil)
        end
        
        local function confirmCallback()
          EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildBriefList)
        end
        
        local msg = {
          nType = AllEnum.MessageBox.Confirm,
          sContent = ConfigTable.GetUIText("BUILD_04"),
          sConfirm = ConfigTable.GetUIText("RoguelikeBuild_BuildCount_BtnManage"),
          callbackConfirm = confirmCallback
        }
        EventManager.Hit(EventId.OpenMessageBox, msg)
      end
    end
    
    PlayerData.Build:GetBuildCount(CheckBuildCountCallBack)
  else
    PlayerData.Quest:ReceiveTeamFormationGroupReward(questGroupCfg.Id, self.nAttributeIdx, callback)
  end
end

function QuestNewbieFormationCtrl:_FlushBatchReceive(bAttributeComplete, nNextGroupId)
  PlayerData.Quest:SetBatchReceiveFlag(false)
  local mapMerged = self._mapMergedReward or {
    tbReward = {},
    tbSpReward = {},
    tbSrc = {},
    tbDst = {}
  }
  self._mapMergedReward = nil
  
  local function refreshFunc()
    EventManager.Hit("UpdateTeamFormationGroup", bAttributeComplete, nNextGroupId)
  end
  
  UTILS.OpenReceiveByReward(mapMerged, refreshFunc)
end

function QuestNewbieFormationCtrl:OnBtnClick_FastReceiveGray()
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Affinity_Reward_Tips"))
end

function QuestNewbieFormationCtrl:OnBtnClick_RewardItem(btn, nIndex)
  local nTid = 0
  local curShowGroupIdx = 0
  for idx, mapGroupData in ipairs(self.tbAllGroup) do
    if self.curShowGroup == mapGroupData.Id then
      curShowGroupIdx = idx
    end
  end
  local questGroupCfg = self.tbAllGroup[curShowGroupIdx]
  if questGroupCfg ~= nil and questGroupCfg.ShowBuildId ~= 0 then
    if 1 < nIndex then
      nIndex = nIndex - 1
      nTid = self.tbChapterReward[nIndex].nTid
    else
      nTid = questGroupCfg.ShowBuildId
    end
  else
    nTid = self.tbChapterReward[nIndex].nTid
  end
  UTILS.ClickItemGridWithTips(nTid, btn.transform, true, true, false)
end

function QuestNewbieFormationCtrl:OnBtnClick_BackToTeamSelect()
  self:RefreshTeamSelect()
end

function QuestNewbieFormationCtrl:OnEvent_SelectTourGuideQuest(nQuestId)
  for i, v in ipairs(self.mapCurPageQuest) do
    if v.nTid == nQuestId then
      self._mapNode.formationQuestLSV:SetScrollGridPos(i - 1, 0, 0)
      EventManager.Hit("Guide_SelectGuideGroupGrid", nQuestId, i - 1)
      break
    end
  end
end

function QuestNewbieFormationCtrl:OnEvent_UpdateTeamFormationGroup(bAttributeComplete, nNextGroup)
  if bAttributeComplete then
    LocalData.SetPlayerLocalData("TeamFormationQuestSelected", nil)
    self:Refresh()
    return
  elseif nNextGroup ~= nil then
    self.nCurGroup = nNextGroup
  end
  self._mapNode.goQuestList:SetActive(true)
  self.mapAllTeamFormationQuestStatus = PlayerData.Quest:GetTeamFormationQuestData()
  self:RefreshQuestList(self.mapAllTeamFormationQuest[self.nCurGroup], self.nCurGroup)
end

function QuestNewbieFormationCtrl:OnEvent_Guide_GetNewQuestTaskIndex(nTaskIndex)
  local nIndex = 0
  for i = 1, #self.mapCurPageQuest do
    if self.mapCurPageQuest[i].nTid == nTaskIndex then
      nIndex = i - 1
      break
    end
  end
  local nPos = 1 < nIndex and nIndex - 1 or 0
  self._mapNode.formationQuestLSV:SetScrollGridPos(nPos, 0)
  local listInUse = self._mapNode.formationQuestLSV:GetInUseGridIndex()
  local nPosInScreen = 0
  for i = 0, listInUse.Count - 1 do
    if listInUse[i] == nIndex then
      nPosInScreen = i
      break
    end
  end
  EventManager.Hit("OnEvent_SetNewQuestTaskIndex", nPosInScreen)
end

return QuestNewbieFormationCtrl
