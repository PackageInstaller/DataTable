local PreStageScene, Super = System.NewClass("PreStageScene", BaseSceneState)
PreStageScene.Step = {
  story1 = 1,
  story2 = 2,
  firstBattle = 3,
  stage = 4
}

function PreStageScene:ctor()
  Super.ctor(self)
  self.curStep = PreStageScene.Step.story1
end

function PreStageScene:OnEnterScene()
  Super.OnEnterScene(self)
  EventMgr.Instance.OnStoryEnd:RegisterEvent(System.fn(self, self.OnStoryEnd))
end

function PreStageScene:OnExitScene()
  Super.OnExitScene(self)
  EventMgr.Instance.OnStoryEnd:RemoveEvent(System.fn(self, self.OnStoryEnd))
end

function PreStageScene:GetConfig(step)
  local cfgData = DT.GetOriginalConstant("PrologueBeginPlot")
  return cfgData[step]
end

function PreStageScene:DoStep(step)
  self.curStep = step
  if step == PreStageScene.Step.story1 then
    AvgStoryManager.Instance:StartStoryById(self:GetConfig(step))
  elseif step == PreStageScene.Step.story2 then
    AvgStoryManager.Instance:StartStoryById(self:GetConfig(step))
  elseif step == PreStageScene.Step.firstBattle then
  elseif step == PreStageScene.Step.stage then
  end
end

function PreStageScene:OnStoryEnd(storyId)
  if self.curStep == PreStageScene.Step.story1 then
    self:DoStep(PreStageScene.Step.story2)
  elseif self.curStep == PreStageScene.Step.story2 then
    self:DoStep(PreStageScene.Step.firstBattle)
  elseif self.curStep == PreStageScene.Step.stage then
  end
end

return PreStageScene
