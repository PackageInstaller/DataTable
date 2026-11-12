local RogueBossSelectCtrl = class("RogueBossSelectCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local mapToggle = {
  [1] = 1,
  [2] = 2,
  [3] = 3,
  [4] = 4,
  [5] = 5,
  [6] = 6,
  [7] = 7,
  [8] = 8,
  [9] = 9,
  [10] = 10
}
RogueBossSelectCtrl._mapNodeConfig = {
  rtBossList = {},
  rtBossInfo = {},
  svList = {
    sComponentName = "LoopScrollView"
  },
  cgsvList = {
    sNodeName = "svList",
    sComponentName = "CanvasGroup"
  },
  imgLevelImg = {sComponentName = "Image"},
  txtSuggestLevel = {sComponentName = "TMP_Text"},
  TMPRoguelikeName = {sComponentName = "TMP_Text"},
  TMPRoguelikeDesc = {sComponentName = "TMP_Text"},
  imgElementInfo = {sComponentName = "Image", nCount = 3},
  Skill = {
    sCtrlName = "Game.UI.TemplateEx.TemplateSkillCtrl",
    nCount = 5
  },
  btnSkill = {
    sNodeName = "Skill",
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_Skill"
  },
  item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 5
  },
  Task = {sComponentName = "Transform", nCount = 3},
  rt_Toggle = {},
  togCtrl = {
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl",
    nCount = 10
  },
  tog = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_HardTog",
    nCount = 10
  },
  imgLockMask = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_TogTips",
    nCount = 10
  },
  rt_Targets = {nCount = 10},
  rt_LockMsg = {nCount = 10},
  txt_LockMsg = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegusBoss_LevelUnLock",
    nCount = 10
  },
  txtLockCondition = {sComponentName = "TMP_Text", nCount = 8},
  txtTitleSkill = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegusBoss_Enemy_Skill"
  },
  txtBtnGo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go"
  },
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnClickBtnCrusade"
  },
  btnRaid = {
    sComponentName = "UIButton",
    callback = "OnClickBtnRaid"
  },
  txtBtnRaid = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Title_Raid"
  },
  TMPRaidUnlockHint = {
    sComponentName = "TMP_Text",
    sLanguageId = "Raid_Btn_Cond"
  },
  btn_item = {
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_Reward"
  },
  goRewardList = {
    sCtrlName = "Game.UI.MainlineEx.RewardListCtrl"
  },
  btnAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AllReward"
  },
  imgTickets = {sComponentName = "Image"},
  txtTicketsCount = {sComponentName = "TMP_Text"},
  txtTitleTarget = {
    sComponentName = "TMP_Text",
    sLanguageId = "MainBattle_Task"
  },
  goBossSelectItem = {
    nCount = 5,
    sCtrlName = "Game.UI.FixedRoguelikeLevelSelectEx.RogueBossSelectItemCtrl"
  },
  imgRaidUnlockMask = {},
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  BG1 = {sNodeName = "----Bg----", sComponentName = "Image"},
  FXNormal = {},
  FXHard = {},
  BG2 = {sComponentName = "Image"},
  txtTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Lv"
  },
  txtBuildTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  imgBuild = {sComponentName = "Image"},
  HardCoreSwitch = {},
  redDotHard = {},
  txtHardCore = {
    sComponentName = "TMP_Text",
    sLanguageId = "RogueBoss_HardCore"
  },
  btnHardCoreChange = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ChangeType"
  },
  goBossTick = {},
  imgBossTickIcon = {sComponentName = "Image"},
  txtBossTickCount = {sComponentName = "TMP_Text"},
  bossTickTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "TopBar_BossTick_Tip"
  },
  btnBossTick = {
    sNodeName = "goBossTickBg",
    sComponentName = "UIButton",
    callback = "OnBtnClick_BossTick"
  },
  goBossTickInfo = {},
  imgBossTickIconInfo = {sComponentName = "Image"},
  txtBossTickCountInfo = {sComponentName = "TMP_Text"},
  btnBossTickInfo = {
    sNodeName = "goBossTickBgInfo",
    sComponentName = "UIButton",
    callback = "OnBtnClick_BossTick"
  },
  goOpen = {},
  goOff = {},
  titleReward = {},
  imgReward = {},
  goReward = {},
  goTask = {},
  handInfoIcon = {},
  imgRewardHand = {},
  goRewardHand = {},
  txtTitleHand = {
    sComponentName = "TMP_Text",
    sLanguageId = "Level_Award"
  },
  txtTitleNormal = {
    sComponentName = "TMP_Text",
    sLanguageId = "Level_Award"
  },
  txtAllRewardNormal = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Btn_All"
  },
  txtAllRewardHand = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mall_Btn_All"
  },
  btnAllRewardHand = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_AllReward"
  },
  btn_itemHand = {
    sComponentName = "UIButton",
    nCount = 5,
    callback = "OnBtnClick_Reward"
  },
  itemHand = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 5
  },
  btn_itemHand_Extra = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ExtraDropReward"
  },
  itemHandExtra = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  gridTemp = {},
  ContentTemp = {sComponentName = "Transform"},
  ListConditions = {},
  btnLock = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Lock"
  },
  txtBtnLock = {
    sComponentName = "TMP_Text",
    sLanguageId = "RegusBoss_SatisfyConditions_UnLock"
  },
  Conditions_ = {nCount = 2},
  imgDoubleDrop = {},
  txtDoubleDrop = {sComponentName = "TMP_Text"},
  txtDoubleDropCount = {sComponentName = "TMP_Text"},
  imgReengagementDrop = {},
  txtReengagementDoubleDrop = {sComponentName = "TMP_Text"},
  txtReengagementDropCount = {sComponentName = "TMP_Text"}
}
RogueBossSelectCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UpdateEnergy] = "OnEvent_UpdateEnergy",
  [EventId.UpdateWorldClass] = "OnEvent_UpdateWorldClass",
  SelectRogueBossItem = "OnEvent_SelectRogueBossItem",
  StartLoopScrollSnap = "OnEvent_StartLoopScrollSnap",
  StartDragLoopScrollSnap = "OnEvent_StartDragLoopScrollSnap",
  RaidSuccess = "OnEvent_RaidSuccess"
}
RogueBossSelectCtrl._mapRedDotConfig = {
  [RedDotDefine.Map_RogueBoss] = {sNodeName = "redDotHard"}
}

function RogueBossSelectCtrl:Awake()
  self.mapAllLevel = {}
  
  local function forEachRegoinBossLevel(mapData)
    if self.mapAllLevel[mapData.RegionBossId] == nil then
      self.mapAllLevel[mapData.RegionBossId] = {}
    end
    self.mapAllLevel[mapData.RegionBossId][mapData.Difficulty] = mapData
  end
  
  ForEachTableLine(DataTable.RegionBossLevel, forEachRegoinBossLevel)
  self.isHandCoreType = PlayerData.RogueBoss:GetSelectRegionType()
  local worldClass = PlayerData.Base:GetWorldClass()
  local openClass = ConfigTable.GetData("OpenFunc", GameEnum.OpenFuncType.RegionBossChallenge).NeedWorldClass
  self._mapNode.HardCoreSwitch:SetActive(worldClass >= openClass)
end

function RogueBossSelectCtrl:FadeIn()
end

function RogueBossSelectCtrl:FadeOut()
end

function RogueBossSelectCtrl:OnEnable()
  PlayerData.RogueBoss:SetIsWeeklyCopies(false)
  self.animatorRoot = self.gameObject:GetComponent("Animator")
  local tbParam = self:GetPanelParam()
  self.nJumpToGroup = 0
  self.nJumpToHard = 0
  self.bJumpTo = false
  if nil ~= next(tbParam) then
    if tbParam[3] == nil then
    end
    self.bJumpTo = tbParam[3]
    self.nJumpToGroup = tbParam[2] == nil and 0 or tbParam[2]
    if 0 ~= self.nJumpToGroup then
      local function closeGuide()
        if PlayerData.Guide:CheckInGuideGroup(16) then
          EventManager.Hit("RogueBossGuideFinish")
        end
      end
      
      self:AddTimer(1, 0.2, closeGuide, true, true, true, nil)
      local nMaxHard = PlayerData.RogueBoss:GetMaxHard(self.nJumpToGroup)
      local nJumpToHard = (nil == tbParam[1] or 0 == tbParam[1]) and nMaxHard or tbParam[1]
      if self.bJumpTo then
        self.nJumpToHard = nJumpToHard
      else
        local nLastMaxHard = PlayerData.RogueBoss:GetLastMaxHard(self.nJumpToGroup)
        if 0 == nLastMaxHard then
          self.nJumpToHard = nJumpToHard
        elseif nLastMaxHard == nMaxHard then
          self.nJumpToHard = nJumpToHard
        else
          self.nJumpToHard = nMaxHard
        end
      end
    end
  end
  print("jump:" .. self.nJumpToHard .. " " .. self.nJumpToGroup)
  self._mapNode.rtBossList:SetActive(true)
  self._mapNode.rtBossInfo:SetActive(false)
  self.curState = 1
  self:SetRegionType()
  
  local function waitCallback()
    self:SetTopBar()
  end
  
  self:AddTimer(1, 0.1, waitCallback, true, true, true, nil)
  self:SetSvList()
  self:SetBgImg()
  if self.nJumpToGroup ~= 0 and self.nJumpToGroup ~= nil then
    self.animatorRoot.enabled = false
    self:OpenJumpToGroup()
  else
    EventManager.Hit(EventId.TemporaryBlockInput, 1.33)
    self._mapNode.cgsvList:DOFade(1, 0.33)
    self:PlayAnim("RogueBossSelect_in")
  end
end

function RogueBossSelectCtrl:OnDisable()
end

function RogueBossSelectCtrl:OnDestroy()
  self.tbAllBoss = nil
end

function RogueBossSelectCtrl:OnRelease()
end

function RogueBossSelectCtrl:OpenJumpToGroup()
  local bOpen = PlayerData.RogueBoss:CheckLevelOpen(self.nJumpToGroup)
  if not bOpen then
    return
  end
  self.curState = 2
  if self.nJumpToHard == 0 then
    self.curSelectHard = GameEnum.diffculty.Diffculty_1
  else
    self.curSelectHard = self.nJumpToHard
  end
  local nMaxHard = PlayerData.RogueBoss:GetBossMaxGroupCount(self.nJumpToGroup)
  if nMaxHard < self.curSelectHard then
    self.curSelectHard = nMaxHard
  end
  self.curGroupId = self.nJumpToGroup
  self:RefreshLevelInfo(self.nJumpToGroup, self.curSelectHard)
  local mapRogueBossLevel = self.mapAllLevel[self.nJumpToGroup][self.curSelectHard]
  self.regionType = mapRogueBossLevel.RegionType
  self._mapNode.rtBossList:SetActive(false)
  self._mapNode.rtBossInfo:SetActive(true)
  self._mapNode.BG2.gameObject:SetActive(true)
  self:SetTogList(self.curSelectHard)
end

function RogueBossSelectCtrl:FindCenterGird()
  local minPos = 99999
  local centerPos = self._mapNode.CenterPoint.position.x
  local centerIndex = 0
  for i = 1, self._mapNode.svContent.childCount do
    local child = self._mapNode.svContent:GetChild(i - 1)
    local pos = math.abs(child.position.x - centerPos)
    if minPos > pos then
      centerIndex = child.name
      minPos = pos
    end
  end
  return centerIndex
end

function RogueBossSelectCtrl:OnPlayGridAnim(goGrid, gridIndex)
  local index = gridIndex
  local trans = goGrid.transform:Find("AnimRoot")
  local firstIndex = self._mapNode.svList:GetFirsetGridIndex()
  local centerIndex = self:FindCenterGird()
  local moveIndex = index - centerIndex + firstIndex
  if moveIndex > #self.tbAllBoss + 1 then
    moveIndex = moveIndex - #self.tbAllBoss - 1
  elseif moveIndex < 0 then
    moveIndex = moveIndex + #self.tbAllBoss + 1
  end
  EventManager.Hit(EventId.TemporaryBlockInput, 0.36)
  self._mapNode.svList:SetScrollGridPos(moveIndex, 0.2)
  self:AddTimer(1, 0.2, function()
    trans:GetComponent("Animator"):Play("rtBossList_in")
    self:OnEvent_SelectRogueBossItem(self.tbAllBoss[index + 1])
  end, true, true, true)
end

function RogueBossSelectCtrl:OnRefreshGrid(goGrid, gridIndex)
  local index = gridIndex + 1
  local trans = goGrid.transform:Find("AnimRoot")
  local goUnlock = trans:Find("goUnlock")
  local goNone = trans:Find("goNone")
  local goLock = trans:Find("goLock")
  local btnGrid = trans:Find("btnGrid"):GetComponent("UIButton")
  local objHardCore = trans:Find("objHardCore")
  local imgBg = trans:Find("bg"):GetComponent("Image")
  objHardCore.gameObject:SetActive(false)
  btnGrid.interactable = index <= #self.tbAllBoss
  if index > #self.tbAllBoss then
    goNone.gameObject:SetActive(true)
    goUnlock.gameObject:SetActive(false)
    goLock.gameObject:SetActive(false)
    if self.regionType == GameEnum.RegionType.NormalRegion then
      self:SetPngSprite(imgBg, "UI/big_sprites/db_stage_01")
    else
      self:SetPngSprite(imgBg, "UI/big_sprites/db_stage_02")
    end
  else
    btnGrid.onClick:RemoveAllListeners()
    btnGrid.onClick:AddListener(function()
      trans:GetComponent("Animator"):Play("rtBossList_in")
      self:OnEvent_SelectRogueBossItem(self.tbAllBoss[index])
      self.bJumpTo = false
    end)
    goNone.gameObject:SetActive(false)
    local mapBossData = self.tbAllBoss[index]
    if mapBossData == nil then
      return
    end
    objHardCore.gameObject:SetActive(mapBossData.RegionType == GameEnum.RegionType.HardCoreRegion)
    if self.regionType == GameEnum.RegionType.NormalRegion then
      self:SetPngSprite(imgBg, "UI/big_sprites/db_stage_01")
    else
      self:SetPngSprite(imgBg, "UI/big_sprites/db_stage_02")
    end
    local nLevelState, bUnlock = PlayerData.RogueBoss:GetLevelOpenState(mapBossData.Id)
    goUnlock.gameObject:SetActive(true)
    goLock.gameObject:SetActive(not bUnlock)
    local TMPBossWait = goNone:Find("TMPBossWait"):GetComponent("TMP_Text")
    local imgLevel = goUnlock:Find("imgLevel"):GetComponent("Image")
    local TMPBossName1 = goUnlock:Find("TMPBossName1"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(TMPBossWait, ConfigTable.GetUIText("RegusBoss_NotOpenItem"))
    self:SetPngSprite(imgLevel, mapBossData.Episode)
    NovaAPI.SetTMPText(TMPBossName1, mapBossData.Name)
    local rtElements1 = goUnlock:Find("goElements/rtElements1")
    local txtDrop = goUnlock:Find("txtDrop"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtDrop, ConfigTable.GetUIText("RegusBoss_Drop_Possible"))
    for i = 1, rtElements1.childCount do
      local imgElement = rtElements1:GetChild(i - 1):GetComponent("Image")
      if mapBossData.EET[i] ~= nil then
        self:SetAtlasSprite(imgElement, "12_rare", AllEnum.ElementIconType.Icon .. mapBossData.EET[i])
      end
      imgElement.gameObject:SetActive(mapBossData.EET[i] ~= nil)
    end
    local rtDropItems = goUnlock:Find("rtDropItems")
    for i = 1, rtDropItems.childCount do
      local item = rtDropItems:GetChild(i - 1)
      if mapBossData.DropItem[i] ~= nil then
        local itemCtrl = self:BindCtrlByNode(item:Find("AnimRoot/tc_item_01"), "Game.UI.TemplateEx.TemplateItemCtrl")
        itemCtrl:SetItem(mapBossData.DropItem[i])
        local btnItem = item:GetComponent("UIButton")
        btnItem.onClick:RemoveAllListeners()
        btnItem.onClick:AddListener(function()
          local mapData = {
            nTid = mapBossData.DropItem[i],
            bShowDepot = true
          }
          if self.bStartSnap ~= true then
            EventManager.Hit(EventId.OpenPanel, PanelId.ItemTips, item, mapData)
          end
        end)
      end
      item.gameObject:SetActive(mapBossData.DropItem[i] ~= nil)
    end
    if bUnlock then
      do
        local sUnlockTips = PlayerData.RogueBoss:GetUnOpenUITipText(nLevelState, mapBossData.Id)
        if nil ~= sUnlockTips and "" ~= sUnlockTips then
          local txtLock = goUnlock:Find("txtLock"):GetComponent("TMP_Text")
          NovaAPI.SetTMPText(txtLock, sUnlockTips)
        end
      end
    end
  end
end

function RogueBossSelectCtrl:RefreshLevelInfo(nGroupId, nDifficult)
  self.SelectDifficult = nDifficult
  local mapRogueBossLevel = self.mapAllLevel[nGroupId][nDifficult]
  local mapBossData = ConfigTable.GetData("RegionBoss", nGroupId)
  local mapLevelInfo = PlayerData.RogueBoss:GetCacheBossLevelMsg(mapRogueBossLevel.Id)
  if mapRogueBossLevel == nil then
    return
  end
  self:SetPngSprite(self._mapNode.imgLevelImg, mapBossData.Image)
  NovaAPI.SetTMPText(self._mapNode.TMPRoguelikeName, mapRogueBossLevel.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPRoguelikeDesc, mapRogueBossLevel.Desc)
  NovaAPI.SetTMPText(self._mapNode.txtSuggestLevel, mapRogueBossLevel.SuggestedPower)
  local sRank = "Icon/BuildRank/BuildRank_" .. mapRogueBossLevel.RecommendBuildRank
  self:SetPngSprite(self._mapNode.imgBuild, sRank)
  local isHandCoreType = mapRogueBossLevel.RegionType == GameEnum.RegionType.HardCoreRegion
  self._mapNode.titleReward:SetActive(not isHandCoreType)
  self._mapNode.imgReward:SetActive(not isHandCoreType)
  self._mapNode.goReward:SetActive(not isHandCoreType)
  self._mapNode.goTask:SetActive(not isHandCoreType)
  self._mapNode.handInfoIcon:SetActive(isHandCoreType)
  self._mapNode.imgRewardHand:SetActive(isHandCoreType)
  self._mapNode.goRewardHand:SetActive(isHandCoreType)
  for i = 1, 3 do
    if mapBossData.EET == nil or mapBossData.EET[i] == nil then
      self._mapNode.imgElementInfo[i].gameObject:SetActive(false)
    else
      self._mapNode.imgElementInfo[i].gameObject:SetActive(true)
      self:SetAtlasSprite(self._mapNode.imgElementInfo[i], "12_rare", AllEnum.ElementIconType.Icon .. mapBossData.EET[i])
    end
  end
  local curStar = 0
  if mapLevelInfo ~= nil then
    curStar = mapLevelInfo.Star
  end
  local tbCond = {}
  table.insert(tbCond, decodeJson(mapRogueBossLevel.OneStarCondition))
  table.insert(tbCond, decodeJson(mapRogueBossLevel.TwoStarCondition))
  table.insert(tbCond, decodeJson(mapRogueBossLevel.ThreeStarCondition))
  for i = 1, 3 do
    local rtTask = self._mapNode.Task[i]
    local goDone = rtTask:Find("imgDone").gameObject
    local imgUnDone = rtTask:Find("imgUnDone").gameObject
    local Text = rtTask:Find("Text"):GetComponent("TMP_Text")
    goDone:SetActive(curStar >= i)
    imgUnDone:SetActive(curStar < i)
    local cond = tbCond[i]
    if cond == nil then
      rtTask.gameObject:SetActive(false)
      return
    else
      rtTask.gameObject:SetActive(true)
      if i == 1 then
        NovaAPI.SetTMPText(Text, ConfigTable.GetUIText("RegionBoss_PassConfition_1"))
      elseif i == 2 then
        NovaAPI.SetTMPText(Text, ConfigTable.GetUIText("RegionBoss_PassConfition_2"))
      else
        NovaAPI.SetTMPText(Text, orderedFormat(ConfigTable.GetUIText("RegionBoss_PassConfition_3"), tbCond[2][2] - cond[2]))
      end
    end
  end
  for i = 1, 5 do
    local sName = "EntryGroupId" .. i
    local sLevelName = "EntryGroupLevel" .. i
    local nSkillId = mapRogueBossLevel[sName]
    local nSkillLv = mapRogueBossLevel[sLevelName]
    self._mapNode.Skill[i]:SetMonsterSkill(nSkillId)
  end
  local tbReward = decodeJson(mapRogueBossLevel.BaseAwardPreview)
  self.tbReward = tbReward
  local lvStarCount = mapLevelInfo and mapLevelInfo.maxStar or 0
  local isFirstPass = mapLevelInfo and mapLevelInfo.First or false
  for index = 1, #tbReward do
    if tbReward[index] ~= nil then
      local nLastIndex = #tbReward[index]
      local bReceived = false
      if tbReward[index][nLastIndex] == 1 and isFirstPass then
        bReceived = true
      elseif tbReward[index][nLastIndex] == 2 and lvStarCount == 3 then
        bReceived = true
      end
      table.insert(self.tbReward[index], bReceived)
    end
  end
  self.tbAfterReward = {}
  for key, value in pairs(self.tbReward) do
    local nLastIndex = #self.tbReward[key]
    if not self.tbReward[key][nLastIndex] then
      table.remove(value)
      table.insert(self.tbAfterReward, value)
    end
  end
  for index = 1, 5 do
    if not isHandCoreType then
      self._mapNode.btn_item[index].interactable = self.tbAfterReward[index] ~= nil
      if self.tbAfterReward[index] ~= nil then
        local nLastIndex = #self.tbAfterReward[index]
        self._mapNode.item[index]:SetItem(self.tbAfterReward[index][1], nil, UTILS.ParseRewardItemCount(self.tbAfterReward[index]), nil, false, self.tbAfterReward[index][nLastIndex] == 1, self.tbAfterReward[index][nLastIndex] == 2, true)
      else
        self._mapNode.item[index]:SetItem(nil)
      end
    else
      self._mapNode.btn_itemHand[index].interactable = self.tbAfterReward[index] ~= nil
      if self.tbAfterReward[index] ~= nil then
        local nLastIndex = #self.tbAfterReward[index]
        self._mapNode.itemHand[index]:SetItem(self.tbAfterReward[index][1], nil, UTILS.ParseRewardItemCount(self.tbAfterReward[index]), nil, false, self.tbAfterReward[index][nLastIndex] == 1, self.tbAfterReward[index][nLastIndex] == 2, true)
      else
        self._mapNode.itemHand[index]:SetItem(nil)
      end
    end
  end
  self.tbExtraDropReward = {}
  self._mapNode.btn_itemHand_Extra.interactable = mapRogueBossLevel.ExtraDropPreview ~= nil and 0 < #mapRogueBossLevel.ExtraDropPreview and self.regionType == GameEnum.RegionType.HardCoreRegion
  if mapRogueBossLevel.ExtraDropPreview ~= nil and 0 < #mapRogueBossLevel.ExtraDropPreview and self.regionType == GameEnum.RegionType.HardCoreRegion then
    self._mapNode.itemHandExtra:SetItem(mapRogueBossLevel.ExtraDropPreview[1], nil, nil, nil, false, false, false, false, false, false, true)
    local countTxt = ""
    if mapRogueBossLevel.ExtraDropPreview[2] == mapRogueBossLevel.ExtraDropPreview[3] then
      countTxt = mapRogueBossLevel.ExtraDropPreview[2]
    else
      countTxt = mapRogueBossLevel.ExtraDropPreview[2] .. "~" .. mapRogueBossLevel.ExtraDropPreview[3]
    end
    local txtCount = self._mapNode.itemHandExtra.gameObject.transform:Find("--Common--/txtCount"):GetComponent("TMP_Text")
    local txtX = txtCount.transform:Find("txtX")
    txtCount.gameObject:SetActive(0 < mapRogueBossLevel.ExtraDropPreview[2])
    txtX.gameObject:SetActive(mapRogueBossLevel.ExtraDropPreview[2] == mapRogueBossLevel.ExtraDropPreview[3])
    self.tbExtraDropReward = mapRogueBossLevel.ExtraDropPreview
    NovaAPI.SetTMPText(txtCount, countTxt)
  else
    self._mapNode.itemHandExtra:SetItem(nil)
  end
  self._mapNode.goBossTickInfo:SetActive(isHandCoreType)
  if not isHandCoreType then
    local nRequire = mapRogueBossLevel.EnergyConsume
    self:SetSprite_Coin(self._mapNode.imgTickets, AllEnum.CoinItemId.Energy)
    local nHas = PlayerData.Base:GetCurEnergy()
    NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, nRequire)
    NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nRequire > nHas.nEnergy and Red_Unable or Blue_Normal)
  else
    self:SetSprite_Coin(self._mapNode.imgTickets, AllEnum.CoinItemId.RogueHardCoreTick)
    local ticketCount = PlayerData.Item:GetItemCountByID(AllEnum.CoinItemId.RogueHardCoreTick)
    NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, "1")
    NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, ticketCount < 1 and Red_Unable or Blue_Normal)
  end
  local isUnLock, isWorldClass, isPreLevelStar = PlayerData.RogueBoss:GetRogueBossUnLockMsg(nGroupId, nDifficult)
  self.curStar = curStar
  self._mapNode.txtBtnRaid.gameObject:SetActive(curStar == 3)
  self._mapNode.imgRaidUnlockMask:SetActive(curStar < 3)
  self._mapNode.btnRaid.gameObject:SetActive(not isHandCoreType and isUnLock)
  self._mapNode.btnGo.gameObject:SetActive(isUnLock)
  self._mapNode.btnLock.gameObject:SetActive(not isUnLock)
  self._mapNode.ListConditions:SetActive(not isUnLock)
  self._mapNode.imgDoubleDrop:SetActive(false)
  self._mapNode.imgReengagementDrop:SetActive(false)
  self.actData = PlayerData.Activity:GetActivityDataByType(GameEnum.activityType.Double)
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  local bShowNormalDouble = false
  if self.actData ~= nil and self.actData:CheckActShow() and self.actData:CheckInstanceType(GameEnum.instanceType.RegionBoss) then
    local nCurCount, nMaxCount = self.actData:GetDoubleDropsTimes()
    bShowNormalDouble = 0 < nMaxCount - nCurCount
  end
  if bShowNormalDouble then
    self._mapNode.imgDoubleDrop:SetActive(isUnLock)
    self:RefreshDoubleDropCount()
  elseif 0 < nReengagementCount then
    self._mapNode.imgReengagementDrop:SetActive(true)
    self:RefreshReengagementCount()
  end
  if not isUnLock and not isHandCoreType then
    local imgConditions_Lock_WC = self._mapNode.Conditions_[1].gameObject.transform:Find("imgConditions_Lock").gameObject
    local imgConditions_UnLock_WC = self._mapNode.Conditions_[1].gameObject.transform:Find("imgConditions_UnLock").gameObject
    local tex_ConditionsTips_WC = self._mapNode.Conditions_[1].gameObject.transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
    imgConditions_Lock_WC:SetActive(not isWorldClass)
    imgConditions_UnLock_WC:SetActive(isWorldClass)
    local tempData = PlayerData.RogueBoss._regionBossLevel[nGroupId][nDifficult]
    NovaAPI.SetTMPText(tex_ConditionsTips_WC, orderedFormat(ConfigTable.GetUIText("RegusBoss_UnlockConditions_WorldClass"), tempData.NeedWorldClass))
    NovaAPI.SetTMPColor(tex_ConditionsTips_WC, isWorldClass and Color(0.3686274509803922, 0.5372549019607843, 0.7058823529411765) or Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764))
    local imgConditions_Lock_PL = self._mapNode.Conditions_[2].gameObject.transform:Find("imgConditions_Lock").gameObject
    local imgConditions_UnLock_PL = self._mapNode.Conditions_[2].gameObject.transform:Find("imgConditions_UnLock").gameObject
    local tex_ConditionsTips_PL = self._mapNode.Conditions_[2].gameObject.transform:Find("tex_ConditionsTips"):GetComponent("TMP_Text")
    local _sKey = "Diffculty_" .. nDifficult - 1
    imgConditions_Lock_PL:SetActive(not isPreLevelStar)
    imgConditions_UnLock_PL:SetActive(isPreLevelStar)
    NovaAPI.SetTMPText(tex_ConditionsTips_PL, orderedFormat(ConfigTable.GetUIText("RegusBoss_UnlockConditions_PreLevel"), ConfigTable.GetUIText(_sKey)))
    NovaAPI.SetTMPColor(tex_ConditionsTips_PL, isPreLevelStar and Color(0.3686274509803922, 0.5372549019607843, 0.7058823529411765) or Color(0.14901960784313725, 0.25882352941176473, 0.47058823529411764))
    self._mapNode.Conditions_[2]:SetActive(true)
  else
  end
end

function RogueBossSelectCtrl:RefreshReengagementCount()
  local nReengagementCount = PlayerData.Reengagement:GetDoubleDropCount()
  local str = ConfigTable.GetUIText("Reengagement_DoubleDrop_LevelTip") .. ":"
  NovaAPI.SetTMPText(self._mapNode.txtReengagementDoubleDrop, str)
  local nMaxCount = PlayerData.Reengagement:GetMaxDoubleDropCount()
  NovaAPI.SetTMPText(self._mapNode.txtReengagementDropCount, string.format("%s/%s", nReengagementCount, nMaxCount))
end

function RogueBossSelectCtrl:OnBtnClick_HardTog(btn)
  if self.regionType == GameEnum.RegionType.NormalRegion then
    local idx = table.indexof(self._mapNode.tog, btn)
    if self.curSelectHard ~= idx then
      self:RefreshLevelInfo(self.curGroupId, idx)
      self._mapNode.togCtrl[self.curSelectHard]:SetTrigger(false)
      self._mapNode.togCtrl[idx]:SetTrigger(true)
      self.curSelectHard = idx
      self._panel._tbParam[1] = self.curSelectHard
    end
  else
  end
end

function RogueBossSelectCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.bJumpTo or self.curState == 1 then
    EventManager.Hit(EventId.CloesCurPanel)
  else
    self.animatorRoot.enabled = true
    self._mapNode.rtBossList:SetActive(true)
    self._mapNode.rtBossInfo:SetActive(false)
    self._mapNode.BG2.gameObject:SetActive(false)
    self:PlayAnim("RogueBossSelect_default")
    
    local function wait()
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
      self._mapNode.svList.gameObject:SetActive(true)
    end
    
    cs_coroutine.start(wait)
    self.curSelectHard = GameEnum.diffculty.Diffculty_1
    self.curGroupId = 0
    self.curState = 1
    self._panel._tbParam[1] = 0
    self._panel._tbParam[2] = 0
  end
end

function RogueBossSelectCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  self._panel._tbParam[1] = 0
  self._panel._tbParam[2] = 0
  PanelManager.Home()
end

function RogueBossSelectCtrl:OnEvent_UpdateEnergy(btn)
  if self.curState == 2 then
    local mapRogueBossLevel = self.mapAllLevel[self.curGroupId][self.curSelectHard]
    if mapRogueBossLevel ~= nil and mapRogueBossLevel.RegionType == GameEnum.RegionType.NormalRegion then
      local nRequire = mapRogueBossLevel.EnergyConsume
      local nHas = PlayerData.Base:GetCurEnergy()
      NovaAPI.SetTMPText(self._mapNode.txtTicketsCount, nRequire)
      NovaAPI.SetTMPColor(self._mapNode.txtTicketsCount, nRequire > nHas.nEnergy and Red_Unable or Blue_Normal)
    else
    end
  end
end

function RogueBossSelectCtrl:OnEvent_SelectRogueBossItem(mapBossData)
  if mapBossData == nil then
    return
  end
  local bOpen = PlayerData.RogueBoss:CheckLevelOpen(mapBossData.Id, nil, true)
  if not bOpen then
    return
  end
  CS.WwiseAudioManager.Instance:PlaySound("ui_rogueBoss_panel_select")
  self.curState = 2
  local nHard = PlayerData.RogueBoss:GetMaxHard(mapBossData.Id)
  self:RefreshLevelInfo(mapBossData.Id, nHard)
  self._panel._tbParam[1] = nHard
  self._panel._tbParam[2] = mapBossData.Id
  self.curSelectHard = nHard
  self.curGroupId = mapBossData.Id
  EventManager.Hit(EventId.TemporaryBlockInput, 0.36)
  self:AddTimer(1, 0.36, function(...)
    self:PlayAnim("RogueBossSelect_out")
    self._mapNode.svList.gameObject:SetActive(false)
  end, true, true, true)
  self:AddTimer(1, 1.2, function(...)
    EventManager.Hit("Guide_OpenRogueBossInfo")
  end, true, true, true)
  self:SetTogList(nHard)
end

function RogueBossSelectCtrl:SetTogList(nHard)
  if self.regionType == GameEnum.RegionType.NormalRegion then
    self._mapNode.rt_Toggle:SetActive(true)
    local nToggleY = 6 < nHard and 295 or 0
    self._mapNode.rt_Toggle.transform.localPosition = Vector3(self._mapNode.rt_Toggle.transform.localPosition.x, nToggleY, self._mapNode.rt_Toggle.transform.localPosition.z)
    if nHard ~= 0 then
      for i = 1, 10 do
        self._mapNode.togCtrl[i]:SetDefault(nHard == mapToggle[i])
      end
    end
    self.tbLockWorldClass = {}
    local tmpCount = #self.mapAllLevel[self.curGroupId]
    for i = 1, tmpCount do
      if self.mapAllLevel[self.curGroupId][i] == nil then
        self._mapNode.togCtrl[i].gameObject:SetActive(false)
      else
        self._mapNode.togCtrl[i].gameObject:SetActive(true)
        local bUnlock, nWorldClass = PlayerData.RogueBoss:GetUnlockRogueBoss(self.curGroupId, mapToggle[i])
        self.tbLockWorldClass[i] = nWorldClass
        self._mapNode.imgLockMask[i].gameObject:SetActive(false)
        self._mapNode.rt_Targets[i]:SetActive(bUnlock)
        self._mapNode.rt_LockMsg[i]:SetActive(not bUnlock)
        local tmpTitle = self._mapNode.tog[i].gameObject.transform:Find("AnimRoot/AnimSwitch/txt_Select"):GetComponent("TMP_Text")
        local tmpTitleUnselect = self._mapNode.tog[i].gameObject.transform:Find("AnimRoot/AnimSwitch/txt_unSelect"):GetComponent("TMP_Text")
        local sKey = "Diffculty_" .. mapToggle[i]
        NovaAPI.SetTMPText(tmpTitle, ConfigTable.GetUIText(sKey))
        NovaAPI.SetTMPText(tmpTitleUnselect, ConfigTable.GetUIText(sKey))
        local mapRogueBossLevel = self.mapAllLevel[self.curGroupId][mapToggle[i]]
        local mapLevelInfo = PlayerData.RogueBoss:GetCacheBossLevelMsg(mapRogueBossLevel.Id)
        local curStar = 0
        if mapLevelInfo ~= nil then
          curStar = mapLevelInfo.Star
        end
        for j = 1, 3 do
          local btnStar = self._mapNode.rt_Targets[i].gameObject.transform:Find("btnTarget" .. j):GetComponent("Button")
          btnStar.interactable = j <= curStar
        end
        local mapRogueBossLevel = self.mapAllLevel[self.curGroupId][mapToggle[i]]
        if not bUnlock then
          if nHard == i then
            self._mapNode.togCtrl[i]:SetDefault(false)
          end
          if self.tbLockWorldClass[i] ~= nil then
            NovaAPI.SetTMPText(self._mapNode.txtLockCondition[i], orderedFormat(ConfigTable.GetUIText("RegusBoss_Unlock_LvHand"), mapRogueBossLevel.NeedWorldClass))
          else
            NovaAPI.SetTMPText(self._mapNode.txtLockCondition[i], ConfigTable.GetUIText("Unlocked_By_PreLevel"))
          end
        end
      end
    end
  else
  end
end

function RogueBossSelectCtrl:OnEvent_UpdateWorldClass()
  self:SetTogList(0)
end

function RogueBossSelectCtrl:OnEvent_StartLoopScrollSnap(snapTime)
  self.bStartSnap = true
  self:AddTimer(1, snapTime, function()
    self.bStartSnap = false
  end, true, true, true)
end

function RogueBossSelectCtrl:OnEvent_StartDragLoopScrollSnap()
  self.bStartSnap = true
end

function RogueBossSelectCtrl:PlayAnim(AnimName)
  self.animatorRoot:Play(AnimName)
  local nAnimLength = NovaAPI.GetAnimClipLength(self.animatorRoot, {AnimName})
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLength)
end

function RogueBossSelectCtrl:OnClickBtnCrusade()
  PlayerData.RogueBoss:SetSelBuildId(0)
  local mapRogueBossLevel = self.mapAllLevel[self.curGroupId][self.curSelectHard]
  if mapRogueBossLevel.RegionType == GameEnum.RegionType.NormalRegion then
    local nEnergy = PlayerData.Base:GetCurEnergy().nEnergy
    if nEnergy < mapRogueBossLevel.EnergyConsume then
      local function callback()
        EventManager.Hit(EventId.ClosePanel, PanelId.EnergyBuy)
      end
      
      EventManager.Hit(EventId.OpenPanel, PanelId.EnergyBuy, AllEnum.EnergyPanelType.Main, {}, true, callback)
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineData_Energy"))
      return
    end
  else
  end
  if not PlayerData.RogueBoss:GetUnlockRogueBoss(self.curGroupId, self.curSelectHard) then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("RegusBoss_Unlock"))
    return
  end
  PlayerData.RogueBoss:SetSelLvId(mapRogueBossLevel.Id)
  
  local function OpenPanel()
    local nMaxHard = PlayerData.RogueBoss:GetMaxHard(self.curGroupId)
    PlayerData.RogueBoss:SetLastMaxHard(self.curGroupId, nMaxHard)
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.RegionBoss)
    self._panel._tbParam[1] = mapRogueBossLevel.diffculty
  end
  
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  PlayerData.RogueBoss:SetIsUnlock(false)
end

function RogueBossSelectCtrl:OnClickBtnRaid()
  if self.curStar ~= 3 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Raid_Lock"))
    return
  end
  local mapRogueBossLevel = self.mapAllLevel[self.curGroupId][self.curSelectHard]
  local nNeedEnergy = mapRogueBossLevel.EnergyConsume
  EventManager.Hit(EventId.OpenPanel, PanelId.Raid, mapRogueBossLevel.Id, nNeedEnergy, GameEnum.instanceType.RegionBoss)
end

function RogueBossSelectCtrl:OnBtnClick_Lock()
  self:OnBtnClick_TogTips(nil, self.SelectDifficult)
end

function RogueBossSelectCtrl:OnBtnClick_Reward(btn, nidx)
  if self.tbAfterReward[nidx] == nil then
    return
  end
  local nTid = self.tbAfterReward[nidx][1]
  if nTid == nil then
    return
  end
  local rtBtn = self._mapNode.item[nidx].gameObject.transform
  UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
end

function RogueBossSelectCtrl:OnBtnClick_ExtraDropReward(btn)
  if self.tbExtraDropReward == nil then
    return
  end
  local nTid = self.tbExtraDropReward[1]
  if nTid == nil then
    return
  end
  local rtBtn = btn.transform:Find("AnimRoot")
  UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
end

function RogueBossSelectCtrl:OnBtnClick_Skill(btn, nidx)
  local mapRogueBossLevel = self.mapAllLevel[self.curGroupId][self.curSelectHard]
  local sName = "EntryGroupId" .. nidx
  local nSkillId = mapRogueBossLevel[sName]
  if nSkillId ~= 0 then
    local mapData = {
      nSkillId = nSkillId,
      bMonster = true,
      bBoss = true
    }
    EventManager.Hit(EventId.OpenPanel, PanelId.SkillTips, btn.transform, mapData)
  end
end

function RogueBossSelectCtrl:OnBtnClick_AllReward(btn)
  local tbExtraDropReward
  if #self.tbExtraDropReward > 0 then
    tbExtraDropReward = {}
    tbExtraDropReward[1] = self.tbExtraDropReward[1]
    tbExtraDropReward[2] = 1
    tbExtraDropReward[3] = 0
  end
  self._mapNode.goRewardList:OpenPanel(self.tbReward, tbExtraDropReward)
end

function RogueBossSelectCtrl:OnBtnClick_TogTips(btn, nIndex)
  if self.tbLockWorldClass[nIndex] then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("LevelSelect_LimitTipsWorldClass"), self.tbLockWorldClass[nIndex]))
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("LevelSelect_LimitTips"))
  end
end

function RogueBossSelectCtrl:OnBtnClick_Left()
end

function RogueBossSelectCtrl:OnBtnClick_Right()
end

function RogueBossSelectCtrl:OnBtnClick_ChangeType()
  self.isHandCoreType = not self.isHandCoreType
  self:SetRegionType()
  self:SetTopBar()
  self:SetSvList()
  self:SetBgImg()
  PlayerData.RogueBoss:SetSelectRegionType(self.isHandCoreType)
end

function RogueBossSelectCtrl:SetRegionType()
  self.regionType = GameEnum.RegionType.NormalRegion
  self._mapNode.goOff.gameObject:SetActive(not self.isHandCoreType)
  self._mapNode.goOpen.gameObject:SetActive(self.isHandCoreType)
end

function RogueBossSelectCtrl:SetTopBar()
  if self.regionType == GameEnum.RegionType.NormalRegion then
    self._mapNode.TopBarPanel:ShowGoEnergy(true)
    self._mapNode.TopBarPanel:ShowGoBossTick(false)
    self._mapNode.goBossTick:SetActive(false)
  else
  end
end

function RogueBossSelectCtrl:SetSvList()
  self.tbAllBoss = {}
  
  local function forEachRegoinBoss(mapData)
    if mapData.RegionType == self.regionType then
      table.insert(self.tbAllBoss, mapData)
    end
  end
  
  ForEachTableLine(DataTable.RegionBoss, forEachRegoinBoss)
  
  local function sortBoss(a, b)
    return a.Sort < b.Sort
  end
  
  table.sort(self.tbAllBoss, sortBoss)
  for i = 1, #self.tbAllBoss do
    local objItem
    if i > self._mapNode.ContentTemp.childCount then
      objItem = instantiate(self._mapNode.gridTemp, self._mapNode.ContentTemp)
    else
      objItem = self._mapNode.ContentTemp:GetChild(i - 1).gameObject
    end
    objItem.gameObject.name = "gridTemp" .. i
    objItem:SetActive(true)
    self:OnRefreshGrid(objItem, i - 1)
  end
  if self.isInit then
    EventManager.Hit(EventId.TemporaryBlockInput, 0.5)
  else
    self.isInit = true
  end
end

function RogueBossSelectCtrl:SetBgImg()
  self:SetPngSprite(self._mapNode.BG1, "Image/UIBG/bg_stage_01")
  self._mapNode.FXNormal:SetActive(true)
  self._mapNode.FXHard:SetActive(false)
end

function RogueBossSelectCtrl:RefreshDoubleDropCount()
  if self.actData ~= nil and self.actData:CheckActShow() and self.actData:CheckInstanceType(GameEnum.instanceType.RegionBoss) then
    local _, str = self.actData:GetDropString()
    local nCount, nMaxCount = self.actData:GetDoubleDropsTimes()
    NovaAPI.SetTMPText(self._mapNode.txtDoubleDrop, str)
    NovaAPI.SetTMPText(self._mapNode.txtDoubleDropCount, string.format("%s/%s", nMaxCount - nCount, nMaxCount))
  end
end

function RogueBossSelectCtrl:OnEvent_RaidSuccess()
  self:RefreshDoubleDropCount()
  self:RefreshReengagementCount()
end

function RogueBossSelectCtrl:OnBtnClick_BossTick(btn)
  local curCoinItmeId = AllEnum.CoinItemId.RogueHardCoreTick
  if 0 <= curCoinItmeId then
    local bShowJumpto = true
    if self.bForceHide then
      bShowJumpto = false
    end
    UTILS.ClickItemGridWithTips(curCoinItmeId, btn.transform, true, true, bShowJumpto)
  end
end

return RogueBossSelectCtrl
