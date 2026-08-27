local UINHeroEnterSlotItem = class("UINHeroEnterSlotItem", UIBaseNode)
local base = UIBaseNode
local staticAllSlots = {}

function UINHeroEnterSlotItem:cleanStaticAllSlots()
  staticAllSlots = {}
end

function UINHeroEnterSlotItem:OnInit()
  self.resloader = nil
  self.isUnlock = false
  self.heroId = nil
  self.clickFunc = nil
  self.isSelected = false
  self.slotNum = nil
  self.isShowSelect = false
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_theSlot, self, self.OnSlotClick)
  self.ui.obj_Add:SetActive(false)
  self.ui.obj_Hero:SetActive(false)
  self.ui.obj_Lock:SetActive(true)
  self.ui.obj_select:SetActive(false)
end

function UINHeroEnterSlotItem:InitHeroEnterSlot(resloader, isUnlock, heroId, isShowSelect)
  self.resloader = resloader
  self.isUnlock = isUnlock
  self.heroId = heroId
  self.isShowSelect = isShowSelect
  self:RefreshHeroEnterSlot()
  if isShowSelect then
    table.insert(staticAllSlots, {
      isUnlock = isUnlock,
      heroID = heroId,
      slotItem = self
    })
    self.slotNum = #staticAllSlots
  end
end

function UINHeroEnterSlotItem:RefreshHeroEnterSlot()
  self.ui.obj_Add:SetActive(false)
  self.ui.obj_Hero:SetActive(false)
  self.ui.obj_Lock:SetActive(false)
  if self.isUnlock then
    if self.heroId ~= nil then
      self.ui.obj_Hero:SetActive(true)
      local heroCfg = ConfigData.hero_data[self.heroId]
      local heroResCfg = ConfigData.resource_model[heroCfg.src_id]
      self.resloader:LoadABAssetAsync(PathConsts:GetCharacterPicPath(heroResCfg.res_Name), function(texture)
        if IsNull(self.transform) then
          return
        end
        self.ui.img_Hero.texture = texture
      end)
    else
      self.ui.obj_Add:SetActive(true)
    end
  else
    self.ui.obj_Lock:SetActive(true)
    self.ui.tex_UnlockMessage:SetIndex(0, ConfigData:GetTipContent(14025))
  end
end

function UINHeroEnterSlotItem:OnSlotClick()
  if self.isUnlock and self.isShowSelect then
    for _, value in ipairs(staticAllSlots) do
      if value.slotItem.isSelected == true then
        value.slotItem.ui.obj_select:SetActive(false)
        value.slotItem.isSelected = false
      end
    end
    self.ui.obj_select:SetActive(true)
    self.isSelected = true
  end
  if self.clickFunc == nil then
    return
  else
    self.clickFunc(self.isUnlock, self.heroId)
  end
end

function UINHeroEnterSlotItem:SetSlotClickEvent(event)
  self.clickFunc = event
end

function UINHeroEnterSlotItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroEnterSlotItem
