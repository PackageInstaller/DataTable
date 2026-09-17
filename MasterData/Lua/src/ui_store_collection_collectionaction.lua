local this = {}

function this:req_CSProtoCollectBuildCreate(guid, sourceBuild, callback)
  local data = {
    collect_id = guid,
    source_build = sourceBuild or 0
  }
  L_Net:sendMessage(MsgGenCode.CSProtoCollectBuildCreate, data, function(rspData, errorCode)
    if callback then
      callback(errorCode)
    end
  end)
end

function this:req_CSProtoCollectGetReward(guidList, sourceBuild, callback)
  local data = {
    guid = guidList,
    source_build = sourceBuild or 0
  }
  L_Net:sendMessage(MsgGenCode.CSProtoCollectGetReward, data, function(rspData, errorCode)
    if callback then
      callback(rspData, errorCode)
    end
  end)
end

function this:rsp_syncCollect(data)
  local updateList = {}
  for _, v in ipairs(data) do
    if v.build_type == L_Const.WorldMapBuildType.WMBT_WILD_COLLECT then
      local collection = v.collect_build_data
      if self.data.collectionMap[collection.guid] ~= nil then
        updateList[collection.guid] = collection.guid
      end
      self.data.collectionMap[collection.guid] = collection
    end
  end
  if not table.isEmpty(updateList) then
    self:call(self.event.refreshCollection)
    self:call(self.event.updateCollection, updateList)
    self:call(self.event.refreshModuleHomeCenterBuildingManageReceiveAllDot)
  end
end

return this
