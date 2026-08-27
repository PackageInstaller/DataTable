local base = require("Game.Exploration.UI.EventRoom.UINEventRoomPageBase")
local UINEpEventPartFusion = class("UINEpEventPartFusion", base)
local UINEpEventPartProductItem = require("Game.Exploration.UI.EventRoom.UINEpEventPartProductItem")
local UINEpEventPartItem = require("Game.Exploration.UI.EventRoom.UINEpEventPartItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UINEpEventPartFusion:OnInit()
  base.OnInit(self)
  UIUtil.AddButtonListener(self.ui.btn_Mix, self, self.OnClickMixPartEvent)
  UIUtil.AddButtonListener(self.ui.btn_Exit, self, self.OnClickExitPartEvent)
  self.__epEventPartItemClick = BindCallback(self, self.OnEpEventPartItemClick)
  self.__epEventPartProductClick = BindCallback(self, self.OnEpEventPartProductClick)
  self.__ShowChipDesc = BindCallback(self, self._ShowChipDesc)
  self.__HideChipDesc = BindCallback(self, self._HideChipDesc)
  self.__partItemProduct = UINEpEventPartItem.New()
  self.__partItemProduct:Init(self.ui.productItem)
  self.__partItemProduct:SetPartItemypeLineColor(self.ui.color_select)
  self.__partItemProduct:SetPartItemLineType(2)
  self.__productPool = UIItemPool.New(UINEpEventPartProductItem, self.ui.productListItem, false)
end

function UINEpEventPartFusion:InitBranchPage(uiEvent, onChoiceClick)
  base.InitBranchPage(self, uiEvent, onChoiceClick)
  if GuideManager:TryTriggerGuide(eGuideCondition.InEpEventRoom) then
  end
end

function UINEpEventPartFusion:RefreshBranchPage()
  self:RefreshEventText()
  self:RefreshEpEventPartFusion()
end

function UINEpEventPartFusion:RefreshEpEventPartFusion()
  local roomData = self.uiEvent.roomData
  local eventCfg = self.uiEvent.eventCfg
  local partFusionCfg = ConfigData.event_partfusion[eventCfg.event_tag_arg]
  self.__partFusionCfg = partFusionCfg
  self.__partItemList = {}
  self.__leftPartIndex = 0
  self.__rightPartIndex = 0
  self.__ableFusion = false
  local dynPlayer = ExplorationManager:GetDynPlayer()
  self.__leftPartCount = #partFusionCfg.part1_all
  self:__InitEventPartItemList(dynPlayer, self.ui.list_leftItem, partFusionCfg.part1_all, 0, 0)
  self.__rightPartCount = #partFusionCfg.part2_all
  self:__InitEventPartItemList(dynPlayer, self.ui.list_rightItem, partFusionCfg.part2_all, self.__leftPartCount, 1)
  self:__InitProductPreviewList(dynPlayer)
  self:__RefreshEventPartProduct()
end

function UINEpEventPartFusion:__InitEventPartItemList(dynPlayer, list_item, list, offsetIndex, typeIndex)
  for index, chipId in pairs(list) do
    local hasChip = dynPlayer:GetChipCount(chipId) > 0
    local partItem = UINEpEventPartItem.New()
    partItem:Init(list_item[index])
    local itemIndex = index + offsetIndex
    partItem:InitEpEventPartItem(chipId, itemIndex, hasChip)
    partItem:SetPartItemLineType(typeIndex)
    partItem:BindEventPartBtnEvent(self.__epEventPartItemClick, self.__ShowChipDesc, self.__HideChipDesc)
    self.__partItemList[itemIndex] = partItem
  end
end

function UINEpEventPartFusion:__InitProductPreviewList(dynPlayer)
  for index, chipId in pairs(self.__partFusionCfg.part_product) do
    local leftIndex = (index - 1) // self.__rightPartCount + 1
    local rightIndex = (index - 1) % self.__rightPartCount + 1
    local hasChip = dynPlayer:GetChipCount(self.__partFusionCfg.part1_all[leftIndex]) > 0 and 0 < dynPlayer:GetChipCount(self.__partFusionCfg.part2_all[rightIndex])
    local productItem = self.__productPool:GetOne()
    productItem.gameObject.name = tostring(index)
    productItem:InitEventPartProduct(index, chipId, hasChip, self.__epEventPartProductClick)
  end
  self.ui.img_ItemSelect.gameObject:SetActive(false)
  self.__selProductIndex = 0
end

function UINEpEventPartFusion:OnEpEventPartProductClick(productItem, index)
  local lastSelect = self.__selProductIndex
  if lastSelect == index then
    return
  end
  self.__selProductIndex = index
  local leftIndex = (index - 1) // self.__rightPartCount + 1
  local rightIndex = (index - 1) % self.__rightPartCount + 1 + self.__leftPartCount
  self:OnEpEventPartItemClick(self.__partItemList[leftIndex])
  self:OnEpEventPartItemClick(self.__partItemList[rightIndex])
end

function UINEpEventPartFusion:OnEpEventPartItemClick(partItem)
  local partIndex = partItem:GetEventPartIndex()
  if partIndex == 0 then
    return
  end
  local lastPartIndex = 0
  if partIndex > self.__leftPartCount then
    if 0 < self.__rightPartIndex then
      lastPartIndex = self.__rightPartIndex + self.__leftPartCount
    end
    if lastPartIndex == partIndex then
      return
    end
    self.__rightPartIndex = partIndex - self.__leftPartCount
  else
    lastPartIndex = self.__leftPartIndex
    if lastPartIndex == partIndex then
      return
    end
    self.__leftPartIndex = partIndex
  end
  local lastItem = self.__partItemList[lastPartIndex]
  if lastItem ~= nil then
    lastItem:SetPartItemypeLineColor(self.ui.color_unSelect)
    self.ui.img_lineList1[lastPartIndex].color = self.ui.color_unSelect
    self.ui.img_lineList2[lastPartIndex].color = self.ui.color_unSelect
  end
  local selectItem = self.__partItemList[partIndex]
  if selectItem ~= nil then
    selectItem:SetPartItemypeLineColor(self.ui.color_select)
    self.ui.img_lineList1[partIndex].color = self.ui.color_select
    self.ui.img_lineList2[partIndex].color = self.ui.color_select
  end
  self:__RefreshEventPartProduct()
end

function UINEpEventPartFusion:__RefreshEventPartProduct()
  if self.__leftPartIndex <= 0 or 0 >= self.__rightPartIndex then
    self.__partItemProduct:InitEpEventEmpty(0)
    self.__ableFusion = false
    self.ui.obj_eventContent:SetActive(false)
  else
    local productIndex = (self.__leftPartIndex - 1) * self.__rightPartCount + self.__rightPartIndex
    local chipId = self.__partFusionCfg.part_product[productIndex]
    self.__partItemProduct:InitEpEventPartItem(chipId, 0, true)
    self.__partItemProduct:BindEventPartBtnEvent(nil, self.__ShowChipDesc, self.__HideChipDesc)
    local chipData = self.__partItemProduct:GetEventPartChip()
    self.ui.tex_FusionInfo.text = chipData:GetChipDescription()
    self.ui.obj_eventContent:SetActive(true)
    self.__selProductIndex = productIndex
    self.ui.img_ItemSelect.gameObject:SetActive(true)
    local productItem = self.__productPool.listItem[productIndex]
    self.ui.img_ItemSelect.position = productItem.transform.position
    local isLeftEmpty = self.__partItemList[self.__leftPartIndex]:IsEventPartEmpty()
    local isRightEmpty = self.__partItemList[self.__rightPartIndex + self.__leftPartCount]:IsEventPartEmpty()
    self.__ableFusion = not isLeftEmpty and not isRightEmpty
  end
  if self.__ableFusion then
    self.ui.cg_Mix.alpha = 1
  else
    self.ui.cg_Mix.alpha = 0.5
  end
end

function UINEpEventPartFusion:OnClickMixPartEvent()
  if not self.__ableFusion then
    return
  end
  local productIndex = (self.__leftPartIndex - 1) * self.__rightPartCount + self.__rightPartIndex
  local eventIndex = self.__partFusionCfg.part_event[productIndex]
  local roomData = self.uiEvent.roomData
  local choiceData = roomData.choiceDatalist[eventIndex]
  if choiceData == nil then
    return
  end
  self.onChoiceClick(choiceData.cfg, choiceData.idx, true, choiceData.catId)
end

function UINEpEventPartFusion:OnClickExitPartEvent()
  local eventIndex = self.__partFusionCfg.exit_index
  local roomData = self.uiEvent.roomData
  local choiceData = roomData.choiceDatalist[eventIndex]
  if choiceData == nil then
    return
  end
  self.onChoiceClick(choiceData.cfg, choiceData.idx, true, choiceData.catId)
end

function UINEpEventPartFusion:_ShowChipDesc(chipData, partItem)
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  local showDesc = CommonUtil.GetDetailDescribeSetting(eGameSetDescType.chip)
  win:SetTitleAndContext(chipData:GetName(), chipData:GetChipDescription(showDesc))
  win:FloatTo(partItem.transform, FloatAlignEnum.HAType.left, FloatAlignEnum.VAType.up)
end

function UINEpEventPartFusion:_HideChipDesc(chipData, partItem)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
    win:Clean3DModifier()
  end
end

function UINEpEventPartFusion:OnDelete()
  base.OnDelete(self)
end

return UINEpEventPartFusion
