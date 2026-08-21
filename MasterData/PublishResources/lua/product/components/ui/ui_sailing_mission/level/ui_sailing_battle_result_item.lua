_class("UISailingBattleResultItem", UICustomWidget)
UISailingBattleResultItem = UISailingBattleResultItem

function UISailingBattleResultItem:OnShow(uiParams)
  self._sailingProgressLabel = self:GetUIComponent("UILocalizationText", "SailingProgress")
  self._sailingLayerLabel = self:GetUIComponent("UILocalizationText", "SailingLayer")
  self._sailingNameLabel = self:GetUIComponent("UILocalizationText", "SailingName")
end

function UISailingBattleResultItem:Refresh(matchResult)
  local sailingMissionModule = GameGlobal.GetModule(SailingMissionModule)
  local layerId = matchResult.m_parent_mission_id
  local missionId = matchResult.m_nID
  local cfg = Cfg.cfg_sailing_mission[missionId]
  local layerCfg = Cfg.cfg_sailing_layer[layerId]
  local missionList = layerCfg.SailingMissionList
  local missionCount = table.count(missionList)
  self._sailingNameLabel:SetText(StringTable.Get(cfg.MissionName))
  self._sailingProgressLabel:SetText("<color=#ffbd1d>" .. matchResult.layer_mission_num .. "</color>/" .. missionCount)
  self._sailingLayerLabel:SetText(StringTable.Get("str_sailing_mission_level_result_layer_tips1", layerId))
  
  local function getDataFuc(layer_id, mission_Id)
    local t = {}
    local cfg = Cfg.cfg_sailing_mission[mission_Id]
    t.name = StringTable.Get(cfg.MissionName)
    t.complete = sailingMissionModule:IsMissionComplete(layer_id, mission_Id)
    return t
  end
  
  local index = 1
  for i = 1, #missionList do
    if missionList[i] == missionId then
      index = i
      break
    end
  end
  
  local function getPreLayerCfgFunc(layer_id)
    local cfgs = Cfg.cfg_sailing_layer({})
    for _, v in pairs(cfgs) do
      if v.NextLayerId == layer_id then
        return v
      end
    end
    return nil
  end
  
  local function getNextLayerCfgFunc(layer_id)
    local cfg = Cfg.cfg_sailing_layer[layer_id]
    if cfg.NextLayerId > 0 then
      return Cfg.cfg_sailing_layer[cfg.NextLayerId]
    end
    return nil
  end
  
  local leftCount = 3
  local leftDatas = {}
  for i = index - 1, 1, -1 do
    leftDatas[#leftDatas + 1] = getDataFuc(layerId, missionList[i])
    leftCount = leftCount - 1
    if leftCount <= 0 then
      break
    end
  end
  local currentLayerCfg = getPreLayerCfgFunc(layerId)
  while currentLayerCfg ~= nil and 0 < leftCount do
    local missions = currentLayerCfg.SailingMissionList
    for i = #missions, 1, -1 do
      leftDatas[#leftDatas + 1] = getDataFuc(currentLayerCfg.ID, missions[i])
      leftCount = leftCount - 1
      if leftCount <= 0 then
        break
      end
    end
    currentLayerCfg = getPreLayerCfgFunc(currentLayerCfg.ID)
  end
  local rightCount = 3
  local rightDatas = {}
  for i = index + 1, #missionList do
    rightDatas[#rightDatas + 1] = getDataFuc(layerId, missionList[i])
    rightCount = rightCount - 1
    if rightCount <= 0 then
      break
    end
  end
  local currentLayerCfg = getNextLayerCfgFunc(layerId)
  while currentLayerCfg ~= nil and 0 < rightCount do
    local missions = currentLayerCfg.SailingMissionList
    for i = 1, #missions do
      rightDatas[#rightDatas + 1] = getDataFuc(currentLayerCfg.ID, missions[i])
      rightCount = rightCount - 1
      if rightCount <= 0 then
        break
      end
    end
    currentLayerCfg = getNextLayerCfgFunc(currentLayerCfg.ID)
  end
  local leftItems = {
    "Level3",
    "Level2",
    "Level1"
  }
  local rightItems = {
    "Level4",
    "Level5",
    "Level6"
  }
  for i = 1, #leftItems do
    local data = leftDatas[i]
    if data ~= nil then
      local itemLoader = self:GetUIComponent("UISelectObjectPath", leftItems[i])
      local item = itemLoader:SpawnObject("UISailingBattleResultItemProcess")
      item:Refresh(data.name, data.complete)
    end
  end
  for i = 1, #rightItems do
    local data = rightDatas[i]
    if data ~= nil then
      local itemLoader = self:GetUIComponent("UISelectObjectPath", rightItems[i])
      local item = itemLoader:SpawnObject("UISailingBattleResultItemProcess")
      item:Refresh(data.name, data.complete)
    end
  end
end
