_class("UIPetSkinsGetCgController", UIController)
UIPetSkinsGetCgController = UIPetSkinsGetCgController

function UIPetSkinsGetCgController:Constructor()
  self._index = 1
end

function UIPetSkinsGetCgController:OnShow(uiParams)
  self._viewing = false
  self._first = uiParams[2] or false
  self._cgTB = uiParams[3]
  self._cgIndex = uiParams[4]
  if self._first then
    local tips = StringTable.Get("str_pet_skin_get_cg_tips")
    ToastManager.ShowToast(tips)
  end
  local picName = uiParams[1]
  if not picName then
    Log.error("###[UIPetSkinsGetCgController] picName is nil !")
  end
  self._viewBtnGo = self:GetGameObject("viewBtn")
  self._closeTipGo = self:GetGameObject("closeTipGo")
  self._cg = self:GetUIComponent("RawImageLoader", "cg")
  self._cg:LoadImage(picName)
  self._cgGo = self:GetGameObject("cg")
  self._btnGroupObj = self:GetGameObject("btnGroup")
  self._leftBtnObj = self:GetGameObject("LeftBtn")
  self._rightBtnObj = self:GetGameObject("RightBtn")
  self._bgObj = self:GetGameObject("bg")
  self._anim = self:GetUIComponent("Animation", "anim")
  self:SetCgWidth()
  if self._first then
    self:Lock("UIPetSkinsGetCgController_OnShow_first")
    self._btnGroupObj:SetActive(false)
    GameGlobal.Timer():AddEvent(1000, function()
      self:UnLock("UIPetSkinsGetCgController_OnShow_first")
      if not tolua.isnull(self._cgGo) then
        self._cgGo:SetActive(true)
      end
    end)
  else
    self._cgGo:SetActive(true)
  end
  self._scaleRoot = self:GetUIComponent("Transform", "scale")
  self._rect = self:GetUIComponent("RectTransform", "root")
  self._scaleK = 0.2
  self._touchScaleK = 0.001
  self._scaleMax = 1.5
  self._scaleMin = 0.5
  self._moveK = 1
  self._moveMaxX = 1000
  self._moveMinX = -1000
  self._moveMaxY = 500
  self._moveMinY = -500
  self._mousePos2 = 0
  self._mousePos = 0
  self._scaling = false
  self._draging = false
  self._touch0Pos = 0
  self._touch0Pos2 = 0
  self._touchDis = 0
  self._touchDis2 = 0
  local pixels = Cfg.cfg_aircraft_camera.clickAndDragPixelLength.Value
  self._startMove = pixels * pixels
  self:Init()
  self:_CheckBtnState()
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._bgObj), UIEvent.BeginDrag, function(pointData)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetSkinCGDragBegin, pointData)
  end)
  self:AttachEvent(GameEventType.PetSkinCGDragBegin, self.PetSkinCGDragBegin)
  self:AddUICustomEventListener(UICustomUIEventListener.Get(self._bgObj), UIEvent.EndDrag, function(pointData)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.PetSkinCGDragEnd, pointData)
  end)
  self:AttachEvent(GameEventType.PetSkinCGDragEnd, self.PetSkinCGDragEnd)
end

function UIPetSkinsGetCgController:SetCgWidth()
  local r_w = ResolutionManager.RealWidth()
  local b_w = ResolutionManager.BlackWidth()
  local currentWidth = r_w - b_w * 2
  local cgRect = self:GetUIComponent("RectTransform", "cg")
  cgRect.sizeDelta = Vector2(currentWidth, cgRect.sizeDelta.y)
end

function UIPetSkinsGetCgController:ResetRect()
  self._rect.anchoredPosition = Vector2(0, 0)
  self._scaleRoot.localScale = Vector3(1, 1, 1)
end

function UIPetSkinsGetCgController:Init()
  self._mousePresent = GameGlobal.EngineInput().mousePresent
  UnityEngine.Input.multiTouchEnabled = true
end

function UIPetSkinsGetCgController:OnHide()
  self._mousePresent = nil
  UnityEngine.Input.multiTouchEnabled = false
end

function UIPetSkinsGetCgController:bgOnClick(go)
  if self._draging then
    return
  end
  if self._scaling then
    return
  end
  if self._cgDraging then
    return
  end
  if self._viewing then
    self._viewing = false
    self:SetViewState()
  elseif self._first then
    local isIndexEnd = self._cgIndex and self._cgIndex == table.count(self._cgTB)
    local waitTime = isIndexEnd and 3000 or 200
    self:Lock("UIPetSkinsGetCgController:cgOnClick")
    if isIndexEnd then
      self:ShowDialog("UIAircraftUnlockFileController", StringTable.Get("str_aircraft_review_story"), StringTable.Get("str_aircraft_review_story_en"), true)
    else
      self._anim:Play("UIPetSkinsGetCgController_out")
    end
    self._leftBtnObj:SetActive(false)
    self._rightBtnObj:SetActive(false)
    self:StartTask(function(TT)
      YIELD(TT, waitTime)
      if self._cgIndex and self._cgIndex ~= table.count(self._cgTB) then
        local nextCGIndex = self._cgIndex + 1
        local staticPic = Cfg.cfg_cg_book[self._cgTB[nextCGIndex]].StaticPic
        self:CloseDialog()
        self:ShowDialog("UIPetSkinsGetCgController", staticPic, self._first, self._cgTB, nextCGIndex)
      else
        self._anim:Play("UIPetSkinsGetCgController_out")
        YIELD(TT, 200)
        self:CloseDialog()
      end
      self:UnLock("UIPetSkinsGetCgController:cgOnClick")
    end)
  else
    self:CloseDialog()
  end
end

function UIPetSkinsGetCgController:SetViewState()
  self._closeTipGo:SetActive(not self._viewing)
  self._viewBtnGo:SetActive(not self._viewing)
  if not self._first then
    self._btnGroupObj:SetActive(not self._viewing)
  end
end

function UIPetSkinsGetCgController:viewBtnOnClick(go)
  self._viewing = true
  self:SetViewState()
end

function UIPetSkinsGetCgController:Update(deltaTimeMS)
  if self._viewing then
    if self._mousePresent then
      self:EditorInput(deltaTimeMS / 1000)
    else
      self:TouchInput(deltaTimeMS / 1000)
    end
  end
end

function UIPetSkinsGetCgController:TouchInput(deltaTime)
  local touchCount = GameGlobal.EngineInput().touchCount
  local touch0
  if 0 < touchCount then
    touch0 = GameGlobal.EngineInput().GetTouch(0)
  end
  local touch1
  if 1 < touchCount then
    touch1 = GameGlobal.EngineInput().GetTouch(1)
  end
  if touch0 and touch0.phase == TouchPhase.Began then
    self._touch0DownPos = touch0.position
  end
  if not touch1 and touch0 and touch0.phase == TouchPhase.Moved then
    self._touch0Pos = touch0.position
    if self._touch0Pos2 ~= 0 then
      if self._draging == false and self._touch0DownPos and (self._touch0Pos - self._touch0DownPos).sqrMagnitude > self._startMove then
        self._draging = true
      end
      local offset = self._touch0Pos - self._touch0Pos2
      self._moveGap = offset * self._moveK
      local targetPos = self._rect.anchoredPosition + Vector2(self._moveGap.x, self._moveGap.y)
      if targetPos.x < self._moveMaxX and targetPos.x > self._moveMinX then
        self._rect.anchoredPosition = Vector2(targetPos.x, self._rect.anchoredPosition.y)
      end
      if targetPos.y < self._moveMaxY and targetPos.y > self._moveMinY then
        self._rect.anchoredPosition = Vector2(self._rect.anchoredPosition.x, targetPos.y)
      end
    end
    self._touch0Pos2 = self._touch0Pos
  end
  if touchCount == 0 then
    self._draging = false
    self._scaling = false
    self._touchDis = 0
    self._touchDis2 = 0
    self._touchDownDis = 0
    self._touch0Pos = 0
    self._touch0Pos2 = 0
  end
  if touch1 then
    self._scaling = true
    local lastLength = Vector2.Distance(touch0.position - touch0.deltaPosition, touch1.position - touch1.deltaPosition)
    local length = Vector2.Distance(touch0.position, touch1.position)
    local offset = length - lastLength
    self._scaleValue = offset * self._touchScaleK
    local targetScale = self._scaleRoot.localScale + Vector3(self._scaleValue, self._scaleValue, self._scaleValue)
    if targetScale.x < self._scaleMax and targetScale.x > self._scaleMin then
      self._scaleRoot.localScale = targetScale
    end
  end
end

function UIPetSkinsGetCgController:EditorInput(deltaTime)
  if GameGlobal.EngineInput().GetMouseButtonDown(0) then
    self._mousePos2 = 0
    self._mousePos = 0
    self._mouseDpwnPos = GameGlobal.EngineInput().mousePosition
  end
  if GameGlobal.EngineInput().GetMouseButton(0) then
    self._mousePos = GameGlobal.EngineInput().mousePosition
    if self._mousePos2 ~= 0 then
      if self._draging == false and (self._mousePos - self._mouseDpwnPos).sqrMagnitude > self._startMove then
        self._draging = true
      end
      local offset = self._mousePos - self._mousePos2
      self._moveGap = offset * self._moveK
      local targetPos = self._rect.anchoredPosition + Vector2(self._moveGap.x, self._moveGap.y)
      if targetPos.x < self._moveMaxX and targetPos.x > self._moveMinX then
        self._rect.anchoredPosition = Vector2(targetPos.x, self._rect.anchoredPosition.y)
      end
      if targetPos.y < self._moveMaxY and targetPos.y > self._moveMinY then
        self._rect.anchoredPosition = Vector2(self._rect.anchoredPosition.x, targetPos.y)
      end
    end
    self._mousePos2 = self._mousePos
  end
  self._scaleLength = GameGlobal.EngineInput().GetAxis("Mouse ScrollWheel")
  if 0 < self._scaleLength or 0 > self._scaleLength then
    local gap = self._scaleLength * self._scaleK
    local targetScale = self._scaleRoot.localScale + Vector3(gap, gap, gap)
    if targetScale.x < self._scaleMax and targetScale.x > self._scaleMin then
      self._scaleRoot.localScale = targetScale
    end
  end
  if GameGlobal.EngineInput().GetMouseButtonUp(0) then
    self._mousePos2 = 0
    self._mousePos = 0
    if self._draging then
      self._draging = false
    end
  end
end

function UIPetSkinsGetCgController:LeftBtnOnClick()
  self._index = self._index - 1
  self:_CheckBtnState()
  local cgID = self._cgTB[self._index]
  local cfCfg = Cfg.cfg_cg_book[cgID]
  if cfCfg then
    self._cg:LoadImage(cfCfg.StaticPic)
  else
    Log.fatal("cfg_cg_book没有该CG：", cgID)
  end
end

function UIPetSkinsGetCgController:RightBtnOnClick()
  self._index = self._index + 1
  self:_CheckBtnState()
  local cgID = self._cgTB[self._index]
  local cfCfg = Cfg.cfg_cg_book[cgID]
  if cfCfg then
    self._cg:LoadImage(cfCfg.StaticPic)
  else
    Log.fatal("cfg_cg_book没有该CG：", cgID)
  end
end

function UIPetSkinsGetCgController:_CheckBtnState()
  if not self._cgTB or self._cgTB and table.count(self._cgTB) == 1 then
    self._leftBtnObj:SetActive(false)
    self._rightBtnObj:SetActive(false)
    return
  end
  self:ResetRect()
  self._leftBtnObj:SetActive(self._index ~= 1)
  self._rightBtnObj:SetActive(self._index ~= table.count(self._cgTB))
end

function UIPetSkinsGetCgController:PetSkinCGDragBegin(pointData)
  if self._viewing then
    return
  end
  self._cgDraging = true
end

function UIPetSkinsGetCgController:PetSkinCGDragEnd(pointData)
  if self._viewing then
    return
  end
  local isNext = pointData.position.x < pointData.pressPosition.x
  self._cgDraging = false
  if self._cgTB and table.count(self._cgTB) == 1 then
    self._leftBtnObj:SetActive(false)
    self._rightBtnObj:SetActive(false)
    return
  end
  if isNext then
    if self._index ~= table.count(self._cgTB) then
      self:RightBtnOnClick()
    end
  elseif self._index ~= 1 then
    self:LeftBtnOnClick()
  end
end
