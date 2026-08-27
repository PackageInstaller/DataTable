local UILotteryResult = class("UILotteryResult", UIBaseWindow)
local base = UIBaseWindow
local UINLtrResultHero = require("Game.Lottery.UI.Result.UINLtrResultHero")
local UINLtrResultHeroConvert = require("Game.Lottery.UI.Result.UINLtrResultHeroConvert")
local UINLtrResultItem = require("Game.Lottery.UI.Result.UINLtrResultItem")
local UINLtrResultFrag = require("Game.Lottery.UI.Result.UINLtrResultFrag")
local UINShareCommonBtn = require("Game.Share.UI.UINShareCommonBtn")
local eShare = require("Game.Share.eShare")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween

function UILotteryResult:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnClickClose)
  self.ui.heroItem:SetActive(false)
  self.heroPool = UIItemPool.New(UINLtrResultHero, self.ui.heroItem)
  self.ui.changeItem:SetActive(false)
  self.heroConvertPool = UIItemPool.New(UINLtrResultHeroConvert, self.ui.changeItem)
  self.ui.lotteryItem:SetActive(false)
  self.itemPool = UIItemPool.New(UINLtrResultItem, self.ui.lotteryItem)
  self.resLoader = cs_ResLoader.Create()
  self.resLoader:LoadABAssetAsync(ItemEffPatch.greetBlastThenLoop)
  self.heroItemList = {}
  self._shareBtn = UINShareCommonBtn.New()
  self._shareBtn:Init(self.ui.shareCommonButton)
  self._shareBtn:Hide()
end

function UILotteryResult:InitLtrResult(rewardElemList, isConvrtFrag, upHeroFragDic)
  self.heroConvertPool:HideAll()
  self.heroPool:HideAll()
  local upFragNum = 0
  local upHeroFragId
  self.isOnce = #rewardElemList == 1
  self:_RefreshLotteryResultUI(self.isOnce)
  self:_InitShowTween(self.isOnce)
  local allCoverDic = {}
  for k, elem in ipairs(rewardElemList) do
    if elem.heroData ~= nil then
      local heroItem = self.heroPool:GetOne()
      heroItem:InitLtrResultHero(elem.heroData, elem.isNewHero, self.resLoader)
      self:_SetItemParent(heroItem.transform, k)
      heroItem:SetStarQualityActive(elem.isNewHero)
      heroItem:SetLtrRsultHeroQulityItemHolderParent(self.ui.qualityItemHolder)
      local convertItem
      if not elem.isNewHero then
        local convertList = isConvrtFrag and heroItem:GetRepeatExtraFragList() or heroItem:GetRepeatExtraItemList()
        if convertList ~= nil and not (#convertList <= 0) then
          convertItem = self.heroConvertPool:GetOne()
          convertItem.transform:SetParent(heroItem:GetLtrResultHeroUIRoot().transform)
          convertItem:HideAllChild()
          for _, data in ipairs(convertList) do
            convertItem:GetOneChlid(data.itemCfg, data.num, self.resLoader)
            local count = allCoverDic[data.itemCfg]
            if count == nil then
              count = 0
            end
            allCoverDic[data.itemCfg] = count + data.num
          end
          self:_JoinItemTween(heroItem:GetLtrResultHeroUIRoot(), k, convertItem)
          table.insert(self.heroItemList, heroItem)
          if upHeroFragDic ~= nil and upHeroFragDic[elem.heroData.dataId] ~= nil then
            upFragNum = upFragNum + upHeroFragDic[elem.heroData.dataId]
            upHeroFragId = elem.heroData.fragId
          end
        end
      end
    else
      local item = self.itemPool:GetOne()
      item:InitLtrResultItem(elem.itemCfg, elem.num)
      self:_SetItemParent(item.transform, k)
      self:_JoinItemTween(item:GetLtrResultItemUIRoot(), k)
    end
  end
  local rewardNum = #rewardElemList
  if 1 < rewardNum and rewardNum < 5 then
    self:_FillEmptyItem(rewardNum + 1, 5)
  elseif 5 < rewardNum and rewardNum < 10 then
    self:_FillEmptyItem(rewardNum + 1, 10)
  end
  if 1 < rewardNum and rewardNum <= 5 then
    self.ui.lowerList:SetActive(false)
    self.ui.upperListLine:SetActive(false)
    self.ui.upperList.transform.anchoredPosition = Vector2.New(20, 0)
  end
  local baseInsert = #rewardElemList * 0.1
  self.showSeq:InsertCallback(baseInsert + 0.3, function()
    self.ui.btn_Close.gameObject:SetActive(true)
  end)
  self:_RefreshConverTotalCount(baseInsert, allCoverDic)
  if isConvrtFrag or upHeroFragId ~= nil then
    self._resultFragNode = UINLtrResultFrag.New()
    self._resultFragNode:Init(self.ui.obj_ConvertFrag)
    self._resultFragNode.transform:SetParent(self.isOnce and self.ui.spOnceChangeParent or self.ui.spTotalChangeParent)
    self._resultFragNode.transform.anchoredPosition = Vector2.zero
    local hasRepeatConvert = not table.IsEmptyTable(allCoverDic)
    self._resultFragNode:InitLtrResultFrag(hasRepeatConvert, upFragNum, upHeroFragId)
  end
  local shareCtr = ControllerManager:GetController(ControllerTypeId.Share, true)
  if shareCtr:IsShareUnlock() then
    self._shareId = eShare.eShareType.CommonReward
    self._shareBtn:Show()
    self._shareBtn:InitShareCommonBtn(BindCallback(self, self._OnClickShare), self._shareId)
  end
end

function UILotteryResult:_FillEmptyItem(fromIdx, toIdx)
  for i = fromIdx, toIdx do
    local item = self.itemPool:GetOne()
    item:SetLtrResultItemEmpty()
    self:_SetItemParent(item.transform, i)
    self:_JoinItemTween(item:GetLtrResultItemUIRoot(), i)
  end
end

function UILotteryResult:_RefreshLotteryResultUI(isOnce)
  self.ui.obj_isOnce:SetActive(isOnce)
  local totalChangeParent = isOnce and self.ui.onceTotalParent or self.ui.tenTotalParent
  self.ui.rect_totalChange:SetParent(totalChangeParent)
  self.ui.rect_totalChange.localPosition = Vector3.zero
  self.ui.obj_isTen:SetActive(not isOnce)
end

function UILotteryResult:_RefreshConverTotalCount(baseInsert, allCoverDic)
  self.__isShowFragChanged = false
  self.showSeq:InsertCallback(baseInsert + 0.15, function()
    self.ui.rect_totalChange.gameObject:SetActive(false)
    for cfg, count in pairs(allCoverDic) do
      if cfg.id == 1006 then
        self.ui.tex_totalItemCount.text = count
        self.ui.img_totalItemPic.sprite = CRH:GetSprite(cfg.icon)
        self.ui.rect_totalChange.gameObject:SetActive(true)
        self.__isShowFragChanged = true
        GuideManager:TryTriggerGuide(eGuideCondition.InLotteryFragChanged)
        break
      end
    end
    if self._resultFragNode ~= nil then
      self._resultFragNode:Show()
    end
  end)
end

function UILotteryResult:IsLotteryFragChanged()
  return self.__isShowFragChanged
end

function UILotteryResult:GetLotteryFragChangeUI()
  return self.ui.rect_totalChange
end

function UILotteryResult:_InitShowTween(isOnce)
  self.ui.btn_Close.gameObject:SetActive(false)
  local sequence = cs_DoTween.Sequence()
  if not isOnce then
    sequence:Insert(0, self.ui.upper:DOAnchorPosX(self.ui.upper.anchoredPosition.x - 300, 1):From())
    sequence:Insert(0, self.ui.lowerArrow:DOAnchorPosX(self.ui.lowerArrow.anchoredPosition.x - 300, 1.2):From())
    sequence:Insert(0, self.ui.upperArrow:DOAnchorPosX(self.ui.upperArrow.anchoredPosition.x + 300, 1.2):From())
    sequence:Insert(0, self.ui.lowerRight:DOAnchorPosX(self.ui.lowerRight.anchoredPosition.x + 300, 1):From())
  end
  self.showSeq = sequence
end

function UILotteryResult:_JoinItemTween(canvasGroup, index, convertItem)
  local tween, deplay
  if not self.isOnce then
    if index <= 5 then
      deplay = (index - 1) * 0.1
      tween = canvasGroup.transform:DOLocalMoveY(150, 0.15):From():SetDelay(deplay)
    else
      deplay = (10 - index) * 0.1
      tween = canvasGroup.transform:DOLocalMoveY(-150, 0.15):From():SetDelay(deplay)
    end
  else
    deplay = 0.2
    tween = canvasGroup.transform:DOLocalMoveY(150, 0.15):From():SetDelay(deplay)
  end
  
  function tween.onComplete()
    local item = self.heroItemList[index]
    if not IsNull(item) then
      item:ShowFlashFx()
    end
    if convertItem ~= nil then
      convertItem:ShowHeroConvertFx()
    end
  end
  
  self.showSeq:Insert(0, tween)
  canvasGroup.alpha = 0
  self.showSeq:Insert(0, canvasGroup:DOFade(1, 0.6):SetDelay(deplay))
end

function UILotteryResult:BindLotteryResultExit(exitAction)
  self.__exitAction = exitAction
end

function UILotteryResult:_SetItemParent(transform, index)
  if self.isOnce then
    transform:SetParent(self.ui.obj_isOnce.transform)
    return
  end
  if index <= 5 then
    transform:SetParent(self.ui.heroList_Up)
  else
    transform:SetParent(self.ui.heroList_Low)
  end
end

function UILotteryResult:_OnClickShare()
  UIManager:ShowWindowAsync(UIWindowTypeID.Share, function(win)
    if win == nil then
      return
    end
    win:SetShareBeforeCaptureFunc(function()
      self:_ShareShow(false)
    end):SetShareAfterCaptureFunc(function()
      self:_ShareShow(true)
    end):InitShare(self._shareId)
  end)
end

function UILotteryResult:_ShareShow(show)
  self._shareBtn.gameObject:SetActive(show)
  self.ui.tenTotalParent.gameObject:SetActive(show)
  self.ui.onceTotalParent.gameObject:SetActive(show)
  self.ui.spTotalChangeParent.gameObject:SetActive(show)
  self.ui.spOnceChangeParent.gameObject:SetActive(show)
  for k, item in ipairs(self.heroConvertPool.listItem) do
    item.gameObject:SetActive(show)
  end
  self.ui.btn_Close.gameObject:SetActive(show)
end

function UILotteryResult:BackAction()
  self:Delete()
  if self.__exitAction ~= nil then
    self.__exitAction()
  end
end

function UILotteryResult:_OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UILotteryResult:OnDelete()
  if self._resultFragNode ~= nil then
    self._resultFragNode:Delete()
  end
  self.heroPool:DeleteAll()
  self.heroConvertPool:DeleteAll()
  self.itemPool:DeleteAll()
  self._shareBtn:Delete()
  self.resLoader:Put2Pool()
  self.resLoader = nil
  if self.showSeq ~= nil then
    self.showSeq:Kill()
    self.showSeq = nil
  end
  base.OnDelete(self)
end

return UILotteryResult
