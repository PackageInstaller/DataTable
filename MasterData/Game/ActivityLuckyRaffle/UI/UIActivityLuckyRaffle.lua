local UIActivityLuckyRaffle = class("UIActivityLuckyRaffle", UIBaseWindow)
local base = UIBaseWindow
local UINLuckyRafflePageItem = require("Game.ActivityLuckyRaffle.UI.UINLuckyRafflePageItem")
local UINLuckyRaffleMainInfo = require("Game.ActivityLuckyRaffle.UI.UINLuckyRaffleMainInfo")
local ActivityFrameUtil = require("Game.ActivityFrame.ActivityFrameUtil")
local cs_ResLoader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon

function UIActivityLuckyRaffle:OnInit()
  self.luckyRaffleCtrl = ControllerManager:GetController(ControllerTypeId.LuckyRaffle, true)
  self.pageItemPool = UIItemPool.New(UINLuckyRafflePageItem, self.ui.pageItem, false)
  UIUtil.AddButtonListener(self.ui.btn_address, self, self.OnClickInputAddress)
  UIUtil.AddButtonListener(self.ui.btn_rule, self, self.OnClickRaffleRule)
  UIUtil.AddButtonListener(self.ui.btn_vote, self, self.OnClickRaffleVote)
  UIUtil.AddButtonListener(self.ui.btn_Check, self, self.OnClickRaffleRandomRewardShow)
  self.clickPageItemRefreshMainInfoCallback = BindCallback(self, self.OnClickPageItemRefreshMainInfo)
  self.mainInfo = UINLuckyRaffleMainInfo.New()
  self.mainInfo:Init(self.ui.mainInfo)
  self.resloader = cs_ResLoader.Create()
  self._OnItemChangeFunc = BindCallback(self, self.ItemChangeCallback)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

function UIActivityLuckyRaffle:InitLuckyRaffle(actId)
  self.luckyRaffleData = self.luckyRaffleCtrl:GetLuckyRaffleDataByActId(actId)
  self.allLuckyRaffleCfg = self.luckyRaffleData:GetLuckyRaffleInfoCfg()
  self.luckyRaffleMainCfg = self.luckyRaffleData:GetLuckyRaffleMainCfg()
  self._ruleId = ConfigData.activity[self.luckyRaffleData:GetActFrameId()].rule_id
  if self._timerId == nil then
    self._timerId = TimerManager:StartTimer(1, BindCallback(self, self.__TimeCountdown), self)
  end
  self:__TimeCountdown()
  self:GenAllLuckyRafflePageItem()
  self:ReqRafflePercent()
  self:RefreshAddressDotShow()
end

function UIActivityLuckyRaffle:RefreshAddressDotShow()
  local showAddressRedDot = self.luckyRaffleData:GetLuckyRaffleAddressRedDot()
  self.ui.obj_addressRedDot:SetActive(showAddressRedDot)
end

function UIActivityLuckyRaffle:ReqRafflePercent()
  NetworkManager:GetNetwork(NetworkTypeID.Object):CS_Rank_Percent(self.luckyRaffleMainCfg.rank_id, 1, #self.allLuckyRaffleCfg + 1, function(objList)
    local data = objList[0]
    self:RefreshAllLuckyRafflePagePercentage(data.numPerInterval, data.total)
  end)
end

function UIActivityLuckyRaffle:GenAllLuckyRafflePageItem()
  for id, cfg in pairs(self.allLuckyRaffleCfg) do
    local pageItem = self.pageItemPool:GetOne(true)
    pageItem:InitLuckyRafflePageItem(cfg, self.luckyRaffleData, self.clickPageItemRefreshMainInfoCallback)
  end
  self:OnClickPageItemRefreshMainInfo(1)
end

function UIActivityLuckyRaffle:RefreshAllLuckyRafflePagePercentage(perInterval, total)
  for id, pageItem in pairs(self.pageItemPool.listItem) do
    pageItem:SetRafflePercent(perInterval[id] or 0, total)
  end
end

function UIActivityLuckyRaffle:RefreshLuckyRaffleAlreadyVoteNum()
  self.mainInfo:RefreshVoteNum()
end

function UIActivityLuckyRaffle:OnClickPageItemRefreshMainInfo(poolId)
  self.nowSelectRaffleCfg = self.allLuckyRaffleCfg[poolId]
  for _, pageItem in pairs(self.pageItemPool.listItem) do
    if pageItem:GetRafflePagePoolId() == poolId then
      pageItem:SetRafflePageSelected(true)
    else
      pageItem:SetRafflePageSelected(false)
    end
  end
  self.mainInfo:InitNLuckyRaffleMainInfo(self.nowSelectRaffleCfg, self.luckyRaffleData, self.resloader)
  self.ui.tex_raffle_tip.text = LanguageUtil.GetLocaleText(self.nowSelectRaffleCfg.raffle_tip)
  local itemId = self.nowSelectRaffleCfg.raffle_item
  self.ui.img_smallRaffleItem.sprite = CRH:GetSpriteByItemId(itemId, false)
  self.ui.img_bigRaffleItem.sprite = CRH:GetSpriteByItemId(itemId, false)
  self.ui.tex_itemCount.text = tostring(PlayerDataCenter:GetItemCount(itemId))
end

function UIActivityLuckyRaffle:OnClickRaffleRule()
  PlayerClickCollectManager:BtnClickNumCollect(1006)
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonInfo, function(win)
    if win then
      win:InitCommonInfoByRule(self._ruleId, true)
    end
  end)
end

function UIActivityLuckyRaffle:OnClickRaffleVote()
  if PlayerDataCenter:GetItemCount(self.nowSelectRaffleCfg.raffle_item) == 0 then
    CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(19002))
    return
  end
  self.luckyRaffleCtrl:LuckyRaffleVote(self.luckyRaffleData:GetActId(), self.nowSelectRaffleCfg.raffle_id)
end

function UIActivityLuckyRaffle:OnClickRaffleRandomRewardShow()
  UIManager:ShowWindowAsync(UIWindowTypeID.RewardPreview, function(window)
    if window == nil then
      return
    end
    window:InitRewardPreviewNotItem(self.nowSelectRaffleCfg.all_reward_ids, self.nowSelectRaffleCfg.all_reward_nums)
  end)
end

function UIActivityLuckyRaffle:OnClickInputAddress()
  self.luckyRaffleData:SetLuckyRaffleAddressLooked()
  self:RefreshAddressDotShow()
  self.luckyRaffleCtrl:EnterInfoPaper()
end

function UIActivityLuckyRaffle:ItemChangeCallback()
  local itemId = self.nowSelectRaffleCfg.raffle_item
  self.ui.tex_itemCount.text = tostring(PlayerDataCenter:GetItemCount(itemId))
end

function UIActivityLuckyRaffle:__TimeCountdown()
  if self._expireTime == nil or self._expireTime > PlayerDataCenter.timestamp then
    local title, timeStr, expireTime = ActivityFrameUtil.GetShowEndTimeStr(self.luckyRaffleData)
    self.ui.tex_timeTitle.text = title
    self.ui.tex_EndTime.text = timeStr
    self._expireTime = expireTime
  end
  local diffStr, diff = ActivityFrameUtil.GetCountdownTimeStr(self._expireTime)
  self.ui.tex_LastTime.text = diffStr
  if diff <= 0 then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
end

function UIActivityLuckyRaffle:OnDelete()
  if self._timerId ~= nil then
    TimerManager:StopTimer(self._timerId)
    self._timerId = nil
  end
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self.pageItemPool:DeleteAll()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
end

return UIActivityLuckyRaffle
