_class("UIHomelandMoviePrepareBase", UICustomWidget)
UIHomelandMoviePrepareBase = UIHomelandMoviePrepareBase

function UIHomelandMoviePrepareBase:OnEnter(prepareType)
  self:Refresh(prepareType)
end

function UIHomelandMoviePrepareBase:OnExit(prepareType)
end

function UIHomelandMoviePrepareBase:CheckExit(prepareType)
  return true
end

function UIHomelandMoviePrepareBase:Refresh(prepareType)
end

function UIHomelandMoviePrepareBase:Clear(prepareType)
  MoviePrepareData:GetInstance():ClearData(prepareType)
  self:Refresh(prepareType)
end
