_class("RankRole", Rank)
RankRole = RankRole

function RankRole:Constructor()
  self.m_rank_data = {}
  self.m_rank_player = {}
end

function RankRole:GetTotalData()
  return self.m_rank_data
end

function RankRole:UnSeriaData(buff)
  local data = self:CreateRankData()
  if not data then
    Log.fatal("RankDataType is nil")
    return nil
  end
  local ret, msg = lua_dc.LoadStream(data._className, buff, data)
  if not ret then
    Log.fatal("lua_dc.LoadStream fail, class = ", data._classname, ", msg = ", msg)
    return nil
  end
  return data
end

function RankRole:UnSeriaBufVec(buf_vec)
  local data_vec = {}
  if 0 == #buf_vec then
    return data_vec
  end
  for k, buf in pairs(buf_vec) do
    local data = self:UnSeriaData(buf)
    if not data then
      Log.fatal("FillDataTotal fail, aUnSeriaData errr")
      return nil
    end
    table.insert(data_vec, k, data)
  end
  return data_vec
end

function RankRole:GetDataByPage(index, count)
  if index < 0 or count <= 0 then
    Log.fatal("GetDataByPage fail, index = ", index, ", count = ", count)
    return nil
  end
  if #self.m_rank_data == 0 then
    return {}
  end
  local begin = index + 1
  local over = index + count
  local data_ret = {}
  for _, v in pairs(self.m_rank_data) do
    local rank_base = v.rank_base
    local player = self:GetPlayer(rank_base.pstid)
    if not player then
      Log.fatal("not player pstid = ", rank_base.pstid)
    elseif begin <= player.rank and over >= player.rank then
      table.insert(data_ret, v)
    end
  end
  return data_ret
end

function RankRole:FillDataTotal(buf_vec)
  if not buf_vec then
    Log.fatal("FillDataTotal fail, arg data_vec is nil")
    return nil
  end
  local data_vec = self:UnSeriaBufVec(buf_vec)
  if not data_vec then
    return nil
  end
  self.m_rank_data = data_vec
  self.m_rank_player = {}
  for i, v in pairs(self.m_rank_data) do
    local rank_base = v.rank_base
    self.m_rank_player[rank_base.pstid] = v
    self.m_rank_player[rank_base.pstid].rank = i
  end
  Log.debug("rank fill total = ", #self.m_rank_data)
  return true
end

function RankRole:FillDataByPage(index, count, buf_vec)
  if index < 0 or count <= 0 then
    Log.fatal("FillDataByPage fail, index = ", index, ", count = ", count)
    return nil
  end
  local data_vec = self:UnSeriaBufVec(buf_vec)
  if not data_vec then
    return nil
  end
  local data_num = #data_vec
  local begin = index + 1
  local over = index + count
  local clean_end = over
  for i = clean_end, begin, -1 do
    if self.m_rank_data[i] then
      local data = self.m_rank_data[i]
      self.m_rank_player[data.rank_base.pstid] = nil
      self.m_rank_data[i] = nil
    end
  end
  local index = begin
  for i = 1, data_num do
    self.m_rank_data[index] = data_vec[i]
    local data = self.m_rank_data[index]
    self.m_rank_player[data.rank_base.pstid] = data
    self.m_rank_player[data.rank_base.pstid].rank = index
    index = begin + i
  end
  return true
end

function RankRole:GetPlayer(pstid)
  if not self.m_rank_player[pstid] then
    return nil
  end
  return self.m_rank_player[pstid]
end
