local this = {}

function this:reqSaveRouletteInfo(type, callback)
  local guidList = {}
  local dataList = self:getDataList(type)
  for i = 1, L_QuickRouletteStore.maxCount do
    local data = dataList[i]
    table.insert(guidList, data and data.guid or 0)
  end
  local pos
  if self.data.selectIndex and 0 < self.data.selectIndex then
    pos = self.data.selectIndex
  end
  L_Net:sendMessage(MsgGenCode.CSProtoSetRouletteItem, {
    type = type,
    guid = guidList,
    pos = pos
  }, function(data, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:updateRouletteInfo(rouletteInfos)
  for _, rouletteInfo in pairs(rouletteInfos or table.empty) do
    for index, guid in pairs(rouletteInfo.guid or table.empty) do
      self:setRouletteData(index, guid, rouletteInfo.type)
    end
    if rouletteInfo.pos and rouletteInfo.pos > 0 then
      self.data.selectIndex = rouletteInfo.pos
      self.data.selectType = rouletteInfo.type
    end
  end
end

function this:refreshRouletteInfo(rouletteInfos)
  if not rouletteInfos then
    return
  end
  for _, rouletteInfo in ipairs(rouletteInfos) do
    if rouletteInfo.type == L_Const.quickRouletteType.petPuzzle then
      local guidList = {}
      if not table.isEmpty(rouletteInfo.guid) then
        for _, guid in ipairs(rouletteInfo.guid) do
          table.insert(guidList, guid)
        end
      else
        for i = 1, 9 do
          table.insert(guidList, 0)
        end
      end
      self:setRouletteInfoByType(rouletteInfo.type, guidList)
      self:call(self.event.refreshPetPuzzleRouletteInfo)
    end
  end
end

function this:req_SaveRouletteInfo(type, guidList, pos, callback)
  pos = pos or 0
  L_Net:sendMessage(MsgGenCode.CSProtoSetRouletteItem, {
    type = type,
    guid = guidList,
    pos = pos
  }, function(data, errorCode)
    if errorCode ~= L_Const.errorCode.ErrCodeSucc then
      return
    end
    if callback then
      callback()
    end
  end)
end

return this
