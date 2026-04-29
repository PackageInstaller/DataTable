_class("UICampaignModule", UIModule)
UICampaignModule = UICampaignModule

function UICampaignModule:Constructor()
  self._reviewData = nil
  self._hauteCountureData = nil
  self:AttachEvent(GameEventType.UIShowEnd, self.OnUIShowEnd)
end

function UICampaignModule:GetReviewData()
  if self._reviewData == nil then
    Log.debug("初始化活动回顾数据:", debug.traceback())
    self._reviewData = UIActivityReviewData:New()
    if self._reviewData:IsLocked() then
      Log.debug("[Review] 活动回顾模块未解锁，监听解锁消息")
      self:AttachEvent(GameEventType.ModuleUnlocked, self.OnModuleUnlock)
    end
  end
  return self._reviewData
end

function UICampaignModule:OnModuleUnlock(id)
  if id == GameModuleID.MD_CAMPAIGNREVIEW then
    Log.debug("[Review] 活动回顾模块解锁，重新初始化")
    self._reviewData = UIActivityReviewData:New()
    self:DetachEvent(GameEventType.ModuleUnlocked)
  end
end

function UICampaignModule:GetHauteCoutureData()
  if not self._hauteCountureData then
    Log.debug("[HauteCouture] 初始化高级时装数据")
    self._hauteCountureData = UIHauteCoutureData:New()
  end
  return self._hauteCountureData
end

function UICampaignModule:EnterDiffTeam(parentID, childID, component)
  Log.info("进入活动困难关编队:", parentID, ",", childID)
  self:StartTask(self._EnterTeam, self, parentID, childID, component)
end

function UICampaignModule:_EnterTeam(TT, parentID, childID, component)
  self:_HandleBeforeEnterDiffTeam(TT, parentID, childID, component)
  local info = component:GetComponentInfo().infos[parentID]
  local stageList = {}
  local cfg = Cfg.cfg_difficulty_parent_mission[parentID]
  if not cfg then
    Log.exception("cfg_difficulty_parent_mission中找不到配置:", parentID)
  end
  for i = 1, #cfg.SubMissionList do
    local stageid = cfg.SubMissionList[i]
    local data
    if info and info.sub_mission_infos then
      for j = 1, #info.sub_mission_infos do
        if info.sub_mission_infos[j].mission_id == stageid then
          data = info.sub_mission_infos[j]
          break
        end
      end
    end
    local pets = {}
    if data and data.pet_list and next(data.pet_list) then
      pets = data.pet_list
    end
    local team = Team:New()
    team:Init(1, "", pets)
    stageList[stageid] = team
  end
  local missionModule = GameGlobal.GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  local data = component:GetComponentInfo().pet_list
  ctx:InitCampDiffTeam({
    {id = 1, pet_list = data}
  })
  local param = {}
  param[1] = parentID
  param[2] = childID
  param[3] = component:GetCampaignMissionComponentId()
  param[4] = component:GetComponentCfgId()
  param[5] = component
  ctx:Init(TeamOpenerType.Camp_Diff, param)
  local teamid = ctx:GetCurrTeamId()
  local teams = ctx:Teams()
  local team = teams:Get(teamid)
  local diffModule = GameGlobal.GetUIModule(DifficultyMissionModule)
  diffModule:SetTeamInfo(team, childID, stageList)
  ctx:ShowDialogUITeams(false)
end

function UICampaignModule:ClearDiffTeam(parentID, childID, component)
  Log.info("清理活动困难关编队:", parentID, ",", childID)
  local info = component:GetComponentInfo().infos[parentID]
  local currentStageTeam = {}
  if info then
    for _, sub in ipairs(info.sub_mission_infos) do
      if sub.mission_id == childID then
        currentStageTeam = sub.pet_list
        break
      end
    end
  end
  local finish = false
  if currentStageTeam and next(currentStageTeam) then
    for _, pstid in pairs(currentStageTeam) do
      if 0 < pstid then
        finish = true
        break
      end
    end
  end
  if finish then
    PopMsgBox(StringTable.Get("str_diff_mission_reset_team_box"), function()
      self:StartTask(self._ReqResetDiffTeam, self, parentID, childID, component)
    end)
  end
end

function UICampaignModule:_ReqResetDiffTeam(TT, parentID, childID, component)
  GameGlobal.UIStateManager():Lock("UICampaignModule:_ReqResetDiffTeam")
  local res = component:HandleDifficultyResetSubMissionRecord(TT, AsyncRequestRes:New(), parentID, childID)
  GameGlobal.UIStateManager():UnLock("UICampaignModule:_ReqResetDiffTeam")
  if res:GetSucc() then
    local tips = StringTable.Get("str_diff_mission_reset_team_succ")
    ToastManager.ShowToast(tips)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnCampDiffTeamReset)
  else
    local result = res:GetResult()
    local tips = StringTable.Get("str_diff_mission_reset_team_fail", result)
    ToastManager.ShowToast(tips)
  end
end

function UICampaignModule:_HandleBeforeEnterDiffTeam(TT, parentID, childID, component)
  local info = component:GetComponentInfo().infos[parentID]
  local useTeam = false
  local team
  local currentStageTeam = {}
  if info then
    for _, sub in ipairs(info.sub_mission_infos) do
      if sub.mission_id == childID then
        currentStageTeam = sub.pet_list
        break
      end
    end
  end
  if next(currentStageTeam) then
    for _, pstid in pairs(currentStageTeam) do
      if pstid and 0 < pstid then
        useTeam = true
        break
      end
    end
  end
  if useTeam then
    Log.info("活动高难关，编队有效")
    team = table.clone(currentStageTeam)
  else
    local pcfg = Cfg.cfg_difficulty_parent_mission[parentID]
    if not pcfg then
      Log.exception("cfg_difficulty_parent_mission中找不到配置:", parentID)
    end
    local removeList = {}
    local cacheTeam = component:GetComponentInfo().pet_list
    if info then
      for i = 1, #cacheTeam do
        local targetID = cacheTeam[i]
        if targetID and 0 < targetID then
          for _, sub_info in ipairs(info.sub_mission_infos) do
            local found = false
            if sub_info.mission_id ~= childID and sub_info.pet_list and next(sub_info.pet_list) then
              for _, sub_petid in pairs(sub_info.pet_list) do
                if targetID == sub_petid then
                  removeList[#removeList + 1] = i
                  found = true
                  break
                end
              end
            end
            if found then
              break
            end
          end
        end
      end
    end
    if removeList and next(removeList) then
      local updateTeam = table.clone(cacheTeam)
      for i = 1, #removeList do
        local idx = removeList[i]
        updateTeam[idx] = 0
      end
      Log.info("处理活动高难关编队，剔除重复星灵")
      team = updateTeam
    end
  end
  if team then
    GameGlobal.UIStateManager():Lock("UICampaignModule:HandleDifficultyChangeFormation")
    local res = component:HandleDifficultyChangeFormation(TT, AsyncRequestRes:New(), parentID, childID, team)
    GameGlobal.UIStateManager():UnLock("UICampaignModule:HandleDifficultyChangeFormation")
    if res:GetSucc() then
    else
      Log.error("请求更新活动高难关编队失败:", res:GetResult())
    end
  end
end

function UICampaignModule:ShowCollectFrogGuide()
  local playerID = GameGlobal.GameLogic():GetOpenId()
  local storyKey = FrogConst.ShowStory .. ECampaignType.CAMPAIGN_TYPE_COLLECT_FROG .. playerID
  local guideUIKey = FrogConst.ShowGuideUI .. ECampaignType.CAMPAIGN_TYPE_COLLECT_FROG .. playerID
  if LocalDB.GetInt(storyKey) == 2 then
    return
  end
  if LocalDB.GetInt(storyKey) ~= 1 then
    LocalDB.SetInt(storyKey, 2)
    GameGlobal.UIStateManager():ShowDialog("UIStoryController", 50780101, function()
      LocalDB.SetInt(storyKey, 1)
      GameGlobal.UIStateManager():ShowDialog(UIStateType.UICN14N43FrogGameGuide)
      LocalDB.SetInt(guideUIKey, 1)
    end)
    return
  end
  if LocalDB.GetInt(guideUIKey) ~= 1 then
    GameGlobal.UIStateManager():ShowDialog(UIStateType.UICN14N43FrogGameGuide)
    LocalDB.SetInt(guideUIKey, 1)
  end
end

function UICampaignModule:OnUIShowEnd(uiName, uiParams)
  if self:CheckCollectFrogOpen() then
    local createF = UICN14N43CreateFrog:New()
    createF:CreateFrog(uiName)
  end
end

function UICampaignModule:CheckCollectFrogOpen()
  local campaign = UIActivityCampaign:New()
  campaign:LoadCampaignInfo_Local(ECampaignType.CAMPAIGN_TYPE_COLLECT_FROG)
  return campaign:CheckCampaignOpen()
end
