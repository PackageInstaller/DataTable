local EpDataCenter = class("EpDataCenter")
local eDetailType = require("Game.Sector.Enum.SectorLevelDetailEnum").eDetailType

function EpDataCenter:ctor()
end

function EpDataCenter:InitEpDataCenter()
  self.epChipIdDic = {}
  self.__onSetEpChipUpdate = BindCallback(self, self.OnSetEpChipUpdate)
  MsgCenter:AddListener(eMsgEventId.SectorChipSet, self.__onSetEpChipUpdate)
end

function EpDataCenter:GetStageEpChipData(stageCfg)
  local chipDic = {}
  for k, v in pairs(stageCfg.function_extra) do
    chipDic[v] = true
  end
  for _, epId in pairs(stageCfg.exploration_list) do
    local epCfg = ConfigData.exploration[epId]
    if epCfg ~= nil then
      for _, poolId in pairs(epCfg.chip_pool) do
        local funcPoolCfg = ConfigData.ep_function_pool[poolId]
        if funcPoolCfg ~= nil then
          for _, chipId in pairs(funcPoolCfg.function_pool) do
            chipDic[chipId] = true
          end
        end
      end
    end
  end
  for itemId, _ in pairs(chipDic) do
    local isChip = ConfigData:GetItemType(itemId) == eItemType.GlobalChip
    if isChip then
      self.epChipIdDic[itemId] = true
    end
  end
end

function EpDataCenter:GetInfinityEpChipData(infinityCfg)
  local chipDic = {}
  for k, v in pairs(infinityCfg.chip) do
    chipDic[v] = true
  end
  for itemId, _ in pairs(chipDic) do
    local isChip = ConfigData:GetItemType(itemId) == eItemType.GlobalChip
    if isChip then
      self.epChipIdDic[itemId] = true
    end
  end
end

function EpDataCenter:OnSetEpChipUpdate(chipSetTab)
  for chipId, _ in pairs(self.epChipIdDic) do
    if chipSetTab[chipId] ~= nil then
      self.epChipIdDic[chipId] = false
    end
  end
end

function EpDataCenter:AddNewChip(chipId)
  if chipId == nil then
    error("chipId is not found")
    return
  end
  local isNew = self:IsNewChip(chipId)
  if isNew or isNew == nil then
    self.epChipIdDic[chipId] = false
  end
end

function EpDataCenter:IsNewChip(chipId)
  return self.epChipIdDic[chipId]
end

function EpDataCenter:GetEpChipIdDic()
  return self.epChipIdDic
end

function EpDataCenter:CleanEpDataCenter()
  self.levelChipIdDic = nil
  MsgCenter:RemoveListener(eMsgEventId.SectorChipSet, self.__onSetEpChipUpdate)
end

return EpDataCenter
