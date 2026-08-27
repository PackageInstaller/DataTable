local UIActivityExplorationFundMain = class("UIActivityExplorationFundMain", UIBaseWindow)
local base = UIBaseWindow
local UINActivityExplorationFundPageEntryItem = require("Game.ActivityExplorationFund.UI.UINActivityExplorationFundPageEntryItem")
local UINActivityExplorationFundRewardItem = require("Game.ActivityExplorationFund.UI.UINActivityExplorationFundRewardItem")

function UIActivityExplorationFundMain:OnInit()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.__BackAction):PushTopStatusDataToBackStack()
  self._pageItemPool = UIItemPool.New(UINActivityExplorationFundPageEntryItem, self.ui.obj_PageEntryItem, false)
  self._mainCtrl = ControllerManager:GetController(ControllerTypeId.ActivityExplorationFund, true)
  self.__OnExplorationFundPageChangeCallback = BindCallback(self, self.__OnExplorationFundPageChange)
  self.__ForceRefreshExplorationFundPageCallback = BindCallback(self, self.__ForceRefreshExplorationFundPage)
  MsgCenter:AddListener(eMsgEventId.ActivityExplorationFundChange, self.__ForceRefreshExplorationFundPageCallback)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.__OnClickFundGetAll)
  UIUtil.AddButtonListener(self.ui.btn_Pay, self, self.__OnClickFundPay)
  self._itemDic = {}
  self.ui.scrollRect.onInstantiateItem = BindCallback(self, self.__OnNewItem)
  self.ui.scrollRect.onChangeItem = BindCallback(self, self.__OnChangeItem)
end

function UIActivityExplorationFundMain:InitExplorationFundMain(actId)
  self.data = self._mainCtrl:GetExplorationFundDataByActId(actId)
  if self.data == nil then
    return
  end
  local id = self.data:GetLastCanGetRewardFoundId()
  self:__OnExplorationFundPageChange(self.data:GetExplorationFundIds()[id], id)
end

function UIActivityExplorationFundMain:__OnExplorationFundPageChange(newFundId, pageIndex)
  if self._prefFundId == newFundId then
    return
  end
  local singleFundData = self.data:GetExplorationFundDataById(newFundId)
  if singleFundData == nil then
    return
  end
  self._singleFundData = singleFundData
  self._prefFundId = newFundId
  self._pageIndex = pageIndex
  self:__RefreshExplorationFundPage(newFundId, pageIndex)
end

function UIActivityExplorationFundMain:__ForceRefreshExplorationFundPage()
  self:__RefreshExplorationFundPage(self._prefFundId, self._pageIndex)
end

function UIActivityExplorationFundMain:__RefreshExplorationFundPage(newFundId, pageIndex)
  local fundPageIds = self.data:GetExplorationFundIds()
  self._pageItemPool:HideAll()
  for index = 1, #fundPageIds do
    local fundId = fundPageIds[index]
    local pageItem = self._pageItemPool:GetOne()
    pageItem:InitExplorationFundPageEntryItem(self.data:GetExplorationFundDataById(fundId), index, fundId, fundId == newFundId, index == #fundPageIds, self.__OnExplorationFundPageChangeCallback)
  end
  local rewardLevels = self._singleFundData:GetSingleFundDataRewardLevels()
  self.ui.scrollRect.totalCount = #rewardLevels
  if self._prefFundId == newFundId then
    self.ui.scrollRect:RefillCells()
  else
    self.ui.scrollRect:RefreshCells()
  end
  local uiCfg = self._singleFundData:GetSingleFundDataFundCfg()
  self.ui.tex_Percent.text = LanguageUtil.GetLocaleText(uiCfg.rebate_num)
  self.ui.tex_Order.text = string.format("%02d", pageIndex)
  self.ui.tex_RewardDes.text = LanguageUtil.GetLocaleText(uiCfg.reward_tips)
  local isUnlockFund = self._singleFundData:GetIsSingleFundDataUnlock()
  local isUnlockFundSenior = self._singleFundData:GetIsSingleFundDataUnlockSenior()
  local isCanBuyFundSenior = self._singleFundData:GetIsSingleFundDataCanBuySenior()
  local isRewardCanPick = self._singleFundData:GetSingleFundDataHasCompleteReward()
  local isFundOver = self._singleFundData:GetIsFundOver()
  self.ui.obj_AllMask:SetActive(not isUnlockFund)
  self.ui.obj_ExMask:SetActive(not isUnlockFundSenior and isUnlockFund)
  self.ui.btn_Pay.gameObject:SetActive(not isUnlockFundSenior and isUnlockFund)
  self.ui.btn_GetAll.interactable = isUnlockFund and isRewardCanPick
  if isFundOver then
    self.ui.tex_GetAll:SetIndex(2)
  elseif isUnlockFund then
    self.ui.tex_GetAll:SetIndex(0)
  else
    self.ui.tex_GetAll:SetIndex(1, self._singleFundData:GetSingleFundDataLockDes())
  end
  self.ui.obj_CanBuyHolder:SetActive(isCanBuyFundSenior)
  self.ui.obj_LockBuyHolder:SetActive(not isCanBuyFundSenior)
  self.ui.tex_Cost.text = self._singleFundData:GetSingleFundDataSeniorPrice()
end

function UIActivityExplorationFundMain:__OnClickFundGetAll()
  self._mainCtrl:ReqTakeExplorationFundReward(self.data:GetActId(), self._singleFundData.id)
end

function UIActivityExplorationFundMain:__OnClickFundPay()
  self._mainCtrl:ReqBuyExplorationFundSenior(self.data:GetActId(), self._singleFundData.id)
end

function UIActivityExplorationFundMain:__OnNewItem(go)
  local goodItem = UINActivityExplorationFundRewardItem.New()
  goodItem:Init(go)
  self._itemDic[go] = goodItem
end

function UIActivityExplorationFundMain:__OnChangeItem(go, index)
  local goodItem = self._itemDic[go]
  if goodItem == nil then
    error("Can't find goodItem by gameObject")
    return
  end
  goodItem:InitExplorationFundRewardItem(index + 1, self._singleFundData)
end

function UIActivityExplorationFundMain:__BackAction()
  self:Delete()
end

function UIActivityExplorationFundMain:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.ActivityExplorationFundChange, self.__ForceRefreshExplorationFundPageCallback)
  base.OnDelete(self)
end

return UIActivityExplorationFundMain
