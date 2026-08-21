_class("UICN14N43Frog", UICustomWidget)
UICN14N43Frog = UICN14N43Frog

function UICN14N43Frog:OnShow(uiParams)
  self.clickCallFun = nil
  self.frogID = -1
  self.idleClick = true
  self:InitWidget()
  if self._spine then
    self._spineSke = self._spine.CurrentSkeleton
    if not self._spineSke then
      self._spineSke = self._spine.CurrentMultiSkeleton
    end
    if self._spineSke then
      self:GetGameObject().transform.localScale = Vector3.zero
      self._spineSke.AnimationState:SetAnimation(0, "Story_norm", true)
    end
  end
  GameGlobal.Timer():AddEvent(50, function()
    if self:GetGameObject() then
      self:GetGameObject().transform.localScale = Vector3.one
    end
  end)
  local etl = UICustomUIEventListener.Get(self._clickBt.gameObject)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(ped)
    if not self.canDrag then
      return
    end
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(ped)
    if not self.canDrag then
      return
    end
    local screenPos = ped.position
    local pos = UIHelper.ScreenPointToWorldPointInRectangle(self._clickBtTran.parent, screenPos, self.controllerCamera)
    self._clickBtTran.position = pos
  end)
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(ped)
    if not self.canDrag then
      return
    end
    if self:CheckInRecycleArea() then
      if self.endDragFun then
        self.endDragFun(self.frogID)
      end
    else
      self._clickBtTran.localPosition = Vector3(0, 0, 0)
    end
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self:ClickBtnOnClick(go)
  end)
end

function UICN14N43Frog:OnHide()
  self._spineSke = nil
  self._spine = nil
end

function UICN14N43Frog:InitWidget()
  self._spine = self:GetUIComponent("SpineLoader", "spine")
  self._clickBt = self:GetGameObject("ClickBtn")
  self._clickBtTran = self._clickBt.transform
  self._RootAnim = self:GetUIComponent("Animation", "RootAnim")
  self._EffAnim = self:GetUIComponent("Animation", "EffAnim")
end

function UICN14N43Frog:SetDragData(camera, area)
  self.controllerCamera = camera
  self.RecycleArea = area
end

function UICN14N43Frog:SetPos(localV3)
  self:GetGameObject().transform.localPosition = localV3
end

function UICN14N43Frog:SetData(canDrag, frogID, clickCallFun, endDragFun)
  self.canDrag = canDrag
  self.frogID = frogID
  self.clickCallFun = clickCallFun
  self.endDragFun = endDragFun
end

function UICN14N43Frog:ClickBtnOnClick(go)
  if not self.idleClick then
    return
  end
  if self._spineSke then
    local entry = self._spineSke.AnimationState:SetAnimation(0, "click1", false)
    self._spine.AnimationState.Data.DefaultMix = 0
    self._spineSke:Update(0)
    if entry then
      local anim = entry.Animation
      local duration = anim.Duration
      local yieldTime = math.floor(duration * 1000)
      if self._spineEvent then
        GameGlobal.Timer():CancelEvent(self._spineEvent)
        self._spineEvent = nil
      end
      self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
        if self._spineSke and self._spine then
          self._spineSke.AnimationState:SetAnimation(0, "Story_norm", true)
          self._spine.AnimationState.Data.DefaultMix = 0
          self._spineSke:Update(0)
        end
      end)
    end
  end
  if self.clickCallFun then
    self.clickCallFun(self.frogID)
  end
end

function UICN14N43Frog:SetActive(bo)
  local go = self:GetGameObject()
  if not go then
    return
  end
  go:SetActive(bo)
end

function UICN14N43Frog:ChangeIdx(idx)
  self.frogID = idx
end

function UICN14N43Frog:CheckInRecycleArea()
  local localPos = self.RecycleArea:InverseTransformPoint(self._clickBtTran.position)
  local isIn = self.RecycleArea.rect:Contains(localPos)
  Log.debug("[isIn] ", isIn)
  return isIn
end

function UICN14N43Frog:GetMoveTran()
  return self._clickBt.transform
end

function UICN14N43Frog:PlayInWater()
  self._RootAnim:Play("effanim_UICN14N43Frog_in")
end

function UICN14N43Frog:PlayOutWater()
  self._RootAnim:Play("effanim_UICN14N43Frog_out")
end

function UICN14N43Frog:PlayMoveEff()
  if self._spineSke then
    local entry = self._spineSke.AnimationState:SetAnimation(0, "jump", false)
    self._spine.AnimationState.Data.DefaultMix = 0
    self._spineSke:Update(0)
    if entry then
      self.idleClick = false
      local anim = entry.Animation
      local duration = anim.Duration
      local yieldTime = math.floor(duration * 1000)
      if self._spineEvent then
        GameGlobal.Timer():CancelEvent(self._spineEvent)
        self._spineEvent = nil
      end
      self._spineEvent = GameGlobal.Timer():AddEvent(yieldTime, function()
        if self._spineSke and self._spine then
          self._spineSke.AnimationState:SetAnimation(0, "Story_norm", true)
          self._spine.AnimationState.Data.DefaultMix = 0
          self._spineSke:Update(0)
          self.idleClick = true
        end
      end)
    end
  end
  self._EffAnim:Play("effanim_UICN14N43Frog_eff_out")
end

function UICN14N43Frog:PlayCollectOver()
  if self._spineSke then
    local entry = self._spineSke.AnimationState:SetAnimation(0, "click1", false)
    self._spine.AnimationState.Data.DefaultMix = 0
    self._spineSke:Update(0)
    if entry then
      if self._spineEvent then
        GameGlobal.Timer():CancelEvent(self._spineEvent)
        self._spineEvent = nil
      end
      self._spineEvent = GameGlobal.Timer():AddEvent(260, function()
        self:SetActive(false)
      end)
    end
  end
end
