_class("MonsterDropItemConfigData", Object)
MonsterDropItemConfigData = MonsterDropItemConfigData

function MonsterDropItemConfigData:Constructor()
end

function MonsterDropItemConfigData:GetPickupType(dropItemID)
  local dropConfig = Cfg.cfg_monster_drop_item[dropItemID]
  return dropConfig.PickupType
end

function MonsterDropItemConfigData:GetDropEffectType(dropItemID)
  local dropConfig = Cfg.cfg_monster_drop_item[dropItemID]
  return dropConfig.EffectType
end

function MonsterDropItemConfigData:GetDropEffectParam(dropItemID)
  local dropConfig = Cfg.cfg_monster_drop_item[dropItemID]
  return dropConfig.EffectParam
end
