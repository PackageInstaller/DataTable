local base = UIBaseNode
local UINActBondDunLevelItem = class("UINActBondDunLevelItem", base)

function UINActBondDunLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn, self, self.__Onclick)
end

function UINActBondDunLevelItem:ActBond_InitDunLevelItem(bondData, dunData, selectCallback)
  self.__bondData = bondData
  self.__dunData = dunData
  self.__selectCallback = selectCallback
  self:__Refresh()
end

function UINActBondDunLevelItem:__Refresh()
  local isUnlock = self.__dunData:GetIsLevelUnlock()
  local unlockDes = self.__dunData:GetIsUnlockDes()
  local isClear = self.__dunData:GetIsClear()
  local score = self.__dunData:GetBondDunScore()
  local levelType = self.__dunData:GetBondDunType()
  local dunGroupData = self.__dunData:GetDunGroupData()
  self.ui.Obj_Lock:SetActive(not isUnlock)
  self.ui.Img_ScoreBg:SetActive(isUnlock)
  if not isUnlock then
    self.ui.Tex_UnlockTip.text = unlockDes
  else
    local isNotHaveScore = score == nil or score == 0
    self.ui.Tex_NoData:SetActive(isNotHaveScore)
    self.ui.Tex_Score.gameObject:SetActive(not isNotHaveScore)
    if not isNotHaveScore then
      self.ui.Tex_Score.text = tostring(score)
    end
  end
  self.ui.Obj_Clear:SetActive(isClear)
  self.ui.Obj_Unclear:SetActive(not isClear)
  self.ui.Img_Icon:SetIndex(levelType)
  self.ui.Tex_Title.text = self.__dunData:GetDungeonLevelName()
  self.ui.Tex_Round:SetIndex(0, tostring(dunGroupData:ActBond_GetIndex()))
end

function UINActBondDunLevelItem:__Onclick()
  if self.__selectCallback ~= nil then
    self.__selectCallback(self)
  end
end

function UINActBondDunLevelItem:SetIsSelected(bool)
  self.ui.Obj_Select:SetActive(bool)
end

function UINActBondDunLevelItem:ActBond_GetDunData()
  return self.__dunData
end

function UINActBondDunLevelItem:OnDelete()
  base.OnDelete(self)
end

return UINActBondDunLevelItem
