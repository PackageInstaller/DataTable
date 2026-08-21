_class("UISailingRewardBanner", UICustomWidget)
UISailingRewardBanner = UISailingRewardBanner

function UISailingRewardBanner:OnShow()
  self:InitWidget()
  self:InitScrollView()
end

function UISailingRewardBanner:OnHide()
  if self._scrollEvent then
    GameGlobal.Timer():CancelEvent(self._scrollEvent)
    self._scrollEvent = nil
  end
  self._matRes = {}
  if self._scrollPlayer and self._scrollPlayer:IsPlaying() then
    self._scrollPlayer:Stop()
  end
  self._scrollPlayer = nil
end

function UISailingRewardBanner:SetData()
end

function UISailingRewardBanner:InitWidget()
  self._module = self:GetModule(SailingMissionModule)
  self._cellArea1Go = self:GetGameObject("CellArea1")
  self._cellArea2Go = self:GetGameObject("CellArea2")
  local cellGen1 = self:GetUIComponent("UISelectObjectPath", "CellArea1")
  self._cellWidget1 = cellGen1:SpawnObject("UISailingRewardBannerItem")
  local cellGen2 = self:GetUIComponent("UISelectObjectPath", "CellArea2")
  self._cellWidget2 = cellGen2:SpawnObject("UISailingRewardBannerItem")
  self._cellCanvas1 = self:GetUIComponent("CanvasGroup", "CellArea1")
  self._cellCanvas2 = self:GetUIComponent("CanvasGroup", "CellArea2")
  self._cellRect1 = self:GetUIComponent("RectTransform", "CellArea1")
  self._cellRect2 = self:GetUIComponent("RectTransform", "CellArea2")
  self._anim = self:GetUIComponent("Animation", "UISailingRewardBanner")
  self._rollInterval = 5000
  local customCfg = Cfg.cfg_sailing_reward_custom[1]
  if customCfg and customCfg.RollInterval then
    self._rollInterval = customCfg.RollInterval
  end
end

function UISailingRewardBanner:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  table.insert(self._matRes, res)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UISailingRewardBanner:ScrollToIndex(tarIdx)
  if self._count <= 1 then
    return
  end
  if self._scrollIng then
    return
  end
  local oldIndex = self._currIdx
  local tmpIdx = tarIdx
  if tmpIdx > self._count then
    self._currIdx = tmpIdx % self._count
  elseif tmpIdx <= 0 then
    self._currIdx = self._count
  else
    self._currIdx = tmpIdx
  end
  for i = 1, #self._idxItems do
    self._idxItems[i]:Flush(self._currIdx)
  end
  self:_SetCellForAnim()
  self:_SetScrollCellData(self._cellWidget1, oldIndex)
  self:_SetScrollCellData(self._cellWidget2, self._currIdx)
  self:_PlayScrollAnim(oldIndex < self._currIdx)
  self:_CreateScrollEvent()
end

function UISailingRewardBanner:CheckDetailBtnOnClick(go)
  if self._curDetailItemID and self._curDetailItemID > 0 then
    local petModule = GameGlobal.GetModule(PetModule)
    if petModule:IsPetSkinID(self._curDetailItemID) then
      local skinId = petModule:GetSkinIDFromItemID(self._curDetailItemID)
      GameGlobal.UIStateManager():ShowDialog("UIPetSkinsMainController", PetSkinUiOpenType.PSUOT_TIPS, skinId)
      return
    end
    if petModule:IsPetID(self._curDetailItemID) then
      GameGlobal.UIStateManager():ShowDialog("UIShopPetDetailController", self._curDetailItemID)
      return
    end
  end
end

function UISailingRewardBanner:ImageLeftOnClick(go)
  if self._count <= 1 then
    return
  end
  local tmpIdx = self._currIdx - 1
  self:ScrollToIndex(tmpIdx)
end

function UISailingRewardBanner:ImageRightOnClick(go)
  if self._count <= 1 then
    return
  end
  local tmpIdx = self._currIdx + 1
  self:ScrollToIndex(tmpIdx)
end

function UISailingRewardBanner:InitScrollView()
  self._isDarging = false
  self._isScrollReady = false
  self:_CreateScrollData()
  self._currIdx = 1
  self:_CreateScrollItem()
  self:_CreateScrollEvent()
  self._isScrollReady = true
end

function UISailingRewardBanner:_CreateScrollData()
  self._carouselTab = {}
  self._cfg_banner = Cfg.cfg_sailing_reward_banner({})
  local count = table.count(self._cfg_banner)
  count = table.count(self._cfg_banner)
  self._count = count
  for i = 1, self._count do
    local cfg_item_middle = {}
    cfg_item_middle.idx = i + 1
    cfg_item_middle.data = self._cfg_banner[i]
    table.insert(self._carouselTab, cfg_item_middle)
  end
end

function UISailingRewardBanner:_CreateScrollItem()
  self._grid = self:GetUIComponent("UISelectObjectPath", "grid")
  self._grid:SpawnObjects("UISailingRewardBannerIdxItem", self._count)
  self._idxItems = self._grid:GetAllSpawnList()
  for i = 1, #self._idxItems do
    self._idxItems[i]:SetData(i, self._currIdx)
  end
  self._content = self:GetUIComponent("RectTransform", "Content")
  self._scroll = self:GetGameObject("scroll")
  self._height = 745
  self._targetPosY = self._currIdx * self._height
  local dataCount = #self._carouselTab
  if dataCount == 0 then
    self._scroll:SetActive(false)
    return
  end
  self:_SetScrollCellData(self._cellWidget1, 1)
  self:_SetCellForNormal()
end

function UISailingRewardBanner:_SetScrollCellData(cellWidget, dataIndex)
  cellWidget:SetData(self._carouselTab[dataIndex], function(cfgID)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.SailingOnProgressRewardBannerClick, cfgID)
  end, function(eventData)
    if self._count <= 1 then
      return
    end
    if self._scrollIng then
      return
    end
    self._bDragPosY = eventData.position.y
    self._isDarging = true
    if self._scrollEvent then
      GameGlobal.Timer():CancelEvent(self._scrollEvent)
      self._scrollEvent = nil
    end
  end, function(eventData)
    if self._count <= 1 then
      return
    end
  end, function(eventData)
    if self._count <= 1 then
      return
    end
    if not self._isDarging then
      return
    end
    local triggerRange = self._height * 0.1
    local tmpIdx = self._currIdx
    local idChanged = false
    self._eDragPosY = eventData.position.y
    local delta = math.abs(self._eDragPosY - self._bDragPosY)
    if self._eDragPosY > self._bDragPosY then
      if triggerRange < delta then
        tmpIdx = tmpIdx + 1
        idChanged = true
      else
      end
    else
      if triggerRange < delta then
        tmpIdx = tmpIdx - 1
        idChanged = true
      else
      end
    end
    local newIdx = tmpIdx
    if tmpIdx > self._count then
      newIdx = tmpIdx % self._count
    elseif tmpIdx <= 0 then
      newIdx = self._count
    else
      newIdx = tmpIdx
    end
    self._isDarging = false
    if idChanged then
      self:ScrollToIndex(newIdx)
    else
      self:_CreateScrollEvent()
    end
  end)
end

function UISailingRewardBanner:_CreateScrollEvent()
  local deltaTime = self._rollInterval
  local dir = 1
  if self._scrollEvent then
    GameGlobal.Timer():CancelEvent(self._scrollEvent)
    self._scrollEvent = nil
  end
  if 1 < self._count then
    self._scrollEvent = GameGlobal.Timer():AddEventTimes(deltaTime, TimerTriggerCount.Infinite, function()
      if not self._isDarging then
        local idx = self._currIdx
        if dir == 1 then
          idx = self._currIdx + 1
        else
          idx = self._currIdx - 1
        end
        if idx < 1 then
          idx = self._count
        elseif idx > self._count then
          idx = 1
        end
        for i = 1, #self._idxItems do
          self._idxItems[i]:Flush(idx)
        end
        self:ScrollToIndex(idx)
      end
    end)
  end
end

function UISailingRewardBanner:_SetCellForNormal()
  self._cellArea1Go:SetActive(true)
  self._cellArea2Go:SetActive(false)
  self._cellCanvas1.alpha = 1
  self._cellRect1.anchoredPosition = Vector2(0, 0)
  self._cellRect2.anchoredPosition = Vector2(0, 0)
end

function UISailingRewardBanner:_SetCellForAnim()
  self._cellArea1Go:SetActive(true)
  self._cellArea2Go:SetActive(true)
  self._cellRect1.anchoredPosition = Vector2(0, 0)
  self._cellRect2.anchoredPosition = Vector2(0, 0)
end

function UISailingRewardBanner:OnUpdate(deltaTimeMS)
  if self._isScrollReady and self._count <= 1 then
    return
  end
end

function UISailingRewardBanner:_PlayScrollAnim(bDown)
  local anim = self._anim
  local animName = "uieff_UISailingRewardBanner_cellarea1_upout"
  if not bDown then
    animName = "uieff_UISailingRewardBanner_cellarea1_downout"
  end
  if self._scrollPlayer then
    if self._scrollPlayer:IsPlaying() then
      self._scrollPlayer:Stop()
    end
    self._scrollPlayer = nil
  end
  self._scrollIng = true
  local player = EZTL_Player:New()
  local tl = EZTL_Sequence:New({
    EZTL_PlayAnimation:New(anim, animName),
    EZTL_Callback:New(function()
      self:_SetCellForNormal()
      self:_SetScrollCellData(self._cellWidget1, self._currIdx)
      self._scrollIng = false
    end)
  }, "动效")
  player:Play(tl)
  self._scrollPlayer = player
end
