local base = UIBaseNode
local UINActBondLevelItem = class("UINActBondLevelItem", base)
local CS_Image = CS.UnityEngine.UI.Image

function UINActBondLevelItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn, self, self.__Onclick)
end

function UINActBondLevelItem:InitActBondLevelItem(actBoondData, dunGroupData, selectCallback, resloader)
  self.__actBoondData = actBoondData
  self.__dunGroupData = dunGroupData
  self.__selectCallback = selectCallback
  self.__resloader = resloader
  self.__buffImgList = {}
  self.__buffImgList[1] = self.ui.Img_Pic
  self:SetIsSelected(false)
  self:__Refresh()
end

function UINActBondLevelItem:__Refresh()
  local isAllCleared = self.__dunGroupData:ActBond_GetIsAllCleared()
  local score = self.__dunGroupData:ActBond_GetScore()
  local unlockTime = self.__dunGroupData:ActBond_GetUnlockTime()
  self.isUnlock = unlockTime < PlayerDataCenter.timestamp
  local isShowScore = self.isUnlock and score ~= 0
  self.ui.Tex_Score.gameObject:SetActive(isShowScore)
  self.ui.Tex_NoData.gameObject:SetActive(not isShowScore)
  self.ui.Obj_Lock:SetActive(not self.isUnlock)
  if self.isUnlock then
    if score ~= 0 then
      self.ui.Tex_Score.text = tostring(score)
    else
      self.ui.Tex_NoData:SetIndex(0)
    end
  else
    local timeStr = TimeUtil:TimestampToDateString(unlockTime, false, true, "%Y/%m/%d %H:%M")
    self.ui.Tex_NoData:SetIndex(1, timeStr)
  end
  self.ui.Tex_Title.text = self.__dunGroupData:ActBond_GetTitle()
  self.ui.Tex_Round:SetIndex(0, tostring(self.__dunGroupData:ActBond_GetIndex()))
  self.ui.Obj_Clear:SetActive(isAllCleared)
  self.ui.Obj_Unclear:SetActive(not isAllCleared)
  local buffList = self.__dunGroupData:ActBond_GetBuffList()
  for index, buffId in ipairs(buffList) do
    if self.__buffImgList[index] == nil then
      local imgItemInfo = self.ui.Img_Pic.gameObject:Instantiate():GetComponent(typeof(CS_Image))
      self.__buffImgList[index] = imgItemInfo
    end
    local dunBuffCfg = ConfigData.dungeon_buff[buffId]
    self.__buffImgList[index].sprite = CRH:GetSprite(dunBuffCfg.icon, CommonAtlasType.ExplorationIcon)
  end
  self:__RefreshBlueDot()
end

function UINActBondLevelItem:__RefreshBlueDot()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self.__actBoondData:GetActId()
  local dunGroupId = self.__dunGroupData:ActBond_GetIndex()
  local blueDotBool = self.isUnlock and not saveUserData:GetBondDunGroupLooked(actId, dunGroupId)
  self.ui.obj_blueDot:SetActive(blueDotBool)
end

function UINActBondLevelItem:__Onclick()
  if not self.isUnlock then
    return
  end
  if self.__selectCallback ~= nil then
    self.__selectCallback(self)
  end
end

function UINActBondLevelItem:ActBond_TimeUpdate()
  if not self.isUnlock then
    self:__Refresh()
  end
end

function UINActBondLevelItem:ActBond_GetDunGropData()
  return self.__dunGroupData
end

function UINActBondLevelItem:SetIsSelected(bool)
  self.ui.obj_Selected:SetActive(bool)
  if bool then
    self.transform:DOScale(Vector3.Temp(1.05, 1.05, 1), 0.2)
  else
    self.transform:DOScale(Vector3.one, 0.2)
  end
end

function UINActBondLevelItem:OnDelete()
  base.OnDelete(self)
end

return UINActBondLevelItem
