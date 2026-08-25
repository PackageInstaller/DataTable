local KeeperSkillUtils = {}
local KeeperSkillList = {}

function KeeperSkillUtils.GetDefaultItem()
  return 0
end

function KeeperSkillUtils.GetKeeperSkillList()
  if table.next(KeeperSkillList) then
    return KeeperSkillList
  end
  for _, skillCfg in pairs(DT.Skill) do
    local skillTypes = BattleUtilServer.GetTQList(skillCfg.Type, 0, 0)
    for _, skillType in ipairs(skillTypes) do
      if "Keeper_Skill" == skillType then
        table.insert(KeeperSkillList, skillCfg.ID)
      end
    end
  end
  return KeeperSkillList
end

function KeeperSkillUtils.CheckSkillItemIsPvpOnly(itemTid)
  if not itemTid then
    return false
  end
  local pvpOnlySkillTidList = KeeperSkillUtils.GetPvpOnlySkillTidList()
  do return table.contains, pvpOnlySkillTidList end
  return table.contains, pvpOnlySkillTidList, itemTid
end

local PvpOnlySkillTidList = {}

function KeeperSkillUtils.GetPvpOnlySkillTidList()
  local rst = {}
  if table.next(PvpOnlySkillTidList) then
    return PvpOnlySkillTidList
  end
  for _, itemCfg in pairs(DT.Item) do
    if itemCfg.Type == CommonDefine.ItemType.KeeperSkill and not itemCfg.SpParam then
      table.insert(rst, itemCfg.ID)
    end
  end
  PvpOnlySkillTidList = rst
  return rst
end

function KeeperSkillUtils.GetSortedSkillList(firstSkillId)
  local list = {}
  local serverTime = TimeUtils.GetServerTime()
  for _, skillId in ipairs(KeeperSkillUtils.GetKeeperSkillList()) do
    local itemId = KeeperSkillUtils.GetItemIdBySkill(skillId)
    local itemCfg = DT.Item[itemId]
    if itemCfg and (not itemCfg.StartDropDate or serverTime >= itemCfg.StartDropDate) then
      table.insert(list, skillId)
    end
  end
  table.sort(list, function(a, b)
    if firstSkillId and (a == firstSkillId or b == firstSkillId) then
      return a == firstSkillId
    end
    local isUnlockedA = KeeperSkillUtils.IsUnlocked(a)
    local isUnlockedB = KeeperSkillUtils.IsUnlocked(b)
    if isUnlockedA ~= isUnlockedB then
      return isUnlockedA
    end
    local itemCfgA = KeeperSkillUtils.GetItemCfg(a)
    local itemCfgB = KeeperSkillUtils.GetItemCfg(b)
    return itemCfgA.BaseSortID < itemCfgB.BaseSortID
  end)
  return list
end

function KeeperSkillUtils.GetOwnedSkillList()
  local list = {}
  for _, skillId in ipairs(KeeperSkillUtils.GetKeeperSkillList()) do
    if KeeperSkillUtils.IsUnlocked(skillId) then
      table.insert(list, skillId)
    end
  end
  return list
end

function KeeperSkillUtils.GetOwnedSkillCount()
  local count = 0
  local Type = cd.ItemType.KeeperSkill
  for itemId, itemCfg in pairs(DT.Item) do
    if itemCfg.Type == Type and ItemDataUtils.GetItemNum(itemId) > 0 then
      count = count + 1
    end
  end
  return count
end

function KeeperSkillUtils.IsKeeperSkillItem(itemId)
  local itemData = DataCenter.itemData
  return itemData.Item2KeeperSkill[itemId] ~= nil
end

function KeeperSkillUtils.GetSkillIdByItem(itemId)
  if not itemId then
    return 0
  end
  local itemData = DataCenter.itemData
  if itemData.KeeperSkill2Item[itemId] then
    return itemId
  end
  return itemData.Item2KeeperSkill[itemId]
end

function KeeperSkillUtils.GetItemIdBySkill(skillId)
  if not skillId then
    return 0
  end
  local itemData = DataCenter.itemData
  if itemData.Item2KeeperSkill[skillId] then
    return skillId
  end
  return itemData.KeeperSkill2Item[skillId]
end

function KeeperSkillUtils.GetSkillTimelinePath(tid)
  if not tid then
    return
  end
  local keeperSkillCfg = KeeperSkillUtils.GetSkillCfg(tid)
  if not keeperSkillCfg then
    return
  end
  local Perform = keeperSkillCfg.Perform and keeperSkillCfg.Perform[1] or nil
  if not Perform then
    return
  end
  local KeepData = bg.DT.TimelineEventData.BUnit_Keeper
  if not KeepData then
    return
  end
  local timelineData = KeepData[Perform]
  if not timelineData or not timelineData.file then
    return
  end
  return timelineData.file
end

function KeeperSkillUtils.GetSkillCfg(skillId)
  skillId = KeeperSkillUtils.GetSkillIdByItem(skillId)
  return DT.Skill[skillId] or {}
end

function KeeperSkillUtils.GetItemCfg(skillIdOrItemId)
  local itemId = KeeperSkillUtils.GetItemIdBySkill(skillIdOrItemId)
  return DT.Item[itemId] or {}
end

function KeeperSkillUtils.GetSkillIcon(skillId)
  local itemId = KeeperSkillUtils.GetItemIdBySkill(skillId)
  local itemCfg = DT.Item[itemId]
  return itemCfg and itemCfg.SpIcon or ""
end

function KeeperSkillUtils.GetBigImage(skillIdOrItemId)
  local cfg = KeeperSkillUtils.GetItemCfg(skillIdOrItemId)
  return type(cfg.PossePic) == "table" and cfg.PossePic[1]
end

function KeeperSkillUtils.GetDisplayImage(skillIdOrItemId)
  local cfg = KeeperSkillUtils.GetItemCfg(skillIdOrItemId)
  return cfg.PosseDiamondChart
end

function KeeperSkillUtils.GetSkillName(skillId)
  local skillConfig = DT.Skill[skillId]
  do return BattleSkillUtils.GetSkillName, skillConfig, 0 end
  return BattleSkillUtils.GetSkillName, skillConfig, 0, 0
end

function KeeperSkillUtils.GetSkillDesc(skillTid, skilArgs)
  local skillCfg = SkillCfgUtils.GetCfg(skillTid)
  local desc = skillCfg.Desc
  if type(desc) == "table" then
    desc = desc[1] and desc[1][2]
  end
  local inBattle = SceneMgr.Instance and SceneMgr.Instance:IsInCopies() or bg.battleScene
  desc = inBattle and SkillCfgUtils.GetFieldBattleDesc(skillTid) or desc
  local parserEnv = {skillId = skillTid}
  local cmdParser = BattleCmdParserClient(parserEnv)
  do return SkillUtils.FillAwakerSkillDesc, cmdParser, desc end
  return SkillUtils.FillAwakerSkillDesc, cmdParser, desc, skilArgs
end

function KeeperSkillUtils.GetKeeperSkillDesc(keeperSkillItem, skilArgs)
  local skillId = KeeperSkillUtils.GetSkillIdByItem(keeperSkillItem)
  do return KeeperSkillUtils.GetSkillDesc, skillId end
  return KeeperSkillUtils.GetSkillDesc, skillId, skilArgs
end

function KeeperSkillUtils.GetKeeperSkillPerCost(skillId)
  do return end
  return KeeperSkillUtils.GetCost
end

function KeeperSkillUtils.GetKeeperMaxEnergy()
  local max_keeper_energy_per = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.max_keeper_energy_per)
  local max_keeper_energy = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.max_keeper_energy)
  local keeper_energy_cost_per = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.keeper_energy_cost_per)
  return max_keeper_energy * (1 + max_keeper_energy_per / 100) * (1 + keeper_energy_cost_per / 100)
end

function KeeperSkillUtils.GetKeeperEnergy()
  do return bg.battleDataCenter.GetPlayerRoleProperty, bg.battleDataCenter end
  return bg.battleDataCenter.GetPlayerRoleProperty, bg.battleDataCenter, bc.RoleProperty.keeper_energy
end

function KeeperSkillUtils.GetKeeperSkillEnergyLevel(keeper_energy)
  local rst = math.floor(keeper_energy / KeeperSkillUtils.GetCost())
  rst = math.max(CommonDefine.KeeperSkillEnergyMinLevel, rst)
  rst = math.min(CommonDefine.KeeperSkillEnergyMaxLevel, rst)
  return rst
end

function KeeperSkillUtils.GetCost()
  local max_keeper_energy = 0
  local keeper_energy_cost_per = 0
  if bg.battleDataCenter then
    max_keeper_energy = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.max_keeper_energy) or 0
    keeper_energy_cost_per = bg.battleDataCenter:GetPlayerRoleProperty(bc.RoleProperty.keeper_energy_cost_per) or 0
  else
    max_keeper_energy = CopyAwakerDataUtils.GetAwakerAttrs(0, "max_keeper_energy") or 0
    keeper_energy_cost_per = CopyAwakerDataUtils.GetAwakerAttrs(0, "keeper_energy_cost_per") or 0
  end
  return max_keeper_energy * (1 + keeper_energy_cost_per / 100)
end

function KeeperSkillUtils.IsUnlocked(skillId)
  local itemId = KeeperSkillUtils.GetItemIdBySkill(skillId)
  if not itemId then
    return false
  end
  return ItemDataUtils.GetItemNum(itemId) > 0
end

function KeeperSkillUtils.CheckCanUseKeeperSkill()
  return bg.battleDataCenter:IsMyActionCamp() and not bg.battleRender:IsInSelectCard()
end

function KeeperSkillUtils.OpenUseKeeperSkillConfirm(roleInfo)
  if not KeeperSkillUtils.CheckCanUseKeeperSkill() then
    return
  end
  local isConfirm = SettingManager.Instance:GetBoolSettingData(CommonDefine.SettingUniqueName.UltiSkillConfirm)
  if isConfirm or bg.battleDataCenter:IsNewChaosSchool() then
    UIManager.Instance:Reopen(Urls.BattleKeeperSkillAwakeTips, roleInfo)
  else
    KeeperSkillUtils.UseKeeperSkill()
  end
end

function KeeperSkillUtils.UseKeeperSkill()
  local opMode = bg.battleDataCenter:GetOpMode()
  if opMode ~= rc.OpMode.Play then
    return
  end
  local skillId = bg.battleDataCenter:GetPlayerKeeperSkill()
  bg.battleRender:SendCommand(BattleCommand.lg_UseKeeperSkill, {skillId = skillId})
end

function KeeperSkillUtils.UseChaosType2Skill()
  local opMode = bg.battleDataCenter:GetOpMode()
  if opMode ~= rc.OpMode.Play then
    return
  end
  if not bg.battleDataCenter:IsNewChaosSchool() then
    return
  end
  bg.battleRender:SendCommand(BattleCommand.lg_UseChaosType2Skill)
end

function KeeperSkillUtils.UseChaosType2Skill2()
  local opMode = bg.battleDataCenter:GetOpMode()
  if opMode ~= rc.OpMode.Play then
    print("[UseChaosType2Skill2] return: opMode is not Play", opMode)
    return
  end
  if not bg.battleDataCenter:IsNewChaosSchool() then
    print("[UseChaosType2Skill2] return: not new chaos school")
    return
  end
  bg.battleRender:SendCommand(BattleCommand.lg_UseChaosType2Skill2)
end

function KeeperSkillUtils.UseKeeperSkillAwake()
  local opMode = bg.battleDataCenter:GetOpMode()
  if opMode ~= rc.OpMode.Play then
    return
  end
  bg.battleRender:SendCommand(BattleCommand.lg_UseSilverKeyAwake)
end

function KeeperSkillUtils.GetKeeperSkillCostPercent(skillEnergy)
  local perCost = KeeperSkillUtils.GetCost()
  if 0 == skillEnergy or 0 == perCost then
    return 0
  end
  return skillEnergy % perCost / perCost
end

local KeeperSkillProgressInfo = {
  [CommonDefine.KeeperSkillEnergyLevel.Neg4] = {
    progressImg = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_KeeperSkill_01.png"
  },
  [CommonDefine.KeeperSkillEnergyLevel.Neg3] = {
    progressImg = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_KeeperSkill_02.png"
  },
  [CommonDefine.KeeperSkillEnergyLevel.Neg2] = {
    progressImg = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_KeeperSkill_03.png"
  },
  [CommonDefine.KeeperSkillEnergyLevel.Neg1] = {
    progressImg = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_KeeperSkill_04.png"
  },
  [CommonDefine.KeeperSkillEnergyLevel.Pos0] = {
    progressImg = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_KeeperSkill_05.png"
  },
  [CommonDefine.KeeperSkillEnergyLevel.Pos1] = {
    progressImg = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_KeeperSkill_06.png"
  },
  [CommonDefine.KeeperSkillEnergyLevel.Pos2] = {
    progressImg = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_KeeperSkill_07.png"
  },
  [CommonDefine.KeeperSkillEnergyLevel.Pos3] = {
    progressImg = "UIResources/AtlasSource/UI_Battle_Image/UI_Battle_KeeperSkill_07.png"
  }
}

function KeeperSkillUtils.GetKeeperSkillProgressInfo()
  return KeeperSkillProgressInfo
end

return KeeperSkillUtils
