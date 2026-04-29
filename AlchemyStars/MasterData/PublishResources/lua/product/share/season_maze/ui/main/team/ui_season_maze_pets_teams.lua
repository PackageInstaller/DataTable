_class("UISeasonMazePetsTeams", UIController)
UISeasonMazePetsTeams = UISeasonMazePetsTeams

function UISeasonMazePetsTeams:Constructor()
  self._widgetCount = 8
  self._layoutWidth = 0
  self._isLongPressing = false
  self._lastClickTime = 0
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._uiSeasonMazeModule = self._seasonMazeModule.uiModule
  self._dialLine2Hp = Cfg.cfg_global.UIWidgetBattlePet_dialLine2Hp.IntValue or 200
  self._bigDiaLine = Cfg.cfg_global.UIWidgetBattlePet_bigDiaLine.IntValue or 5
end

function UISeasonMazePetsTeams:LoadDataOnEnter(TT, res, uiParams)
  self._module = self:GetModule(MissionModule)
  self._ctx = self._module:TeamCtx()
  self._teams = self._ctx:Teams()
  self.ctid = nil
end

function UISeasonMazePetsTeams:OnShow(uiParams)
  self:UnLock("DoEnterEightPetsTeam")
  local teamId = self._ctx:GetCurrTeamId()
  self:UIWidget()
  self:DefaultVisible()
  self:AddEvents()
  self:InitCommonTopButton()
  self:InitTeams()
  self:FlushTeam(teamId)
  self:InAnimation()
end

function UISeasonMazePetsTeams:OnHide()
  if self._ctx:GetFightAgain() then
    self._ctx:SetFightAgain(false)
  end
  if self._ctx:IsFastSelect() then
    self._ctx:ClearFastSelect()
  end
  local hpm = self:GetModule(HelpPetModule)
  hpm:UI_ClearHelpPet()
  self:GetModule(PetModule):ClearAllPetSortInfo()
end

function UISeasonMazePetsTeams:OnUpdate(deltaTimeMS)
  self:OnLayoutChanged(deltaTimeMS)
end

function UISeasonMazePetsTeams:BtnChangeNameOnClick(go)
  if self.ctid then
    self:ShowDialog("UITeamsNameModify", self.ctid)
  end
end

function UISeasonMazePetsTeams:BtnClearOnClick(go)
  local teamid = self._ctx:GetCurrTeamId()
  local team = self._teams:Get(teamid)
  if not team:HasPet() then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_discovery_clear_all_pet_or_not"), function(param)
    local teamid = self._ctx:GetCurrTeamId()
    local team = self._teams:Get(teamid)
    local tmpTeam = team:Clone()
    local pets = tmpTeam:GetPets()
    for k, v in pairs(pets) do
      pets[k] = 0
    end
    self:UpdateFormationInfo(tmpTeam)
  end, nil, function(param)
  end, nil)
end

function UISeasonMazePetsTeams:BtnFastTeamOnClick(go)
  self._ctx:InitTeamFastSelect()
  self:ShowDialog("UISeasonMazeTeamChangeController")
end

function UISeasonMazePetsTeams:BtnFightOnClick(go)
  local l_curTime = os.time()
  if l_curTime - self._lastClickTime < 1 then
    Log.debug("btnFightOnClick repeat")
    return
  else
    self._lastClickTime = l_curTime
  end
  local pc = GameGlobal:GetInstance():GetCollector("CoreGameLoading")
  pc:ResetCollector()
  pc:Sample("UISeasonMazePetsTeams:BtnFightOnClick()")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIBattleStart)
  local bCheckTeamValid, team = self:CheckTeamValid()
  if not bCheckTeamValid then
    ToastManager.ShowToast(StringTable.Get("str_discovery_no_leader_no_fight"))
    return
  end
  if not self:CheckTeamMemberDuplicate() then
    ToastManager.ShowToast(StringTable.Get("str_tower_error_8"))
    return
  end
  if self:SMazeCheckEmptySlot() then
    UISeasonMazeModule.PopMsgBox("", StringTable.Get("str_season_maze_team_check_empty"), SeasonMazeMsgBoxType.OkCancel, function()
      self:BtnFightEvent()
    end)
    return
  end
  self:BtnFightEvent()
end

function UISeasonMazePetsTeams:BtnFightEvent(go)
  local petModule = self:GetModule(PetModule)
  petModule:ClearAllPetSortInfo()
  self:Lock("DoEnterMatch")
  local game = GameGlobal.GetModule(GameMatchModule)
  local role = GameGlobal.GetModule(RoleModule)
  local curTeamId = self._ctx:GetCurrTeamId()
  local matchType = MatchType.MT_SeasonMaze
  local param = self._ctx:GetParam()
  local createInfo = game:GetMatchCreateInfo(matchType, param)
  self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
  local teamid = self._ctx:GetCurrTeamId()
  local team = self._teams:Get(teamid)
  local petsList = team.pets
  role:UpdateMatchPetsList(petsList)
end

function UISeasonMazePetsTeams:SMazeCheckEmptySlot()
  local teamid = self._ctx:GetCurrTeamId()
  local team = self._teams:Get(teamid)
  local empty = false
  if team and team.pets and next(team.pets) then
    for k, v in pairs(team.pets) do
      if not v or v == 0 then
        empty = true
        break
      end
    end
  end
  if empty then
    local allPets = self._uiSeasonMazeModule:GetSeasonMazePets(function(petInfo)
      local id = petInfo.petID
      local checkPet = self._uiSeasonMazeModule:CreateMatchPet(petInfo)
      local teamid = self._ctx:GetCurrTeamId()
      local team = self._teams:Get(teamid)
      local empty = false
      if team and team.pets and next(team.pets) then
        for k, v in pairs(team.pets) do
          if v and v == id then
            return false
          elseif v and 0 < v and checkPet:IsBinderPet(v) then
            return false
          end
        end
      end
      local isWorking = self._uiSeasonMazeModule:GetPetState(id, ESeasonMazePetStateType.ESeasonMazePetStateType_Dispatch)
      if isWorking then
        return false
      end
      local isDie = self._uiSeasonMazeModule:GetPetState(id, ESeasonMazePetStateType.ESeasonMazePetStateType_Dead)
      if isDie then
        return false
      end
      return true
    end)
    if allPets and table.count(allPets) > 0 then
      return true
    end
  end
  return false
end

function UISeasonMazePetsTeams:UIWidget()
  self._btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._hlgLayout = self:GetUIComponent("GridLayoutGroup", "hlg")
  self._hlgPath = self:GetUIComponent("UISelectObjectPath", "hlg")
  self._uiTeamsLeaderPath = self:GetUIComponent("UISelectObjectPath", "leader")
  self._replaceTran = self:GetUIComponent("RectTransform", "replace")
  self._replaceCard = nil
  self._replaceCardPath = self:GetUIComponent("UISelectObjectPath", "card")
  self._imgCondition = self:GetUIComponent("RectTransform", "imgCondition")
  self._txtCondition = self:GetUIComponent("UILocalizationText", "txtCondition")
  self._animation = self:GetUIComponent("Animation", "animation")
  self._atlasProperty = self:GetAsset("Property.spriteatlas", LoadType.SpriteAtlas)
  self._atlasAwake = self:GetAsset("UIAwake.spriteatlas", LoadType.SpriteAtlas)
  self._atlasProf = self:GetAsset("UIPetJobIcon.spriteatlas", LoadType.SpriteAtlas)
  self._uiSeasonMazeAtlas = self:GetAsset("SeasonMaze.spriteatlas", LoadType.SpriteAtlas)
  self._primaryTips = self:GetGameObject("primaryTips")
  self._primaryTips:SetActive(false)
  self._primaryRollingTipsGo = self:GetGameObject("primaryRollingTips")
  self._primaryRollingTipsText = self:GetUIComponent("UILocalizationText", "primaryRollingTipsText")
  if self._primaryRollingTipsGo then
    self._primaryRollingTipsGo:SetActive(false)
  end
  self._diaSp1 = self._uiSeasonMazeAtlas:GetSprite("cn14_sjmj_zdf_di017")
  self._diaSp2 = self._uiSeasonMazeAtlas:GetSprite("cn14_sjmj_zdf_di016")
end

function UISeasonMazePetsTeams:GetHpCfg()
  return self._dialLine2Hp, self._bigDiaLine, self._diaSp1, self._diaSp2
end

function UISeasonMazePetsTeams:DefaultVisible()
  self._replaceTran.gameObject:SetActive(false)
end

function UISeasonMazePetsTeams:AddEvents()
  self:AttachEvent(GameEventType.ActivityCloseEvent, self.OnActivityCloseEvent)
  self:AttachEvent(GameEventType.DiscoveryChangeTeamData, self.FlushTeam)
  self:AttachEvent(GameEventType.TeamItemLongPress, self.TeamItemLongPress)
  self:AttachEvent(GameEventType.TeamUpdateReplaceCardPos, self.UpdateReplaceCardPos)
end

function UISeasonMazePetsTeams:InitCommonTopButton()
  self._backBtns = self._btns:SpawnObject("UISMazeCommonTopButton")
  self._backBtns:SetData(function()
    self:CloseDialog()
  end, nil, function()
    UICommonHelper:GetInstance():SwitchToUIMain()
  end, false, nil)
end

function UISeasonMazePetsTeams:InitTeams()
  self._hlgSpawns = self._hlgPath:SpawnObjects("UISeasonMazePetsTeamsItem", self._widgetCount)
  for k, v in pairs(self._hlgSpawns) do
    v:GetGameObject().name = k - 1
  end
  self:OnLayoutChanged(0)
  for k, v in pairs(self._hlgSpawns) do
    v:InitData(self._atlasProperty, self._atlasAwake, self._atlasProf, function(slot)
      self:OpenTeamMemberSelect(slot)
    end, function()
      local petList = {}
      local allPets = self._uiSeasonMazeModule:GetSeasonMazePets()
      local teamid = self._ctx:GetCurrTeamId()
      local team = self._teams:Get(teamid)
      if team.pets and next(team.pets) then
        for key, value in pairs(team.pets) do
          local pet = allPets[value]
          if pet then
            table.insert(petList, pet)
          end
        end
      end
      return petList
    end, function()
      return self:GetHpCfg()
    end)
  end
  self._replaceCard = self._replaceCardPath:SpawnObject("UISeasonMazePetsTeamsItem")
  self._replaceCard:InitData(self._atlasProperty, self._atlasAwake, self._atlasProf, function(slot)
    self:OpenTeamMemberSelect(slot)
  end, function()
    local petList = {}
    local allPets = self._uiSeasonMazeModule:GetSeasonMazePets()
    local teamid = self._ctx:GetCurrTeamId()
    local team = self._teams:Get(teamid)
    if team.pets and next(team.pets) then
      for key, value in pairs(team.pets) do
        local pet = allPets[value]
        if pet then
          table.insert(petList, pet)
        end
      end
    end
    return petList
  end, function()
    return self:GetHpCfg()
  end)
end

function UISeasonMazePetsTeams:OnLayoutChanged(deltaTimeMS)
  local newLayoutWidth = self._hlgLayout.transform.rect.width
  if self._layoutWidth ~= newLayoutWidth then
    self._layoutWidth = newLayoutWidth
    local padding = self._hlgLayout.padding
    local itemWidth = (newLayoutWidth - padding.right) * 0.5
    local cellSize = self._hlgLayout.cellSize
    cellSize = Vector2(itemWidth, cellSize.y)
    self._hlgLayout.cellSize = cellSize
    self._replaceTran.sizeDelta = cellSize
    UnityEngine.UI.LayoutRebuilder.MarkLayoutForRebuild(self._hlgLayout.transform)
  end
end

function UISeasonMazePetsTeams:FlushTeam(teamId)
  local allPets = self._uiSeasonMazeModule:GetSeasonMazePets()
  for k, v in ipairs(self._hlgSpawns) do
    local petList = self._ctx:Teams():Get(teamId).pets
    local pstid = petList[k]
    local pet = allPets[pstid]
    v:FlushPet(k, pet)
  end
  self.ctid = teamId
end

function UISeasonMazePetsTeams:InAnimation()
  local lockName = "UISeasonMazePetsTeams:InAnimation"
  self:StartTask(function(TT)
    self:Lock(lockName)
    self._animation:Play("effanim_UISeasonMazePetsTeams_in")
    YIELD(TT, 500)
    self:UnLock(lockName)
  end)
end

function UISeasonMazePetsTeams:OnActivityCloseEvent(id)
  self:CloseDialog()
end

function UISeasonMazePetsTeams:OpenTeamMemberSelect(slot)
  self._ctx:InitTeamMemberSelect(slot)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  self:ShowDialog("UISeasonMazeTeamChangeController")
end

function UISeasonMazePetsTeams:UpdateFormationInfo(newTeam)
  local lockName = "UISeasonMazePetsTeams:UpdateFormationInfo"
  self:StartTask(function(TT)
    self:Lock(lockName)
    local teamId = newTeam:GetID()
    local teamName = newTeam:GetName()
    local pets = newTeam:GetPets()
    local res = self._seasonMazeModule:ReqSeasonMazeChangeFormationInfo(TT, teamId, teamName, pets)
    if res:GetSucc() then
      self._ctx.seasonMazeTeam:UpdateTeam(newTeam)
      self:FlushTeam(teamId)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
    else
      Log.fatal("### 更新编队失败 ")
    end
    self:UnLock(lockName)
  end)
end

function UISeasonMazePetsTeams:TeamItemLongPress(isBegin, slot, pet)
  local teamId = self._ctx:GetCurrTeamId()
  if isBegin then
    self._isLongPressing = true
    self._replaceCard:FlushPet(slot, pet, false)
    self._replaceCard:HideGuideWarn()
  else
    self._isLongPressing = false
    local WorldToScreenPoint = UnityEngine.RectTransformUtility.WorldToScreenPoint
    local RectangleContainsScreenPoint = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    for i, v in pairs(self._hlgSpawns) do
      local tran = v:GetGameObject().transform
      local screenPos = WorldToScreenPoint(camera, self._replaceTran.position)
      local inSlot = RectangleContainsScreenPoint(tran, screenPos, camera)
      local localPos = tran:InverseTransformPoint(self._replaceTran.position)
      if tran.rect:Contains(localPos) and not v:IsLocked() then
        local teamid = self._ctx:GetCurrTeamId()
        local team = self._teams:Get(teamid)
        local tmpTeam = team:Clone()
        tmpTeam:Swap(slot, i)
        self:UpdateFormationInfo(tmpTeam)
        break
      end
    end
  end
  self._replaceTran.gameObject:SetActive(self._isLongPressing)
end

function UISeasonMazePetsTeams:UpdateReplaceCardPos(screenPos)
  if self._replaceTran ~= nil then
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._replaceTran.parent, screenPos, camera)
    self._replaceTran.position = pos
  end
end

function UISeasonMazePetsTeams:CheckTeamValid()
  local teamid = self._ctx:GetCurrTeamId()
  local team = self._teams:Get(teamid)
  if not team or not team.pets then
    return false
  end
  if table.count(team.pets) <= 0 then
    return false
  end
  local leaderId = team.pets[1]
  if not leaderId then
    return false
  end
  if leaderId == 0 then
    return false
  end
  return true, team
end

function UISeasonMazePetsTeams:CheckTeamMemberDuplicate()
  local teamid = self._ctx:GetCurrTeamId()
  local team = self._teams:Get(teamid)
  if not team or not team.pets then
    return false
  end
  local petModule = self:GetModule(PetModule)
  local dic = {}
  for index, pstId in pairs(team.pets) do
    if 0 < pstId then
      local petData = petModule:GetPet(pstId)
      if petData then
        local tmpId = petData:GetTemplateID()
        if dic[tmpId] == nil then
          dic[tmpId] = 0
        end
        dic[tmpId] = dic[tmpId] + 1
      end
    end
  end
  for k, v in pairs(dic) do
    if 1 < v then
      return false
    end
  end
  return true
end

function UISeasonMazePetsTeams:_MatchStart(TT, nMatchType, teamId, createInfo)
  self._matchType = nMatchType
  self._matchTeamId = teamId
  self._matchCreateInfo = createInfo
  self:_OnMatchStart()
end

function UISeasonMazePetsTeams:_OnMatchStart()
  self:StartTask(self.StartMatchTask, self, self._matchType, self._matchTeamId, self._matchCreateInfo)
end

function UISeasonMazePetsTeams:StartMatchTask(TT, nMatchType, teamId, createInfo)
  local game = GameGlobal.GetModule(GameMatchModule)
  local res = game:StartMatchTask(TT, nMatchType, teamId, createInfo)
  self:UnLock("DoEnterMatch")
  if not res:GetSucc() then
    if GameGlobal.UIStateManager():IsShow("UIAircraftTacticSwitch") then
      GameGlobal.UIStateManager():CloseDialog("UIAircraftTacticSwitch")
    end
    local result = res:GetResult()
    if result == MatchOpResCode.MATCH_NOT_ENOUGH_PHY_POWER then
      self:ShowDialog("UIGetPhyPointController")
    elseif result == MatchOpResCode.MATCH_CAMPAIGN_MISSIOHN_CROSS_DAY then
      ToastManager.ShowToast(game:GetErrorMsg(result))
      if nMatchType == MatchType.MT_BlackFist then
        self:SwitchState(UIStateType.UIBlackFightMain)
      else
        self:SwitchState(UIStateType.UIActivityN5BattleField)
      end
    elseif result == MatchOpResCode.MATCH_WORLD_BOSS_MISSION_INVALID then
      ToastManager.ShowToast(game:GetErrorMsg(result))
      self:SwitchState(UIStateType.UIWorldBoss)
    elseif result == MatchOpResCode.MATCH_DM_FORMATION_INVALID then
      local tips = StringTable.Get("str_diff_mission_MATCH_DM_FORMATION_INVALID")
      ToastManager.ShowToast(tips)
    elseif result == MatchOpResCode.MATCH_CAMPAIGN_CamNotOpen or result == MatchOpResCode.MATCH_CAMPAIGN_ComNotOpen then
      local res = AsyncRequestRes:New()
      res:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED)
      self._seasonMazeModule:CheckSeasonMazeClose(res)
    else
      ToastManager.ShowToast(game:GetErrorMsg(result))
    end
    return
  end
  local serial = GameGlobal.GetModule(SerialAutoFightModule)
  serial:StartSerialFight()
end
