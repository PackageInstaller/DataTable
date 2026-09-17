local module = class("cellQuickBoxItem", G_UIModuleBase)

function module:ctor(...)
  module.super.ctor(self, ...)
  self.isSelected = false
  self.isInFilter = false
  self.petCount = 0
  self.totalSlots = 0
end

function module.bind()
  return {
    activeCell = false,
    activeSelect = false,
    activeNormal = true,
    activeFullTips = true,
    txtNum1 = "",
    txtNum2 = "",
    txtPetIndex = ""
  }
end

function module.methods()
  return {
    onPointEnter_hitArea = function(self)
      if self.bind.pointEnterCallback then
        self.bind.pointEnterCallback(self)
      end
      self.isSelected = true
      self:refreshSelectState(true)
    end,
    onPointExit_hitArea = function(self)
      if self.bind.pointExitCallback then
        self.bind.pointExitCallback(self)
      end
      self.isSelected = false
      self:refreshSelectState(false)
    end,
    onClick = function(self)
    end
  }
end

function module:refreshSelectState(isSelect)
  self.bindComponents.tipsAnim:Play("anim_cellBoxItem_tips")
  if isSelect then
    self:stopTimer("playHideAnim")
    self.bind.activeSelect = true
    self.bind.activeNormal = false
    self.bindComponents.selectAnim:Play("anim_cellBoxItem_select_show")
    L_AudioUtil.playSound("Play_SFX_System_UI_QiboHouse_Glance")
  else
    self.bind.activeSelect = true
    self.bind.activeNormal = false
    self.bindComponents.selectAnim:Play("anim_cellBoxItem_select_hide")
    self:newOrResetTimer("playHideAnim", function()
      self.bind.activeSelect = false
      self.bind.activeNormal = true
    end, 0.5)
  end
end

function module:setFilterMode(isInFilter)
  self.isInFilter = isInFilter
  self:refreshPetCountText()
end

function module:refreshPetCountText()
  if self.totalSlots > 0 then
    self.bind.txtNum1 = string.format("%d<size=20px>/%d</size>", self.petCount, self.totalSlots)
    self.bind.txtNum2 = string.format("%d<size=20px>/%d</size>", self.petCount, self.totalSlots)
  else
    self.bind.txtNum1 = ""
    self.bind.txtNum2 = ""
  end
end

function module:indexChange(index)
  if index < 10 then
    return string.format("0%d", index)
  end
  return tostring(index)
end

function module:open()
  self.bind.activeCell = false
  self:newOrResetTimer("playShowAnim", function()
    self.bind.activeCell = true
    self.bindComponents.anim:Play("anim_cellBoxItem_show")
  end, self.bind.boxIndex * 0.03)
  local numStr = self:indexChange(self.bind.boxIndex)
  self.bind.txtPetIndex = numStr
  self.bind.activeFullTips = self.bind.isFull or false
  self.petCount = self.bind.petCount or 0
  self.totalSlots = self.bind.totalSlots or 0
  self.isInFilter = self.bind.isInFilter or false
  self:refreshPetCountText()
end

function module:refresh(data)
  if data then
    self.bind.activeFullTips = data.isFull or false
    if data.petCount ~= nil then
      self.petCount = data.petCount
    end
    if data.totalSlots ~= nil then
      self.totalSlots = data.totalSlots
    end
    if data.isInFilter ~= nil then
      self.isInFilter = data.isInFilter
    end
    self:refreshPetCountText()
  end
end

function module:close()
end

return module
