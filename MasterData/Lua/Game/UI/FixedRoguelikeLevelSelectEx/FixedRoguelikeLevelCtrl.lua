local FixedRoguelikeLevelCtrl = class("FixedRoguelikeLevelCtrl", BaseCtrl)
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local mapToggle = {
  [1] = GameEnum.diffculty.Diffculty_1,
  [2] = GameEnum.diffculty.Diffculty_2,
  [3] = GameEnum.diffculty.Diffculty_3,
  [4] = GameEnum.diffculty.Diffculty_4
}
FixedRoguelikeLevelCtrl._mapNodeConfig = {
  bgLevelInfo = {sNodeName = "----Bg----"},
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  rt_RoguelkeSelect = {},
  rt_RoguelkeInfo = {},
  btnGo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  svRogulike = {
    sComponentName = "LoopScrollView"
  },
  imgElementInfo = {sComponentName = "Image", nCount = 3},
  TMPRoguelikeDesc = {sComponentName = "TMP_Text"},
  TMPRoguelikeName = {sComponentName = "TMP_Text"},
  txtRecommendLevel = {sComponentName = "TMP_Text"},
  ImgRoguelikeInfo = {sComponentName = "Image"},
  item = {
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl",
    nCount = 6
  },
  ItemBtn = {
    sComponentName = "UIButton",
    nCount = 6,
    callback = "OnBtnClick_RewardItem"
  },
  tog = {
    sComponentName = "UIButton",
    nCount = 4,
    callback = "OnBtnClick_Tog"
  },
  imgLockMask = {
    sComponentName = "Button",
    callback = "OnBtnClick_TogTips",
    nCount = 4
  },
  togCtrl = {
    sNodeName = "tog",
    sCtrlName = "Game.UI.TemplateEx.TemplateToggleCtrl",
    nCount = 4
  },
  TopBarPanel = {
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  AnimCtrl = {
    sComponentName = "Animator",
    sNodeName = "----SafeAreaRoot----"
  },
  goEnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  goRewardList = {
    sCtrlName = "Game.UI.MainlineEx.RewardListCtrl"
  },
  btnEnemyInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnemyInfo"
  },
  btnAllReward = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardList"
  },
  txtEnergyCount = {sComponentName = "TMP_Text"}
}
FixedRoguelikeLevelCtrl._mapEventConfig = {
  [EventId.UIHomeConfirm] = "OnEvent_Home",
  [EventId.UIBackConfirm] = "OnEvent_Back"
}

function FixedRoguelikeLevelCtrl:Awake()
  self:RefreshTogText()
end

function FixedRoguelikeLevelCtrl:FadeIn()
end

function FixedRoguelikeLevelCtrl:FadeOut()
end

function FixedRoguelikeLevelCtrl:OnEnable()
  local tbParam = self:GetPanelParam()
  if 0 < #tbParam then
    if tbParam[3] == nil then
    end
    self.bJumpto = tbParam[3]
    self.nJumptoHard = tbParam[1] == nil and 0 or tbParam[1]
    self.nJumptoGroup = tbParam[2] == nil and 0 or tbParam[2]
  end
  self._mapNode.rt_RoguelkeSelect:SetActive(true)
  self._mapNode.rt_RoguelkeInfo:SetActive(false)
  self._mapNode.bgLevelInfo:SetActive(false)
  self._mapNode.rawImgActor2D.gameObject:SetActive(true)
  self.curState = 1
  self.curRogueHard = GameEnum.diffculty.Diffculty_1
  self.nCurGroupId = 0
  self.mapAllRoguelike = {}
  self.tbRoguelikeGroup = {}
  
  local function forEachRoguelike(mapData)
    if self.mapAllRoguelike[mapData.GroupId] == nil then
      self.mapAllRoguelike[mapData.GroupId] = {}
      table.insert(self.tbRoguelikeGroup, mapData.GroupId)
    end
    self.mapAllRoguelike[mapData.GroupId][mapData.Difficulty] = mapData
  end
  
  ForEachTableLine(DataTable.FixedRoguelike, forEachRoguelike)
  
  local function sortGroup(a, b)
    local mapDataA = ConfigTable.GetData("FixedRoguelikeGroup", a)
    local mapDataB = ConfigTable.GetData("FixedRoguelikeGroup", b)
    return mapDataA.Sort < mapDataB.Sort
  end
  
  table.sort(self.tbRoguelikeGroup, sortGroup)
  self._mapNode.svRogulike:Init(#self.tbRoguelikeGroup, self, self.RefreshGrid, self.OnBtnClick_Grid)
  if self.nJumptoGroup ~= 0 and self.nJumptoGroup ~= nil then
    if self.nJumptoHard ~= 0 and self.nJumptoHard ~= nil then
      self:OpenJumptoHard()
    else
      self:OpenJumptoGroup()
    end
  end
  Actor2DManager.SetBoardNPC2D(self:GetPanelId(), self._mapNode.rawImgActor2D, 9102)
end

function FixedRoguelikeLevelCtrl:OnDisable()
  Actor2DManager.UnsetBoardNPC2D()
end

function FixedRoguelikeLevelCtrl:OnDestroy()
end

function FixedRoguelikeLevelCtrl:OnRelease()
end

function FixedRoguelikeLevelCtrl:RefreshTogText()
  for k, v in pairs(mapToggle) do
    self._mapNode.togCtrl[k]:SetText(ConfigTable.GetUIText("Diffculty_" .. k))
  end
end

function FixedRoguelikeLevelCtrl:RefreshGrid(goGrid, gridIndex)
  local nIdx = gridIndex + 1
  local mapRoguelikeGroupId = self.tbRoguelikeGroup[nIdx]
  local mapRoguelike = self.mapAllRoguelike[mapRoguelikeGroupId][GameEnum.diffculty.Diffculty_1]
  local mapRoguelikeGroup = ConfigTable.GetData("FixedRoguelikeGroup", mapRoguelikeGroupId)
  if mapRoguelike == nil then
    return
  end
  local tmpName = goGrid.transform:Find("btnGrid/AnimRoot/TMPRogelikeName"):GetComponent("TMP_Text")
  local imgLevelImage = goGrid.transform:Find("btnGrid/AnimRoot/imgLevelImage"):GetComponent("Image")
  local goLockMask = goGrid.transform:Find("btnGrid/AnimRoot/goMask").gameObject
  local bLock = PlayerData.PlayerFixedRoguelikeData:IsRoguelikeUnlock(mapRoguelike.Id)
  goLockMask:SetActive(not bLock)
  NovaAPI.SetTMPText(tmpName, mapRoguelikeGroup.Name)
  self:SetPngSprite(imgLevelImage, mapRoguelikeGroup.Episode)
  for i = 1, 3 do
    local sRtName = "imgElement" .. i
    local imgElement = goGrid.transform:Find("btnGrid/AnimRoot/rtElements/" .. sRtName):GetComponent("Image")
    if mapRoguelikeGroup.EET == nil or mapRoguelikeGroup.EET[i] == nil then
      imgElement.gameObject:SetActive(false)
    else
      imgElement.gameObject:SetActive(true)
      self:SetAtlasSprite(imgElement, "12_rare", AllEnum.ElementIconType.Icon .. mapRoguelikeGroup.EET[i])
    end
  end
end

function FixedRoguelikeLevelCtrl:OpenJumptoGroup()
  self.curState = 2
  self._mapNode.AnimCtrl:Play("rougelikelevelselect_go_info")
  self._mapNode.bgLevelInfo:SetActive(true)
  self._mapNode.rawImgActor2D.gameObject:SetActive(false)
  self.nCurGroupId = self.nJumptoGroup
  for index, hardBtn in ipairs(self._mapNode.tog) do
    local bActive = self.mapAllRoguelike[self.nCurGroupId][mapToggle[index]] ~= nil
    hardBtn.gameObject:SetActive(bActive)
    if bActive then
      local nRoguelikeId = self.mapAllRoguelike[self.nCurGroupId][mapToggle[index]].Id
      local bLock = PlayerData.PlayerFixedRoguelikeData:IsRoguelikeUnlock(nRoguelikeId)
      hardBtn.interactable = bLock
      self._mapNode.imgLockMask[index].gameObject:SetActive(not bLock)
      self._mapNode.imgLockMask[index].interactable = not bLock
    end
  end
  self:RefreshRoguelikeInfo(self.nCurGroupId, GameEnum.diffculty.Diffculty_1)
end

function FixedRoguelikeLevelCtrl:OpenJumptoHard()
  self.curState = 2
  self._mapNode.AnimCtrl:Play("rougelikelevelselect_go_info")
  self._mapNode.bgLevelInfo:SetActive(true)
  self._mapNode.rawImgActor2D.gameObject:SetActive(false)
  self.nCurGroupId = self.nJumptoGroup
  local nJumptoRoguelikeId = self.mapAllRoguelike[self.nCurGroupId][self.nJumptoHard].Id
  if not PlayerData.PlayerFixedRoguelikeData:IsRoguelikeUnlock(nJumptoRoguelikeId) then
    self.nJumptoHard = GameEnum.diffculty.Diffculty_1
  end
  for index, hardBtn in ipairs(self._mapNode.tog) do
    local bActive = self.mapAllRoguelike[self.nCurGroupId][mapToggle[index]] ~= nil
    hardBtn.gameObject:SetActive(bActive)
    if bActive then
      local nRoguelikeId = self.mapAllRoguelike[self.nCurGroupId][mapToggle[index]].Id
      local bLock = PlayerData.PlayerFixedRoguelikeData:IsRoguelikeUnlock(nRoguelikeId)
      hardBtn.interactable = bLock
      self._mapNode.imgLockMask[index].gameObject:SetActive(not bLock)
      self._mapNode.imgLockMask[index].interactable = not bLock
    end
  end
  self:RefreshRoguelikeInfo(self.nCurGroupId, self.nJumptoHard)
end

function FixedRoguelikeLevelCtrl:OnBtnClick_Grid(goGrid, gridIndex)
  local nIdx = gridIndex + 1
  local nRoguelikeGroupId = self.tbRoguelikeGroup[nIdx]
  local mapRoguelike = self.mapAllRoguelike[nRoguelikeGroupId][GameEnum.diffculty.Diffculty_1]
  local bGridUnlock = PlayerData.PlayerFixedRoguelikeData:IsRoguelikeUnlock(mapRoguelike.Id)
  if not bGridUnlock then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("LevelSelect_NotOpen"))
    return
  end
  self.curState = 2
  self._mapNode.AnimCtrl:Play("rougelikelevelselect_go_info")
  self._mapNode.bgLevelInfo:SetActive(true)
  self._mapNode.rawImgActor2D.gameObject:SetActive(false)
  self.nCurGroupId = nRoguelikeGroupId
  self._panel._tbParam[2] = nRoguelikeGroupId
  local nHard = PlayerData.PlayerFixedRoguelikeData:GetMaxDifficult(self.nCurGroupId)
  for index, hardBtn in ipairs(self._mapNode.tog) do
    local bActive = self.mapAllRoguelike[nRoguelikeGroupId][mapToggle[index]] ~= nil
    hardBtn.gameObject:SetActive(bActive)
    if bActive then
      local nRoguelikeId = self.mapAllRoguelike[self.nCurGroupId][mapToggle[index]].Id
      local bLock = PlayerData.PlayerFixedRoguelikeData:IsRoguelikeUnlock(nRoguelikeId)
      hardBtn.interactable = bLock
      self._mapNode.imgLockMask[index].gameObject:SetActive(not bLock)
      self._mapNode.imgLockMask[index].interactable = not bLock
    end
  end
  self:RefreshRoguelikeInfo(nRoguelikeGroupId, nHard)
end

function FixedRoguelikeLevelCtrl:RefreshRoguelikeInfo(nGroupId, nHard)
  for i = 1, 4 do
    self._mapNode.togCtrl[i]:SetDefault(i == nHard)
  end
  self.curRogueHard = nHard
  self._panel._tbParam[1] = self.curRogueHard
  local mapRoguelike = self.mapAllRoguelike[nGroupId][nHard]
  self.curRoguelikeId = mapRoguelike.Id
  if mapRoguelike == nil then
    return
  end
  NovaAPI.SetTMPText(self._mapNode.TMPRoguelikeName, mapRoguelike.Name)
  NovaAPI.SetTMPText(self._mapNode.TMPRoguelikeDesc, mapRoguelike.Desc)
  self:SetPngSprite(self._mapNode.ImgRoguelikeInfo, mapRoguelike.Image)
  local nRequire = mapRoguelike.NeedEnergy
  local nHas = PlayerData.Base:GetCurEnergy()
  NovaAPI.SetTMPText(self._mapNode.txtEnergyCount, nRequire)
  NovaAPI.SetTMPColor(self._mapNode.txtEnergyCount, nRequire > nHas.nEnergy and Red_Unable or Blue_Normal)
  for i = 1, 3 do
    if mapRoguelike.EET == nil or mapRoguelike.EET[i] == nil then
      self._mapNode.imgElementInfo[i].gameObject:SetActive(false)
    else
      self._mapNode.imgElementInfo[i].gameObject:SetActive(true)
      self:SetAtlasSprite(self._mapNode.imgElementInfo[i], "12_rare", AllEnum.ElementIconType.Icon .. mapRoguelike.EET[i])
    end
  end
  local tbReward = decodeJson(mapRoguelike.RewardPreview)
  self.tbReward = tbReward
  for index = 1, 6 do
    self._mapNode.ItemBtn[index].interactable = self.tbAfterReward[index] ~= nil
    if tbReward[index] ~= nil then
      self._mapNode.item[index]:SetItem(tbReward[index][1], nil, nil, nil, tbReward[index][3] == 1, tbReward[index][3] == 2)
    else
      self._mapNode.item[index]:SetItem(nil)
    end
  end
  NovaAPI.SetTMPText(self._mapNode.txtRecommendLevel, mapRoguelike.Recommend)
end

function FixedRoguelikeLevelCtrl:OnEvent_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.bJumpto then
    EventManager.Hit(EventId.CloesCurPanel)
    return
  end
  if self.curState == 1 then
    EventManager.Hit(EventId.CloesCurPanel)
  else
    self._mapNode.AnimCtrl:Play("rougelikelevelselect_go_list")
    self._mapNode.bgLevelInfo:SetActive(false)
    self._mapNode.rawImgActor2D.gameObject:SetActive(true)
    self.curRogueHard = GameEnum.diffculty.Diffculty_1
    self.nCurGroupId = 0
    self.curState = 1
    self._panel._tbParam[2] = 0
    self._panel._tbParam[1] = 0
  end
end

function FixedRoguelikeLevelCtrl:OnEvent_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function FixedRoguelikeLevelCtrl:OnBtnClick_Go()
  local mapRoguelike = self.mapAllRoguelike[self.nCurGroupId][self.curRogueHard]
  local nNeedEnergy = mapRoguelike.NeedEnergy
  local nCurEnergy = PlayerData.Base:GetCurEnergy().nEnergy
  
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.MainlineFormation, AllEnum.FormationEnterType.FixedRoguelike, self.curRoguelikeId)
  end
  
  if nNeedEnergy <= nCurEnergy then
    EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
  else
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("MainlineData_Energy"))
  end
end

function FixedRoguelikeLevelCtrl:OnBtnClick_Tog(btn)
  local nHard = table.indexof(self._mapNode.tog, btn:GetComponent("UIButton"))
  local togIdx = table.indexof(self._mapNode.tog, btn)
  if nHard == nil then
    return
  end
  if self.curRogueHard ~= nHard then
    for idx, value in pairs(mapToggle) do
      if value == self.curRogueHard then
        self._mapNode.togCtrl[idx]:SetTrigger(false)
      end
    end
    self._mapNode.togCtrl[togIdx]:SetTrigger(true)
    self:RefreshRoguelikeInfo(self.nCurGroupId, nHard)
  end
end

function FixedRoguelikeLevelCtrl:OnBtnClick_EnemyInfo(btn)
  EventManager.Hit("OpenFixedRoguelikeMonsterInfo", self.curRoguelikeId)
end

function FixedRoguelikeLevelCtrl:OnBtnClick_RewardList(btn)
  local mapLevel = ConfigTable.GetData("FixedRoguelike", self.curRoguelikeId)
  local tbReward = decodeJson(mapLevel.RewardPreview)
  self._mapNode.goRewardList:OpenPanel(tbReward)
end

function FixedRoguelikeLevelCtrl:OnBtnClick_RewardItem(btn)
  local nIdx = table.indexof(self._mapNode.ItemBtn, btn)
  local mapLevel = ConfigTable.GetData("FixedRoguelike", self.curRoguelikeId)
  local tbReward = decodeJson(mapLevel.RewardPreview)
  local rtBtn = btn.transform:Find("AnimRoot")
  if tbReward[nIdx] ~= nil then
    local nTid = tbReward[nIdx][1]
    UTILS.ClickItemGridWithTips(nTid, rtBtn, false, true, false)
  end
end

function FixedRoguelikeLevelCtrl:OnBtnClick_TogTips(btn)
  EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FixedRoguelike_LimitTips"))
end

return FixedRoguelikeLevelCtrl
