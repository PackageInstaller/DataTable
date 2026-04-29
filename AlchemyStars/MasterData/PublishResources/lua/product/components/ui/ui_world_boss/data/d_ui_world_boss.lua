_class("DUIWorldBossDanDetailCell", Object)
DUIWorldBossDanDetailCell = DUIWorldBossDanDetailCell

function DUIWorldBossDanDetailCell:Constructor(cfg, danInfo)
  self._danCfg = cfg
  self._danInfo = danInfo
  self._danId = -1
  if self._danCfg then
    self._danId = self._danCfg.ID
  end
end

function DUIWorldBossDanDetailCell:GetDanId()
  return self._danId
end

function DUIWorldBossDanDetailCell:GetDanRankLevel()
  if self._danCfg then
    return self._danCfg.RankLevel
  end
end

function DUIWorldBossDanDetailCell:GetDanCondition()
  if self._danCfg then
    if self._danCfg.RankLevel > 0 then
      local topDanName = UIWorldBossHelper.GetDanName(self._danId - 1, 0)
      local outStr = StringTable.Get("str_world_boss_dan_detail_lengend_condition", StringTable.Get(topDanName), self._danCfg.RankLevel)
      return outStr
    else
      local outStr = self:_FormatNeedDamageNumStr(self._danCfg.NeedDamage)
      return outStr
    end
  end
end

function DUIWorldBossDanDetailCell:_FormatNeedDamageNumStr(num)
  local preZero = UIActivityHelper.GetZeroStrFrontNum(7, num)
  local fmtStr = string.format("<color=#696969>%s</color><color=#e7d3ac>%s</color>", preZero, tostring(num))
  return fmtStr
end

function DUIWorldBossDanDetailCell:GetDanExtraInfo()
  if self._danCfg and self._danCfg.RankLevel > 0 and self._danInfo and 0 < self._danInfo.rank_first_damage then
    return StringTable.Get("str_world_boss_dan_detail_top_one_score", self._danInfo.rank_first_damage)
  end
end

function DUIWorldBossDanDetailCell:GetDanBadgeBase()
  if self._danCfg then
    return self._danCfg.DanBadgeBase
  end
end

function DUIWorldBossDanDetailCell:GetDanRewards()
  if self._danCfg then
    local rewardVec = self._danCfg.Rewards
    if rewardVec then
      local roleAssetList = {}
      for index, value in ipairs(rewardVec) do
        local asset = RoleAsset:New()
        asset.assetid = value[1]
        asset.count = value[2]
        table.insert(roleAssetList, asset)
      end
      return roleAssetList
    end
  end
end

function DUIWorldBossDanDetailCell:GetDanName()
  if self._danCfg then
    return self._danCfg.DanName
  end
end

function DUIWorldBossDanDetailCell:IsPlusDan()
  local bPlus = false
  if self._danCfg and self._danCfg.IsPlusDan and self._danCfg.IsPlusDan == 1 then
    bPlus = true
  end
  return bPlus
end

function DUIWorldBossDanDetailCell:IsPlayerCurDanData()
  local curDan = self._danInfo.cur_dan
  local curRank = self._danInfo.my_rank
  if UIWorldBossHelper.IsNoDan(curDan, curRank) then
    return false
  end
  if 0 < curRank and 0 < self._danCfg.RankLevel then
    return true
  end
  if curRank == 0 and self._danCfg.RankLevel == 0 then
    return curDan == self._danCfg.ID
  else
    return false
  end
end
