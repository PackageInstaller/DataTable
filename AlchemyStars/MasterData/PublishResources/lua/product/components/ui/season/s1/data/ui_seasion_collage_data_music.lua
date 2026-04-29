_class("UISeasonCollageData_Music", Object)
UISeasonCollageData_Music = UISeasonCollageData_Music

function UISeasonCollageData_Music:Constructor()
  self._Index = nil
  self._ID = nil
  self._Valid = nil
  self._IsUnlock = nil
  self._IsNew = nil
  self._audioID = nil
end

function UISeasonCollageData_Music:Index()
  return self._Index
end

function UISeasonCollageData_Music:ID()
  return self._ID
end

function UISeasonCollageData_Music:IsValid()
  return self._Valid
end

function UISeasonCollageData_Music:IsUnlock()
  return self._IsUnlock
end

function UISeasonCollageData_Music:IsNew()
  return self._IsNew
end

function UISeasonCollageData_Music:AudioID()
  if not self._audioID then
    self._audioID = Cfg.cfg_role_music[self._ID].AudioID
  end
  return self._audioID
end

function UISeasonCollageData_Music:Duration()
  if not self._duration then
    self._duration = Cfg.cfg_role_music[self._ID].Duration
  end
  return self._duration
end
