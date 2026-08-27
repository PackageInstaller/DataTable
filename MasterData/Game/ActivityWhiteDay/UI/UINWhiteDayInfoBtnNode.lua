local UINWhiteDayInfoBtnNode = class("UINWhiteDayInfoBtnNode", UIBaseNode)
local base = UIBaseNode
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINWhiteDayInfoBtnUnlockItem = require("Game.ActivityWhiteDay.UI.UINWhiteDayInfoBtnUnlockItem")
local cs_DoTween = CS.DG.Tweening.DOTween

function UINWhiteDayInfoBtnNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.rewardItem)
  self.ui.rewardItem:SetActive(false)
  self.unlockItemPool = UIItemPool.New(UINWhiteDayInfoBtnUnlockItem, self.ui.obj_unlockItem)
  self.ui.obj_unlockItem:SetActive(false)
  self.__curShowLevel = nil
  self.__curShowExp = nil
  self.__expBarFillSize = self.ui.trans_img_Fill.sizeDelta
end

function UINWhiteDayInfoBtnNode:InitWhiteDayInfoNode(AWDCtrl, AWDData)
  self.AWDCtrl = AWDCtrl
  self.AWDData = AWDData
  self:RefreshWDInfoNode(true)
end

function UINWhiteDayInfoBtnNode:RefreshWDInfoNode(isInit)
  local curLevel = self.AWDData:GetAWDFactoryLevel()
  local curExp = self.AWDData:GetAWDFactoryExp()
  local isMaxLevel = self.AWDData:GetAWDFactoryIsFullLevel()
  local randomId, _ = self.AWDData:GetWDRandomPhotoItemIdAndNum()
  local exchangeId, _ = self.AWDData:GetWDExchangePhotoItemIdAndNum()
  local isLimit = self.AWDData:GetWhiteDayPhotoConvertItemIsAboveLimit()
  if curLevel ~= self.__curShowLevel then
    self.ui.tex_Lv:SetIndex(0, tostring(curLevel))
    self.rewardItemPool:HideAll()
    self.unlockItemPool:HideAll()
    if isMaxLevel then
      self.ui.tex_LeveTip:SetIndex(1)
      self.ui.obj_rewardClear:SetActive(true)
    else
      self.ui.tex_LeveTip:SetIndex(0)
      local ids, nums = self.AWDData:GetAWDFactoryLevelUpReward(curLevel)
      for index, itemId in ipairs(ids) do
        local num = nums[index]
        local rewardItem = self.rewardItemPool:GetOne()
        local itemCfg = ConfigData.item[itemId]
        rewardItem:InitItemWithCount(itemCfg, num, nil, nil)
        if randomId == itemId or exchangeId == itemId then
          rewardItem:SetItemRecycyleTag(isLimit)
        end
      end
      local lineList = self.AWDData:GetAWDFactoryLevelUpUnlockLineList(curLevel + 1) or table.emptytable
      for _, lineId in ipairs(lineList) do
        local unlockItem = self.unlockItemPool:GetOne()
        unlockItem:IntiInfoBtnUnlockItem(true, nil)
      end
      local orderDataList = self.AWDData:GetAWDFactoryLevelUpUnlockOrderDataList(curLevel + 1) or table.emptytable
      for _, orderData in ipairs(orderDataList) do
        local unlockItem = self.unlockItemPool:GetOne()
        unlockItem:IntiInfoBtnUnlockItem(false, orderData)
      end
    end
  end
  if curLevel ~= self.__curShowLevel or curExp ~= self.__curShowExp then
    local previousLevel = self.AWDData:GetWDBeforeLevelUpLevel()
    local isLevelUp = previousLevel ~= nil and curLevel > previousLevel
    local finalRate
    if not isMaxLevel then
      local levelUpNeedExp = self.AWDData:GetAWDFactoryLevelUpExp(curLevel)
      self.ui.tex_ProgressBar.gameObject:SetActive(true)
      self.ui.tex_ProgressBar:SetIndex(0, tostring(curExp), tostring(levelUpNeedExp))
      finalRate = curExp / levelUpNeedExp
    else
      self.ui.tex_ProgressBar.gameObject:SetActive(false)
      finalRate = 1
    end
    if isInit then
      self.ui.trans_img_Fill.sizeDelta = Vector2.New(self.__expBarFillSize.x * finalRate, self.__expBarFillSize.y)
    else
      if self.__levelTween ~= nil then
        self.__levelTween:Kill()
        self.__levelTween = nil
      end
      self.__levelTween = cs_DoTween.Sequence()
      if isLevelUp then
        for i = previousLevel, curLevel do
          self.__levelTween:Append(self.ui.trans_img_Fill:DOSizeDelta(self.__expBarFillSize, 0.5))
        end
        if not isMaxLevel then
          self.__levelTween:AppendCallback(function()
            self.ui.trans_img_Fill.sizeDelta = Vector2.New(0, self.__expBarFillSize.y)
          end)
          self.__levelTween:Append(self.ui.trans_img_Fill:DOSizeDelta(Vector2.New(self.__expBarFillSize.x * finalRate, self.__expBarFillSize.y), 0.5))
        end
      else
        self.__levelTween:Append(self.ui.trans_img_Fill:DOSizeDelta(Vector2.New(self.__expBarFillSize.x * finalRate, self.__expBarFillSize.y), 0.5))
      end
      self.__levelTween:Pause()
    end
  end
  self.__curShowExp = curExp
  self.__curShowLevel = curLevel
end

function UINWhiteDayInfoBtnNode:TryPlayWDLevelExpTween()
  if self.__levelTween ~= nil then
    self.__levelTween:Play()
  end
end

function UINWhiteDayInfoBtnNode:OnDelete()
  if self.__levelTween ~= nil then
    self.__levelTween:Kill()
    self.__levelTween = nil
  end
  base.OnDelete(self)
end

return UINWhiteDayInfoBtnNode
