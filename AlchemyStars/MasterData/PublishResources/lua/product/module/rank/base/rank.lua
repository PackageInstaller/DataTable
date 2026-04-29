_class("Rank", Object)
Rank = Rank

function Rank:RankType()
  return RANK_TYPE.RANK_TYPE_INVALID
end

function Rank:CreateRankData()
  return nil
end

function Rank:GetConfig()
  return Cfg.cfg_rank[self:RankType()]
end

function Rank:CacheTime()
  local config = self:GetConfig()
  local CACHE_TIME = 5
  if not config then
    return CACHE_TIME
  end
  if not config.ClientCacheTime then
    return CACHE_TIME
  end
  return config.ClientCacheTime
end
