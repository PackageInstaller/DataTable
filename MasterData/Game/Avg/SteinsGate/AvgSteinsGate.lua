local AvgSteinsGate = class("AvgSteinsGate")

function AvgSteinsGate:ctor(avgSystem)
  self.avgSystem = avgSystem
end

function AvgSteinsGate:PlayAvgActSG(actCfg)
  if self:_SteinLineChange(actCfg) then
    return
  end
  if self:_DealMobile(actCfg) then
    return
  end
end

function AvgSteinsGate:_SteinLineChange(actCfg)
  local sgLineChange = actCfg.sgLineChange
  if sgLineChange == nil then
    return
  end
  if sgLineChange.worldChangeId == nil then
    error("[Avg] sgLineChange.worldChangeId is nil")
    return
  end
  local CameraEffectUtil = require("Game.Exploration.Util.CameraEffectUtil")
  local CameraEffectEnum = CameraEffectUtil.CameraEffectEnum
  self._resLoader = self._resLoader or CS.ResLoader.Create()
  self._isPlayWorldLineChnage = true
  self.avgSystem:SetWaitAvgSGAnim()
  CameraEffectUtil.CameraEffectFunction[CameraEffectEnum.SteinLineChange](sgLineChange.worldChangeId, self._resLoader, function()
    self._isPlayWorldLineChnage = nil
    self:_OnMobileTweenComplpete()
  end)
  return true
end

function AvgSteinsGate:_DealMobile(actCfg)
  local sgMobile = actCfg.sgMobile
  if sgMobile == nil then
    return
  end
  if sgMobile.hideImmediate then
    UIManager:DeleteWindow(UIWindowTypeID.SteinsGateAvg)
    return
  end
  self._OnMobileTweenEndFunc = self._OnMobileTweenEndFunc or BindCallback(self, self._OnMobileTweenComplpete)
  if sgMobile.showSgMobile ~= nil then
    if sgMobile.showSgMobile then
      self.avgSystem:SetWaitAvgSGAnim()
      self:_ShowMobileWin(function(win)
        win:ShowSGAvgMobileAnim(self._OnMobileTweenEndFunc)
      end)
    else
      local mobileWin = UIManager:GetWindow(UIWindowTypeID.SteinsGateAvg)
      if mobileWin then
        self.avgSystem:SetWaitAvgSGAnim()
        mobileWin:HideSGAvgMobileAnim(self._OnMobileTweenEndFunc)
      end
    end
    return
  end
  if sgMobile.showReceiveNewMsg then
    self.avgSystem:SetWaitAvgSGAnim()
    self:_ShowMobileWin(function(win)
      win:SGAvgMobileReceiveMsgAnim(self._OnMobileTweenEndFunc)
    end)
    return
  end
  if sgMobile.receiveMsg ~= nil then
    local mobileWin = UIManager:GetWindow(UIWindowTypeID.SteinsGateAvg)
    if mobileWin then
      self.avgSystem:SetWaitAvgSGAnim()
      mobileWin:SGAvgMobileReceiveMsg(sgMobile.receiveMsg, self._OnMobileTweenEndFunc)
    else
      error("[Avg]手机未拿出来，不可显示收到的消息内容")
    end
    return
  end
  if sgMobile.sendMsg ~= nil then
    self.avgSystem:SetWaitAvgSGAnim()
    self:_ShowMobileWin(function(win)
      win:SGAvgMobileSendMsgAnim(sgMobile.sendMsg, self._OnMobileTweenEndFunc)
    end)
    return
  end
  if sgMobile.sendMsgConfirm then
    local mobileWin = UIManager:GetWindow(UIWindowTypeID.SteinsGateAvg)
    if mobileWin then
      self.avgSystem:SetWaitAvgSGAnim()
      mobileWin:SendMsgConfirmSGAnim(self._OnMobileTweenEndFunc)
    else
      error("[Avg]手机未拿出来，不可播放发送消息的动画")
    end
    return
  end
  return true
end

function AvgSteinsGate:_OnMobileTweenComplpete()
  local avgWindow = UIManager:GetWindow(UIWindowTypeID.Avg)
  if avgWindow ~= nil then
    avgWindow:OnAvgSGAnimComplete()
  end
end

function AvgSteinsGate:_ShowMobileWin(callBack)
  UIManager:ShowWindowAsync(UIWindowTypeID.SteinsGateAvg, function(win)
    if win == nil then
      return
    end
    local holder = self.avgSystem:GetAvgSteinsGateMobileHolder()
    win.transform:SetParent(holder)
    win:InitSteinsGateAvg(self.avgSystem)
    callBack(win)
  end)
end

function AvgSteinsGate:OnDelete()
  if self._isPlayWorldLineChnage then
    self._isPlayWorldLineChnage = nil
    UIManager:DeleteWindow(UIWindowTypeID.MoviePlayer)
  end
  UIManager:DeleteWindow(UIWindowTypeID.SteinsGateAvg)
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
end

return AvgSteinsGate
