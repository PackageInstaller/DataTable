_class("UICutsceneReviewController", UIController)
UICutsceneReviewController = UICutsceneReviewController

function UICutsceneReviewController:OnShow(uiParams)
  self:AttachEvent(GameEventType.CutsceneFinish, self.OnCutsceneFinish)
end

function UICutsceneReviewController:OnUpdate(deltaTimeMS)
end

function UICutsceneReviewController:OnHide()
end

function UICutsceneReviewController:ButtonSkipOnClick(go)
  local uiStoryModule = GameGlobal.GetModule(StoryModule):GetUIModule()
  if uiStoryModule then
    uiStoryModule:BackFrom3DStory()
  else
    Log.fatal("Can not find uiStoryModule")
    self:SwitchState(UIStateType.UIMain)
  end
  GameGlobal:GetInstance():ExitCutsceneGame()
end

function UICutsceneReviewController:OnCutsceneFinish()
  Log.fatal("OnCutsceneFinish----------------")
  local uiStoryModule = GameGlobal.GetModule(StoryModule):GetUIModule()
  if uiStoryModule then
    uiStoryModule:BackFrom3DStory()
  else
    Log.fatal("Can not find uiStoryModule")
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIMain)
  end
  GameGlobal:GetInstance():ExitCutsceneGame()
end
