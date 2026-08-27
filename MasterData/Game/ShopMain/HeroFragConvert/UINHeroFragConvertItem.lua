local UINHeroFragConvertItem = class("UINHeroFragConvertItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")

function UINHeroFragConvertItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemWithCount = UINBaseItemWithCount.New()
  self.itemWithCount:Init(self.ui.UINBaseItemWithCount)
  UIUtil.AddButtonListener(self.ui.Btn_Touch, self, self.__OnClick)
  self.ui.Btn_Touch.onPress:AddListener(BindCallback(self, self.__OnClick))
  UIUtil.AddButtonListener(self.ui.Btn_Cancle, self, self.__OnClickMin)
  self.ui.Btn_Cancle.onPress:AddListener(BindCallback(self, self.__OnClickMin))
end

function UINHeroFragConvertItem:InitHeroFragConvertItem(addCallback, minCalback)
  self.__addCallback = addCallback
  self.__minCalback = minCalback
end

function UINHeroFragConvertItem:RefreshHeroFragConvertItem(fragConvertData, curSelectedNum)
  self.fragConvertData = fragConvertData
  local fragId = fragConvertData.fragId
  local fragNum = fragConvertData.fragNum
  self.itemWithCount:InitItemWithCount(ConfigData.item[fragId], fragNum)
  self:__RefeshSelectedNum(curSelectedNum)
  self:__RefreshAram()
end

function UINHeroFragConvertItem:__RefeshSelectedNum(curSelectedNum)
  if 0 < curSelectedNum then
    self.ui.Obj_SelectedNum:SetActive(true)
    self.ui.Btn_Cancle.gameObject:SetActive(true)
    self.ui.Tex_Num.text = tostring(curSelectedNum)
  else
    self.ui.Obj_SelectedNum:SetActive(false)
    self.ui.Btn_Cancle.gameObject:SetActive(false)
  end
end

function UINHeroFragConvertItem:__RefreshAram()
  local weaponData = self.fragConvertData.weaponData
  local isUnlock, step
  if weaponData == nil then
    isUnlock = false
  else
    step = weaponData:GetSpecWeaponCurStep()
    isUnlock = 0 < step
  end
  self.ui.unlocked:SetActive(isUnlock)
  self.ui.Obj_ArmaLock:SetActive(not isUnlock)
  if isUnlock then
    self.ui.Tex_ArmaLv.text = "LV." .. tostring(weaponData:GetSpecWeaponCurLevel())
    self.ui.Tex_Lv.text = LanguageUtil.GetRomanNumber(step)
  end
end

function UINHeroFragConvertItem:__OnClick()
  if self.__addCallback ~= nil then
    local newNum = self.__addCallback(self.fragConvertData, 1)
    self:__RefeshSelectedNum(newNum)
  end
end

function UINHeroFragConvertItem:__OnClickMin()
  if self.__minCalback ~= nil then
    local newNum = self.__minCalback(self.fragConvertData, 1)
    self:__RefeshSelectedNum(newNum)
  end
end

function UINHeroFragConvertItem:OnDelete()
  base.OnDelete(self)
end

return UINHeroFragConvertItem
