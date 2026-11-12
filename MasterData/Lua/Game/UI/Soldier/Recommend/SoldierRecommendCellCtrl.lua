local SoldierRecommendCellCtrl = class("SoldierRecommendCellCtrl", BaseCtrl)

local function SetActiveIfChanged(goNode, bActive)
  if goNode.activeSelf ~= bActive then
    goNode:SetActive(bActive)
  end
end

SoldierRecommendCellCtrl._mapNodeConfig = {
  btnGrid = {
    sNodeName = "t_btn_00",
    sComponentName = "UIButton",
    callback = "OnBtnClick_Detail"
  },
  txt_title = {sComponentName = "TMP_Text"},
  sv_char = {
    sComponentName = "RectTransform"
  },
  sv_charSupport = {
    sComponentName = "LoopScrollView"
  },
  img_Char = {sComponentName = "Image"},
  btn_Apply = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Apply"
  },
  txt_Apply = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_Apply"
  },
  btn_Cancel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Cancel"
  },
  txt_Cancel = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_Cancel"
  },
  btnDelete = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Delete"
  },
  img_Use = {},
  txt_Use = {
    sComponentName = "TMP_Text",
    sLanguageId = "Soldier_Recommend_Use"
  },
  imgVersion = {},
  txt_Version = {sComponentName = "TMP_Text"}
}
SoldierRecommendCellCtrl._mapEventConfig = {
  SoldierRecommend_Update = "OnEvent_SoldierRecommendCell_Update"
}
SoldierRecommendCellCtrl._mapRedDotConfig = {}

function SoldierRecommendCellCtrl:Awake()
  self.tbCharItemCtrl = {}
  self._tbSupportCharData = {}
  self.nStaticCharRootCount = self._mapNode.sv_char.childCount
  self._tbSupportGrid = {}
  local svSupport = self._mapNode.sv_charSupport
  self._goSupportTemplate = svSupport.transform:Find("grid").gameObject
  self._goSupportTemplate:SetActive(false)
  self._rtSupportContent = svSupport.content
  self._objSupportLayout = self._rtSupportContent:GetComponent("GridLayoutGroup")
  self._objSupportLayout.enabled = false
  local objFitter = self._rtSupportContent:GetComponent("ContentSizeFitter")
  if objFitter ~= nil then
    objFitter.enabled = false
  end
  self._rtSupportContent.pivot = Vector2(0, 1)
  self._rtSupportContent.anchorMin = Vector2(0, 0)
  self._rtSupportContent.anchorMax = Vector2(0, 1)
end

function SoldierRecommendCellCtrl:OnEnable()
  self:SetApplyStatus()
end

function SoldierRecommendCellCtrl:OnDisable()
end

function SoldierRecommendCellCtrl:OnDestroy()
  self._objListCtrl = nil
  self.tbCharItemCtrl = nil
  self._tbSupportCharData = nil
  self._tbSupportGrid = nil
  self._goSupportTemplate = nil
  self._rtSupportContent = nil
  self._objSupportLayout = nil
  self.mapRecommendData = nil
end

function SoldierRecommendCellCtrl:SetDetailCallback(objListCtrl, nIndex)
  self._objListCtrl = objListCtrl
  self._nListIndex = nIndex
end

function SoldierRecommendCellCtrl:OnBtnClick_Detail()
  self._objListCtrl:OnRecommendGridBtnClick(self.gameObject, self._nListIndex - 1)
end

function SoldierRecommendCellCtrl:SetItemData(mapRecommendData, bInSoldier)
  self.bInSoldier = bInSoldier
  self.mapRecommendData = mapRecommendData
  SetActiveIfChanged(self._mapNode.btnDelete.gameObject, not self.mapRecommendData.bSystemRecommend)
  NovaAPI.SetTMPText(self._mapNode.txt_title, self.mapRecommendData.sTitle)
  SetActiveIfChanged(self._mapNode.imgVersion.gameObject, self.mapRecommendData.sVersion ~= nil and self.mapRecommendData.sVersion ~= "")
  NovaAPI.SetTMPText(self._mapNode.txt_Version, self.mapRecommendData.sVersion)
  local mapCfg = ConfigTable.GetData("SoldierBossTemplate", self.mapRecommendData.nBossTemplateId or 0)
  if mapCfg ~= nil then
    self:SetPngSprite(self._mapNode.img_Char, mapCfg.SoldierPlayerHead)
  end
  self:RefreshCharList()
  self:SetApplyStatus()
end

function SoldierRecommendCellCtrl:RefreshCharList()
  for nIndex = #self._tbSupportCharData, 1, -1 do
    self._tbSupportCharData[nIndex] = nil
  end
  local trCharRoot = self._mapNode.sv_char
  local tbCharList = self.mapRecommendData.charList or {}
  for nIndex = 1, self.nStaticCharRootCount do
    local charData = tbCharList[nIndex]
    local trCharItemRoot = trCharRoot:GetChild(nIndex - 1)
    local goChar = trCharItemRoot:Find("AnimRoot/SoldierCharCardItem").gameObject
    local nInstanceId = goChar:GetInstanceID()
    local objCharItemCtrl = self.tbCharItemCtrl[nInstanceId]
    if charData ~= nil and objCharItemCtrl == nil then
      objCharItemCtrl = self._panel:BindRecommendCtrl(goChar, "Game.UI.Soldier.Recommend.SoldierRecommendCharItemCtrl")
      self.tbCharItemCtrl[nInstanceId] = objCharItemCtrl
    end
    if objCharItemCtrl ~= nil then
      objCharItemCtrl:SetRecommendData(charData, nIndex)
    end
    SetActiveIfChanged(trCharItemRoot.gameObject, charData ~= nil)
  end
  for nIndex = self.nStaticCharRootCount + 1, #tbCharList do
    table.insert(self._tbSupportCharData, tbCharList[nIndex])
  end
  local bHasSupportChar = #self._tbSupportCharData > 0
  SetActiveIfChanged(self._mapNode.sv_charSupport.gameObject, bHasSupportChar)
  local objLayout = self._objSupportLayout
  local v2CellSize = objLayout.cellSize
  local nCount = #self._tbSupportCharData
  self._mapNode.sv_charSupport:StopMovement()
  self._rtSupportContent.anchoredPosition = Vector2.zero
  self._rtSupportContent.sizeDelta = Vector2(objLayout.padding.left + objLayout.padding.right + nCount * v2CellSize.x + math.max(0, nCount - 1) * objLayout.spacing.x, 0)
  for nIndex = 1, nCount do
    local goGrid = self._tbSupportGrid[nIndex]
    if goGrid == nil then
      goGrid = instantiate(self._goSupportTemplate, self._rtSupportContent)
      self._tbSupportGrid[nIndex] = goGrid
      local rtGrid = goGrid:GetComponent("RectTransform")
      rtGrid.pivot = Vector2(0, 1)
      rtGrid.anchorMin = Vector2(0, 1)
      rtGrid.anchorMax = Vector2(0, 1)
      rtGrid.localScale = Vector3.one
      rtGrid.sizeDelta = v2CellSize
      rtGrid.anchoredPosition = Vector2(objLayout.padding.left + (nIndex - 1) * (v2CellSize.x + objLayout.spacing.x), -objLayout.padding.top)
    end
    self:OnSupportCharRefreshGrid(goGrid, nIndex - 1)
    SetActiveIfChanged(goGrid, true)
  end
  for nIndex = nCount + 1, #self._tbSupportGrid do
    self:OnSupportCharRefreshGrid(self._tbSupportGrid[nIndex], nIndex - 1)
    SetActiveIfChanged(self._tbSupportGrid[nIndex], false)
  end
end

function SoldierRecommendCellCtrl:OnSupportCharRefreshGrid(goGrid, nGridIndex)
  local mapCharData = self._tbSupportCharData[nGridIndex + 1]
  local goChar = goGrid.transform:Find("AnimRoot/SoldierCharCardItem").gameObject
  local nInstanceId = goChar:GetInstanceID()
  local objCharItemCtrl = self.tbCharItemCtrl[nInstanceId]
  if objCharItemCtrl == nil and mapCharData ~= nil then
    objCharItemCtrl = self._panel:BindRecommendCtrl(goChar, "Game.UI.Soldier.Recommend.SoldierRecommendCharItemCtrl")
    self.tbCharItemCtrl[nInstanceId] = objCharItemCtrl
  end
  if objCharItemCtrl ~= nil then
    objCharItemCtrl:SetRecommendData(mapCharData)
  end
end

function SoldierRecommendCellCtrl:SetApplyStatus()
  if self.mapRecommendData == nil then
    return
  end
  local bApply = false
  local recommendData = PlayerData.SoldierData:GetRecommendData(self.bInSoldier)
  if recommendData ~= nil and recommendData.nRecommendId == self.mapRecommendData.nRecommendId then
    bApply = true
  end
  SetActiveIfChanged(self._mapNode.btn_Apply.gameObject, not bApply)
  SetActiveIfChanged(self._mapNode.btn_Cancel.gameObject, bApply)
  SetActiveIfChanged(self._mapNode.img_Use.gameObject, bApply)
end

function SoldierRecommendCellCtrl:OnBtnClick_Apply()
  PlayerData.SoldierData:SetRecommendData(self.mapRecommendData.nRecommendId, self.bInSoldier)
end

function SoldierRecommendCellCtrl:OnBtnClick_Cancel()
  PlayerData.SoldierData:SetRecommendData(0, self.bInSoldier)
end

function SoldierRecommendCellCtrl:OnEvent_SoldierRecommendCell_Update()
  self:SetApplyStatus()
end

function SoldierRecommendCellCtrl:OnBtnClick_Delete()
  PlayerData.SoldierData:SendUnfavoriteRecommend(self.mapRecommendData.nRecommendId, function()
    PlayerData.SoldierData:RequestRecommendList(function()
      EventManager.Hit("RefreshSoldierRecommendList")
    end)
  end)
end

return SoldierRecommendCellCtrl
