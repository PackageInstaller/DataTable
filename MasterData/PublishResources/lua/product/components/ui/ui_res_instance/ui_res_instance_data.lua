_class("UIResInstanceData", Object)
UIResInstanceData = UIResInstanceData
local StringGet = StringTable.Get

function UIResInstanceData:Constructor(instanceId)
  self.cfg = Cfg.cfg_res_instance_detail[instanceId]
  self.aircraftModule = GameGlobal.GetModule(AircraftModule)
  self:InitRewards()
end

function UIResInstanceData:InitRewards()
  self.rewards = {}
  local list, randomList = UICommonHelper:GetInstance():GetPassAward(AwardHeadType.ResInstance, self.cfg.ID, true)
  if list then
    for index, value in ipairs(list) do
      local reward = {}
      reward.id = value.ItemID
      reward.count = value.Count
      reward.randomType = value.Type
      reward.fix = true
      local cfg = Cfg.cfg_item[value.ItemID]
      if cfg then
        reward.name = StringGet(cfg.Name)
        reward.icon = cfg.Icon
        reward.color = cfg.Color
      end
      table.insert(self.rewards, reward)
    end
  end
  if randomList then
    for index, value in ipairs(randomList) do
      local reward = {}
      reward.id = value.ItemID
      reward.count = value.Count
      reward.randomType = value.Type
      reward.fix = false
      local cfg = Cfg.cfg_item[value.ItemID]
      if cfg then
        reward.name = StringGet(cfg.Name)
        reward.icon = cfg.Icon
        reward.color = cfg.Color
      end
      table.insert(self.rewards, reward)
    end
  end
end

function UIResInstanceData:GetId()
  return self.cfg and self.cfg.ID or 0
end

function UIResInstanceData:GetMainType()
  return self.cfg and self.cfg.MainType or 0
end

function UIResInstanceData:GetName()
  return self.cfg and StringGet(self.cfg.Name) or ""
end

function UIResInstanceData:GetLevelNum()
  return self.cfg and self.cfg.Lv or 0
end

function UIResInstanceData:GetUnLockLevel()
  return self.cfg and self.cfg.UnlockCondition or 0
end

function UIResInstanceData:GetLevelCN()
  return self.cfg.LvCN and StringGet(self.cfg.LvCN) or ""
end

function UIResInstanceData:GetDifficultyName()
  return self.cfg and StringGet(self.cfg.DifficultyName) or ""
end

function UIResInstanceData:GetPower()
  if self.cfg then
    return self.cfg.NeedPower or 0
  end
  return 0
end

function UIResInstanceData:GetRewards()
  return self.rewards
end

function UIResInstanceData:GetId()
  return self.cfg and self.cfg.ID or 0
end

function UIResInstanceData:GetSubType()
  return self.cfg and self.cfg.SubType or 0
end

function UIResInstanceData:Open()
  local mainType = self:GetMainType()
  local resModule = GameGlobal.GetModule(ResDungeonModule)
  local sList = resModule:GetInstanceDataList(mainType)
  if sList and table.ikey(sList, self:GetId()) then
    return true
  else
    return false
  end
end

function UIResInstanceData:GetWarn()
  local s = StringTable.Get("str_res_instance_detail_detail_lock_str")
  return string.format(s, self:GetUnLockLevel())
end

function UIResInstanceData:GetEnemys()
  return self.cfg and self.cfg.MonsterList or ""
end

function UIResInstanceData:GetLevelId()
  return self.cfg and self.cfg.FightLevelid or 0
end

function UIResInstanceData:GetWorldBuffId()
  return self.cfg and self.cfg.WordBuff or 0
end
