local TravelerDuelChallengeInfoCtrl = class("TravelerDuelChallengeInfoCtrl", BaseCtrl)
local ConfigData = require("GameCore.Data.ConfigData")
local _, colorWhite = ColorUtility.TryParseHtmlString("#FFFFFF")
local _, colorGreen = ColorUtility.TryParseHtmlString("#ebffc3")
TravelerDuelChallengeInfoCtrl._mapNodeConfig = {
  txtTitleHard = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_AffixHardLevelTitle"
  },
  txtTitleAffix = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_SelectedAffixTitle"
  },
  gridAffix = {},
  rtAffixListContent = {sComponentName = "Transform"},
  ScrollView = {
    sNodeName = "svAffixSelect",
    sComponentName = "ScrollRect"
  },
  AffixPrefab = {},
  txtAffixSelectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_AffixSelectTitle"
  },
  txtAffixSelfSelectTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_AffixSelfSelectTitle"
  },
  ContentAffixSelect = {sComponentName = "Transform"},
  ContentAffixSelfSelect = {sComponentName = "Transform"},
  TMPTitleChallengeAttr = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_EnemyAttrTitle"
  },
  TMPTitleChallengeScore = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_ScoreTitle"
  },
  TMPChallengeAttr = {sComponentName = "TMP_Text"},
  TMPChallengeScore = {sComponentName = "TMP_Text"},
  TMPCurLevel = {sComponentName = "TMP_Text"},
  txtRecommendLevelChallenge = {sComponentName = "TMP_Text"},
  txtTitleRecommendTrekkerLevel = {
    sComponentName = "TMP_Text",
    sLanguageId = "TravelerDuel_RecommendLevelTitle"
  },
  imgElementInfoChallenge = {sComponentName = "Image", nCount = 3},
  imgChallengeCover = {sComponentName = "Transform"},
  btnGoChallenge = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Go"
  },
  txtBtnGoChallenge = {
    sComponentName = "TMP_Text",
    sLanguageId = "Maninline_Btn_Go"
  },
  btnClearSelect = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_ClearAllAffix"
  },
  txtClearSelect = {
    sComponentName = "TMP_Text",
    sLanguageId = "TD_ClearAffixTitle"
  },
  srAffixList = {
    sComponentName = "UIScrollToClick"
  },
  goEmpty = {},
  txtEmpty = {
    sComponentName = "TMP_Text",
    sLanguageId = "TDEmptyAffix"
  },
  TMPRecEleTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend"
  },
  TMPRecommendBuildTitleChallenge = {
    sComponentName = "TMP_Text",
    sLanguageId = "InfinityTower_Recommend_Construct"
  },
  imgReconmendBuildChallenge = {sComponentName = "Image"},
  btnEnemyInfoChallengeInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnemyInfo"
  }
}
TravelerDuelChallengeInfoCtrl._mapEventConfig = {}
TravelerDuelChallengeInfoCtrl._mapRedDotConfig = {}

function TravelerDuelChallengeInfoCtrl:Awake()
end

function TravelerDuelChallengeInfoCtrl:FadeIn()
end

function TravelerDuelChallengeInfoCtrl:FadeOut()
end

function TravelerDuelChallengeInfoCtrl:OnEnable()
end

function TravelerDuelChallengeInfoCtrl:OnDisable()
  if self._coroutineScroll ~= nil then
    cs_coroutine.stop(self._coroutineScroll)
    self._coroutineScroll = nil
  end
  self:ClearListGrids()
end

function TravelerDuelChallengeInfoCtrl:OnDestroy()
end

function TravelerDuelChallengeInfoCtrl:OnRelease()
end

function TravelerDuelChallengeInfoCtrl:Refresh(nLevelId, tbAllAffix, mapActData)
  self.mapActData = mapActData
  self.tbAllAffix = tbAllAffix
  self.tbEnemyAffix = {}
  self.tbSelfAffix = {}
  self:InitAffixData()
  self:ClearListGrids()
  local mapBossLevelData = ConfigTable.GetData("TravelerDuelBossLevel", nLevelId)
  if mapBossLevelData == nil then
    return
  end
  self.nLevelId = nLevelId
  local mapLevel = ConfigTable.GetData("TravelerDuelChallengeDifficulty", 0)
  if mapLevel ~= nil then
    local rBuildRank = mapLevel.RecommendBuildRank
    local sScore = "Icon/BuildRank/BuildRank_" .. rBuildRank
    self:SetPngSprite(self._mapNode.imgReconmendBuildChallenge, sScore)
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeAttr, string.format("%d%%", mapLevel.Attr))
    NovaAPI.SetTMPText(self._mapNode.txtRecommendLevelChallenge, mapLevel.RecommendLevel)
  else
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeScore, "0")
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeAttr, "0%")
    NovaAPI.SetTMPText(self._mapNode.txtRecommendLevelChallenge, "0")
    local sScore = "Icon/BuildRank/BuildRank_" .. 1
    self:SetPngSprite(self._mapNode.imgReconmendBuildChallenge, sScore)
  end
  NovaAPI.SetTMPText(self._mapNode.TMPCurLevel, "0")
  for i = 1, 3 do
    if mapBossLevelData.EET == nil or mapBossLevelData.EET[i] == nil then
      self._mapNode.imgElementInfoChallenge[i].gameObject:SetActive(false)
    else
      self._mapNode.imgElementInfoChallenge[i].gameObject:SetActive(true)
      self:SetAtlasSprite(self._mapNode.imgElementInfoChallenge[i], "12_rare", AllEnum.ElementIconType.Icon .. mapBossLevelData.EET[i])
    end
  end
  self.selectedAffixIds = {}
  self.lastSelAffixId = nil
  self:CreateAffixGrid()
  self:RefreshAffixGrid()
  NovaAPI.SetVerticalNormalizedPosition(self._mapNode.ScrollView, 1)
  self:InitCachedSelectedGridState()
end

function TravelerDuelChallengeInfoCtrl:ClearAffixContentChildren(trContent)
  if trContent == nil then
    return
  end
  for i = trContent.childCount - 1, 0, -1 do
    local trChild = trContent:GetChild(i)
    if trChild ~= nil and trChild:IsNull() == false then
      trChild.gameObject.name = " "
      destroy(trChild.gameObject)
    end
  end
end

function TravelerDuelChallengeInfoCtrl:CreateAffixGrid()
  local tr_enemy = self._mapNode.ContentAffixSelect
  local tr_self = self._mapNode.ContentAffixSelfSelect
  for nIdx, tbData in ipairs(self.tbEnemyAffix) do
    local go_affix = instantiate(self._mapNode.AffixPrefab, tr_enemy)
    go_affix.gameObject.name = tostring(nIdx - 1)
    self.mapAffixGrid[go_affix] = self:BindCtrlByNode(go_affix, "Game.UI.TrekkerVersus_600003.TravelerDuelChallengeAffixGrid")
    go_affix:SetActive(true)
  end
  for nIdx, tbData in ipairs(self.tbSelfAffix) do
    local go_affix = instantiate(self._mapNode.AffixPrefab, tr_self)
    go_affix.gameObject.name = tostring(nIdx - 1)
    self.mapAffixGrid[go_affix] = self:BindCtrlByNode(go_affix, "Game.UI.TrekkerVersus_600003.TravelerDuelChallengeAffixGrid")
    go_affix:SetActive(true)
  end
end

function TravelerDuelChallengeInfoCtrl:RefreshAffixGrid()
  local tr_enemy = self._mapNode.ContentAffixSelect
  local tr_self = self._mapNode.ContentAffixSelfSelect
  for nIdx, tbData in ipairs(self.tbEnemyAffix) do
    local go_affix = tr_enemy:Find(tostring(nIdx - 1)).gameObject
    local bLine = self.tbEnemyAffix[nIdx + 1] ~= nil and self.tbEnemyAffix[nIdx + 1][2] == tbData[2]
    local bSelect = table.indexof(self.selectedAffixIds, tbData[1]) > 0
    local bGroupMask = false
    if not bSelect then
      for _, nSelectId in ipairs(self.selectedAffixIds) do
        local mapAffixCfgDataSelect = ConfigTable.GetData("TravelerDuelChallengeAffix", nSelectId)
        if mapAffixCfgDataSelect == nil then
          return
        end
        if mapAffixCfgDataSelect.GroupId == tbData[2] then
          bGroupMask = true
          break
        end
      end
    end
    local imgFocus = go_affix.transform:Find("btnGrid/imgFocus")
    local bFocus = tbData[1] == self.lastSelAffixId
    if bFocus then
      if imgFocus ~= nil then
        imgFocus.gameObject:SetActive(true)
      end
    elseif imgFocus ~= nil then
      imgFocus.gameObject:SetActive(false)
    end
    if nIdx >= go_affix.transform.parent.childCount then
      go_affix.transform:SetAsLastSibling()
    else
      go_affix.transform:SetSiblingIndex(nIdx)
    end
    self.mapAffixGrid[go_affix]:Refresh(tbData[1], bSelect, bGroupMask, bLine, self.mapActData)
    local btn_grid = go_affix.transform:Find("btnGrid"):GetComponent("UIButton")
    btn_grid.onClick:RemoveAllListeners()
    btn_grid.onClick:AddListener(function()
      self:OnBtnClickGrid(go_affix, nIdx - 1)
    end)
  end
  for nIdx, tbData in ipairs(self.tbSelfAffix) do
    local go_affix = tr_self:Find(tostring(nIdx - 1)).gameObject
    local bLine = self.tbSelfAffix[nIdx + 1] ~= nil and self.tbSelfAffix[nIdx + 1][2] == tbData[2]
    local bSelect = 0 < table.indexof(self.selectedAffixIds, tbData[1])
    local bGroupMask = false
    if not bSelect then
      for _, nSelectId in ipairs(self.selectedAffixIds) do
        local mapAffixCfgDataSelect = ConfigTable.GetData("TravelerDuelChallengeAffix", nSelectId)
        if mapAffixCfgDataSelect == nil then
          return
        end
        if mapAffixCfgDataSelect.GroupId == tbData[2] then
          bGroupMask = true
          break
        end
      end
    end
    local imgFocus = go_affix.transform:Find("btnGrid/imgFocus")
    local bFocus = tbData[1] == self.lastSelAffixId
    if bFocus then
      if imgFocus ~= nil then
        imgFocus.gameObject:SetActive(true)
      end
    elseif imgFocus ~= nil then
      imgFocus.gameObject:SetActive(false)
    end
    if nIdx >= go_affix.transform.parent.childCount then
      go_affix.transform:SetAsLastSibling()
    else
      go_affix.transform:SetSiblingIndex(nIdx)
    end
    self.mapAffixGrid[go_affix]:Refresh(tbData[1], bSelect, bGroupMask, bLine, self.mapActData)
    local btn_grid = go_affix.transform:Find("btnGrid"):GetComponent("UIButton")
    btn_grid.onClick:RemoveAllListeners()
    btn_grid.onClick:AddListener(function()
      self:OnBtnClickGrid(go_affix, nIdx - 1)
    end)
  end
end

function TravelerDuelChallengeInfoCtrl:InitAffixData()
  for _, tbData in ipairs(self.tbAllAffix) do
    local config = ConfigTable.GetData("TravelerDuelChallengeAffix", tbData[1])
    if config ~= nil then
      if table.indexof(config.AddCamp, 3) > 0 then
        table.insert(self.tbEnemyAffix, tbData)
      else
        if table.indexof(config.AddCamp, 1) > 0 then
          table.insert(self.tbSelfAffix, tbData)
        else
        end
      end
    end
  end
end

function TravelerDuelChallengeInfoCtrl:InitCachedSelectedGridState()
  local cachedAffixes = self.mapActData:GetCacheAffixids()
  if cachedAffixes ~= nil then
    for index, nAffixId in ipairs(cachedAffixes) do
      local grid = self:GetGridByDataID(nAffixId)
      if grid ~= nil then
        self:OnBtnClickGrid(grid)
        self:RefreshGridSelectState(grid, nAffixId, false)
      else
        self:AddAffixGrid(nAffixId)
      end
    end
  end
end

function TravelerDuelChallengeInfoCtrl:RefreshGridSelectState(goGrid, affixId, bSelect)
  if goGrid == nil then
    return
  end
  if bSelect then
    self.lastSelAffixId = affixId
  else
    self.lastSelAffixId = nil
  end
  local imgFocus = goGrid.transform:Find("btnGrid/imgFocus")
  if imgFocus ~= nil then
    imgFocus.gameObject:SetActive(bSelect)
  end
  local strId = tostring(affixId)
  for index, nAffixId in ipairs(self.selectedAffixIds) do
    local grid = self.tbAffixGrid[index]
    if grid == nil then
      printError("词条数量错误")
      return
    end
    local selNode = grid.transform:Find("selNode")
    local bindGrid = grid.transform:Find("BindGridID")
    if bindGrid ~= nil and selNode ~= nil then
      do
        local textComp = bindGrid.gameObject:GetComponent("Text")
        local imgBg = grid.transform:Find("Bg"):GetComponent("Image")
        if textComp ~= nil then
          local text = NovaAPI.GetText(textComp)
          if text == strId then
            selNode.gameObject:SetActive(bSelect)
            imgBg.color = bSelect and colorGreen or colorWhite
            if bSelect then
              local function wait()
                coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
                
                self._mapNode.srAffixList:ScrollToClick(grid)
              end
              
              self._coroutineScroll = cs_coroutine.start(wait)
            end
          else
            selNode.gameObject:SetActive(false)
            imgBg.color = colorWhite
          end
        end
      end
    end
  end
end

function TravelerDuelChallengeInfoCtrl:GetGridByDataID(dataID)
  local grid
  for index, tbData in ipairs(self.tbEnemyAffix) do
    if dataID == tbData[1] then
      local rtGrid = self._mapNode.ContentAffixSelect:Find(tostring(index - 1))
      return rtGrid.gameObject
    end
  end
  for index, tbData in ipairs(self.tbSelfAffix) do
    if dataID == tbData[1] then
      local rtGrid = self._mapNode.ContentAffixSelfSelect:Find(tostring(index - 1))
      return rtGrid.gameObject
    end
  end
  return nil
end

function TravelerDuelChallengeInfoCtrl:OnBtnClickGrid(goGrid, gridIndex)
  local nAffixId = self.mapAffixGrid[goGrid]:GetAffixId()
  if not self.mapAffixGrid[goGrid].bUnlock then
    EventManager.Hit(EventId.OpenMessageBox, orderedFormat(ConfigTable.GetUIText("TD_AffixCondTips" .. self.mapAffixGrid[goGrid].nType), self.mapAffixGrid[goGrid].nCond))
    return
  end
  local bClick = true
  if not gridIndex then
    gridIndex = tonumber(goGrid.name)
    bClick = false
  end
  local bIsEnemy = false
  for index, tbData in ipairs(self.tbEnemyAffix) do
    if tbData[1] == nAffixId then
      bIsEnemy = true
      break
    end
  end
  local nIdx = gridIndex + 1
  local tbData
  if bIsEnemy then
    tbData = self.tbEnemyAffix[nIdx]
  else
    tbData = self.tbSelfAffix[nIdx]
  end
  if self.lastSelAffixId ~= nil then
    local lastGrid = self:GetGridByDataID(self.lastSelAffixId)
    self:RefreshGridSelectState(lastGrid, self.lastSelAffixId, false)
  end
  if table.indexof(self.selectedAffixIds, tbData[1]) > 0 then
    self:RemoveAffixGrid(tbData[1])
    self.mapAffixGrid[goGrid]:SetSelect(false)
    for index, Data in ipairs(bIsEnemy and self.tbEnemyAffix or self.tbSelfAffix) do
      if index ~= nIdx and Data[2] == tbData[2] then
        local goGridAffix = bIsEnemy and self._mapNode.ContentAffixSelect:Find(tostring(index - 1)).gameObject or self._mapNode.ContentAffixSelfSelect:Find(tostring(index - 1)).gameObject
        if goGridAffix ~= nil and self.mapAffixGrid[goGridAffix] ~= nil then
          self.mapAffixGrid[goGridAffix]:SetGroupMask(false)
        end
      end
    end
    self:RefreshGridSelectState(goGrid, tbData[1], false)
  else
    local bGroupExchange = false
    local nLastGroupId = 0
    for index, Data in ipairs(bIsEnemy and self.tbEnemyAffix or self.tbSelfAffix) do
      if index ~= nIdx and Data[2] == tbData[2] and table.indexof(self.selectedAffixIds, Data[1]) > 0 then
        bGroupExchange = true
        nLastGroupId = Data[1]
      end
    end
    self.mapAffixGrid[goGrid]:SetSelect(true)
    self.mapAffixGrid[goGrid]:SetGroupMask(false)
    for index, Data in ipairs(bIsEnemy and self.tbEnemyAffix or self.tbSelfAffix) do
      if index ~= nIdx and Data[2] == tbData[2] then
        local goGridAffix = bIsEnemy and self._mapNode.ContentAffixSelect:Find(tostring(index - 1)).gameObject or self._mapNode.ContentAffixSelfSelect:Find(tostring(index - 1)).gameObject
        if goGridAffix ~= nil and self.mapAffixGrid[goGridAffix] ~= nil then
          self.mapAffixGrid[goGridAffix]:SetGroupMask(true)
          self.mapAffixGrid[goGridAffix]:SetSelect(false)
        end
      end
    end
    if bGroupExchange then
      table.removebyvalue(self.selectedAffixIds, nLastGroupId)
      
      local function Sort(a, b)
        local mapCfgDataA = ConfigTable.GetData("TravelerDuelChallengeAffix", a)
        local mapCfgDataB = ConfigTable.GetData("TravelerDuelChallengeAffix", b)
        if mapCfgDataA == nil or mapCfgDataB == nil then
          return mapCfgDataA ~= nil
        end
        if mapCfgDataA.Difficulty ~= mapCfgDataB.Difficulty then
          return mapCfgDataA.Difficulty < mapCfgDataB.Difficulty
        end
        return a < b
      end
      
      table.insert(self.selectedAffixIds, tbData[1])
      table.sort(self.selectedAffixIds, Sort)
      self:RefreshAffixList()
    else
      self:AddAffixGrid(tbData[1])
    end
    if bClick then
      local nCurLevel = 0
      for _, nAffixId in ipairs(self.selectedAffixIds) do
        local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixId)
        if mapAffixCfgData ~= nil then
          nCurLevel = nCurLevel + mapAffixCfgData.Difficulty
        end
      end
      EventManager.Hit("TrekkerVersusSelectAffix", nCurLevel)
    end
    self:RefreshGridSelectState(goGrid, tbData[1], true)
  end
end

function TravelerDuelChallengeInfoCtrl:ClearListGrids()
  if self.tbAffixGrid ~= nil then
    for _, goAffixGrid in ipairs(self.tbAffixGrid) do
      destroy(goAffixGrid)
    end
  end
  self.tbAffixGrid = {}
  if self.mapAffixGrid ~= nil then
    for go, mapCtrl in pairs(self.mapAffixGrid) do
      self:UnbindCtrlByNode(mapCtrl)
    end
  end
  self:ClearAffixContentChildren(self._mapNode.ContentAffixSelect)
  self:ClearAffixContentChildren(self._mapNode.ContentAffixSelfSelect)
  self.mapAffixGrid = {}
end

function TravelerDuelChallengeInfoCtrl:AddAffixGrid(nAffixId)
  local function Sort(a, b)
    local mapCfgDataA = ConfigTable.GetData("TravelerDuelChallengeAffix", a)
    
    local mapCfgDataB = ConfigTable.GetData("TravelerDuelChallengeAffix", b)
    if mapCfgDataA == nil or mapCfgDataB == nil then
      return mapCfgDataA ~= nil
    end
    if mapCfgDataA.Difficulty ~= mapCfgDataB.Difficulty then
      return mapCfgDataA.Difficulty < mapCfgDataB.Difficulty
    end
    return a < b
  end
  
  table.insert(self.selectedAffixIds, nAffixId)
  table.sort(self.selectedAffixIds, Sort)
  local goAffix = instantiate(self._mapNode.gridAffix, self._mapNode.rtAffixListContent)
  goAffix:SetActive(true)
  table.insert(self.tbAffixGrid, goAffix)
  self:RefreshAffixList()
end

function TravelerDuelChallengeInfoCtrl:AddJumptoAffixes(tbAffixes)
  if self.lastSelAffixId ~= nil then
    local lastGrid = self:GetGridByDataID(self.lastSelAffixId)
    self:RefreshGridSelectState(lastGrid, self.lastSelAffixId, false)
    self.lastSelAffixId = nil
  end
  local nAffixCountChange = 0
  local tbLockedAffix = {}
  for _, nAffixId in ipairs(tbAffixes) do
    local bUnlock, nType, nCond = self.mapActData:GetTravelerDuelAffixUnlock(nAffixId)
    local bIsEnemy = false
    for index, tbData in ipairs(self.tbEnemyAffix) do
      if nAffixId == tbData[1] then
        bIsEnemy = true
        break
      end
    end
    if not bUnlock then
      table.insert(tbLockedAffix, nAffixId)
    elseif 1 > table.indexof(self.selectedAffixIds, nAffixId) then
      local tbData
      local nAffixIdx = 0
      for idx, tbAffixData in ipairs(bIsEnemy and self.tbEnemyAffix or self.tbSelfAffix) do
        if nAffixId == tbAffixData[1] then
          tbData = tbAffixData
          nAffixIdx = idx
          break
        end
      end
      if tbData ~= nil then
        local bGroupExchange = false
        local nLastAffixId = 0
        for index, Data in ipairs(bIsEnemy and self.tbEnemyAffix or self.tbSelfAffix) do
          if index ~= nAffixIdx and Data[2] == tbData[2] and 0 < table.indexof(self.selectedAffixIds, Data[1]) then
            bGroupExchange = true
            nLastAffixId = Data[1]
          end
        end
        if not bGroupExchange then
          nAffixCountChange = nAffixCountChange + 1
        else
          table.removebyvalue(self.selectedAffixIds, nLastAffixId)
          local goGrid = self:GetGridByDataID(nLastAffixId)
          if goGrid ~= nil then
            self.mapAffixGrid[goGrid]:SetSelect(false)
          end
        end
        table.insert(self.selectedAffixIds, nAffixId)
      end
    end
  end
  if 0 < nAffixCountChange then
    for i = 1, nAffixCountChange do
      local goAffix = instantiate(self._mapNode.gridAffix, self._mapNode.rtAffixListContent)
      goAffix:SetActive(true)
      table.insert(self.tbAffixGrid, goAffix)
    end
  end
  
  local function Sort(a, b)
    local mapCfgDataA = ConfigTable.GetData("TravelerDuelChallengeAffix", a)
    local mapCfgDataB = ConfigTable.GetData("TravelerDuelChallengeAffix", b)
    if mapCfgDataA == nil or mapCfgDataB == nil then
      return mapCfgDataA ~= nil
    end
    if mapCfgDataA.Difficulty ~= mapCfgDataB.Difficulty then
      return mapCfgDataA.Difficulty < mapCfgDataB.Difficulty
    end
    return a < b
  end
  
  table.sort(self.selectedAffixIds, Sort)
  self:RefreshAffixList()
  self:RefreshAffixGrid()
  if 0 < #tbLockedAffix then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("TravelerDuel_JumptoAffixUnlock"))
  end
end

function TravelerDuelChallengeInfoCtrl:RemoveAffixGrid(nAffixId)
  table.removebyvalue(self.selectedAffixIds, nAffixId)
  local go = table.remove(self.tbAffixGrid)
  destroy(go)
  self:RefreshAffixList()
end

function TravelerDuelChallengeInfoCtrl:OnClickAffixListButton(goGrid, affixId)
  for index, nAffixId in ipairs(self.selectedAffixIds) do
    local grid = self.tbAffixGrid[index]
    if grid == nil then
      printError("词条数量错误")
      return
    end
    local node = grid.transform:Find("selNode")
    if node ~= nil then
      local imgBg = grid.transform:Find("Bg"):GetComponent("Image")
      imgBg.color = colorWhite
      node.gameObject:SetActive(false)
    end
  end
  local bIsEnemy = false
  for index, tbData in ipairs(self.tbEnemyAffix) do
    if nAffixId == tbData[1] then
      bIsEnemy = true
      break
    end
  end
  local selNode = goGrid.transform:Find("selNode")
  if selNode ~= nil then
    local imgBg = goGrid.transform:Find("Bg"):GetComponent("Image")
    selNode.gameObject:SetActive(true)
    imgBg.color = colorGreen
    local selIndex
    for index, Data in ipairs(bIsEnemy and self.tbEnemyAffix or self.tbSelfAffix) do
      local id = Data[1]
      if id == affixId then
        selIndex = index - 1
      end
    end
    if selIndex ~= nil then
      if self.lastSelAffixId ~= nil then
        local goGridAffix = self:GetGridByDataID(self.lastSelAffixId)
        if goGridAffix ~= nil then
          local gameObj = goGridAffix.gameObject
          local imgFocus = gameObj.transform:Find("btnGrid/imgFocus")
          if imgFocus ~= nil then
            imgFocus.gameObject:SetActive(false)
          end
        end
      end
      self.lastSelAffixId = affixId
      if self.lastSelAffixId ~= nil then
        local goGridAffix = self:GetGridByDataID(self.lastSelAffixId)
        if goGridAffix ~= nil then
          local gameObj = goGridAffix.gameObject
          local imgFocus = gameObj.transform:Find("btnGrid/imgFocus")
          if imgFocus ~= nil then
            imgFocus.gameObject:SetActive(true)
          end
        end
      end
    end
  end
end

function TravelerDuelChallengeInfoCtrl:RefreshAffixList()
  local nTotalDifficulty = 0
  self._mapNode.goEmpty:SetActive(0 >= #self.tbAffixGrid)
  for index, nAffixId in ipairs(self.selectedAffixIds) do
    local goGrid = self.tbAffixGrid[index]
    if goGrid == nil then
      printError("词条数量错误")
      return
    end
    local button = goGrid.transform:GetComponent("UIButton")
    if button ~= nil then
      button.onClick:RemoveAllListeners()
      
      local function listener()
        self:OnClickAffixListButton(goGrid, nAffixId)
      end
      
      button.onClick:AddListener(listener)
    end
    local mapAffixCfgData = ConfigTable.GetData("TravelerDuelChallengeAffix", nAffixId)
    local imgAffixIcon = goGrid.transform:Find("imgAffixIconBg/imgAffixIcon"):GetComponent("Image")
    local TMPAffixDesc = goGrid.transform:Find("TMPAffixDesc"):GetComponent("TMP_Text")
    local TMPHard = goGrid.transform:Find("imgHardBg/TMPHard"):GetComponent("TMP_Text")
    local bindGrid = goGrid.transform:Find("BindGridID")
    if bindGrid ~= nil then
      local textComp = bindGrid.gameObject:GetComponent("Text")
      if textComp ~= nil then
        NovaAPI.SetText(textComp, tostring(nAffixId))
      end
    end
    self:SetPngSprite(imgAffixIcon, mapAffixCfgData.Icon)
    local sDesc = orderedFormat(ConfigTable.GetUIText("TravelerDuel_AffixDescFormat") or "", mapAffixCfgData.Name, UTILS.ParseDesc(mapAffixCfgData))
    sDesc = UTILS.ParseNoBrokenDesc(sDesc)
    NovaAPI.SetTMPText(TMPAffixDesc, sDesc)
    NovaAPI.SetTMPText(TMPHard, mapAffixCfgData.Difficulty)
    nTotalDifficulty = nTotalDifficulty + mapAffixCfgData.Difficulty
  end
  NovaAPI.SetTMPText(self._mapNode.TMPCurLevel, nTotalDifficulty)
  local mapLevel = ConfigTable.GetData("TravelerDuelChallengeDifficulty", nTotalDifficulty)
  if mapLevel == nil then
    for i = nTotalDifficulty, 0, -1 do
      if ConfigTable.GetData("TravelerDuelChallengeDifficulty", i) ~= nil then
        mapLevel = ConfigTable.GetData("TravelerDuelChallengeDifficulty", i)
        break
      end
    end
  end
  if mapLevel ~= nil then
    local rBuildRank = mapLevel.RecommendBuildRank
    local sScore = "Icon/BuildRank/BuildRank_" .. rBuildRank
    self:SetPngSprite(self._mapNode.imgReconmendBuildChallenge, sScore)
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeScore, mapLevel.BaseScore)
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeAttr, string.format("%d%%", mapLevel.Attr))
    NovaAPI.SetTMPText(self._mapNode.txtRecommendLevelChallenge, mapLevel.RecommendLevel)
  else
    local sScore = "Icon/BuildRank/BuildRank_" .. 1
    self:SetPngSprite(self._mapNode.imgReconmendBuildChallenge, sScore)
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeScore, "0")
    NovaAPI.SetTMPText(self._mapNode.TMPChallengeAttr, "0%")
    NovaAPI.SetTMPText(self._mapNode.txtRecommendLevelChallenge, "0")
  end
end

function TravelerDuelChallengeInfoCtrl:CacheAffixes()
  if self.nLevelId == nil or self.nLevelId == 0 then
    return
  end
  local mapBossLevelData = ConfigTable.GetData("TravelerDuelBossLevel", self.nLevelId)
  self.mapActData:SetCacheAffixids(clone(self.selectedAffixIds))
end

function TravelerDuelChallengeInfoCtrl:OnBtnClick_ClearAllAffix()
  self.selectedAffixIds = {}
  if self.tbAffixGrid ~= nil then
    for _, goAffixGrid in ipairs(self.tbAffixGrid) do
      destroy(goAffixGrid)
    end
  end
  self:RefreshAffixGrid()
  if self.lastSelAffixId ~= nil then
    local lastGrid = self:GetGridByDataID(self.lastSelAffixId)
    self:RefreshGridSelectState(lastGrid, self.lastSelAffixId, false)
    self.lastSelAffixId = nil
  end
  self.tbAffixGrid = {}
  self:RefreshAffixList()
end

function TravelerDuelChallengeInfoCtrl:OnBtnClick_Go()
  local function OpenPanel()
    EventManager.Hit(EventId.OpenPanel, PanelId.RegionBossFormation, AllEnum.RegionBossFormationType.TravelerDuel, self.nLevelId, {
      self.mapActData.nActId,
      
      self.selectedAffixIds
    })
  end
  
  self:CacheAffixes()
  EventManager.Hit(EventId.SetTransition, 2, OpenPanel)
end

function TravelerDuelChallengeInfoCtrl:OnBtnClick_EnemyInfo()
  EventManager.Hit("OpenTravelerDuelMonsterInfo", self.nLevelId)
end

return TravelerDuelChallengeInfoCtrl
