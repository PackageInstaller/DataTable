local BattlePerformanceUtil = {}

function BattlePerformanceUtil.ShowBlackScreenGo()
  UIManager.Instance:Reopen(Urls.BattleBlackBlockPanel, 5)
end

function BattlePerformanceUtil.CloseBlackScreenGo()
  UIManager.Instance:CloseByUrl(Urls.BattleBlackBlockPanel)
end

return BattlePerformanceUtil
