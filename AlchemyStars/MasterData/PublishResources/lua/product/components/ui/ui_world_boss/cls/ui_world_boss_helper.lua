local UIWroldBossBadgeStype = {WBBS_NORMAL = 1, WBBS_SIMPLE = 2}
_enum("UIWroldBossBadgeStype", UIWroldBossBadgeStype)
_class("UIWorldBossHelper", Object)
UIWorldBossHelper = UIWorldBossHelper

function UIWorldBossHelper:Constructor()
end

function UIWorldBossHelper.GetCurDanCfg(curDan, curRankLevel)
  if UIWorldBossHelper.IsNoDan(curDan, curRankLevel) then
    return nil
  end
  local cfg = Cfg.cfg_world_boss_dan[curDan]
  return cfg
end

function UIWorldBossHelper.GetUiLegendDanCfg(missionId)
  local curRankLevel = 1
  local curCfg
  local cfg = Cfg.cfg_world_boss_dan({MissionID = missionId})
  if 0 < #cfg then
    local minLevel = 0
    for index, value in ipairs(cfg) do
      if 0 < value.RankLevel and curRankLevel <= value.RankLevel and (minLevel == 0 or minLevel > value.RankLevel) then
        minLevel = value.RankLevel
        curCfg = value
      end
    end
  end
  return curCfg
end

function UIWorldBossHelper.GetUiMinDanId(missionId)
  local curRankLevel = 1
  local danId = 1
  local cfg = Cfg.cfg_world_boss_dan({MissionID = missionId})
  if 0 < #cfg then
    danId = cfg[1].ID
  end
  return danId
end

function UIWorldBossHelper.GetDanBadgeBase(curDan, curRankLevel)
  if UIWorldBossHelper.IsNoDan(curDan, curRankLevel) then
    return "1601191_logo"
  end
  local rankLevel = curRankLevel
  local cfg = UIWorldBossHelper.GetCurDanCfg(curDan, rankLevel)
  if cfg then
    return cfg.DanBadgeBase
  end
end

function UIWorldBossHelper.GetWorldBossLegendDanGroup(idMission)
  local roleModule = GameGlobal.GetModule(RoleModule)
  local idZone = roleModule:GetZoneIdType()
  local zoneTableName = "cfg_world_boss_legend_dan_" .. idZone
  local cfg
  if ResourceManager:GetInstance():HasLua(zoneTableName) then
    cfg = Cfg[zoneTableName]
  else
    cfg = Cfg.cfg_world_boss_legend_dan
  end
  local cfgGroup = cfg({MissionID = idMission})
  return cfgGroup
end

function UIWorldBossHelper.GetDanBadgeBaseSimple(curDan, curRankLevel)
  if UIWorldBossHelper.IsNoDan(curDan, curRankLevel) then
    return "1601191_logo"
  end
  local rankLevel = curRankLevel
  local cfg = UIWorldBossHelper.GetCurDanCfg(curDan, rankLevel)
  if cfg then
    local cfgGroup
    if 0 < rankLevel then
      cfgGroup = UIWorldBossHelper.GetWorldBossLegendDanGroup(cfg.MissionID)
    end
    if cfgGroup ~= nil then
      local cfgPool = {}
      for k, v in pairs(cfgGroup) do
        table.insert(cfgPool, v)
      end
      table.sort(cfgPool, function(a, b)
        return a.ID < b.ID
      end)
      for k, v in pairs(cfgPool) do
        if rankLevel <= v.RankingLevel then
          return v.SimpleDanBadgeBase
        end
      end
    end
    return cfg.SimpleDanBadgeBase
  end
end

function UIWorldBossHelper.IsPlusDan(curDan, curRankLevel)
  if UIWorldBossHelper.IsNoDan(curDan, curRankLevel) then
    return false
  end
  local rankLevel = curRankLevel
  local cfg = UIWorldBossHelper.GetCurDanCfg(curDan, rankLevel)
  if cfg then
    if cfg.IsPlusDan and cfg.IsPlusDan == 1 then
      return true
    else
      return false
    end
  end
  return false
end

function UIWorldBossHelper.GetDanName(curDan, curRankLevel)
  if UIWorldBossHelper.IsNoDan(curDan, curRankLevel) then
    return "str_world_boss_dan_detail_no_dan"
  end
  local rankLevel = curRankLevel
  local cfg = UIWorldBossHelper.GetCurDanCfg(curDan, rankLevel)
  if cfg then
    return cfg.DanName
  end
end

function UIWorldBossHelper.GetDanNeedDamage(curDan, curRankLevel)
  if UIWorldBossHelper.IsNoDan(curDan, curRankLevel) then
    return 0
  end
  local rankLevel = 0
  if curRankLevel then
    rankLevel = curRankLevel
  end
  if 0 < rankLevel then
    return nil
  end
  local cfg = UIWorldBossHelper.GetCurDanCfg(curDan, rankLevel)
  if cfg then
    return cfg.NeedDamage
  else
    return nil
  end
end

function UIWorldBossHelper.IsNormalTopDan(curDan, curRankLevel)
  if UIWorldBossHelper.IsNoDan(curDan, curRankLevel) then
    return false
  end
  local rankLevel = 0
  if curRankLevel then
    rankLevel = curRankLevel
  end
  if 0 < rankLevel then
    return false
  end
  local nextDan = curDan + 1
  local nextCfg = UIWorldBossHelper.GetCurDanCfg(nextDan, rankLevel)
  if nextCfg then
    return 0 < nextCfg.RankLevel
  else
    return false
  end
end

function UIWorldBossHelper.IsNoDan(curDan, curRankLevel)
  if curDan == 0 and curRankLevel == 0 then
    return true
  else
    return false
  end
end

function UIWorldBossHelper.SortDanDetailUIData(list)
  if list then
    table.sort(list, function(a, b)
      return a._danId > b._danId
    end)
  end
end

function UIWorldBossHelper.InitSelfDanBadgeSimple(badgeGen, badgeGo, badgeRect)
  local head_dan_badge
  if badgeGen and badgeGo then
    local roleModule = GameGlobal.GetModule(RoleModule)
    local bShowBadge = roleModule:GetBadgeSwitch()
    if bShowBadge then
      local lastDan = roleModule:GetWorldBossRecordDan()
      local lastRank = roleModule:GetWorldBossRecordRank()
      if UIWorldBossHelper.IsNoDan(lastDan, lastRank) then
        badgeGo:SetActive(false)
      else
        head_dan_badge = badgeGen:SpawnObject("UIWorldBossDanBadge")
        local badgeType = UIWroldBossBadgeStype.WBBS_SIMPLE
        head_dan_badge:SetData(badgeType, lastDan, lastRank, badgeRect.sizeDelta.x, badgeRect.sizeDelta.y)
        badgeGo:SetActive(true)
      end
    else
      badgeGo:SetActive(false)
    end
  end
  return head_dan_badge
end

function UIWorldBossHelper.InitOtherDanBadgeSimple(badgeGen, badgeGo, badgeRect, roleWorldBossInfo)
  local head_dan_badge
  if badgeGen and badgeGo and badgeRect and roleWorldBossInfo then
    local bShowBadge = roleWorldBossInfo.dan_head_switch
    if bShowBadge then
      local lastDan = roleWorldBossInfo.dan
      local lastRank = roleWorldBossInfo.grading
      if UIWorldBossHelper.IsNoDan(lastDan, lastRank) then
        badgeGo:SetActive(false)
      else
        head_dan_badge = badgeGen:SpawnObject("UIWorldBossDanBadge")
        local badgeType = UIWroldBossBadgeStype.WBBS_SIMPLE
        head_dan_badge:SetData(badgeType, lastDan, lastRank, badgeRect.sizeDelta.x, badgeRect.sizeDelta.y)
        badgeGo:SetActive(true)
      end
    else
      badgeGo:SetActive(false)
    end
  end
  return head_dan_badge
end

function UIWorldBossHelper.InitDanBadge(badgeGen, badgeGo, badgeRect, dan, rank)
  local head_dan_badge
  if badgeGen and badgeGo and badgeRect and dan and rank then
    local bShowBadge = 0 < dan
    if bShowBadge then
      if UIWorldBossHelper.IsNoDan(dan, rank) then
        badgeGo:SetActive(false)
      else
        head_dan_badge = badgeGen:SpawnObject("UIWorldBossDanBadge")
        local badgeType = UIWroldBossBadgeStype.WBBS_NORMAL
        head_dan_badge:SetData(badgeType, dan, rank, badgeRect.sizeDelta.x, badgeRect.sizeDelta.y)
        badgeGo:SetActive(true)
      end
    else
      badgeGo:SetActive(false)
    end
  end
  return head_dan_badge
end

function UIWorldBossHelper.GetCurDanLevel(danId)
  local danLevel = 0
  local cfg = Cfg.cfg_world_boss_dan[danId]
  if cfg then
    danLevel = cfg.DanLevel
  end
  return danLevel
end

function UIWorldBossHelper.CheckCurRank(rankList, score)
  local function bEqual(a, b)
    return a == b
  end
  
  local function checkFun(a, b)
    return b <= a
  end
  
  if rankList and score then
    local nRank = #rankList
    if nRank == 0 then
      return 1
    end
    if nRank == 1 and checkFun(score, rankList[1]) then
      return 1
    end
    if checkFun(score, rankList[1]) then
      return 1
    end
    if not checkFun(score, rankList[nRank]) then
      return nRank + 1
    end
    if bEqual(score, rankList[nRank]) then
      return nRank
    end
    local top = 1
    local bottom = nRank
    local mid = math.floor((bottom + top) / 2)
    local nList = bottom - top + 1
    local safeFlag = 999
    while 2 < nList do
      if checkFun(score, rankList[mid]) then
        bottom = mid
      else
        top = mid
      end
      mid = math.floor((bottom + top) / 2)
      nList = bottom - top + 1
      safeFlag = safeFlag - 1
      if safeFlag < 0 then
        break
      end
    end
    if checkFun(score, rankList[top]) then
      return top
    elseif not checkFun(score, rankList[bottom]) then
      return bottom + 1
    else
      return bottom
    end
  end
  return -1
end

function UIActivityHelper.CalClientDan(rankList, curDan, curRank, curPromoteDamage, damage, missionId)
  local newDan = curDan
  local newRank = curRank
  local promoteDamage = curPromoteDamage
  if rankList then
    local nRankList = #rankList
    if 0 < curRank or UIWorldBossHelper.IsNormalTopDan(curDan, curRank) then
      local legendCfg = UIWorldBossHelper.GetUiLegendDanCfg(missionId)
      if legendCfg then
        local maxRank = legendCfg.RankLevel
        local calRank = UIWorldBossHelper.CheckCurRank(rankList, damage)
        if 1 <= calRank and maxRank >= calRank then
          newRank = calRank
          newDan = legendCfg.ID
          if newRank ~= 1 then
            local preRank = newRank - 1
            if 1 <= preRank and nRankList >= preRank then
              promoteDamage = rankList[preRank]
            end
          end
        else
          newRank = 0
          newDan = legendCfg.ID - 1
          if 0 < nRankList then
            promoteDamage = rankList[nRankList]
          end
        end
      end
    end
  end
  return newDan, newRank, promoteDamage
end
