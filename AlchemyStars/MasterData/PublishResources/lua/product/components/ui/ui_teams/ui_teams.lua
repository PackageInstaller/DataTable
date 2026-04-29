_class("UITeams", UIController)
UITeams = UITeams

function UITeams:Constructor()
  self._module = self:GetModule(MissionModule)
  self.ctx = self._module:TeamCtx()
  self.ctid = nil
  self._param = self.ctx.param
  self._teamOpenerType = self.ctx.teamOpenerType
  self._teams = self.ctx:Teams()
  self._lastClickTime = 0
end

function UITeams:OnShow(uiParams)
  self:UnLock("DoEnterTeam")
  self._fightCallback = uiParams and uiParams[1]
  self._blockMask = self:GetGameObject("blockMask")
  local mdSerialFight = GameGlobal.GetModule(SerialAutoFightModule)
  if mdSerialFight:IsRunning() then
    local autoBtnPool = self:GetUIComponent("UISelectObjectPath", "pool")
    self._autoBtn = autoBtnPool:SpawnObject("UIWidgetSerialButton")
    self._blockMask:SetActive(true)
  else
    self._blockMask:SetActive(false)
    mdSerialFight:ResetModuleData()
  end
  self:AttachEvent(GameEventType.CancelSerialAutoFight, self.OnCancelSerialAutoFight)
  local hideHomeBtn = mdSerialFight:IsInited()
  
  local function backCallback()
    local hpm = self:GetModule(HelpPetModule)
    hpm:UI_ClearHelpPet()
    self:GetModule(PetModule):ClearAllPetSortInfo()
    mdSerialFight:ResetModuleData()
    local isFightAgain = self.ctx:GetFightAgain()
    if self.ctx.teamOpenerType == TeamOpenerType.SmallMap then
      self:SwitchState(UIStateType.UIMain)
    elseif self.ctx.teamOpenerType == TeamOpenerType.ResInstance then
      if isFightAgain then
        self:SwitchState(UIStateType.UIResDetailController, self.ctx.param)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.Maze then
      if isFightAgain then
        UIMazeController.SetToOpenRoomIndex(self.ctx.param)
        GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Maze_Enter, "mj_01")
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.ExtMission then
      if isFightAgain then
        local extraMissionID = self.ctx.param[1]
        local stageId = self.ctx.param[2]
        self:SwitchState(UIStateType.UIExtraMissionStage, extraMissionID, stageId)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.Stage then
      if isFightAgain then
        DiscoveryData.EnterStateUIDiscovery(3, self.ctx.param)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.Tower then
      if isFightAgain then
        local element = self.ctx:GetTowerElement()
        self:SwitchState(UIStateType.UITowerLayer, element)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.Main then
      self:CloseDialog()
    elseif self.ctx.teamOpenerType == TeamOpenerType.Trail then
      self:CloseDialog()
    elseif self.ctx.teamOpenerType == TeamOpenerType.Sailing then
      self:CloseDialog()
    elseif self.ctx.teamOpenerType == TeamOpenerType.Vampire then
      self:CloseDialog()
    elseif self.ctx.teamOpenerType == TeamOpenerType.Campaign then
      if isFightAgain then
        local match = GameGlobal.GetModule(MatchModule)
        local enterData = match:GetMatchEnterData()
        if self:IsSeasonTalentTree(enterData) then
          self:ExitBattle2SeasonT(enterData)
        elseif self:IsSeaonOnceMissionBlackFist(enterData) then
          self:ExitBattle2OnceMissionBlackFist(enterData)
        else
          local campaignMissionInfo = enterData:GetCampaignMissionInfo()
          local campaignModule = GameGlobal.GetModule(CampaignModule)
          campaignModule:ExitBattle(campaignMissionInfo)
        end
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.LostLand then
      if isFightAgain then
        local misisonid = self.ctx.param
        self:SwitchState(UIStateType.UILostLandStage, misisonid)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.Conquest then
      if isFightAgain then
        self:SwitchState(UIStateType.UIActivityN5BattleField)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
      if isFightAgain then
        self:SwitchState(UIStateType.UIWorldBoss)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.N21CC then
      if isFightAgain then
        local match = GameGlobal.GetModule(MatchModule)
        local enterData = match:GetMatchEnterData()
        local campaignMissionInfo = enterData:GetCampaignMissionInfo()
        local campaignModule = GameGlobal.GetModule(CampaignModule)
        campaignModule:ExitBattle(campaignMissionInfo)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.Diff then
      self:CloseDialog()
    elseif self.ctx.teamOpenerType == TeamOpenerType.BlackFist then
      if isFightAgain then
        local info = GameGlobal.GetModule(MatchModule):GetMatchEnterData():GetBlackFistInfo()
        GameGlobal.GetModule(CampaignModule):ExitBattle(info)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.Air then
      self:CloseDialog()
    elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
      self:CloseDialog()
    elseif self.ctx.teamOpenerType == TeamOpenerType.Season then
      if isFightAgain then
        local matchModule = self:GetModule(MatchModule)
        local enterData = matchModule:GetMatchEnterData()
        local seasonMissionInfo = enterData:GetSeasonMissionInfo()
        local seasonModule = GameGlobal.GetModule(SeasonModule)
        local rt
        seasonModule:ExitBattle(seasonMissionInfo)
      else
        self:CloseDialog()
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
      self:CloseDialog()
    elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
      self:CloseDialog()
    elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
      local anipopModule = GameGlobal.GetModule(AnipopModule)
      local anipopInfo = anipopModule:GetAniPopInfo()
      local roundInfo = anipopInfo.round_info
      local levelInfo = roundInfo.level_list[roundInfo.mission_index]
      if not anipopInfo or not levelInfo then
        GameGlobal.UIStateManager():SwitchState(UIStateType.UIEliminateController)
        ToastManager.ShowToast(StringTable.Get("str_pet_config_pet_error_faild19"))
      else
        self:SwitchState(UIStateType.UIEliminateLevelController)
      end
    elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonOnceMission then
      if isFightAgain then
        local matchModule = self:GetModule(MatchModule)
        local enterData = matchModule:GetMatchEnterData()
        UISeasonHelper.TrySeasonBattleExit(enterData:GetMatchType(), false)
      else
        self:CloseDialog()
      end
    else
      self:SwitchState(UIStateType.UIMain)
    end
  end
  
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtns = btns:SpawnObject("UINewCommonTopButton")
  self._backBtns:SetData(backCallback, nil, function()
    local hpm = self:GetModule(HelpPetModule)
    hpm:UI_ClearHelpPet()
    if self.ctx.teamOpenerType == TeamOpenerType.Air then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.AircraftLeaveAircraft)
      GameGlobal.LoadingManager():StartLoading(LoadingHandlerName.Aircraft_Exit, "UI")
    else
      UICommonHelper:GetInstance():SwitchToUIMain()
    end
  end, hideHomeBtn)
  self._leftTglGroupArrow = self:GetGameObject("leftArrow")
  self._rightTglGroupArrow = self:GetGameObject("rightArrow")
  self._btnChangeName = self:GetGameObject("btnChangeName")
  self._tglGoupTrans = self:GetUIComponent("RectTransform", "hlgTgls")
  self._tglScrollViewTrans = self:GetUIComponent("RectTransform", "TglScrollView")
  self._tglScrollView = self:GetUIComponent("ScrollRect", "TglScrollView")
  self._fightBtnTrans = self:GetUIComponent("RectTransform", "btnFight")
  self._viewPointTrans = self:GetUIComponent("RectTransform", "TglViewport")
  self._safeArea = self:GetUIComponent("RectTransform", "SafeArea")
  self._canvas = self._safeArea.parent:GetComponent("RectTransform")
  self._tglGroupOriginPosX = self._tglGoupTrans.anchoredPosition.x - 1
  self._leftTglGroupArrow:SetActive(false)
  self._rightTglGroupArrow:SetActive(false)
  self._btnChangeName:SetActive(false)
  local height = self._tglScrollViewTrans.sizeDelta.y
  if self._teamOpenerType ~= TeamOpenerType.Main and self._teamOpenerType ~= TeamOpenerType.SmallMap then
    local height = self._tglScrollViewTrans.sizeDelta.y
    self._tglScrollViewTrans.sizeDelta = Vector2(self._safeArea.rect.size.x - self._fightBtnTrans.sizeDelta.x + 30, height)
  else
    self._tglScrollViewTrans.sizeDelta = Vector2(self._safeArea.rect.size.x, height)
  end
  if self._teamOpenerType == TeamOpenerType.WorldBoss or self._teamOpenerType == TeamOpenerType.Diff or self._teamOpenerType == TeamOpenerType.N21CC or self._teamOpenerType == TeamOpenerType.Sailing or self.ctx.teamOpenerType == TeamOpenerType.Vampire or self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
  else
    self._btnChangeName:SetActive(true)
    if GameSingle then
      self._btnChangeName:SetActive(false)
    end
    self._tglGroup = self:GetUIComponent("ToggleGroup", "hlgTgls")
    local hlgTgls = self:GetUIComponent("UISelectObjectPath", "hlgTgls")
    local teamCount = self.ctx:GetTeamCount()
    hlgTgls:SpawnObjects("UITeamsSelectItem", teamCount)
    self._hlgTglsSpawns = hlgTgls:GetAllSpawnList()
    for i, v in ipairs(self._hlgTglsSpawns) do
      v:Init(i, self, self._tglGroup, self._tglScrollView)
    end
    self._tglScrollView.onValueChanged:AddListener(function()
      self._maxScrollDis = self._tglGoupTrans.sizeDelta.x - self._viewPointTrans.rect.width
      if self._maxScrollDis < 0 then
        self._rightTglGroupArrow:SetActive(0 < self._tglGoupTrans.anchoredPosition.x and math.abs(self._tglGoupTrans.anchoredPosition.x) > math.abs(self._maxScrollDis))
      else
        self._rightTglGroupArrow:SetActive(math.abs(self._tglGoupTrans.anchoredPosition.x) < math.abs(self._maxScrollDis))
      end
      self._leftTglGroupArrow:SetActive(self._tglGoupTrans.anchoredPosition.x < self._tglGroupOriginPosX)
    end)
  end
  self.tranHlg = self:GetUIComponent("RectTransform", "hlg")
  self.hlg = self:GetUIComponent("UISelectObjectPath", "hlg")
  local goFight = self:GetGameObject("btnFight")
  goFight:SetActive(self._teamOpenerType ~= TeamOpenerType.Main and self._teamOpenerType ~= TeamOpenerType.SmallMap)
  local leader = self:GetUIComponent("UISelectObjectPath", "leader")
  self._uiTeamsLeader = leader:SpawnObject("UITeamsLeader")
  self._replaceGo = self:GetGameObject("replace")
  self._replaceTran = self:GetUIComponent("RectTransform", "replace")
  self._replaceGo:SetActive(false)
  self._isLongPressing = false
  self._btnTxt = self:GetUIComponent("UILocalizationText", "Text")
  self._mazeTeamTips = self:GetGameObject("mazeTips")
  self._mazeTeamTipsText = self:GetUIComponent("UILocalizationText", "Tips")
  self._airTeamTips = self:GetGameObject("airTips")
  self._airTeamTips:SetActive(self.ctx.teamOpenerType == TeamOpenerType.Air)
  self._seasonTeamTips = self:GetGameObject("seasonTips")
  self._seasonTeamTipsText = self:GetUIComponent("UILocalizationText", "SeasonTipsText")
  self._campaignTips = self:GetGameObject("campaignTips")
  self._campaignTipsText = self:GetUIComponent("UILocalizationText", "CampaignTipsText")
  self:_CheckTeamTips()
  self:_CheckCampaignTeamTips()
  self:AttachEvent(GameEventType.DiscoveryChangeTeamData, self.FlushTeam)
  self:AttachEvent(GameEventType.TeamItemLongPress, self.TeamItemLongPress)
  self:AttachEvent(GameEventType.TeamUpdateReplaceCardPos, self.UpdateReplaceCardPos)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(goFight), UIEvent.Press, function(go)
    self._isDown = true
    self._btnTxt.color = Color(1, 1, 1, 1)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(goFight), UIEvent.Hovered, function(go)
    if self._isDown then
      self._btnTxt.color = Color(1, 1, 1, 1)
    end
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(goFight), UIEvent.Unhovered, function(go)
    self._btnTxt.color = Color(1, 1, 1, 1)
  end)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(goFight), UIEvent.Release, function(go)
    self._isDown = false
  end)
  local teamid = self.ctx:GetCurrTeamId()
  self:FlushTeam(teamid)
  if self.ctx.teamOpenerType == TeamOpenerType.Maze then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenTeamUI, self.ctx.teamOpenerType, -1)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenTeamUI, self.ctx.teamOpenerType, self.ctx.param)
  end
  self:TglBtnPosReset()
end

function UITeams:RightArrowOnClick()
  local teamCount = self.ctx:GetTeamCount()
  local maxWidth = self._tglGoupTrans.sizeDelta.x
  local teamItemWidth = maxWidth / teamCount
  local maxScrollWidth = self._tglGoupTrans.sizeDelta.x - self._viewPointTrans.rect.width
  local pos = self._tglGoupTrans.anchoredPosition
  for i = 1, teamCount do
    local cur = -maxScrollWidth + teamItemWidth * i
    local last = -maxScrollWidth + teamItemWidth * (i - 1)
    if 0 < cur then
      break
    end
    if cur > pos.x and last < pos.x then
      if pos.x - last > 1 then
        self._tglGoupTrans.anchoredPosition = Vector3(last, pos.y, pos.z)
        return
      else
        break
      end
    end
  end
  local x = pos.x - teamItemWidth
  x = x < -maxScrollWidth and -maxScrollWidth or x
  self._tglGoupTrans.anchoredPosition = Vector3(x, pos.y, pos.z)
end

function UITeams:LeftArrowOnClick()
  local teamCount = self.ctx:GetTeamCount()
  local maxWidth = self._tglGoupTrans.sizeDelta.x
  local teamItemWidth = maxWidth / teamCount
  local pos = self._tglGoupTrans.anchoredPosition
  for i = 1, teamCount do
    local cur = -teamItemWidth * i
    local last = -teamItemWidth * (i - 1)
    if cur < -maxWidth then
      break
    end
    if cur < pos.x and last > pos.x then
      if last - pos.x > 1 then
        self._tglGoupTrans.anchoredPosition = Vector3(last, pos.y, pos.z)
        return
      else
        break
      end
    end
  end
  local x = pos.x + teamItemWidth
  x = 0 < x and 0 or x
  self._tglGoupTrans.anchoredPosition = Vector3(x, pos.y, pos.z)
end

function UITeams:BtnPosResetToShow()
  local maxWidth = self._tglGoupTrans.sizeDelta.x
  local teamCount = self.ctx:GetTeamCount()
  local teamItemWidth = maxWidth / teamCount
  local pos = self._tglGoupTrans.anchoredPosition
  local maxScrollWidth = self._tglGoupTrans.sizeDelta.x - self._viewPointTrans.rect.width
  local nextPos
  local select = self.ctx:GetCurrTeamId()
  if 1 < teamCount then
    local seletbtn = self._hlgTglsSpawns[select]
    local btnRectTrans = seletbtn.view:GetComponent("RectTransform")
    local anchoredPosX = btnRectTrans.anchoredPosition.x
    local halfWidth = teamItemWidth / 2
    if anchoredPosX + pos.x + halfWidth > self._viewPointTrans.rect.width then
      for i = 1, teamCount do
        local cur = -maxScrollWidth + teamItemWidth * i
        local last = -maxScrollWidth + teamItemWidth * (i - 1)
        if 0 < cur then
          break
        end
        if cur > pos.x and last < pos.x then
          if pos.x - last > 1 then
            self._tglGoupTrans.anchoredPosition = Vector3(last, pos.y, pos.z)
            return
          else
            break
          end
        end
      end
    elseif anchoredPosX + pos.x - halfWidth < 0 then
      for i = 1, teamCount do
        local cur = -teamItemWidth * i
        local last = -teamItemWidth * (i - 1)
        if cur < -maxWidth then
          break
        end
        if cur < pos.x and last > pos.x then
          if last - pos.x > 1 then
            self._tglGoupTrans.anchoredPosition = Vector3(last, pos.y, pos.z)
            return
          else
            break
          end
        end
      end
    end
  end
end

function UITeams:TglBtnPosReset()
  UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tglGoupTrans)
  local select = self.ctx:GetCurrTeamId()
  if self.ctx:GetTeamCount() > 1 then
    local seletbtn = self._hlgTglsSpawns[select]
    local btnRectTrans = seletbtn.view:GetComponent("RectTransform")
    local anchoredPosX = btnRectTrans.anchoredPosition.x
    if anchoredPosX > self._viewPointTrans.rect.width / 2 then
      local maxMove = self._tglGoupTrans.sizeDelta.x - self._viewPointTrans.rect.width
      local move = anchoredPosX - self._viewPointTrans.rect.width / 2
      if maxMove < move then
        move = maxMove
      end
      local originY = self._tglGoupTrans.anchoredPosition.y
      self._tglGoupTrans.anchoredPosition = Vector2(-move, originY)
    end
  end
end

function UITeams:OnHide()
  self._backBtns = nil
  self:DetachEvent(GameEventType.DiscoveryChangeTeamData, self.FlushTeam)
  self:DetachEvent(GameEventType.TeamItemLongPress, self.TeamItemLongPress)
  self:DetachEvent(GameEventType.TeamUpdateReplaceCardPos, self.UpdateReplaceCardPos)
  local isFightAgain = self.ctx:GetFightAgain()
  if isFightAgain then
    self.ctx:SetFightAgain(false)
  end
  if self.ctx:IsFastSelect() then
    self.ctx:ClearFastSelect()
  end
  if self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
    self.ctx:Init(TeamOpenerType.Main, 0)
  end
  local hpm = self:GetModule(HelpPetModule)
  hpm:UI_ClearHelpPet()
  self:GetModule(PetModule):ClearAllPetSortInfo()
end

function UITeams:FlushTeam(teamId)
  self._teams = self.ctx:Teams()
  local team = self._teams:Get(teamId)
  if not team then
    return
  end
  if self._hlgTglsSpawns then
    for i, v in ipairs(self._hlgTglsSpawns) do
      local info = self._teams:Get(i)
      if info then
        v:FlushName(info.id)
      end
    end
  end
  self.ctx:SetCurrTeamId(teamId)
  self._replaceTran.sizeDelta = Vector2(self.tranHlg.rect.width / team.teamSlotCount, self.tranHlg.rect.height)
  self.hlg:SpawnObjects("UITeamItem", team.teamSlotCount)
  self._uiSlots = self.hlg:GetAllSpawnList()
  for i, v in ipairs(self._uiSlots) do
    v:PlayAnimIn((i - 1) * 70)
    v:FlushTeamMember(i, teamId)
    v:Flush(team.pets[i])
    v:FlushCallback(function()
      self:OpenTeamMemberSelect(i)
    end)
    local state = self:GetHelpPetState()
    v:FlushHelpPetState(state == 1)
  end
  self._uiTeamsLeader:Flush(team.pets[1])
  if self._hlgTglsSpawns then
    for i, v in ipairs(self._hlgTglsSpawns) do
      if v:GetId() == teamId then
        v:FlushTglIsOn(true)
        break
      end
    end
  end
  self.ctid = teamId
  self:BtnPosResetToShow()
end

function UITeams:OpenTeamMemberSelect(slot)
  local teamCtx = self._module:TeamCtx()
  teamCtx:InitTeamMemberSelect(slot)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
  if self._teamOpenerType == TeamOpenerType.Maze then
    self:ShowDialog("UITeamChangeController")
  elseif self._teamOpenerType == TeamOpenerType.Stage then
    local state = self:GetHelpPetState()
    self:ShowDialog("UITeamChangeController", nil, nil, nil, state)
  elseif self._teamOpenerType == TeamOpenerType.ExtMission then
    local state = self:GetHelpPetState()
    self:ShowDialog("UITeamChangeController", nil, nil, nil, state)
  elseif self._teamOpenerType == TeamOpenerType.Tower then
    self:ShowDialog("UITeamChangeController")
  elseif self._teamOpenerType == TeamOpenerType.Main then
    self:ShowDialog("UITeamChangeController")
  elseif self._teamOpenerType == TeamOpenerType.ResInstance then
    self:ShowDialog("UITeamChangeController")
  elseif self._teamOpenerType == TeamOpenerType.Trail then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, false)
  elseif self._teamOpenerType == TeamOpenerType.Campaign then
    local state = self:GetHelpPetState()
    self:ShowDialog("UITeamChangeController", nil, nil, nil, state)
  elseif self._teamOpenerType == TeamOpenerType.LostLand then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, 0)
  elseif self._teamOpenerType == TeamOpenerType.Conquest then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  elseif self._teamOpenerType == TeamOpenerType.BlackFist then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  elseif self._teamOpenerType == TeamOpenerType.WorldBoss then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  elseif self._teamOpenerType == TeamOpenerType.N21CC then
    local state = self:GetHelpPetState()
    self:ShowDialog("UITeamChangeController", nil, nil, nil, state)
  elseif self._teamOpenerType == TeamOpenerType.Air then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  elseif self._teamOpenerType == TeamOpenerType.Diff then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  elseif self._teamOpenerType == TeamOpenerType.Sailing then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, false)
  elseif self._teamOpenerType == TeamOpenerType.Vampire then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, false)
  elseif self._teamOpenerType == TeamOpenerType.Camp_Diff then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  elseif self._teamOpenerType == TeamOpenerType.Season then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  elseif self._teamOpenerType == TeamOpenerType.PopStarPro then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  elseif self._teamOpenerType == TeamOpenerType.AniPopStar then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  elseif self._teamOpenerType == TeamOpenerType.SeasonOnceMission then
    self:ShowDialog("UITeamChangeController", nil, nil, nil, self:GetHelpPetState())
  else
    self:SwitchState(UIStateType.UITeamChangeController)
  end
end

function UITeams:GetHelpPetState()
  if GameSingle then
    return false
  end
  local enable = 0
  local module = self:GetModule(RoleModule)
  local isLock = not module:CheckModuleUnlock(GameModuleID.MD_HelpPet)
  if isLock then
    return enable
  end
  if self._teamOpenerType == TeamOpenerType.Stage then
    local missionId = self._param
    local mission = Cfg.cfg_mission[missionId]
    if mission then
      local levelId = mission.FightLevel
      enable = Cfg.cfg_level[levelId].EnableHelpPet
    end
  elseif self._teamOpenerType == TeamOpenerType.ExtMission then
    local extmissionId = self._param[2]
    local extmission = Cfg.cfg_extra_mission_task[extmissionId]
    if extmission then
      local levelId = extmission.FightLevel
      enable = Cfg.cfg_level[levelId].EnableHelpPet
    end
  elseif self._teamOpenerType == TeamOpenerType.Campaign then
    local missionId = self._param[1]
    local mission = Cfg.cfg_campaign_mission[missionId]
    if mission then
      local levelId = mission.FightLevel
      enable = Cfg.cfg_level[levelId].EnableHelpPet
    end
  elseif self._teamOpenerType == TeamOpenerType.Conquest then
    local levelId = self._param[5]
    if levelId then
      enable = Cfg.cfg_level[levelId].EnableHelpPet
    end
  elseif self._teamOpenerType == TeamOpenerType.BlackFist then
    local missionId = self._param[1]
    local mission = Cfg.cfg_blackfist_mission[missionId]
    if mission then
      local levelId = mission.LevelID
      enable = Cfg.cfg_level[levelId].EnableHelpPet
    end
  elseif self._teamOpenerType == TeamOpenerType.WorldBoss then
    local worldBossModule = self:GetModule(WorldBossModule)
    local index = worldBossModule:GetBossLevelDifficultyIndex()
    local missionId = self._param[1]
    self._param[2] = index - 1
    local cfg_world_boss_mission = Cfg.cfg_world_boss_mission[missionId]
    if cfg_world_boss_mission then
      local levelId = cfg_world_boss_mission.FightLevel[index]
      enable = Cfg.cfg_level[levelId].EnableHelpPet
    end
  elseif self._teamOpenerType == TeamOpenerType.N21CC then
    local missionId = self._param[1]
    local mission = Cfg.cfg_campaign_mission[missionId]
    if mission then
      local levelId = mission.FightLevel
      enable = Cfg.cfg_level[levelId].EnableHelpPet
    end
  elseif self._teamOpenerType == TeamOpenerType.Diff or self._teamOpenerType == TeamOpenerType.Sailing or self._teamOpenerType == TeamOpenerType.Vampire or self._teamOpenerType == TeamOpenerType.Camp_Diff then
  elseif self._teamOpenerType == TeamOpenerType.Air then
    local isBlackFist = self._param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_AircraftBlackfist
    if isBlackFist then
      local missionId = self._param[1]
      local mission = Cfg.cfg_blackfist_mission[missionId]
      if mission then
        local levelId = mission.LevelID
        enable = Cfg.cfg_level[levelId].EnableHelpPet
      end
    else
      local missionid = self._param[1]
      local cfg_campaign_mission = Cfg.cfg_campaign_mission[missionid]
      if not cfg_campaign_mission then
        Log.error("###[UITeams] cfg_campaign_mission is nil ! id --> ", missionid)
      end
      local levelId = cfg_campaign_mission.FightLevel
      if levelId then
        enable = Cfg.cfg_level[levelId].EnableHelpPet
      end
    end
  elseif self._teamOpenerType == TeamOpenerType.Season then
    local missionId = self._param[1]
    local progress = self._param[5]
    local mission = Cfg.cfg_season_mission[missionId]
    if mission then
      local levelId = mission.FightLevel[progress]
      enable = Cfg.cfg_level[levelId].EnableHelpPet
    end
  elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
  elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
  elseif self._teamOpenerType == TeamOpenerType.SeasonOnceMission then
    enable = false
  end
  return enable
end

function UITeams:BtnChangeNameOnClick(go)
  if self.ctid then
    self:ShowDialog("UITeamsNameModify", self.ctid)
  end
end

function UITeams:btnClearOnClick(go)
  local teamid = self.ctx:GetCurrTeamId()
  local team = self._teams:Get(teamid)
  if not team:HasPet() then
    return
  end
  PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_discovery_clear_all_pet_or_not"), function(param)
    self:StartTask(function(TT)
      local hpm = self:GetModule(HelpPetModule)
      hpm:UI_ClearHelpPet()
      if self.ctx.teamOpenerType == TeamOpenerType.Tower then
        local curTeamId = self.ctx:GetCurrTeamId()
        local team = self._teams:Get(curTeamId):Clone()
        team:ClearPet()
        local module = self:GetModule(TowerModule)
        self:Lock("module:UpdateMainFormationInfo")
        local res, mul_formations = self.ctx:ReqTowerChangeMulFormationInfo(TT, team)
        self:UnLock("module:UpdateMainFormationInfo")
        if res:GetSucc() then
          self.ctx:InitTowerTeam(mul_formations)
          self._teams = self.ctx:GetTowerTeam()
          local element = self.ctx:GetTowerElement()
          local teams = self.ctx:RawGetTowerTeam(element)
          teams:UpdateTeam(team)
          self:FlushTeam(curTeamId)
        else
          ToastManager.ShowToast(module:GetErrorMsg(res:GetResult()))
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.Maze then
        local team = self._teams:Get(self.ctx.mazeTeamId):Clone()
        team:ClearPet()
        local mazeModule = self:GetModule(MazeModule)
        self:Lock("module:UpdateMainFormationInfo")
        local res, data = mazeModule:UpdateMazeFormationInfo(TT, team.id, team.name, team.pets)
        self:UnLock("module:UpdateMainFormationInfo")
        if res:GetSucc() then
          self.ctx:InitMazeTeam(data)
          self._teams = self.ctx:GetMazeTeam()
          self.ctx:GetMazeTeam():UpdateTeam(team)
          self:FlushTeam(self.ctx.mazeTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.Trail then
        local team = self._teams:Get(self.ctx.trailTeamId):Clone()
        team:ClearPet()
        self:Lock("module:UpdateMainFormationInfo")
        local talePetModule = GameGlobal.GetModule(TalePetModule)
        local res = talePetModule:UpdateMainFormationInfo(TT, team.id, team.name, team.pets)
        self:UnLock("module:UpdateMainFormationInfo")
        if res:GetSucc() then
          self.ctx.trailTeam:UpdateTeam(team)
          self:FlushTeam(self.ctx.trailTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
        local team = self._teams:Get(self.ctx.worldBossTeamId):Clone()
        team:ClearPet()
        self:Lock("module:UpdateWorldBossFormationInfo")
        local worldBossModule = GameGlobal.GetModule(WorldBossModule)
        local res = worldBossModule:ReqWorldBossChangeFormationInfo(TT, team.pets)
        self:UnLock("module:UpdateWorldBossFormationInfo")
        if res:GetSucc() then
          self.ctx.worldBossTeam:UpdateTeam(team)
          self:FlushTeam(self.ctx.worldBossTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.N21CC then
        local curTeamId = self.ctx:GetCurrTeamId()
        local team = self._teams:Get(curTeamId):Clone()
        team:ClearPet()
        self:Lock("module:UpdateMainFormationInfo")
        local result = UIActivityN4CCHelper.SaveTeamInfo(TT, team.id, team.name, team.pets)
        if result then
          self.ctx.n21CCTeam:UpdateTeam(team)
          self:FlushTeam(curTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
        self:UnLock("module:UpdateMainFormationInfo")
      elseif self.ctx.teamOpenerType == TeamOpenerType.Diff then
        local team = self._teams:Get(self.ctx.diffTeamId):Clone()
        team:ClearPet()
        self:Lock("module:UpdateDiffFormationInfo")
        local diffModule = GameGlobal.GetModule(DifficultyMissionModule)
        local param = self.ctx.param
        local nodeid = param[1]
        local stageid = param[2]
        if GameSingle then
          self:UnLock("module:UpdateDiffFormationInfo")
          self.ctx.diffTeam:UpdateTeam(team)
          self:FlushTeam(self.ctx.diffTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
          return
        end
        local res = diffModule:HandleChangeFormation(TT, nodeid, stageid, team.pets)
        self:UnLock("module:UpdateDiffFormationInfo")
        if res:GetSucc() then
          self.ctx.diffTeam:UpdateTeam(team)
          self:FlushTeam(self.ctx.diffTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.Sailing then
        local team = self._teams:Get(self.ctx.sailingTeamId):Clone()
        team:ClearPet()
        self:Lock("module:UpdateDiffFormationInfo")
        local sailingMissionModule = GameGlobal.GetModule(SailingMissionModule)
        local param = self.ctx.param
        local layerId = param[1]
        local missionId = param[2]
        local res = sailingMissionModule:HandleChangeFormation(TT, layerId, missionId, team.pets)
        self:UnLock("module:UpdateDiffFormationInfo")
        if res:GetSucc() then
          self.ctx.sailingTeam:UpdateTeam(team)
          self:FlushTeam(self.ctx.sailingTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.Vampire then
        local curTeamId = self.ctx:GetCurrTeamId()
        local team = self._teams:Get(curTeamId):Clone()
        team:ClearPet()
        self:Lock("module:UpdateMainFormationInfo")
        local result, hasExpire = UIN25VampireUtil.SaveTeamInfo(TT, team.pets)
        if result then
          self.ctx.vampireTeam:UpdateTeam(team)
          self:FlushTeam(curTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
        self:UnLock("module:UpdateMainFormationInfo")
      elseif self.ctx.teamOpenerType == TeamOpenerType.Air then
        local team = self._teams:Get(self.ctx.airTeamId):Clone()
        team:ClearPet()
        local airModule = self:GetModule(AircraftModule)
        self:Lock("module:UpdateMainFormationInfo")
        local res, data = airModule:RequestChangeTacticFormationInfo(TT, team.id, team.name, team.pets)
        self:UnLock("module:UpdateMainFormationInfo")
        if res:GetSucc() then
          self.ctx:InitAirTeam(data)
          self._teams = self.ctx:GetAirTeam()
          self._teams:UpdateTeam(team)
          self:FlushTeam(self.ctx.airTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
        local team = self._teams:Get(self.ctx.diffTeamId):Clone()
        team:ClearPet()
        self:Lock("module:UpdateCampDiffFormationInfo")
        local param = self.ctx.param
        local diffCpt = param[5]
        local nodeid = param[1]
        local stageid = param[2]
        local res = diffCpt:HandleDifficultyChangeFormation(TT, AsyncRequestRes:New(), nodeid, stageid, team.pets)
        self:UnLock("module:UpdateCampDiffFormationInfo")
        if res:GetSucc() then
          self.ctx.campDiffTeam:UpdateTeam(team)
          self:FlushTeam(self.ctx.campDiffTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新活动高难编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.Season then
        local team = self._teams:Get(self.ctx.seasonTeamId):Clone()
        team:ClearPet()
        local seasonModule = GameGlobal.GetModule(SeasonModule)
        self:Lock("module:UpdateMainFormationInfo")
        local res = seasonModule:ReqSeasonChangeFormationInfo(TT, team.id, team.name, team.pets)
        self:UnLock("module:UpdateMainFormationInfo")
        if res:GetSucc() then
          self.ctx.seasonTeam:UpdateTeam(team)
          self:FlushTeam(self.ctx.seasonTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
        local team = self._teams:Get(self.ctx.seasonTeamId):Clone()
        team:ClearPet()
        local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
        self:Lock("module:UpdateMainFormationInfo")
        local res = seasonMazeModule:ReqSeasonMazeChangeFormationInfo(TT, team.id, team.name, team.pets)
        self:UnLock("module:UpdateMainFormationInfo")
        if res:GetSucc() then
          self.ctx.seasonMazeTeam:UpdateTeam(team)
          self:FlushTeam(self.ctx.seasonMazeTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
        local team = self._teams:Get(self.ctx.popStarTeamId):Clone()
        team:ClearPet()
        self:Lock("module:UpdateMainFormationInfo")
        local param = self.ctx.param
        local linePopStarCpt = param[6]
        local res = AsyncRequestRes:New()
        local tb = {
          id = team.id,
          name = team.name,
          pet_list = team.pets
        }
        linePopStarCpt:HandleLinePopStarChangeFormation(TT, res, tb)
        self:UnLock("module:UpdateMainFormationInfo")
        if res:GetSucc() then
          self.ctx.popStarTeam.list[self.ctx.popStarTeamId] = team
          self:FlushTeam(self.ctx.popStarTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
        local team = self._teams:Get(self.ctx.aniPopStarTeamId):Clone()
        team:ClearPet()
        self:Lock("module:UpdateMainFormationInfo")
        local anipopModule = GameGlobal.GetModule(AnipopModule)
        local res = anipopModule:UpdateAnipopFormationInfo(TT, team.id, team.name, team.pets)
        self:UnLock("module:UpdateMainFormationInfo")
        if res:GetSucc() then
          self.ctx.aniPopStarTeam.list[self.ctx.aniPopStarTeamId] = team
          self:FlushTeam(self.ctx.aniPopStarTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonOnceMission then
        local team = self._teams:Get(self.ctx.seasonOnceTeamId):Clone()
        team:ClearPet()
        local cpt = self._param[4]
        local teamInfo = LineFormationItem:New()
        teamInfo.id = team.id
        teamInfo.name = team.name
        teamInfo.pet_list = team.pets
        local res = AsyncRequestRes:New()
        res:SetSucc(false)
        self:Lock("SeasonOnceMissionClearTeam")
        cpt:HandleLineChangeFormationReq(TT, res, teamInfo)
        self:UnLock("SeasonOnceMissionClearTeam")
        if res:GetSucc() then
          self.ctx.seasonOnceTeam:UpdateTeam(team)
          self:FlushTeam(self.ctx.seasonOnceTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 赛季一次性战斗关清空编队失败 ")
        end
      else
        local curTeamId = self.ctx:GetCurrTeamId()
        local team = self._teams:Get(curTeamId):Clone()
        team:ClearPet()
        if GameSingle then
          self.ctx.teams:UpdateTeam(team)
          self:FlushTeam(curTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
          return
        end
        self:Lock("module:UpdateMainFormationInfo")
        local res = self._module:UpdateMainFormationInfo(TT, team.id, team.name, team.pets)
        self:UnLock("module:UpdateMainFormationInfo")
        if res:GetSucc() then
          self.ctx.teams:UpdateTeam(team)
          self:FlushTeam(curTeamId)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
        else
          Log.fatal("### 更新编队失败 ")
        end
      end
    end, self)
  end)
end

function UITeams:BtnFastTeamOnClick(go)
  local teamCtx = self._module:TeamCtx()
  teamCtx:InitTeamFastSelect()
  self:ShowDialog("UITeamChangeController")
end

function UITeams:_MatchStart(TT, nMatchType, teamid, createInfo)
  self._nMatchType = nMatchType
  self._teamid = teamid
  self._createInfo = createInfo
  local isTape = false
  if self._teamOpenerType == TeamOpenerType.Campaign then
    if self._param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_SimulatorBlackfist or self._param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_CamSimulator then
      isTape = true
    end
  elseif self._teamOpenerType == TeamOpenerType.Air then
    isTape = true
  elseif self._teamOpenerType == TeamOpenerType.Vampire then
    self:Lock("UITeams_MatchStart")
    local curTeamId = self.ctx:GetCurrTeamId()
    local team = self._teams:Get(curTeamId):Clone()
    local result, hasExpire = UIN25VampireUtil.SaveTeamInfo(TT, team.pets)
    if hasExpire then
      ToastManager.ShowToast(StringTable.Get("str_n25_start_battle_error"))
      self.ctx.vampireTeam:UpdateTeam(team)
      self:FlushTeam(curTeamId)
      self:UnLock("UITeams_MatchStart")
      self:UnLock("DoEnterMatch")
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
      return
    end
    self:UnLock("UITeams_MatchStart")
  end
  if isTape then
    self:UnLock("DoEnterMatch")
    local pstid = self._param[3][ECampaignMissionParamKey.ECampaignMissionParamKey_CartridgePstId]
    self:ShowDialog("UIAircraftTacticSwitch", pstid, function()
      self:Lock("DoEnterMatch")
      self:_OnMatchStart()
    end)
  else
    self:_OnMatchStart()
  end
end

function UITeams:_OnMatchStart()
  self:StartTask(self.StartMatchTask, self, self._nMatchType, self._teamid, self._createInfo)
end

function UITeams:StartMatchTask(TT, nMatchType, teamid, createInfo)
  local game = GameGlobal.GetModule(GameMatchModule)
  local res = game:StartMatchTask(TT, nMatchType, teamid, createInfo)
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
    elseif result == MatchOpResCode.MATCH_CAMPAIGN_ComNotOpen and nMatchType == MatchType.MT_Season then
      local seasonRes = AsyncRequestRes:New()
      seasonRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE)
      self:GetModule(SeasonModule):CheckSeasonClose(seasonRes)
    elseif result == MatchOpResCode.MATCH_CAMPAIGN_CamNotOpen and nMatchType == MatchType.MT_Campaign then
      local campId, comId, comType = GameGlobal.GetModule(CampaignModule):ParseCampaignMissionParams(createInfo.CampaignMissionParams)
      local campConfig = Cfg.cfg_campaign[campId]
      local campType = campConfig and campConfig.CampaignType
      if campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON then
        local seasonRes = AsyncRequestRes:New()
        seasonRes:SetResult(CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE)
        self:GetModule(SeasonModule):CheckSeasonClose(seasonRes)
      else
        ToastManager.ShowToast(game:GetErrorMsg(result))
        self:SwitchState(UIStateType.UIMain)
      end
    elseif result == MatchOpResCode.MATCH_CAMPAIGN_ComNotOpen and nMatchType == MatchType.MT_Campaign then
      local result = CampaignErrorType.E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE
      UIActivityErrorHelper.CheckErrorCode(result, nil, nil, function()
        local params = createInfo.CampaignMissionParams
        local cmptCfgId = (params or {})[1]
        GameGlobal.EventDispatcher():Dispatch(GameEventType.ActivityComponentCloseEvent, cmptCfgId)
      end)
    elseif result == MatchOpResCode.MATCH_CAMPAIGN_PREMISSIONNOTPASS then
      ToastManager.ShowToast(StringTable.Get("str_function_lock_season_tips"))
    else
      ToastManager.ShowToast(game:GetErrorMsg(result))
    end
    return
  end
  local serial = GameGlobal.GetModule(SerialAutoFightModule)
  serial:StartSerialFight()
end

function UITeams:_ResInstanceMatchStart(TT)
  local resDungeonModule = self:GetModule(ResDungeonModule)
  local instanceId = resDungeonModule:GetEnterInstanceId()
  local game = GameGlobal.GetModule(GameMatchModule)
  local curTeamId = self.ctx:GetCurrTeamId()
  local res = resDungeonModule:StartMatchTask(TT, instanceId, curTeamId)
  self:UnLock("DoEnterMatch")
  if not res:GetSucc() then
    ToastManager.ShowToast(game:GetErrorMsg(res:GetResult()))
    return
  end
  local serial = GameGlobal.GetModule(SerialAutoFightModule)
  serial:StartSerialFight()
end

function UITeams:CheckTeamMemberDuplicate()
  local teamid = self.ctx:GetCurrTeamId()
  local team = self._teams:Get(teamid)
  if not team or not team.pets then
    return false
  end
  local petModule = self:GetModule(PetModule)
  local dic = {}
  local valueIndexDic = {}
  for index, pstId in pairs(team.pets) do
    if 0 < pstId then
      local petData = petModule:GetPet(pstId)
      if petData then
        local tmpId = petData:GetTemplateID()
        if dic[tmpId] == nil then
          dic[tmpId] = 0
        end
        dic[tmpId] = dic[tmpId] + 1
        valueIndexDic[tmpId] = index
      end
    end
  end
  local helpPetModule = GameGlobal.GetModule(HelpPetModule)
  local helpPet = helpPetModule:UI_GetSelectHelpPet()
  if helpPet then
    local helpPetTmpId = helpPet.m_nTemplateID
    local index = valueIndexDic[helpPetTmpId]
    if index and index ~= 5 then
      return false
    end
  end
  for k, v in pairs(dic) do
    if 1 < v then
      return false
    end
  end
  return true
end

function UITeams:CheckTeamValid()
  local teamid = self.ctx:GetCurrTeamId()
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

function UITeams:btnFightOnClick(go)
  if GameSingle then
    if self._teamOpenerType == TeamOpenerType.Diff then
      local ctx = self:GetModule(MissionModule):TeamCtx()
      local teams = ctx:Teams()
      local curTeamId = self.ctx:GetCurrTeamId()
      local team = teams:Get(curTeamId)
      local petsList = team.pets
      local md = GameGlobal.GetModule(SkillPerfModule)
      local game = GameGlobal.GetModule(GameMatchModule)
      local createInfo = game:GetMatchCreateInfo(MatchType.MT_DifficultyMission, self._param)
      local missionId = createInfo.sub_mission_id
      local mission = Cfg.cfg_Difficulty_sub_mission[missionId]
      local levelId
      if mission then
        levelId = mission.FightLevel
      end
      md:EnterCoreGameSingle(MatchType.MT_DifficultyMission, levelId, missionId, petsList, createInfo.parent_mission_id)
    else
      local ctx = self:GetModule(MissionModule):TeamCtx()
      local teams = ctx:Teams()
      local curTeamId = self.ctx:GetCurrTeamId()
      local team = teams:Get(curTeamId)
      local petsList = team.pets
      local md = GameGlobal.GetModule(SkillPerfModule)
      local missionId = self._param
      local mission = Cfg.cfg_mission[missionId]
      local levelId
      if mission then
        levelId = mission.FightLevel
      end
      md:EnterCoreGameSingle(MatchType.MT_Mission, levelId, missionId, petsList)
    end
    return
  end
  local l_curTime = os.time()
  if l_curTime - self._lastClickTime < 1 then
    Log.debug("btnFightOnClick repeat")
    return
  end
  self._lastClickTime = l_curTime
  local pc = GameGlobal:GetInstance():GetCollector("CoreGameLoading")
  pc:ResetCollector()
  pc:Sample("UITeams:btnFightOnClick()")
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIBattleStart)
  local bCheckTeamValid, team = self:CheckTeamValid()
  if false == bCheckTeamValid then
    ToastManager.ShowToast(StringTable.Get("str_discovery_no_leader_no_fight"))
    return
  end
  if self:CheckTeamMemberDuplicate() == false then
    ToastManager.ShowToast(StringTable.Get("str_tower_error_8"))
    return
  end
  local guide_team_limit = Cfg.cfg_guide_const.guide_team_limit.StrValue
  local enterBattleLimit = {}
  local limitTips = {}
  local a = string.split(guide_team_limit, "|")
  for _, value1 in ipairs(a) do
    local b = string.split(value1, ";")
    local missionId = tonumber(b[1])
    if not enterBattleLimit[missionId] then
      enterBattleLimit[missionId] = {}
    end
    local petIds = string.split(b[2], ",")
    for index, petId in ipairs(petIds) do
      table.insert(enterBattleLimit[missionId], tonumber(petId))
    end
    local tipId = b[3]
    if not limitTips[missionId] then
      limitTips[missionId] = tipId
    end
  end
  local limit = enterBattleLimit[self._param]
  if limit then
    local petModule = self:GetModule(PetModule)
    for i = 1, #team.pets do
      local petData = petModule:GetPet(team.pets[i])
      if petData then
        local key = table.ikey(limit, petData:GetTemplateID())
        if key then
          table.remove(limit, key)
        end
      end
    end
    if 0 < #limit then
      PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.Ok, "", StringTable.Get(limitTips[self._param]))
      return
    end
  end
  self:GetModule(PetModule):ClearAllPetSortInfo()
  if self._fightCallback then
    self._fightCallback()
  end
  self:Lock("DoEnterMatch")
  local game = GameGlobal.GetModule(GameMatchModule)
  local role = GameGlobal.GetModule(RoleModule)
  local curTeamId = self.ctx:GetCurrTeamId()
  if self._teamOpenerType == TeamOpenerType.Stage then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_Mission, self._param)
    self:StartTask(self._MatchStart, self, MatchType.MT_Mission, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.ExtMission then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_ExtMission, self._param)
    self:StartTask(self._MatchStart, self, MatchType.MT_ExtMission, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Maze then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_Maze, self._param)
    self:StartTask(self._MatchStart, self, MatchType.MT_Maze, self.ctx.mazeTeamId, createInfo)
    local teams = self.ctx:GetMazeTeam()
    local team = teams:Get(self.ctx.mazeTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnLeaveMaze)
  elseif self._teamOpenerType == TeamOpenerType.ResInstance then
    self:StartTask(self._ResInstanceMatchStart, self)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Tower then
    local teams = self.ctx:GetTowerTeam()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    local count = 0
    for _, id in ipairs(petsList) do
      if 0 < id then
        count = count + 1
      end
    end
    local towerTeamCeiling = self.ctx:GetTowerTeamCeiling()
    if count < towerTeamCeiling then
      local tips = {
        [ElementType.ElementType_Blue] = "str_tower_pet_count_error_water",
        [ElementType.ElementType_Red] = "str_tower_pet_count_error_fire",
        [ElementType.ElementType_Green] = "str_tower_pet_count_error_wood",
        [ElementType.ElementType_Yellow] = "str_tower_pet_count_error_thunder"
      }
      ToastManager.ShowToast(string.format(StringTable.Get(tips[self.ctx:GetTowerElement()]), towerTeamCeiling))
      self:UnLock("DoEnterMatch")
      return
    end
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_Tower, self.ctx:GetTowerLayerID())
    self:StartTask(self._MatchStart, self, MatchType.MT_Tower, curTeamId, createInfo)
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Trail then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_TalePet, self._param)
    self:StartTask(self._MatchStart, self, MatchType.MT_TalePet, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Campaign then
    local matchType = MatchType.MT_Campaign
    if self._param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_SimulatorBlackfist then
      matchType = MatchType.MT_BlackFist
    elseif self._param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_SimpleBattleField then
      matchType = MatchType.MT_SimpleBattleField
    end
    local createInfo = game:GetMatchCreateInfo(matchType, self._param)
    self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.LostLand then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_LostArea, self._param)
    self:StartTask(self._MatchStart, self, MatchType.MT_LostArea, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Conquest then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_Conquest, self._param)
    self:StartTask(self._MatchStart, self, MatchType.MT_Conquest, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.WorldBoss then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_WorldBoss, self._param)
    local worldBossModule = self:GetModule(WorldBossModule)
    self:StartTask(self._MatchStart, self, MatchType.MT_WorldBoss, worldBossModule:GetCurSelectTeamIndex(), createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.N21CC then
    local matchType = MatchType.MT_Campaign
    local createInfo = game:GetMatchCreateInfo(matchType, self._param)
    self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.BlackFist then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_BlackFist, self._param)
    self:StartTask(self._MatchStart, self, MatchType.MT_BlackFist, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Air then
    local airModule = GameGlobal.GetModule(AircraftModule)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    for i = 1, #petsList do
      local pstid = petsList[i]
      if pstid ~= 0 then
        local room = airModule:GetRoomByRoomType(AirRoomType.TacticRoom)
        local switchCount = room:GetPetRemainFightNum(pstid)
        if switchCount <= 0 then
          local tips = StringTable.Get("str_aircraft_tactic_battle_error_tips")
          ToastManager.ShowToast(tips)
          self:UnLock("DoEnterMatch")
          return
        end
      end
    end
    local matchType = MatchType.MT_Campaign
    if self._param[2] == ECampaignMissionComponentId.ECampaignMissionComponentId_AircraftBlackfist then
      matchType = MatchType.MT_BlackFist
    end
    local createInfo = game:GetMatchCreateInfo(matchType, self._param)
    self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Diff then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_DifficultyMission, self._param)
    local diffModule = self:GetModule(DifficultyMissionModule)
    self:StartTask(self._MatchStart, self, MatchType.MT_DifficultyMission, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Sailing then
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    if petsList == nil or #petsList < 5 then
      self:UnLock("DoEnterMatch")
      local tips = StringTable.Get("str_sailing_mission_team_count_not_enough")
      ToastManager.ShowToast(tips)
      return
    end
    for i = 1, #petsList do
      if petsList[i] <= 0 then
        self:UnLock("DoEnterMatch")
        local tips = StringTable.Get("str_sailing_mission_team_count_not_enough")
        ToastManager.ShowToast(tips)
        return
      end
    end
    local sailingMissionModule = GameGlobal.GetModule(SailingMissionModule)
    local layerId = self._param[1]
    local missionId = self._param[2]
    if sailingMissionModule:GetChallengeLayerID() == layerId then
      LocalDB.SetInt(UISailing:ChallengeMissionKey(), missionId)
    end
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_SailingMission, self._param)
    self:StartTask(self._MatchStart, self, MatchType.MT_SailingMission, curTeamId, createInfo)
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Vampire then
    local matchType = MatchType.MT_MiniMaze
    local createInfo = game:GetMatchCreateInfo(matchType, self._param)
    self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
  elseif self._teamOpenerType == TeamOpenerType.Camp_Diff then
    local createInfo = game:GetMatchCreateInfo(MatchType.MT_DifficultyMission, self._param)
    local diffModule = self:GetModule(DifficultyMissionModule)
    self:StartTask(self._MatchStart, self, MatchType.MT_DifficultyMission, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.Season then
    local matchType = MatchType.MT_Season
    local createInfo = game:GetMatchCreateInfo(matchType, self._param)
    self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
    local matchType = MatchType.MT_PopStarPro
    local createInfo = game:GetMatchCreateInfo(matchType, self._param)
    self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
    local matchType = MatchType.MT_PopStarPro
    local createInfo = game:GetMatchCreateInfo(matchType, self._param)
    self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  elseif self._teamOpenerType == TeamOpenerType.SeasonOnceMission then
    local matchType = MatchType.MT_Campaign
    local createInfo = game:GetMatchCreateInfo(matchType, self._param)
    self:StartTask(self._MatchStart, self, matchType, curTeamId, createInfo)
    local teams = self.ctx:Teams()
    local team = teams:Get(curTeamId)
    local petsList = team.pets
    role:UpdateMatchPetsList(petsList)
  else
    self:UnLock("DoEnterMatch")
  end
end

function UITeams:TeamItemLongPress(isBegin, slot, id)
  if isBegin then
    Log.debug("TeamItemLongPress begin drag")
    self._isLongPressing = true
    if not self._replaceCard then
      local sop = self:GetUIComponent("UISelectObjectPath", "card")
      sop:SpawnObjects("UIPetMemberItem", 1)
      self._replaceCard = sop:GetAllSpawnList()[1]
    end
    self._replaceCard:SetData(id)
  else
    self._isLongPressing = false
    local strUITeamsDrag = "UITeamsDrag"
    for i, v in ipairs(self._uiSlots) do
      local tran = v:GetRectTransform()
      local localPos = tran:InverseTransformPoint(self._replaceTran.position)
      if tran.rect:Contains(localPos) and not v:IsLocked() then
        if i == 5 then
          local hpm = self:GetModule(HelpPetModule)
          local key = hpm:UI_GetHelpPetKey()
          if 0 < key then
            self._replaceGo:SetActive(false)
            ToastManager.ShowToast(StringTable.Get("str_help_pet_weizhi"))
            return
          end
        end
        local teamid = self.ctx:GetCurrTeamId()
        local team = self._teams:Get(teamid):Clone()
        team:Swap(slot, i)
        self:StartTask(function(TT)
          self:Lock(strUITeamsDrag)
          if self.ctx.teamOpenerType == TeamOpenerType.Tower then
            local module = self:GetModule(TowerModule)
            local res, formation_data = self.ctx:ReqTowerChangeMulFormationInfo(TT, team)
            if res:GetSucc() then
              self.ctx:InitTowerTeam(formation_data)
              self._teams = self.ctx:GetTowerTeam()
              local element = self.ctx:GetTowerElement()
              local teams = self.ctx:RawGetTowerTeam(element)
              teams:UpdateTeam(team)
              self:FlushTeam(team.id)
            else
              ToastManager.ShowToast(module:GetErrorMsg(res:GetResult()))
            end
            self:UnLock(strUITeamsDrag)
          elseif self.ctx.teamOpenerType == TeamOpenerType.Maze then
            local mazeModule = self:GetModule(MazeModule)
            local res, data = mazeModule:UpdateMazeFormationInfo(self, team.id, team.name, team.pets)
            if res:GetSucc() then
              self.ctx:InitMazeTeam(data)
              self._teams = self.ctx:GetMazeTeam()
              self.ctx:GetMazeTeam():UpdateTeam(team)
              self:FlushTeam(team.id)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            else
              ToastManager.ShowToast(self._module:GetErrorMsg(res:GetResult()))
            end
            self:UnLock(strUITeamsDrag)
          elseif self.ctx.teamOpenerType == TeamOpenerType.Trail then
            local talePetModule = GameGlobal.GetModule(TalePetModule)
            local res = talePetModule:UpdateMainFormationInfo(TT, team.id, team.name, team.pets)
            if res:GetSucc() then
              self.ctx.trailTeam:UpdateTeam(team)
              self:FlushTeam(team.id)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            end
            self:UnLock(strUITeamsDrag)
          elseif self.ctx.teamOpenerType == TeamOpenerType.WorldBoss then
            local worldBossModule = GameGlobal.GetModule(WorldBossModule)
            local res = worldBossModule:ReqWorldBossChangeFormationInfo(TT, team.pets)
            if res:GetSucc() then
              self.ctx.worldBossTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.worldBossTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            end
            self:UnLock(strUITeamsDrag)
          elseif self.ctx.teamOpenerType == TeamOpenerType.N21CC then
            local result = UIActivityN4CCHelper.SaveTeamInfo(TT, team.id, team.name, team.pets)
            if result then
              self.ctx.n21CCTeam:UpdateTeam(team)
              self:FlushTeam(team.id)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
              self:UnLock(strUITeamsDrag)
            else
              self:UnLock(strUITeamsDrag)
            end
          elseif self.ctx.teamOpenerType == TeamOpenerType.Diff then
            local diffModule = GameGlobal.GetModule(DifficultyMissionModule)
            local param = self.ctx.param
            local nodeid = param[1]
            local stageid = param[2]
            if GameSingle then
              self:UnLock(strUITeamsDrag)
              self.ctx.diffTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.diffTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
              self._replaceGo:SetActive(self._isLongPressing)
              return
            end
            local res = diffModule:HandleChangeFormation(TT, nodeid, stageid, team.pets)
            self:UnLock(strUITeamsDrag)
            if res:GetSucc() then
              self.ctx.diffTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.diffTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            else
              Log.fatal("### 更新编队失败 ")
            end
          elseif self.ctx.teamOpenerType == TeamOpenerType.Sailing then
            local sailingMissionModule = GameGlobal.GetModule(SailingMissionModule)
            local param = self.ctx.param
            local layerId = param[1]
            local missionId = param[2]
            local res = sailingMissionModule:HandleChangeFormation(TT, layerId, missionId, team.pets)
            self:UnLock(strUITeamsDrag)
            if res:GetSucc() then
              self.ctx.sailingTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.sailingTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            else
              Log.fatal("### 更新编队失败 ")
            end
          elseif self.ctx.teamOpenerType == TeamOpenerType.Vampire then
            local result, hasExpire = UIN25VampireUtil.SaveTeamInfo(TT, team.pets)
            if result then
              self.ctx.vampireTeam:UpdateTeam(team)
              self:FlushTeam(team.id)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
              self:UnLock(strUITeamsDrag)
            else
              self:UnLock(strUITeamsDrag)
            end
          elseif self.ctx.teamOpenerType == TeamOpenerType.Air then
            local airModule = GameGlobal.GetModule(AircraftModule)
            local res, data = airModule:RequestChangeTacticFormationInfo(TT, team.id, team.name, team.pets)
            if res:GetSucc() then
              self.ctx:InitAirTeam(data)
              self.ctx.airTeam:UpdateTeam(team)
              self:FlushTeam(team.id)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
              self:UnLock(strUITeamsDrag)
            end
            self:UnLock(strUITeamsDrag)
          elseif self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
            local param = self.ctx.param
            local diffCpt = param[5]
            local nodeid = param[1]
            local stageid = param[2]
            local res = diffCpt:HandleDifficultyChangeFormation(TT, AsyncRequestRes:New(), nodeid, stageid, team.pets)
            self:UnLock(strUITeamsDrag)
            if res:GetSucc() then
              self.ctx.campDiffTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.campDiffTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            else
              Log.fatal("### 更新活动高难编队失败 ")
            end
          elseif self.ctx.teamOpenerType == TeamOpenerType.Season then
            local seasonModule = GameGlobal.GetModule(SeasonModule)
            local res = seasonModule:ReqSeasonChangeFormationInfo(TT, team.id, team.name, team.pets)
            if res:GetSucc() then
              self.ctx.seasonTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.seasonTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            else
              Log.fatal("### 更新编队失败 ")
            end
            self:UnLock(strUITeamsDrag)
          elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonMaze then
            local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
            local res = seasonMazeModule:ReqSeasonMazeChangeFormationInfo(TT, team.id, team.name, team.pets)
            if res:GetSucc() then
              self.ctx.seasonMazeTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.seasonMazeTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            else
              Log.fatal("### 更新编队失败 ")
            end
          elseif self.ctx.teamOpenerType == TeamOpenerType.PopStarPro then
            local param = self.ctx.param
            local linePopStarCpt = param[6]
            local res = AsyncRequestRes:New()
            local tb = {
              id = team.id,
              name = team.name,
              pet_list = team.pets
            }
            linePopStarCpt:HandleLinePopStarChangeFormation(TT, res, tb)
            if res:GetSucc() then
              self.ctx.popStarTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.popStarTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            end
            self:UnLock(strUITeamsDrag)
          elseif self.ctx.teamOpenerType == TeamOpenerType.AniPopStar then
            local anipopModule = GameGlobal.GetModule(AnipopModule)
            local res, info = anipopModule:UpdateAnipopFormationInfo(TT, team.id, team.name, team.pets)
            if res:GetSucc() then
              self.ctx.aniPopStarTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.aniPopStarTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            end
            self:UnLock(strUITeamsDrag)
          elseif self.ctx.teamOpenerType == TeamOpenerType.SeasonOnceMission then
            local cpt = self._param[4]
            local teamInfo = LineFormationItem:New()
            teamInfo.id = team.id
            teamInfo.name = team.name
            teamInfo.pet_list = team.pets
            local res = AsyncRequestRes:New()
            res:SetSucc(false)
            cpt:HandleLineChangeFormationReq(TT, res, teamInfo)
            if res:GetSucc() then
              self.ctx.seasonOnceTeam:UpdateTeam(team)
              self:FlushTeam(self.ctx.seasonOnceTeamId)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
            else
              Log.fatal("### 赛季一次性战斗关拖拽更新编队失败 ")
            end
            self:UnLock(strUITeamsDrag)
          else
            if GameSingle then
              self.ctx.teams:UpdateTeam(team)
              self:FlushTeam(team.id)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
              self:UnLock(strUITeamsDrag)
              self._replaceGo:SetActive(self._isLongPressing)
              return
            end
            local res, data = self._module:UpdateMainFormationInfo(self, team.id, team.name, team.pets)
            if res:GetSucc() then
              self.ctx.teams:UpdateTeam(team)
              self:FlushTeam(team.id)
              GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamMemberChanged)
              self:UnLock(strUITeamsDrag)
            else
              self:UnLock(strUITeamsDrag)
            end
          end
        end, self)
        break
      end
    end
  end
  self._replaceGo:SetActive(self._isLongPressing)
end

function UITeams:UpdateReplaceCardPos(screenPos)
  if self._replaceTran then
    local camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._replaceTran.parent, screenPos, camera)
    self._replaceTran.position = pos
  end
end

function UITeams:GetTeamItem(index)
  if self._uiSlots[index] then
    return self._uiSlots[index]:GetGB()
  else
    return nil
  end
end

function UITeams:GetTeamItemHelpPetIcon(index)
  if self._uiSlots[index] then
    return self._uiSlots[index]:GetHelpPetIcon()
  else
    return nil
  end
end

function UITeams:OnCancelSerialAutoFight()
  self._blockMask:SetActive(false)
  if self._autoBtn then
    self._autoBtn:Hide()
  end
end

function UITeams:blockMaskOnClick()
  ToastManager.ShowToast(StringTable.Get("str_battle_cannot_use"))
end

function UITeams:_CheckTeamTips()
  local active = false
  local text
  if self.ctx.teamOpenerType == TeamOpenerType.Maze then
    active = true
    text = StringTable.Get("str_maze_teams_tips")
  elseif self.ctx.teamOpenerType == TeamOpenerType.Vampire then
    active = true
    text = StringTable.Get("str_n25_teams_tips")
  end
  self._mazeTeamTips:SetActive(active)
  self._mazeTeamTipsText:SetText(text)
  self:_CheckSeasonTeamTips()
end

function UITeams:_CheckSeasonTeamTips()
  local active = false
  local text
  if self.ctx.teamOpenerType == TeamOpenerType.Season then
    local missionId = self._param[1]
    if missionId then
      local missionCfg = Cfg.cfg_season_mission[missionId]
      if missionCfg and missionCfg.Type ~= SeasonEventPointType.DailyLevel then
        active = true
        text = StringTable.Get("str_season_pet_enhance_title", missionCfg.PetGrade, missionCfg.PetLv, missionCfg.PetAwakening, missionCfg.PetEquip)
      end
    end
  end
  if self._seasonTeamTips then
    self._seasonTeamTips:SetActive(active)
    if active then
      self._seasonTeamTipsText:SetText(text)
    end
  end
end

function UITeams:_CheckCampaignTeamTips()
  local active = false
  local text
  if self.ctx.teamOpenerType == TeamOpenerType.Campaign or self.ctx.teamOpenerType == TeamOpenerType.Camp_Diff then
    local missionId = self._param[1]
    if missionId then
      local missionCfg = Cfg.cfg_campaign_mission[missionId]
      if missionCfg and missionCfg.PetLv ~= nil then
        active = true
        text = StringTable.Get("str_season_pet_enhance_title", missionCfg.PetGrade, missionCfg.PetLv, missionCfg.PetEquip, missionCfg.PetEquip)
      end
    end
  end
  if self._campaignTips then
    self._campaignTips:SetActive(active)
    if active then
      self._campaignTipsText:SetText(text)
    end
  end
end

function UITeams:IsSeasonTalentTree(enterData)
  local createInfo = enterData:GetMissionCreateInfo()
  if createInfo then
    local campId, comId, comType = GameGlobal.GetModule(CampaignModule):ParseCampaignMissionParams(createInfo.CampaignMissionParams)
    local campConfig = Cfg.cfg_campaign[campId]
    local campType = campConfig and campConfig.CampaignType
    if campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON and comId == ECCampaignSeasonComponentID.LINE_MISSION then
      return true
    end
  end
  return false
end

function UITeams:IsSeaonOnceMissionBlackFist(enterData)
  local createInfo = enterData:GetMissionCreateInfo()
  if createInfo then
    local campId, comId, comType = GameGlobal.GetModule(CampaignModule):ParseCampaignMissionParams(createInfo.CampaignMissionParams)
    local campConfig = Cfg.cfg_campaign[campId]
    local campType = campConfig and campConfig.CampaignType
    if campType == ECampaignType.CAMPAIGN_TYPE_INLAND_SEASON and comId == ECCampaignSeasonComponentID.LINE_MISSION_BLACKFIST then
      return true
    end
  end
  return false
end

function UITeams:ExitBattle2SeasonT(enterData)
  GameGlobal.GetUIModule(SeasonModule):SetTalentTreeBattleOut(true)
  GameGlobal:GetInstance():ExitCoreGame()
  local CampaignMissionCreateInfo = enterData:GetCampaignMissionInfo()
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  seasonModule:ExitBattle(CampaignMissionCreateInfo, false, nil)
end

function UITeams:ExitBattle2OnceMissionBlackFist(enterData)
  UISeasonHelper.TrySeasonBattleExit(enterData._match_type, false)
end
