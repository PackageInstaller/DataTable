local this = class("modulePetBoxTabtwo", G_UIModuleBase)
local _petLevelTpl = L_GameTpl:getPetLevelTpl()
local _petFavorabilityTpl = L_GameTpl:getPetFavorabilityTpl()
local _petTpl = L_GameTpl:getPetTpl()
local petRankTpl = L_GameTpl:getPetRankTpl()
local uiTopBarTpl = L_GameTpl:getUiTopBarTpl()

function this.bind()
  return {
    leftActive = false,
    leftDeActive = false,
    rightActive = false,
    rightDeActive = false
  }
end

function this.methods()
  return {
    onClick_LeftBtn = function(self)
      if self.selIndex == 1 then
        return
      end
      self:refreshSel(1)
      if self.callBack then
        self.callBack(true)
      end
    end,
    onClick_RightBtn = function(self)
      if self.selIndex == 2 then
        return
      end
      self:refreshSel(2)
      if self.callBack then
        self.callBack(false)
      end
    end
  }
end

function this:setData(selIndex, callBack)
  self.callBack = callBack
  self:refreshSel(selIndex)
end

function this:refreshSel(selIndex)
  self.selIndex = selIndex
  if selIndex == 1 then
    self.bind.leftActive = true
    self.bind.leftDeActive = false
    self.bind.rightActive = false
    self.bind.rightDeActive = true
  elseif selIndex == 2 then
    self.bind.leftActive = false
    self.bind.leftDeActive = true
    self.bind.rightActive = true
    self.bind.rightDeActive = false
  end
end

return this
