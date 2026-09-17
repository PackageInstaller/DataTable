local this = class("cellPhotoPet", G_UIModuleBase)
local petGradeTpl = L_GameTpl:getPetGradeTpl()

function this.bind()
  return {
    gradeGroup = true,
    gradeValue = "",
    gradeIcon = "",
    selected = false,
    showTip = false,
    tipVal = "",
    module_pixelIcon = {
      moduleName = "pages/pet/modulePetPixelIcon"
    },
    skinActive = false
  }
end

function this:methods()
  return {
    onClick_handle = function(self)
      L_AudioUtil.playSound("Play_SFX_System_UI_Photograph_Choose_Qibo_Change")
      self:emit("onClick_handle", self, self.bind.guid)
    end
  }
end

function this:open()
  this.super.open(self)
  self._pixelIconModule = self.modules.module_pixelIcon
end

function this:close()
end

function this:refresh()
  if not self.isBind then
    return
  end
  if not math.isEmpty(self.bind.guid) then
    self:setPetDataContent(self.bind.guid, self.bind)
    self:setGifPlay(self.bind.choice)
  end
end

function this:setPetDataContent(guid, params)
  self.bind.guid = guid
  table.merge(self.bind, params or {})
  local serverData = L_PetStore:getPetItem(guid)
  if serverData then
    self._pixelIconModule:setGuid(guid)
    local property = L_PetStore:getPetOriginalProperty(serverData)
    local gradeTpl = petGradeTpl:getTplById(property.gradeRank)
    self.bind.gradeIcon = petGradeTpl:getIcon(gradeTpl)
    self.bind.gradeValue = tostring(property.grade)
    if serverData.wear_skin_id then
      self.bind.skinActive = serverData.wear_skin_id ~= 0
    end
  end
end

function this:setGifPlay(isPlay)
  if not self.isBind then
    return
  end
  self.bind.selected = isPlay
  if isPlay then
    self._pixelIconModule:playPixelGif()
  else
    self._pixelIconModule:stopPixelGif()
  end
end

function this:changeSelectNum(num, isSet)
  self.selectNum = num or 0
  self.isSet = isSet
  self:refreshTip()
end

function this:resetTipVal()
  self.selectNum = 0
  self.isSet = false
  self:refreshTip()
end

function this:refreshTip()
  self.bind.showTip = self.selectNum > 0 and self.isSet
  self.bind.tipVal = tostring(self.selectNum)
end

return this
