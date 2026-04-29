require("main_lobby_center_camp_data")
_class("WorldBossMulti", MainLobbyCenterCampData)
WorldBossMulti = WorldBossMulti

function WorldBossMulti:LoadData(TT)
  local worldBossModule = GameGlobal.GetModule(WorldBossModule)
  worldBossModule:ReqWorldBossData(TT)
end

function WorldBossMulti:CheckOpen()
  local open = GameGlobal.GetModule(WorldBossModule):AwardMultiOpen()
  local unlock = GameGlobal.GetModule(RoleModule):CheckModuleUnlock(GameModuleID.MD_WorldBoss)
  open = open and unlock
  return open
end

function WorldBossMulti:CheckNew()
  return 0
end

function WorldBossMulti:CheckRed()
  if GameGlobal.GetModule(WorldBossModule).m_world_boss_data then
    local key = self:_GetLocalDBKey()
    local red = UIWorldBossMultiToolFunctions.GetLocalDBInt(key, 0) <= 0
    return red and 1 or 0
  else
    return 0
  end
end

function WorldBossMulti:_GetLocalDBKey()
  return UIWorldBossMultiKey.Opened .. GameGlobal.GetModule(WorldBossModule).m_world_boss_data.boss_mission_id
end
