local UIDormReplaceHero = class("UIDormReplaceHero", UIBaseWindow)
local base = UIBaseWindow
local DormUtil = require("Game.Dorm.DormUtil")

function UIDormReplaceHero:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.Delete)
  UIUtil.AddButtonListener(self.ui.btn_Cancel, self, self.Delete)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickConfirm)
end

function UIDormReplaceHero:InitDmReplaceHero(otherRoomData, heroData, roomdata, confimFunc)
  self.confimFunc = confimFunc
  self:ReplaceRoomImage(otherRoomData, roomdata)
  self.ui.img_Hero.sprite = CRH:GetHeroSkinSprite(heroData.dataId, heroData.skinId)
  self.ui.Text_BeforName.text = string.format("%02d", otherRoomData:GetDmRoomIndex()) .. "-" .. otherRoomData:GetName()
  self.ui.Text_AfterName.text = string.format("%02d", roomdata:GetDmRoomIndex()) .. "-" .. roomdata:GetName()
  self.ui.img_beforepos.transform.anchoredPosition = DormUtil.ToRectTransformPos(otherRoomData.x, otherRoomData.y)
  self.ui.img_afterpos.transform.localPosition = DormUtil.ToRectTransformPos(roomdata.x, roomdata.y)
end

function UIDormReplaceHero:ReplaceRoomImage(otherRoomData, roomdata)
  local isBeforeBigRoom = otherRoomData:IsBigRoomType()
  local isAfterBigRoom = roomdata:IsBigRoomType()
  self.ui.obj_normalBefore:SetActive(not isBeforeBigRoom)
  self.ui.obj_bigBefore:SetActive(isBeforeBigRoom)
  self.ui.obj_normalAfter:SetActive(not isAfterBigRoom)
  self.ui.obj_bigAfter:SetActive(isAfterBigRoom)
end

function UIDormReplaceHero:OnClickConfirm()
  if self.confimFunc ~= nil then
    self.confimFunc()
  end
  self:Delete()
end

function UIDormReplaceHero:OnDelete()
  base.OnDelete(self)
end

return UIDormReplaceHero
