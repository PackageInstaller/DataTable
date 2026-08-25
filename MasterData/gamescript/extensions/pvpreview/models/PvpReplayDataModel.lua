local PvpReplayDataModel = NewClass("PvpReplayDataModel", BaseModel)

function PvpReplayDataModel:OnInit()
  self.playerRecordData = {}
  self.enermyRecordData = {}
  self.recordId = 0
end

function PvpReplayDataModel:OnReset()
  self:OnInit()
end

function PvpReplayDataModel:UpdateData(tbl)
  self:Set_recordId(tbl.recordId or 0)
  for uid, recordStatsData in pairs(tbl.statsData or {}) do
    if uid == PlayerDataUtils.GetPlayerUid() then
      self:Set_playerRecordData(recordStatsData)
    else
      self:Set_enermyRecordData(recordStatsData)
    end
  end
end

function PvpReplayDataModel:Set_recordId(num)
  self.recordId = num
end

function PvpReplayDataModel:Get_recordId()
  return self.recordId
end

function PvpReplayDataModel:Set_playerRecordData(tbl)
  self.playerRecordData = tbl
end

function PvpReplayDataModel:Get_playerRecordData()
  return self.playerRecordData
end

function PvpReplayDataModel:Set_enermyRecordData(tbl)
  self.enermyRecordData = tbl
end

function PvpReplayDataModel:Get_enermyRecordData()
  return self.enermyRecordData
end

return PvpReplayDataModel
