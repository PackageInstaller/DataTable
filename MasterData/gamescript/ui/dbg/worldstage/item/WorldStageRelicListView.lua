local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local GameObject = CS.UnityEngine.GameObject
local WorldStageRelicListView, Super = System.NewComponent("WorldStageRelicListView")

function WorldStageRelicListView:ctor(res)
  Super.ctor(self)
  self.ui = UIBaseResource(res)
  self.relicItemList = {}
  self._emptyItemList = {}
  self.visible = true
  self._cellSpacing = -16
  self._gridColomn = CommonDefine.StageRelicGrid
  self._cellSize = 100
end

function WorldStageRelicListView:OnBind(binder)
  self.binder = binder
  self.binder:SetActive(self.ui.Item_Battle_Dbg_Relic, false)
  self:BindRelicEvents()
  self:_BindMaxRelicNumChange()
  self:RefreshRelicList()
end

function WorldStageRelicListView:_BindMaxRelicNumChange()
  self.binder:BindToRaw(function(cbinder, num, _)
    cbinder:BindToRaw(function(ccbinder, isExtended)
      self:ApplyGridConfig(isExtended)
      self:RefreshRelicList()
      EventMgr.Instance.OnExtendedRelicNum:Dispatch(isExtended)
    end, function()
      do return self.IsExtendedRelicNum end
      return self.IsExtendedRelicNum, self
    end)
  end, function()
    do return self.GetMaxRelicNum end
    return self.GetMaxRelicNum, self
  end)
end

function WorldStageRelicListView:ApplyGridConfig(isExtended)
  if nil == isExtended then
    isExtended = self:IsExtendedRelicNum()
  end
  if isExtended then
    self._gridColomn = CommonDefine.StageRelicGridMax
    self._cellSize = 67
  else
    self._gridColomn = CommonDefine.StageRelicGrid
    self._cellSize = 100
  end
end

function WorldStageRelicListView:BindRelicEvents()
  self.binder:BindEvent(EventMgr.Instance.OnRelicDataChange, System.fn(self, self.OnRelicDataChange))
end

function WorldStageRelicListView:OnRelicDataChange(data)
  self:RefreshRelicList()
end

function WorldStageRelicListView:GetMaxRelicNum()
  if bg.battleRender then
    local playerData = bg.battleDataCenter:GetPlayerRoleDataModel()
    if playerData then
      do return playerData.GetProperty, playerData end
      return playerData.GetProperty, playerData, "relic_num_limit"
    end
  end
  do return CopyAwakerDataUtils.GetAwakerAttrs, 0 end
  return CopyAwakerDataUtils.GetAwakerAttrs, 0, "relic_num_limit", "relic_num_limit"
end

function WorldStageRelicListView:IsExtendedRelicNum()
  local propertyValue = 0
  if bg.battleRender then
    local playerData = bg.battleDataCenter:GetPlayerRoleDataModel()
    if playerData then
      propertyValue = playerData:GetProperty("ExtendedCreationLimit")
    end
  else
    propertyValue = CopyAwakerDataUtils.GetAwakerAttrs(0, "ExtendedCreationLimit")
  end
  return propertyValue and propertyValue >= 1
end

function WorldStageRelicListView:InitRelicList()
  if bg.battleRender then
    self._relicDataList = self:GetBattleRelicList()
  else
    self._relicDataList = self:GetStageRelicList()
  end
end

function WorldStageRelicListView:GetBattleRelicList()
  local relicDatas = bg.battleRender.relicMgr:GetAllRelicDatas()
  local relicKeyId = DT.GetConstant("RelicKey")
  local relicList = {}
  for k, v in ipairs(relicDatas) do
    if v.tid ~= relicKeyId then
      table.insert(relicList, v)
    end
  end
  return relicList
end

function WorldStageRelicListView:GetStageRelicList()
  do return RelicDataUtils.SortRelics, RelicDataUtils.GetAllRelicDatas() end
  return RelicDataUtils.SortRelics, RelicDataUtils.GetAllRelicDatas()
end

function WorldStageRelicListView:IsCanGetMaxRelicNum()
  return self:GetMaxRelicNum() >= CommonDefine.RelicNumMax
end

function WorldStageRelicListView:RefreshRelicList()
  self:ApplyGridConfig()
  self:InitRelicList()
  local relicList = self._relicDataList or {}
  local filledCount = #relicList
  if 0 == filledCount then
    self:ClearAllRelicItems()
    self.binder:SetActive(self.ui.uiNode, false)
    return
  end
  self.binder:SetActive(self.ui.uiNode, true)
  local maxRelicNum = self:GetMaxRelicNum() or filledCount
  local displayCount = math.min(filledCount, maxRelicNum)
  local scale = self:IsExtendedRelicNum() and 0.67 or 1
  local aliveUids = {}
  for index = 1, displayCount do
    local relicData = relicList[index]
    local uid = relicData and relicData.uid
    if uid then
      aliveUids[uid] = true
      local itemComp = self.relicItemList[uid]
      if not itemComp then
        itemComp = self:CreateRelicItem(relicData, index)
        self.relicItemList[uid] = itemComp
      else
        self:ApplyRelicItemData(itemComp, relicData, index)
      end
      self:LayoutRelicItem(itemComp.res, index, scale)
      self.binder:SetActive(itemComp.res, true)
    end
  end
  for uid, itemComp in pairs(self.relicItemList) do
    if not aliveUids[uid] then
      self:DestroyRelicItem(itemComp)
      self.relicItemList[uid] = nil
    end
  end
  self:RefreshEmptySlots(maxRelicNum, displayCount, scale)
  self:UpdateContentSize(maxRelicNum)
end

function WorldStageRelicListView:CreateRelicItem(relicData, index)
  local go = self.binder:Instantiate(self.ui.Item_Battle_Dbg_Relic, self.ui.Content.transform)
  go.name = string.format("Item_Battle_Dbg_Relic_%s", tostring(relicData and relicData.uid or "empty_" .. index))
  local itemComp = self.binder:BindComponent(RelicBattleSceneItemComponent(go, relicData, self.ui.Relic_Tip_Pos, index))
  return itemComp
end

function WorldStageRelicListView:ApplyRelicItemData(itemComp, relicData, index)
  itemComp.index = index
  itemComp.relic = relicData
  if relicData then
    itemComp.relic.tid = relicData.tid or relicData.relicTid
    itemComp.relic.relicTid = itemComp.relic.tid
    itemComp.relicConfig = DT.RelicConfig[itemComp.relic.tid]
  end
end

function WorldStageRelicListView:GetGridStep()
  return (self._cellSize or 100) + (self._cellSpacing or -16)
end

function WorldStageRelicListView:LayoutRelicItem(go, index, scale)
  if IsNil(go) then
    return
  end
  local cols = self._gridColomn or CommonDefine.StageRelicGrid
  local step = self:GetGridStep()
  local idx = index - 1
  local col = idx % cols
  local row = math.floor(idx / cols)
  local rt = go.transform
  rt.localScale = Vector3(scale, scale, 1)
  rt.localPosition = Vector3(col * step, -row * step, 0)
end

function WorldStageRelicListView:UpdateContentSize(maxRelicNum)
  local content = self.ui.Content
  if IsNil(content) then
    return
  end
  local cols = self._gridColomn or CommonDefine.StageRelicGrid
  local size = self._cellSize or 100
  local step = self:GetGridStep()
  local rows = math.max(1, math.ceil(maxRelicNum / cols))
  local width = (cols - 1) * step + size
  local height = (rows - 1) * step + size
  content.transform.sizeDelta = Vector2(width, height)
end

function WorldStageRelicListView:RefreshEmptySlots(maxRelicNum, filledCount, scale)
  for index = 1, maxRelicNum do
    if index <= filledCount then
      local emptyComp = self._emptyItemList[index]
      if emptyComp and not IsNil(emptyComp.res) then
        self.binder:SetActive(emptyComp.res, false)
      end
    else
      local emptyComp = self._emptyItemList[index]
      if not emptyComp then
        emptyComp = self:CreateRelicItem(nil, index)
        self._emptyItemList[index] = emptyComp
      end
      self:LayoutRelicItem(emptyComp.res, index, scale)
      self.binder:SetActive(emptyComp.res, true)
    end
  end
  for index, emptyComp in pairs(self._emptyItemList) do
    if maxRelicNum < index and not IsNil(emptyComp.res) then
      self.binder:SetActive(emptyComp.res, false)
    end
  end
end

function WorldStageRelicListView:DestroyRelicItem(itemComp)
  if not itemComp then
    return
  end
  if itemComp.binder then
    itemComp.binder:teardown()
  end
  if not IsNil(itemComp.res) then
    GameObject.Destroy(itemComp.res)
  end
end

function WorldStageRelicListView:ClearAllRelicItems()
  for uid, itemComp in pairs(self.relicItemList) do
    self:DestroyRelicItem(itemComp)
    self.relicItemList[uid] = nil
  end
  for index, emptyComp in pairs(self._emptyItemList) do
    self:DestroyRelicItem(emptyComp)
    self._emptyItemList[index] = nil
  end
end

return WorldStageRelicListView
