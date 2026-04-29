local UIBuildComponentBuildStatus = {
  Init = 0,
  CleanUpComplete = 1,
  RepairComplete = 2,
  DecorateComplete = 4,
  Picnic = 1024
}
_enum("UIBuildComponentBuildStatus", UIBuildComponentBuildStatus)
_class("UIBuildComponentBuildItemData", Object)
UIBuildComponentBuildItemData = UIBuildComponentBuildItemData

function UIBuildComponentBuildItemData:Constructor(componentCfgID)
  self._componentCfgID = componentCfgID
  local cfgs = Cfg.cfg_component_build_item({ComponentID = componentCfgID})
  self._buildDataMap = self:_InitBuildDataMap(cfgs)
  self._buildDataStoryReviewIdMap = self:_InitBuildDataStoryReviewIdMap(cfgs)
  self._buildDataItemId = self:_InitBuildDataCostItemId(cfgs)
end

function UIBuildComponentBuildItemData:_InitBuildDataMap(tb_in)
  local tb_out = {}
  for _, v in pairs(tb_in) do
    local id, st = self:GetItemIdAndStatus(v)
    if not tb_out[id] then
      tb_out[id] = {}
    end
    local item = tb_out[id]
    if item[st] then
      Log.exception("UIBuildComponentBuildItemData:GetBuildStatusMap()", " repeat [BuildItemId, BuildStatus] in cfg_component_build_item", " componentCfgID = " .. self._componentCfgID)
    end
    item[st] = v
  end
  return tb_out
end

function UIBuildComponentBuildItemData:_InitBuildDataStoryReviewIdMap(tb_in)
  local tb_out = {}
  for _, v in pairs(tb_in) do
    local reviewId = self:GetStoryReviewId(v)
    if reviewId then
      if tb_out[reviewId] then
        Log.exception("UIBuildComponentBuildItemData:_InitBuildDataStoryReviewIdMap()", " repeat [StoryReviewId] in cfg_component_build_item", " componentCfgID = " .. self._componentCfgID, " StoryReviewId = " .. reviewId)
      end
      local id, st = self:GetItemIdAndStatus(v)
      tb_out[reviewId] = {buildItemId = id, status = st}
    end
  end
  return tb_out
end

function UIBuildComponentBuildItemData:_InitBuildDataCostItemId(tb_in)
  for _, v in pairs(tb_in) do
    local itemId = self:GetCostItemId(v)
    if itemId then
      return itemId
    end
  end
end

function UIBuildComponentBuildItemData:GetBuildItemDataMap()
  return self._buildDataMap
end

function UIBuildComponentBuildItemData:GetBuildItemIdList()
  local tb_out = table.keys(self._buildDataMap)
  return tb_out
end

function UIBuildComponentBuildItemData:GetBuildItemIdList_Picnic()
  local tb_out = {}
  for k, v in pairs(self._buildDataMap) do
    if v[UIBuildComponentBuildStatus.Picnic] then
      table.insert(tb_out, k)
    end
  end
  return tb_out
end

function UIBuildComponentBuildItemData:GetBuildItemStatusList(buildItemId)
  local tb_out = table.keys(self._buildDataMap[buildItemId])
  table.sort(tb_out)
  return tb_out
end

function UIBuildComponentBuildItemData:GetBuildItemData(buildItemId, buildStatus)
  local data = self._buildDataMap[buildItemId][buildStatus]
  if not data then
    Log.exception("UIBuildComponentBuildItemData:GetBuildItemData() buildItemId = ", buildItemId, " buildStatus = ", buildStatus)
  end
  return data
end

function UIBuildComponentBuildItemData:GetNeedBuildItemIdAndStatus(buildItemId, buildStatus)
  local data = self:GetBuildItemData(buildItemId, buildStatus)
  return self:GetNeedItemIdAndStatus(data)
end

function UIBuildComponentBuildItemData:GetBuildDataStoryReviewIdMap()
  return self._buildDataStoryReviewIdMap
end

function UIBuildComponentBuildItemData:GetBuildDataItemId()
  return self._buildDataItemId
end

function UIBuildComponentBuildItemData:GetItemIdAndStatus(cfg)
  return cfg.BuildItemId, cfg.BuildStatus
end

function UIBuildComponentBuildItemData:GetNeedItemIdAndStatus(cfg)
  return cfg.NeedItemId, cfg.NeedItemStatus
end

function UIBuildComponentBuildItemData:GetWidgetDesPos(cfg)
  return Vector2(cfg.WidgetDesPos[1], cfg.WidgetDesPos[2])
end

function UIBuildComponentBuildItemData:GetWidgetPos(cfg)
  return Vector2(cfg.WidgetPos[1], cfg.WidgetPos[2])
end

function UIBuildComponentBuildItemData:GetIconPos(cfg)
  return Vector2(cfg.IconConfig[1], cfg.IconConfig[2])
end

function UIBuildComponentBuildItemData:GetIconWidth(cfg)
  return cfg.IconConfig[3]
end

function UIBuildComponentBuildItemData:GetIconHeight(cfg)
  return cfg.IconConfig[4]
end

function UIBuildComponentBuildItemData:GetIconRotate(cfg)
  return cfg.IconConfig[5]
end

function UIBuildComponentBuildItemData:GetTriggerPos(cfg)
  return Vector2(cfg.TriggerArea[1], cfg.TriggerArea[2])
end

function UIBuildComponentBuildItemData:GetTriggerWidth(cfg)
  return cfg.TriggerArea[3]
end

function UIBuildComponentBuildItemData:GetTriggerHeight(cfg)
  return cfg.TriggerArea[4]
end

function UIBuildComponentBuildItemData:GetTriggerRotate(cfg)
  return cfg.TriggerArea[5]
end

function UIBuildComponentBuildItemData:GetEffectAreaPos(cfg)
  local x = cfg.EffectArea[1] or 0
  local y = cfg.EffectArea[2] or 0
  return Vector2(x, y)
end

function UIBuildComponentBuildItemData:GetEffectAreaScale(cfg)
  return cfg.EffectArea[3] and cfg.EffectArea[3] / 100 or 1
end

function UIBuildComponentBuildItemData:GetLayer(cfg)
  return cfg.Layer
end

function UIBuildComponentBuildItemData:GetCost(cfg)
  return cfg.BuildCost
end

function UIBuildComponentBuildItemData:GetCostItemId(cfg)
  return cfg.BuildCost and cfg.BuildCost[1] and cfg.BuildCost[1][1]
end

function UIBuildComponentBuildItemData:GetCostCount(cfg)
  return cfg.BuildCost and cfg.BuildCost[1][1] and cfg.BuildCost[1][2]
end

function UIBuildComponentBuildItemData:GetBuildReward(cfg)
  local tb_out = {}
  if cfg.BuildReward then
    for i = 1, #cfg.BuildReward do
      local roleAsset = RoleAsset:New()
      roleAsset.assetid = cfg.BuildReward[i][1]
      roleAsset.count = cfg.BuildReward[i][2]
      table.insert(tb_out, roleAsset)
    end
  end
  return tb_out
end

function UIBuildComponentBuildItemData:GetStoryId(cfg)
  return cfg.StoryId
end

function UIBuildComponentBuildItemData:GetStoryType(cfg)
  return cfg.StoryType
end

function UIBuildComponentBuildItemData:GetStoryReviewId(cfg)
  return cfg.StoryReviewId
end

function UIBuildComponentBuildItemData:GetStatusName(cfg)
  return cfg.StatusName and StringTable.Get(cfg.StatusName) or ""
end

function UIBuildComponentBuildItemData:GetDes(cfg)
  return cfg.Des and StringTable.Get(cfg.Des) or ""
end

function UIBuildComponentBuildItemData:GetIcon(cfg)
  return cfg.Icon or ""
end

function UIBuildComponentBuildItemData:GetSpine(cfg)
  if not cfg.SpineName then
    return
  end
  local name = cfg.SpineName[1] or ""
  local ani = cfg.SpineName[2] or ""
  return name, ani
end

function UIBuildComponentBuildItemData:GetName(cfg)
  return StringTable.Get(cfg.Name)
end

function UIBuildComponentBuildItemData:IsShow(cfg)
  return cfg.IsShow == 1
end

function UIBuildComponentBuildItemData:GetTipsIcon(cfg)
  return cfg.TipsIcon
end
