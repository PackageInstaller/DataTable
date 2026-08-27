local UINDmCheckInRoomSlotItem = class("UINDmCheckInRoomSlotItem", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINDmCheckInRoomSlotItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_IconBtn, self, self._OnClickRoot)
end

function UINDmCheckInRoomSlotItem:InitDmCheckInRoomSlotItem(clickFunc, roomData, fntData)
  self.clickFunc = clickFunc
  self.roomData = roomData
  self.fntData = fntData
  if fntData == nil then
    self.ui.HeroAvator.gameObject:SetActive(false)
    self.ui.addOrEmpty.gameObject:SetActive(true)
    self.ui.addOrEmpty:SetIndex(1)
    return
  end
  local heroId = fntData:GetFntParam()
  if heroId == 0 then
    self.ui.HeroAvator.gameObject:SetActive(false)
    self.ui.addOrEmpty.gameObject:SetActive(true)
    self.ui.addOrEmpty:SetIndex(0)
    return
  end
  self.ui.HeroAvator.gameObject:SetActive(true)
  self.ui.addOrEmpty.gameObject:SetActive(false)
  local heroData = PlayerDataCenter:GetHeroData(heroId)
  if heroData ~= nil then
    self.ui.img_HeroIcon.sprite = CRH:GetHeroSkinSprite(heroData.dataId, heroData.skinId)
  end
end

function UINDmCheckInRoomSlotItem:_OnClickRoot()
  if self.fntData == nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2025))
    return
  end
  if self.clickFunc ~= nil then
    self.clickFunc(self.roomData)
  end
end

function UINDmCheckInRoomSlotItem:OnDelete()
  base.OnDelete(self)
end

return UINDmCheckInRoomSlotItem
