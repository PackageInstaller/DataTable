local UINRoleHeadItem = class("UINRoleHeadItem", UIBaseNode)
local base = UIBaseNode

function UINRoleHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self.__OnClickRoot)
end

function UINRoleHeadItem:InitRoleHeadItem(roleData, resloader, clickEvent, belongPlayer)
  self.roleData = roleData
  self.clickEvent = clickEvent
  self.isCommander = false
  local path = belongPlayer and PathConsts:GetCharacterPicPath(roleData:GetResPicName()) or PathConsts:GetCharacterSmallPicPath(roleData:GetResPicName())
  self.ui.img_HeroPic.gameObject:SetActive(belongPlayer)
  self.ui.img_MonsterPic.gameObject:SetActive(not belongPlayer)
  resloader:LoadABAssetAsync(path, function(texture)
    if self.roleData == roleData then
      if belongPlayer then
        self.ui.img_HeroPic.texture = texture
      else
        self.ui.img_MonsterPic.texture = texture
      end
    end
  end)
  self.ui.career:SetActive(true)
  self.ui.img_Career.sprite = CRH:GetSprite(roleData:GetCarrerIcon(), CommonAtlasType.CareerCamp)
end

function UINRoleHeadItem:InitCommanderHeadItem(resloader, clickEvent)
  self.roleData = nil
  self.clickEvent = clickEvent
  self.isCommander = true
  self.ui.img_HeroPic.gameObject:SetActive(false)
  self.ui.img_MonsterPic.gameObject:SetActive(true)
  resloader:LoadABAssetAsync(ResConsts.cmderHead, function(texture)
    if self.isCommander then
      self.ui.img_MonsterPic.texture = texture
    end
  end)
  self.ui.career:SetActive(false)
end

function UINRoleHeadItem:AlphaRoleHeadItem(transparent)
  self.ui.canvasGroup.alpha = transparent and self.ui.transparentValue or 1
end

function UINRoleHeadItem:__OnClickRoot()
  if self.clickEvent ~= nil then
    self.clickEvent(self.roleData, self.isCommander)
  end
end

function UINRoleHeadItem:OnDelete()
  base.OnDelete(self)
end

return UINRoleHeadItem
