local base = require("Game.CommonUI.FloatWin.UINFloatUINode")
local UINActCommonMonsterCardCardInfoNode = class("UINActCommonMonsterCardCardInfoNode", base)
local eActMonsterCardEnum = require("Game.ActivityFrame.ActivityMonsterCard.eActMonsterCardEnum")
local cs_LeanTouch = CS.Lean.Touch.LeanTouch
local cs_InputUtility = CS.InputUtility
local cs_MessageCommon = CS.MessageCommon
local UINActCommonMonsterCardCardInfoNodeTag = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardCardInfoNodeTag")

function UINActCommonMonsterCardCardInfoNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Equip, self, self._OnclickEquip)
  self.tagItemPool = UIItemPool.New(UINActCommonMonsterCardCardInfoNodeTag, self.ui.TagItem, false)
  self.__onFingerDown = BindCallback(self, self._OnFingerDown)
end

function UINActCommonMonsterCardCardInfoNode:InitACMCCInfoNode(monCardData, monCardPlayData, ACMonsterCardUI)
  self.monCardData = monCardData
  self.monCardPlayData = monCardPlayData
  self.ACMonsterCardUI = ACMonsterCardUI
  self:__Refresh()
end

function UINActCommonMonsterCardCardInfoNode:__Refresh()
  self.ui.Tex_Name.text = self.monCardData:AacMCD_GetName()
  local level = self.monCardData:AacMCD_GetLevel()
  self.ui.Tex_lv:SetIndex(0, tostring(level))
  local isFake = self.monCardData:AacMCD_GetIsFakeCard()
  if isFake then
    self.ui.Tex_Des.text = self.monCardData:AacMCD_GetDes(level, eLogicDesType.MonsterCard)
  else
    self.ui.Tex_Des.text = self.monCardData:AacMCD_GetLevelUpDes(level, eLogicDesType.MonsterCard)
  end
  local isFake = self.monCardData:AacMCD_GetIsFakeCard()
  local isEquiped = self.monCardPlayData:ActMCPD_GetIsSelectedCard(self.monCardData)
  if isFake then
    self.ui.Img_btn_Equip.color = self.ui.color_btn_equip[3]
    self.ui.tex_Equip:SetIndex(2)
  elseif isEquiped then
    self.ui.Img_btn_Equip.color = self.ui.color_btn_equip[2]
    self.ui.tex_Equip:SetIndex(1)
  else
    self.ui.Img_btn_Equip.color = self.ui.color_btn_equip[1]
    self.ui.tex_Equip:SetIndex(0)
  end
  if isFake then
    self.ui.lvlbg:SetActive(false)
    self.ui.Tex_Lvlup:SetIndex(0, tostring(1))
    self.ui.Tex_Num:SetIndex(0, tostring(0), tostring(1))
  else
    self.ui.lvlbg:SetActive(true)
    local isHaveNextLevel, nextLevel, curNum, needNum = self.monCardData:AacMCD_GetNextLevelInfo()
    if isHaveNextLevel then
      self.ui.Tex_Lvlup:SetIndex(0, tostring(nextLevel))
      self.ui.Tex_Num.gameObject:SetActive(true)
      self.ui.Tex_Num:SetIndex(0, tostring(curNum), tostring(needNum))
    else
      self.ui.Tex_Lvlup:SetIndex(1)
      self.ui.Tex_Num.gameObject:SetActive(false)
    end
  end
  local isActive = self.monCardData:AacMCD_GetType() == eActMonsterCardEnum.cardType.active
  self.ui.Btn_Equip.gameObject:SetActive(isActive)
  self.tagItemPool:HideAll()
  for _, labelId in ipairs(self.monCardData:AacMCD_GetLabels()) do
    local labelCfg = ConfigData.activity_monster_card_label[labelId]
    local labelName = LanguageUtil.GetLocaleText(labelCfg.name)
    local item = self.tagItemPool:GetOne(true)
    item:ACMCCINRefreshTagName(labelName)
  end
end

function UINActCommonMonsterCardCardInfoNode:_OnclickEquip()
  local isFake = self.monCardData:AacMCD_GetIsFakeCard()
  if isFake then
    return
  end
  local isEquiped = self.monCardPlayData:ActMCPD_GetIsSelectedCard(self.monCardData)
  if isEquiped then
    self.monCardPlayData:ActMCPD_DeselectCard(self.monCardData)
  else
    local selectedCardDataList = self.monCardPlayData:ActMCPD_GetSelectedCardDataList()
    local maxNum = self.monCardPlayData:ActMCPD_GetCardCouldSelectNum()
    local curNum = #selectedCardDataList
    if maxNum <= curNum then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(13503))
    end
    self.monCardPlayData:ActMCPD_SelectCard(self.monCardData)
  end
  self.ACMonsterCardUI:ACM_RefreshInstalledCards()
  self.ACMonsterCardUI:ACM_TrySendInstalledCardInfo()
  self:__Refresh()
end

function UINActCommonMonsterCardCardInfoNode:_OnClickCloseInfo()
  self:Hide()
end

function UINActCommonMonsterCardCardInfoNode:_OnFingerDown(leanFinger)
  if not cs_InputUtility.OverUIValidTag(TagConsts.ValidTarget) then
    self:Hide()
  end
end

function UINActCommonMonsterCardCardInfoNode:OnShow()
  base.OnShow(self)
  cs_LeanTouch.OnFingerDown("+", self.__onFingerDown)
end

function UINActCommonMonsterCardCardInfoNode:OnHide()
  cs_LeanTouch.OnFingerDown("-", self.__onFingerDown)
  base.OnHide(self)
end

function UINActCommonMonsterCardCardInfoNode:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardCardInfoNode
