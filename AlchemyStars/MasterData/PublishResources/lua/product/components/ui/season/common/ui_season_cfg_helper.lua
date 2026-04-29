_class("UISeasonCfgHelper", Object)
UISeasonCfgHelper = UISeasonCfgHelper

function UISeasonCfgHelper.CfgSeason_CampaignClient(id)
  local cfg = Cfg.cfg_season_campaign_client[id]
  UISeasonCfgHelper.CheckCfgNil(cfg, "cfg_season_campaign_client", id)
  return cfg
end

function UISeasonCfgHelper.GetCurSeasonMedalGroupCfg(id)
  if id == -1 then
    return
  end
  local cfg = UISeasonCfgHelper.CfgSeason_CampaignClient(id)
  local medalId = cfg and cfg.MedalGroupID
  if medalId then
    local medalCfg = Cfg.cfg_item_medal_group[medalId]
    UISeasonCfgHelper.CheckCfgNil(medalCfg, "cfg_item_medal_group", medalId)
    return medalCfg
  end
end

function UISeasonCfgHelper.CfgSeason_QuestItemPos(index)
  local seasonId = GameGlobal.GetModule(SeasonModule):GetCurSeasonID()
  local cfgs = Cfg.cfg_season_quest_item_pos({SeasonID = seasonId})
  if cfgs then
    table.sort(cfgs, function(a, b)
      return a.ID < b.ID
    end)
    local idx = (index - 1) % #cfgs + 1
    local cfg = cfgs[idx]
    return cfg
  end
end

function UISeasonCfgHelper.CfgSeason_QuestItemClient(id)
  local cfg = Cfg.cfg_season_quest_item_client[id]
  UISeasonCfgHelper.CheckCfgNil(cfg, "cfg_season_quest_item_client", id)
  return cfg
end

function UISeasonCfgHelper.CheckCfgNil(cfg, cfgName, id)
  if not cfg then
    local strId = string.format("UISeasonCfgHelper %s[%s] = nil", cfgName, id)
    local str = id and strId or string.format("UISeasonCfgHelper %s = nil", cfgName)
    Log.exception(str, debug.traceback())
    return
  end
end
