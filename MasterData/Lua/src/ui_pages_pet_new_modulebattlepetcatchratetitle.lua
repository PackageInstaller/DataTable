local this = class("moduleBattlePetCatchRateTitle", G_UIModuleBase)
local _enemyTpl = L_GameTpl:getEnemyTpl()
local _petTpl = L_GameTpl:getPetTpl()
local _foodTpl = L_GameTpl:getFoodTpl()
local _petCatchItemTpl = L_GameTpl:getPetCatchItemTpl()
local _colorType = {
  GREEN = 1,
  YELLOW = 2,
  RED = 3
}

function this.bind()
  return {
    txt_rate_value = "",
    color_desTxt = C_Color.white,
    color_bg = C_Color.white
  }
end

function this.methods()
end

function this:open()
end

function this:setData(rateValue)
  if rateValue ~= self.rateValue then
    self:doTxtRate(rateValue)
    if self.rateValue ~= nil and rateValue ~= math.floor(self.rateValue * 10 + 0.5) / 10 then
      C_AudioManager.Play("Play_SFX_System_UI_CatchLens_Probability")
    end
  else
    self:refreshRate(rateValue)
  end
end

function this:setTxtRate(rateValue)
  self.rateValue = rateValue
  self:refreshRate(rateValue)
end

function this:refreshRate(rateValue)
  if 100 <= rateValue then
    self.bind.txt_rate_value = ("%s%%"):format(tostring(100))
  elseif math.abs(rateValue) >= 1 then
    self.bind.txt_rate_value = ("%.1f%%"):format(rateValue)
  else
    self.bind.txt_rate_value = ("%.2f%%"):format(rateValue)
  end
  self:RefreshColor(rateValue)
end

local colorStrMap = {
  [_colorType.GREEN] = {"#3bcea2", "#3bcea2"},
  [_colorType.YELLOW] = {"#e78739", "#ff9c00"},
  [_colorType.RED] = {"#da796e", "#ff7161"}
}

function this:RefreshColor(rateValue)
  local battleConfig = C_BattleConfigManager.Data
  local colorType
  if rateValue < battleConfig.catchYellowColor then
    colorType = _colorType.RED
  elseif rateValue >= battleConfig.catchYellowColor and rateValue < battleConfig.catchGreenColor then
    colorType = _colorType.YELLOW
  else
    colorType = _colorType.GREEN
  end
  if self.lastColorType and self.lastColorType == colorType then
    return
  end
  self.lastColorType = colorType
  local colorStrs = colorStrMap[colorType]
  local colorStr1 = colorStrs[1]
  local colorStr2 = colorStrs[2]
  local _, outlineColor = C_ColorUtility.TryParseHtmlString(colorStr1)
  local _, glowColor = C_ColorUtility.TryParseHtmlString(colorStr1)
  local _, color = C_ColorUtility.TryParseHtmlString(colorStr2)
  self.bind.color_desTxt = color
  self.bind.color_bg = color
  self.bindComponents.Text_rate.style.outlineColor = outlineColor
  self.bindComponents.Text_rate.style.glowColor = glowColor
  self.bindComponents.Text_rate:RefreshStyle()
end

function this:doTxtRate(rateValue)
  if self.doTxtTween then
    self.doTxtTween:Kill()
    self.doTxtTween = nil
  end
  
  local function getter()
    return self.rateValue or 0
  end
  
  local function setter(v)
    self.rateValue = v
    self:refreshRate(v)
  end
  
  local time = 0.5
  local ease = self:getAnimCurve()
  self.doTxtTween = DOTween.To(getter, setter, rateValue, time):SetEase(ease):OnComplete(function()
    self:refreshRate(rateValue)
  end)
end

function this:getAnimCurve()
  local ease = Tweening.Ease.OutQuad
  if not self.isBind then
    return ease
  end
  local curveHolder = self.bindComponents.animCurveHolder
  if curveHolder ~= nil and curveHolder.curves.Count > 0 then
    return curveHolder.curves[0]
  end
  return ease
end

function this:close()
  if self.doTxtTween then
    self.doTxtTween:Kill()
    self.doTxtTween = nil
  end
end

return this
