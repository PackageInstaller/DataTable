local UINTimeLimitTasklimitNode = class("UINTimeLimitTasklimitNode", UIBaseNode)
local base = UIBaseNode

function UINTimeLimitTasklimitNode:OnInit()
  self.taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self:Hide()
end

function UINTimeLimitTasklimitNode:InitWithCurTaskDatas(typeId)
  self.typeId = typeId
  self:RefreshTaskLeftTime()
  if self.shopTimer == nil then
    self.shopTimer = TimerManager:StartTimer(1, self.RefreshTaskLeftTime, self)
  else
    TimerManager:ResumeTimer(self.shopTimer)
  end
end

function UINTimeLimitTasklimitNode:RefreshTaskLeftTime()
  local outOfDataTm = self.taskCtrl.timeLimitTaskendTime[self.typeId]
  if outOfDataTm == nil then
    return
  end
  local leftTime = outOfDataTm - PlayerDataCenter.timestamp
  if leftTime < 0 then
    self.ui.tex_lefttime:SetIndex(2)
    return
  end
  local d, h, m, s = TimeUtil:TimestampToTimeInter(leftTime, false, true)
  if 0 < d then
    self.ui.tex_lefttime:SetIndex(0, tostring(d), string.format("%02d:%02d:%02d", tostring(h), tostring(m), tostring(s)))
  else
    self.ui.tex_lefttime:SetIndex(1, string.format("%02d:%02d:%02d", tostring(h), tostring(m), tostring(s)))
  end
end

function UINTimeLimitTasklimitNode:OnHide()
  if self.shopTimer ~= nil then
    TimerManager:PauseTimer(self.shopTimer)
  end
  base.OnHide(self)
end

function UINTimeLimitTasklimitNode:OnDelete()
  if self.shopTimer ~= nil then
    TimerManager:StopTimer(self.shopTimer)
    self.shopTimer = nil
  end
  base.OnDelete(self)
end

return UINTimeLimitTasklimitNode
