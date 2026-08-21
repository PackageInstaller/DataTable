_class("UIMissionStageItem", UICustomWidget)
UIMissionStageItem = UIMissionStageItem

function UIMissionStageItem:OnShow(uiParams)
  self:_AttachEvents()
  self:InitWidget()
end

function UIMissionStageItem:OnHide()
  self:_DetachEvents()
end

function UIMissionStageItem:_AttachEvents()
  self:AttachEvent(GameEventType.TalePetInfoDataChange, self.InfoDataChange)
end

function UIMissionStageItem:_DetachEvents()
  self:DetachEvent(GameEventType.TalePetInfoDataChange)
end

function UIMissionStageItem:InfoDataChange()
  self:OnRefreshUI()
end

function UIMissionStageItem:InitWidget()
  self.stage = self:GetUIComponent("UILocalizationText", "stage")
  self.unselect = self:GetGameObject("unselect")
  self.select = self:GetGameObject("select")
  self.complete = self:GetGameObject("complete")
  self.lock = self:GetGameObject("lock")
  self.unlock = self:GetGameObject("unlock")
end

function UIMissionStageItem:SetData(index, callback, petId)
  self.index = index
  self.callback = callback
  self.petId = petId
  self:OnRefreshUI()
end

function UIMissionStageItem:OnRefreshUI()
  self.unselect:SetActive(false)
  self.select:SetActive(false)
  self.complete:SetActive(false)
  self.lock:SetActive(false)
  self.unlock:SetActive(false)
  self.stage.color = Color(0, 0, 0, 1)
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  local info = talePetModule:GetPetInfo(self.petId)
  local totalPro = talePetModule:GetTaskPhase(self.petId)
  if info == nil then
    if self.index == 1 then
      self.unlock:SetActive(true)
      self.select:SetActive(true)
      self.stage:SetText(1)
      self:btnClickOnClick()
    else
      self.lock:SetActive(true)
      self.stage:SetText("")
    end
    return
  end
  if info.pet_status == TalePetCallType.TPCT_Can_Do or info.pet_status == TalePetCallType.TPCT_Done then
    self.unlock:SetActive(true)
    self.unselect:SetActive(true)
    self.complete:SetActive(true)
    self.stage:SetText(tostring(self.index))
    if self.index == totalPro then
      self:btnClickOnClick()
    end
    return
  end
  if self.index - 1 > info.task_phase then
    self.lock:SetActive(true)
    self.stage:SetText("")
  elseif self.index - 1 == info.task_phase then
    self.unlock:SetActive(true)
    self.select:SetActive(true)
    self.stage:SetText(tostring(self.index))
    self:btnClickOnClick()
  else
    self.unlock:SetActive(true)
    self.unselect:SetActive(true)
    self.complete:SetActive(true)
    self.stage:SetText(tostring(self.index))
    if self.index == totalPro then
      self:btnClickOnClick()
    end
  end
end

function UIMissionStageItem:btnClickOnClick()
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  local info = talePetModule:GetPetInfo(self.petId)
  if info == nil then
    return
  end
  if (info.pet_status == TalePetCallType.TPCT_Can_Do or info.pet_status == TalePetCallType.TPCT_Done) and self.callback then
    self.callback(self.index)
    self.stage.color = Color(1, 1, 1, 1)
    self.select:SetActive(true)
    self.unselect:SetActive(false)
    return
  end
  if self.index > info.task_phase + 1 then
    ToastManager.ShowToast(StringTable.Get("str_tale_pet_stage_tips"))
    return
  end
  if self.callback then
    self.callback(self.index)
    self.select:SetActive(true)
    self.stage.color = Color(1, 1, 1, 1)
    self.unselect:SetActive(false)
  end
end

function UIMissionStageItem:RefreshSelect()
  self.select:SetActive(false)
  self.unselect:SetActive(true)
  self.stage.color = Color(0, 0, 0, 1)
end
