_class("UIHomelandMovieMainController", UIController)
UIHomelandMovieMainController = UIHomelandMovieMainController

function UIHomelandMovieMainController:Constructor()
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
  self._movieList = nil
  self._movieData = nil
  self._movieWidgets = {}
  self._scoreWidgets = {}
  self._curMovieWidget = nil
  self._pstID = nil
  self._homelandModule = GameGlobal.GetModule(HomelandModule)
  self._hasHistory = false
  self._build = nil
  self._atlas = self:GetAsset("UIHomelandMovie.spriteatlas", LoadType.SpriteAtlas)
  self._isHide = false
  self._preRawImageName = nil
  self._fadeTime = 0.5
end

function UIHomelandMovieMainController:OnShow(param)
  self._build = param[1]
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMN17, AudioConstValue.BGMCrossFadeTime)
  self:InitWidget()
  self:ShowMovieTag()
  self:GetMovieTag()
  self._movieDataHelper = MovieDataHelper:New()
  local type, AnonymousId = self._movieDataHelper:ShowOrNot()
  if type then
    self:ShowAnonymous(AnonymousId)
  end
end

function UIHomelandMovieMainController:InitWidget()
  self._movieTitle = self:GetUIComponent("UILocalizationText", "movieTitle")
  self._movieContent = self:GetUIComponent("UILocalizationText", "movieContent")
  self._contentRect = self:GetUIComponent("RectTransform", "introContent")
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._scores = self:GetUIComponent("UISelectObjectPath", "scores")
  self._movieBG = self:GetUIComponent("RawImageLoader", "movieBG")
  self._movieBGPre = self:GetUIComponent("RawImageLoader", "movieBGPre")
  self._movieRawBG = self:GetUIComponent("RawImage", "movieBG")
  self._movieRawBGPre = self:GetUIComponent("RawImage", "movieBGPre")
  self._playbackBtn = self:GetUIComponent("Image", "playbackBtn")
  self._camera = self:GetUIComponent("Image", "camera")
  self._chooseText = self:GetUIComponent("UILocalizationText", "chooseText")
  self._root = self:GetGameObject("root")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._tagContent = self:GetUIComponent("UISelectObjectPath", "TagContent")
end

function UIHomelandMovieMainController:OnHide()
end

function UIHomelandMovieMainController:BtnBackOnClick(TT)
  self:CloseDialog()
  AudioHelperController.PlayBGM(CriAudioIDConst.BGMEnterHomeland, AudioConstValue.BGMCrossFadeTime)
end

function UIHomelandMovieMainController:ChooseMovieOnClick(TT)
  if self._movieData then
    GameGlobal.TaskManager():StartTask(function(TT)
      self:MakingMovie(TT, self._movieData)
    end)
  else
    Log.fatal("选择剧本失败 没有剧本信息")
  end
end

function UIHomelandMovieMainController:MakingMovie(TT, data)
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local reply, psdId = homelandModule:HandleEnterMakingMovice(TT, data.ID)
  if reply:GetSucc() then
    MoviePrepareData:GetInstance():SetMovieData(data.ID, psdId, self._build)
    Log.fatal(homelandModule.movice_pstid)
    self.mUIHomeland:EnterMoviePrepare(TT)
  else
    if reply.m_result == HomeLandErrorType.E_MOVICE_NOT_UNLOCK then
      ToastManager.ShowHomeToast(StringTable.Get(Cfg.cfg_homeland_movice[data.ID].Achieve))
    end
    Log.fatal("选择剧本请求异常")
  end
end

function UIHomelandMovieMainController:ShowAnonymous(AnonymousId)
  self:ShowDialog("UIHomelandAnonymousPopController", AnonymousId)
end

function UIHomelandMovieMainController:ChooseActorOnClick()
  self:ShowDialog("UIHomelandMovieActorController", self._movieData)
end

function UIHomelandMovieMainController:PlayBackbtnOnClick()
  if self._hasHistory then
    self:ShowDialog("UIHomelandMoviePlaybackController", self._movieData, self._build)
  else
    ToastManager.ShowHomeToast(StringTable.Get("str_movie_toast_Nohistory"))
  end
end

function UIHomelandMovieMainController:ShowMovieTag()
  local cfg = Cfg.cfg_homeland_movie_tag({})
  local tag = {}
  for i, v in ipairs(cfg) do
    table.insert(tag, v.ID)
  end
  local len = #tag
  local index = 1
  self._movieWidgets = self._tagContent:SpawnObjects("UIHomelandMovieTagItem", len)
  for i, v in pairs(cfg) do
    self._movieWidgets[index]:SetData(v, index, function(item)
      self:OnTagClicked(item)
    end)
    if index == 1 then
      self:OnTagClicked(self._movieWidgets[index])
    end
    index = index + 1
  end
end

function UIHomelandMovieMainController:OnTagClicked(item)
  if self._curTagWidget then
    if self._curTagWidget == item then
      self.sameClick = true
    else
      self.sameClick = false
    end
    self._curTagWidget:SetSelected(false)
    self._curTagWidget:SetRed()
  end
  self._curTagWidget = item
  self._curTagWidget:SetSelected(true)
end

function UIHomelandMovieMainController:GetMovieTag()
  local cfg = Cfg.cfg_homeland_movie_tag({})
  local tag = cfg[1].MovieId
  self:InitDramaList(tag)
end

function UIHomelandMovieMainController:InitDramaList(tag)
  if self.sameClick then
    return
  end
  self.refresh = false
  if tag == nil then
    local cfg = Cfg.cfg_homeland_movie_tag({})
    tag = cfg[1].MovieId
  end
  self._movieList = MovieDataManager:GetInstance():GetSortMovieList(tag)
  local len = table.count(self._movieList)
  local index = 1
  self._movieWidgets = self._content:SpawnObjects("UIHomelandMovieMainItem", len)
  for i, v in pairs(self._movieList) do
    self._movieWidgets[index]:SetData(v, index, function(item)
      self:OnDramaItemClicked(item)
    end)
    if index == 1 then
      self.refresh = true
      self:OnDramaItemClicked(self._movieWidgets[index])
    end
    index = index + 1
  end
  self.refresh = false
end

function UIHomelandMovieMainController:OnDramaItemClicked(item)
  local data = item:GetData()
  if self._movieData == data then
    return
  end
  self._anim:Play("UIHomelandMovieMainController_scores")
  self._movieData = data
  if self._curMovieWidget then
    self._curMovieWidget:SetSelected(false, self.refresh)
  end
  self._curMovieWidget = item
  self._curMovieWidget:SetSelected(true, self.refresh)
  local history = MovieDataManager:GetInstance():GetMovieHistoryDataByID(self._movieData.ID)
  self._hasHistory = table.count(history) > 0
  if self._hasHistory then
    self._camera.sprite = self._atlas:GetSprite("dy_xzjb_icon06")
    self._playbackBtn.sprite = self._atlas:GetSprite("dy_xzjb_di03")
    self._chooseText.color = Color(0.5019607843137255, 0.5019607843137255, 0.5019607843137255)
  else
    self._camera.sprite = self._atlas:GetSprite("dy_xzjb_icon07")
    self._playbackBtn.sprite = self._atlas:GetSprite("dy_xzjb_di14")
    self._chooseText.color = Color(0.8980392156862745, 0.8980392156862745, 0.8980392156862745)
  end
  self:InitDramaInfo(item)
  self._curTagWidget:SetRed()
end

function UIHomelandMovieMainController:_FadeBG(rawImage)
  self._movieRawBG:DOFade(1, 0)
  if self._preRawImageName then
    self._movieBG:LoadImage(self._preRawImageName)
  else
    self._movieRawBG:DOFade(0, 0)
  end
  self._movieBGPre:LoadImage(rawImage)
  self._movieRawBGPre:DOFade(0, 0)
  self._movieRawBGPre:DOFade(1, self._fadeTime)
  self._preRawImageName = rawImage
end

function UIHomelandMovieMainController:InitDramaInfo(item)
  local scoreList = item:GetScoreList()
  local len = self:_CountScoreLen(scoreList)
  local index = 1
  local curScore = 0
  self._movieTitle:SetText(StringTable.Get(self._movieData.Name))
  self._movieContent:SetText(StringTable.Get(self._movieData.Intro))
  self._contentRect.anchoredPosition = Vector2(0, 0)
  self:_FadeBG(self._movieData.Background)
  self._scoreWidgets = self._scores:SpawnObjects("UIHomelandMovieMainScoreItem", len)
  for i, v in pairs(scoreList) do
    if curScore ~= v[1] then
      curScore = v[1]
      self._scoreWidgets[index]:SetData(v, self._movieData.ID)
      index = index + 1
    end
  end
end

function UIHomelandMovieMainController:ExplainBtnOnClick()
  self:ShowDialog("UIHomelandMovieExplainController", self._movieData)
end

function UIHomelandMovieMainController:EyeBtnOnClick()
  self._isHide = true
  self._root:SetActive(false)
end

function UIHomelandMovieMainController:MovieBGOnClick()
  if self._isHide then
    self._isHide = false
    self._root:SetActive(true)
  end
end

function UIHomelandMovieMainController:_CountScoreLen(list)
  local len = 0
  local curScore = 0
  for i, v in pairs(list) do
    if v[1] ~= curScore then
      curScore = v[1]
      len = len + 1
    end
  end
  return len
end
