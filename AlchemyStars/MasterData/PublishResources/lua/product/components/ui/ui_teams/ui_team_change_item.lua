_class("UITeamChangeItem", UICustomWidget)
UITeamChangeItem = UITeamChangeItem

function UITeamChangeItem:Constructor()
  self._petModule = GameGlobal.GetModule(PetModule)
  self._worldBossModule = GameGlobal.GetModule(WorldBossModule)
end

function UITeamChangeItem:SetData(tabItem, callback, longPressCallback, scrollRect, firstIn, teamType, slot)
  self:_GetComponents()
  self._tabItem = tabItem
  self._pstid = tabItem.pstid
  self._del = tabItem.del
  self._helpPetState = tabItem.helppet
  self._isHelp = tabItem.help
  self._firstIn = firstIn
  self._callback = callback
  self._longPressCallback = longPressCallback
  self._scrollRect = scrollRect
  self._teamType = teamType
  self._slot = slot
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  self._isFastSelect = ctx:IsFastSelect()
  self:_CheckDisable()
  self:_OnValue()
  self:_OnFastTeam()
end

function UITeamChangeItem:_CheckDisable()
  if self._teamType == TeamOpenerType.WorldBoss then
    self._disable = self._worldBossModule:CheckPetInRecordTeam(self._pstid)
  elseif self._teamType == TeamOpenerType.EightPets then
    local reason, limit = UIN33EightPetsTeamsContext:TeamConditionTestPet(self._pstid, self._slot)
    self._disable = reason ~= 0
    self._disableDetail = {reason, limit}
  end
end

function UITeamChangeItem:_GetComponents()
  self._info = self:GetUIComponent("UISelectObjectPath", "info")
  self._infoGo = self:GetGameObject("info")
  self._delete = self:GetGameObject("noinfo")
  self._helpPetGO = self:GetGameObject("helppet")
  self._yxzzGO = self:GetGameObject("zzrk")
  self._wfzzGO = self:GetGameObject("wfzz")
  self._eightFightDisableGO = self:GetGameObject("eightFightDisable")
  self._eightFightDisableTxt = self:GetUIComponent("UILocalizationText", "eightFightDisableTxt")
  self._bgBtn = self:GetGameObject("btn")
  self._bg = self:GetGameObject("bg")
  self._lostLand = self:GetGameObject("lostLand")
  self._recommend = self:GetGameObject("recommend")
  self._noinfoText = self:GetUIComponent("UILocalizationText", "noinfotext")
  self._binderPet = self:GetGameObject("binderPet")
  self._binderPetTex = self:GetUIComponent("RollingText", "binderPetTex")
  self._diffGo = self:GetGameObject("diffGo")
  self._fastTeam = self:GetUIComponent("UIView", "fastTeam")
  self._ftTeamMember = self._fastTeam:GetUIComponent("RectTransform", "teamMember")
  self._ftRepeatPet = self._fastTeam:GetUIComponent("RectTransform", "repeatPet")
  self._ftImgID = self._fastTeam:GetUIComponent("RectTransform", "imgID")
  self._ftImgHelp = self._fastTeam:GetUIComponent("RectTransform", "imgHelp")
  self._ftMemberID = self._fastTeam:GetUIComponent("UILocalizationText", "memberID")
  self._ftRepeatPrompt = self._fastTeam:GetUIComponent("UILocalizationText", "repeatPrompt")
end

function UITeamChangeItem:CheckHelpPetState()
  if self._helpPetState then
    self._helpPetGO:SetActive(true)
    if self._helpPetState == 1 then
      self._yxzzGO:SetActive(true)
      self._wfzzGO:SetActive(false)
    elseif self._helpPetState == 0 then
      self._yxzzGO:SetActive(false)
      self._wfzzGO:SetActive(true)
    end
  else
    self._helpPetGO:SetActive(false)
  end
end

function UITeamChangeItem:_OnValue()
  local etlAdd = UILongPressTriggerListener.Get(self._bgBtn)
  local etlAddDrag = UICustomUIEventListener.Get(self._bgBtn)
  self:AddUICustomEventListener(etlAddDrag, UIEvent.Press, function(go)
    self._bg:SetActive(true)
  end)
  self:AddUICustomEventListener(etlAddDrag, UIEvent.Release, function(go)
    self._bg:SetActive(false)
  end)
  local pet = self._petModule:GetPet(self._pstid)
  if self._teamType == TeamOpenerType.Vampire and pet == nil then
    pet = UIN25VampireUtil.CreatePetData(self._pstid)
  end
  local oriPet = pet
  local pet, isEnhanced = UIPetModule.ProcessSinglePetEnhance(oriPet)
  self:RefreshEnhanceFlagArea(isEnhanced)
  self.pet = pet
  self:_CheckNoInfoActive()
  self:CheckHelpPetState()
  if not self._helpPetState then
    self._infoGo:SetActive(true)
    local hpm = self:GetModule(HelpPetModule)
    if hpm:UI_GetHelpPetKey() > 0 and self._isHelp then
      pet = hpm:UI_GetSelectConstructHelpPet()
    end
    local heart = self._info:SpawnObject("UIHeartItem")
    self.heartItem = heart
    self:SetDiffGo()
    heart:SetData(pet, nil, false, self._firstIn, self._teamType, PetSkinEffectPath.CARD_TEAM_SELECT, self._isHelp, self._spShow, self._isFastSelect)
  else
    self._infoGo:SetActive(false)
    self._diffGo:SetActive(false)
    self._isDiffFilter = false
  end
  self:AddUICustomEventListener(etlAddDrag, UIEvent.BeginDrag, function(eventData)
    self._draging = true
    self._scrollRect:OnBeginDrag(eventData)
  end)
  self:AddUICustomEventListener(etlAddDrag, UIEvent.Drag, function(eventData)
    self._scrollRect:OnDrag(eventData)
  end)
  self:AddUICustomEventListener(etlAddDrag, UIEvent.EndDrag, function(eventData)
    self._draging = false
    self._scrollRect:OnEndDrag(eventData)
  end)
  self:AddUICustomEventListener(etlAdd, UIEvent.LongPress, function(go)
    if not self._draging and self._longPressCallback and not GuideHelper.IsUIGuideShow() then
      if self._bg.activeSelf then
        Log.debug("###[UITeamChangeItem] self._bg.activeSelf")
        self._bg:SetActive(false)
      end
      local pstid
      if self._helpPetState or self._del then
        pstid = 0
      else
        pstid = self._pstid
      end
      self._longPressCallback(pstid)
    end
  end)
  self:GetLostLand()
end

function UITeamChangeItem:SetDiffGo()
  local show = false
  if self._teamType == TeamOpenerType.Diff then
    local module = GameGlobal.GetUIModule(DifficultyMissionModule)
    local filterPets = module:GetFilterPets()
    local pstid = self.pet:GetPstID()
    if filterPets[pstid] then
      show = true
    end
  elseif self._teamType == TeamOpenerType.Sailing then
    local sailingMissionModule = GameGlobal.GetModule(SailingMissionModule)
    local filterPets = sailingMissionModule:GetFilterPets()
    local pstid = self.pet:GetPstID()
    if filterPets[pstid] then
      show = true
    end
  elseif self._teamType == TeamOpenerType.Vampire then
    show = false
  elseif self._teamType == TeamOpenerType.Camp_Diff then
    local module = GameGlobal.GetUIModule(DifficultyMissionModule)
    local filterPets = module:GetFilterPets()
    local pstid = self.pet:GetPstID()
    if filterPets[pstid] then
      show = true
    end
  end
  self._diffGo:SetActive(show)
  self._isDiffFilter = show
end

function UITeamChangeItem:RefreshBinderPet()
  self._spShow = false
  self._spPstid = 0
  local showTex
  if self.pet then
    local thisPetID = self.pet:GetTemplateID()
    local teamPets
    if self._isFastSelect then
      local pstidTab = self:RootUIOwner():GetPstidTab()
      teamPets = {}
      for k, v in pairs(pstidTab) do
        if v.memId ~= nil then
          table.insert(teamPets, v.pstid)
        end
      end
    elseif self:RootUIOwner().helpPetBranch then
    else
      local l_module = self:GetModule(MissionModule)
      local ctx = l_module:TeamCtx()
      local l_teams = ctx:Teams()
      local l_teamid = ctx:GetCurrTeamId()
      local l_team = l_teams:Get(l_teamid)
      teamPets = l_team.pets
    end
    if teamPets and 0 < table.count(teamPets) then
      for key, pstid in pairs(teamPets) do
        local isBinderPet = false
        local _pet = self._petModule:GetPet(pstid)
        if _pet then
          isBinderPet = _pet:IsBinderPet(thisPetID)
        end
        if isBinderPet then
          local petName = _pet:GetPetName()
          local tex = StringTable.Get("str_team_change_binder_item_tex", StringTable.Get(petName))
          self._binderPetTex:RefreshText(tex)
          self._spShow = true
          self._spPstid = pstid
          break
        end
      end
    end
  end
  self._binderPet:SetActive(self._spShow)
end

function UITeamChangeItem:_CheckNoInfoActive()
  local active = false
  local text
  local eightPetLimit = false
  if self._teamType == TeamOpenerType.WorldBoss then
    active = self._del or self._disable
    if self._disable then
      text = StringTable.Get("str_world_boss_team_pet_disable")
    elseif self._del then
      text = StringTable.Get("str_team_change_no_choose")
    end
  elseif self._teamType == TeamOpenerType.EightPets then
    active = self._del
    if self._disable then
      eightPetLimit = true
    elseif self._del then
      text = StringTable.Get("str_team_change_no_choose")
    end
  else
    active = self._del
    text = StringTable.Get("str_team_change_no_choose")
  end
  if active then
    self._noinfoText:SetText(text)
  end
  self._delete:SetActive(active)
  self._eightFightDisableGO:SetActive(eightPetLimit)
  if eightPetLimit then
    self.eightPetLimit = self._disableDetail[2]
    local profTxtKey = UIPetModule.GetPetProfTxtKey(self.pet)
    self.eightPetProfTxt = StringTable.Get(profTxtKey)
    self._eightFightDisableTxt:SetText(StringTable.Get("str_discovery_ep_career_in_team", self.eightPetLimit, self.eightPetProfTxt))
  end
  if not active then
    self:RefreshBinderPet()
  else
    self._binderPet:SetActive(false)
  end
end

function UITeamChangeItem:GetLostLand()
  local fromLostLand = self._teamType and self._teamType == TeamOpenerType.LostLand
  self._lostLand:SetActive(fromLostLand)
  if fromLostLand then
    local uiLostLandModule = GameGlobal.GetUIModule(LostAreaModule)
    local recommend = uiLostLandModule:CheckPetRecommend(self._pstid)
    self._recommend:SetActive(recommend)
  end
end

function UITeamChangeItem:OnHide()
end

function UITeamChangeItem:bgOnClick()
  if self._isDiffFilter and not self._del then
    return
  end
  if self._teamType == TeamOpenerType.WorldBoss then
    if self._disable then
      ToastManager.ShowToast(StringTable.Get("str_world_boss_team_pet_tips"))
      return
    end
  elseif self._teamType == TeamOpenerType.EightPets and self._disable then
    ToastManager.ShowToast(StringTable.Get("str_discovery_ep_career_in_team", self.eightPetLimit, self.eightPetProfTxt))
    return
  end
  if self._callback then
    self._callback(self._pstid, self._del, self._helpPetState, self._slot)
  end
end

function UITeamChangeItem:GetHelpPetState()
  return self._helpPetState
end

function UITeamChangeItem:LostLandMissionInfo()
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  local missionid = ctx.param
  self:ShowDialog("UILostLandMissionInfoController", missionid)
end

function UITeamChangeItem:recommendBtnOnClick(go)
  self:LostLandMissionInfo()
end

function UITeamChangeItem:RefreshEnhanceFlagArea(isEnhanced)
  local flagGo = self:GetGameObject("EnhanceFlagArea")
  local flagSop = self:GetUIComponent("UISelectObjectPath", "EnhanceFlagArea")
  if not flagGo then
    return
  end
  if self._helpPetState then
    flagGo:SetActive(false)
  else
    flagGo:SetActive(isEnhanced)
  end
  flagGo:SetActive(isEnhanced)
  if isEnhanced then
    local flagWidget = flagSop:SpawnObject("UIPetEnhancedFlag")
  else
  end
end

function UITeamChangeItem:_OnFastTeam()
  self._repeatHelpPetVisible = false
  if not self._isFastSelect then
    self._fastTeam.gameObject:SetActive(false)
    return
  else
    self._fastTeam.gameObject:SetActive(true)
  end
  local teamMemberVisible = false
  local repeatPetVisible = false
  local memberImgIDVisible = false
  local memberImgHelpVisible = false
  if self._tabItem.memId ~= nil then
    teamMemberVisible = true
    memberImgIDVisible = true
    memberImgHelpVisible = false
    self._ftMemberID:SetText(self._tabItem.memId)
  end
  if self._spShow then
    repeatPetVisible = true
    self._binderPet:SetActive(false)
    local petName = ""
    local l_pet = self._petModule:GetPet(self._spPstid)
    if l_pet then
      petName = l_pet:GetPetName()
    end
    local prompt = StringTable.Get("str_discovery_sppet_prompt", StringTable.Get(petName))
    self._ftRepeatPrompt:SetText(prompt)
  end
  local hpm = self:GetModule(HelpPetModule)
  local helpPetKey = hpm:UI_GetHelpPetKey()
  if 0 < helpPetKey then
    local petHelper = hpm:UI_GetTeamMaxPet()
    if self.pet ~= nil and petHelper ~= nil and self.pet:GetTemplateID() == petHelper.m_nTemplateID then
      repeatPetVisible = true
      self._repeatHelpPetVisible = true
      local prompt = StringTable.Get("str_discovery_hppet_prompt")
      self._ftRepeatPrompt:SetText(prompt)
    end
    if self._tabItem.memId == 5 then
      memberImgIDVisible = false
      memberImgHelpVisible = true
    end
  end
  self._ftTeamMember.gameObject:SetActive(teamMemberVisible)
  self._ftRepeatPet.gameObject:SetActive(repeatPetVisible)
  self._ftImgID.gameObject:SetActive(memberImgIDVisible)
  self._ftImgHelp.gameObject:SetActive(memberImgHelpVisible)
end

function UITeamChangeItem:GetTabItem()
  return self._tabItem
end

function UITeamChangeItem:IsBinderPet()
  return self._spShow
end

function UITeamChangeItem:IsRepeatHelpPet()
  return self._repeatHelpPetVisible
end

function UITeamChangeItem:FastTeamChanged()
  self:_CheckDisable()
  self:_CheckNoInfoActive()
  self:_OnFastTeam()
end
