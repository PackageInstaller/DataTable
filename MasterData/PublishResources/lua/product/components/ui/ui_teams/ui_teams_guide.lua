_class("UITeamsGuide", UIController)
UITeamsGuide = UITeamsGuide

function UITeamsGuide:OnShow(uiParams)
  self:UnLock("DoEnterTeam")
  self._module = self:GetModule(MissionModule)
  self.ctx = self._module:TeamCtx()
  self._teamOpenerType = self.ctx.teamOpenerType
  self._param = self.ctx.param
  local btns = self:GetUIComponent("UISelectObjectPath", "btns")
  self._backBtns = btns:SpawnObject("UINewCommonTopButton")
  local mdSerialFight = self:GetModule(SerialAutoFightModule)
  self._backBtns:SetData(function()
    mdSerialFight:ResetModuleData()
    local isFightAgain = self.ctx:GetFightAgain()
    if self._teamOpenerType == TeamOpenerType.Stage then
      if isFightAgain then
        DiscoveryData.EnterStateUIDiscovery(3, self.ctx.param)
      else
        self:CloseDialog()
      end
    elseif self._teamOpenerType == TeamOpenerType.ExtMission then
      if isFightAgain then
        self:SwitchState(UIStateType.UIExtraMissionStage, self.ctx.param[1], self.ctx.param[2])
      else
        self:CloseDialog()
      end
    elseif self._teamOpenerType == TeamOpenerType.Trail then
      self:CloseDialog()
    elseif self._teamOpenerType == TeamOpenerType.Sailing then
      self:CloseDialog()
    elseif self._teamOpenerType == TeamOpenerType.Vampire then
      self:CloseDialog()
    elseif self._teamOpenerType == TeamOpenerType.Diff then
      self:CloseDialog()
    elseif self._teamOpenerType == TeamOpenerType.Campaign then
      if isFightAgain and self.ctx.param[3] then
        local componentId = self.ctx.param[3][1]
        if componentId then
          local sample = GameGlobal.GetModule(CampaignModule):GetSampleByID(componentId)
          if sample and sample.camp_type == ECampaignType.CAMPAIGN_TYPE_INLAND_N7 then
            self:SwitchState(UIStateType.UICN7N36Line)
          end
          self:SwitchState(UIStateType.UIMain)
        else
        end
      else
        self:CloseDialog()
      end
    elseif self._teamOpenerType == TeamOpenerType.Camp_Diff then
      self:CloseDialog()
    elseif self._teamOpenerType == TeamOpenerType.Season then
      self:CloseDialog()
    else
      self:SwitchState(UIStateType.UIMain)
    end
  end, nil)
  self.hlg = self:GetUIComponent("UISelectObjectPath", "hlg")
  self.hlg:SpawnObjects("UITeamItem", 5)
  self._uiSlots = self.hlg:GetAllSpawnList()
  local goFight = self:GetGameObject("btnFight")
  goFight:SetActive(self._teamOpenerType ~= TeamOpenerType.Main and self._teamOpenerType ~= TeamOpenerType.SmallMap)
  local leader = self:GetUIComponent("UISelectObjectPath", "leader")
  self._uiTeamsLeader = leader:SpawnObject("UITeamsLeader")
  local uiCanvas = self:GetUIComponent("Canvas", "UICanvas")
  self._camera = uiCanvas.worldCamera
  self._btnTxt = self:GetUIComponent("UILocalizationText", "Text")
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
  self:FlushTeam()
  self._autoBtnPool = self:GetUIComponent("UISelectObjectPath", "pool")
  self._blockMask = self:GetGameObject("blockMask")
  local mdSerialFight = GameGlobal.GetModule(SerialAutoFightModule)
  if mdSerialFight:IsRunning() then
    self._autoBtn = self._autoBtnPool:SpawnObject("UIWidgetSerialButton")
  end
  if mdSerialFight:IsRunning() and mdSerialFight:GetFightCount() > 0 then
    self._blockMask:SetActive(true)
    self:btnFightOnClick()
  end
  self:AttachEvent(GameEventType.CancelSerialAutoFight, self.OnCancelSerialAutoFight)
end

function UITeamsGuide:OnHide()
  self._backBtns = nil
  local isFightAgain = self.ctx:GetFightAgain()
  if isFightAgain then
    self.ctx:SetFightAgain(false)
  end
end

function UITeamsGuide:GetCfgMissionGuide()
  local stageId = 0
  if self._teamOpenerType == TeamOpenerType.Stage then
    stageId = self._param
  elseif self._teamOpenerType == TeamOpenerType.ExtMission then
    stageId = self._param[2]
  elseif self._teamOpenerType == TeamOpenerType.Trail then
    stageId = self._param
  elseif self._teamOpenerType == TeamOpenerType.Sailing then
    stageId = self._param[2]
  elseif self._teamOpenerType == TeamOpenerType.Vampire then
    stageId = self._param[1]
  elseif self._teamOpenerType == TeamOpenerType.Campaign then
    stageId = self._param[1]
  elseif self._teamOpenerType == TeamOpenerType.Season then
    stageId = self._param[1]
  end
  local cfg = Cfg.cfg_mission_guide()[stageId]
  if not cfg then
    Log.fatal("### TeamsContext Init no cfg in cfg_mission_guide.stageId=", stageId)
  end
  return cfg
end

function UITeamsGuide:FlushTeam()
  local pets = {}
  local cfg = self:GetCfgMissionGuide()
  if not cfg then
    return
  end
  for i, v in ipairs(cfg.BattlePetList) do
    local petIndo = pet_data:New()
    petIndo.template_id = v[1]
    petIndo.level = v[2]
    petIndo.grade = v[3]
    petIndo.awakening = v[4]
    petIndo.equip_lv = v[5]
    petIndo.equip_refine_lv = v[6] or 0
    petIndo.affinity_level = 1
    petIndo.current_skin = 0
    local pet = Pet:New(petIndo)
    table.insert(pets, pet)
  end
  for i, v in ipairs(self._uiSlots) do
    v:PlayAnimIn((i - 1) * 70)
    v:FlushGuide(pets[i], true)
    v:FlushCallback(nil)
  end
  self._uiTeamsLeader:Flush(pets[1], true)
end

function UITeamsGuide:_MatchStart(TT, nMatchType, teamid, createInfo)
  local game = GameGlobal.GetModule(GameMatchModule)
  local res = game:StartMatchTask(TT, nMatchType, teamid, createInfo)
  self:UnLock("DoEnterMatch")
  if not res:GetSucc() then
    ToastManager.ShowToast(game:GetErrorMsg(res:GetResult()))
  end
end

function UITeamsGuide:btnFightOnClick(go)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundUIBattleStart)
  self:Lock("DoEnterMatch")
  local game = GameGlobal.GetModule(GameMatchModule)
  local matchType = MatchType.MT_NONE
  if self._teamOpenerType == TeamOpenerType.Stage then
    matchType = MatchType.MT_Mission
  elseif self._teamOpenerType == TeamOpenerType.ExtMission then
    matchType = MatchType.MT_ExtMission
  elseif self._teamOpenerType == TeamOpenerType.Trail then
    matchType = MatchType.MT_TalePet
  elseif self._teamOpenerType == TeamOpenerType.Sailing then
    matchType = MatchType.MT_SailingMission
  elseif self._teamOpenerType == TeamOpenerType.Vampire then
    matchType = MatchType.MT_MiniMaze
  elseif self._teamOpenerType == TeamOpenerType.Campaign then
    matchType = MatchType.MT_Campaign
  elseif self._teamOpenerType == TeamOpenerType.Season then
    matchType = MatchType.MT_Season
  else
    Log.fatal("### UITeamsGuide extend by yourself. self._teamOpenerType = ", self._teamOpenerType)
    return
  end
  local teamId = 1
  local createInfo = game:GetMatchCreateInfo(matchType, self._param)
  self:StartTask(function(TT)
    local res = game:StartMatchTask(TT, matchType, teamId, createInfo)
    if not res:GetSucc() then
      ToastManager.ShowToast(game:GetErrorMsg(res:GetResult()))
      self:UnLock("DoEnterMatch")
    else
      self:UnLock("DoEnterMatch")
    end
    local serial = GameGlobal.GetModule(SerialAutoFightModule)
    serial:StartSerialFight()
  end, self)
end

function UITeamsGuide:blockMaskOnClick()
  ToastManager.ShowToast(StringTable.Get("str_battle_cannot_use"))
end

function UITeamsGuide:OnCancelSerialAutoFight()
  self._blockMask:SetActive(false)
  if self._autoBtn then
    self._autoBtn:Hide()
  end
end
