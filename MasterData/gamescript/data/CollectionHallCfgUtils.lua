local CollectionHallCfgUtils = {}

function CollectionHallCfgUtils.GetCfg(tid)
  if not tid then
    return nil
  end
  return DT.CollectionHall[tid]
end

function CollectionHallCfgUtils.GetCfgField(field, cfgTid)
  local cfg = CollectionHallCfgUtils.GetCfg(cfgTid)
  if not cfg then
    return
  end
  return cfg[field]
end

function CollectionHallCfgUtils.GetCollectionRelicCfg(collectionTid)
  local cfg = CollectionHallCfgUtils.GetCfg(collectionTid)
  local featureCfg = FeatureUnlockCfgUtils.GetFeatureConfigByFeatureId(CommonDefine.FeatureId.CollectionRelic)
  if not cfg or cfg.CollectionType ~= featureCfg.ID then
    return nil
  end
  local relicTid = cfg.UnlockCondPara and cfg.UnlockCondPara[1]
  do return RelicCfgUtils.GetCfg end
  return RelicCfgUtils.GetCfg, relicTid
end

function CollectionHallCfgUtils.GetCollectionItemCfg(collectionTid)
  local cfg = CollectionHallCfgUtils.GetCfg(collectionTid)
  local weaponFeatureTid = FeatureUnlockCfgUtils.GetFeatureConfigByFeatureId(CommonDefine.FeatureId.CollectionWeapon).ID
  local trinketFeatureTid = FeatureUnlockCfgUtils.GetFeatureConfigByFeatureId(CommonDefine.FeatureId.CollectionTrinket).ID
  if not cfg or not table.contains({weaponFeatureTid, trinketFeatureTid}, cfg.CollectionType) then
    return nil
  end
  local itemTid = cfg.UnlockCondPara and cfg.UnlockCondPara[1]
  do return ItemCfgUtils.GetCfg end
  return ItemCfgUtils.GetCfg, itemTid, trinketFeatureTid
end

function CollectionHallCfgUtils.GetCollectionHistoryTitle(collectionTid)
  local cfg = CollectionHallCfgUtils.GetCfg(collectionTid)
  local featureCfg = FeatureUnlockCfgUtils.GetFeatureConfigByFeatureId(CommonDefine.FeatureId.CollectionStory, CommonDefine.WorldStorySubFeature.History)
  if not cfg or cfg.CollectionType ~= featureCfg.ID then
    return
  end
  local cfgTitle = LT.Text(cfg.Title)
  if not cfgTitle then
    return
  end
  local length = #cfgTitle
  local prefix = string.sub(cfgTitle, 1, 4)
  local suffix = string.sub(cfgTitle, 5, length)
  return prefix, suffix
end

function CollectionHallCfgUtils.GetContentList(collectionTid)
  local desc = CollectionHallCfgUtils.GetCfgField("Desc", collectionTid)
  do return StrUtils.SplitTitleAndContent, LT.Text(desc) end
  return StrUtils.SplitTitleAndContent, LT.Text(desc)
end

function CollectionHallCfgUtils.ResetMainBgMusic()
  local musicId = DT.GetConstant("DefaultBgMusicId")
  ClientDataUtils.SetData(cd.ClientDataMainKey.AVG, "MainBgMusicTid", musicId)
  GlobalDispatcher:Dispatch(NotifyId.OSTMusicSet, musicId)
  SceneMgr.Instance:EnterTown(true)
end

function CollectionHallCfgUtils.ResetMainBgCG()
  local cgId = DT.GetConstant("DefaultBgCGId")
  ClientDataUtils.SetData(cd.ClientDataMainKey.AVG, "MainBgTid", cgId)
  SceneMgr.Instance:EnterTown(true)
end

return CollectionHallCfgUtils
