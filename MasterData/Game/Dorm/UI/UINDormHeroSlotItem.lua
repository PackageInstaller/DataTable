local UINDormHeroSlotItem = class("UINDormHeroSlotItem", UIBaseNode)
local base = UIBaseNode

function UINDormHeroSlotItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_theSlot, self, self.OnClickItem)
end

function UINDormHeroSlotItem:InitDormHeroSlotItem(fntData, resloader, clickEvent)
  self.fntData = fntData
  self.clickEvent = clickEvent
  if fntData == nil then
    self.ui.img_Hero.gameObject:SetActive(false)
  else
    local param = self.fntData:GetFntParam()
    self.ui.img_Hero.gameObject:SetActive(true)
    local heroData = PlayerDataCenter.heroDic[param]
    if heroData == nil then
      error("Can't get heroData, id = " .. tostring(param))
      return
    end
    local path = PathConsts:GetCharacterPicPath(heroData:GetResPicName())
    resloader:LoadABAssetAsync(path, function(texture)
      self.ui.img_Hero.texture = texture
    end)
  end
end

function UINDormHeroSlotItem:OnClickItem()
  if self.clickEvent ~= nil then
    self.clickEvent(self.fntData)
  end
end

function UINDormHeroSlotItem:OnDelete()
  base.OnDelete(self)
end

return UINDormHeroSlotItem
