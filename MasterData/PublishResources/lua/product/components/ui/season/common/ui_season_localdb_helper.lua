_class("UISeasonLocalDBHelper", Object)
UISeasonLocalDBHelper = UISeasonLocalDBHelper

function UISeasonLocalDBHelper.CurSeason_GetKey(str)
  local seasonModule = GameGlobal.GetModule(SeasonModule)
  local seasonId = seasonModule:GetCurSeasonID()
  local str_id = string.format("UISeason_%d_%s_", seasonId, str)
  local key = UIActivityHelper.GetLocalDBKeyWithPstId(str_id)
  return key
end

function UISeasonLocalDBHelper._SeasonBtn_GetKey(btnName, funcName)
  return UISeasonLocalDBHelper.CurSeason_GetKey(btnName .. "_" .. funcName .. "_")
end

function UISeasonLocalDBHelper.SeasonBtn_Has(btnName, funcName)
  local key = UISeasonLocalDBHelper._SeasonBtn_GetKey(btnName, funcName)
  return LocalDB.HasKey(key)
end

function UISeasonLocalDBHelper.SeasonBtn_Get(btnName, funcName, value)
  value = value or 1
  local key = UISeasonLocalDBHelper._SeasonBtn_GetKey(btnName, funcName)
  return LocalDB.GetInt(key, value)
end

function UISeasonLocalDBHelper.SeasonBtn_Set(btnName, funcName, value)
  value = value or 1
  local key = UISeasonLocalDBHelper._SeasonBtn_GetKey(btnName, funcName)
  LocalDB.SetInt(key, value)
end

function UISeasonLocalDBHelper.SeasonBtn_Delete(btnName, funcName)
  local key = UISeasonLocalDBHelper._SeasonBtn_GetKey(btnName, funcName)
  LocalDB.Delete(key)
end

function UISeasonLocalDBHelper.Season_GetKey(seasonId, str)
  str = string.format("UISeason_%d_%s_", seasonId, str)
  local key = UIActivityHelper.GetLocalDBKeyWithPstId(str)
  return key
end

function UISeasonLocalDBHelper._SeasonFinalPlotBtnShowed_GetKey(seasonId)
  return UISeasonLocalDBHelper.Season_GetKey(seasonId, "finalPlotBtnShowed")
end

function UISeasonLocalDBHelper.SeasonFinalPlotBtnShowed_Has(seasonId)
  local key = UISeasonLocalDBHelper._SeasonFinalPlotBtnShowed_GetKey(seasonId)
  return LocalDB.HasKey(key)
end

function UISeasonLocalDBHelper.SeasonFinalPlotBtnShowed_Set(seasonId)
  local key = UISeasonLocalDBHelper._SeasonFinalPlotBtnShowed_GetKey(seasonId)
  LocalDB.SetInt(key, 1)
end

function UISeasonLocalDBHelper.SeasonFinalPlotBtnShowed_Delete(seasonId)
  local key = UISeasonLocalDBHelper._SeasonFinalPlotBtnShowed_GetKey(seasonId)
  LocalDB.Delete(key)
end
