_class("UISeasonMazeCard", UICustomWidget)
UISeasonMazeCard = UISeasonMazeCard

function UISeasonMazeCard:OnShow(uiParams)
  self._playType = SeasonMazeCardPlayType.None
  self._p0 = Vector3.zero
  self._p1 = Vector3.zero
  self._p2 = Vector3.zero
  self._offsetX = 400
  self._p1Y = 0.5
  self._time = 0
  self._speed = 3
  self._camera = GameGlobal.UIStateManager():GetControllerCamera(self.uiOwner:GetName())
  self:_InitWidget()
  self:AttachEvent(GameEventType.OnSeasonMazeCardSettle, self._OnCardSettle)
  self:AttachEvent(GameEventType.OnSeasonMazeItemUseEnd, self._OnItemUseEnd)
  self:AttachEvent(GameEventType.AfterUILayerChanged, self._RefreshNew)
  self:AttachEvent(GameEventType.OnTempCloseRoom, self._TempCloseRoom)
  self:AttachEvent(GameEventType.ApplicationFocus, self.OnApplicationFocus)
end

function UISeasonMazeCard:OnHide()
end

function UISeasonMazeCard:_InitWidget()
  self._gameObject = self.view:GetGameObject()
  self._rectTransform = self:GetGameObject():GetComponent("RectTransform")
  self._cards = self:GetUIComponent("UISelectObjectPath", "Cards")
  self._beadBtn = self:GetGameObject("BeadBtn")
  self._bagBtn = self:GetGameObject("BagBtn")
  self._red = self:GetGameObject("Red")
  self._redCount = self:GetGameObject("Count")
  self._redCountValue = self:GetUIComponent("UILocalizationText", "CountValue")
  self._template = self:GetUIComponent("UISelectObjectPath", "Template")
  self._templateGO = self:GetGameObject("Template")
  self._templateTransform = self._templateGO.transform
  self._templateWidget = self._template:SpawnObject("UISeasonMazeCardItem")
  self._cardsGO = self:GetGameObject("Cards")
  self._black = self:GetGameObject("Black")
  self._animation = self._gameObject:GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonMazeCard:SetData(ids, closeAnim)
  if ids then
    self._gameObject:SetActive(true)
    self._ids = ids
    self._curIndex = 0
    self._templateGO:SetActive(false)
    self:_OnValue()
  elseif closeAnim then
    self:_OnClose()
  else
    if self._allWidgets then
      self._cards:ClearWidgets()
      self._allWidgets = nil
    end
    self._gameObject:SetActive(false)
  end
end

function UISeasonMazeCard:OnUpdate(dtMS)
  if self._playing then
    if self._playType == SeasonMazeCardPlayType.Button then
      self._time = self._time + dtMS * 0.001 * self._speed
      local bezierP = BezierTool.BezierCurve2(self._p0, self._p1, self._p2, self._time)
      local position = Vector3(bezierP.x, bezierP.y, self._templateTransform.position.z)
      if position.y >= self._p2.y then
        position.x = self._p2.x
        position.y = self._p2.y
        self._templateTransform.position = position
        self._playing = false
        self._playType = SeasonMazeCardPlayType.None
      else
        self._templateTransform.position = position
      end
    elseif self._playType == SeasonMazeCardPlayType.Drag then
    end
  end
end

function UISeasonMazeCard:_CalcBezierP()
  local curWidget = self._allWidgets[self._curIndex]
  if curWidget then
    self._p0 = curWidget:Position()
    self._p1 = self:_CalcBezierP1(curWidget)
    self._p2 = self._camera:ScreenToWorldPoint(Vector3(UnityEngine.Screen.width * 0.5, UnityEngine.Screen.height * 0.65, 0))
  end
end

function UISeasonMazeCard:_CalcBezierP1(widget)
  local y = UnityEngine.Screen.height * self._p1Y
  local x = UnityEngine.Screen.width * 0.5
  local screenPosition = Vector3(x, y, 0)
  if self._count % 2 == 0 then
    local midIndex = self._count / 2
    if midIndex >= self._curIndex then
      screenPosition = Vector3(widget:LocalPosition().x + 2 * self._offsetX + x, y, 0)
    else
      screenPosition = Vector3(widget:LocalPosition().x - 2 * self._offsetX + x, y, 0)
    end
  else
    local midIndex = math.floor(self._count / 2) + 1
    if midIndex > self._curIndex then
      screenPosition = Vector3(widget:LocalPosition().x + 2 * self._offsetX + x, y, 0)
    elseif midIndex < self._curIndex then
      screenPosition = Vector3(widget:LocalPosition().x - 2 * self._offsetX + x, y, 0)
    end
  end
  return self._camera:ScreenToWorldPoint(screenPosition)
end

function UISeasonMazeCard:_OnValue()
  self._count = #self._ids
  self:_Refresh()
end

function UISeasonMazeCard:_OnClose()
  self:Lock("UISeasonMazeCardOnClose")
  self:StartTask(function(TT)
    self._animation:Play("uieff_UISeasonMazeCard_out")
    YIELD(TT, 500)
    if self._allWidgets then
      self._cards:ClearWidgets()
      self._allWidgets = nil
    end
    self._gameObject:SetActive(false)
    self:UnLock("UISeasonMazeCardOnClose")
  end)
end

function UISeasonMazeCard:_Refresh()
  self:Lock("UISeasonMazeCardRefresh")
  self:StartTask(function(TT)
    self._cardsGO:SetActive(true)
    self._black:SetActive(true)
    self:_RefreshNew()
    if not self._allWidgets then
      self._cards:SpawnObjects("UISeasonMazeCardItem", self._count)
    end
    self._animation:Play("uieff_UISeasonMazeCard_in")
    YIELD(TT)
    self._allWidgets = self._cards:GetAllSpawnList()
    for i = 1, self._count do
      self._allWidgets[i]:SetData(i, self._ids[i], function(index)
        self:_OnClickCard(index)
      end, function()
        self:PlayCard(SeasonMazeCardPlayType.Button)
      end, true, self, true)
    end
    YIELD(TT, 433)
    self:UnLock("UISeasonMazeCardRefresh")
  end, self)
end

function UISeasonMazeCard:_OnClickCard(index)
  if self._curIndex == index then
    self._curIndex = 0
    for _, value in ipairs(self._allWidgets) do
      value:ReSet()
    end
  else
    self._curIndex = index
    for _, value in ipairs(self._allWidgets) do
      value:SetOffect(index)
    end
  end
  self:PreView(self._ids[self._curIndex])
end

function UISeasonMazeCard:ReSet()
  if self._allWidgets then
    self._curIndex = 0
    self:PreView(self._ids[self._curIndex])
    for _, value in ipairs(self._allWidgets) do
      value:ReSet()
    end
  end
end

function UISeasonMazeCard:PlayCard(playType)
  self._playType = playType
  self:Lock("UISeasonMazeCardPlayCard")
  self._playTask = self:StartTask(function(TT)
    local id = self._ids[self._curIndex]
    if id then
      if self._playType == SeasonMazeCardPlayType.Button then
        local cardWidget = self._allWidgets[self._curIndex]
        cardWidget:PlayBtnAnimation()
        YIELD(TT, 333)
        if not self.view then
          self:UnLock("UISeasonMazeCardPlayCard")
          return
        end
        cardWidget:RootAlpha(0)
        self._templateGO:SetActive(true)
        self._templateWidget:RootAlpha(1)
        self._templateWidget:QualityAlpha(1)
        self._templateWidget:SetData(self._curIndex, id, function()
        end, nil, false, nil, true)
        self._templateWidget:Mark(true)
        self._templateTransform.position = cardWidget:Position()
        self._playing = true
        self._time = 0
        self:_CalcBezierP()
        self._templateWidget:PlayAnim("uieff_UISeasonMazeCardItem_play")
        YIELD(TT, 300)
        if not self.view then
          self:UnLock("UISeasonMazeCardPlayCard")
          return
        end
        self:_TweenAnchorPosition(self._curIndex)
        self._templateWidget:PlayAnim("uieff_UISeasonMazeCardItem_play_out")
        YIELD(TT, 60)
        if not self.view then
          self:UnLock("UISeasonMazeCardPlayCard")
          return
        end
        SMazeAdaptor.PlayCard(id)
        self:_CloseRaycast()
        YIELD(TT, 1173)
        if not self.view then
          self:UnLock("UISeasonMazeCardPlayCard")
          return
        end
      elseif self._playType == SeasonMazeCardPlayType.Drag then
        self._templateWidget:Mark(true)
        self._templateWidget:QualityAlpha(1)
        self._templateWidget:PlayAnim("uieff_UISeasonMazeCardItem_play02_out")
        self:_TweenAnchorPosition(self._curIndex)
        YIELD(TT, 60)
        if not self.view then
          self:UnLock("UISeasonMazeCardPlayCard")
          return
        end
        SMazeAdaptor.PlayCard(id)
        self:_CloseRaycast()
        YIELD(TT, 1173)
        if not self.view then
          self:UnLock("UISeasonMazeCardPlayCard")
          return
        end
      end
      self._templateGO:SetActive(false)
    end
    self:UnLock("UISeasonMazeCardPlayCard")
  end, self)
end

function UISeasonMazeCard:_CloseRaycast()
  if self._allWidgets then
    for _, widget in ipairs(self._allWidgets) do
      widget:EnableRaycast(false)
    end
  end
end

function UISeasonMazeCard:_TweenAnchorPosition(index)
  if self._allWidgets then
    for _index, widget in ipairs(self._allWidgets) do
      local rectTransform = widget:RectTransform()
      if _index < index then
        self._tweener = rectTransform:DOAnchorPosX(rectTransform.anchoredPosition.x + 182.05, 0.3)
      elseif index < _index then
        self._tweener = rectTransform:DOAnchorPosX(rectTransform.anchoredPosition.x - 182.05, 0.3)
      end
    end
  end
end

function UISeasonMazeCard:BeadBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBead")
end

function UISeasonMazeCard:BagBtnOnClick(go)
  self:ShowDialog("UISeasonMazeBackPackController", 1)
end

function UISeasonMazeCard:_OnCardSettle(card)
  local cardWidget = self._allWidgets[self._curIndex]
  if cardWidget then
    cardWidget:OnPlayCard(card:ActPoint(), card:ResValue())
  end
end

function UISeasonMazeCard:PreView(id)
  SMazeAdaptor.OnChooseCard(id, id ~= nil)
end

function UISeasonMazeCard:_OnItemUseEnd(propType)
  if propType then
    if propType == SeasonMazeEffectType.SMET_Once_Shoe then
      self:_PlayAnimation(propType)
    elseif propType == SeasonMazeEffectType.SMET_Once_Sprint then
      self:_PlayAnimation(propType)
    elseif propType == SeasonMazeEffectType.SMET_Once_Retrun then
      self:SetData(nil, true)
    elseif propType == SeasonMazeEffectType.SMET_Once_Bomb then
    end
  end
end

function UISeasonMazeCard:_RefreshNew()
  local count = 0
  self._isUnlock = false
  local seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  local seasonMazeObj = seasonMazeModule:CurSeasonObj()
  if seasonMazeObj then
    local componentInfo = seasonMazeObj:GetComponentInfo(ECCampaignSeasonMazeComponentID.SEASON_MAZE)
    if componentInfo then
      if componentInfo.m_auto_bead_map then
        for _, value in pairs(componentInfo.m_auto_bead_map) do
          local data = value
          if data and data.bead_info.b_new then
            count = count + 1
          end
        end
      end
      local cfgs = Cfg.cfg_component_season_maze({
        Hard = componentInfo.hard
      })
      if cfgs and cfgs[1] then
        self._isUnlock = 0 < cfgs[1].BeadSlotCnt
      end
    end
  end
  if self._isUnlock then
    self._red:SetActive(count == 1)
    self._redCount:SetActive(1 < count)
    self._redCountValue:SetText(tostring(count))
    self:_CheckGuide()
  end
  self._beadBtn:SetActive(self._isUnlock)
end

function UISeasonMazeCard:OnBeginDrag(eventData, card)
  if self._idDraging then
    return
  end
  self._idDraging = true
  self._curDragCard = card
  self._templateTransform.position = card:Position()
  self._templateWidget:SetData(card:Index(), card:ID(), function()
  end, nil, false, nil, true)
  self._templateWidget:RootAlpha(1)
  self._templateWidget:QualityAlpha(1)
  self._templateWidget:Mark(true)
end

function UISeasonMazeCard:OnDrag(eventData)
  if self._idDraging and self._curDragCard then
    if not self._templateGO.activeSelf then
      self._templateGO:SetActive(true)
      self._templateWidget:PlayAnim("uieff_UISeasonMazeCardItem_play02_in")
      self._curDragCard:RootAlpha(0)
    end
    local position = self:ScreenPointToLocalPointInRectangle(self._gameObject.transform, eventData)
    self._templateTransform.localPosition = Vector3(position.x, position.y, 0)
    self._dragSucc = self:_OnDragCheck()
    if self._dragSucc and self._curIndex ~= self._curDragCard:Index() then
      self:_OnClickCard(self._curDragCard:Index())
    end
  end
end

function UISeasonMazeCard:OnDragEnd(eventData)
  if self._curDragCard then
    if self._dragSucc then
      self:_OnDragSucc()
    else
      self:_OnDragFail()
    end
    self._curDragCard = nil
  end
end

function UISeasonMazeCard:_OnDragCheck()
  return self._templateTransform.anchoredPosition.y > 300
end

function UISeasonMazeCard:OnReleased()
  self._idDraging = false
end

function UISeasonMazeCard:_OnDragSucc()
  self:PlayCard(SeasonMazeCardPlayType.Drag)
end

function UISeasonMazeCard:_OnDragFail()
  self:ReSet()
  self._templateGO:SetActive(false)
  self._playType = SeasonMazeCardPlayType.None
  if self._playTask then
    GameGlobal.TaskManager():KillTask(self._playTask)
    self._playTask = nil
  end
end

function UISeasonMazeCard:ScreenPointToLocalPointInRectangle(rect, eventData)
  local res, position = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(rect, eventData.position, eventData.pressEventCamera, nil)
  return position
end

function UISeasonMazeCard:_TempCloseRoom(isTempClose)
  if isTempClose then
    self._gameObject:SetActive(true)
    self._cardsGO:SetActive(false)
    self._black:SetActive(false)
    self._beadBtn:SetActive(self._isUnlock == true)
    self._bagBtn:SetActive(true)
    self._animation:Play("uieff_UISeasonMazeCard_in")
  elseif self._allWidgets then
    self._gameObject:SetActive(true)
    self._cardsGO:SetActive(true)
    self._black:SetActive(true)
    self._beadBtn:SetActive(self._isUnlock == true)
    self._bagBtn:SetActive(true)
  else
    self._gameObject:SetActive(false)
  end
end

function UISeasonMazeCard:OnApplicationFocus()
  if not EDITOR then
    if self._tweener then
      self._tweener:Kill()
      self._tweener = nil
    end
    self._templateGO:SetActive(false)
    self:ReSet()
  end
end

function UISeasonMazeCard:GetMiddleCard()
  if self._allWidgets and #self._allWidgets > 2 then
    return self._allWidgets[2]:GetMiddleCardBtnGo()
  end
end

function UISeasonMazeCard:_CheckGuide()
  self:Lock("UISeasonMazeCard_CheckGuide")
  self:StartTask(function(TT)
    YIELD(TT, 33)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UISeasonMazeBead)
    self:UnLock("UISeasonMazeCard_CheckGuide")
  end, self)
end

function UISeasonMazeCard:_PlayAnimation(propType)
  if self._allWidgets then
    if propType then
      if self._shoeTask then
        GameGlobal.TaskManager():KillTask(self._shoeTask)
        self._shoeTask = nil
      end
      if self._spriteTask then
        GameGlobal.TaskManager():KillTask(self._spriteTask)
        self._spriteTask = nil
      end
      if propType == SeasonMazeEffectType.SMET_Once_Shoe then
        self:Lock("UISeasonMazeCardAnimationShoe")
        self._shoeTask = self:StartTask(function(TT)
          local time = 0
          local count = 0
          for index, widget in ipairs(self._allWidgets) do
            local delayTime = (index - 1) * 30
            if 0 < delayTime then
              YIELD(TT, delayTime)
            end
            widget:PlayAnim("uianim_UISeasonMazeCardItem_running_shoes")
            YIELD(TT, 30)
            widget:PlayDiceAnimation()
            widget:RefreshDiceValue()
            widget:RefreshResValue()
            count = count + 1
          end
          time = 267 + (count - 1) * 30
          YIELD(TT, time)
          self:UnLock("UISeasonMazeCardAnimationShoe")
        end)
      elseif propType == SeasonMazeEffectType.SMET_Once_Sprint then
        self:Lock("UISeasonMazeCardAnimationSprint")
        self._spriteTask = self:StartTask(function(TT)
          self:SetData(nil, true)
          self:UnLock("UISeasonMazeCardAnimationSprint")
        end)
      end
    else
      self._animation:Stop()
      for _, widget in ipairs(self._allWidgets) do
        widget:StopAnim()
      end
    end
  end
end
