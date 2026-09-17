local this = class("cellPointItem", G_UIModuleBase)
local _screenPosToUI = Unity.RectTransformUtility.ScreenPointToLocalPointInRectangle
local time = 0.06

function this.bind()
  return {
    obj = false,
    bg = false,
    ringBg = true,
    icon = "",
    pos = C_Vector3(0, 0, 0),
    sureGroup = false,
    deletedGroup = false,
    sureGroupPos = C_Vector3(0, 0, 0),
    deletedGroupPos = C_Vector3(0, 0, 0),
    bShowTrace = false,
    scale = C_Vector3(1, 1, 1),
    raycast = true
  }
end

function this.methods()
  return {
    onClick_sure = function(self)
      Timer.once(time, function()
        self:emit("onClick_sure", self.bind)
      end)
    end,
    onClick_cancel = function(self)
      Timer.once(time, function()
        self:emit("onClick_cancel", self.bind)
      end)
    end,
    onClick_deleted = function(self)
      Timer.once(time, function()
        self:emit("onClick_deleted", self.bind)
      end)
    end,
    onClick_point = function(self)
      if self.bind.type == 0 then
        if self.bind.sureGroup then
        else
          self.bind.bg = true
          self.bind.deletedGroup = true
        end
      else
        self:emit("onClick_point", self.bind.guid, self.bind.id, self.bind.pos)
      end
    end,
    onClick_trace = function(self)
      self:emit("onClick_trace", self.bind)
    end
  }
end

function this:Destroy()
  C_GameObject.Destroy(self.bindComponents.cellAnim.gameObject)
end

function this:refresh()
  self.bindComponents.icon:SetNativeSize()
  self:setPosSpecial()
  self:setPositionChoices()
  if self.bind.bAnim then
    self.bind.bAnim = false
    self.bindComponents.cellAnim:Stop()
    self.bindComponents.cellAnim:Play("anim_tipnode_tag")
  end
  if self.bind.bNew then
    self.bind.bNew = false
    self.bindComponents.anim:CrossFade("anim_tipnode_down", 0)
  end
end

function this:playChangeAnim()
  self.bindComponents.anim:Stop()
  self.bindComponents.anim:CrossFade("anim_mappointitem_icon_in", 0)
end

function this:setPositionChoices()
  local xDelta, yDelta = 0, 0
  local ldScreen = C_CameraManager.uiCamera:WorldToScreenPoint(self.bindComponents.ld.position)
  local ruScreen = C_CameraManager.uiCamera:WorldToScreenPoint(self.bindComponents.ru.position)
  local minScreen = C_CameraManager.uiCamera:WorldToScreenPoint(self.bind.rectSafeLd.position)
  local maxScreen = C_CameraManager.uiCamera:WorldToScreenPoint(self.bind.rectSafeRu.position)
  if ldScreen.x < minScreen.x then
    xDelta = minScreen.x - ldScreen.x
  end
  if ldScreen.y < minScreen.y then
    yDelta = minScreen.y - ldScreen.y
  end
  if ruScreen.x > maxScreen.x then
    xDelta = maxScreen.x - ruScreen.x
  end
  if ruScreen.y > maxScreen.y then
    yDelta = maxScreen.y - ruScreen.y
  end
  self.bind.sureGroupPos = C_Vector3(xDelta, yDelta, 0)
  self.bind.deletedGroupPos = C_Vector3(xDelta, yDelta, 0)
end

function this:setPosSpecial()
  if self.bind.id ~= L_Const.mapNavPointId then
    return
  end
  local guid = self.bind.guid
  local bTracing = L_MapStore:getTracing(guid)
  if not bTracing then
    return
  end
  self:modifySelfSetNodeOutScreen()
end

function this:modifySelfSetNodeOutScreen()
  local pinScreenPos = C_CameraManager.uiCamera:WorldToScreenPoint(self.bindComponents.rectSelf.position)
  local bNeedModify, inter = self:calcScreenEdgeIntersection(C_Vector2(pinScreenPos.x, pinScreenPos.y))
  if bNeedModify then
    local pinWorldPos = C_CameraManager.uiCamera:ScreenToWorldPoint(C_Vector3(inter.x, inter.y, self.bindComponents.rectSelf.position.z))
    self.bindComponents.rectSelf.position = pinWorldPos
  end
end

function this:calcScreenEdgeIntersection(pTar)
  local showRectMin = C_Vector2(100, 100)
  local showRectMax = C_Vector2(Unity.Screen.width - 100, Unity.Screen.height - 100)
  local centerRectPos = showRectMin + (showRectMax - showRectMin) / 2
  local v2Delta = pTar - centerRectPos
  local bNeedModify = pTar.x > showRectMax.x or pTar.y > showRectMax.y or pTar.x < showRectMin.x or pTar.y < showRectMin.y
  if not bNeedModify then
    return false
  end
  if v2Delta.x == 0 then
    return true, C_Vector2(centerRectPos.x, v2Delta.y > 0 and showRectMax.y or 0)
  elseif v2Delta.y == 0 then
    return true, C_Vector2(v2Delta.x > 0 and showRectMax.x or 0, centerRectPos.y)
  end
  local x1, y1 = centerRectPos.x, centerRectPos.y
  local x2, y2 = pTar.x, pTar.y
  local x, y
  if v2Delta.x > 0 then
    x = showRectMax.x
  else
    x = showRectMin.x
  end
  y = y1 + (y1 - y2) * (x - x1) / (x1 - x2)
  local inter1 = C_Vector2(x, y)
  if v2Delta.y > 0 then
    y = showRectMax.y
  else
    y = showRectMin.y
  end
  x = x1 + (x1 - x2) * (y - y1) / (y1 - y2)
  local inter2 = C_Vector2(x, y)
  local res = inter1
  if math.abs((inter2 - centerRectPos).x) < math.abs((res - centerRectPos).x) then
    res = inter2
  end
  return true, res
end

function this:getNodeScreenPos(parent)
  local cellPos = self.bindComponents.rectSelf.position
  local screenPos_cell = C_CameraManager.uiCamera:WorldToScreenPoint(cellPos)
  local v2 = L_Vector3.new(screenPos_cell.x, screenPos_cell.y)
  local parent = parent
  local _, uiPos = _screenPosToUI(parent, v2, C_CameraManager.uiCamera)
  return uiPos
end

function this:setIsChoose(bChoose)
  if bChoose then
    self.bind.bg = true
  else
    self.bind.bg = false
  end
end

function this:destroy()
end

return this
