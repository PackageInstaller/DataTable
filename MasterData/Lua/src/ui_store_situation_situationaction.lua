local this = {}

function this:req_changeCover(situationId, coverName, callback)
  local solution = self:getSolutionInfo(situationId)
  local json = solution:export()
  local netData = {
    data = {
      id = situationId,
      name = solution.name,
      Cover = coverName or "",
      show_data = json
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoChangeSceneShowcase, netData, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if solution then
        solution.coverName = coverName
      end
      if callback then
        callback()
      end
    end
  end)
end

function this:req_changeName(situationId, name, callback)
  local solution = self:getSolutionInfo(situationId)
  local json = solution:export()
  local netData = {
    data = {
      id = situationId,
      name = name,
      Cover = solution.coverName or "",
      show_data = json
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoChangeSceneShowcase, netData, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if solution then
        solution.name = name
      end
      self:call(self.event.nameChanged, situationId)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_editSituation(situationId, callback)
  local solution = self:getSolutionInfo(situationId)
  local json = solution:export()
  local netData = {
    data = {
      id = situationId,
      name = solution.name,
      Cover = solution.coverName or "",
      show_data = json
    }
  }
  L_Net:sendMessage(MsgGenCode.CSProtoChangeSceneShowcase, netData, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:deserialize(json)
  local allData = {
    heroes = {},
    objs = {},
    pets = {},
    stamps = {},
    camera = nil,
    env = nil
  }
  local jsonData = L_Json.decode(json)
  for i, v in pairs(jsonData.heroes) do
    local heroData = L_Json.decode(v)
    table.insert(allData.heroes, heroData)
  end
  for i, v in pairs(jsonData.objs) do
    local objData = L_Json.decode(v)
    table.insert(allData.objs, objData)
  end
  for i, v in pairs(jsonData.pets) do
    local petData = L_Json.decode(v)
    table.insert(allData.pets, petData)
  end
  for i, v in pairs(jsonData.stamps) do
    local stampData = L_Json.decode(v)
    table.insert(allData.stamps, stampData)
  end
  local cameraData = L_Json.decode(jsonData.camera)
  allData.camera = cameraData
  local envData = L_Json.decode(jsonData.env)
  allData.env = envData
  return allData
end

return this
