local UINEventComebackExchange = require("Game.ActivityComeback.UI.UINEventComebackExchange")
local UINEventComebackLiteExchange = class("UINEventComebackLiteExchange", UINEventComebackExchange)
local base = UINEventComebackExchange
local CS_Resloader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon
local UINEventComebackExchangeReward = require("Game.ActivityComeback.UI.UINEventComebackExchangeReward")
local UINEventComebackLiteExchangeShow = require("Game.ActivityComeback.UI.UINEventComebackLiteExchangeShow")

function UINEventComebackLiteExchange:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Des, self, self.__OnClickShow)
  self.__OnClickChangeNumAddCallback = BindCallback(self, self.__OnClickChangeNum, true)
  self.__OnClickChangeNumReduceCallback = BindCallback(self, self.__OnClickChangeNum, false)
  self.ui.btn_Min.onPress:AddListener(self.__OnClickChangeNumReduceCallback)
  UIUtil.AddButtonListener(self.ui.btn_Min, self.__OnClickChangeNumReduceCallback)
  UIUtil.AddButtonListener(self.ui.btn_Least, self, self.__OnhangeMinNum)
  self.ui.btn_Add.onPress:AddListener(self.__OnClickChangeNumAddCallback)
  UIUtil.AddButtonListener(self.ui.btn_Add, self.__OnClickChangeNumAddCallback)
  UIUtil.AddButtonListener(self.ui.btn_Max, self, self.__OnChangeMaxNum)
  UIUtil.AddButtonListener(self.ui.btn_Exchange, self, self.__OnClickLottery)
  self.ui.inputField.onEndEdit:AddListener(BindCallback(self, self.__OnClickInputNum))
  self._itemPool = UIItemPool.New(UINEventComebackExchangeReward, self.ui.itemNode)
  self.ui.itemNode:SetActive(false)
  self._colorLottery = self.ui.img_Exchange.color
  self.ui.tex_Des.text = ConfigData:GetTipContent(7409)
  self.__RefreshLotteryTimesStateCallback = BindCallback(self, self.__RefreshLotteryTimesState)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshLotteryTimesStateCallback)
  self._rewardShowNode = UINEventComebackLiteExchangeShow.New()
  self._rewardShowNode:Init(self.ui.rewardList)
end

function UINEventComebackLiteExchange:InitComebackExchange(id)
  local activityRoundCtrl = ControllerManager:GetController(ControllerTypeId.ActivityRound)
  if activityRoundCtrl == nil then
    error("奖池抽奖活动不存在")
    return
  end
  self._roundData = activityRoundCtrl:GetActivityRound(id)
  if self._roundData == nil then
    error("奖池抽奖活动不存在")
    return
  end
  local curRoundId = self._roundData:GetCurRoundId()
  self._poolData = self._roundData:GetRoundPoolData(curRoundId)
  self._roundIdList = self._roundData:GetRoundIds()
  local allCount = #self._roundIdList
  self.curIndex = table.indexof(self._roundIdList, curRoundId)
  self:__RefreshPool()
  self._rewardShowNode:Hide()
end

function UINEventComebackLiteExchange:__RefreshPool()
  self.ui.tex_Count.text = self._poolData:GetRoundTimes() .. "/" .. self._poolData:GetRoundTotalTimes()
  local poolparaCfg = self._poolData:GetPoolParaCfg()
  self.ui.tex_Title.text = LanguageUtil.GetLocaleText(poolparaCfg.pool_name)
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self._resloader = CS_Resloader.Create()
  self.ui.img_Gift.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(PathConsts:GetRoundRewardPoolPic(poolparaCfg.poolimg_name), function(texture)
    if IsNull(texture) then
      error("comeback_exchange texture MISS")
      return
    end
    self.ui.img_Gift.gameObject:SetActive(true)
    self.ui.img_Gift.texture = texture
  end)
  local bigRewardIds = poolparaCfg.reward_id
  self._rewardItemDic = {}
  self._itemPool:HideAll()
  for _, rewardId in ipairs(bigRewardIds) do
    local usedMun, allNum = self._poolData:GetRoundSingleRewardCount(rewardId)
    local poolContent = poolparaCfg.poolContent[rewardId]
    local item = self._itemPool:GetOne()
    local remainCount = allNum - usedMun
    item:InitExchangeReward(poolContent.rewardId, poolContent.rewardNum, remainCount)
    self._rewardItemDic[rewardId] = item
  end
  self.ui.icon_Cost.sprite = CRH:GetSpriteByItemId(poolparaCfg.costId, true)
  self._lotteryTimes = self:__ClampLotteryCount(1)
  self.ui.inputField.text = tostring(self._lotteryTimes)
  self:__RefreshLotteryTimesState()
end

function UINEventComebackLiteExchange:__CanLottery(showTip)
  if not self._roundData:IsUnlockPool(self._poolData:GetRoundId()) then
    if showTip then
      CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7402))
    end
    return
  end
  if self._poolData:GetRoundRemainTimes() <= 0 then
    if showTip then
      CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7404))
    end
    return false
  end
  local poolparaCfg = self._poolData:GetPoolParaCfg()
  local costId = poolparaCfg.costId
  local costNum = poolparaCfg.costNum * self._lotteryTimes
  local hasNum = PlayerDataCenter:GetItemCount(costId)
  if costNum > hasNum then
    if showTip then
      CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7405))
    end
    return false
  end
  return true
end

return UINEventComebackLiteExchange
