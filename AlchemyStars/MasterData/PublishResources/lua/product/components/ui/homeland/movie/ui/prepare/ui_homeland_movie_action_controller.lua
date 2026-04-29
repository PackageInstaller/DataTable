_class("UIHomelandMovieActionController", UIController)
UIHomelandMovieActionController = UIHomelandMovieActionController

function UIHomelandMovieActionController:Constructor()
end

function UIHomelandMovieActionController:OnShow(uiParams)
  self:InitWidget()
  self._ActionRoot = self:GetGameObject("ActionRoot")
end

function UIHomelandMovieActionController:OnHide()
end

function UIHomelandMovieActionController:InitWidget()
end

function UIHomelandMovieActionController:BackBtnOnClick(go)
  self:CloseDialog()
end

function UIHomelandMovieActionController:ActionOnClick(go)
  self:Lock("UIHomelandMovieActionController_ActionOnClick")
  self._ActionRoot.transform:DOScale(Vector3(0.8, 0.8, 0.8), 0.1)
  GameGlobal.Timer():AddEvent(200, function()
    self._ActionRoot.transform:DOScale(Vector3(1, 1, 1), 0.1)
  end)
  GameGlobal.Timer():AddEvent(400, function()
    self:UnLock("UIHomelandMovieActionController_ActionOnClick")
    self:CloseDialog()
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.Summer1Click)
    GameGlobal.TaskManager():StartTask(function(TT)
      GameGlobal.GetModule(HomelandModule):GetUIModule():EnterMovieMaker(TT)
    end)
  end)
end
