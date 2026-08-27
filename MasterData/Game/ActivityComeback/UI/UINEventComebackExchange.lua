local UINEventComebackExchange = class("UINEventComebackExchange", UIBaseNode)
local base = UIBaseNode
local CS_Resloader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon
local UINEventComebackExchangeReward = require("Game.ActivityComeback.UI.UINEventComebackExchangeReward")
local UINEventComebackExchangeShow = require("Game.ActivityComeback.UI.UINEventComebackExchangeShow")

function UINEventComebackExchange:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Des, self, self.__OnClickShow)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_Left, self, self.__OnClickSwitPool, true)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_Right, self, self.__OnClickSwitPool, false)
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
  self._unitWidth = self.ui.tran_count.sizeDelta.x
  self._itemPool = UIItemPool.New(UINEventComebackExchangeReward, self.ui.itemNode)
  self.ui.itemNode:SetActive(false)
  self._colorLottery = self.ui.img_Exchange.color
  self.__RefreshLotteryTimesStateCallback = BindCallback(self, self.__RefreshLotteryTimesState)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self.__RefreshLotteryTimesStateCallback)
  self._rewardShowNode = UINEventComebackExchangeShow.New()
  self._rewardShowNode:Init(self.ui.rewardList)
end

function UINEventComebackExchange:InitComebackExchange(id)
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
  self.ui.btn_Left.gameObject:SetActive(self.curIndex > 1)
  self.ui.btn_Right.gameObject:SetActive(allCount > self.curIndex)
  local sizeDelta = self.ui.tran_count.sizeDelta
  sizeDelta.x = self._unitWidth * allCount
  self.ui.tran_count.sizeDelta = sizeDelta
  local anchoredPositio = self.ui.tran_CurrNum.anchoredPosition
  anchoredPositio.x = self._unitWidth * (self.curIndex - 1)
  self.ui.tran_CurrNum.anchoredPosition = anchoredPositio
  self:__RefreshPool()
  self._rewardShowNode:Hide()
end

function UINEventComebackExchange:__OnClickSwitPool(isLeft)
  local addIndex = isLeft and -1 or 1
  local curIndex = self.curIndex + addIndex
  local allCount = #self._roundIdList
  if curIndex < 1 or curIndex > allCount then
    return
  end
  self.curIndex = curIndex
  local curRoundId = self._roundIdList[self.curIndex]
  
  local function changeFunc()
    self._poolData = self._roundData:GetRoundPoolData(curRoundId)
    self.ui.btn_Left.gameObject:SetActive(self.curIndex > 1)
    self.ui.btn_Right.gameObject:SetActive(self.curIndex < allCount)
    local anchoredPositio = self.ui.tran_CurrNum.anchoredPosition
    anchoredPositio.x = self._unitWidth * (self.curIndex - 1)
    self.ui.tran_CurrNum.anchoredPosition = anchoredPositio
    self:__RefreshPool()
  end
  
  local isUnlock = self._roundData:IsUnlockPool(curRoundId)
  local allowReq = self._roundData:AllowReqRoundPool(curRoundId)
  if isUnlock or not allowReq then
    changeFunc()
  else
    local activityRoundNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityRound)
    activityRoundNetCtrl:CS_ActivityRound_NextLotteryRound(self._roundData:GetRoundActId(), self._poolData:GetRoundId(), function()
      changeFunc()
    end)
  end
end

function UINEventComebackExchange:__RefreshPool()
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
  local islock = not self._roundData:IsUnlockPool(self._poolData:GetRoundId())
  self.ui.locked:SetActive(islock)
  if islock then
    local index = self.curIndex - 1
    if 0 < index then
      local beforePoolId = self._roundIdList[index]
      local poolData = self._roundData:GetRoundPoolData(beforePoolId)
      local poolCfg = poolData:GetPoolParaCfg()
      local poolName = LanguageUtil.GetLocaleText(poolCfg.pool_name)
      self.ui.tex_lock:SetIndex(0, poolName)
    end
  end
end

function UINEventComebackExchange:__RefreshRemain()
  local poolparaCfg = self._poolData:GetPoolParaCfg()
  for rewardId, item in pairs(self._rewardItemDic) do
    local useNum, allNum = self._poolData:GetRoundSingleRewardCount(rewardId)
    local remainCount = allNum - useNum
    item:SetExchangeRemainCount(remainCount)
  end
  self._lotteryTimes = self:__ClampLotteryCount(1)
  self.ui.inputField.text = tostring(self._lotteryTimes)
  self.ui.tex_Count.text = self._poolData:GetRoundTimes() .. "/" .. self._poolData:GetRoundTotalTimes()
end

function UINEventComebackExchange:__OnClickInputNum(valueStr)
  local count = tonumber(valueStr)
  if count == self._lotteryTimes then
    return
  end
  local clampCount = self:__ClampLotteryCount(count)
  if clampCount ~= count then
    count = clampCount
    self.ui.inputField.text = tostring(count)
  end
  self:__RefreshLotteryTimesState()
end

function UINEventComebackExchange:__OnClickChangeNum(isAdd)
  local changNum = isAdd and 1 or -1
  local count = self:__ClampLotteryCount(self._lotteryTimes + changNum)
  if count == self._lotteryTimes then
    return
  end
  self._lotteryTimes = count
  self.ui.inputField.text = tostring(count)
  self:__RefreshLotteryTimesState()
end

function UINEventComebackExchange:__OnChangeMaxNum()
  local count = self:__ClampLotteryCount(self._poolData:GetRoundRemainTimes())
  if count == self._lotteryTimes then
    return
  end
  self._lotteryTimes = count
  self.ui.inputField.text = tostring(count)
  self:__RefreshLotteryTimesState()
end

function UINEventComebackExchange:__OnhangeMinNum()
  local count = self:__ClampLotteryCount(1)
  if count == self._lotteryTimes then
    return
  end
  self._lotteryTimes = count
  self.ui.inputField.text = tostring(count)
  self:__RefreshLotteryTimesState()
end

function UINEventComebackExchange:__ClampLotteryCount(count)
  local poolparaCfg = self._poolData:GetPoolParaCfg()
  local costId = poolparaCfg.costId
  local costNum = poolparaCfg.costNum
  local remainTimes = self._poolData:GetRoundRemainTimes()
  if remainTimes == 0 then
    return 0
  end
  if count > remainTimes then
    count = remainTimes
  elseif count <= 0 then
    count = 1
  end
  local itemCount = PlayerDataCenter:GetItemCount(costId)
  if itemCount >= costNum * count then
    return count
  end
  count = itemCount // costNum
  if count <= 0 then
    count = 1
  end
  return count
end

function UINEventComebackExchange:__RefreshLotteryTimesState()
  local poolparaCfg = self._poolData:GetPoolParaCfg()
  local costId = poolparaCfg.costId
  local costNum = poolparaCfg.costNum * self._lotteryTimes
  self.ui.tex_CostCount.text = tostring(costNum)
  local isEnough = costNum <= PlayerDataCenter:GetItemCount(costId)
  self.ui.tex_CostCount.color = isEnough and Color.white or Color.red
  self.ui.img_Exchange.color = self:__CanLottery() and self._colorLottery or Color.gray
end

function UINEventComebackExchange:__CanLottery(showTip)
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
      CS_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7403))
    end
    return false
  end
  return true
end

function UINEventComebackExchange:__OnClickLottery()
  if not self:__CanLottery(true) then
    return
  end
  local activityRoundNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivityRound)
  activityRoundNetCtrl:CS_ActivityRound_ExecLottery(self._roundData:GetRoundActId(), self._lotteryTimes, self._poolData:GetRoundId(), function()
    AudioManager:PlayAudioById(1211)
    self._lotteryTimes = self:__ClampLotteryCount(1)
    self:__RefreshRemain()
    self:__RefreshLotteryTimesState()
  end)
end

function UINEventComebackExchange:__OnClickShow()
  self._rewardShowNode:Show()
  self._rewardShowNode:UpdateExchangeShow(self._roundData, self._poolData)
end

function UINEventComebackExchange:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self.__RefreshLotteryTimesStateCallback)
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  base.OnDelete(self)
end

return UINEventComebackExchange
