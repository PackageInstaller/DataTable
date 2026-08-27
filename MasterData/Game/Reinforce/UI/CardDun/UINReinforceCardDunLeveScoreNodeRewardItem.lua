local base = UIBaseNode
local UINReinforceCardDunLeveScoreNodeRewardItem = class("UINReinforceCardDunLeveScoreNodeRewardItem", base)
local UINBaseItemWithReceived = require("Game.CommonUI.Item.UINBaseItemWithReceived")
local color_orange = Color.New(1.0, 0.4196078431372549, 0.06274509803921569)
local color_gray = Color.New(0.5058823529411764, 0.5058823529411764, 0.5058823529411764)
local color_des_normal = Color.New(1, 1, 1, 0.9019607843137255)
local color_des_picked = Color.New(1, 1, 1, 0.3607843137254902)

function UINReinforceCardDunLeveScoreNodeRewardItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Get, self, self.__OnClick)
  self._itemPool = UIItemPool.New(UINBaseItemWithReceived, self.ui.rewardItem, false)
  self._emptyItemPool = UIItemPool.New(UIBaseNode, self.ui.emptyItem, false)
end

function UINReinforceCardDunLeveScoreNodeRewardItem:RefreshRewardData(rewardData, curScore, pickedDic, levelName, onClickGetOne, isHaveLayer)
  self.onClickGetOne = onClickGetOne
  self.rewardData = rewardData
  local needScore = rewardData.rewardCfg.value
  if isHaveLayer then
    self.ui.tex_TaskDes.text = string.format(ConfigData:GetTipContent(59032), tostring(levelName), tostring(needScore))
  else
    self.ui.tex_TaskDes.text = string.format(ConfigData:GetTipContent(59018), tostring(levelName), tostring(needScore))
  end
  self._itemPool:HideAll()
  local isPicked = pickedDic[needScore]
  local itemids = rewardData.rewardCfg.reward_item_ids
  local itemnums = rewardData.rewardCfg.reward_item_nums
  for i, itemId in ipairs(itemids) do
    local itemNum = itemnums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self._itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemNum, nil, isPicked)
  end
  self._emptyItemPool:HideAll()
  for i = #itemids + 1, 2 do
    self._emptyItemPool:GetOne()
  end
  self:__RefreshProcess(rewardData, curScore, pickedDic)
end

function UINReinforceCardDunLeveScoreNodeRewardItem:__RefreshProcess(rewardData, curScore, pickedDic)
  local needScore = rewardData.rewardCfg.value
  local isPicked = pickedDic[needScore]
  local isComplete = curScore >= needScore
  self.ui.processSlider.value = curScore / needScore
  self.ui.btn_Received.gameObject:SetActive(isPicked)
  self.ui.btn_Get.gameObject:SetActive(isComplete and not isPicked)
  self.ui.btn_UnClear.gameObject:SetActive(not isPicked and not isComplete)
  self.ui.notPickBg:SetActive(not isPicked)
  self.ui.pickedBg:SetActive(isPicked)
  if isPicked then
    self.ui.tex_MissionDeco.color = color_gray
    self.ui.tex_TaskDes.color = color_des_picked
    self.ui.img_Fill.color = color_gray
    for _, emptyItem in ipairs(self._emptyItemPool.listItem) do
      emptyItem.transform:GetComponent(typeof(CS.UiImageItemInfo)):SetIndex(1)
    end
    self.ui.tex_Progress:SetIndex(1, tostring(curScore), tostring(needScore))
  else
    self.ui.tex_MissionDeco.color = color_orange
    self.ui.tex_TaskDes.color = color_des_normal
    self.ui.img_Fill.color = color_orange
    for _, emptyItem in ipairs(self._emptyItemPool.listItem) do
      emptyItem.transform:GetComponent(typeof(CS.UiImageItemInfo)):SetIndex(0)
    end
    self.ui.tex_Progress:SetIndex(0, tostring(curScore), tostring(needScore))
  end
end

function UINReinforceCardDunLeveScoreNodeRewardItem:__OnClick()
  if self.onClickGetOne ~= nil then
    self.onClickGetOne(self.rewardData.rewardCfg.value)
  end
end

function UINReinforceCardDunLeveScoreNodeRewardItem:OnDelete()
  base.OnDelete(self)
end

return UINReinforceCardDunLeveScoreNodeRewardItem
