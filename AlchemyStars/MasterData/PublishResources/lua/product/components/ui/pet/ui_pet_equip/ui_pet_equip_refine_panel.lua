_class("UIPetEquipRefinePanel", UICustomWidget)
UIPetEquipRefinePanel = UIPetEquipRefinePanel

function UIPetEquipRefinePanel:OnShow(uiParams)
  self:InitWidget()
  self._btnCfg = {
    [1] = {
      bg = "spirit_lg_icon08"
    },
    [2] = {
      bg = "spirit_lg_icon10"
    },
    [3] = {
      bg = "spirit_lg_icon11"
    }
  }
  self:_OnValue()
end

function UIPetEquipRefinePanel:InitWidget()
  self.lockedPool = self:GetUIComponent("UISelectObjectPath", "locked")
  self.unlockedPool = self:GetUIComponent("UISelectObjectPath", "unlocked")
  self.lockedPoolGo = self:GetGameObject("locked")
  self.unlockedPoolGo = self:GetGameObject("unlocked")
  self.refineLevelBtnPool = self:GetUIComponent("UISelectObjectPath", "refineLevelBtnPool")
  self.tipsImgGo = self:GetGameObject("tipsImg")
  self.tipsImgRt = self:GetUIComponent("RectTransform", "tipsImg")
  self.closeTipsBtnGo = self:GetGameObject("CloseTipsBtn")
  self.closeTipsBtnGo:SetActive(false)
  self.tipsImgGo:SetActive(false)
end

function UIPetEquipRefinePanel:_OnValue()
  self.selectBtnIndex = 1
  self.selectBtnView = nil
  local len = #self._btnCfg
  self.btnViews = self.refineLevelBtnPool:SpawnObjects("UIPetEquipRefineLevelBtn", len)
  for i = 1, len do
    local bgName = self._btnCfg[i].bg
    local btnView = self.btnViews[i]
    btnView:SetData(bgName, function()
      self:OnLevelBtnClicked(i, btnView)
    end)
    if i == self.selectBtnIndex then
      self.selectBtnView = btnView
    end
  end
end

function UIPetEquipRefinePanel:OnLevelBtnClicked(index, btnView, isInit)
  if index == self.selectBtnIndex then
    return
  end
  if not isInit then
    local nextRefineIndex = 0
    if self.isRefineUnlock then
      local refineLv = self._petData:GetEquipRefineLv()
      nextRefineIndex = refineLv + 1
    end
    if self.selectBtnView then
      if nextRefineIndex > self.selectBtnIndex then
        self.selectBtnView:PlayAni("uieff_UIPetEquipRefineLevelBtn_unselectedin_01")
      else
        self.selectBtnView:PlayAni("uieff_UIPetEquipRefineLevelBtn_unselectedin_02")
      end
    end
    self.selectBtnIndex = index
    self.selectBtnView = btnView
    self.selectBtnView:PlayAni("uieff_UIPetEquipRefineLevelBtn_select")
  else
    self.selectBtnIndex = index
    self.selectBtnView = btnView
  end
  self:ShowRefineInfo(true)
end

function UIPetEquipRefinePanel:OnRefineSucc()
  if self.selectBtnIndex < #self.btnViews then
    local nextIndex = self.selectBtnIndex + 1
    local nextBtn = self.btnViews[nextIndex]
    self:OnLevelBtnClicked(nextIndex, nextBtn)
  else
    self:RefreshCurSelectBtnState()
  end
end

function UIPetEquipRefinePanel:SetData(petData, petEquipController)
  self.petEquipController = petEquipController
  self._petData = petData
  self._petId = self._petData:GetTemplateID()
  self._pstId = self._petData:GetPstID()
  self._currentEquipLv = self._petData:GetEquipLv()
  self._elem = self._petData:GetPetFirstElement()
  self._equipMaxLv = 0
  local cfg_equip = Cfg.cfg_pet_equip({
    PetID = self._petId
  })
  if cfg_equip and 0 < #cfg_equip then
    for k, subCfg in pairs(cfg_equip) do
      if subCfg.Level > self._equipMaxLv then
        self._equipMaxLv = subCfg.Level
      end
    end
  else
    Log.fatal("###[UIPetEquipDetailPanel] cfg_pet_equip is nil ! id --> ", self._petId)
  end
  local btnIndex = self._petData:GetEquipRefineLv() + 1
  if 3 < btnIndex then
    btnIndex = 3
  end
  local nextBtn = self.btnViews[btnIndex]
  self:OnLevelBtnClicked(btnIndex, nextBtn, true)
  self.isRefineUnlock = self:CheckCondition()
  self:ShowRefineInfo()
  if UIPetEquipHelper.CheckRefineRed(self._petData) then
    UIPetEquipHelper.SetRefineRed(self._petData)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetAwakenEvent)
  end
end

function UIPetEquipRefinePanel:CheckCondition()
  local refineStatus = self._petData:GetEquipRefineStatus()
  return refineStatus == PetEquipRefineStatus.UNLOCK
end

function UIPetEquipRefinePanel:ShowRefineInfo(withAni)
  if withAni then
    local lockName = "UIPetEquipRefinePanel_RefineContentChgAni"
    self:Lock(lockName)
    self:StartTask(function(TT)
      if self.isRefineUnlock then
        if self.unLockedView then
          self.unLockedView:PLayOutAni()
          YIELD(TT, 200)
        end
        self:ShowUnLockedByIndex(self.selectBtnIndex)
        self.unLockedView:PLayInAni()
      else
        if self.lockedView then
          self:_LockedViewPlayAni("out")
          YIELD(TT, 200)
        end
        self:ShowLockedByIndex(self.selectBtnIndex)
        self:_LockedViewPlayAni("in")
      end
      self:UnLock(lockName)
    end, self)
    return
  end
  self.lockedPoolGo:SetActive(not self.isRefineUnlock)
  self.unlockedPoolGo:SetActive(self.isRefineUnlock)
  if self.isRefineUnlock then
    self:ShowUnLockedByIndex(self.selectBtnIndex)
  else
    self:ShowLockedByIndex(self.selectBtnIndex)
  end
end

function UIPetEquipRefinePanel:ShowLockedByIndex(index)
  if not self.lockedView then
    self.lockedView = self.lockedPool:SpawnObject("UIPetEquipRefinePanelLock")
  end
  self.lockedView:SetData(index, self._petData, self)
end

function UIPetEquipRefinePanel:ShowUnLockedByIndex(index)
  if not self.unLockedView then
    self.unLockedView = self.unlockedPool:SpawnObject("UIPetEquipRefinePanelUnLock")
  end
  self.unLockedView:SetData(index, self._petData, function()
    self:OnRefineSucc()
  end, self.petEquipController, self)
end

function UIPetEquipRefinePanel:RefreshCurSelectBtnState()
  local maxHightIndex = self:GetHightLightMaxIndex()
  if maxHightIndex >= self.selectBtnIndex then
    self.selectBtnView:PlayAni("uieff_UIPetEquipRefineLevelBtn_selectedin_01")
  else
    self.selectBtnView:PlayAni("uieff_UIPetEquipRefineLevelBtn_selectedin_02")
  end
end

function UIPetEquipRefinePanel:PlayTabInAni(TT)
  if self.isRefineUnlock then
    self:_UnLockedViewPlayAni("in")
  else
    self:_LockedViewPlayAni("in")
  end
  local nextRefineIndex = 0
  if self.isRefineUnlock then
    local refineLv = self._petData:GetEquipRefineLv()
    nextRefineIndex = refineLv + 1
  end
  for i, v in ipairs(self.btnViews) do
    if i == self.selectBtnIndex then
      if i < nextRefineIndex then
        v:PlayAni("uieff_UIPetEquipRefineLevelBtn_selectedin_01")
      else
        v:PlayAni("uieff_UIPetEquipRefineLevelBtn_selectedin_02")
      end
    elseif i < nextRefineIndex then
      v:PlayAni("uieff_UIPetEquipRefineLevelBtn_in_01")
    else
      v:PlayAni("uieff_UIPetEquipRefineLevelBtn_in_02")
    end
    YIELD(TT, 60)
  end
end

function UIPetEquipRefinePanel:GetHightLightMaxIndex()
  local maxIndex = 0
  if self.isRefineUnlock then
    local refineLv = self._petData:GetEquipRefineLv()
    if 0 < refineLv then
      maxIndex = refineLv
    else
      maxIndex = 1
    end
  end
  return maxIndex
end

function UIPetEquipRefinePanel:PlayTabOutAni(TT)
  if self.isRefineUnlock then
    self:_UnLockedViewPlayAni("out")
  else
    self:_LockedViewPlayAni("out")
  end
  for i, v in ipairs(self.btnViews) do
    v:PlayAni("uieff_UIPetEquipRefineLevelBtn_out")
  end
end

function UIPetEquipRefinePanel:CheckGuide()
  if self._petData:GetPetGrade() < 3 then
    return
  end
  if self.isRefineUnlock then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIPetEquipControllerUnLock)
  else
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UIPetEquipControllerLock)
  end
end

function UIPetEquipRefinePanel:ShowTips(go)
  self.tipsImgGo:SetActive(true)
  self.closeTipsBtnGo:SetActive(true)
  if go then
    local position = go.transform.position
    self.tipsImgRt.position = position
  end
end

function UIPetEquipRefinePanel:CloseTipsBtnOnClick(go)
  self.tipsImgGo:SetActive(false)
  self.closeTipsBtnGo:SetActive(false)
end

function UIPetEquipRefinePanel:_LockedViewPlayAni(type)
  local tb = {
    ["in"] = "uieff_UIPetEquipRefinePanelLock_in",
    out = "uieff_UIPetEquipRefinePanelLock_out"
  }
  if self.lockedView then
    self.lockedView:PlayAni(tb[type])
  end
end

function UIPetEquipRefinePanel:_UnLockedViewPlayAni(type)
  local tb = {
    ["in"] = "uieff_UIPetEquipRefinePanelUnLock_in",
    out = "uieff_UIPetEquipRefinePanelUnLock_out"
  }
  if self.unLockedView then
    self.unLockedView:PlayAni(tb[type])
  end
end
