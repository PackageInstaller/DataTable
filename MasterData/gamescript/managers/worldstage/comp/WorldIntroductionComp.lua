local WorldIntroductionComp, Super = System.NewClass("WorldIntroductionComp", WorldStageComp)

function WorldIntroductionComp:ShowCopySettlePanel(cb)
  UIManager.Instance:CloseByUrl(Urls.LoadingPanel)
  
  local function endFunc()
    if IntroductionDataUtils.IsFirstBattle() then
      Logger.Warn("不应该走到这里来的，猜测是在第一场战斗使用了副本胜利通关的GM？" .. debug.traceback())
      WorldStageManager.Instance:FinishStage(self.stageData.groupId)
      SceneMgr.Instance:EnterIntroduction({
        step = IntroductionDataUtils.GetStep(),
        stageTid = self.stageData.stageId
      })
    else
      SceneMgr.Instance:EnterIntroduction({
        step = IntroductionDataUtils.GetStep(),
        stageTid = self.stageData.stageId
      })
    end
    if cb then
      cb()
    end
  end
  
  AudioManager.Instance:PostSoundEvent("CHAPTER_WIN_MUSIC")
  DataCenter.copiesData.copiesSettleData.stageId = self.stageData.stageId
  CopiesDataUtils.ShowSettlement(endFunc, DT.StageGroup[self.stageData.groupId].Type)
end

function WorldIntroductionComp:EndFirstBattle()
end

return WorldIntroductionComp
