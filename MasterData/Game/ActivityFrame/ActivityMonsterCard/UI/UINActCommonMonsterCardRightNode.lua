local base = UIBaseNode
local UINActCommonMonsterCardRightNode = class("UINActCommonMonsterCardRightNode", base)
local cs_MessageCommon = CS.MessageCommon
local eActMonsterCardEnum = require("Game.ActivityFrame.ActivityMonsterCard.eActMonsterCardEnum")
local UINActCommonMonsterCardCardItem = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardCardItem")
local UINActCommonMonsterCardCardInstalledItem = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardCardInstalledItem")
local UINActCommonMonsterCardSiftingNode = require("Game.ActivityFrame.ActivityMonsterCard.UI.UINActCommonMonsterCardSiftingNode")

function UINActCommonMonsterCardRightNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Remove, self, self.__RemoveAll)
  UIUtil.AddButtonListener(self.ui.Btn_Equip, self, self.__AutoEquip)
  UIUtil.AddButtonListener(self.ui.Btn_Sort, self, self.__OnClickSifting)
  self.passiveItemPool = UIItemPool.New(UINActCommonMonsterCardCardItem, self.ui.PassiveItem, false)
  self.activeItemPool = UIItemPool.New(UINActCommonMonsterCardCardItem, self.ui.ActiveItem, false)
  self.selectedItemPool = UIItemPool.New(UINActCommonMonsterCardCardInstalledItem, self.ui.ActiveSelectedItem, false)
  self.__OnClickCardItem = BindCallback(self, self.OnClickCardItem)
  self.ui.obj_Select:SetActive(false)
  self.siftingNode = UINActCommonMonsterCardSiftingNode.New()
  self.siftingNode:Init(self.ui.SortConditionNode)
  self.siftingNode:Hide()
end

function UINActCommonMonsterCardRightNode:InitACMCRightNode(monsterCardPlayData, ACMonsterCardUI)
  self.monsterCardPlayData = monsterCardPlayData
  self.ACMonsterCardUI = ACMonsterCardUI
  self.resloader = ACMonsterCardUI.resloader
  self:__RefreshPassiveList()
  self:ACMR_RefreshActiveList()
  self:ACMR_InitSelectedList()
end

function UINActCommonMonsterCardRightNode:__RefreshPassiveList()
  local hadCardList = self.monsterCardPlayData:ActMCPD_GetCardDataListByType(eActMonsterCardEnum.cardType.passive)
  local passiveCardList = self.monsterCardPlayData:ActMCPD_GetAllCardDataListByType(eActMonsterCardEnum.cardType.passive)
  local maxNum = self.monsterCardPlayData:ActMCPD_GetCardTypeNum(eActMonsterCardEnum.cardType.passive)
  local curNum = #hadCardList
  self.passiveItemPool:HideAll()
  for _, cardData in ipairs(passiveCardList) do
    local item = self.passiveItemPool:GetOne()
    item:Refresh_ACMCCI(self.monsterCardPlayData, cardData, self.__OnClickCardItem, false, self.resloader)
  end
  self.ui.Tex_PassiveCardNum.text = string.format("%s/%s", tostring(curNum), tostring(maxNum))
  self.ui.node_autoExcuting:SetActive(0 < curNum)
end

function UINActCommonMonsterCardRightNode:ACMR_RefreshActiveList()
  local hadCardList = self.monsterCardPlayData:ActMCPD_GetCardDataListByType(eActMonsterCardEnum.cardType.active)
  local activeCardList = self.monsterCardPlayData:ActMCPD_GetAllCardDataListByType(eActMonsterCardEnum.cardType.active)
  local maxNum = self.monsterCardPlayData:ActMCPD_GetCardTypeNum(eActMonsterCardEnum.cardType.active)
  local curNum = #hadCardList
  self.activeItemPool:HideAll()
  local selectedCardDic = self.monsterCardPlayData:ActMCPD_GetSelectedCardDic()
  for _, cardData in ipairs(activeCardList) do
    if self:__SiftCardData(cardData) then
      local monCardId = cardData:AacMCD_GetId()
      local item = self.activeItemPool:GetOne()
      item:Refresh_ACMCCI(self.monsterCardPlayData, cardData, self.__OnClickCardItem, false, self.resloader)
      item:Set_ACMCCI_IsSelected(selectedCardDic[monCardId])
    end
  end
  self.ui.Tex_ActiveCardNum.text = string.format("%s/%s", tostring(curNum), tostring(maxNum))
end

function UINActCommonMonsterCardRightNode:ACMR_InitSelectedList()
  local maxNum = self.monsterCardPlayData:ActMCPD_GetCardCouldSelectNum()
  self.selectedItemPool:HideAll()
  for i = 1, maxNum do
    local item = self.selectedItemPool:GetOne()
  end
  self:ACMR_RefreshSelectedList(false)
end

function UINActCommonMonsterCardRightNode:ACMR_RefreshSelectedList(isNeedTween)
  local selectedCardDataList = self.monsterCardPlayData:ActMCPD_GetSelectedCardDataList()
  local maxNum = self.monsterCardPlayData:ActMCPD_GetCardCouldSelectNum()
  local curNum = #selectedCardDataList
  for index, item in ipairs(self.selectedItemPool.listItem) do
    if index <= curNum then
      local cardData = selectedCardDataList[index]
      item:PlayInstallTween_ACMCCII(true, isNeedTween)
      item:Refresh_ACMCCII(self.monsterCardPlayData, cardData, self.__OnClickCardItem, self.resloader)
    else
      item:PlayInstallTween_ACMCCII(false, isNeedTween)
    end
  end
  self.ui.Tex_ActiveSelectedNum.text = string.format("%s/%s", tostring(curNum), tostring(maxNum))
end

function UINActCommonMonsterCardRightNode:OnClickCardItem(item)
  local data = item:Get_ACMCCI_MonCardData()
  self.ACMonsterCardUI:ACM_ShowCardInfo(data, item.transform)
end

function UINActCommonMonsterCardRightNode:__OnClickSifting()
  if self.__isSiftingInited then
    self.siftingNode:Show()
    return
  end
  local cardList = self.monsterCardPlayData:ActMCPD_GetAllCardDataListByType(eActMonsterCardEnum.cardType.active)
  local allLabelDic = {}
  local qualityDic = {}
  for _, cardData in pairs(cardList) do
    for index, labelId in ipairs(cardData:AacMCD_GetLabels()) do
      allLabelDic[labelId] = true
    end
    local quality = cardData:AacMCD_GetQuailty()
    qualityDic[quality] = true
  end
  
  local function ToListAndSort(dic)
    local list = {}
    for v, _ in pairs(dic) do
      table.insert(list, v)
    end
    table.sort(list)
    return list
  end
  
  local labelList = ToListAndSort(allLabelDic)
  local qualityList = ToListAndSort(qualityDic)
  self.siftingNode:InitMCSiftCondition(labelList, qualityList, function(siftingDataDic)
    self.__siftingDataDic = siftingDataDic
    self:ACMR_RefreshActiveList()
  end)
  self.__isSiftingInited = true
  self.siftingNode:Show()
end

function UINActCommonMonsterCardRightNode:__SiftCardData(cardData)
  if self.__siftingDataDic == nil then
    return true
  end
  local isQualityOK = false
  local siftingData = self.__siftingDataDic[eActMonsterCardEnum.siftingType.quality]
  if siftingData == nil or siftingData.selectIdDic == nil or table.count(siftingData.selectIdDic) == 0 then
    isQualityOK = true
  else
    local quality = cardData:AacMCD_GetQuailty()
    isQualityOK = siftingData.selectIdDic[quality] == true
  end
  local isLabelOK = false
  siftingData = self.__siftingDataDic[eActMonsterCardEnum.siftingType.label]
  if siftingData == nil or siftingData.selectIdDic == nil or table.count(siftingData.selectIdDic) == 0 then
    isLabelOK = true
  else
    for index, labelId in ipairs(cardData:AacMCD_GetLabels()) do
      if siftingData.selectIdDic[labelId] then
        isLabelOK = true
        break
      end
    end
  end
  return isQualityOK and isLabelOK
end

function UINActCommonMonsterCardRightNode:__RemoveAll()
  local isHaveSelectedCard = self.monsterCardPlayData:ActMCPD_GetIsHaveSelectedCard()
  if not isHaveSelectedCard then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(13502))
    return
  end
  self.monsterCardPlayData:ActMCPD_DeselectAllCard()
  self.ACMonsterCardUI:ACM_RefreshInstalledCards()
  self.ACMonsterCardUI:ACM_TrySendInstalledCardInfo()
end

function UINActCommonMonsterCardRightNode:__AutoEquip()
  self.monsterCardPlayData:ActMCPD_AutoSelectCard(BindCallback(self, self.__SiftCardData))
  self.ACMonsterCardUI:ACM_RefreshInstalledCards()
  self.ACMonsterCardUI:ACM_TrySendInstalledCardInfo()
end

function UINActCommonMonsterCardRightNode:OnDelete()
  base.OnDelete(self)
end

return UINActCommonMonsterCardRightNode
