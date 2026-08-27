local UINFloatUINode = class("UINFloatUINode", UIBaseNode)
local base = UIBaseNode
local cs_Screen = CS.UnityEngine.Screen
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINFloatUINode:OnInit()
  self.oldtargetTransform = nil
  self.oldtargetScreenConers = nil
end

function UINFloatUINode:FloatTo(transform, horizontalAlign, verticalAlign, shiftX, shiftY, customTargetCamer)
  shiftX = shiftX or 0
  shiftY = shiftY or 0
  local x = 0
  local y = 0
  local pivotx = 0.5
  local pivoty = 0.5
  local targetScreenConers = {}
  if transform == nil then
    local mousePos = CS.InputUtility.MousePosition
    for i = 1, 4 do
      targetScreenConers[i] = UIManager:Screen2UIPosition(mousePos, nil, nil)
    end
    self.oldtargetScreenConers = nil
    self.oldtargetTransform = nil
  elseif self.oldtargetTransform == transform then
    targetScreenConers = self.oldtargetScreenConers
  else
    local targetWorldConersArray = transform:ExGetWorldCorners()
    for i = 0, targetWorldConersArray.Length - 1 do
      if targetWorldConersArray[i] ~= nil then
        targetScreenConers[i + 1] = UIManager:World2UIPosition(targetWorldConersArray[i], nil, UIManager.UICamera, customTargetCamer or UIManager.UICamera)
      end
    end
    self.oldtargetScreenConers = targetScreenConers
    self.oldtargetTransform = transform
  end
  if horizontalAlign == HAType.left then
    x = targetScreenConers[1].x + shiftX
    pivotx = 0
  elseif horizontalAlign == HAType.right then
    x = targetScreenConers[4].x + shiftX
    pivotx = 1
  elseif horizontalAlign == HAType.center then
    x = (targetScreenConers[1].x + targetScreenConers[4].x) / 2 + shiftX
    pivotx = 0.5
  elseif horizontalAlign == HAType.autoCenter then
    x = (targetScreenConers[1].x + targetScreenConers[4].x) / 2 + shiftX
    pivotx = 0.5
    local screenMiddlePointX = x
    local leftX = screenMiddlePointX - self.transform.sizeDelta.x / 2
    local rightX = screenMiddlePointX + self.transform.sizeDelta.x / 2
    local helfScreen = UIManager.BackgroundStretchSize.x / 2
    if leftX < -helfScreen then
      x = targetScreenConers[1].x + shiftX
      pivotx = 0
    elseif rightX > helfScreen then
      x = targetScreenConers[4].x + shiftX
      pivotx = 1
    end
  elseif horizontalAlign == HAType.autoTightLeft then
    x = targetScreenConers[1].x + shiftX
    pivotx = 1
    local helfScreen = UIManager.BackgroundStretchSize.x / 2
    if targetScreenConers[1].x - self.transform.sizeDelta.x < -helfScreen then
      x = targetScreenConers[4].x + shiftX
      pivotx = 0
    end
  elseif horizontalAlign == HAType.autoTightRight then
    x = targetScreenConers[4].x + shiftX
    pivotx = 0
    local helfScreen = UIManager.BackgroundStretchSize.x / 2
    if helfScreen < targetScreenConers[4].x + self.transform.sizeDelta.x then
      x = targetScreenConers[1].x - shiftX
      pivotx = 1
    end
  end
  if verticalAlign == VAType.up then
    y = targetScreenConers[2].y + shiftY
    local upY = y + self.transform.sizeDelta.y
    local helfScreen = UIManager.BackgroundStretchSize.y / 2
    if upY > helfScreen then
      y = helfScreen - self.transform.sizeDelta.y
    end
    pivoty = 0
  elseif verticalAlign == VAType.down then
    y = targetScreenConers[1].y + shiftY
    local downY = y - self.transform.sizeDelta.y
    local helfScreen = UIManager.BackgroundStretchSize.y / 2
    if downY < -helfScreen then
      y = -helfScreen + self.transform.sizeDelta.y
    end
    pivoty = 1
  elseif verticalAlign == VAType.downAuto then
    y = targetScreenConers[1].y + shiftY
    local downY = y - self.transform.sizeDelta.y
    local helfScreen = UIManager.BackgroundStretchSize.y / 2
    if downY < -helfScreen then
      y = targetScreenConers[2].y + shiftY
      pivoty = 0
    else
      pivoty = 1
    end
  elseif verticalAlign == VAType.autoAlignDown then
    y = targetScreenConers[1].y + shiftY
    pivoty = 0
    local helfScreen = UIManager.BackgroundStretchSize.y / 2
    if helfScreen < targetScreenConers[1].y + self.transform.sizeDelta.y then
      y = targetScreenConers[2].y + shiftY
      pivoty = 1
    end
  elseif verticalAlign == VAType.autoAlignUp then
    y = targetScreenConers[2].y + shiftY
    pivoty = 1
    local helfScreen = UIManager.BackgroundStretchSize.y / 2
    if targetScreenConers[2].y - self.transform.sizeDelta.y < -helfScreen then
      y = targetScreenConers[1].y + shiftY
      pivoty = 0
    end
  elseif verticalAlign == VAType.center then
    y = (targetScreenConers[1].y + targetScreenConers[2].y) / 2 + shiftY
    pivoty = 0.5
  end
  local parent = self.transform.parent
  if parent ~= nil then
    self.transform:SetParent(UIManager.UICanvas.transform)
  end
  self.transform.pivot = Vector2.New(pivotx, pivoty)
  self.transform.localPosition = Vector2.New(x, y)
  if parent ~= nil then
    self.transform:SetParent(parent)
  end
end

function UINFloatUINode:AutoFlotTo(transform, judgeWorldPoint)
end

return UINFloatUINode
