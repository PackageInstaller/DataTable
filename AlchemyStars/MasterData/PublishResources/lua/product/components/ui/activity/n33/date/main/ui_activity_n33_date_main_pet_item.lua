_class("UIActivityN33DateMainPetItem", UICustomWidget)
UIActivityN33DateMainPetItem = UIActivityN33DateMainPetItem

function UIActivityN33DateMainPetItem:Constructor()
  self._canClick = true
end

function UIActivityN33DateMainPetItem:OnShow()
  self:AddEventListener()
  self:_GetComponent()
end

function UIActivityN33DateMainPetItem:AddEventListener()
  self:AttachEvent(GameEventType.OnN33FindPet, self.OnN33FindPet)
  self:AttachEvent(GameEventType.OnDateFilterClick, self.OnDateFilterClick)
end

function UIActivityN33DateMainPetItem:_GetComponent()
  self._petIcon = self:GetUIComponent("RawImageLoader", "petIcon")
  self._rect = self:GetUIComponent("RectTransform", "rect")
  self._anim = self:GetUIComponent("Animation", "rect")
  self._inviteIconObj = self:GetGameObject("inviteIcon")
  self._filterMaskObj = self:GetGameObject("filterMask")
  self._rect.anchorMax = Vector2(0.5, 0.5)
  self._rect.anchorMin = Vector2(0.5, 0.5)
  self._rect.sizeDelta = Vector2(119, 137)
end

function UIActivityN33DateMainPetItem:OnDateFilterClick(type)
  if type == UIActivityN33DateMainFilterType.Build then
    self._canClick = false
  else
    self._canClick = true
  end
end

function UIActivityN33DateMainPetItem:OnN33FindPet(petID)
  if petID == self._cfg.PetId then
    self:PetIconOnClick()
  end
end

function UIActivityN33DateMainPetItem:CheckID(petID)
  if petID == self._cfg.PetId then
    return true
  end
  return false
end

function UIActivityN33DateMainPetItem:SetData(cfg, data, callback)
  self._cfg = cfg
  self._activityConst = data
  self._callback = callback
  self:_Init()
end

function UIActivityN33DateMainPetItem:_Init()
  self._petIcon:LoadImage(self._cfg.MapIcon)
  local pos = Vector2(self._cfg.Position[1] / 100, self._cfg.Position[2] / 100)
  self._rect.anchoredPosition = pos
  if self._cfg.PreCondition then
    local isOver = self._activityConst:CheckStoryConditionIsOver(self._cfg.ID)
    self._inviteIconObj:SetActive(isOver)
  else
    self._inviteIconObj:SetActive(false)
  end
end

function UIActivityN33DateMainPetItem:GetConfig()
  return self._cfg
end

function UIActivityN33DateMainPetItem:PetIconOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  if not self._canClick then
    return
  end
  self:StartTask(function(TT)
    self:Lock("uieffanim_UIActivityN33DateMainPetItem_click")
    self._anim:Play("uieffanim_UIActivityN33DateMainPetItem_click")
    YIELD(TT, 777)
    self:UnLock("uieffanim_UIActivityN33DateMainPetItem_click")
    if self._callback then
      self._callback(self)
    end
  end, self)
end
