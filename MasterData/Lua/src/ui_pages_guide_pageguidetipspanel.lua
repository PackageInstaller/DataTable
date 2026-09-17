local this = class("pageGuideTipsPanel", G_UIPageBase)

function this.bind()
  return {
    tipText = "",
    keyList = {
      moduleName = "pages/Guide/cellKeyIcon"
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:updateUI(options)
end

function this:open(options)
end

function this:updateUI(options)
  self.bind.tipText = options.showTips
  self.bind.keyList:clear()
  local keyData = {}
  for _, key in ipairs(options.showKeys) do
    if not string.isEmpty(key) then
      table.insert(keyData, {keyText = key})
    end
  end
  for _, key in ipairs(options.specialIcons) do
    if not string.isEmpty(key) then
      table.insert(keyData, {iconIndex = key, isIcon = true})
    end
  end
  self.bind.keyList:insert_array(keyData)
  if not string.isEmpty(options.gamepadKey) then
    L_ShortCutManager:addShortKeyFlag(self, options.gamepadKey, L_Const.AnchorType.Middle, self.bindComponents.keyGamepadRect)
  end
end

function this:update()
end

function this:fixTextBackground()
  if self.fixedText then
    return
  end
  local size = self.bindComponents.tipTextRect.sizeDelta
  if size.x <= 0 then
    return
  end
  local bgSize = C_Vector2(size.x + 100, 70)
  if size.x < 457 then
    bgSize = C_Vector2(557, 70)
  end
  if self.bind.normalSizeDelta.x == bgSize.x or self.bind.emphasizeSizeDelta.x == bgSize.x then
    return
  end
  self.bind.emphasizeSizeDelta = bgSize
  self.bind.normalSizeDelta = bgSize
  self.fixedText = true
end

function this:refreshInfo(options)
  self.bind.tipText = options.showTips
end

function this:close()
  L_ShortCutManager:clearShortKeyFlag(self)
end

return this
