local UIEventBattlePass = class("UIEventBattlePass", UIBaseWindow)
local base = UIBaseWindow
local UINBattlePassTable = require("Game.BattlePass.UI.UINBattlePassTable")
local UIHeroSkinShowTool = require("Game.CommonUI.Skin.UIHeroSkinShowTool")
local BattlePassEnum = require("Game.BattlePass.BattlePassEnum")
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")

function UIEventBattlePass:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Task, self, self.OnBtnTaskClicked)
  UIUtil.AddButtonListener(self.ui.btn_BuyLevel, self, self.OnBtnBuyLevelClicked)
  UIUtil.AddButtonListener(self.ui.btn_Buy, self, self.OnBtnBuyClicked)
  UIUtil.AddButtonListener(self.ui.btn_GetAll, self, self.OnBtnGetAllClicked)
  UIUtil.AddButtonListener(self.ui.btn_Tips, self, self.OnBtnTipsClicked)
  self.originExpWidth = self.ui.img_ExpFill.transform.sizeDelta.x
  self.originExpHeight = self.ui.img_ExpFill.transform.sizeDelta.y
  self.passTableNode = UINBattlePassTable.New()
  self.passTableNode:Init(self.ui.passTable)
  self.skinTool = UIHeroSkinShowTool.New()
  self.skinTool:InitSkinShow(self.ui.heroHolder, self.ui.picHolder, self:GetWindowSortingLayer(), "BattlePass")
  self.__onBattlePassDataChange = BindCallback(self, self.OnBattlePassDataChange)
  MsgCenter:AddListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
  self._defaultColor1 = self.ui.img_BuyLevel.color
  self._defaultColor2 = self.ui.tex_BuyLevel.color
  self._disableColor1 = Color.New(0.41, 0.41, 0.41)
  self._disableColor2 = Color.New(0.76, 0.76, 0.76)
end

function UIEventBattlePass:InitBattlePassUI(activityId)
  local passInfo = PlayerDataCenter.battlepassData.passInfos[activityId]
  self.passInfo = passInfo
  if self.passInfo == nil then
    return
  end
  self:InitBattlePassStaticUI()
  self:UpdateBattlePassBase(passInfo)
  self.passTableNode:InitBattlePassTable(self.passInfo)
end

function UIEventBattlePass:UpdateBattlePassBase(passInfo)
  self.ui.btn_Buy.gameObject:SetActive(not passInfo.unlockUltimate)
  self.ui.lockSenior:SetActive(not passInfo.unlockSenior)
  local index = passInfo.unlockSenior and 1 or 0
  if not IsNull(self.ui.tex_Buy) then
    self.ui.tex_Buy:SetIndex(index)
  end
  self.ui.tex_Level:SetIndex(0, tostring(passInfo.level))
  local fillAmount = self.passInfo.exp / self.passInfo:GetPassCurLevelExp()
  if self.passInfo:IsPassFullLevel() and not self.passInfo:HasBpOverLimitReward() then
    self.ui.tex_Exp:SetIndex(0)
    fillAmount = 1
  else
    self.ui.tex_Exp:SetIndex(1, tostring(passInfo.exp), tostring(self.passInfo:GetPassCurLevelExp()))
  end
  if self.passInfo:IsPassFullLevel() then
    self.ui.img_BuyLevel.color = self._disableColor1
    self.ui.tex_BuyLevel.color = self._disableColor2
  else
    self.ui.img_BuyLevel.color = self._defaultColor1
    self.ui.tex_BuyLevel.color = self._defaultColor2
  end
  self.ui.slider_ExpFill.value = fillAmount
  self.ui.btn_GetAll.gameObject:SetActive(self.passInfo:PassHaveRewardTake())
  self.ui.tex_LimitExp.text = string.format("%d/%d", self.passInfo.weeklyExp, self.passInfo:GetWeeklyExpLimit())
  local endTime = self.passInfo:GetBattlePassEndTime()
  if endTime < 0 then
    self.ui.tex_TimeTips.gameObject:SetActive(false)
    return
  else
    self.ui.tex_TimeTips.gameObject:SetActive(true)
    self:UpdateBattlePassEndTime()
    TimerManager:StopTimer(self.__endTimer)
    self.__endTimer = TimerManager:StartTimer(2, self.UpdateBattlePassEndTime, self, false)
  end
end

function UIEventBattlePass:UpdateBattlePassEndTime()
  local endTime = self.passInfo:GetBattlePassEndTime()
  local lastTime = math.max(math.floor(endTime - PlayerDataCenter.timestamp), 0)
  local d, h, m, s = TimeUtil:TimestampToTimeInter(lastTime, false, true)
  if 0 < s then
    m = m + 1
  end
  self.ui.tex_TimeTips:SetIndex(0, tostring(d), tostring(h), tostring(m))
end

function UIEventBattlePass:OnBattlePassDataChange(id)
  if id ~= self.passInfo.id then
    return
  end
  self:UpdateBattlePassBase(self.passInfo)
  self.passTableNode:UpdateBattlePassTable(self.passInfo)
end

function UIEventBattlePass:InitBattlePassStaticUI()
  local passCfg = self.passInfo.passCfg
  local skinCfg = ConfigData.skin[passCfg.banner_skin]
  self.ui.tex_Tips.text = string.format(LanguageUtil.GetLocaleText(passCfg.describe), LanguageUtil.GetLocaleText(skinCfg.name))
  self.skinTool:ShowSkinById(passCfg.banner_skin)
end

function UIEventBattlePass:OnBtnTipsClicked()
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(window)
    if window == nil then
      return
    end
    window:InitCommonInfo(ConfigData:GetTipContent(self.passInfo.passCfg.tips_desc), ConfigData:GetTipContent(326))
  end)
end

function UIEventBattlePass:OnBtnTaskClicked()
  JumpManager:Jump(JumpManager.eJumpTarget.DynTask, nil, nil, {
    TaskEnum.eTaskType.DailyTask
  }, true)
end

function UIEventBattlePass:OnBtnBuyLevelClicked()
  if self.passInfo:IsPassFullLevel() then
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(325))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassBuyLevel, function(buyWindow)
    if buyWindow == nil then
      return
    end
    buyWindow:InitPassBuyLevelUI(self.passInfo)
  end)
end

function UIEventBattlePass:OnBtnBuyClicked()
  UIManager:ShowWindowAsync(UIWindowTypeID.EventBattlePassPurchase, function(purchaseWindow)
    if purchaseWindow == nil then
      return
    end
    purchaseWindow:InitBattlePassPurchaseUI(self.passInfo)
  end)
end

function UIEventBattlePass:OnBtnGetAllClicked()
  local battlepassCtrl = ControllerManager:GetController(ControllerTypeId.BattlePass, true)
  battlepassCtrl:TakeBattlePassReward(self.passInfo.id, 0, BattlePassEnum.TakeWay.All)
end

function UIEventBattlePass:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.BattlePassChange, self.__onBattlePassDataChange)
  TimerManager:StopTimer(self.__endTimer)
  if self.skinTool ~= nil then
    self.skinTool:OnDelete()
    self.skinTool = nil
  end
  base.OnDelete(self)
end

return UIEventBattlePass
