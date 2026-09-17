local this = class("modulePetFrameIcon", G_UIModuleBase)
local MaxFrame = 8
local _petTpl = L_GameTpl:getPetTpl()

function this.bind()
  return {
    activeSelf = true,
    modulePetFlashEft = {
      moduleName = "pages/pet/modulePetFlashEft"
    }
  }
end

function this.methods()
  return {}
end

function this:open()
  self.isActiveSelf = true
end

function this:close()
  L_TimerManager:clearTimer(self)
end

function this:refreshView()
  if not self.isBind then
    return
  end
  L_TimerManager:clearTimer(self)
  local guid = self.bind.guid
  self.modules.modulePetFlashEft:setModulePetFlashEftData(guid)
  if math.isEmpty(guid) or guid <= 0 then
    if self.isActiveSelf == true then
      self.bind.activeSelf = false
      self.isActiveSelf = false
    end
    return
  end
  if self.isActiveSelf == false then
    self.bind.activeSelf = true
    self.isActiveSelf = true
  end
  local pet = L_PetStore:getPetItem(guid)
  if pet == nil then
    errorf("pet guid: " .. tostring(guid) .. " no data")
    return
  end
  local tpl = _petTpl:getTplById(pet.id)
  local icon = _petTpl:getPetPixelIcon(tpl, pet:isSpecialPet())
  self:ReloadGif(icon)
  local offSetPos = _petTpl:getPetPixelPosition(tpl, pet:isSpecialPet())
  if offSetPos == nil then
    errorf(string.format("petId: %d, _petTpl:getPetPixelPosition() == nil", pet.id))
  else
    self.bindComponents.rect_img_icon.anchoredPosition = L_Vector3.new(offSetPos[1], offSetPos[2])
  end
  if self.bind.autoPlay then
    self:playPixelGif()
  end
end

function this:ReloadGif(frameIcon)
  if frameIcon == self._initFrameIcon then
    return
  end
  self._initFrameIcon = frameIcon
  self._curFrame = 1
  self.isInitFrameIcon = false
  self.bindComponents.img_icon:Stop()
  self._defaultPixelId = string.match(self._initFrameIcon, "%a*%d+")
  self.bindComponents.img_icon:ClearFrameSprites()
  self.bindComponents.img_icon:LoadSprite(self._initFrameIcon)
end

function this:setGuid(guid, autoPlay)
  self.bind.guid = guid
  self.bind.autoPlay = autoPlay
  self:refreshView()
end

function this:playPixelGif()
  if not self.isInitFrameIcon then
    local gifPath = string.format("UI/Icon/PetPixelIcon/tex_icon_pet_%s_{0}.png", self._defaultPixelId)
    self.bindComponents.img_icon:SetSprites(gifPath, MaxFrame, function()
      if not self.isBind or not self.bindComponents then
        return
      end
      self:_DoPlayGift()
    end)
    self.isInitFrameIcon = true
  else
    self:_DoPlayGift()
  end
end

function this:_DoPlayGift()
  self:newOrResetTimer("playGif", function()
    if not self.isBind or not self.bindComponents then
      return
    end
    if self._curFrame == nil then
      self._curFrame = 1
    end
    self._curFrame = self._curFrame % MaxFrame + 1
    self.bindComponents.img_icon:SetFrame(self._curFrame)
  end, 0.1, -1)
end

function this:SetColor(color)
  self.bindComponents.img_icon.color = color
end

return this
