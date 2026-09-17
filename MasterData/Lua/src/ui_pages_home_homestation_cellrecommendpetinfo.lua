local this = class("cellRecommendPetInfo", G_UIModuleBase)
local petInfoTpl = L_GameTpl:getPetTpl()
local _petTpl = L_GameTpl:getPetTpl()
local MaxFrame = 8
local GifPathNew = "UI/Texture/PetPixelIcon/tex_icon_pet_%s_{0}.png"
local IconPathNew = "UI/Icon/PetPixelIcon/tex_icon_pet_%s_{0}.png"

function this.bind()
  return {
    selectedBoxShow = false,
    unselectedBoxShow = true,
    petNameSelected = "",
    petNameUnselected = ""
  }
end

function this.methods()
  return {
    onClick = function(self)
      C_MapManager:trackBoki(self.bind.tpl.id)
    end,
    onClickEnter = function(self)
      self:PlayFrameIcon()
    end,
    onClickExit = function(self)
      self:StopFrameIcon()
    end
  }
end

function this:PlayFrameIcon()
  self:SetDynamicImgPlay(true)
end

function this:StopFrameIcon()
  self:SetDynamicImgPlay(false)
end

function this:SetDynamicImgPlay(isPlay)
  self._curFrame = 1
  if isPlay then
    self.bindComponents.imgPetDynamic:Play()
    self.bindComponents.imgPetDynamicOut:Play()
  else
    self.bindComponents.imgPetDynamic:Stop()
    self.bindComponents.imgPetDynamicOut:Stop()
  end
end

function this:open()
  local petTpl = petInfoTpl:getTplById(self.bind.tpl.id)
  local perName = petInfoTpl:getName(petTpl)
  self.bind.petNameSelected = perName
  self.bind.petNameUnselected = perName
  self._initFrameIcon = _petTpl:getPetPixelIcon(petTpl)
  self._defaultPixelId = string.match(self._initFrameIcon, "%a*%d+")
  local gifPath = string.format(IconPathNew, self._defaultPixelId)
  self.bindComponents.imgPetDynamic:SetSprites(gifPath, MaxFrame)
  local gifPathOutline = string.format(GifPathNew, self._defaultPixelId, self._curFrame)
  self.bindComponents.imgPetDynamicOut:SetSprites(gifPathOutline, MaxFrame)
  self:SetDynamicImgPlay(false)
end

function this:close()
  self:SetDynamicImgPlay(false)
end

return this
