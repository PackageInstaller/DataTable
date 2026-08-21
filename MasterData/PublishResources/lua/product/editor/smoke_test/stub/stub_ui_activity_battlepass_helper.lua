if not SMOKE_TEST_ENABLED then
  return
end
if not _G.UIActivityBattlePassHelper then
  return
end
Log.warn("TestRobotModule: UIActivityBattlePassHelper stub!")

function UIActivityBattlePassHelper.CheckComponentRedPoint(campaign, ...)
  return false
end
