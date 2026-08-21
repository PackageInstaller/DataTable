local UIActivityN21CCAffixGroupType = {SelfGain = 1, EnemyGain = 2}
_enum("UIActivityN21CCAffixGroupType", UIActivityN21CCAffixGroupType)
_class("UIActivityN21CCAffixGroupsData", Object)
UIActivityN21CCAffixGroupsData = UIActivityN21CCAffixGroupsData

function UIActivityN21CCAffixGroupsData:Constructor(affixIds, selectIds)
  self._affixDatas = {}
  if not affixIds then
    return
  end
  self._type = UIActivityN21CCAffixGroupType.SelfGain
  self._unlockScore = 0
  for i = 1, #affixIds do
    local cfg = Cfg.cfg_component_mission_affix[affixIds[i]]
    if i == 1 then
      self._type = cfg.GainType
      self._unlockScore = cfg.UnLockScore
    end
    local isSelected = false
    if selectIds then
      for j = 1, #selectIds do
        if selectIds[j] == cfg.ID then
          isSelected = true
          break
        end
      end
    end
    local affixData = UIActivityN21CCAffixData:New(cfg, isSelected, self)
    self._affixDatas[#self._affixDatas + 1] = affixData
  end
end

function UIActivityN21CCAffixGroupsData:GetAffixDatas()
  return self._affixDatas
end

function UIActivityN21CCAffixGroupsData:GetType()
  return self._type
end

function UIActivityN21CCAffixGroupsData:GetUnLockScore()
  return self._unlockScore
end
