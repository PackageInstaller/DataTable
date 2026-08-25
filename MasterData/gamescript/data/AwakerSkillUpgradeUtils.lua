local AwakerSkillUpgradeUtils = {}

function AwakerSkillUpgradeUtils.GetCfg(tid)
  local rst = DT.AwakerSkillUpgrade[tid]
  if not rst then
    Logger.Debug("Error tid ", tid)
    return nil
  end
  return rst
end

function AwakerSkillUpgradeUtils.GetSkillUpgradeCost(tid, skillLevel, slot)
  local rst = {}
  local cfg = AwakerSkillUpgradeUtils.GetCfg(tid)
  if not cfg then
    return rst
  end
  for _, info in pairs(cfg.data_list) do
    if info.SkillLevel == skillLevel then
      rst = info[slot]
      break
    end
  end
  return rst
end

function AwakerSkillUpgradeUtils.GetSkillUpgradeCostCoinGroup(tid, skillLevel, slot)
  local coinTid = DT.GetConstant("GoldItemTid")
  local costGroup = AwakerSkillUpgradeUtils.GetSkillUpgradeCost(tid, skillLevel, slot)
  if not costGroup then
    Logger.Error("GetSkillUpgradeCostCoinGroup costGroup is nil, tid=", tid, "skillLevel=", skillLevel, "slot=", slot)
    return coinTid, 0
  end
  for i = 1, #costGroup, 2 do
    local costTid = costGroup[i]
    local costNum = costGroup[i + 1]
    if costTid == coinTid then
      return coinTid, costNum
    end
  end
  return coinTid, 0
end

function AwakerSkillUpgradeUtils.GetSkillUpgradeCostItemGroup(tid, skillLevel, slot)
  local coinTid = DT.GetConstant("GoldItemTid")
  local rst = {}
  local costGroup = AwakerSkillUpgradeUtils.GetSkillUpgradeCost(tid, skillLevel, slot)
  if not costGroup then
    Logger.Error("GetSkillUpgradeCostItemGroup costGroup is nil, tid=", tid, "skillLevel=", skillLevel, "slot=", slot)
    return rst
  end
  for i = 1, #costGroup, 2 do
    local costTid = costGroup[i]
    local costNum = costGroup[i + 1]
    if costTid ~= coinTid then
      table.insert(rst, {tid = costTid, num = costNum})
    end
  end
  return rst
end

return AwakerSkillUpgradeUtils
