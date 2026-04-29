_class("UISeasonCollageData_Collection", Object)
UISeasonCollageData_Collection = UISeasonCollageData_Collection

function UISeasonCollageData_Collection:Constructor()
  self._Index = nil
  self._ID = nil
  self._IsNew = nil
  self._IsGot = nil
  self._IsComposeUsed = nil
  self._GetTime = nil
  self._IsFinalPlotItem = nil
end

function UISeasonCollageData_Collection:Index()
  return self._Index
end

function UISeasonCollageData_Collection:ID()
  return self._ID
end

function UISeasonCollageData_Collection:IsNew()
  return self._IsNew
end

function UISeasonCollageData_Collection:IsGot()
  return self._IsGot
end

function UISeasonCollageData_Collection:IsComposeUsed()
  return self._IsComposeUsed
end

function UISeasonCollageData_Collection:GetTime()
  return self._GetTime
end

function UISeasonCollageData_Collection:IsFinalPlotItem()
  return self._IsFinalPlotItem
end
