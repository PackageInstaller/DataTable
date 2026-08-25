local CopyRecordsModel, Super = NewClass("CopyRecordsModel", BaseModel)

function CopyRecordsModel:OnInit()
  self:OnReset()
end

function CopyRecordsModel:OnReset()
  self.stageRecordDataMap = {}
  self.myRecordsMap = {}
  self.myRecordsTotalPage = 0
  self.otherRecordUid = 0
  self.otherRecordPage = 0
  self.otherRecordWidList = {}
  self.otherRecordDataList = {}
  self.recordFacadeMap = {}
end

function CopyRecordsModel:SetMyRecords(recordData)
  self.myRecordsMap[recordData.page] = recordData.list
  self.myRecordsTotalPage = recordData.totalPage
  for uid, facadeData in pairs(recordData.facades or {}) do
    self.recordFacadeMap[uid] = facadeData
  end
  EventMgr.Instance.MyCopyRecordUpdate:Dispatch()
end

function CopyRecordsModel:GetMyRecords()
  local records = {}
  for page, pageRecords in ipairs(self.myRecordsMap) do
    for _, record in ipairs(pageRecords) do
      table.insert(records, record)
    end
  end
  return records
end

function CopyRecordsModel:ClearMyRecords()
  self.myRecordsMap = {}
  self.myRecordsTotalPage = 0
end

function CopyRecordsModel:ReqOtherNextPageRecords()
  if self.isReqing then
    return
  end
  if #self.otherRecordDataList >= #self.otherRecordWidList then
    return
  end
  local startIdx = self.otherRecordPage * 10 + 1
  if startIdx > #self.otherRecordWidList then
    return
  end
  local endIdx = startIdx + 9
  local targetWidList = {}
  for i = startIdx, endIdx do
    table.insert(targetWidList, self.otherRecordWidList[i])
  end
  self.isReqing = true
  CopyRecordsController.Instance:ReqQueryOthersRecentReview(self.otherRecordUid, targetWidList, function(data)
    for _, recordData in ipairs(data) do
      table.insert(self.otherRecordDataList, recordData)
    end
    self.isReqing = false
    self.otherRecordPage = self.otherRecordPage + 1
    if #self.otherRecordDataList < 5 or #data <= 0 then
      self:ReqOtherNextPageRecords()
    end
  end, function()
    self.isReqing = false
  end)
end

function CopyRecordsModel:ReqMyNextPageRecords()
  for page = 1, self.myRecordsTotalPage do
    if not self.myRecordsMap[page] then
      CopyRecordsController.Instance:ReqQueryMyRecord(page)
      return
    end
  end
end

function CopyRecordsModel:SetOtherRecordUid(uid)
  self.otherRecordUid = uid
end

function CopyRecordsModel:GetOtherRecordUid()
  return self.otherRecordUid
end

function CopyRecordsModel:SetOtherRecordDataList(list)
  self.otherRecordDataList = list
end

function CopyRecordsModel:SetOtherRecordWidList(list)
  self.otherRecordWidList = list
end

function CopyRecordsModel:GetOtherRecordWidList()
  return self.otherRecordWidList
end

function CopyRecordsModel:GetOtherRecords()
  return self.otherRecordDataList
end

function CopyRecordsModel:ClearOtherRecords()
  self.otherRecordDataList = {}
  self.otherRecordPage = 0
end

function CopyRecordsModel:SetStagePageRecords(stageId, page, sortType, recordData)
  local stageRecord = self.stageRecordDataMap[stageId]
  if not stageRecord then
    stageRecord = {}
    self.stageRecordDataMap[stageId] = stageRecord
  end
  local sortTypeRecords = stageRecord[sortType]
  if not sortTypeRecords then
    sortTypeRecords = {
      pageRecords = {},
      totalPage = 0,
      page = 0,
      total = 0
    }
    stageRecord[sortType] = sortTypeRecords
  end
  self:_InsertPageRecords(sortTypeRecords.pageRecords, page, recordData.list)
  sortTypeRecords.totalPage = recordData.totalPage
  sortTypeRecords.page = math.max(sortTypeRecords.page, recordData.page)
  sortTypeRecords.total = recordData.total
  for uid, facadeData in pairs(recordData.facades or {}) do
    self.recordFacadeMap[uid] = facadeData
  end
  EventMgr.Instance.CopyRecordUpdate:Dispatch()
end

function CopyRecordsModel:_InsertPageRecords(pageRecords, page, list)
  local newWidMap = {}
  for _, data in ipairs(list) do
    newWidMap[data.wid] = true
  end
  for _, pageList in pairs(pageRecords) do
    for i = #pageList, 1, -1 do
      if newWidMap[pageList[i].wid] then
        table.remove(pageList, i)
      end
    end
  end
  pageRecords[page] = list
end

function CopyRecordsModel:ClearStageRecords(stageId)
  self.stageRecordDataMap[stageId] = nil
end

function CopyRecordsModel:GetStageRecords(stageId, sortType)
  local records = self.stageRecordDataMap[stageId] or {}
  local sortTypeRecordData = records[sortType] or {}
  local pageList = sortTypeRecordData.pageRecords or {}
  local ret = {}
  for _, list in ipairs(pageList) do
    table.append(ret, list)
  end
  return ret
end

function CopyRecordsModel:ReqNextPageRecords(stageId, sortType)
  local records = self.stageRecordDataMap[stageId] or {}
  local sortTypeRecordData = records[sortType]
  if not sortTypeRecordData then
    return
  end
  if sortTypeRecordData.page < sortTypeRecordData.totalPage then
    CopyRecordsController.Instance:ReqQueryStageRecord(stageId, sortTypeRecordData.page + 1, sortType)
  end
end

function CopyRecordsModel:GetRecordFacade(uid)
  return self.recordFacadeMap[uid]
end

return CopyRecordsModel
