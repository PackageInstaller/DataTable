local UIBattleStatisticsPanelInex = {
  None = 0,
  Total = 1,
  Detail = 2
}
_enum("UIBattleStatisticsPanelInex", UIBattleStatisticsPanelInex)
_class("UIBattleStatisticsCellData", Object)
UIBattleStatisticsCellData = UIBattleStatisticsCellData

function UIBattleStatisticsCellData:Constructor(recordData, matchPet)
  self._recordData = recordData
  self._matchPet = matchPet
  self._maxTotalDamage = 0
  self._maxDetailDamage = 0
end

function UIBattleStatisticsCellData:GetRecordData()
  return self._recordData
end

function UIBattleStatisticsCellData:GetMatchPet()
  return self._matchPet
end

function UIBattleStatisticsCellData:SetMaxTotalDamage(damage)
  self._maxTotalDamage = damage
end

function UIBattleStatisticsCellData:GetMaxTotalDamage()
  return self._maxTotalDamage
end

function UIBattleStatisticsCellData:SetMaxDetailDamage(damage)
  self._maxDetailDamage = damage
end

function UIBattleStatisticsCellData:GetMaxDetailDamage()
  return self._maxDetailDamage
end

_class("UIBattleStatistics", UIController)
UIBattleStatistics = UIBattleStatistics

function UIBattleStatistics:OnShow(uiParams)
  self._timeEvents = {}
  self._tabIndex = UIBattleStatisticsPanelInex.None
  self._totalInfoAreaGo = self:GetGameObject("TotalInfoArea")
  self._detailInfoAreaGo = self:GetGameObject("DetailInfoArea")
  self._totalScroll = self:GetUIComponent("ScrollRect", "TotalScroll")
  self._detailScroll = self:GetUIComponent("ScrollRect", "DetailScroll")
  self._totalCellGen = self:GetUIComponent("UISelectObjectPath", "TotalContent")
  self._detailCellGen = self:GetUIComponent("UISelectObjectPath", "DetailContent")
  self._btnSelectedCoverRect = self:GetUIComponent("RectTransform", "BtnSelectedCover")
  self._totalBtnSelectdPosX = -168
  self._detailBtnSelectdPosX = 168
  local match = self:GetModule(MatchModule)
  local enterData = match:GetMatchEnterData()
  self._matchType = enterData._match_type
  self._matchPetData = uiParams[1]
  self:InitData()
  self:InitCells()
end

function UIBattleStatistics:OnHide()
  for key, value in pairs(self._timeEvents) do
    GameGlobal.Timer():CancelEvent(value)
  end
  if self._materialReq then
    self._materialReq:Dispose()
    self._material = nil
    self._materialReq = nil
  end
end

function UIBattleStatistics:InitData()
  self._uiTotalDataList = {}
  self._uiDetailDataList = {}
  if not self._matchPetData then
    return
  end
  local damageStatisticsDataList = InnerGameHelperRender.GetDamageStatisticsInfo()
  local dataDic = {}
  local maxTotalDamage = 0
  local maxDetailDamage = 0
  for _, v in pairs(damageStatisticsDataList) do
    local damageStatisticsData = v
    local dataPetTemplateID = damageStatisticsData:GetPetTemplateID()
    dataDic[dataPetTemplateID] = damageStatisticsData
    local damage = damageStatisticsData:GetAllDamageValue()
    if maxTotalDamage < damage then
      maxTotalDamage = damage
    end
    local normalDamage = damageStatisticsData:GetPetNormalDamageValue()
    local chainDamage = damageStatisticsData:GetPetChainDamageValue()
    local activeDamage = damageStatisticsData:GetPetActiveDamageValue()
    local buffDamage = damageStatisticsData:GetPetBuffDamageValue()
    local damageList = {}
    table.insert(damageList, normalDamage)
    table.insert(damageList, chainDamage)
    table.insert(damageList, activeDamage)
    table.insert(damageList, buffDamage)
    for damageTypeIndex, singleDamage in ipairs(damageList) do
      if singleDamage > maxDetailDamage then
        maxDetailDamage = singleDamage
      end
    end
  end
  for index, matchPetInfo in ipairs(self._matchPetData) do
    local matchPetTemplateID = matchPetInfo:GetTemplateID()
    local damageStatisticsData = dataDic[matchPetTemplateID]
    if damageStatisticsData then
      local uiData = UIBattleStatisticsCellData:New(damageStatisticsData, matchPetInfo)
      uiData:SetMaxTotalDamage(maxTotalDamage)
      uiData:SetMaxDetailDamage(maxDetailDamage)
      table.insert(self._uiTotalDataList, uiData)
      table.insert(self._uiDetailDataList, uiData)
    end
  end
  local specialPetTemplateID = -1
  local specialDamageStatisticsData = dataDic[specialPetTemplateID]
  if specialDamageStatisticsData then
    local uiData = UIBattleStatisticsCellData:New(specialDamageStatisticsData, nil)
    uiData:SetMaxTotalDamage(maxTotalDamage)
    uiData:SetMaxDetailDamage(maxDetailDamage)
    table.insert(self._uiTotalDataList, uiData)
  end
end

function UIBattleStatistics:InitCells()
  self:InitTotalCells()
  self:InitDetailCells()
  self._tabIndex = UIBattleStatisticsPanelInex.Total
  self:_LockForCellsAnim(1000)
end

function UIBattleStatistics:InitTotalCells()
  if not self._uiTotalDataList then
    return
  end
  local count = #self._uiTotalDataList
  self._totalCellGen:SpawnObjects("UIWidgetBattleStatisticsTotalCell", count)
  self._totalCells = self._totalCellGen:GetAllSpawnList()
  for i = 1, #self._totalCells do
    self._totalCells[i]:SetData(self._uiTotalDataList[i])
  end
  if 6 < count then
    self._totalScroll.vertical = true
  else
    self._totalScroll.vertical = false
  end
end

function UIBattleStatistics:InitDetailCells()
  if not self._uiDetailDataList then
    return
  end
  local count = #self._uiDetailDataList
  self._detailCellGen:SpawnObjects("UIWidgetBattleStatisticsDetailCell", count)
  self._detailCells = self._detailCellGen:GetAllSpawnList()
  for i = 1, #self._detailCells do
    self._detailCells[i]:SetData(self._uiDetailDataList[i])
  end
  if 5 < count then
    self._detailScroll.vertical = true
  else
    self._detailScroll.vertical = false
  end
end

function UIBattleStatistics:DotBGOnClick(go)
  self:CloseDialog()
end

function UIBattleStatistics:TotalBtnOnClick(go)
  if self._tabIndex == UIBattleStatisticsPanelInex.Total then
    return
  end
  self._tabIndex = UIBattleStatisticsPanelInex.Total
  self:_LockForCellsAnim(1000)
  self._btnSelectedCoverRect.anchoredPosition = Vector2(self._totalBtnSelectdPosX, 0)
  self._totalInfoAreaGo:SetActive(true)
  self._detailInfoAreaGo:SetActive(false)
  self._totalScroll.horizontalNormalizedPosition = 0
  self._detailScroll.horizontalNormalizedPosition = 0
  for i = 1, #self._totalCells do
    self._totalCells[i]:RefreshUI()
  end
end

function UIBattleStatistics:DetailBtnOnClick(go)
  if self._tabIndex == UIBattleStatisticsPanelInex.Detail then
    return
  end
  self._tabIndex = UIBattleStatisticsPanelInex.Detail
  self:_LockForCellsAnim(1000)
  self._btnSelectedCoverRect.anchoredPosition = Vector2(self._detailBtnSelectdPosX, 0)
  self._totalInfoAreaGo:SetActive(false)
  self._detailInfoAreaGo:SetActive(true)
  self._totalScroll.horizontalNormalizedPosition = 0
  self._detailScroll.horizontalNormalizedPosition = 0
  for i = 1, #self._detailCells do
    self._detailCells[i]:RefreshUI()
  end
end

function UIBattleStatistics:_LockForCellsAnim(timeLen)
  self:Lock("UIBattleStatistics_LockForCellsAnim")
  local te = GameGlobal.Timer():AddEvent(timeLen, function()
    self:UnLock("UIBattleStatistics_LockForCellsAnim")
  end)
  table.insert(self._timeEvents, te)
end
