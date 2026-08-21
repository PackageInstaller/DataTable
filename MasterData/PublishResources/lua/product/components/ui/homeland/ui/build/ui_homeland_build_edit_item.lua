_class("UIHomelandBuildEditItem", UICustomWidget)
UIHomelandBuildEditItem = UIHomelandBuildEditItem

function UIHomelandBuildEditItem:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.mItem = GameGlobal.GetModule(ItemModule)
  self._isInit = nil
  self.beginPos = Vector2.zero
end

function UIHomelandBuildEditItem:OnShow()
  self.bg = self:GetGameObject("bg")
  self.imgIcon = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.txtLiveable = self:GetUIComponent("UILocalizationText", "txtLiveable")
  self.txtCount = self:GetUIComponent("UILocalizationText", "txtCount")
  self.txtUsing = self:GetUIComponent("UILocalizationText", "txtUsing")
  self.countGo = self:GetGameObject("count")
  self.using = self:GetGameObject("using")
  self.using:SetActive(false)
  self.new = self:GetGameObject("new")
  self.parent = self:GetGameObject("parent")
  self.child = self:GetGameObject("child")
  self.bNew = false
  self.pstID = nil
end

function UIHomelandBuildEditItem:Init(camera, listType)
  if self._isInit then
    return
  end
  self._isInit = true
  self.camera = camera
  self.listType = listType
  local etl = UICustomUIEventListener.Get(self.bg)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(eventData)
    self:SetPosDragItem(eventData.position)
    self.beginPos = eventData.position
    self:ClearNew()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(eventData)
    if self.goDragItem.activeInHierarchy then
      if self:CheckBlack() then
        self:SetPosDragItem(eventData.position)
        GameGlobal.EventDispatcher():Dispatch(GameEventType.DragBuildingIntoScene, self.id, eventData.pointerId, eventData.position)
      end
    elseif eventData.position.y > self.beginPos.y then
      local v2 = eventData.position - self.beginPos
      if self:CheckBlack() then
        self:ShowHideDragItem(true)
        self:FlushDragItem(self.id)
      end
    end
  end)
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(eventData)
    self:ShowHideDragItem(false)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
    if self:CheckBlack() then
      local cfg = Cfg.cfg_item_architecture[self.id]
      if cfg.SubType == ArchitectureSubType.Father_Architecture and self.homeBuildManager:GetBuildCount(self.id) <= 0 then
        self.homeBuildManager:FocusAndOutline(self.id)
      else
        self.homeBuildManager:Add(self.id)
      end
    end
    self:ClearNew()
  end)
end

function UIHomelandBuildEditItem:CheckBlack()
  if self.isBlack and self.listType == BuildEditListType.BT_MakeMovie then
    ToastManager.ShowToast(StringTable.Get("str_movie_build_is_black"))
    return false
  end
  return true
end

function UIHomelandBuildEditItem:OnHide()
  self.imgIcon:DestoryLastImage()
end

function UIHomelandBuildEditItem:Flush(id, isBlack)
  local inUsing = false
  self.id = id
  self.isBlack = isBlack
  local tpl = UIHomelandBuildEdit.GetItemTemplate(id)
  self.imgIcon:LoadImage(tpl.Icon)
  self.txtLiveable:SetText("+" .. UIHomelandBuildEdit.GetBuildingLiveable(id))
  local cfg = Cfg.cfg_item_architecture[id]
  if cfg.SubType == ArchitectureSubType.Father_Architecture then
    self.countGo:SetActive(false)
    self.parent:SetActive(true)
    self.child:SetActive(false)
    if self.homeBuildManager:GetBuildCount(self.id) <= 0 then
      inUsing = true
      self.txtUsing:SetText(StringTable.Get("str_homeland_build_placed"))
    end
  elseif cfg.SubType == ArchitectureSubType.Son_Architecture then
    self.parent:SetActive(false)
    self.child:SetActive(true)
    self.txtCount:SetText(StringTable.Get("str_homeland_build_mul_count", self.homeBuildManager:GetBuildCount(id)))
  else
    self.countGo:SetActive(true)
    self.parent:SetActive(false)
    self.child:SetActive(false)
    self.txtCount:SetText(StringTable.Get("str_homeland_build_mul_count", self.homeBuildManager:GetBuildCount(id)))
  end
  self.using:SetActive(inUsing)
  self:FlushNew()
end

function UIHomelandBuildEditItem:FlushNew()
  local items = self.mItem:GetItemByTempId(self.id)
  self.bNew = false
  for _, v in pairs(items) do
    if v:IsNewOverlay() then
      self.bNew = true
      self.pstID = v:GetID()
      break
    end
  end
  self.new:SetActive(self.bNew)
end

function UIHomelandBuildEditItem:ClearNew()
  if self.bNew then
    self:Lock("UIHomelandBuildEditItemClearNew")
    self:StartTask(function(TT)
      self.mItem:SetItemUnnewOverlay(TT, self.pstID)
      self.new:SetActive(false)
      GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandRefreshBuildFilterNew)
      self:UnLock("UIHomelandBuildEditItemClearNew")
    end)
  end
end

function UIHomelandBuildEditItem:SetDragItem(goDragItem, poolDragItem, dragItem)
  self.goDragItem = goDragItem
  self.poolDragItem = poolDragItem
  self.dragItem = dragItem
  self.dragItemParent = self.dragItem.parent:GetComponent("RectTransform")
end

function UIHomelandBuildEditItem:ShowHideDragItem(isShow)
  self.goDragItem:SetActive(isShow)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandShowHideDragItem, isShow)
end

function UIHomelandBuildEditItem:FlushDragItem(tplId)
  local ui = self.poolDragItem:SpawnObject("UIHomelandBuildEditDragItem")
  ui:Flush(self.id)
end

function UIHomelandBuildEditItem:SetPosDragItem(posScreen)
  local res, pos = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(self.dragItemParent, posScreen, self.camera, nil)
  self.dragItem.anchoredPosition = pos
end

function UIHomelandBuildEditItem:GetBg()
  return self.bg
end
