local base = UIBaseWindow
local UIReinforceCardSave = class("UIReinforceCardSave", base)
local UINRfCdSaveSCardItem = require("Game.Reinforce.UI.CardSave.UINRfCdSaveSCardItem")
local UINRfCardFacBig = require("Game.Reinforce.UI.FactorCard.UINRfCardFacBig")
local UINRfCdSaveEmptyCardItem = require("Game.Reinforce.UI.CardSave.UINRfCdSaveEmptyCardItem")
local cs_MessageCommon = CS.MessageCommon

function UIReinforceCardSave:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_RandomRule, self, self._OnClickRandomRule)
  UIUtil.AddButtonListener(self.ui.btn_Comfirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self._OnClickBack)
  self._card = UINRfCardFacBig.New()
  self._card:Init(self.ui.uINRfCardFacBig)
  self._card:SetRfCardFacBigDetailFunc(BindCallback(self, self._ShowDetail))
  self._resloader = CS.ResLoader.Create()
  self._emptyCardPool = UIItemPool.New(UINRfCdSaveEmptyCardItem, self.ui.emptyItem, false)
  self._smallCardPool = UIItemPool.New(UINRfCdSaveSCardItem, self.ui.facItem, false)
  self._OnClickSmallCardFunc = BindCallback(self, self._OnClickSamllCard)
  self._ShowSmallCardDetailFunc = BindCallback(self, self._ShowSmallCardDetail)
  self.ui.tex_Confirm:SetIndex(1)
  self._DefaultConfirmBtnColor = self.ui.btn_Comfirm.targetGraphic.color
  CS.DG.Tweening.DOTween.Sequence():Append(self.ui.leftCg:DOFade(0, 0.21):From()):Join(self.ui.leftCg.transform:DOScale(0.6, 0.3):From()):Append(self.ui.rightCg:DOFade(0, 0.21):From()):SetLink(self.gameObject)
end

function UIReinforceCardSave:InitReinforceCardSave(newCardData, cardDataDic, rfCdAllData, closeFunc)
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self._BackAction):PushTopStatusDataToBackStack(true)
  self._newCardData = newCardData
  self._rfCdAllData = rfCdAllData
  self._rfEpMainCfg = rfCdAllData:GetRfEpMainCfg()
  self._cardDataDic = cardDataDic
  self._closeFunc = closeFunc
  self._card:InitRfCardFacBig(newCardData, self._resloader, false)
  self:_UpdStage()
  local sptCardOrderDic = {}
  for i, order in pairs(rfCdAllData:GetRfFactorCardAsSupport()) do
    sptCardOrderDic[order] = order
  end
  self._emptyItemDic = {}
  self._emptyCardPool:HideAll()
  self._smallCardPool:HideAll()
  local ownNum = 0
  for i = 1, self._rfEpMainCfg.factor_num do
    local smallCardData = cardDataDic[i]
    if smallCardData == nil then
      local emptyIetm = self._emptyCardPool:GetOne()
      emptyIetm:InitRfCdSaveEmptyCardItem(i, self._OnClickSmallCardFunc)
      self._emptyItemDic[i] = emptyIetm
    else
      local smallItem = self._smallCardPool:GetOne()
      smallItem:InitRfCdSaveSCardItem(smallCardData, self._resloader, self._OnClickSmallCardFunc, self._ShowSmallCardDetailFunc)
      local isSpt = sptCardOrderDic[i]
      smallItem:SetRfCdIsSupport(isSpt)
      ownNum = ownNum + 1
    end
  end
  self.ui.tex_Num:SetIndex(0, tostring(ownNum), tostring(self._rfEpMainCfg.factor_num))
  local guideId = ConfigData.reinforce_exploration_main[rfCdAllData:GetRfCdAllActFrameId()].save_guide_id
  GuideManager:StartNewTriggerGuide(guideId)
end

function UIReinforceCardSave:_ShowDetail(rfCardData, isFmt, isUpd)
  if isUpd then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailFac, function(win)
    if win == nil then
      return
    end
    win:InitRfCardDetailFac(rfCardData, isFmt)
  end)
end

function UIReinforceCardSave:_OnClickRandomRule()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfoByRule(self._rfEpMainCfg.factor_rule, true)
    UIUtil.SetTopStatusBtnShow(false, false)
  end)
end

function UIReinforceCardSave:_OnClickSamllCard(idx, itemTransform)
  self.ui.obj_Select.gameObject:SetActive(true)
  self.ui.obj_Select:SetParent(itemTransform)
  self.ui.obj_Select.anchoredPosition = Vector2.zero
  self._seletedIdx = idx
  self:_UpdStage()
  if self._cardDataDic[idx] == nil then
    local emptyItem = self._emptyItemDic[idx]
    if self._lastSelectedEmptyItem ~= emptyItem then
      if self._lastSelectedEmptyItem ~= nil then
        self._lastSelectedEmptyItem:SetRfCdSaveEmptyCardItemSelect(false)
      end
      emptyItem:SetRfCdSaveEmptyCardItemSelect(true)
      self._lastSelectedEmptyItem = emptyItem
    end
    self.ui.tex_Confirm:SetIndex(1)
  else
    self.ui.tex_Confirm:SetIndex(0)
  end
end

function UIReinforceCardSave:_ShowSmallCardDetail(smallCardItem, facCardData, isFmt)
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardDetailFac, function(win)
    if win == nil then
      return
    end
    win:InitRfCardDetailFac(facCardData, isFmt)
  end)
end

function UIReinforceCardSave:_UpdStage()
  self.ui.btn_Comfirm.targetGraphic.color = self._seletedIdx == nil and Color.gray or self._DefaultConfirmBtnColor
end

function UIReinforceCardSave:_OnClickConfirm()
  if self._seletedIdx == nil then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(59010))
    return
  end
  
  local function confirmFunc()
    local activityId = self._rfCdAllData:GetRfCdAllActFrameId()
    NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_FactorCard_SaveFresh(activityId, true, self._seletedIdx, function()
      self._newCardData:SetRfCdFactorOrder(self._seletedIdx)
      self._rfCdAllData:AddRfFactorCardData(self._newCardData)
      self:ExitRfCardSave()
    end)
    self:ExitRfCardSave()
  end
  
  if self._cardDataDic[self._seletedIdx] ~= nil and PlayerDataCenter.cacheSaveData:GetEnableRfCardSaveReplaceTip() then
    local windonw = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    local msg = ConfigData:GetTipContent(59011)
    if self._rfCdAllData:GetRfFactorCardAsSupportPosByCardOrderId(self._seletedIdx) > 0 then
      msg = ConfigData:GetTipContent(59030)
    end
    windonw:ShowTextBoxWithYesAndNo(msg, confirmFunc)
    windonw:ShowDontRemindTog(function(flag)
      PlayerDataCenter.cacheSaveData:SetEnableRfCardSaveReplaceTip(not flag)
    end, false)
    return
  end
  confirmFunc()
end

function UIReinforceCardSave:_OnClickBack()
  local function exitFunc()
    local activityId = self._rfCdAllData:GetRfCdAllActFrameId()
    
    NetworkManager:GetNetwork(NetworkTypeID.Reinforce):CS_FactorCard_SaveFresh(activityId, false, nil, function()
      self:ExitRfCardSave()
    end)
  end
  
  if #self._emptyCardPool.listItem > 0 and PlayerDataCenter.cacheSaveData:GetEnableRfCardSaveSkipTip() then
    local windonw = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    windonw:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(59012), exitFunc)
    windonw:ShowDontRemindTog(function(flag)
      PlayerDataCenter.cacheSaveData:SetEnableRfCardSaveSkipTip(not flag)
    end, false)
    return
  end
  exitFunc()
end

function UIReinforceCardSave:ExitRfCardSave()
  UIUtil.OnClickBackByUiTab(self)
end

function UIReinforceCardSave:_BackAction()
  self:Delete()
  if self._closeFunc then
    self._closeFunc()
  end
end

function UIReinforceCardSave:OnDelete()
  self._resloader:Put2Pool()
  self._resloader = nil
  self._card:Delete()
  self._emptyCardPool:DeleteAll()
  self._smallCardPool:DeleteAll()
  base.OnDelete(self)
end

return UIReinforceCardSave
