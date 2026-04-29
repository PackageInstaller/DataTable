_class("UIHomelandMoviePrepareMainController", UIController)
UIHomelandMoviePrepareMainController = UIHomelandMoviePrepareMainController

function UIHomelandMoviePrepareMainController:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self.homeBuildManager = self.homelandClient:BuildManager()
  self.furnitureWidget = nil
  self.otherWidget = nil
  self.curPrepareType = nil
  self.curPrepareStageItem = nil
  self.stagesConfig = {
    {
      prepareType = MoviePrepareType.PT_Scene,
      name = "str_movie_scene"
    },
    {
      prepareType = MoviePrepareType.PT_Furniture,
      name = "str_movie_free"
    },
    {
      prepareType = MoviePrepareType.PT_Prop,
      name = "str_movie_prop"
    },
    {
      prepareType = MoviePrepareType.PT_Actor,
      name = "str_movie_actor"
    }
  }
  self.stageItems = {}
  self.fatherBuilding = nil
  self.nextColorEnable = Color(0.13725490196078433, 0.6784313725490196, 0.9568627450980393)
  self.nextColorDisable = Color(0.4117647058823529, 0.40784313725490196, 0.40784313725490196)
end

function UIHomelandMoviePrepareMainController:OnShow(uiParams)
  self:InitWidget()
  self:_OnValue()
  self:AttachEvent(GameEventType.HomeBuildOnSelectBuilding, self.HomeBuildOnSelectBuilding)
  self:AttachEvent(GameEventType.UIHomelandMoviePrepareActorSelected, self.OnNextBtnStateChange)
end

function UIHomelandMoviePrepareMainController:OnHide()
  self:DetachEvent(GameEventType.HomeBuildOnSelectBuilding, self.HomeBuildOnSelectBuilding)
  self:DetachEvent(GameEventType.UIHomelandMoviePrepareActorSelected, self.OnNextBtnStateChange)
end

function UIHomelandMoviePrepareMainController:InitWidget()
  self.topBtn = self:GetGameObject("topBtn")
  self.stages = self:GetUIComponent("UISelectObjectPath", "stages")
  self.stageOperate = self:GetGameObject("stageOperate")
  self.stageContent = self:GetGameObject("stageContent")
  self.arrowBtn = self:GetUIComponent("RectTransform", "arrowBtn")
  self.freeStagePool = self:GetUIComponent("UISelectObjectPath", "freeStagePool")
  self.otherStagePool = self:GetUIComponent("UISelectObjectPath", "otherStagePool")
  self.prepareGo = self:GetGameObject("prepare")
  self.mobileControlGo = self:GetGameObject("mobileBuildControl")
  self.operateGo = self:GetGameObject("operate")
  local mobilePool = self:GetUIComponent("UISelectObjectPath", "mobileBuildControl")
  self.mobileControl = mobilePool:SpawnObject("UIWidgetHomelandBuildController")
  local operatePool = self:GetUIComponent("UISelectObjectPath", "operate")
  self.operate = operatePool:SpawnObject("UIHomelandBuildEditOperate")
  self.txtNext = self:GetUIComponent("UILocalizationText", "txtNext")
  self._phasePanel = self:GetUIComponent("UISelectObjectPath", "phasePanel")
  self._phasePanelGo = self:GetGameObject("phasePanel")
  self._phasePanelRect = self:GetUIComponent("RectTransform", "phasePanel")
  self._animation = self:GetUIComponent("Animation", "animation")
end

function UIHomelandMoviePrepareMainController:_OnValue()
  self.furnitureWidget = self.freeStagePool:SpawnObject("UIHomelandMoviePrepareFurniture")
  self.otherWidget = self.otherStagePool:SpawnObject("UIHomelandMoviePrepareSelectItem")
  self.otherWidget:SetPhasePanel(self._phasePanel, self._phasePanelRect)
  self.furnitureWidget:SetUIWidgetHomelandBuildController(self.mobileControl)
  self.fatherBuilding = MoviePrepareData:GetInstance():GetFatherBuild()
  local len = table.count(self.stagesConfig)
  self.stages:SpawnObjects("PrepareStageItem", len)
  local items = self.stages:GetAllSpawnList()
  for idx, subItem in pairs(items) do
    local subConfig = self.stagesConfig[idx]
    subItem:SetData(subConfig.name, subConfig.prepareType, function(item)
      self:OnStageItemClicked(item)
    end)
    self.stageItems[subConfig.prepareType] = subItem
    if idx == 1 then
      self.curPrepareStageItem = subItem
      self.curPrepareType = self.curPrepareStageItem:GetPrepareType()
      self.curPrepareStageItem:SetSelect(true)
    else
      subItem:SetSelect(false)
    end
  end
  self:ChangeStageContent(nil, self.curPrepareType)
end

function UIHomelandMoviePrepareMainController:GetPrepareWidget(prepareType)
  if prepareType == MoviePrepareType.PT_Furniture then
    return self.furnitureWidget
  else
    return self.otherWidget
  end
end

function UIHomelandMoviePrepareMainController:OnStageItemClicked(item)
  if item == self.curPrepareStageItem then
    return
  end
  if self.curPrepareStageItem then
    self.curPrepareStageItem:SetSelect(false)
  end
  local lastType = self.curPrepareType
  local newType = item:GetPrepareType()
  item:SetSelect(true)
  self.curPrepareStageItem = item
  self.curPrepareType = newType
  self:ChangeStageContent(lastType, newType)
  self:RefreshNextBtnColor()
end

function UIHomelandMoviePrepareMainController:ChangeStageContent(lastType, curType)
  if lastType then
    if lastType == MoviePrepareType.PT_Furniture then
      self.furnitureWidget:OnExit(lastType)
    else
      self.otherWidget:OnExit(lastType)
    end
    self._animation:Play("UIHomelandMoviePrepareMainController_up")
  end
  self.mobileControlGo:SetActive(curType == MoviePrepareType.PT_Furniture)
  if curType == MoviePrepareType.PT_Furniture then
    self.furnitureWidget:GetGameObject():SetActive(true)
    self.otherWidget:GetGameObject():SetActive(false)
    self.furnitureWidget:OnEnter(curType)
    self.homelandClient:SetLockGlobalCamera(nil)
    self.homelandClient:BuildManager():SetBuildEditorMode(BuildEditorMode.MakeMovieFree)
    self._phasePanelGo:SetActive(false)
  else
    self.furnitureWidget:GetGameObject():SetActive(false)
    self.otherWidget:GetGameObject():SetActive(true)
    self.otherWidget:OnEnter(curType)
    self.homelandClient:SetLockGlobalCamera(true)
    self.homelandClient:BuildManager():SetBuildEditorMode(BuildEditorMode.MakeMovieOther)
    self._camera = GameGlobal.UIStateManager():GetControllerCamera(self:GetName())
    self.otherWidget:SetCamera(self._camera)
    self._phasePanelGo:SetActive(true)
    self.otherWidget:ClearSelectBtns()
  end
  
  local function callBack()
    if curType ~= MoviePrepareType.PT_Furniture then
      self.otherWidget:RefreshSelectBtns()
    end
  end
  
  if self._hasEnter then
    self.mUIHomeland:FocusPreparePoint(self.fatherBuilding, curType, callBack)
  else
    self._hasEnter = true
    self.mUIHomeland:FocusPreparePointDirect(self.fatherBuilding, curType, callBack)
  end
  self:RefreshArrowPos()
end

function UIHomelandMoviePrepareMainController:BackBtnOnClick(go)
  local function Exit()
    self:StartTask(self._Exit, self)
  end
  
  local title
  local desc = StringTable.Get("str_movie_prepare_back_tips")
  local leftBtn = {
    StringTable.Get("str_common_cancel"),
    function(param)
    end
  }
  local rightBtn = {
    StringTable.Get("str_common_ok"),
    function()
      Exit()
    end
  }
  self:ShowDialog("UIHomelandMessageBox", title, desc, leftBtn, rightBtn, true)
end

function UIHomelandMoviePrepareMainController:_Exit(TT)
  self:Lock("HomeExitBuildMode")
  CutsceneManager.ExcuteCutsceneIn(UIStateType.UIHomeMovieStoryController .. "DirectIn", function()
    self:SwitchState(UIStateType.UIHomeland)
    CutsceneManager.ExcuteCutsceneOut()
    self:UnLock("HomeExitBuildMode")
  end)
  self.mUIHomeland:RestoreFreeChildrenInScene(MoviePrepareData:GetInstance():GetFatherBuild())
  self.mUIHomeland:ShowHightLightFreeArea(self.fatherBuilding, false)
  HomelandMoviePrepareManager:GetInstance():ClearAll()
  HomelandMoviePrepareManager:GetInstance():Dispose()
  self.homelandClient:SetLockGlobalCamera(nil)
  self.homelandClient:FinishBuild(TT)
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMEnterHomeland, AudioConstValue.BGMCrossFadeTime)
end

function UIHomelandMoviePrepareMainController:IntroduceBtnOnClick(go)
  local movieId = MoviePrepareData:GetInstance():GetMovieId()
  self:ShowDialog("UIHomelandMovieIntroduceController", movieId)
end

function UIHomelandMoviePrepareMainController:ClearBtnOnClick(go)
  local title
  local desc = self:GetClearTipsContent()
  local leftBtn = {
    StringTable.Get("str_common_cancel"),
    function(param)
    end
  }
  local rightBtn = {
    StringTable.Get("str_common_ok"),
    function()
      if self.curPrepareType == MoviePrepareType.PT_Furniture then
        self.furnitureWidget:Clear(self.curPrepareType)
      else
        self.otherWidget:Clear(self.curPrepareType)
        self.otherWidget:RefreshSelectBtns()
      end
    end
  }
  self:ShowDialog("UIHomelandMessageBox", title, desc, leftBtn, rightBtn, true)
end

function UIHomelandMoviePrepareMainController:GetClearTipsContent()
  if self.curPrepareType == MoviePrepareType.PT_Scene then
    return StringTable.Get("str_movie_prepare_clear_scene_tips")
  elseif self.curPrepareType == MoviePrepareType.PT_Prop then
    return StringTable.Get("str_movie_prepare_clear_prop_tips")
  elseif self.curPrepareType == MoviePrepareType.PT_Furniture then
    return StringTable.Get("str_movie_prepare_clear_furniture_tips")
  elseif self.curPrepareType == MoviePrepareType.PT_Actor then
    return StringTable.Get("str_movie_prepare_clear_actor_tips")
  else
    return nil
  end
end

function UIHomelandMoviePrepareMainController:NextBtnOnClick(go)
  if self.curPrepareType == MoviePrepareType.PT_Actor then
    if self.otherWidget:CheckExit(self.curPrepareType) then
      self:ShowDialog("UIHomelandMovieActionController")
    else
      ToastManager.ShowHomeToast(StringTable.Get("str_movie_prepare_actor_noenough"))
    end
    return
  end
  local nextType = self.curPrepareType + 1
  local nextItem = self.stageItems[nextType]
  if nextItem then
    self:OnStageItemClicked(nextItem)
  end
end

function UIHomelandMoviePrepareMainController:RefreshNextBtnColor()
  local enable = true
  if self.curPrepareType == MoviePrepareType.PT_Actor then
    enable = self.otherWidget:CheckExit(self.curPrepareType)
  end
  if enable then
    self.txtNext.color = self.nextColorEnable
  else
    self.txtNext.color = self.nextColorDisable
  end
end

function UIHomelandMoviePrepareMainController:OnNextBtnStateChange(state)
  self:RefreshNextBtnColor()
end

function UIHomelandMoviePrepareMainController:ArrowBtnOnClick(go)
  if self.stageContent.activeInHierarchy then
    self.stageContent:SetActive(false)
    self.arrowBtn.anchoredPosition = Vector2(-57, 83)
    self.arrowBtn.localScale = Vector3(1, -1, 1)
  else
    self.stageContent:SetActive(true)
    local h = self:GetArrowTopHeight()
    self.arrowBtn.anchoredPosition = Vector2(-57, h)
    self.arrowBtn.localScale = Vector3.one
  end
end

function UIHomelandMoviePrepareMainController:RefreshArrowPos()
  if self.stageContent.activeInHierarchy then
    local h = self:GetArrowTopHeight()
    self.arrowBtn.anchoredPosition = Vector2(-57, h)
  end
end

function UIHomelandMoviePrepareMainController:GetArrowTopHeight()
  if self.curPrepareType == MoviePrepareType.PT_Furniture then
    return 407
  else
    return 315
  end
end

function UIHomelandMoviePrepareMainController:HomeBuildOnSelectBuilding()
  local homeBuilding = self.homeBuildManager:GetCurrentBuilding()
  if homeBuilding then
    self.prepareGo:SetActive(false)
    self.operateGo:SetActive(true)
    self.operate:FlushOperate()
  else
    self.prepareGo:SetActive(true)
    self.operateGo:SetActive(false)
    self.furnitureWidget:Refresh(self.curPrepareType)
  end
end
