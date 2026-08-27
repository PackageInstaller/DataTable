local UIActSum21Exchange = class("UIActSum21Exchange", UIBaseWindow)
local base = UIBaseWindow
local UINAct21SumExcgRewardList = require("Game.ActivitySummer.UI.ActSum21Exchange.UINAct21SumExcgRewardList")
local UINAct21SumExcgHardDisk = require("Game.ActivitySummer.UI.ActSum21Exchange.UINAct21SumExcgHardDisk")

function UIActSum21Exchange:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self._OnClickAdd)
  UIUtil.AddButtonListener(self.ui.btn_Max, self, self._OnClickAdd2Max)
  UIUtil.AddButtonListener(self.ui.btn_Min, self, self._OnClickMin)
  UIUtil.AddButtonListener(self.ui.btn_Least, self, self._OnClickMin2Least)
  UIUtil.AddButtonListener(self.ui.btn_Exchange, self, self._OnClickExchange)
  UIUtil.AddButtonListener(self.ui.btn_ReSetHD, self, self._OnClickReset)
  UIUtil.AddButtonListener(self.ui.btn_resourceItem, self, self._OnClickRes)
  self.ui.btn_Add.onPress:AddListener(BindCallback(self, self._OnClickAddOnPress))
  self.ui.btn_Add.onPressUp:AddListener(BindCallback(self, self._OnPressUp))
  self.ui.btn_Min.onPress:AddListener(BindCallback(self, self._OnClickMinOnPress))
  self.ui.btn_Min.onPressUp:AddListener(BindCallback(self, self._OnPressUp))
  self.ui.inputField.onEndEdit:AddListener(BindCallback(self, self._OnInputFieldEndEdit))
  self.rewardListNode = UINAct21SumExcgRewardList.New(self)
  self.rewardListNode:Init(self.ui.table)
  self.HDNode = UINAct21SumExcgHardDisk.New()
  self.HDNode:Init(self.ui.HDNode)
  self._onPoolIdcallback = BindCallback(self, self._OnPoolIdcallback)
  self.netCtrl = NetworkManager:GetNetwork(NetworkTypeID.ActivitySectorI)
  UIUtil.SetTopStatus(self, self._OnClickClose)
  self._OnItemChangeFunc = BindCallback(self, self._OnItemChange)
  MsgCenter:AddListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.ui.obj_HDType:SetActive(false)
  self.ui.Fx_Complete:SetActive(false)
end

function UIActSum21Exchange:InitActSum21Exchange(sectorIData, withAutoPopup)
  self.sectorIData = sectorIData
  self.pickedRewardPoolIdDic = self.sectorIData:GenActSectorIRewardExchanged()
  local curPickedNum = 0
  for k, num in pairs(self.pickedRewardPoolIdDic) do
    curPickedNum = curPickedNum + num
  end
  self.curPickedNum = curPickedNum
  self.HDNode:InitHDNode(sectorIData, self._onPoolIdcallback)
  self.HDNode:RefreshHD(self.curPickedNum, self.curPoolParaCfg.allRewardNum)
  local endTs = sectorIData:GetActivityDestroyTime()
  local date = TimeUtil:TimestampToDate(endTs, false, true)
  local timeStr = string.format("%02d/%02d/%02d %02d:%02d", date.year, date.month, date.day, date.hour, date.min)
  self.ui.tex_OverTime:SetIndex(0, timeStr)
  if withAutoPopup and self.curPoolParaCfg.allRewardNum == self.curPickedNum then
    self:_Show2NextPool()
  end
end

function UIActSum21Exchange:_OnPoolIdcallback(poolId, poolIdx)
  self:_SelectPool(poolId, poolIdx)
end

function UIActSum21Exchange:_SelectPool(poolId, poolIdx)
  local poolParaCfg = ConfigData.activity_time_limit_pool_para[poolId]
  if poolParaCfg == nil then
    error("Cant get activity_time_limit_pool_para,id = " .. tostring(poolId))
    return
  end
  self.curPoolParaCfg = poolParaCfg
  self:_UpdResNum()
  local sprite = CRH:GetSpriteByItemId(self.curPoolParaCfg.costId)
  self.ui.img_ResIcon.sprite = sprite
  self.ui.img_BtnCostIcon.sprite = sprite
  self.curCostGroupNum = 0
  self:_RefreshCurCost()
  self.rewardListNode:InitAct21SumExcgRewardList(poolId, poolIdx, self.pickedRewardPoolIdDic, self.sectorIData.roundId)
  self.rewardListNode:ShowRefreshUITween()
  local isCurPool = poolId == self.sectorIData.roundId
  local isClearPoolIdx = poolId < self.sectorIData.roundId and 1 or 0
  self.ui.obj_exchangeCount:SetActive(isCurPool)
  self.ui.obj_HDType:SetActive(not isCurPool)
  self.ui.tex_HDType:SetIndex(isClearPoolIdx)
  local showResetBtn = false
  if isCurPool then
    if poolParaCfg.round == -1 then
      showResetBtn = poolParaCfg.allRewardNum == self.curPickedNum
    else
      showResetBtn = true
      for k, rewardId in ipairs(poolParaCfg.reward_id) do
        local bigRewardCfg = poolParaCfg.poolContent[rewardId]
        if bigRewardCfg.num ~= self.pickedRewardPoolIdDic[rewardId] then
          showResetBtn = false
          break
        end
      end
    end
  end
  self.ui.btn_ReSetHD.gameObject:SetActive(showResetBtn)
end

function UIActSum21Exchange:_OnInputFieldEndEdit(value)
  local val = 0
  if not string.IsNullOrEmpty(value) then
    val = tonumber(value)
  end
  self:_TryChangeNum(val)
end

function UIActSum21Exchange:_OnClickAddOnPress()
  if self:_TryChangeNum(self.curCostGroupNum + 1) then
    AudioManager:PlayAudioById(1064)
  end
end

function UIActSum21Exchange:_OnClickMinOnPress()
  if self:_TryChangeNum(self.curCostGroupNum - 1) then
    AudioManager:PlayAudioById(1065)
  end
end

function UIActSum21Exchange:_OnPressUp()
end

function UIActSum21Exchange:_OnClickAdd()
  if self:_TryChangeNum(self.curCostGroupNum + 1) then
    AudioManager:PlayAudioById(1064)
  else
    CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(7011))
  end
end

function UIActSum21Exchange:_OnClickAdd2Max()
  local maxGroupNum = self:_GetMaxAddableNum()
  self:_TryChangeNum(maxGroupNum)
  AudioManager:PlayAudioById(1064)
end

function UIActSum21Exchange:_OnClickMin()
  if self:_TryChangeNum(self.curCostGroupNum - 1) then
    AudioManager:PlayAudioById(1065)
  end
end

function UIActSum21Exchange:_OnClickMin2Least()
  self:_TryChangeNum(0)
  AudioManager:PlayAudioById(1065)
end

function UIActSum21Exchange:_TryChangeNum(num)
  local maxGroupNum = self:_GetMaxAddableNum()
  local newNum = math.clamp(num, 0, maxGroupNum)
  local change = false
  if newNum ~= self.curCostGroupNum then
    self.curCostGroupNum = newNum
    change = true
  end
  self:_RefreshCurCost()
  return change
end

function UIActSum21Exchange:_GetMaxAddableNum()
  local resItemNum = PlayerDataCenter:GetItemCount(self.curPoolParaCfg.costId)
  local maxGroupNum = resItemNum // self.curPoolParaCfg.costNum
  local totalNum = self.curPoolParaCfg.allRewardNum - self.curPickedNum
  maxGroupNum = math.min(maxGroupNum, totalNum)
  return maxGroupNum
end

function UIActSum21Exchange:_RefreshCurCost()
  self.ui.inputField.text = tostring(self.curCostGroupNum)
  if self.curCostGroupNum == 0 then
    self.ui.btn_Exchange.interactable = false
    self.ui.tex_Count:SetIndex(0, tostring(self.curPoolParaCfg.costNum))
    return
  end
  self.ui.btn_Exchange.interactable = true
  local totalCostNum = self.curCostGroupNum * self.curPoolParaCfg.costNum
  self.ui.tex_Count:SetIndex(0, tostring(totalCostNum))
end

function UIActSum21Exchange:_OnClickExchange()
  if self.curCostGroupNum <= 0 then
    return
  end
  self._lastStartExIdx = self.sectorIData.roundIndex
  self._lastExNum = self.curCostGroupNum
  self._OnExchangeCompleteFunc = self._OnExchangeCompleteFunc or BindCallback(self, self._OnExchangeComplete)
  self.netCtrl:CS_ACTIVITYSECTORI_ExecLottery(self.sectorIData.actId, self.curCostGroupNum, self._OnExchangeCompleteFunc)
end

function UIActSum21Exchange:_OnExchangeComplete(objList)
  if objList.Count == 0 then
    error("objList.Count == 0")
    return
  end
  local msg = objList[0]
  if isGameDev then
    self.sectorIData:CheckShuffleResult(self._lastStartExIdx, self._lastExNum, msg.rewards)
  end
  local rewardList = {}
  local rewardIdDic = {}
  for k, v in ipairs(msg.rewards) do
    if rewardIdDic[v.elemNumber] == nil then
      local rewardCfg = self.curPoolParaCfg.poolContent[v.elemNumber]
      if rewardCfg == nil then
        error("Cant get activity_time_limit_pool,id = " .. tostring(v.elemNumber))
      else
        local rewardData = {
          rewardId = v.elemNumber,
          itemId = rewardCfg.rewardId,
          itemNum = rewardCfg.rewardNum,
          groupNum = 1,
          rewardCfg = rewardCfg
        }
        table.insert(rewardList, rewardData)
        rewardIdDic[v.elemNumber] = rewardData
      end
    else
      local rewardData = rewardIdDic[v.elemNumber]
      rewardData.groupNum = rewardData.groupNum + 1
    end
  end
  table.sort(rewardList, function(a, b)
    return self.ActSum21ExchangeRewardSortFunc(a.rewardCfg, b.rewardCfg)
  end)
  self:InitActSum21Exchange(self.sectorIData)
  self._lastRewardList = rewardList
  self:PlayCompleteFx()
end

function UIActSum21Exchange:_OnClickReset()
  AudioManager:PlayAudioById(1138)
  self:_Show2NextPool()
end

function UIActSum21Exchange:_Show2NextPool()
  local msg
  if self.curPoolParaCfg.allRewardNum == self.curPickedNum then
    msg = ConfigData:GetTipContent(7003)
  else
    msg = ConfigData:GetTipContent(7002)
  end
  local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
  window:ShowTextBoxWithYesAndNo(msg, function()
    self.netCtrl:CS_ACTIVITYSECTORI_NextLotteryRound(self.sectorIData.actId, function()
      self:InitActSum21Exchange(self.sectorIData)
    end)
  end)
end

function UIActSum21Exchange:_OnItemChange(itemUpdate)
  if itemUpdate[self.curPoolParaCfg.costId] == nil then
    return
  end
  self:_UpdResNum()
  self:_TryChangeNum(self.curCostGroupNum)
end

function UIActSum21Exchange:_UpdResNum()
  local resItemNum = PlayerDataCenter:GetItemCount(self.curPoolParaCfg.costId)
  self.ui.tex_ResCount.text = tostring(resItemNum)
end

function UIActSum21Exchange.ActSum21ExchangeRewardSortFunc(rewardCfgA, rewardCfgB)
  if rewardCfgA.reward_type ~= rewardCfgB.reward_type then
    return rewardCfgA.reward_type < rewardCfgB.reward_type
  end
  if rewardCfgA.priority ~= rewardCfgB.priority then
    return rewardCfgA.priority > rewardCfgB.priority
  end
  local qualityA = ConfigData.item[rewardCfgA.rewardId].quality
  local qualityB = ConfigData.item[rewardCfgB.rewardId].quality
  if qualityA ~= qualityB then
    return qualityA > qualityB
  end
  return rewardCfgA.id < rewardCfgB.id
end

function UIActSum21Exchange:_OnClickRes()
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  local itemCfg = ConfigData.item[self.curPoolParaCfg.costId]
  window:InitCommonItemDetail(itemCfg)
end

function UIActSum21Exchange:PlayCompleteFx(rewardList)
  self.ui.Fx_Complete:SetActive(true)
  self.ui.canvasGroup.blocksRaycasts = false
  AudioManager:PlayAudioById(1137)
  if self._timerID ~= nil then
    TimerManager:StopTimer(self._timerID)
    self._timerID = nil
  end
  local fxTime = self.ui.flo_FxTime or 3.5
  self._timerID = TimerManager:StartTimer(fxTime, function()
    self._timerID = nil
    self.ui.Fx_Complete:SetActive(false)
    self.ui.canvasGroup.blocksRaycasts = true
    self:ShowExchangeReward(self._lastRewardList)
  end, self, true, false, false)
end

function UIActSum21Exchange:ShowExchangeReward(rewardList)
  UIManager:ShowWindowAsync(UIWindowTypeID.ActSum21ExchangeResult, function(win)
    if win == nil then
      return
    end
    win:InitActSum21ExchangeResult(rewardList, function()
      if self.curPoolParaCfg.allRewardNum == self.curPickedNum and not IsNull(self.gameObject) then
        self:_Show2NextPool()
      end
    end)
  end)
end

function UIActSum21Exchange:_OnClickClose()
  if self._timerID ~= nil then
    self:ShowExchangeReward(self._lastRewardList)
  end
  self:Delete()
end

function UIActSum21Exchange:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.UpdateItem, self._OnItemChangeFunc)
  self.rewardListNode:Delete()
  self.HDNode:Delete()
  if self._timerID ~= nil then
    TimerManager:StopTimer(self._timerID)
    self._timerID = nil
  end
  base.OnDelete(self)
end

return UIActSum21Exchange
