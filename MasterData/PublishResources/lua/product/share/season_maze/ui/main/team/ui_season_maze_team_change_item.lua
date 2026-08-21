_class("UISeasonMazeTeamChangeItem", UICustomWidget)
UISeasonMazeTeamChangeItem = UISeasonMazeTeamChangeItem

function UISeasonMazeTeamChangeItem:Constructor()
  self._uiSeasonMazeModule = GameGlobal.GetUIModule(SeasonMazeModule)
end

function UISeasonMazeTeamChangeItem:SetData(tabItem, callback, longPressCallback, scrollRect, firstIn, teamType, slot, getPet, uictrl, manualBanPetList, rotateBanPetList)
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
  self._getPet = getPet
  self._pet = self._getPet(self._pstid)
  self._uictrl = uictrl
  self._inTeam = false
  self._manualBanPetList = manualBanPetList
  self._rotateBanPetList = rotateBanPetList
  local module = self:GetModule(MissionModule)
  local ctx = module:TeamCtx()
  self._isFastSelect = ctx:IsFastSelect()
  self:_OnValue()
  self:_OnFastTeam()
  self:_ShowDispatchState()
end

function UISeasonMazeTeamChangeItem:_GetComponents()
  self._info = self:GetUIComponent("UISelectObjectPath", "info")
  self._infoGo = self:GetGameObject("info")
  self._delete = self:GetGameObject("noinfo")
  self._bgBtn = self:GetGameObject("btn")
  self._bg = self:GetGameObject("bg")
  self._noinfoText = self:GetUIComponent("UILocalizationText", "noinfotext")
  self._binderPet = self:GetGameObject("binderPet")
  self._binderPetTex = self:GetUIComponent("RollingText", "binderPetTex")
  self._fastTeam = self:GetUIComponent("UIView", "fastTeam")
  self._ftTeamMember = self._fastTeam:GetUIComponent("RectTransform", "teamMember")
  self._ftRepeatPet = self._fastTeam:GetUIComponent("RectTransform", "repeatPet")
  self._ftImgID = self._fastTeam:GetUIComponent("RectTransform", "imgID")
  self._ftImgHelp = self._fastTeam:GetUIComponent("RectTransform", "imgHelp")
  self._ftMemberID = self._fastTeam:GetUIComponent("UILocalizationText", "memberID")
  self._ftRepeatPrompt = self._fastTeam:GetUIComponent("UILocalizationText", "repeatPrompt")
  self.dispatch = self:GetGameObject("dispatch")
  self.dispatchText = self:GetUIComponent("UILocalizationText", "dispatchText")
  self._manualBanLayerGo = self:GetGameObject("ManualBanLayer")
  self._rotateBanLayerGo = self:GetGameObject("RotateBanLayer")
end

function UISeasonMazeTeamChangeItem:_OnValue()
  local etlAdd = UILongPressTriggerListener.Get(self._bgBtn)
  local etlAddDrag = UICustomUIEventListener.Get(self._bgBtn)
  self:AddUICustomEventListener(etlAddDrag, UIEvent.Press, function(go)
    self._bg:SetActive(true)
  end)
  self:AddUICustomEventListener(etlAddDrag, UIEvent.Release, function(go)
    self._bg:SetActive(false)
  end)
  self:_CheckNoInfoActive()
  self:_CheckBanPet()
  self._infoGo:SetActive(true)
  local heart = self._info:SpawnObject("UISeasonMazeTeamHeartItem")
  self.heartItem = heart
  heart:SetData(self._pet, nil, false, self._firstIn, self._teamType, PetSkinEffectPath.CARD_TEAM_SELECT, self._isHelp, self._spShow, self._isFastSelect)
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
    if self._scrollVerPos then
      self._scrollRect.verticalNormalizedPosition = self._scrollVerPos
      self._scrollVerPos = nil
    end
  end)
  self:AddUICustomEventListener(etlAdd, UIEvent.LongPress, function(go)
    if not self._draging and self._longPressCallback and not GuideHelper.IsUIGuideShow() then
      if self._bg.activeSelf then
        Log.debug("###[UISeasonMazeTeamChangeItem] self._bg.activeSelf")
        self._bg:SetActive(false)
      end
      local open = self._longPressCallback(self._pstid, etlAddDrag)
      if open then
        self._scrollVerPos = self._scrollRect.verticalNormalizedPosition
      end
    end
  end)
end

function UISeasonMazeTeamChangeItem:_ShowDispatchState()
  local module = GameGlobal.GetModule(SeasonMazeModule)
  local dispatch = module:GetPetDispatchData(self._pet:GetTemplateID())
  if dispatch then
    self.dispatch:SetActive(true)
    local dispatch = module:GetPetDispatchData(self._pet:GetTemplateID())
    if dispatch then
      self.dispatchText:SetText(dispatch.residue_round)
    else
      Log.exception("pet has dispatched but has no server data")
    end
  else
    self.dispatch:SetActive(false)
  end
  if SMazeAdaptor.GetCurRoomType() == SeasonMazeRoomType.SMRT_Ore then
    local missionModule = GameGlobal.GetModule(MissionModule)
    local context = missionModule:TeamCtx()
    local teams = context:GetSeasonMazeTeam()
    local teamid = context:GetCurrTeamId()
    local team = teams.list[teamid]
    local idx = 1
    for i = 1, #team.pets do
      local petID = team.pets[i]
      if petID == self._pet:GetTemplateID() then
        self._fastTeam.gameObject:SetActive(true)
        self._ftMemberID:SetText(idx)
        self._inTeam = true
        break
      end
      idx = idx + 1
    end
  end
end

function UISeasonMazeTeamChangeItem:RefreshBinderPet()
  self._spShow = false
  self._spPstid = 0
  if self._pet then
    local thisPetID = self._pet:GetTemplateID()
    local teamPets
    if self._isFastSelect then
      local pstidTab = self:RootUIOwner():GetPstidTab()
      teamPets = {}
      for k, v in pairs(pstidTab) do
        if v.memId ~= nil then
          table.insert(teamPets, v.pstid)
        end
      end
    else
      local pstidTab = self:RootUIOwner():GetTeamOrPrimaryPets()
      teamPets = {}
      if pstidTab and next(pstidTab) then
        for k, v in pairs(pstidTab) do
          if v and 0 < v then
            table.insert(teamPets, v)
          end
        end
      end
    end
    if teamPets and 0 < table.count(teamPets) then
      for key, pstid in pairs(teamPets) do
        local isBinderPet = false
        local tmp_pet = self._getPet(pstid)
        if tmp_pet then
          isBinderPet = tmp_pet:IsBinderPet(thisPetID)
        end
        if isBinderPet then
          local petName = tmp_pet:GetPetName()
          local tex = StringTable.Get("str_team_change_binder_item_tex", StringTable.Get(petName))
          self._spShow = true
          self._binderPet:SetActive(true)
          if self._binderPet.activeInHierarchy then
            self._binderPetTex:RefreshText(tex)
          end
          self._spPstid = pstid
          break
        end
      end
    end
  end
  self._binderPet:SetActive(self._spShow)
end

function UISeasonMazeTeamChangeItem:_CheckNoInfoActive()
  local active = false
  local text
  active = self._del
  text = StringTable.Get("str_team_change_no_choose")
  if active then
    self._noinfoText:SetText(text)
  end
  self._delete:SetActive(active)
  if not active then
    self:RefreshBinderPet()
  else
    self._binderPet:SetActive(false)
  end
end

function UISeasonMazeTeamChangeItem:_CheckBanPet()
  local isManualBanPet = false
  local isRotateBanPet = false
  self._isBanPet = false
  if self._manualBanPetList and table.icontains(self._manualBanPetList, self._pstid) then
    isManualBanPet = true
    self._isBanPet = true
  end
  if self._rotateBanPetList and table.icontains(self._rotateBanPetList, self._pstid) then
    isRotateBanPet = true
    self._isBanPet = true
  end
  if self._manualBanLayerGo then
    self._manualBanLayerGo:SetActive(isManualBanPet)
  end
  if self._rotateBanLayerGo then
    self._rotateBanLayerGo:SetActive(isRotateBanPet)
  end
end

function UISeasonMazeTeamChangeItem:OnHide()
end

function UISeasonMazeTeamChangeItem:BgOnClick()
  if self._isDiffFilter and not self._del then
    return
  end
  if self._isBanPet then
    return
  end
  local isWorking = self._uiSeasonMazeModule:GetPetState(self._pet:GetTemplateID(), ESeasonMazePetStateType.ESeasonMazePetStateType_Dispatch)
  if isWorking then
    local module = GameGlobal.GetModule(SeasonMazeModule)
    local dispatch = module:GetPetDispatchData(self._pet:GetTemplateID())
    if dispatch then
      local tips = StringTable.Get("str_season_maze_dispatch_finish_tips", dispatch.residue_round)
      ToastManager.ShowToast(tips)
      Log.debug("###[UISeasonMazeTeamChangeItem] click pet is dispatch !")
    else
      Log.exception("pet has dispatched but has no server data")
    end
    return
  end
  local isDie = self._uiSeasonMazeModule:GetPetState(self._pet:GetTemplateID(), ESeasonMazePetStateType.ESeasonMazePetStateType_Dead)
  if isDie then
    local tips = StringTable.Get("str_season_maze_pet_select_dead_tips")
    ToastManager.ShowToast(tips)
    Log.debug("###[UISeasonMazeTeamChangeItem] click pet is die !")
    return
  end
  if SMazeAdaptor.GetCurRoomType() == SeasonMazeRoomType.SMRT_Ore and self._uiSeasonMazeModule:IsRunning() and self._uiSeasonMazeModule:SeasonMazeManager():GetCurState():StateID() ~= SMazeStateID.BossAttack and self._uictrl ~= nil and self._uictrl:GetName() == "UISeasonMazeTeamChangeController" then
    if self._uictrl:CheckAvailablePetCount() <= 1 then
      local tips = StringTable.Get("str_season_maze_pet_less_one_available")
      ToastManager.ShowToast(tips)
      return
    end
    if self._inTeam then
      UISeasonMazeModule.PopMsgBox(StringTable.Get("str_season_maze_room_ore_title"), StringTable.Get("str_season_maze_pet_select_used_tips"), SeasonMazeMsgBoxType.OkCancel, function()
        if self._callback then
          self._callback(self._pstid, self._del, self._helpPetState, self._slot)
        end
      end)
    elseif self._callback then
      self._callback(self._pstid, self._del, self._helpPetState, self._slot)
    end
  elseif self._callback then
    self._callback(self._pstid, self._del, self._helpPetState, self._slot)
  end
end

function UISeasonMazeTeamChangeItem:GetHelpPetState()
  return self._helpPetState
end

function UISeasonMazeTeamChangeItem:_OnFastTeam()
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
    local l_pet = self._getPet(self._spPstid)
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
    if self._pet ~= nil and petHelper ~= nil and self._pet:GetTemplateID() == petHelper.m_nTemplateID then
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

function UISeasonMazeTeamChangeItem:GetTabItem()
  return self._tabItem
end

function UISeasonMazeTeamChangeItem:RevertButton()
  local etlAddDrag = UICustomUIEventListener.Get(self._bgBtn)
  if etlAddDrag.IsDragging then
    etlAddDrag.IsDragging = false
  end
  if self._scrollVerPos then
    self._scrollRect.verticalNormalizedPosition = self._scrollVerPos
    self._scrollVerPos = nil
  end
end

function UISeasonMazeTeamChangeItem:IsBinderPet()
  return self._spShow
end

function UISeasonMazeTeamChangeItem:IsRepeatHelpPet()
  return self._repeatHelpPetVisible
end

function UISeasonMazeTeamChangeItem:FastTeamChanged()
  self:_CheckNoInfoActive()
  self:_OnFastTeam()
end
