local base = UIBaseNode
local UINActCommonMonsterCardLeftNode = class("UINActCommonMonsterCardLeftNode", base)
local eActMonsterCardEnum = require("Game.ActivityFrame.ActivityMonsterCard.eActMonsterCardEnum")
local UINActCommonMonsterCardLeftNode_TypeItem = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardLeftNode_TypeItem")

function UINActCommonMonsterCardLeftNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Tip, self, self.__OnClickBtnTip)
  self.__ActiveItem = UINActCommonMonsterCardLeftNode_TypeItem.New()
  self.__ActiveItem:Init(self.ui.obj_Item)
  self.__ActiveItem:Set_ACMCLNI_Title(true)
  self.__PassiveItem = UINActCommonMonsterCardLeftNode_TypeItem.New()
  self.__PassiveItem:Init(self.ui.obj_Item:Instantiate())
  self.__PassiveItem:Set_ACMCLNI_Title(false)
end

function UINActCommonMonsterCardLeftNode:InitACMCLeftNode(monsterCardPlayData)
  self.monsterCardPlayData = monsterCardPlayData
  self:ACML_RefreshNode()
end

function UINActCommonMonsterCardLeftNode:ACML_RefreshNode()
  local selectedCardDataList = self.monsterCardPlayData:ActMCPD_GetSelectedCardDataList()
  self.__ActiveItem:RefreshACMCLNI_CardTypeDes(selectedCardDataList)
  self.__ActiveItem:Show()
  local passiveCardList = self.monsterCardPlayData:ActMCPD_GetCardDataListByType(eActMonsterCardEnum.cardType.passive)
  self.__PassiveItem:RefreshACMCLNI_CardTypeDes(passiveCardList)
  self.__PassiveItem:Show()
end

function UINActCommonMonsterCardLeftNode:__OnClickBtnTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(win)
    if win == nil then
      return
    end
    local tipId = self.monsterCardPlayData:ActMCPD_GetTipId()
    win:InitCommonInfoByRule(tipId, true)
  end)
end

function UINActCommonMonsterCardLeftNode:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardLeftNode
