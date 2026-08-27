local base = UIBaseWindow
local UIBpSpReward = class("UIBpSpReward", base)
local UICommonItem = require("Game.CommonUI.Item.UICommonRewardItem")
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_Ease = CS.DG.Tweening.Ease

function UIBpSpReward:OnInit()
  self.resloader = CS.ResLoader.Create()
  self.rewardData = nil
  self.exitFuncList = {}
  self.buyFuncList = {}
  self.__rewardItemDic = {}
  self.__rewardSubItemDic = {}
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnBuyBpClick)
  self.__OnRewardItemClick = BindCallback(self, self.OnRewardItemClick)
  self.__OnSubItemClick = BindCallback(self, self.OnSubItemClick)
  self.__UpdateSpRewardShowFunc = BindCallback(self, self.__UpdateSpRewardShow)
  self.ui.loopScroll.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.loopScroll.onChangeItem = BindCallback(self, self.__OnChangeItem)
  self.ui.loopScroll.onReturnItem = BindCallback(self, self.__OnReturnItem)
  self.ui.subLoopScroll.onInstantiateItem = BindCallback(self, self.__OnNewSubItem)
  self.ui.subLoopScroll.onChangeItem = BindCallback(self, self.__OnChangeSubItem)
  self.ui.subLoopScroll.onReturnItem = BindCallback(self, self.__OnReturnSubItem)
  self.__SetCanClickClose = BindCallback(self, self.SetIsCanClickClose, true)
  self:SetIsCanClickClose(true)
  self.__onOPenShowReward = false
end

function UIBpSpReward:AddAndTryShowReward(commonRewardData)
  self.rewardData = commonRewardData
  if commonRewardData.exitAction ~= nil then
    table.insert(self.exitFuncList, commonRewardData.exitAction)
  end
  if commonRewardData.buyAction ~= nil then
    table.insert(self.buyFuncList, commonRewardData.buyAction)
  end
  self.ui.tex_Tip:SetIndex(commonRewardData:GetCRBattlePassTip())
  self.ui.tex_Buy:SetIndex(commonRewardData:GetCRBattlePassBuy())
  self:__ShowNextReward()
end

function UIBpSpReward:__ShowNextReward()
  ControllerManager:GetController(ControllerTypeId.Skin, true):CheckItemListsForSkins(self.rewardData.rewardIds, self.__UpdateSpRewardShowFunc, self.rewardData)
end

function UIBpSpReward:__UpdateSpRewardShow()
  self:Show()
  if not string.IsNullOrEmpty(self.rewardData.title) then
    self.ui.txt_RewardTitle.text = self.rewardData.title
  end
  if Consts.GameChannelType.IsJp() and self.rewardData:HasCRQZ() then
    local itemDic = self.rewardData:GetCRBeforeMergeItemDic()
    local freeQZNum = itemDic[ConstGlobalItem.PaidItem] or 0
    local paidQZNum = itemDic[ConstGlobalItem.PaidQZ] or 0
    self.ui.obj_JpQZTag:SetActive(true)
    self.ui.tex_FreeCount:SetIndex(0, tostring(freeQZNum))
    self.ui.tex_PayCount:SetIndex(0, tostring(paidQZNum))
  else
    self.ui.obj_JpQZTag:SetActive(false)
  end
  if self.rewardData.heroIdList ~= nil and 0 < #self.rewardData.heroIdList then
    self:Hide()
    UIManager:ShowWindowAsync(UIWindowTypeID.GetHero, function(window)
      if window == nil then
        return
      end
      if self.rewardData.crUpHeroFragDic ~= nil then
        window:SetGetHeroConvertFrag(self.rewardData.crUpHeroFragDic)
      end
      window:InitGetHeroList(self.rewardData.heroIdList, false, true, self.rewardData.newHeroIndexDic, function()
        self:Show()
        self:__RefreshList()
        AudioManager:PlayAudioById(1115)
        UIManager:DeleteWindow(UIWindowTypeID.GetHero)
      end, self.rewardData.skipOldHero)
    end)
  else
    AudioManager:PlayAudioById(1029)
    self:__RefreshList()
  end
end

function UIBpSpReward:__SetLoopItem(item, itemId, itemNum)
  if self.rewardData.crUpHeroFragDic ~= nil then
    item:SetIsConvertHeroFrag()
  end
  if self.rewardData.crItemTransDic ~= nil then
    local transNum = self.rewardData.crItemTransDic[itemId]
    if transNum ~= nil then
      item:SetItemTranNum(transNum)
      self:SetCannotClickCloseTimer()
    end
  end
  item.baseItem.baseItem:SetIsShowNewTag(false)
  if self.rewardData.crItemNewDic ~= nil and self.rewardData.crItemNewDic[itemId] ~= nil then
    item.baseItem.baseItem:SetIsShowNewTag(true)
  end
end

function UIBpSpReward:__OnNewItem(go)
  local item = UICommonItem.New()
  go.transform.localScale = Vector3.one
  item:Init(go)
  item:BindRewardResloader(self.resloader)
  self.__rewardItemDic[go] = item
end

function UIBpSpReward:__OnChangeItem(go, index)
  local item = self.__rewardItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local itemId = self.rewardData.rewardIds[index + 1]
  local itemNum = self.rewardData.rewardNums[index + 1]
  self:__SetLoopItem(item, itemId, itemNum)
  local itemCfg = ConfigData.item[itemId]
  item:InitCommonRewardItem(itemCfg, itemNum, self.rewardData.heroSnapshoot, self.__OnRewardItemClick)
  item:BindRewardClickCustomArg(index + 1)
end

function UIBpSpReward:__OnReturnItem(go)
  local item = self.__rewardItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  item.baseItem:CloseGreatRewardLoopFx()
  item.baseItem:CloseQualityFx()
end

function UIBpSpReward:__GetItemByIndex(index)
  local go = self.ui.loopScroll:GetCellByIndex(index)
  if go ~= nil then
    return self.__rewardItemDic[go]
  end
  return nil
end

function UIBpSpReward:__OnNewSubItem(go)
  local item = UINBaseItemWithCount.New()
  go.transform.localScale = Vector3.one
  item:Init(go)
  item:BindBaseItemResloader(self.resloader)
  self.__rewardSubItemDic[go] = item
end

function UIBpSpReward:__OnChangeSubItem(go, index)
  local item = self.__rewardSubItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  local hasBpSpReward, bpSpRewardIds, bpSpRewardNums = self.rewardData:GetBpSpRewardPreview()
  local itemId = bpSpRewardIds[index + 1]
  local itemNum = bpSpRewardNums[index + 1]
  local itemCfg = ConfigData.item[itemId]
  item:InitItemWithCount(itemCfg, itemNum, self.__OnSubItemClick)
  item:BindClickCustomArg(index + 1)
end

function UIBpSpReward:__OnReturnSubItem(go)
  local item = self.__rewardSubItemDic[go]
  if item == nil then
    error("Can't find item by gameObject")
    return
  end
  item:CloseGreatRewardLoopFx()
  item:CloseQualityFx()
end

function UIBpSpReward:OnRewardItemClick(itemCfg, index)
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:SetNotNeedAnyJump(true)
      win:InitListDetail(self.rewardData.rewardDataList, index)
    end
  end)
end

function UIBpSpReward:OnSubItemClick(itemCfg, index)
  UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
    if win ~= nil then
      win:SetNotNeedAnyJump(true)
      win:InitListDetail(self.rewardData:GetBpSpRewardList(), index)
    end
  end)
end

function UIBpSpReward:__RefreshList()
  self.ui.loopScroll.totalCount = #self.rewardData.rewardIds
  self.ui.subLoopScroll.totalCount = self.rewardData:GetBpSpRewardCount()
  self:__ShowGetRewardFx()
end

function UIBpSpReward:__ShowGetRewardFx()
  self.ui.dotween_rewardContent:DORestart()
  self.ui.dotween_list:DORestart()
  self.ui.dotween_sublist:DORestart()
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill(true)
    self.tweenSeq = nil
  end
  self.__onOPenShowReward = true
  if not self.__isAdded then
    self.__isAdded = true
    self.ui.dotween_rewardContent.onComplete:AddListener(function()
      self.__onOPenShowReward = false
      self:__PlayTooMuchRewardAnima()
      self:__PlaySubListRewardAnima()
    end)
  end
end

local anchorLeft = Vector2.New(0, 0.5)
local anchorMid = Vector2.New(0.5, 0.5)

function UIBpSpReward:__PlayTooMuchRewardAnima()
  local maxCouldContainNum = math.ceil((self.ui.loopScroll.transform.rect.width - self.ui.layoutGroup.padding.left) / (self.ui.layoutGroup.cellSize.x + self.ui.layoutGroup.spacing.x))
  local maxPage = math.ceil(#self.rewardData.rewardIds / maxCouldContainNum)
  if 1 < maxPage then
    self.ui.layoutGroup.transform.anchorMax = anchorLeft
    self.ui.layoutGroup.transform.anchorMin = anchorLeft
    self.ui.layoutGroup.transform.pivot = anchorLeft
  else
    self.ui.layoutGroup.transform.anchorMax = anchorMid
    self.ui.layoutGroup.transform.anchorMin = anchorMid
    self.ui.layoutGroup.transform.pivot = anchorMid
  end
  
  local function ShowOnePage(pageIndex)
    if self.tweenSeq ~= nil then
      self.tweenSeq:Kill(true)
      self.tweenSeq = nil
    end
    if pageIndex >= maxPage then
      return
    end
    self.tweenSeq = cs_DoTween.Sequence()
    self.tweenSeq:AppendInterval(0.05)
    self.ui.loopScroll:RefillCells(pageIndex * maxCouldContainNum)
    for i = pageIndex * maxCouldContainNum, (pageIndex + 1) * maxCouldContainNum - 1 do
      if i >= #self.rewardData.rewardIds then
        break
      end
      local item = self:__GetItemByIndex(i)
      if item ~= nil then
        item.transform.localScale = Vector3.one
        self.tweenSeq:Append(item.transform:DOScale(Vector3.zero, 0.2):From():SetEase(cs_Ease.OutBack))
        self.tweenSeq:AppendCallback(function()
          if ConfigData.game_config.itemWithGreatFxDic[item.itemCfg.id] then
            item.baseItem:LoadGetGreatRewardFx(self.resloader, 0)
          else
            item.baseItem:LoadGetRewardFx(self.resloader, 0)
          end
        end)
      end
    end
    self.tweenSeq:AppendCallback(function()
      ShowOnePage(pageIndex + 1)
    end)
  end
  
  ShowOnePage(0)
end

function UIBpSpReward:__PlaySubListRewardAnima()
  local hasBpSpReward, bpSpRewardIds, bpSpRewardNums = self.rewardData:GetBpSpRewardPreview()
  if not hasBpSpReward then
    return
  end
  local maxCouldContainNum = math.ceil((self.ui.subLoopScroll.transform.rect.width - self.ui.subLayoutGroup.padding.left) / (self.ui.subLayoutGroup.cellSize.x + self.ui.subLayoutGroup.spacing.x))
  local maxPage = math.ceil(#bpSpRewardIds / maxCouldContainNum)
  if 1 < maxPage then
    self.ui.subLayoutGroup.transform.anchorMax = anchorLeft
    self.ui.subLayoutGroup.transform.anchorMin = anchorLeft
    self.ui.subLayoutGroup.transform.pivot = anchorLeft
  else
    self.ui.subLayoutGroup.transform.anchorMax = anchorMid
    self.ui.subLayoutGroup.transform.anchorMin = anchorMid
    self.ui.subLayoutGroup.transform.pivot = anchorMid
  end
  self.ui.subLoopScroll:RefillCells()
end

function UIBpSpReward:SetIsCanClickClose(isCan)
  self.__isCanClickClose = isCan
end

function UIBpSpReward:SetCannotClickCloseTimer()
  self:SetIsCanClickClose(false)
  if self.__cannotClickCloseTimerId ~= nil then
    TimerManager:StopTimer(self.__cannotClickCloseTimerId)
  end
  self.__cannotClickCloseTimerId = TimerManager:StartTimer(3, self.__SetCanClickClose)
end

function UIBpSpReward:OnClickClose()
  self:__CloseInternal(self.exitFuncList)
end

function UIBpSpReward:OnBuyBpClick()
  self:__CloseInternal(self.buyFuncList)
end

function UIBpSpReward:__CloseInternal(funcList)
  if self.tweenSeq ~= nil and self.tweenSeq:IsPlaying() then
    self.tweenSeq.timeScale = 1000
  elseif self.__isAdded and not self.__onOPenShowReward then
    if not self.__isCanClickClose then
      return
    end
    self:Delete()
    for index, func in ipairs(funcList) do
      func()
    end
  end
end

function UIBpSpReward:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.tweenSeq ~= nil then
    self.tweenSeq:Kill(true)
    self.tweenSeq = nil
  end
  self.ui.dotween_list:DOKill()
  self.ui.dotween_sublist:DOKill()
  self.ui.dotween_rewardContent:DOKill()
  for go, item in pairs(self.__rewardItemDic) do
    item:Delete()
  end
  if self.__cannotClickCloseTimerId ~= nil then
    TimerManager:StopTimer(self.__cannotClickCloseTimerId)
    self.__cannotClickCloseTimerId = nil
  end
  base.OnDelete(self)
end

return UIBpSpReward
