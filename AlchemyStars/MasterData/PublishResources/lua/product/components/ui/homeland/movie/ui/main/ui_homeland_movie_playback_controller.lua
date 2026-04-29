_class("UIHomelandMoviePlaybackController", UIController)
UIHomelandMoviePlaybackController = UIHomelandMoviePlaybackController

function UIHomelandMoviePlaybackController:Constructor()
  self._movieData = nil
  self._isRoast = true
  self._actorList = nil
  self._actorWidgetList = nil
  self._playbackList = nil
  self._maxPlaybackNum = 1
  self._curPlayback = 1
  self._starTable = nil
  self._atlas = nil
  self._build = nil
  self._timeEvents = {}
  self._canClick = true
  self._totalTime = 1200
  self.mHomeland = GameGlobal.GetModule(HomelandModule)
  self.mUIHomeland = self.mHomeland:GetUIModule()
  self.homelandClient = self.mUIHomeland:GetClient()
end

function UIHomelandMoviePlaybackController:OnShow(uiParams)
  self._actorList = {}
  self._actorWidgetList = {}
  self._playbackList = {}
  self._movieData = uiParams[1]
  self._build = uiParams[2]
  self._starTable = {}
  self._atlas = self:GetAsset("UIHomelandMovie.spriteatlas", LoadType.SpriteAtlas)
  self._isRoast = MoviePrepareData:GetInstance():GetOpenTease()
  self:InitWidget()
  self:GetPlaybackData()
  self:SetPlaybackData()
  self:SetToast()
end

function UIHomelandMoviePlaybackController:InitWidget()
  self._content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._rect = self:GetUIComponent("RectTransform", "Content")
  self._moviePoster = self:GetUIComponent("RawImageLoader", "moviePoster")
  self._shotData = self:GetUIComponent("UILocalizationText", "shotData")
  self._playbackTitle = self:GetUIComponent("UILocalizationText", "playbackTitle")
  self._orderText = self:GetUIComponent("UILocalizationText", "orderText")
  self._roastBtn = self:GetUIComponent("Image", "roastBtn")
  self._roastIcon = self:GetUIComponent("Image", "roastIcon")
  self._leftBtn = self:GetGameObject("leftBtn")
  self._righttBtn = self:GetGameObject("rightBtn")
  self._shine = self:GetGameObject("shine")
  self._starParentObj = self:GetGameObject("scoreText")
  self._pointsParentObj = self:GetGameObject("points")
  self._shotText = self:GetUIComponent("UILocalizationText", "shotText")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._shotData1 = self:GetUIComponent("UILocalizationText", "shotData1")
  self._orderText1 = self:GetUIComponent("UILocalizationText", "orderText1")
  self._playbackTitle1 = self:GetUIComponent("UILocalizationText", "playbackTitle1")
  self._starParentObj1 = self:GetGameObject("scoreText1")
  self._shine1 = self:GetGameObject("shine1")
  self._stars = {}
  self._stars1 = {}
  self._points = {}
  for i = 1, 5 do
    local trans = GameObjectHelper.FindChild(self._starParentObj.transform, "star" .. i)
    local trans1 = GameObjectHelper.FindChild(self._starParentObj1.transform, "star" .. i)
    self._stars[i] = {}
    self._stars1[i] = {}
    self._stars[i].image = trans:GetComponent("Image")
    self._stars1[i].image = trans1:GetComponent("Image")
  end
end

function UIHomelandMoviePlaybackController:OnHide()
end

function UIHomelandMoviePlaybackController:GetPlaybackData()
  self._playbackList = MovieDataManager:GetInstance():GetMovieHistoryDataByID(self._movieData.ID)
  self._maxPlaybackNum = table.count(self._playbackList)
  self._leftBtn:SetActive(false)
  self._righttBtn:SetActive(self._maxPlaybackNum > 1)
  for i = 1, 3 do
    local trans = GameObjectHelper.FindChild(self._pointsParentObj.transform, "point" .. i)
    self._points[i] = {}
    self._points[i].trans = trans
    trans.gameObject:SetActive(i <= self._maxPlaybackNum)
    self._points[i].rect = trans:GetComponent("RectTransform")
    self._points[i].image = trans:GetComponent("Image")
  end
end

function UIHomelandMoviePlaybackController:SetPlaybackData()
  local data = self._playbackList[self._curPlayback]
  local time = data.date
  self._moviePoster:LoadImage(self._movieData.Poster)
  self._shotData:SetText(TimeToDate4(time, "min"))
  self._playbackTitle:SetText(data.name)
  self._orderText:SetText("0" .. self._curPlayback .. ".")
  self._shotData1:SetText(TimeToDate4(time, "min"))
  self._playbackTitle1:SetText(data.name)
  self._orderText1:SetText("0" .. self._curPlayback .. ".")
  self:InitActorList()
  self:_InitScore()
end

function UIHomelandMoviePlaybackController:SetToast()
  if not self._isRoast then
    self._roastBtn.sprite = self._atlas:GetSprite("dy_dyhf_di01")
    self._roastIcon.sprite = self._atlas:GetSprite("dy_dyhf_icon06")
    self._shotText.color = Color(0.8980392156862745, 0.8980392156862745, 0.8980392156862745)
  else
    self._roastBtn.sprite = self._atlas:GetSprite("dy_kxyy_di05")
    self._roastIcon.sprite = self._atlas:GetSprite("dy_dyhf_icon05")
    self._shotText.color = Color(1.0, 1.0, 1.0)
  end
end

function UIHomelandMoviePlaybackController:InitActorList()
  local data = self._playbackList[self._curPlayback]
  self._actorList = data.chose_pets
  self._actorWidgetList = self._content:SpawnObjects("UIHomelandMoviePlaybackItem", table.count(self._actorList))
  self._rect.anchoredPosition = Vector2(0, 0)
  local index = 1
  for i, v in pairs(self._actorList) do
    self._actorWidgetList[index]:SetData(v, self._movieData)
    index = index + 1
  end
end

function UIHomelandMoviePlaybackController:_InitScore()
  local data = self._playbackList[self._curPlayback]
  local score = MovieDataManager:GetInstance():CaculateTotalScore(data)
  self._shine:SetActive(5 <= score)
  self._shine1:SetActive(5 <= score)
  local index = 1
  while score >= index do
    self._stars[index].image.sprite = self._atlas:GetSprite("dy_cd_icon03")
    self._stars1[index].image.sprite = self._atlas:GetSprite("dy_cd_icon03")
    index = index + 1
  end
  if 5 < index then
    return
  end
  if score % 1 >= 0.5 then
    self._stars[index].image.sprite = self._atlas:GetSprite("dy_cd_icon04")
    self._stars1[index].image.sprite = self._atlas:GetSprite("dy_cd_icon04")
    index = index + 1
  end
  while index <= 5 do
    self._stars[index].image.sprite = self._atlas:GetSprite("dy_cd_icon05")
    self._stars1[index].image.sprite = self._atlas:GetSprite("dy_cd_icon05")
    index = index + 1
  end
end

function UIHomelandMoviePlaybackController:BtnBackOnClick()
  self:CloseDialog()
end

function UIHomelandMoviePlaybackController:LeftBtnOnClick()
  if not self._canClick then
    return
  end
  self._righttBtn:SetActive(true)
  self:SetPointSelect(self._curPlayback, false)
  self:SetPointSelect(self._curPlayback - 1, true)
  self._curPlayback = self._curPlayback - 1
  self._anim:Play("UIHomelandMoviePlaybackController_right")
  self:_LockClick()
  if self._curPlayback == 1 then
    self._leftBtn:SetActive(false)
  end
  self:SetPlaybackData()
end

function UIHomelandMoviePlaybackController:RightBtnOnClick()
  if not self._canClick then
    return
  end
  self._leftBtn:SetActive(true)
  self:SetPointSelect(self._curPlayback, false)
  self:SetPointSelect(self._curPlayback + 1, true)
  self._curPlayback = self._curPlayback + 1
  self._anim:Play("UIHomelandMoviePlaybackController_left")
  self:_LockClick()
  if self._curPlayback == self._maxPlaybackNum then
    self._righttBtn:SetActive(false)
  end
  self:SetPlaybackData()
end

function UIHomelandMoviePlaybackController:_LockClick()
  self._canClick = false
  local te = GameGlobal.Timer():AddEvent(self._totalTime, function()
    self._canClick = true
  end)
  table.insert(self._timeEvents, te)
end

function UIHomelandMoviePlaybackController:PlayBtnOnClick()
  GameGlobal.TaskManager():StartTask(function(TT)
    local data = self._playbackList[self._curPlayback]
    self:StartPlayback(TT, data)
  end)
end

function UIHomelandMoviePlaybackController:StartPlayback(TT, playbackData)
  local homelandModule = GameGlobal.GetModule(HomelandModule)
  local reply, arch_list = homelandModule:HandleRequesRecordArch(TT, playbackData.pstid, playbackData.movice_id)
  if reply:GetSucc() then
    MoviePrepareData:GetInstance():SetReplayData(self._build, self._isRoast, arch_list, playbackData)
    self.mUIHomeland:EnterRepalyMovie(TT)
  else
    Log.fatal("播放回放请求异常")
  end
end

function UIHomelandMoviePlaybackController:RoastBtnOnClick()
  if self._isRoast then
    ToastManager.ShowHomeToast(StringTable.Get("str_movie_totas_buji_Off"))
  else
    ToastManager.ShowHomeToast(StringTable.Get("str_movie_totas_buji_On"))
  end
  self._isRoast = not self._isRoast
  self:SetToast()
  MoviePrepareData:GetInstance():SetOpenTease(self._isRoast)
end

function UIHomelandMoviePlaybackController:SetPointSelect(index, select)
  if select then
    if self._points[index] then
      self._points[index].image.sprite = self._atlas:GetSprite("dy_dyhf_icon03")
      self._points[index].rect.sizeDelta = Vector2(43, 18)
    end
  elseif self._points[index] then
    self._points[index].image.sprite = self._atlas:GetSprite("dy_dyhf_icon04")
    self._points[index].rect.sizeDelta = Vector2(20, 18)
  end
end

function GetTableValueByIndex(tb, index)
  local t = {}
  for i, v in pairs(tb) do
    t[#t + 1] = v.pstid
  end
  table.sort(t)
  return tb[t[index]]
end
