_class("UIHomelandMoviePrepareFurniture", UIHomelandMoviePrepareBase)
UIHomelandMoviePrepareFurniture = UIHomelandMoviePrepareFurniture

function UIHomelandMoviePrepareFurniture:OnShow()
  local freeStagePool = self:GetUIComponent("UISelectObjectPath", "editList")
  local camera = GameGlobal.UIStateManager():GetControllerCamera("UIHomelandMoviePrepareMainController")
  self.editList = freeStagePool:SpawnObject("UIHomelandBuildEditList")
  self.editList:Init(camera, BuildEditListType.BT_MakeMovie)
  self.fatherBuilding = MoviePrepareData:GetInstance():GetFatherBuild()
  self.mUIHomeland = GameGlobal.GetModule(HomelandModule):GetUIModule()
end

function UIHomelandMoviePrepareFurniture:OnEnter(prepareType)
  self:Refresh(prepareType)
  self.mUIHomeland:ShowHightLightFreeArea(self.fatherBuilding, true)
end

function UIHomelandMoviePrepareFurniture:OnExit(prepareType)
  self.mUIHomeland:ShowHightLightFreeArea(self.fatherBuilding, false)
  return true
end

function UIHomelandMoviePrepareFurniture:Refresh(prepareType)
  HomelandMoviePrepareManager:GetInstance():SetPhaseType(prepareType)
  self.editList:FlushArrange()
end

function UIHomelandMoviePrepareFurniture:SetUIWidgetHomelandBuildController(mobileControl)
  self.editList:SetUIWidgetHomelandBuildController(mobileControl)
end
