_class("UIN22MedalEditBoardItem", UICustomWidget)
UIN22MedalEditBoardItem = UIN22MedalEditBoardItem

function UIN22MedalEditBoardItem:Constructor()
  self.mMedal = GameGlobal.GetModule(MedalModule)
  self.data = self.mMedal:GetN22MedalEditData()
  self.vecBeginDrag = Vector2.zero
end

function UIN22MedalEditBoardItem:OnShow()
  local go = self:GetGameObject()
  self.rt = go:GetComponent(typeof(UnityEngine.RectTransform))
  UICommonHelper:GetInstance():RectTransformAnchor2Center(self.rt)
  self.anim = go:GetComponent(typeof(UnityEngine.Animation))
  self.select = self:GetGameObject("select")
  self.select:SetActive(false)
  self.bg = self:GetGameObject("bg")
  self.imgMedal = self:GetUIComponent("Image", "imgMedal")
  self.goImgMedal = self:GetGameObject("imgMedal")
  self.atlas = self:GetAsset("UIMedal.spriteatlas", LoadType.SpriteAtlas)
  local etl = UICustomUIEventListener.Get(self.bg)
  self:AddUICustomEventListener(etl, UIEvent.BeginDrag, function(eventData)
    local camera = GameGlobal.UIStateManager():GetControllerCamera("UIN22MedalEdit")
    local posScreen = camera:WorldToScreenPoint(self.rt.position)
    self.vecBeginDrag = Vector2(posScreen.x, posScreen.y) - eventData.position
    self.ui:SetIsDraggingMedal(true)
    self.ui:SetCurBoardMedalId(self.id, self)
    self:SetIndexAsLast()
  end)
  self:AddUICustomEventListener(etl, UIEvent.Drag, function(eventData)
    self.ui:SetCurDragScreenPosition(eventData.position + self.vecBeginDrag)
  end)
  self:AddUICustomEventListener(etl, UIEvent.EndDrag, function(eventData)
    self.vecBeginDrag = Vector2.zero
    self.ui:SetIsDraggingMedal(false)
    self.ui:ClampBoardMedalUI(self.id)
  end)
  self:AddUICustomEventListener(etl, UIEvent.Click, function(go)
    self.ui:SetCurBoardMedalId(self.id, self)
    self:SetIndexAsLast()
  end)
end

function UIN22MedalEditBoardItem:OnHide()
  self.goModel = nil
  if self.taskId and self.taskId > 0 then
    GameGlobal.TaskManager():KillTask(self.taskId)
  end
end

function UIN22MedalEditBoardItem:Flush(id, ui)
  self.id = id
  self.ui = ui
  self.boardMedal = self.data:GetBoardMedalById(self.id)
  local sprite = UIN22MedalEditItem.GetSprite(self.atlas, self.boardMedal:IconMedal())
  self.imgMedal.sprite = sprite
  self:FlushWidthHeight()
  local posView = self:CalcPosViewByPos(self.boardMedal.pos)
  self:FlushPos(posView)
  self:FlushRot(self.boardMedal.quat)
  self.rt:SetSiblingIndex(self.boardMedal.index - 1)
  if IsUnityEditor() then
    self:GetGameObject().name = id .. self.boardMedal:IconMedal()
  end
end

function UIN22MedalEditBoardItem:FlushWidthHeight()
  local rect = self.imgMedal.sprite.rect
  self.boardMedal.wh = Vector2(rect.width, rect.height) * 0.36
  local whBoard = self.ui:GetBoardWidthHeight()
  self.rt.sizeDelta = self.data:GetScaledWidthHeight(whBoard.x, self.boardMedal.wh)
end

function UIN22MedalEditBoardItem:FlushPos(posView)
  self.rt.anchoredPosition = posView
  local whBoard = self.ui:GetBoardWidthHeight()
  local pos = self.data:GetScaledPosInverse(whBoard.x, posView)
  self.boardMedal.pos = pos
end

function UIN22MedalEditBoardItem:FlushRot(quat)
  self.boardMedal.quat = quat
  self.rt.localRotation = quat
end

function UIN22MedalEditBoardItem:FlushSelect(id)
  if id == self.id then
    self.select:SetActive(true)
    self.anim:Play("uieff_UIN22MedalEditBoardItem_in")
  elseif self:IsSelect() then
    self.taskId = self:StartTask(function(TT)
      local key = "uieff_UIN22MedalEditBoardItem_out"
      self:Lock(key)
      self.anim:Play("uieff_UIN22MedalEditBoardItem_out")
      YIELD(TT, 500)
      self.select:SetActive(false)
      self.taskId = 0
      self:UnLock(key)
    end, self)
  end
end

function UIN22MedalEditBoardItem:FlushSelectWithoutAnim(id)
  if id == self.id then
    self.select:SetActive(true)
  elseif self:IsSelect() then
    self.select:SetActive(false)
  end
end

function UIN22MedalEditBoardItem:IsSelect()
  return self.select.activeInHierarchy
end

function UIN22MedalEditBoardItem:CalcPosViewByPos(pos)
  local whBoard = self.ui:GetBoardWidthHeight()
  local posView = self.data:GetScaledPos(whBoard.x, pos)
  return posView
end

function UIN22MedalEditBoardItem:SetIndexAsLast()
  self.data:SinkMedalById(self.id)
  self.rt:SetAsLastSibling()
end

function UIN22MedalEditBoardItem:Id()
  return self.id
end

function UIN22MedalEditBoardItem:Position()
  return self.rt.position
end

function UIN22MedalEditBoardItem:AnchoredPosition()
  return self.rt.anchoredPosition
end

function UIN22MedalEditBoardItem:LocalPosition()
  return self.rt.localPosition
end

function UIN22MedalEditBoardItem:LocalRotation()
  return self.rt.localRotation
end

function UIN22MedalEditBoardItem:AABB()
  local aabb = UIN22MedalEdit.GetAABBOfRectTransform(self.rt)
  return aabb
end
