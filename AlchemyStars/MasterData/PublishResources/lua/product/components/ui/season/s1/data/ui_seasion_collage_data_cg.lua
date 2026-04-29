_class("UISeasonCollageData_CG", Object)
UISeasonCollageData_CG = UISeasonCollageData_CG

function UISeasonCollageData_CG:Constructor()
  self._Index = nil
  self._ID = nil
  self._Valid = nil
  self._IsUnlock = nil
  self._IsNew = nil
  self._CanShare = nil
  self._ShareAwardCount = nil
end

function UISeasonCollageData_CG:Index()
  return self._Index
end

function UISeasonCollageData_CG:ID()
  return self._ID
end

function UISeasonCollageData_CG:IsValid()
  return self._Valid
end

function UISeasonCollageData_CG:IsUnlock()
  return self._IsUnlock
end

function UISeasonCollageData_CG:IsNew()
  return self._IsNew
end

function UISeasonCollageData_CG:CanShare()
  return self._CanShare
end

function UISeasonCollageData_CG:ShareAwardCount()
  return self._ShareAwardCount
end
