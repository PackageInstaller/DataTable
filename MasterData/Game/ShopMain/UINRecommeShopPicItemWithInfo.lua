local UINRecommeShopPicItemWithInfo = class("UINRecommeShopPicItemWithInfo", UIBaseNode)
local base = UIBaseNode
local JumpManager = require("Game.Jump.JumpManager")
local UINRecommeShopMidPageInfo = require("Game.ShopMain.UINRecommeShopMidPageInfo")

function UINRecommeShopPicItemWithInfo:OnInit()
  self.__couldClick = true
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_jump, self, self.OnClickRecommePicJump)
end

function UINRecommeShopPicItemWithInfo:InitRecommeShopPicWithInfo(recommeCfg, resloader)
  self.recommeCfg = recommeCfg
  local textureName = self.recommeCfg.imgIcon
  resloader:LoadABAssetAsync(PathConsts:GetShopRecommendPath(textureName), function(texture)
    if not IsNull(texture) then
      self.ui.img_Banner.texture = texture
      self.ui.img_Banner.gameObject:SetActive(false)
      self.ui.img_Banner.gameObject:SetActive(true)
    end
  end)
  self.picInfo = UINRecommeShopMidPageInfo.New()
  self.picInfo:Init(self.ui.informationNode)
  self.picInfo:InitRecommeShopMidPageInfo(recommeCfg)
end

function UINRecommeShopPicItemWithInfo:__GetIsSouldOut()
  if self.recommeCfg == nil or self.recommeCfg.jump_arg == nil then
    return false
  end
  local jumpTargetShopId = self.recommeCfg.jump_arg[1]
  local jumpTargetShelfId = self.recommeCfg.jump_arg[2]
  if jumpTargetShopId == nil or jumpTargetShelfId == nil then
    return false
  end
  local ShopController = ControllerManager:GetController(ControllerTypeId.Shop, true)
  return ShopController:GetShelfIsSouldOut(jumpTargetShopId, jumpTargetShelfId)
end

function UINRecommeShopPicItemWithInfo:UpdateSouldOut(getOneCallback, recycleOneCallback)
  if self:__GetIsSouldOut() then
    self.__couldClick = false
    if self.souldGo == nil then
      local souldGo = getOneCallback()
      self.souldGo = souldGo
      self.souldGo.transform:SetParent(self.transform)
    end
    self.souldGo.transform.anchoredPosition = Vector2.zero
    self.souldGo.transform.sizeDelta = Vector2.zero
    self.souldGo:Show()
  else
    self.__couldClick = true
    if self.souldGo ~= nil then
      recycleOneCallback(self.souldGo)
    end
  end
end

function UINRecommeShopPicItemWithInfo:OnClickRecommePicJump()
  if not self.__couldClick then
    return
  end
  if self.recommeCfg.jump_target ~= nil and self.recommeCfg.jump_target > 0 then
    JumpManager:Jump(self.recommeCfg.jump_target, nil, nil, self.recommeCfg.jump_arg)
  end
end

return UINRecommeShopPicItemWithInfo
