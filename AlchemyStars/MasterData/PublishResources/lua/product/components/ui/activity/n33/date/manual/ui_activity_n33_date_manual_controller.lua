_class("UIActivityN33DateManualController", UIController)
UIActivityN33DateManualController = UIActivityN33DateManualController

function UIActivityN33DateManualController:LoadDataOnEnter(TT, res, uiParams)
end

function UIActivityN33DateManualController:OnShow(uiParams)
  self._activityConst = uiParams[1]
  self._petList = self._activityConst:GetDateManualList()
  self._curPetItem = nil
  self:AttackEvent()
  self:_GetComponent()
  self:_Init()
end

function UIActivityN33DateManualController:AttackEvent()
  self:AttachEvent(GameEventType.AircraftInteractiveEventRewardShowItemTips, self._ShowTips)
end

function UIActivityN33DateManualController:_GetComponent()
  self._petImg = self:GetUIComponent("RawImageLoader", "petImg")
  self._petName = self:GetUIComponent("UILocalizationText", "petName")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._buildingContent = self:GetUIComponent("UISelectObjectPath", "building")
  self._selectInfoPool = self:GetUIComponent("UISelectObjectPath", "selectInfoPool")
  self._srMemory = self:GetUIComponent("ScrollRect", "Scroll View")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._findObj = self:GetGameObject("find")
  self._leftArrowObj = self:GetGameObject("leftArrow")
  self._rightArrowObj = self:GetGameObject("rightArrow")
end

function UIActivityN33DateManualController:_Init()
  self._petItems = self._content:SpawnObjects("UIActivityN33DateManualItem", table.count(self._petList))
  local i = 1
  for _, v in pairs(self._petList) do
    local item = self._petItems[i]
    item:SetData(v, self._activityConst, function(item)
      self:PetItemClick(item)
    end)
    i = i + 1
  end
  self._petItems[1]:ItemBtnOnClick()
  self._srMemory.onValueChanged:AddListener(function(ve2)
    if ve2.x >= 0.9 and self._rightArrowObj.activeSelf then
      self._rightArrowObj:SetActive(false)
    elseif ve2.x < 0.9 and not self._rightArrowObj.activeSelf then
      self._rightArrowObj:SetActive(true)
    end
    if ve2.x <= 0.1 and self._leftArrowObj.activeSelf then
      self._leftArrowObj:SetActive(false)
    elseif ve2.x > 0.1 and not self._leftArrowObj.activeSelf then
      self._leftArrowObj:SetActive(true)
    end
  end)
end

function UIActivityN33DateManualController:PetItemClick(item)
  if self._curPetItem then
    self._curPetItem:SetSelect(false)
  end
  self._curPetItem = item
  if self._building then
    local cfgs = self._curPetItem:GetCfgs()
    local cfg = cfgs[1]
    self._petImg:LoadImage(cfg.PetImg)
    local petName = Cfg.cfg_pet[cfg.PetId].Name
    self._petName:SetText(StringTable.Get(petName))
    self._findObj:SetActive(self._curPetItem:IsInMap())
    self._building = self._buildingContent:SpawnObject("UIActivityN33DateManuaBuildContent")
    self._building:SetData(cfgs, self._activityConst, true, nil, function()
      self:StartTask(self._CloseAnim, self)
    end)
    self._building:PlayInAnim()
  else
    self._building = self._buildingContent:SpawnObject("UIActivityN33DateManuaBuildContent")
    local cfgs = self._curPetItem:GetCfgs()
    local cfg = cfgs[1]
    self._petImg:LoadImage(cfg.PetImg)
    local petName = Cfg.cfg_pet[cfg.PetId].Name
    self._petName:SetText(StringTable.Get(petName))
    self._findObj:SetActive(self._curPetItem:IsInMap())
    self._building:SetData(cfgs, self._activityConst, true, function()
    end, function()
      self:StartTask(self._CloseAnim, self)
    end)
  end
end

function UIActivityN33DateManualController:FindBtnOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self:StartTask(self._CloseAnim, self, function()
    local cfgs = self._curPetItem:GetCfgs()
    local cfg = cfgs[1]
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnN33FindPet, cfg.PetId)
  end)
end

function UIActivityN33DateManualController:_ShowTips(itemId, pos)
  if not self._selectInfo then
    self._selectInfo = self._selectInfoPool:SpawnObject("UISelectInfo")
  end
  self._selectInfo:SetData(itemId, pos)
end

function UIActivityN33DateManualController:BackBtnOnClick()
  if self._activityConst:CheckSimulationOperationIsOver() then
    ToastManager.ShowToast(StringTable.Get("str_activity_finished"))
    self:SwitchState(UIStateType.UIActivityN33MainController)
    return
  end
  self:StartTask(self._CloseAnim, self)
end

function UIActivityN33DateManualController:_CloseAnim(TT, callback)
  self._building:PlayCloseAnim()
  self._anim:Play("uieffanim_UIActivityN33DateManualController_out")
  self:Lock("UIActivityN33DateManualController_CloseAnim")
  YIELD(TT, 500)
  self:UnLock("UIActivityN33DateManualController_CloseAnim")
  if callback then
    callback()
  end
  self:CloseDialog()
end
