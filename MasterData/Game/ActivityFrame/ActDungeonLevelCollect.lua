local ActDungeonLevelCollect = class("ActDungeonLevelCollect")

function ActDungeonLevelCollect:InitActDungeonLevelCollectCommon(dungeonLevelList, actBase)
  self:InitActDungeonLevelCollect(dungeonLevelList, actBase)
  local actFrameId = actBase:GetActFrameId()
  local repeatDgCfg = ConfigData.act_general_repeat_dg_dg[actFrameId]
  if repeatDgCfg == nil then
    error("Cant get act_general_repeat_dg_repeat_dungeon cfg, id:" .. tostring(actFrameId))
    return
  end
  self._repeatDgCfg = repeatDgCfg
  self:SetDungeonLevelCollectName(LanguageUtil.GetLocaleText(repeatDgCfg.level_title), LanguageUtil.GetLocaleText(repeatDgCfg.level_title_en))
end

function ActDungeonLevelCollect:InitActDungeonLevelCollect(dungeonLevelList, actBase)
  self._actBase = actBase
  self._dungeonList = dungeonLevelList
end

function ActDungeonLevelCollect:SetDungeonLevelCollectName(cnName, enName)
  self._cnName = cnName
  self._enName = enName
end

function ActDungeonLevelCollect:GetActDungeonSortList()
  return self._dungeonList
end

function ActDungeonLevelCollect:GetActDungeonActBase()
  return self._actBase
end

function ActDungeonLevelCollect:GetActDungeonTitle()
  return self._cnName, self._enName
end

function ActDungeonLevelCollect:IsDgLevelCollectUnlock()
  local unlock = CheckCondition.CheckLua(self._repeatDgCfg.pre_condition, self._repeatDgCfg.pre_para1, self._repeatDgCfg.pre_para2)
  return unlock
end

function ActDungeonLevelCollect:GetDgLevelCollectUnlockTip()
  local lockTip = CheckCondition.GetUnlockInfoLua(self._repeatDgCfg.pre_condition, self._repeatDgCfg.pre_para1, self._repeatDgCfg.pre_para2)
  return lockTip
end

return ActDungeonLevelCollect
