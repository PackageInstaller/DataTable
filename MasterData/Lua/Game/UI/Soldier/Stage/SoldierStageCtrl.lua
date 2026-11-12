local SoldierStageCtrl = class("SoldierStageCtrl", BaseCtrl)
local WwiseAudioMgr = CS.WwiseAudioManager.Instance
local AssetRoot = "Icon/SoldierOtherIcon/"
local STAGE_COUNT = 3
local NODE_MAX = 7
SoldierStageCtrl._mapNodeConfig = {
  Bg = {nCount = 3},
  goStage = {},
  goProgress = {},
  ImageLine = {nCount = 2},
  ImgNml = {nCount = 3},
  ImgDone = {nCount = 3},
  ImageDoneLock = {nCount = 3},
  txtNmlTitle = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Stage_Title"
  },
  txtNmlNum = {nCount = 3, sComponentName = "TMP_Text"},
  txtDoneTitle = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Stage_Title"
  },
  txtDoneNum = {nCount = 3, sComponentName = "TMP_Text"},
  ItemProgress = {nCount = 7},
  goChallenge = {},
  txtChallenge = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Stage_CheckStage"
  },
  txtChoose = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Stage_Tips"
  },
  txtBlank = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Stage_Click_Tips"
  },
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
SoldierStageCtrl._mapEventConfig = {}
SoldierStageCtrl._mapRedDotConfig = {}

function SoldierStageCtrl:Awake()
end

function SoldierStageCtrl:OnEnable()
  self.animRoot = self.gameObject:GetComponent("Animator")
  local param = self:GetPanelParam()
  self.bIsChallenge = false
  self.nStageId = 1
  self.nCurNodeId = 0
  self.fnCallback = nil
  if type(param) == "table" then
    self.bIsChallenge = param[1] and true or false
    self.nStageId = param[2] or 1
    self.nCurNodeId = param[3] or 0
    self.fnCallback = param[4]
  end
  self:Refresh()
end

function SoldierStageCtrl:OnDisable()
end

function SoldierStageCtrl:OnDestroy()
end

function SoldierStageCtrl:Refresh()
  self._mapNode.goStage:SetActive(not self.bIsChallenge)
  self._mapNode.goProgress:SetActive(not self.bIsChallenge)
  self._mapNode.goChallenge:SetActive(self.bIsChallenge)
  if self.bIsChallenge then
    self:RefreshBg(self.nStageId, self.nStageId)
    local nAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
      "SoldierStagePanelChallenge_in"
    })
    self.animRoot:Play("SoldierStagePanelChallenge_in", 0, 0)
    EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
    return
  end
  local sAnim, nFromStage = self:_GetStageTransition()
  self:RefreshBg(nFromStage, nFromStage)
  self:RefreshStage(nFromStage, nFromStage)
  self:RefreshProgress()
  local nAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {
    "SoldierStagePanel_in"
  })
  self.animRoot:Play("SoldierStagePanel_in", 0, 0)
  EventManager.Hit(EventId.TemporaryBlockInput, nAnimLen)
  if sAnim ~= nil then
    self:AddTimer(1, nAnimLen, function()
      if self.nStageId == nFromStage then
        WwiseAudioMgr:PostEvent("mode_900001_chess_result_stage")
      else
        WwiseAudioMgr:PostEvent("mode_900001_chess_result_stage_levelUp")
      end
      self:RefreshBg(nFromStage, self.nStageId)
      self:RefreshStage(nFromStage, self.nStageId)
      self.animRoot:Play(sAnim, 0, 0)
      local nStageAnimLen = NovaAPI.GetAnimClipLength(self.animRoot, {sAnim})
      EventManager.Hit(EventId.TemporaryBlockInput, nStageAnimLen)
    end, true, true, true)
  end
end

function SoldierStageCtrl:_GetStageTransition()
  local nTotal = math.min(self:GetTotalStageCount(), STAGE_COUNT)
  if 3 <= nTotal and self.nStageId == 2 then
    return "SoldierStagePanel_1To2", 1
  end
  if 3 <= nTotal and self.nStageId == 3 then
    return "SoldierStagePanel_2To3", 2
  end
  return nil, self.nStageId
end

function SoldierStageCtrl:RefreshBg(nFromStage, nToStage)
  if self.bIsChallenge then
    for i = 1, STAGE_COUNT do
      self._mapNode.Bg[i]:SetActive(i == STAGE_COUNT)
    end
    return
  end
  for i = 1, STAGE_COUNT do
    self._mapNode.Bg[i]:SetActive(i == nFromStage or i == nToStage)
  end
end

function SoldierStageCtrl:RefreshStage(nFromStage, nToStage)
  local nTotal = math.min(self:GetTotalStageCount(), STAGE_COUNT)
  local tbSlotToStage = {}
  if 3 <= nTotal then
    tbSlotToStage[1] = 1
    tbSlotToStage[2] = 2
    tbSlotToStage[3] = 3
  elseif nTotal == 2 then
    if 1 >= self.nStageId then
      tbSlotToStage[2] = 1
      tbSlotToStage[3] = 2
    else
      tbSlotToStage[1] = 1
      tbSlotToStage[2] = 2
    end
  else
    tbSlotToStage[2] = 1
  end
  for k = 1, STAGE_COUNT do
    local nSlotStage = tbSlotToStage[k]
    if nSlotStage == nil then
      self._mapNode.ImgNml[k]:SetActive(false)
      self._mapNode.ImgDone[k]:SetActive(false)
      self._mapNode.ImageDoneLock[k]:SetActive(false)
    else
      local bCurFrom = nSlotStage == nFromStage
      local bCurTo = nSlotStage == nToStage
      local bDoneFrom = nFromStage > nSlotStage
      local bDoneTo = nToStage > nSlotStage
      self._mapNode.ImgNml[k]:SetActive(not bCurFrom or not bCurTo)
      self._mapNode.ImgDone[k]:SetActive(bCurFrom or bCurTo)
      self._mapNode.ImageDoneLock[k]:SetActive(bDoneFrom or bDoneTo)
      NovaAPI.SetTMPText(self._mapNode.txtNmlNum[k], tostring(nSlotStage))
      NovaAPI.SetTMPText(self._mapNode.txtDoneNum[k], tostring(nSlotStage))
    end
  end
  self._mapNode.ImageLine[1]:SetActive(tbSlotToStage[1] ~= nil and tbSlotToStage[2] ~= nil)
  self._mapNode.ImageLine[2]:SetActive(tbSlotToStage[2] ~= nil and tbSlotToStage[3] ~= nil)
end

function SoldierStageCtrl:GetTotalStageCount()
  local levelData = PlayerData.SoldierData:GetCurLevelData()
  if levelData == nil then
    return 1
  end
  local mapChallengeCfg = ConfigTable.GetData("SoldierGradeChallenge", levelData.nGradeChallengeId)
  if mapChallengeCfg == nil then
    return 1
  end
  local tbAllNodeList = CacheTable.GetData("_SoldierNodePlan", mapChallengeCfg.NodeGroupId)
  if tbAllNodeList == nil then
    return 1
  end
  local nMax = 0
  for _, v in ipairs(tbAllNodeList) do
    if nMax < v.Stage then
      nMax = v.Stage
    end
  end
  return math.max(1, nMax)
end

function SoldierStageCtrl:RefreshProgress()
  local tbNodeList = self:GetStageNodeList()
  local nCount = math.min(#tbNodeList, NODE_MAX)
  for i = 1, NODE_MAX do
    local goItem = self._mapNode.ItemProgress[i]
    if i > nCount then
      goItem:SetActive(false)
    else
      goItem:SetActive(true)
      local nodeData = tbNodeList[i]
      local trItem = goItem.transform
      local bBoss = nodeData.nNodeType == GameEnum.soldierNodeType.MidBossBattle or nodeData.nNodeType == GameEnum.soldierNodeType.FinalBossBattle
      local sRoot = bBoss and "goBoss" or "goNormal"
      local trNormal = trItem:Find("goNormal")
      local trBoss = trItem:Find("goBoss")
      if trNormal ~= nil then
        trNormal.gameObject:SetActive(not bBoss)
      end
      if trBoss ~= nil then
        trBoss.gameObject:SetActive(bBoss)
      end
      local trRoot = trItem:Find(sRoot)
      local imgIcon = trRoot:Find("ImgProgressNml/ImageNmlIcon"):GetComponent("Image")
      local cfg = AllEnum.SoliderNoteTypeCfg[nodeData.nNodeType]
      if cfg ~= nil then
        self:SetPngSprite(imgIcon, AssetRoot .. cfg.Icon)
      end
      local bNotLast = i < nCount
      local trLine1 = trRoot:Find("ImgProgressNml/ImageNmlline1")
      local trLine2 = trRoot:Find("ImgProgressNml/ImageNmlline2")
      if trLine1 ~= nil then
        trLine1.gameObject:SetActive(bNotLast)
      end
      if trLine2 ~= nil then
        trLine2.gameObject:SetActive(bNotLast)
      end
      local trSel = trRoot:Find("ImgProgressSel")
      if trSel ~= nil then
        trSel.gameObject:SetActive(nodeData.nNodeId == self.nCurNodeId)
      end
    end
  end
end

function SoldierStageCtrl:GetStageNodeList()
  local levelData = PlayerData.SoldierData:GetCurLevelData()
  if levelData ~= nil and levelData.nStageId == self.nStageId then
    return levelData:GetNodeList() or {}
  end
  local tbList = {}
  if levelData == nil then
    return tbList
  end
  local mapChallengeCfg = ConfigTable.GetSData("SoldierGradeChallenge", levelData.nGradeChallengeId)
  if mapChallengeCfg == nil then
    return tbList
  end
  local tbAllNodeList = CacheTable.GetData("_SoldierNodePlan", mapChallengeCfg.NodeGroupId)
  if tbAllNodeList == nil then
    return tbList
  end
  for _, v in ipairs(tbAllNodeList) do
    if v.Stage == self.nStageId then
      table.insert(tbList, {
        nNodeId = v.Id,
        nIndex = v.Index,
        nNodeType = v.NodeType
      })
    end
  end
  table.sort(tbList, function(a, b)
    return a.nIndex < b.nIndex
  end)
  return tbList
end

function SoldierStageCtrl:OnBtnClick_Close()
  if self.fnCallback ~= nil then
    self.fnCallback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.SoldierStagePanel)
end

return SoldierStageCtrl
