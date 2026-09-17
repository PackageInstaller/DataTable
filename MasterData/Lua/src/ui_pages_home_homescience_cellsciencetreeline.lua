local this = class("cellScienceTreeLine", G_UIModuleBase)
local colorLockStar = C_LuaUtility.ParseHtmlStringColor("#c9bcaf")
local colorCanUpgrade = C_LuaUtility.ParseHtmlStringColor("#A78B71")
local colorLevelMax = C_LuaUtility.ParseHtmlStringColor("#86CA5E")

function this.bind()
  return {
    anchoredPosition = nil,
    listStar = {},
    activeLineL = false,
    activeLineLPointL = false,
    activeLineLPointR = false,
    activeLineLMiddle = false,
    activeLineLL = false,
    activeLineLR = false,
    activeLineR = false,
    activeLineRL = false,
    activeLineRPointL = false,
    activeLineRVerticalUp = false,
    activeLineRVerticalDashedUp = false,
    activeLineRVerticalDown = false,
    activeLineRVerticalDashedDown = false,
    colorLineLPointL = nil,
    colorLineLPointR = nil,
    colorLineLL = nil,
    colorLineLR = nil,
    colorLineLMiddle = nil,
    colorLineRPointL = nil,
    colorLineRL = nil,
    colorLineRVerticalUp = nil,
    colorLineRVerticalDashedUp = nil,
    colorLineRVerticalDown = nil,
    colorLineRVerticalDashedDown = nil
  }
end

function this:open()
  self.super.open(self)
  self.gameObject.name = tostring(self.bind.techTreeId)
  self:refreshLine()
  self:refreshStar()
  self:setPreLineColor()
  self:setRightLineStarColor()
end

function this:refreshLine()
  if self.bind.widthLineRVerticalUp then
    local trans = self.bind.activeLineRVerticalUp and self.bindComponents.transLineRVerticalUp or self.bindComponents.transLineRVerticalDashedUp
    self:setWidth(trans, self.bind.widthLineRVerticalUp)
  end
  if self.bind.widthLineRVerticalDown then
    local trans = self.bind.activeLineRVerticalDown and self.bindComponents.transLineRVerticalDown or self.bindComponents.transLineRVerticalDashedDown
    self:setWidth(trans, self.bind.widthLineRVerticalDown)
  end
  if self.bind.widthLineL then
    self:setWidth(self.bindComponents.transLineL, self.bind.widthLineL)
  end
end

function this:refreshStar()
  if self.bind.activeLineLMiddle then
    self.bind.colorLineLMiddle = self.bind.starColor
  end
  if self.bind.starPosList then
    self.bind.listStar:clear()
    self.bind.listStar:insert_array(L_DataUtil.getEmptyModuleDatas(#self.bind.starPosList))
    for i = 1, #self.bind.starPosList do
      self.modules.listStar[i].bindComponents.trans.anchoredPosition = self.bind.starPosList[i]
      self.modules.listStar[i].bindComponents.image.color = self.bind.starColor
    end
  end
end

function this:setWidth(trans, width)
  local y = trans.sizeDelta.y
  trans.sizeDelta = C_Vector2(width, y)
end

function this:setPivotX(trans, pivotX, isRot)
  local y = trans.pivot.y
  trans.pivot = C_Vector2(pivotX, y)
  local pos = trans.anchoredPosition
  if isRot then
    pos.y = 0
  else
    pos.x = 0
  end
  trans.anchoredPosition = pos
end

function this:setPreLineColor()
  local color = self.bind.lineColor
  if self.bind.activeLineLL then
    self.bind.colorLineLL = color
  end
  if self.bind.activeLineLR then
    self.bind.colorLineLR = color
  end
end

function this:setRightLineStarColor()
  if not self.bind.activeLineR then
    return
  end
  for _, v in ipairs(self.modules.listStar) do
    if v.bindComponents.trans.anchoredPosition.y == 0 then
      v.bindComponents.image.color = self.bind.colorLineRL or colorLockStar
    elseif v.bindComponents.trans.anchoredPosition.y > 0 then
      v.bindComponents.image.color = self.bind.colorLineRVerticalUp or colorLockStar
    else
      v.bindComponents.image.color = self.bind.colorLineRVerticalDown or colorLockStar
    end
  end
end

return this
