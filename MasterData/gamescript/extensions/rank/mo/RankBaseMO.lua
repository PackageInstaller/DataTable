local RankBaseMO = NewClass("RankBaseMO")

function RankBaseMO:ctor()
  self.rank = 0
  self.rewardRankIndex = 0
  self.timestamp = 0
  self.type = ""
  self.name = ""
  self.icon = 0
  self.uid = ""
  self.score = 0
  self.level = 0
  self.subRankTid = 0
  self.gender = 0
  self.avatarFrame = 0
  self.state = ""
  self.note = ""
  self.todayGood = false
  self.relation = 0
  self.exp = 0
  self.seasonSchemaTag = "unknown"
  self.rawExt = {}
  self.score2 = 0
  self.railWayTeam = nil
  self.dailyChallengeTeam = nil
  self.school2MaxScoreTeam = nil
  self.seasonTid = 0
  self.gameplayType = 0
  self.playersNum = 0
  self.rawSvrData = {}
  self:InitRawFieldCompatMeta()
end

function RankBaseMO:InitRawFieldCompatMeta()
  local oldMeta = getmetatable(self)
  if oldMeta and oldMeta.__rankRawCompat then
    return
  end
  local newMeta = {}
  if oldMeta then
    for key, value in pairs(oldMeta) do
      newMeta[key] = value
    end
  end
  local oldIndex = oldMeta and oldMeta.__index
  
  function newMeta.__index(tbl, key)
    local value
    if type(oldIndex) == "function" then
      value = oldIndex(tbl, key)
    elseif type(oldIndex) == "table" then
      value = oldIndex[key]
    end
    if nil ~= value then
      return value
    end
    local rawSvrData = rawget(tbl, "rawSvrData")
    if rawSvrData then
      return rawSvrData[key]
    end
  end
  
  newMeta.__rankRawCompat = true
  setmetatable(self, newMeta)
end

function RankBaseMO:UpdateData(data)
  if nil == data then
    return
  end
  self.rawSvrData = table.clone(data)
  self:SetRank(data.rank or data.rankIndex)
  self:SetRewardRankIndex(data.rewardRankIndex)
  self:SetTimestamp(data.timestamp)
  self:SetType(data.type)
  self:SetName(data.name)
  self:SetIcon(data.icon)
  self:SetUid(data.uid)
  self:SetScore(data.score)
  self:SetLevel(data.level)
  self:SetSubRankTid(data.subRankTid)
  self:SetGender(data.gender)
  self:SetAvatarFrame(data.avatarFrame)
  self:SetState(data.state)
  self:SetNote(data.note)
  self:SetTodayGood(data.todayGood)
  self:SetRelation(data.relation)
  self:SetExp(data.exp)
  self:SetScore2(data.score2)
  self:SetRailWayTeam(data.railWayTeam)
  self:SetDailyChallengeTeam(data.dailyChallengeTeam)
  self:SetSchool2MaxScoreTeam(data.school2MaxScoreTeam)
  self:SetRawExt(data.rawExt)
  self:SetSeasonTid(data.seasonTid)
  self:SetGameplayType(data.gameplayType)
end

function RankBaseMO:UpdateDataWithSchema(data, schemaTag)
  if nil == data then
    return
  end
  self:SetSeasonSchemaTag(schemaTag or data.seasonSchemaTag or "unknown")
  self:UpdateData(data)
end

function RankBaseMO:SetRank(rank)
  if nil == rank then
    return
  end
  self.rank = rank
end

function RankBaseMO:SetRewardRankIndex(rewardRankIndex)
  if nil == rewardRankIndex then
    return
  end
  self.rewardRankIndex = rewardRankIndex
end

function RankBaseMO:SetTimestamp(timestamp)
  if nil == timestamp then
    return
  end
  self.timestamp = timestamp
end

function RankBaseMO:SetType(type)
  if nil == type then
    return
  end
  self.type = type
end

function RankBaseMO:SetName(name)
  if nil == name then
    return
  end
  self.name = name
end

function RankBaseMO:SetIcon(icon)
  if nil == icon then
    return
  end
  self.icon = icon
end

function RankBaseMO:SetUid(uid)
  if nil == uid then
    return
  end
  self.uid = uid
end

function RankBaseMO:SetScore(score)
  if nil == score then
    return
  end
  self.score = score
end

function RankBaseMO:SetLevel(level)
  if nil == level then
    return
  end
  self.level = level
end

function RankBaseMO:SetSubRankTid(subRankTid)
  if nil == subRankTid then
    return
  end
  self.subRankTid = subRankTid
end

function RankBaseMO:SetGender(gender)
  if nil == gender then
    return
  end
  self.gender = gender
end

function RankBaseMO:SetAvatarFrame(avatarFrame)
  if nil == avatarFrame then
    return
  end
  self.avatarFrame = avatarFrame
end

function RankBaseMO:SetState(state)
  if nil == state then
    return
  end
  self.state = state
end

function RankBaseMO:SetNote(note)
  if nil == note then
    return
  end
  self.note = note
end

function RankBaseMO:SetRelation(relation)
  if nil == relation then
    return
  end
  self.relation = relation
end

function RankBaseMO:SetExp(exp)
  if nil == exp then
    return
  end
  self.exp = exp
end

function RankBaseMO:SetTodayGood(todayGood)
  if nil == todayGood then
    return
  end
  self.todayGood = todayGood
end

function RankBaseMO:SetSeasonSchemaTag(schemaTag)
  if nil == schemaTag or "" == schemaTag then
    return
  end
  self.seasonSchemaTag = schemaTag
end

function RankBaseMO:SetRawExt(rawExt)
  if nil == rawExt then
    return
  end
  self.rawExt = rawExt
end

function RankBaseMO:SetScore2(score2)
  if nil == score2 then
    return
  end
  self.score2 = score2
end

function RankBaseMO:SetRailWayTeam(railWayTeam)
  if nil == railWayTeam then
    return
  end
  self.railWayTeam = railWayTeam
end

function RankBaseMO:SetDailyChallengeTeam(dailyChallengeTeam)
  if nil == dailyChallengeTeam then
    return
  end
  self.dailyChallengeTeam = dailyChallengeTeam
end

function RankBaseMO:SetSchool2MaxScoreTeam(school2MaxScoreTeam)
  if nil == school2MaxScoreTeam then
    return
  end
  self.school2MaxScoreTeam = school2MaxScoreTeam
end

function RankBaseMO:GetRank()
  return self.rank
end

function RankBaseMO:GetRewardRankIndex()
  return self.rewardRankIndex
end

function RankBaseMO:GetTimestamp()
  return self.timestamp
end

function RankBaseMO:GetType()
  return self.type
end

function RankBaseMO:GetName()
  return self.name
end

function RankBaseMO:GetIcon()
  return self.icon
end

function RankBaseMO:GetUid()
  return self.uid
end

function RankBaseMO:GetScore()
  return self.score
end

function RankBaseMO:GetLevel()
  return self.level
end

function RankBaseMO:GetSubRankTid()
  return self.subRankTid
end

function RankBaseMO:GetGender()
  return self.gender
end

function RankBaseMO:GetAvatarFrame()
  return self.avatarFrame
end

function RankBaseMO:GetState()
  return self.state
end

function RankBaseMO:GetNote()
  return self.note
end

function RankBaseMO:GetTodayGood()
  return self.todayGood
end

function RankBaseMO:GetRelation()
  return self.relation
end

function RankBaseMO:GetExp()
  return self.exp
end

function RankBaseMO:GetSeasonSchemaTag()
  return self.seasonSchemaTag
end

function RankBaseMO:GetRawExt()
  return self.rawExt or {}
end

function RankBaseMO:GetStageTid()
  local team = self.railWayTeam
  if team and team.stageTid then
    return team.stageTid
  end
  return 0
end

function RankBaseMO:GetScore2()
  return self.score2
end

function RankBaseMO:GetRailWayTeam()
  return self.railWayTeam
end

function RankBaseMO:GetDailyChallengeTeam()
  return self.dailyChallengeTeam
end

function RankBaseMO:GetSchool2MaxScoreTeam()
  return self.school2MaxScoreTeam
end

function RankBaseMO:SetSeasonTid(seasonTid)
  if nil == seasonTid then
    return
  end
  self.seasonTid = seasonTid
end

function RankBaseMO:GetSeasonTid()
  return self.seasonTid
end

function RankBaseMO:SetGameplayType(gameplayType)
  self.gameplayType = gameplayType
end

function RankBaseMO:GetGameplayType()
  return self.gameplayType
end

function RankBaseMO:GetPlayersNum()
  local rankType = self.type
  local seasonTid = self.seasonTid
  return RankModel.Instance:GetRankLengthData(rankType, seasonTid) or 0
end

function RankBaseMO:GetTitleAndIcon()
  local rewardRankIndex = self.rewardRankIndex
  if not rewardRankIndex or rewardRankIndex <= 0 then
    return nil, nil
  end
  local seasonTid = self.seasonTid
  if not seasonTid or 0 == seasonTid then
    return nil, nil
  end
  local gameplayType = self.gameplayType
  if not gameplayType or 0 == gameplayType then
    return nil, nil
  end
  local playersNum = self:GetPlayersNum()
  local row = SeasonRotationModel.Instance:GetSeasonRankRewardRowByRewardIndex(seasonTid, gameplayType, rewardRankIndex, playersNum)
  if row then
    return row.Name, row.RankIcon
  end
  return nil, nil
end

return RankBaseMO
