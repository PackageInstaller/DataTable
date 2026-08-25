local PvpCollectCfgUtils = {}

function PvpCollectCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.PVPCollect[tid]
end

function PvpCollectCfgUtils.GetCfgField(field, cfgTid)
  local cfg = PvpCollectCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function PvpCollectCfgUtils.GetCollectionName(tid)
  if not tid then
    return
  end
  local config = PvpCollectCfgUtils.GetCfg(tid)
  if not config then
    return
  end
  if config.Type == CommonDefine.PVPCollectionType.KeeperSkill and not PVPCollectionDataUtils.HasOwnedCollection(tid) then
    do return PvpCollectCfgUtils.GetKeeperSkillPosseUnknowDesc end
    return PvpCollectCfgUtils.GetKeeperSkillPosseUnknowDesc, tid, nil
  end
  if config.Type == CommonDefine.PVPCollectionType.Awaker then
    local awakerTid = ItemDataUtils.GetAwakerTidByItemTid(config.Item)
    do return AwakerDataUtils.GetAwakerName end
    return AwakerDataUtils.GetAwakerName, awakerTid
  end
  do return PvpCollectCfgUtils.GetCollectionPvpSkillName end
  return PvpCollectCfgUtils.GetCollectionPvpSkillName, tid, awakerTid
end

function PvpCollectCfgUtils.GetCollectionPvpSkillDesc(collectTid)
  local skillTid = PvpCollectCfgUtils.GetCollectionPvpSkillTid(collectTid)
  do return SkillUtils.GetAwakerSkillDesc, {}, skillTid end
  return SkillUtils.GetAwakerSkillDesc, {}, skillTid, 1
end

function PvpCollectCfgUtils.GetCollectionPvpSkillTid(collectTid)
  local collectItem = PvpCollectCfgUtils.GetCfgField("Item", collectTid)
  if not collectItem then
    return
  end
  local collectItemCfg = ItemCfgUtils.GetCfg(collectItem)
  if not collectItemCfg then
    return
  end
  local cfgPvpSkill = collectItemCfg.PVPSkill
  if not cfgPvpSkill then
    return
  end
  return cfgPvpSkill[1]
end

function PvpCollectCfgUtils.GetCollectionPvpSkillCost(collectTid)
  local skillTid = PvpCollectCfgUtils.GetCollectionPvpSkillTid(collectTid)
  return SkillCfgUtils.GetCfgField("Cost", skillTid) or 0
end

function PvpCollectCfgUtils.GetCollectionPvpSkillName(collectTid)
  local collectItem = PvpCollectCfgUtils.GetCfgField("Item", collectTid)
  if not collectItem then
    return ""
  end
  local collectItemCfg = ItemCfgUtils.GetCfg(collectItem)
  if not collectItemCfg then
    return ""
  end
  local cfgPvpSkill = collectItemCfg.PVPSkill
  if not cfgPvpSkill then
    do return LT.Text end
    return LT.Text, collectItemCfg.Name, nil, nil, nil, nil
  end
  local skillTid = cfgPvpSkill[1]
  local skillConfig = DT.Skill[skillTid]
  do return BattleSkillUtils.GetSkillName, skillConfig, 0 end
  return BattleSkillUtils.GetSkillName, skillConfig, 0, 0
end

function PvpCollectCfgUtils.GetKeeperSkillPosseUnknowDesc(collectTid)
  local collectionType = PvpCollectCfgUtils.GetCollectionType(collectTid)
  if not collectionType or collectionType ~= CommonDefine.PVPCollectionType.KeeperSkill then
    return
  end
  local config = PvpCollectCfgUtils.GetCfg(collectTid)
  if not config or not config.UnknownName then
    return
  end
  do return LT.Text end
  return LT.Text, config.UnknownName
end

function PvpCollectCfgUtils.GetCollectionType(collectTid)
  do return PvpCollectCfgUtils.GetCfgField, "Type" end
  return PvpCollectCfgUtils.GetCfgField, "Type", collectTid
end

function PvpCollectCfgUtils.GetCollectAwakerPosition(collectTid)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectTid)
  if not awakerTid then
    return nil
  end
  local awakerConfig = AwakerCfgUtils.GetCfg(awakerTid)
  return awakerConfig and awakerConfig.PVPPosition
end

function PvpCollectCfgUtils.GetCollectAwakerTid(collectTid)
  local config = PvpCollectCfgUtils.GetCfg(collectTid)
  if not config then
    return nil
  end
  if config.Type ~= CommonDefine.PVPCollectionType.Awaker then
    return nil
  end
  do return ItemDataUtils.GetAwakerTidByItemTid end
  return ItemDataUtils.GetAwakerTidByItemTid, config.Item
end

function PvpCollectCfgUtils.GetCollectAwakerPvpSkillList(collectionTid)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectionTid)
  if not awakerTid then
    return nil
  end
  local awakerConfig = AwakerCfgUtils.GetCfg(awakerTid)
  return awakerConfig and awakerConfig.PVPSkillList
end

function PvpCollectCfgUtils.GetCollectAwakerHp(collectionTid)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectionTid)
  if not awakerTid then
    return nil
  end
  local awakerConfig = AwakerDataUtils.GetAwakerConfig(awakerTid)
  return awakerConfig and math.floor(awakerConfig.PVPHP)
end

function PvpCollectCfgUtils.GetCollectAwakerUltiSkillTid(collectionTid)
  local cfgPvpSkillList = PvpCollectCfgUtils.GetCollectAwakerPvpSkillList(collectionTid)
  if not cfgPvpSkillList then
    return nil
  end
  for _, skillTid in pairs(cfgPvpSkillList) do
    local skillType = SkillCfgUtils.GetSkillType(skillTid)
    if skillType == CommonDefine.SkillType.Ulti_Skill then
      return skillTid
    end
  end
  return nil
end

function PvpCollectCfgUtils.GetCollectAwakerSkillInfoList(collectionTid)
  local cfgPvpSkillList = PvpCollectCfgUtils.GetCollectAwakerPvpSkillList(collectionTid)
  if not cfgPvpSkillList then
    return nil
  end
  local map = {}
  local rst = {}
  for idx, skillTid in ipairs(cfgPvpSkillList) do
    local skillConfig = SkillCfgUtils.GetCfg(skillTid)
    if not skillConfig or not skillConfig.Slot then
    else
      local skillType = SkillCfgUtils.GetSkillType(skillTid)
      if skillType == CommonDefine.SkillType.Ulti_Skill then
      else
        if not map[skillConfig.Slot] then
          local showIdx = idx
          if skillType == CommonDefine.SkillType.Card_Strike then
            showIdx = 999
          end
          map[skillConfig.Slot] = {
            tid = skillTid,
            idx = showIdx,
            num = 0
          }
        end
        map[skillConfig.Slot].num = map[skillConfig.Slot].num + 1
      end
    end
  end
  for _, skillInfo in pairs(map) do
    table.insert(rst, skillInfo)
  end
  table.sort(rst, function(a, b)
    return a.idx < b.idx
  end)
  return rst
end

function PvpCollectCfgUtils.GetCollectionFormationImage(collectionTid)
  do return PvpCollectCfgUtils.GetCfgField, "FormationImage" end
  return PvpCollectCfgUtils.GetCfgField, "FormationImage", collectionTid
end

function PvpCollectCfgUtils.GetCollectAwakerPvpPosition(collectionTid)
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectionTid)
  do return AwakerCfgUtils.GetCfgField, "PVPPosition" end
  return AwakerCfgUtils.GetCfgField, "PVPPosition", awakerTid
end

function PvpCollectCfgUtils.GetCollectAwakerFormationImage(collectionTid, skinTid)
  local formationImage = PvpCollectCfgUtils.GetCollectionFormationImage(collectionTid)
  if not formationImage then
    return nil
  end
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectionTid)
  if not awakerTid then
    return formationImage
  end
  if not skinTid then
    do return AwakerDataUtils.ReplaceMyAwakerSkinRes, formationImage end
    return AwakerDataUtils.ReplaceMyAwakerSkinRes, formationImage, awakerTid, nil, nil
  end
  local targetResNo = AwakerDataUtils.GetAwakerResNum(awakerTid, true, skinTid)
  do return AwakerDataUtils.ReplaceSkinRes, formationImage, awakerTid end
  return AwakerDataUtils.ReplaceSkinRes, formationImage, awakerTid, targetResNo
end

function PvpCollectCfgUtils.GetCollectAwakerCollectImage(collectionTid)
  local collectImage = PvpCollectCfgUtils.GetCfgField("CollectImage", collectionTid)
  if not collectImage then
    return nil
  end
  local awakerTid = PvpCollectCfgUtils.GetCollectAwakerTid(collectionTid)
  if awakerTid then
    do return AwakerDataUtils.ReplaceMyAwakerSkinRes, collectImage end
    return AwakerDataUtils.ReplaceMyAwakerSkinRes, collectImage, awakerTid
  end
  return collectImage
end

function PvpCollectCfgUtils.GetItemStoryDescByCollectTid(collectTid)
  local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(collectTid)
  return itemCfg and LT.Text(itemCfg.StoryDesc)
end

function PvpCollectCfgUtils.GetItemCfgByCollectTid(collectTid)
  local itemTid = PvpCollectCfgUtils.GetCfgField("Item", collectTid)
  do return ItemCfgUtils.GetCfg end
  return ItemCfgUtils.GetCfg, itemTid
end

function PvpCollectCfgUtils.GetAwakerTidByCollectTid(collectTid)
  local itemCfg = PvpCollectCfgUtils.GetItemCfgByCollectTid(collectTid)
  do return ItemCfgUtils.GetItemAwakerTid end
  return ItemCfgUtils.GetItemAwakerTid, itemCfg.ID
end

local __weaponPvpSkillTid2CollectTidMap

function PvpCollectCfgUtils._InitWeaponPvpSkillTid2CollectTidMap()
  if __weaponPvpSkillTid2CollectTidMap then
    return
  end
  __weaponPvpSkillTid2CollectTidMap = {}
  for collectTid, cfg in pairs(DT.PVPCollect) do
    if cfg.Type == CommonDefine.PVPCollectionType.Weapon then
      local skillTid = PvpCollectCfgUtils.GetCollectionPvpSkillTid(collectTid)
      if skillTid then
        __weaponPvpSkillTid2CollectTidMap[skillTid] = collectTid
      end
    end
  end
end

function PvpCollectCfgUtils.GetWeaponCollectTidByPvpSkillTid(skillTid)
  if not skillTid then
    return
  end
  PvpCollectCfgUtils._InitWeaponPvpSkillTid2CollectTidMap()
  return __weaponPvpSkillTid2CollectTidMap[skillTid]
end

function PvpCollectCfgUtils.IsWeaponPvpSkillTid(skillTid)
  return PvpCollectCfgUtils.GetWeaponCollectTidByPvpSkillTid(skillTid) ~= nil
end

return PvpCollectCfgUtils
