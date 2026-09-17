local this = class("moduleColorPick", G_UIModuleBase)
local inner = 133
local outer = 175
local mid = (inner + outer) / 2
local ColorUtility = CS.Lens.Gameplay.Utility.HSVColorUtility

function this.bind()
  return {
    pos_handleHue = nil,
    pos_handleColor = nil,
    color_img = nil,
    hueColor_img = nil,
    dragColor_img = nil,
    go_paste = nil
  }
end

function this.methods()
  return {
    onBeginDrag_hue = function(self, screenPos)
      self:beginDrag_hue(screenPos)
    end,
    onDrag_hue = function(self, screenPos)
      self:onDrag_hue(screenPos)
    end,
    onDrag_color = function(self, screenPos)
      self:onDrag_color(screenPos)
    end,
    onClick_hue = function(self)
      local screenPos = Unity.Input.mousePosition
      self:onDrag_hue(screenPos)
    end,
    onClick_color = function(self)
      local screenPos = Unity.Input.mousePosition
      self:onDrag_color(screenPos)
    end,
    onInput_color = function(self, str)
      self:setColorByStr(str)
    end,
    onClick_copy = function(self)
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("ui_moduleColorPick"))
      Unity.GUIUtility.systemCopyBuffer = self.bindComponents.input_color.text
    end,
    onClick_paste = function(self)
      self.bindComponents.input_color.text = Unity.GUIUtility.systemCopyBuffer
    end
  }
end

function this:open()
  self.colorPanelWidth = self.bindComponents.colorPanel.rect.size.x
  self.colorPanelHeight = self.bindComponents.colorPanel.rect.size.y
  self.colorPanelLimitX = self.colorPanelWidth / 2
  self.colorPanelLimitY = self.colorPanelHeight / 2
  self.circleMt = C_UnityObject.Instantiate(self.bindComponents.img_hueCircle.material)
  self.colorMt = C_UnityObject.Instantiate(self.bindComponents.img_colorPanel.material)
  self.bindComponents.img_colorPanel.material = self.colorMt
  self.bindComponents.img_hueCircle.material = self.circleMt
  self.circleMt:SetFloat("_RadiusInner", inner / outer * 0.5)
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    self.bind.go_paste = false
  end
end

function this:initColor(color)
  self:setColor(color)
  self:refreshColorUI()
end

function this:refresh()
end

function this:close()
  self.skipEmit = nil
  if self.circleMt then
    C_UnityObject.Destroy(self.circleMt)
  end
  if self.colorMt then
    C_UnityObject.Destroy(self.colorMt)
  end
end

function this:beginDrag_hue(screenPos)
  local pos = L_Vector3.screenToLocalInRectangle(self.bindComponents.hueCircle, screenPos)
  local dis = math.sqrt(pos.x ^ 2 + pos.y ^ 2)
  if dis >= inner and dis <= outer then
    self.isDraggingHue = true
  else
    self.isDraggingHue = false
  end
end

function this:onDrag_hue(screenPos)
  if not self.isDraggingHue then
    return
  end
  local pos = L_Vector3.screenToLocalInRectangle(self.bindComponents.hueCircle, screenPos)
  pos.z = 0
  local dir = pos:calNormalized()
  local targetP = L_Vector3.new(dir.x * mid, dir.y * mid)
  self.bind.pos_handleHue = targetP:toUnityV2()
  local angle = C_Vector2.Angle(targetP:toUnityV2(), C_Vector2.right)
  if 0 > targetP.y then
    angle = 360 - angle
  end
  self.hueAngle = angle
  self:calRGBColor()
  self:setHexColor()
  self.bind.color_img = self.color
  self.bind.dragColor_img = self.color
  self:refreshColorPalate()
end

function this:onDrag_color(screenPos)
  local pos = L_Vector3.screenToLocalInRectangle(self.bindComponents.hueCircle, screenPos)
  local width = self.colorPanelWidth
  local height = self.colorPanelHeight
  local xLimit = self.colorPanelLimitX
  local yLimit = self.colorPanelLimitY
  pos.x = math.clamp(pos.x, -xLimit, xLimit)
  pos.y = math.clamp(pos.y, -yLimit, yLimit)
  self.bind.pos_handleColor = pos:toUnityV2()
  pos.x = pos.x + xLimit
  pos.y = pos.y + yLimit
  self.colorS = pos.x / width
  self.colorV = pos.y / height
  self:calRGBColor()
  self:setHexColor()
  self.bind.color_img = self.color
  self.bind.dragColor_img = self.color
end

function this:calRGBColor()
  local color = ColorUtility.HSVToRGB(self.hueAngle, self.colorS, self.colorV)
  self.color = color
  self:onColorChange()
  return color
end

function this:setHexColor()
  local hexColor = C_ColorUtility.ToHtmlStringRGB(self.color)
  self.bindComponents.input_color:SetTextWithoutNotify(hexColor)
end

function this:setColorByStr(str)
  if not str or #str ~= 6 then
    return
  end
  str = "#" .. str
  local r, c = C_ColorUtility.TryParseHtmlString(str)
  if r then
    self:setColor(c)
    self:onColorChange()
    self:refreshColorUI()
  else
  end
end

function this:refreshColorUI()
  local radian = self.hueAngle * Mathf.Deg2Rad
  local x = Mathf.Cos(radian)
  local y = Mathf.Sin(radian)
  local dir = C_Vector2(x, y)
  local pos = dir * mid
  self.bind.pos_handleHue = pos
  local width = self.colorPanelWidth
  local height = self.colorPanelHeight
  local xLimit = self.colorPanelLimitX
  local yLimit = self.colorPanelLimitY
  local targetX = width * self.colorS - xLimit
  local targetY = height * self.colorV - yLimit
  self.bind.pos_handleColor = C_Vector2(targetX, targetY)
  self.bind.color_img = self.color
  self.bind.dragColor_img = self.color
  self:setHexColor()
  self:refreshColorPalate()
end

function this:refreshColorPalate()
  local color = ColorUtility.HSVToRGB(self.hueAngle, 1, 1)
  self.colorMt:SetColor("_Color", color)
  self.bind.hueColor_img = color
end

function this:onColorCircleChange(_inner, _outer)
  inner = _inner
  outer = _outer
  mid = (inner + outer) / 2
  self.circleMt:SetFloat("_RadiusInner", inner / outer * 0.5)
end

function this:setColor(color)
  self.color = color
  local hsvColor = ColorUtility.RGBToHSV(color)
  local h, s, v = hsvColor.h, hsvColor.s, hsvColor.v
  self.hueAngle = h
  self.colorS = s
  self.colorV = v
end

function this:onColorChange()
  if not self.isBind then
    return
  end
  self:emit("onColorChange", self.color)
  if self.onColorChangeFunc then
    self.onColorChangeFunc(C_ColorUtility.ToHtmlStringRGB(self.color))
  end
end

function this:SetOnColorChange(func)
  self.onColorChangeFunc = func
end

return this
