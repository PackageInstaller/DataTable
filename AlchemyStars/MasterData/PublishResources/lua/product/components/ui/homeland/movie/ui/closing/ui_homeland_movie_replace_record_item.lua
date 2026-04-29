_class("UIHomelandMovieReplaceRecordItem", UICustomWidget)
UIHomelandMovieReplaceRecordItem = UIHomelandMovieReplaceRecordItem

function UIHomelandMovieReplaceRecordItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIHomelandMovieReplaceRecordItem:SetData(pstId, record)
  self._pstId = pstId
  self._record = record
  self:_OnValue()
end

function UIHomelandMovieReplaceRecordItem:_GetComponents()
  self._recordNameTex = self:GetUIComponent("UILocalizationText", "recordName")
  self._makeTimeTex = self:GetUIComponent("UILocalizationText", "makeTime")
  self._starList = self:GetGameObject("starList")
  self._fullStarIcon = self:GetGameObject("FullStarIcon")
end

function UIHomelandMovieReplaceRecordItem:_OnValue()
  self._recordNameTex:SetText(self._record.name)
  local str = TimeToDate4(self._record.date, "min")
  self._makeTimeTex:SetText(str)
  local totalScore = MovieDataManager:GetInstance():CaculateTotalScore(self._record)
  local integerTotalScore = math.floor(totalScore)
  for i = 0, self._starList.transform.childCount - 1 do
    local star = self._starList.transform:GetChild(i)
    local score = i + 1
    if integerTotalScore >= score then
      star:Find("Full").gameObject:SetActive(true)
    elseif totalScore > i + 0.5 then
      star:Find("Half").gameObject:SetActive(true)
    end
  end
  if integerTotalScore == 5 then
    self._fullStarIcon:SetActive(true)
  end
end

function UIHomelandMovieReplaceRecordItem:BtnOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.UIHomelandMovieReplaceRecordSelect, self._pstId)
end
