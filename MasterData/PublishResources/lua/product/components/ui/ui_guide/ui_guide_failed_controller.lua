_class("UIGuideFailedController", UIController)
UIGuideFailedController = UIGuideFailedController

function UIGuideFailedController:OnShow(UIParams)
  self.canClick = false
  self.missionId = UIParams[1]
  local matchType = UIParams[2]
  self.continueGO = self:GetGameObject("continue")
  self.continueGO:SetActive(false)
  self.conditionTxt = self:GetUIComponent("UILocalizationText", "condition1")
  self.conditionGO = self:GetGameObject("condition1")
  self.condition2GO = self:GetGameObject("condition2")
  self.titleTxt1 = self:GetUIComponent("UILocalizationText", "title1")
  self.titleTxt2 = self:GetUIComponent("UILocalizationText", "title2")
  self.descTxt1 = self:GetUIComponent("UILocalizationText", "desc1")
  self.descTxt2 = self:GetUIComponent("UILocalizationText", "desc2")
  if matchType == MatchType.MT_Chess then
    self.titleTxt1:SetText(StringTable.Get("str_guide_fail_9"))
    self.descTxt1:SetText(StringTable.Get("str_guide_fail_10"))
    self.titleTxt2:SetText(StringTable.Get("str_guide_fail_11"))
    self.descTxt2:SetText(StringTable.Get("str_guide_fail_12"))
    self.condition2GO:SetActive(false)
  elseif matchType == MatchType.MT_PopStar then
    self:GetGameObject("Line1"):SetActive(false)
    self:GetGameObject("Line2"):SetActive(false)
    self:GetGameObject("LinePopStar"):SetActive(true)
  end
  self._autoBtnPool = self:GetUIComponent("UISelectObjectPath", "pool")
  local md = GameGlobal.GetModule(SerialAutoFightModule)
  if md:IsRunning() then
    self._autoBtn = self._autoBtnPool:SpawnObject("UIWidgetSerialButton")
    self:AttachEvent(GameEventType.CancelSerialAutoFight, self.OnCancelSerialAutoFight)
    self:StartTask(function(TT)
      YIELD(TT, 2000)
      self:bgOnClick()
    end)
  end
  self:Refresh()
end

function UIGuideFailedController:Refresh()
  local cfg = self.missionId and Cfg.cfg_waypoint[self.missionId]
  if cfg then
    local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
    local localPlayerInfo = matchEnterData:GetLocalPlayerInfo()
    local matchPets = InnerGameHelperRender.GetLocalMatchPets()
    local name = ""
    local show = false
    local recommendLevel = cfg and cfg.RecommendLV or 0
    local needGradeLevel = cfg.RecommendAwaken
    for i = 1, #localPlayerInfo.pet_list do
      local petID = localPlayerInfo.pet_list[i].pet_pstid
      local pet = matchPets[petID]
      local petLevel = pet:GetPetLevel()
      local petGradeLevel = pet:GetPetGrade()
      local minLevel = Cfg.cfg_guide_const.guide_team_min.IntValue
      if needGradeLevel > petGradeLevel then
        show = true
        name = name .. StringTable.Get(pet:GetPetName()) .. "、"
      else
        if petGradeLevel == needGradeLevel and recommendLevel > petLevel + minLevel then
          show = true
          name = name .. StringTable.Get(pet:GetPetName()) .. "、"
        else
        end
      end
    end
    if show then
      self.conditionGO:SetActive(true)
      name = string.sub(name, 1, string.len(name) - 3)
      self.conditionTxt:SetText(StringTable.Get("str_guide_fail_3") .. name)
    else
      self.conditionGO:SetActive(false)
    end
  else
    self.conditionGO:SetActive(false)
  end
  self.taskId = self:StartTask(function(TT)
    YIELD(TT, 2000)
    self.canClick = true
    self.continueGO:SetActive(true)
    if GameGlobal.GetModule(SerialAutoFightModule):IsRunning() then
      YIELD(TT, 1000)
      self:CloseDialog()
    end
  end)
end

function UIGuideFailedController:OnHide()
  TaskManager:GetInstance():KillTask(self.taskId)
  self.continueGO = nil
end

function UIGuideFailedController:bgOnClick()
  GameGlobal.GameRecorder():RecordAction(GameRecordAction.UIInput, {
    ui = "UIGuideFailedController",
    input = "bgOnClick",
    args = {}
  })
  if self.canClick then
    self:CloseDialog()
  end
end

function UIGuideFailedController:OnCancelSerialAutoFight()
  if self._autoBtn then
    self._autoBtn:Hide()
  end
end
