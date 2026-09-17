local module = class("cellIconTabItem", G_UIModuleBase)
local imgSignGradientColors = {
  [0] = "#b2c3cb",
  [1] = "#7de1d2",
  [2] = "#81c2f1",
  [3] = "#bc73ff",
  [4] = "#ffb853"
}
local iconStart = C_Vector2(58, 50)
local iconEquip = C_Vector2(40, 38)

function module.bind()
  return {
    img_icon = "",
    go_bg = nil,
    rect_icon = nil,
    go_iconFx = false
  }
end

function module:refresh()
  self:_disposeTextureHandle()
  if self.bindComponents.gradient ~= nil then
    local _, nextColor01 = C_ColorUtility.TryParseHtmlString(imgSignGradientColors[self.bind.rarity] .. "BF")
    self.bindComponents.gradient.LinearColor2 = nextColor01
  end
  if self.bind.isStarEq then
    local fxMaterial = self:_ensureFxMaterial()
    self:_clearFxTextures()
    self.bind.go_bg = false
    self.bind.rect_icon = iconStart
    self.bind.go_iconFx = true
    self.handle = C_LuaUtility.LoadTexture(self.bind.img_icon, function(maskTex)
      if fxMaterial == nil then
        return
      end
      fxMaterial:SetTexture("_MaskTex", maskTex)
      fxMaterial:SetTexture("_DissolveTex", maskTex)
    end)
  else
    self:_disposeFxMaterial()
    self.bind.go_bg = true
    self.bind.rect_icon = iconEquip
    self.bind.go_iconFx = false
  end
end

function module:unBind()
  self:_disposeFxRuntime()
  self.super.unBind(self)
end

function module:close()
  self:_disposeFxRuntime()
end

function module:_disposeTextureHandle()
  if L_CommonUtil.isValid(self.handle) and self.handle.IsValid then
    self.handle:Dispose()
  end
  self.handle = nil
end

function module:_getFxComponent()
  if L_CommonUtil.isValid(self.fxComponent) then
    return self.fxComponent
  end
  local bindComponentsCache = rawget(self, "bindComponentsCache")
  if bindComponentsCache ~= nil then
    local fx = bindComponentsCache.fx_ui_golden_equipment
    if L_CommonUtil.isValid(fx) then
      self.fxComponent = fx
      return fx
    end
  end
  local uiBinding = rawget(self, "uiBinding")
  if uiBinding == nil then
    return nil
  end
  local exist, fx = uiBinding.BindComponentMap:TryGetValue("fx_ui_golden_equipment")
  if not exist or not L_CommonUtil.isValid(fx) then
    return nil
  end
  self.fxComponent = fx
  if bindComponentsCache ~= nil then
    bindComponentsCache.fx_ui_golden_equipment = fx
  end
  return fx
end

function module:_ensureFxMaterial()
  local fx = self:_getFxComponent()
  if fx == nil then
    return nil
  end
  if self.fxMaterial ~= nil then
    return self.fxMaterial
  end
  self.originFxMaterial = self.originFxMaterial or fx.material
  if self.originFxMaterial == nil then
    return fx.material
  end
  self.fxMaterial = C_UnityObject.Instantiate(self.originFxMaterial)
  fx.material = self.fxMaterial
  return self.fxMaterial
end

function module:_clearFxTextures()
  if self.fxMaterial ~= nil then
    self.fxMaterial:SetTexture("_MaskTex", nil)
    self.fxMaterial:SetTexture("_DissolveTex", nil)
  end
end

function module:_disposeFxMaterial()
  local fx = self:_getFxComponent()
  self:_clearFxTextures()
  if self.fxMaterial ~= nil then
    if fx ~= nil and self.originFxMaterial ~= nil then
      fx.material = self.originFxMaterial
    end
    C_UnityObject.Destroy(self.fxMaterial)
    self.fxMaterial = nil
  end
  self.fxComponent = nil
end

function module:_disposeFxRuntime()
  self:_disposeTextureHandle()
  self:_disposeFxMaterial()
end

return module
