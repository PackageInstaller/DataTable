local StarTowerGrowthPreviewWindowCtrl = class("StarTowerGrowthPreviewWindowCtrl", BaseCtrl)
StarTowerGrowthPreviewWindowCtrl._mapNodeConfig = {
  lsvEffect = {},
  AdNodeScrollView = {
    sComponentName = "LoopScrollView"
  },
  txtGrowthPreviewWindowTitle = {
    sComponentName = "TMP_Text",
    sLanguageId = "StarTower_ResearchPreview"
  },
  txtTabTitle = {sComponentName = "TMP_Text"},
  txtHighestLevelTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "STGrowth_HighestLevelTip"
  },
  txtNoEffectTip = {
    sComponentName = "TMP_Text",
    sLanguageId = "STGrowth_NoEffectTip"
  },
  rtWindow = {
    sNodeName = "StarTowerGrowthPreview",
    sComponentName = "RectTransform"
  },
  aniWindow = {
    sNodeName = "StarTowerGrowthPreview",
    sComponentName = "Animator"
  },
  gridFlexable = {},
  effectContent = {
    sComponentName = "RectTransform"
  },
  snapshot = {},
  btnClose = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  },
  btnCloseBig = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Close"
  }
}
StarTowerGrowthPreviewWindowCtrl._mapEventConfig = {
  SelectDiffNode = "OnEvent_SelectDiffNode"
}

function StarTowerGrowthPreviewWindowCtrl:RefreshNodeScrollView()
  local tbDifficulty = {}
  
  local function foreachStarTower(mapdata)
    local nDifficulty = mapdata.Difficulty
    if table.indexof(tbDifficulty, nDifficulty) <= 0 then
      table.insert(tbDifficulty, nDifficulty)
    end
  end
  
  ForEachTableLine(DataTable.StarTower, foreachStarTower)
  self.nDifficultyCount = #tbDifficulty
  self.tbDiffNode = {}
  self._mapNode.AdNodeScrollView:Init(self.nDifficultyCount, self, self.OnNodeGridRefresh)
  self._mapNode.AdNodeScrollView:SetScrollGridPos(self.nCurDifficulty - 1, 0.2)
end

function StarTowerGrowthPreviewWindowCtrl:OnNodeGridRefresh(goGrid, nIdx)
  local nIndex = tonumber(goGrid.name) + 1
  if self.tbDiffNode[goGrid] ~= nil then
    self:UnbindCtrlByNode(self.tbDiffNode[goGrid])
    self.tbDiffNode[goGrid] = nil
  end
  local ctrlItem = self:BindCtrlByNode(goGrid, "Game.UI.StarTowerGrowth.StarTowerDifficultyNodeItemCtrl")
  self.tbDiffNode[goGrid] = ctrlItem
  ctrlItem:RefreshNode(nIndex, self.nCurDifficulty, nIndex == self.curSelectDiff, self.nMaxDifficulty)
end

function StarTowerGrowthPreviewWindowCtrl:RefreshEffectDetail()
  local sTabTitle = ConfigTable.GetUIText("StarTower_ActiveResearch")
  local sDifficulty = ConfigTable.GetUIText("Diffculty_" .. self.curSelectDiff)
  NovaAPI.SetTMPText(self._mapNode.txtTabTitle, sDifficulty .. " " .. sTabTitle)
  self.tbCurNodes = {}
  
  local function foreachGrowthGroup(mapdata)
    local tbNodes = PlayerData.StarTower:GetGrowthNodesByGroup(mapdata.Id)
    if tbNodes ~= nil then
      for k, v in pairs(tbNodes) do
        local mapNodeData = ConfigTable.GetData("StarTowerGrowthNode", v.nId)
        if mapNodeData ~= nil and v.bActive and mapNodeData.Clientlvl <= self.curSelectDiff and mapNodeData.EffectClient ~= nil and mapNodeData.Priority ~= nil then
          if self.tbCurNodes[mapNodeData.EffectClient] == nil then
            self.tbCurNodes[mapNodeData.EffectClient] = mapNodeData
          elseif mapNodeData.Priority > self.tbCurNodes[mapNodeData.EffectClient].Priority then
            self.tbCurNodes[mapNodeData.EffectClient] = mapNodeData
          end
        end
      end
    end
  end
  
  ForEachTableLine(DataTable.StarTowerGrowthGroup, foreachGrowthGroup)
  local bHasEff = self.tbCurNodes ~= nil and next(self.tbCurNodes) ~= nil
  self._mapNode.txtNoEffectTip.gameObject:SetActive(not bHasEff)
  self._mapNode.lsvEffect.gameObject:SetActive(bHasEff)
  self._mapNode.txtHighestLevelTip.gameObject:SetActive(bHasEff)
  if not bHasEff then
    return
  end
  self.tbCurNodeSorted = {}
  for k, v in pairs(self.tbCurNodes) do
    table.insert(self.tbCurNodeSorted, v)
  end
  table.sort(self.tbCurNodeSorted, function(a, b)
    return a.Priority > b.Priority
  end)
  self:RefreshEffectContent()
end

local function highlightNumbers(text, colorTag)
  local sResult = ""
  local nLastEnd = 1
  for nStart, sTag, nEnd in string.gmatch(text, "()(<[^>]+>)()") do
    local sPlain = string.sub(text, nLastEnd, nStart - 1)
    sPlain = string.gsub(sPlain, "%d+%.?%d*%%?", "<color=#" .. colorTag .. ">%0</color>")
    sResult = sResult .. sPlain .. sTag
    nLastEnd = nEnd
  end
  local sTail = string.sub(text, nLastEnd)
  sTail = string.gsub(sTail, "%d+%.?%d*%%?", "<color=#" .. colorTag .. ">%0</color>")
  sResult = sResult .. sTail
  return sResult
end

function StarTowerGrowthPreviewWindowCtrl:RefreshEffectContent()
  while self._mapNode.effectContent.transform.childCount > 0 do
    local goChild = self._mapNode.effectContent.transform:GetChild(0)
    goChild.gameObject:SetActive(false)
    destroyImmediate(goChild.gameObject)
  end
  for k, v in pairs(self.tbCurNodeSorted) do
    local mapData = v
    local goGrid = instantiate(self._mapNode.gridFlexable, self._mapNode.effectContent)
    local txtNodeTitle = goGrid.transform:Find("imgBarBg1"):Find("txtNodeTitle"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txtNodeTitle, mapData.Name)
    local txtNodeDesc = goGrid.transform:Find("imgBarBg2"):Find("txtNodeDesc"):GetComponent("TMP_Text")
    local sDesc = mapData.Desc
    sDesc = highlightNumbers(sDesc, "0abec5")
    NovaAPI.SetTMPText(txtNodeDesc, sDesc)
    goGrid.gameObject:SetActive(true)
  end
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.effectContent)
  CS.UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._mapNode.effectContent)
  self._mapNode.lsvEffect:GetComponent("ScrollRect").verticalNormalizedPosition = 1
end

function StarTowerGrowthPreviewWindowCtrl:UnbindAllGrids()
  if self.tbDiffNode == nil then
    return
  end
  for go, ctrl in pairs(self.tbDiffNode) do
    self:UnbindCtrlByNode(ctrl)
  end
  self.tbDiffNode = {}
end

function StarTowerGrowthPreviewWindowCtrl:OpenPanel(nDifficulty, nMaxDifficulty)
  self.nCurDifficulty = nDifficulty or 1
  self.nMaxDifficulty = nMaxDifficulty or 1
  self.curSelectDiff = self.nCurDifficulty
  
  local function wait()
    NovaAPI.UIEffectSnapShotCapture(self._mapNode.snapshot)
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self.gameObject:SetActive(true)
    self._mapNode.rtWindow.gameObject:SetActive(true)
    self._mapNode.aniWindow:Play("t_window_04_t_in")
    self:RefreshNodeScrollView()
    self:RefreshEffectDetail()
  end
  
  cs_coroutine.start(wait)
end

function StarTowerGrowthPreviewWindowCtrl:ClosePanel()
  self._mapNode.aniWindow:Play("t_window_04_t_out")
  EventManager.Hit(EventId.TemporaryBlockInput, 0.3)
  self:AddTimer(1, 0.3, function()
    self.gameObject:SetActive(false)
    self._mapNode.rtWindow.gameObject:SetActive(false)
    self:UnbindAllGrids()
  end, true, true, true, nil)
end

function StarTowerGrowthPreviewWindowCtrl:Awake()
end

function StarTowerGrowthPreviewWindowCtrl:OnEnable()
end

function StarTowerGrowthPreviewWindowCtrl:OnDisable()
end

function StarTowerGrowthPreviewWindowCtrl:OnDestroy()
end

function StarTowerGrowthPreviewWindowCtrl:OnEvent_SelectDiffNode(nDiff)
  self.curSelectDiff = nDiff
  self:RefreshEffectDetail()
end

function StarTowerGrowthPreviewWindowCtrl:OnBtnClick_Close()
  self:ClosePanel()
end

return StarTowerGrowthPreviewWindowCtrl
