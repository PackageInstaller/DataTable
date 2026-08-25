local FIGHT_AWAKER_NUM = 4
local FIGHT_WEAPON_NUM = 4
local FIGHT_KEEPERSKILL_NUM = 2
local ItemType = CommonDefine.ItemType

local function createPvPTeamBuildMainPanelState()
  local state = {}
  state.curTeamIdx = 1
  
  function state.curSchoolId()
    local awakerTids = PvPTeamBuildDataUtils.GetAwakerTidsByCollectTids(state.awakerGroup)
    do return AwakerDataUtils.GetAwakerTeamEffectSchool end
    return AwakerDataUtils.GetAwakerTeamEffectSchool, awakerTids
  end
  
  state.awakerGroup = {}
  state.weaponGroup = {}
  state.keeperSkillGroup = {}
  
  function state.type2GroupMap()
    return {
      [ItemType.AwakerItem] = state.awakerGroup,
      [ItemType.Weapon] = state.weaponGroup,
      [ItemType.KeeperSkill] = state.keeperSkillGroup
    }
  end
  
  state.isMatching = false
  return state
end

local function createPvPTeamBuildMainPanelViews(data)
  local views = {}
  
  function views:CheckCanChallenge()
    local rst = true
    local scanGroup = {
      data.awakerGroup,
      data.weaponGroup,
      data.keeperSkillGroup
    }
    for _, group in pairs(scanGroup) do
      for _, tid in pairs(group) do
        if 0 == tid then
          return false
        end
      end
    end
    return rst
  end
  
  function views:CheckNeedUnlockBattlePass()
    local scanGroup = {
      data.awakerGroup,
      data.weaponGroup,
      data.keeperSkillGroup
    }
    for _, group in pairs(scanGroup) do
      for _, tid in pairs(group) do
        if not PVPCollectionDataUtils.IsAvailable(tid) then
          return true
        end
      end
    end
  end
  
  return views
end

local function createPvPTeamBuildMainPanelActions(data)
  local actions = {}
  
  function actions:SetCurTeamIdx(num)
    if not num then
      Logger.Debug("Error Val ", num)
      return
    end
    data.curTeamIdx = num
    PvpModel.Instance:SetCurTeamIdx(num)
    self:UpdateShowTeam()
  end
  
  function actions:UpdateTeam(teamIdx)
    if not teamIdx then
      Logger.Debug("Error Val ", teamIdx)
      return
    end
  end
  
  function actions:SetAwakerGroup(awakerGroup)
    if not awakerGroup then
      Logger.Debug("Error Val ", awakerGroup)
      return
    end
    data.awakerGroup = awakerGroup
  end
  
  function actions:SetWeaponGroup(weaponGroup)
    if not weaponGroup then
      Logger.Debug("Error Val ", weaponGroup)
      return
    end
    data.weaponGroup = weaponGroup
  end
  
  function actions:SetKeeperSkillGroup(keeperSkillGroup)
    if not keeperSkillGroup then
      Logger.Debug("Error Val ", keeperSkillGroup)
      return
    end
    data.keeperSkillGroup = keeperSkillGroup
  end
  
  function actions:SetIsMatching(boolVal)
    data.isMatching = boolVal
  end
  
  function actions:UpdateShowTeam()
    local awakerGroup, weaponGroup, keeperSkillGroup = {}, {}, {}
    
    local function handleSvrData(sourceGroup, targetGroup, num)
      if sourceGroup then
        for _, teamAwakerData in ipairs(sourceGroup) do
          table.insert(targetGroup, teamAwakerData.tid)
        end
      else
        for i = 1, num do
          table.insert(targetGroup, 0)
        end
      end
      return targetGroup
    end
    
    awakerGroup = handleSvrData(PvPTeamBuildDataUtils.GetTeamDataByIdx(data.curTeamIdx, "awakerList"), awakerGroup, FIGHT_AWAKER_NUM)
    weaponGroup = handleSvrData(PvPTeamBuildDataUtils.GetTeamDataByIdx(data.curTeamIdx, "weaponList"), weaponGroup, FIGHT_WEAPON_NUM)
    keeperSkillGroup = handleSvrData(PvPTeamBuildDataUtils.GetTeamDataByIdx(data.curTeamIdx, "keeperSkillList"), keeperSkillGroup, FIGHT_KEEPERSKILL_NUM)
    data:SetAwakerGroup(awakerGroup)
    data:SetWeaponGroup(weaponGroup)
    data:SetKeeperSkillGroup(keeperSkillGroup)
  end
  
  return actions
end

local function onSetup(binder, model)
  binder:BindToRaw(function(_, nVal)
    model:UpdateShowTeam()
    model:SetCurTeamIdx(PvPTeamBuildDataUtils.GetLastChooseTeam())
  end, function()
    return DataCenter.pvpTeamBuildData.teamDataGroup
  end)
  binder:BindToRaw(function(_, nVal)
    PvPTeamBuildDataUtils.ReqOnChooseTeam(nVal)
  end, function()
    return model.curTeamIdx
  end)
  binder:BindEvent(EventMgr.Instance.PVPTeamUpdate, function()
    model:UpdateShowTeam()
  end)
end

local PvPTeamBuildMainPanelModel = Vue.model("PvPTeamBuildMainPanelModel", createPvPTeamBuildMainPanelState):views(createPvPTeamBuildMainPanelViews):actions(createPvPTeamBuildMainPanelActions):setup(onSetup)
return PvPTeamBuildMainPanelModel
