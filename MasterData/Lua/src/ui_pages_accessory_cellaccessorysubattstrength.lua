local this = class("cellAccessorySubAttStrength", G_UIModuleBase)
local unlockDesColor = "#4F525D"

function this.bind()
  return {
    isOn_lockDesc = false,
    txt_desc_lock = nil,
    txt_desc_unlock = nil,
    isOn_lockImg = false,
    color_lock = C_Color(0.06666666666666667, 0.10196078431372549, 0.13333333333333333, 0.2),
    active_noneBg = false,
    active_whiteBg = false,
    active_blueBg = false,
    active_blackBg = false,
    anchorsMax_blueBg = C_Vector2(1, 1)
  }
end

function this:refresh()
  self:initCell()
end

function this:initCell()
  if not self.isBind then
    return
  end
  self:clearTimer()
  if self.bind.index == self.bind.newUnlockIndex then
    self:newOrResetTimer("timer1", function()
      self.bindComponents.anim:Play("anim_AStrength_unlock")
      L_AudioUtil.playSound("Play_SFX_System_UI_Equipment_Unlock")
      self:newOrResetTimer("timer2", function()
        self.bind.active_blueBg = false
      end, 1)
      self:newOrResetTimer("timer3", function()
        self.bind.txt_desc_unlock = L_GameUtil.fillColor(self.bind.desc, unlockDesColor)
        self.bind.txt_desc_lock = self.bind.desc
      end, 0.165)
    end, 0.1)
    self.bind.isOn_lockDesc = not self.bind.bLock or self.bind.showHighLight
    self.bind.isOn_lockImg = self.bind.bLock
    local bgTabGroupId = self.bind.showBg and L_AccessoryConst.StrengthSubAttBgTabId.White or L_AccessoryConst.StrengthSubAttBgTabId.None
    if self.bind.bLock then
      bgTabGroupId = L_AccessoryConst.StrengthSubAttBgTabId.Grey
    end
    if self.bind.showHighLight then
      bgTabGroupId = L_AccessoryConst.StrengthSubAttBgTabId.Blue
    end
    self.bind.active_noneBg = bgTabGroupId == L_AccessoryConst.StrengthSubAttBgTabId.None
    self.bind.active_whiteBg = bgTabGroupId == L_AccessoryConst.StrengthSubAttBgTabId.White
    self.bind.active_blackBg = bgTabGroupId == L_AccessoryConst.StrengthSubAttBgTabId.Grey
  elseif self.bind.index == self.bind.unlockNextIndex then
    self:newOrResetTimer("timer4", function()
      self.bind.anchorsMax_blueBg = C_Vector2(0, 1)
      self.bind.active_blueBg = true
      self.bindComponents.anim:Play("anim_AStrength_unlock_next")
      self:newOrResetTimer("timer5", function()
        self.bind.active_blackBg = false
      end, 0.667)
    end, 0.785)
    self.bind.txt_desc_lock = self.bind.desc
    self.bind.txt_desc_unlock = L_GameUtil.fillColor(self.bind.desc, unlockDesColor)
    self.bind.isOn_lockDesc = not self.bind.bLock or self.bind.showHighLight
    self.bind.isOn_lockImg = self.bind.bLock
    local bgTabGroupId = self.bind.showBg and L_AccessoryConst.StrengthSubAttBgTabId.White or L_AccessoryConst.StrengthSubAttBgTabId.None
    if self.bind.bLock then
      bgTabGroupId = L_AccessoryConst.StrengthSubAttBgTabId.Grey
    end
    if self.bind.showHighLight then
      bgTabGroupId = L_AccessoryConst.StrengthSubAttBgTabId.Blue
    end
    self.bind.active_noneBg = bgTabGroupId == L_AccessoryConst.StrengthSubAttBgTabId.None
    self.bind.active_whiteBg = bgTabGroupId == L_AccessoryConst.StrengthSubAttBgTabId.White
    if self.bind.showHighLight then
      self.bindComponents.animLock:Play("anim_AStrength_unlock_lockloop")
    end
  else
    self.bind.txt_desc_lock = self.bind.desc
    self.bind.txt_desc_unlock = L_GameUtil.fillColor(self.bind.desc, unlockDesColor)
    self.bind.isOn_lockDesc = not self.bind.bLock or self.bind.showHighLight
    self.bind.isOn_lockImg = self.bind.bLock
    local bgTabGroupId = self.bind.showBg and L_AccessoryConst.StrengthSubAttBgTabId.White or L_AccessoryConst.StrengthSubAttBgTabId.None
    if self.bind.bLock then
      bgTabGroupId = L_AccessoryConst.StrengthSubAttBgTabId.Grey
    end
    if self.bind.showHighLight then
      bgTabGroupId = L_AccessoryConst.StrengthSubAttBgTabId.Blue
    end
    self.bind.active_noneBg = bgTabGroupId == L_AccessoryConst.StrengthSubAttBgTabId.None
    self.bind.active_whiteBg = bgTabGroupId == L_AccessoryConst.StrengthSubAttBgTabId.White
    self.bind.active_blueBg = bgTabGroupId == L_AccessoryConst.StrengthSubAttBgTabId.Blue
    self.bind.active_blackBg = bgTabGroupId == L_AccessoryConst.StrengthSubAttBgTabId.Grey
    if self.bind.showHighLight then
      self.bindComponents.animLock:Play("anim_AStrength_unlock_lockloop")
    end
  end
end

function this:clearTimer()
  self:stopTimer("timer1")
  self:stopTimer("timer2")
  self:stopTimer("timer3")
  self:stopTimer("timer4")
  self:stopTimer("timer5")
end

function this:close()
  self:clearTimer()
end

return this
