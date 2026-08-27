local UINWhiteDayLineSlotNode = class("UINWhiteDayLineSlotNode", UIBaseNode)
local base = UIBaseNode
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local ActivityWhiteDayEnum = require("Game.ActivityWhiteDay.ActivityWhiteDayEnum")

function UINWhiteDayLineSlotNode:OnInit()
  self.loop1Effect = nil
  self.loop2Effect = nil
  self.picEffect = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_slot, self, self.OnAWDClickSlot)
  UIUtil.AddButtonListener(self.ui.btn_speedUpNode, self, self.OnAWDClickAcc)
  UIUtil.AddButtonListener(self.ui.btn_Event, self, self.OnAWDClickEvent)
end

function UINWhiteDayLineSlotNode:InitWhiteDayLineSlot(AWDCtrl, AWDLineData, resloader)
  self.AWDCtrl = AWDCtrl
  self.AWDLineData = AWDLineData
  self.resloader = resloader
  self:RefreshAWDLineSlot()
end

function UINWhiteDayLineSlotNode:RefreshAWDLineSlot()
  local isUnlcok = self.AWDLineData:GetIsWDLUnlock()
  local isInProduction = self.AWDLineData:GetIsInProduction()
  local isHaveEvent = self.AWDLineData:GetIsHaveEvent()
  local isComplete = self.AWDLineData:GetIsProductionOver()
  self.ui.obj_frame:SetActive(not isComplete)
  self.ui.obj_tex_Start:SetActive(isUnlcok and not isInProduction)
  self.ui.obj_condition:SetActive(not isUnlcok)
  self.ui.obj_timeAndAcc:SetActive(isInProduction)
  self.ui.obj_count:SetActive(false)
  self:__RefreshWDEventTween()
  self.ui.btn_Event.gameObject:SetActive(isHaveEvent)
  if self.loop1Effect ~= nil then
    self.loop1Effect:SetActive(false)
    self.loop2Effect:SetActive(false)
  end
  if isComplete then
    self.ui.img_buttom:SetIndex(1)
    if self.loop1Effect == nil then
      local prefab1 = self.resloader:LoadABAsset(ActivityWhiteDayEnum.effect.loop1)
      local prefab2 = self.resloader:LoadABAsset(ActivityWhiteDayEnum.effect.loop2)
      self.loop1Effect = prefab1:Instantiate(self.ui.go_EffectLoop1Root.transform)
      self.loop2Effect = prefab2:Instantiate(self.ui.go_EffectLoop2Root.transform)
    else
      self.loop1Effect:SetActive(false)
      self.loop1Effect:SetActive(true)
      self.loop2Effect:SetActive(false)
      self.loop2Effect:SetActive(true)
    end
  else
    self.ui.img_buttom:SetIndex(0)
  end
  if not isUnlcok then
    local unlockLevel = self.AWDLineData:GetWDLUnlockLevel()
    self.ui.img_AddLocked:SetIndex(1)
    self.ui.img_Icon.gameObject:SetActive(false)
    self.ui.tex_Condition:SetIndex(0, tostring(unlockLevel))
  else
    self.ui.img_AddLocked.gameObject:SetActive(not isInProduction)
    self.ui.img_Icon.gameObject:SetActive(isInProduction)
    if isInProduction then
      local WDOrderData = self.AWDLineData:GetWDProductionOrderData()
      local orderItemId = WDOrderData:GetWDOrderItemId()
      local orderItemCfg, itemNum = WDOrderData:GetWDOrderItemIdAndNum()
      self.ui.img_Icon.sprite = CRH:GetSpriteByItemId(orderItemId)
      if 1 < itemNum then
        self.ui.obj_count:SetActive(true)
        self.ui.tex_Count.text = tostring(itemNum)
      end
      self:RefreshAWDOrderProcess()
    else
      self.ui.img_AddLocked:SetIndex(0)
    end
  end
  if isInProduction and not isComplete then
    if self.accLoopEffect == nil then
      local prefab = self.resloader:LoadABAsset(ActivityWhiteDayEnum.effect.accLoop)
      self.accLoopEffect = prefab:Instantiate(self.ui.obj_EffectAccLoopRoot.transform)
    else
      self.accLoopEffect:SetActive(true)
    end
  elseif self.accLoopEffect ~= nil then
    self.accLoopEffect:SetActive(false)
  end
end

function UINWhiteDayLineSlotNode:WDSlotPlayAccEffect()
  local isInProduction = self.AWDLineData:GetIsInProduction()
  local isComplete = self.AWDLineData:GetIsProductionOver()
  if self.__accEffectTimerId ~= nil then
    TimerManager:StopTimer(self.__accEffectTimerId)
    self.__accEffectTimerId = nil
  end
  if isInProduction and not isComplete then
  else
    self.ui.tex_Time.text = TimeUtil:TimestampToTime(0, false, false, true)
    self.ui.obj_frame:SetActive(true)
    self.ui.obj_tex_Start:SetActive(false)
    self.ui.obj_condition:SetActive(false)
    self.ui.obj_timeAndAcc:SetActive(true)
  end
  if self.accHitEffect == nil then
    local prefab = self.resloader:LoadABAsset(ActivityWhiteDayEnum.effect.accHit)
    self.accHitEffect = prefab:Instantiate(self.ui.obj_EffectAccHitRoot.transform)
  else
    self.accHitEffect:SetActive(true)
  end
  AudioManager:PlayAudioById(1208)
  
  local function OnEndPlayAccEffect()
    self.accHitEffect:SetActive(false)
    self:RefreshAWDLineSlot()
    self.__accEffectTimerId = nil
  end
  
  self.__accEffectTimerId = TimerManager:StartTimer(2.5, OnEndPlayAccEffect, self, true)
end

function UINWhiteDayLineSlotNode:RefreshAWDOrderProcess()
  local isInProduction = self.AWDLineData:GetIsInProduction()
  if isInProduction then
    local isComplete = self.AWDLineData:GetIsProductionOver()
    if self.__accEffectTimerId == nil then
      self.ui.obj_frame:SetActive(not isComplete)
    end
    if isComplete then
      self.ui.img_buttom:SetIndex(1)
    else
      self.ui.img_buttom:SetIndex(0)
      local leftTime = self.AWDLineData:GetInProductionLeftTime()
      self.ui.tex_Time.text = TimeUtil:TimestampToTime(leftTime, false, false, true)
    end
  end
end

function UINWhiteDayLineSlotNode:RefreshAWDLineSlotPos()
end

function UINWhiteDayLineSlotNode:TryRefreshWDEventTween(taskData)
  if taskData.id == self.AWDLineData:GetWDLEventTaksId() then
    self:__RefreshWDEventTween()
  end
end

function UINWhiteDayLineSlotNode:__RefreshWDEventTween()
  local isHaveEvent = self.AWDLineData:GetIsHaveEvent()
  if not isHaveEvent then
    self.ui.tween_event:DORewind()
    return
  end
  local taskId = self.AWDLineData:GetWDLEventTaksId()
  if taskId == nil then
    self.ui.tween_event:DORewind()
    return
  end
  local taskData = PlayerDataCenter.allTaskData.taskDatas[taskId]
  if taskData == nil then
    self.ui.tween_event:DORewind()
    return
  end
  local isComplete = taskData:CheckComplete()
  if isComplete then
    self.ui.tween_event:DOPlayForward()
  else
    self.ui.tween_event:DORewind()
  end
end

function UINWhiteDayLineSlotNode:OnAWDClickSlot()
  local isUnlcok = self.AWDLineData:GetIsWDLUnlock()
  local isInProduction = self.AWDLineData:GetIsInProduction()
  local lineId = self.AWDLineData:GetWDLDLineID()
  local AWDData = self.AWDLineData:GetAWDData()
  local actFrameId = AWDData:GetActFrameId()
  if not isInProduction and isUnlcok then
    UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayLine, function(win)
      if win ~= nil then
        win:InitWDLine(self.AWDCtrl, self.AWDLineData)
      end
    end)
  else
  end
  if isInProduction then
    if self.AWDLineData:GetIsProductionOver() then
      local orderData = self.AWDLineData:GetWDProductionOrderData()
      local AWDData = self.AWDLineData:GetAWDData()
      if self.picEffect == nil then
        local prefab = self.resloader:LoadABAsset(ActivityWhiteDayEnum.effect.hit)
        self.picEffect = prefab:Instantiate(self.ui.go_EffectPickRoot.transform)
      else
        self.picEffect:SetActive(false)
        self.picEffect:SetActive(true)
      end
      self.AWDCtrl:WDFinishLineOrder(actFrameId, lineId, function(rewardDic)
        self.AWDLineData:SetWDLDAssistHeroID(nil)
        UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
          if window == nil then
            return
          end
          local CRData = CommonRewardData.CreateCRDataUseDic(rewardDic):SetCRShowOverFunc(function()
            self.AWDCtrl:WDTryShowFactroyLevelUp(AWDData, function()
              local whiteDayWin = UIManager:GetWindow(UIWindowTypeID.WhiteDay)
              if whiteDayWin ~= nil then
                whiteDayWin.infoBtnNode:TryPlayWDLevelExpTween()
              end
            end)
          end)
          if AWDData:GetWhiteDayPhotoConvertItemIsAboveLimit() then
            local randomId, _ = AWDData:GetWDRandomPhotoItemIdAndNum()
            local exchangeId, _ = AWDData:GetWDExchangePhotoItemIdAndNum()
            local randomNum = rewardDic[randomId] or 0
            local exchangeNum = rewardDic[exchangeId] or 0
            local converItems = {}
            if 0 < randomNum then
              converItems[randomId] = randomNum
            end
            if 0 < exchangeNum then
              converItems[exchangeId] = exchangeNum
            end
            CRData:SetCRItemTransDic(converItems)
          end
          window:AddAndTryShowReward(CRData)
        end)
      end)
    else
      self:OnAWDClickAcc()
    end
  end
end

function UINWhiteDayLineSlotNode:OnAWDClickAcc()
  UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayAccOrder, function(win)
    if win ~= nil then
      win:InitWDAccOrder(self.AWDCtrl, self.AWDLineData)
    end
  end)
end

function UINWhiteDayLineSlotNode:OnAWDClickEvent()
  UIManager:ShowWindowAsync(UIWindowTypeID.WhiteDayEvent, function(win)
    if win ~= nil then
      win:InitWDEvent(self.AWDCtrl, self.AWDLineData)
    end
  end)
end

function UINWhiteDayLineSlotNode:OnDelete()
  if self.__accEffectTimerId ~= nil then
    TimerManager:StopTimer(self.__accEffectTimerId)
    self.__accEffectTimerId = nil
  end
  self.ui.tween_event:DOKill()
  base.OnDelete(self)
end

return UINWhiteDayLineSlotNode
