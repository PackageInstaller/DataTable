_class("UITeamItem", UICustomWidget)
UITeamItem = UITeamItem

function UITeamItem:OnShow()
  self._card = self:GetUIComponent("UISelectObjectPath", "card")
  self._cardGo = self:GetGameObject("card")
  self._imgBG = self:GetGameObject("imgBG")
  self._interactableImg = self:GetUIComponent("Image", "imgBG")
  self._imgMask = self:GetGameObject("imgMask")
  self._imgMask:SetActive(false)
  self._tran = self:GetGameObject():GetComponent("RectTransform")
  self._imgAdd = self:GetGameObject("imgAdd")
  self._imgLock = self:GetGameObject("imgLock")
  self._guideEff = self:GetGameObject("UIWeakKuang")
  self._divider = self:GetGameObject("divider")
  self._helpPetGO = self:GetGameObject("helppet")
  self._helpPetGO:SetActive(false)
  self._zhuzhanGO = self:GetGameObject("zhuzhan")
  self._wufazhuzhanGO = self:GetGameObject("wufazhuzhan")
  self._helppetTipsGO = self:GetGameObject("helppetTips")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._id = 0
  self._slot = 0
  self._lock = false
  self._teamId = 0
  self._callback = nil
  self._petModule = self:GetModule(PetModule)
  self.firstTimePlayAnim = true
  local etl = UICustomUIEventListener.Get(self._imgBG)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(ped)
    if self._slot == 5 then
      local hpm = self:GetModule(HelpPetModule)
      local helpPetKey = hpm:UI_GetHelpPetKey()
      if helpPetKey and 0 < helpPetKey then
        ToastManager.ShowToast(StringTable.Get("str_help_pet_weizhi"))
        return
      end
    end
    if self._id == 0 or GameGlobal.UIStateManager():IsLocked() then
      return
    end
    self._imgMask:SetActive(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamItemLongPress, true, self._slot, self._id)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(ped)
    if self._slot == 5 then
      local hpm = self:GetModule(HelpPetModule)
      local helpPetKey = hpm:UI_GetHelpPetKey()
      if helpPetKey and 0 < helpPetKey then
        return
      end
    end
    if self._id ~= 0 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamUpdateReplaceCardPos, ped.position)
    end
  end)
  
  local function endDragFunc()
    if self._slot == 5 then
      local hpm = self:GetModule(HelpPetModule)
      local helpPetKey = hpm:UI_GetHelpPetKey()
      if helpPetKey and 0 < helpPetKey then
        return
      end
    end
    if self._id == 0 then
      return
    end
    self._imgMask:SetActive(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamItemLongPress, false, self._slot, self._id)
  end
  
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(ped)
    endDragFunc()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self._anim:Play("uianim_UITeamItem_select")
    GameGlobal.UIStateManager():Lock("UITeamItem_Click")
    self:StartTask(function(TT)
      YIELD(TT, 400)
      GameGlobal.UIStateManager():UnLock("UITeamItem_Click")
      if self._callback then
        self._callback()
      end
    end)
  end)
  if not EDITOR then
    self:AddUICustomEventListener(etl, UIEvent.ApplicationFocus, function(b)
      if not b then
        if not etl.IsDragging then
          return
        end
        etl.IsDragging = false
        endDragFunc()
      end
    end)
  end
end

function UITeamItem:PlayAnimIn(delay)
  if self.firstTimePlayAnim then
    self.firstTimePlayAnim = false
  else
    return
  end
  GameGlobal.UIStateManager():Lock("UITeamItem_PlayAnimIn" .. delay)
  self:StartTask(function(TT)
    YIELD(TT, delay)
    self._anim:Play("uianim_UITeamItem_in")
    GameGlobal.UIStateManager():UnLock("UITeamItem_PlayAnimIn" .. delay)
  end)
end

function UITeamItem:FlushIdx(idx)
  self._idx = idx
end

function UITeamItem:FlushTeamMember(slot, teamId)
  self._slot = slot
  self._teamId = teamId
end

function UITeamItem:FlushHelpPetState(helpPetEnable)
  self._helpPetEnable = helpPetEnable
  if self._slot == 5 then
    local missionModule = self:GetModule(MissionModule)
    local ctx = missionModule:TeamCtx()
    local fromMain = ctx.teamOpenerType == TeamOpenerType.Main
    if fromMain then
      self:FlushHelpPetIcon(1)
      return
    end
    local module = self:GetModule(RoleModule)
    local isLock = not module:CheckModuleUnlock(GameModuleID.MD_HelpPet)
    if isLock then
      self:FlushHelpPetIcon(1)
      return
    end
    local hpm = self:GetModule(HelpPetModule)
    local helpPetKey = hpm:UI_GetHelpPetKey()
    if self._helpPetEnable then
      if helpPetKey and 0 < helpPetKey then
        self:FlushHelpPetIcon(2)
      elseif self._id == 0 then
        self:FlushHelpPetIcon(3)
      else
        self:FlushHelpPetIcon(4)
      end
    else
      self:FlushHelpPetIcon(1)
    end
  else
    self:FlushHelpPetIcon(1)
  end
end

function UITeamItem:FlushHelpPetIcon(state)
  local helpPetGOVisible = false
  local zhuzhanGOVisible = false
  local wufazhuzhanGOVisible = false
  local helppetTipsGOVisible = false
  if state == 1 then
    helpPetGOVisible = false
  elseif state == 2 then
    helpPetGOVisible = true
    zhuzhanGOVisible = true
  elseif state == 3 then
    helpPetGOVisible = true
    wufazhuzhanGOVisible = true
    helppetTipsGOVisible = true
  elseif state == 4 then
    helpPetGOVisible = true
    wufazhuzhanGOVisible = true
  end
  self._helpPetGO:SetActive(helpPetGOVisible)
  self._zhuzhanGO:SetActive(zhuzhanGOVisible)
  self._wufazhuzhanGO:SetActive(wufazhuzhanGOVisible)
end

function UITeamItem:Flush(id)
  self._imgAdd:SetActive(true)
  self._imgLock:SetActive(false)
  self._divider:SetActive(false)
  if GameSingle and id == 0 then
    self._cardGo:SetActive(false)
    id = nil
  end
  if not id then
    return
  end
  self._id = id
  self._lock = false
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  if self._slot == 5 then
    local hpm = self:GetModule(HelpPetModule)
    local helpPetKey = hpm:UI_GetHelpPetKey()
    if helpPetKey and 0 < helpPetKey then
      self._guideEff:SetActive(false)
      self._cardGo:SetActive(true)
      self._imgAdd:SetActive(false)
      local uiItem = self._card:SpawnObject("UIPetMemberItem")
      self._itemTemp = uiItem
      local helpPet = hpm:UI_GetSelectConstructHelpPet()
      uiItem:GuideSetData(helpPet, true, self._slot)
      self._divider:SetActive(true)
      return
    end
  end
  if id == 0 then
    if ctx.teamOpenerType == TeamOpenerType.Tower then
      if self._slot > ctx.towerTeamCeiling then
        self:SetLock()
      end
      self._cardGo:SetActive(false)
    else
      local discoveryData = missionModule:GetDiscoveryData()
      local chapters = discoveryData:GetVisibleChapters()
      local needChapter = Cfg.cfg_guide_const.guide_team_btn_chapter.IntValue
      if chapters and needChapter > table.count(chapters) then
        local petModule = self:GetModule(PetModule)
        local _uiModule = petModule.uiModule
        local _petIds = _uiModule:RequestPetDatas()
        local teamid = ctx:GetCurrTeamId()
        local curPets = ctx.teams.list[teamid].pets
        local targetSlot = 1
        for slot, psdId in ipairs(curPets) do
          if psdId == 0 then
            targetSlot = slot
            break
          end
        end
        for i = #_petIds, 1, -1 do
          if table.icontains(curPets, _petIds[i]) then
            table.remove(_petIds, i)
          end
        end
        if targetSlot == self._slot and 0 < #_petIds then
          self._guideEff:SetActive(true)
        else
          self._guideEff:SetActive(false)
        end
      else
        self._guideEff:SetActive(false)
      end
      self._cardGo:SetActive(false)
    end
  else
    self._guideEff:SetActive(false)
    self._cardGo:SetActive(true)
    self._imgAdd:SetActive(false)
    local uiItem = self._card:SpawnObject("UIPetMemberItem")
    self._itemTemp = uiItem
    uiItem:SetData(id, nil, nil, self._slot)
    self._divider:SetActive(true)
  end
end

function UITeamItem:SetLock()
  self._lock = true
  self._imgAdd:SetActive(false)
  self._imgLock:SetActive(true)
  self._interactableImg.raycastTarget = false
end

function UITeamItem:FlushGuide(pet, fromGuide)
  self._divider:SetActive(false)
  self._fromGuide = fromGuide or false
  self._imgAdd:SetActive(false)
  self._imgLock:SetActive(true)
  if not pet then
    self._cardGo:SetActive(false)
    return
  end
  self._cardGo:SetActive(true)
  local uiItem = self._card:SpawnObject("UIPetMemberItem")
  self._itemTemp = uiItem
  uiItem:GuideSetData(pet, self._fromGuide)
  self._divider:SetActive(true)
end

function UITeamItem:FlushCallback(callback)
  self._callback = callback
end

function UITeamItem:IsLocked()
  return self._lock
end

function UITeamItem:GetIdx()
  return self._idx
end

function UITeamItem:GetRectTransform()
  return self._tran
end

function UITeamItem:GetGB()
  return self._imgBG
end

function UITeamItem:GetHelpPetIcon()
  return self._wufazhuzhanGO
end

function UITeamItem:ShowDetailBtn(show)
  if self._itemTemp then
    self._itemTemp:ShowDetailBtn(show)
  end
end
