_class("UISeasonExploreHelper", Object)
UISeasonExploreHelper = UISeasonExploreHelper

function UISeasonExploreHelper.GetPreviewCfg()
  local svrTimeModule = GameGlobal.GetModule(SvrTimeModule)
  local loginModule = GameGlobal.GetModule(LoginModule)
  local curTime = math.floor(svrTimeModule:GetServerTime() * 0.001)
  local cfgs = Cfg.cfg_season_preview({})
  for k, cfg in pairs(cfgs) do
    local beginShowTime = loginModule:GetTimeStampByTimeStr(cfg.BeginShowTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if curTime < beginShowTime then
      return
    end
    local openTime = loginModule:GetTimeStampByTimeStr(cfg.SeasonOpenTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    local endShowTime = loginModule:GetTimeStampByTimeStr(cfg.EndShowTime, Enum_DateTimeZoneType.E_ZoneType_GMT)
    if curTime < endShowTime then
      return cfg, openTime
    end
  end
  return
end

function UISeasonExploreHelper.GetSeasonCgCfgs()
  local cfgs = GameGlobal.GetModule(BookModule):GetShowCfgsWithType(4)
  return cfgs
end

function UISeasonExploreHelper.IsSeasonCgHasNew()
  local cfgs = GameGlobal.GetModule(BookModule):GetShowCfgsWithType(4)
  local bookModule = GameGlobal.GetModule(BookModule)
  for k, v in pairs(cfgs) do
    local k, isUnLock = bookModule:GetSeasonStory(v)
    if isUnLock and not UISeasonExploreHelper.IsCgHasClicked(v.ID) then
      return true
    end
  end
  return false
end

function UISeasonExploreHelper.IsCgHasClicked(cgId)
  local key = UISeasonExploreHelper.GetCgNewKey(cgId)
  return UISeasonExploreHelper._HasKey(key)
end

function UISeasonExploreHelper.SetCgAsClicked(cgId)
  local key = UISeasonExploreHelper.GetCgNewKey(cgId)
  UISeasonExploreHelper._SetKey(key)
end

function UISeasonExploreHelper.GetCgNewKey(cgId)
  return "season_cg_click" .. cgId
end

function UISeasonExploreHelper:GetSeasonMusicCfgs()
  local roleModule = GameGlobal.GetModule(RoleModule)
  local retCfgs = {}
  local cfgs = Cfg.cfg_role_music({})
  for k, cfg in pairs(cfgs) do
    if roleModule:UI_CheckTimeUnlock(cfg) then
      table.insert(retCfgs, cfg)
    end
  end
  return retCfgs
end

function UISeasonExploreHelper.IsSeasonMusicHasNew()
  local cfgs = UISeasonExploreHelper:GetSeasonMusicCfgs()
  local roleModule = GameGlobal.GetModule(RoleModule)
  for k, cfg in pairs(cfgs) do
    local isUnlock = not roleModule:UI_CheckMusicLock(cfg)
    if isUnlock and not UISeasonExploreHelper.IsMusicHasClicked(cfg.ID) then
      return true
    end
  end
  return false
end

function UISeasonExploreHelper.IsMusicHasClicked(musicId)
  local key = UISeasonExploreHelper.GetMusicNewKey(musicId)
  return UISeasonExploreHelper._HasKey(key)
end

function UISeasonExploreHelper.SetMusicAsClicked(musicId)
  local key = UISeasonExploreHelper.GetMusicNewKey(musicId)
  UISeasonExploreHelper._SetKey(key)
end

function UISeasonExploreHelper.GetMusicNewKey(musicId)
  return "season_music_click" .. musicId
end

function UISeasonExploreHelper.GetSeasonRareItems()
  local itemModule = GameGlobal.GetModule(ItemModule)
  local itmes = itemModule:GetItemListBySubType(ItemSubType.ItemSubType_Season_Collection)
  return itmes
end

function UISeasonExploreHelper.IsSeasonRareItemHasNew()
  local items = UISeasonExploreHelper.GetSeasonRareItems()
  if items then
    for k, item in pairs(items) do
      local isNew = not UISeasonExploreHelper.IsRareItemHasClicked(item:GetID())
      if isNew then
        return true
      end
    end
  end
  return false
end

function UISeasonExploreHelper.IsRareItemHasClicked(pstId)
  local key = UISeasonExploreHelper.GetRareItemKey(pstId)
  return UISeasonExploreHelper._HasKey(key)
end

function UISeasonExploreHelper.SetRareItemAsClicked(pstId)
  local key = UISeasonExploreHelper.GetRareItemKey(pstId)
  UISeasonExploreHelper._SetKey(key)
end

function UISeasonExploreHelper.GetRareItemKey(pstId)
  return "season_rare_item_click" .. pstId
end

function UISeasonExploreHelper.IsPreviewHasClicked(previewId)
  local key = UISeasonExploreHelper.GetPreviewKey(previewId)
  return UISeasonExploreHelper._HasKey(key)
end

function UISeasonExploreHelper.SetPreviewAsClicked(previewId)
  local key = UISeasonExploreHelper.GetPreviewKey(previewId)
  UISeasonExploreHelper._SetKey(key)
end

function UISeasonExploreHelper.GetPreviewKey(previewId)
  return "season_preview_click" .. previewId
end

function UISeasonExploreHelper._HasKey(k)
  local key = UISeasonExploreHelper._GetPrefsKey(k)
  return UnityEngine.PlayerPrefs.HasKey(key)
end

function UISeasonExploreHelper._SetKey(k)
  local key = UISeasonExploreHelper._GetPrefsKey(k)
  UnityEngine.PlayerPrefs.SetInt(key, 1)
end

function UISeasonExploreHelper._GetPrefsKey(str)
  local mRole = GameGlobal.GetModule(RoleModule)
  local pstId = mRole:GetPstId()
  local playerPrefsKey = pstId .. str
  return playerPrefsKey
end

UISeasonExploreHelper.playingStateNone = 0
UISeasonExploreHelper.playingStatePlaying = 1
UISeasonExploreHelper.playingStatePause = 2
