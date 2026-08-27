local UIPeriodicBattleBossResult = class("UIPeriodicBattleBossResult", UIBaseWindow)
local base = UIBaseWindow
local UINPeriodBattleBossResultItem = require("Game.PeriodicChallenge.UI.BattleBossResult.UINPeriodBattleBossResultItem")

function UIPeriodicBattleBossResult:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Settle, self, self._OnClickSettle)
  UIUtil.AddButtonListener(self.ui.btn_Reload, self, self._OnClickRestart)
  UIUtil.AddButtonListener(self.ui.btn_Statistic, self, self._OnClickStatistic)
  self.resultItemPool = UIItemPool.New(UINPeriodBattleBossResultItem, self.ui.infoItem, false)
end

function UIPeriodicBattleBossResult:InitPeriodicBattleBossResult(resultTab, settleFunc, restartFunc, statisticFunc)
  self.settleFunc = settleFunc
  self.restartFunc = restartFunc
  self.statisticFunc = statisticFunc
  self.resultItemPool:HideAll()
  if resultTab.bossName ~= nil then
    local resultItem = self.resultItemPool:GetOne()
    resultItem:SetNameIdxPeriodBossResultItem(0, resultTab.bossName)
    resultItem:SetValueIdxPeriodBossResultItem(0, resultTab.bossCurHp, resultTab.bossMaxHp)
  end
  local resultItem = self.resultItemPool:GetOne()
  resultItem:SetNameIdxPeriodBossResultItem(1)
  local curTime = tostring(resultTab.battleCurSecond) .. "S"
  local allTime = tostring(resultTab.battleAllSecond) .. "S"
  resultItem:SetValueIdxPeriodBossResultItem(0, curTime, allTime)
  local resultItem = self.resultItemPool:GetOne()
  resultItem:SetNameIdxPeriodBossResultItem(2)
  resultItem:SetValueIdxPeriodBossResultItem(1, resultTab.score)
end

function UIPeriodicBattleBossResult:_OnClickSettle()
  if self.settleFunc ~= nil then
    self.settleFunc()
  end
  self:Delete()
end

function UIPeriodicBattleBossResult:_OnClickRestart()
  if self.restartFunc ~= nil then
    self.restartFunc()
  end
  self:Delete()
end

function UIPeriodicBattleBossResult:_OnClickStatistic()
  if self.statisticFunc ~= nil then
    self.statisticFunc()
  end
end

function UIPeriodicBattleBossResult:OnDelete()
  self.resultItemPool:DeleteAll()
  base.OnDelete(self)
end

return UIPeriodicBattleBossResult
