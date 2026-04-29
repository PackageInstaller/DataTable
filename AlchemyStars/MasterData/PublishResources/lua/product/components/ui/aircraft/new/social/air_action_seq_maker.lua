_class("AirActionSeqMaker", Object)
AirActionSeqMaker = AirActionSeqMaker

function AirActionSeqMaker:Constructor(count, furnitureType)
  local cfgs = Cfg.cfg_aircraft_action_sequence({seqType = furnitureType})
  if cfgs then
    for key, cfg in pairs(cfgs) do
      if cfg.peopleCount == count then
        self.m_Cfg = cfg
        break
      end
    end
  end
  if self.m_Cfg then
    self:InitBeginSeq()
    self:InitLoopSeq()
    self:InitFinishSeq()
  end
end

function AirActionSeqMaker:InitBeginSeq()
  self.m_BeginSeq = self.m_Cfg.beginSequence
end

function AirActionSeqMaker:HasBegin()
  return self.m_BeginSeq ~= nil
end

function AirActionSeqMaker:GetBeginSeq()
  return {
    self.m_BeginSeq[1],
    tonumber(self.m_BeginSeq[2])
  }
end

function AirActionSeqMaker:InitLoopSeq()
  self.m_LoopSeq = {}
  if self.m_Cfg.loopCount and self.m_Cfg.loopCount > 0 then
    local round = 0
    for index, str in ipairs(self.m_Cfg.loopSequence) do
      round = round + 1
      if not self.m_LoopSeq[round] then
        self.m_LoopSeq[round] = {}
      end
      local b = string.split(str, ";")
      if b and table.count(b) >= 2 then
        for i = 1, self.m_Cfg.peopleCount do
          local c = string.split(b[i], ",")
          self.m_LoopSeq[round][i] = {
            c[1],
            tonumber(c[2])
          }
        end
      else
        local c = string.split(str, ",")
        self.m_LoopSeq[round][1] = {
          c[1],
          tonumber(c[2])
        }
      end
    end
  end
end

function AirActionSeqMaker:GetLoopCount()
  return self.m_Cfg.loopCount
end

function AirActionSeqMaker:GetTotalLoopTime(index)
  return self:GetLoopTime(self:GetLoopCount(), index)
end

function AirActionSeqMaker:GetLoopTime(round, index)
  local time = 0
  if round and 0 < round then
    for i = 1, round do
      for j = 1, self:GetOnceLoopCount() do
        time = time + self.m_LoopSeq[j][index][2]
      end
    end
  end
  return time
end

function AirActionSeqMaker:GetRemainTime(round, index)
  return self:GetTotalLoopTime(index) - self:GetLoopTime(round, index) + self:GetFinishTime(index)
end

function AirActionSeqMaker:HasLoop()
  return self:GetLoopCount() > 0
end

function AirActionSeqMaker:GetLoopSeq(round, index)
  return self.m_LoopSeq[round][index]
end

function AirActionSeqMaker:GetOnceLoopCount()
  return table.count(self.m_LoopSeq)
end

function AirActionSeqMaker:InitFinishSeq()
  self.m_FinishSeq = {}
  if self.m_Cfg.finishSequence then
    for index, value in ipairs(self.m_Cfg.finishSequence) do
      local d = string.split(value, ",")
      table.insert(self.m_FinishSeq, {
        d[1],
        tonumber(d[2])
      })
    end
  end
end

function AirActionSeqMaker:GetFinishSeq(index)
  return self.m_FinishSeq[index]
end

function AirActionSeqMaker:GetFinishTime(index)
  local time = 0
  if time and self.m_FinishSeq and self.m_FinishSeq[index] then
    time = self.m_FinishSeq[index][2]
  end
  return time
end

function AirActionSeqMaker:HasFinish()
  return table.count(self.m_FinishSeq)
end

function AirActionSeqMaker:Dispose()
  self.m_BeginSeq = nil
  self.m_LoopSeq = {}
  self.m_FinishSeq = {}
end
