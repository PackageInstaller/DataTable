local UnityTime = CS.UnityEngine.Time
local CheckThreshold = 45
local ResUpdateUtil = System.NewClass("ResUpdateUtil")

function ResUpdateUtil:ctor()
  self.lastCheckTime = 0
end

function ResUpdateUtil:CheckResUpdate(force)
  if self.existResNeedUpdate then
    return
  end
  local curTime = UnityTime.realtimeSinceStartup
  if not force and curTime - self.lastCheckTime < CheckThreshold then
    return
  end
  self.lastCheckTime = curTime
  Utils:CheckResUpdate(function(succ, has_update)
    if succ and has_update then
      self.existResNeedUpdate = true
      if BattleManager.Instance:IsInBattle() then
        return
      end
      self:TryPopResUpdateDialog()
      return
    end
  end)
end

function ResUpdateUtil:TryPopResUpdateDialog()
  if self.isClickRestartGame then
    return
  end
  if bg.battleScene or BattleManager.Instance:IsInBattle() then
    return
  end
  if not self.existResNeedUpdate then
    return
  end
  if UIManager.Instance:GetWindow(Urls.PvPMatchingPanel) or UIManager.Instance:GetWindow(Urls.PvPMatchRstPanel) then
    return
  end
  local panel = UIManager.Instance:GetWindow(Urls.ResUpdatePopupPanel)
  if panel then
    return
  end
  UIManager.Instance:ForbidBack()
  
  local function confirmFunc()
    self.isClickRestartGame = true
  end
  
  UIManager.Instance:Reopen(Urls.ResUpdatePopupPanel, confirmFunc)
end

function ResUpdateUtil:StartAutoCheckResUpdate()
  if ApplicationUtils.is_editor_mode() then
    return
  end
  self.existResNeedUpdate = false
  self.isClickRestartGame = false
  self.lastCheckTime = UnityTime.realtimeSinceStartup
  self:StopAutoCheckResUpdate()
  self.autoCheckTimer = TimerManager.Instance:CreateTimer(CheckThreshold, -1, function()
    self:CheckResUpdate(true)
  end, nil)
end

function ResUpdateUtil:StopAutoCheckResUpdate()
  if self.autoCheckTimer then
    TimerManager.Instance:StopTimer(self.autoCheckTimer)
    self.autoCheckTimer = nil
  end
end

ResUpdateUtil.Instance = ResUpdateUtil()
return ResUpdateUtil
