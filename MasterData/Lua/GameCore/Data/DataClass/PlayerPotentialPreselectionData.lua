local PlayerPotentialPreselectionData = class("PlayerPotentialPreselectionData")
local TimerManager = require("GameCore.Timer.TimerManager")
local saveCD = 5

function PlayerPotentialPreselectionData:Init()
  self.bGetData = false
  self.tbPreselectionList = {}
  self.mapCurUsePreselection = {}
  self.rankSaveTimer = nil
end

function PlayerPotentialPreselectionData:CreateNewPreselection(mapNetData)
  local mapPotential = {}
  local tbCharPotential = {}
  for _, v in ipairs(mapNetData.CharPotentials) do
    local nCharId = v.CharId
    local tbPotential = {}
    for _, data in ipairs(v.Potentials) do
      table.insert(tbPotential, {
        nId = data.Id,
        nLevel = data.Level
      })
    end
    table.insert(tbCharPotential, {nCharId = nCharId, tbPotential = tbPotential})
  end
  mapPotential = {
    nId = mapNetData.Id,
    sName = mapNetData.Name,
    bPreference = mapNetData.Preference,
    tbCharPotential = tbCharPotential,
    nTimestamp = mapNetData.Timestamp
  }
  return mapPotential
end

function PlayerPotentialPreselectionData:GetPreselectionById(nId)
  for _, v in ipairs(self.tbPreselectionList) do
    if v.nId == nId then
      return v
    end
  end
end

function PlayerPotentialPreselectionData:SavePreselection(sName, bPreference, tbCharPotential, callback)
  self:SendImportPotential(sName, bPreference, tbCharPotential, callback)
end

function PlayerPotentialPreselectionData:PackPotentialData(tbCharPotential)
  local bit_buffer = {}
  local bit_pos = 0
  
  local function to_uint32(num)
    num = math.floor(num or 0)
    if num < 0 then
      num = 0
    elseif 4294967295 < num then
      num = 4294967295
    end
    return num
  end
  
  local function add_bit(bit)
    bit_buffer[bit_pos] = bit
    bit_pos = bit_pos + 1
  end
  
  local function write_bits(value, num_bits)
    for i = num_bits - 1, 0, -1 do
      add_bit(value >> i & 1)
    end
  end
  
  local function pack_potential(tbAll, tbPotential, bSpecial)
    for k, nId in ipairs(tbAll) do
      local nLevel = 0
      for _, data in ipairs(tbPotential) do
        if data.nId == nId then
          nLevel = data.nLevel
          break
        end
      end
      if bSpecial then
        local flag = 0 < nLevel and 1 or 0
        write_bits(flag, 1)
      else
        write_bits(nLevel, 3)
      end
    end
  end
  
  for k, v in ipairs(tbCharPotential) do
    if v.nCharId == 0 then
      return
    end
    write_bits(to_uint32(v.nCharId), 32)
  end
  for k, v in ipairs(tbCharPotential) do
    local potentialCfg = ConfigTable.GetData("CharPotential", v.nCharId)
    if potentialCfg ~= nil then
      if k == 1 then
        pack_potential(potentialCfg.MasterSpecificPotentialIds, v.tbPotential, true)
        pack_potential(potentialCfg.MasterNormalPotentialIds, v.tbPotential, false)
        pack_potential(potentialCfg.CommonPotentialIds, v.tbPotential, false)
      else
        pack_potential(potentialCfg.AssistSpecificPotentialIds, v.tbPotential, true)
        pack_potential(potentialCfg.AssistNormalPotentialIds, v.tbPotential, false)
        pack_potential(potentialCfg.CommonPotentialIds, v.tbPotential, false)
      end
    end
  end
  local bytes = {}
  for i = 0, bit_pos - 1, 8 do
    local byte = 0
    for j = 0, 7 do
      if bit_pos > i + j then
        byte = byte * 2 + (bit_buffer[i + j] or 0)
      else
        byte = byte * 2
      end
    end
    table.insert(bytes, string.char(byte))
  end
  return CS.System.Convert.ToBase64String(table.concat(bytes))
end

function PlayerPotentialPreselectionData:UnPackPotentialData(b64Str)
  if not b64Str or type(b64Str) ~= "string" or b64Str == "" then
    return
  end
  if string.match(b64Str, "[^A-Za-z0-9+/=]") then
    printError("包含非base64字符")
    return
  end
  b64Str = b64Str:gsub("-", "+")
  b64Str = b64Str:gsub("_", "/")
  local len = #b64Str
  if len % 4 ~= 0 then
    b64Str = b64Str .. string.rep("=", 4 - len % 4)
  end
  if #b64Str % 4 ~= 0 then
    printError("Base64长度错误")
    return
  end
  local ok, packed_data = xpcall(function()
    return CS.System.Convert.FromBase64String(b64Str)
  end, function(e)
    return e
  end)
  if not ok then
    printError("Base64解码失败: " .. tostring(packed_data))
    return
  end
  local bit_buffer = {}
  local bit_count = 0
  for i = 1, #packed_data do
    local byte = string.byte(packed_data, i)
    for j = 7, 0, -1 do
      local bit = byte >> j & 1
      bit_buffer[bit_count] = bit
      bit_count = bit_count + 1
    end
  end
  local bit_index = 0
  
  local function read_bits(num_bits)
    local value = 0
    for i = num_bits - 1, 0, -1 do
      if bit_index >= bit_count then
        break
      end
      value = value + (bit_buffer[bit_index] or 0) * (1 << i)
      bit_index = bit_index + 1
    end
    return value
  end
  
  local tbCharPotential = {}
  for i = 1, 3 do
    local nCharId = read_bits(32)
    local mapCharCfg = ConfigTable.GetData_Character(nCharId)
    if mapCharCfg == nil or mapCharCfg.Visible == false or mapCharCfg.Available == false then
      printError("角色id解析错误")
      return
    end
    table.insert(tbCharPotential, {
      CharId = nCharId,
      Potentials = {}
    })
  end
  local nMaxLevel = ConfigTable.GetConfigNumber("PotentialPreselectionMaxLevel")
  
  local function unpack_potential(tbPotential, tbAll, bSpecial, nSpecialCount)
    for _, nId in ipairs(tbAll) do
      if bSpecial then
        local flag = read_bits(1)
        if flag == 1 then
          table.insert(tbPotential, {Id = nId, Level = 1})
          if nSpecialCount then
            nSpecialCount = nSpecialCount + 1
            if 2 < nSpecialCount then
              printError("特殊潜能数量超过2")
              return false
            end
          end
        end
      else
        local nLevel = read_bits(3)
        if nLevel > nMaxLevel then
          printError("潜能等级异常")
          return false
        end
        if 0 < nLevel then
          table.insert(tbPotential, {Id = nId, Level = nLevel})
        end
      end
    end
    return true
  end
  
  for k, v in ipairs(tbCharPotential) do
    if v.CharId > 0 then
      local nSpecialCount = 0
      local potentialCfg = ConfigTable.GetData("CharPotential", v.CharId)
      if potentialCfg then
        local bAvailable = true
        if k == 1 then
          bAvailable = bAvailable and unpack_potential(v.Potentials, potentialCfg.MasterSpecificPotentialIds, true, nSpecialCount)
          bAvailable = bAvailable and unpack_potential(v.Potentials, potentialCfg.MasterNormalPotentialIds, false)
        else
          bAvailable = bAvailable and unpack_potential(v.Potentials, potentialCfg.AssistSpecificPotentialIds, true, nSpecialCount)
          bAvailable = bAvailable and unpack_potential(v.Potentials, potentialCfg.AssistNormalPotentialIds, false)
        end
        bAvailable = bAvailable and unpack_potential(v.Potentials, potentialCfg.CommonPotentialIds, false)
        if not bAvailable then
          return
        end
      end
    end
  end
  return tbCharPotential
end

function PlayerPotentialPreselectionData:SavePreselectionFromRank(sName, bPreference, tbCharPotential, callback)
  if self.rankSaveTimer ~= nil then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Potential_Preselection_Save_CD"))
    return
  end
  self.rankSaveTimer = TimerManager.Add(1, saveCD, nil, function()
    self.rankSaveTimer:Cancel()
    self.rankSaveTimer = nil
  end, true, true, true, nil)
  self:SendImportPotential(sName, bPreference, tbCharPotential, callback)
end

function PlayerPotentialPreselectionData:GetPreselectionList()
  return self.tbPreselectionList
end

function PlayerPotentialPreselectionData:SendGetPreselectionList(callback)
  if not self.bGetData then
    local function netCallback(_, mapNetData)
      self.bGetData = true
      
      self.tbPreselectionList = {}
      for _, v in ipairs(mapNetData.List) do
        local mapData = self:CreateNewPreselection(v)
        table.insert(self.tbPreselectionList, mapData)
      end
      if callback ~= nil then
        callback()
      end
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.potential_preselection_list_req, {}, nil, netCallback)
  elseif callback ~= nil then
    callback()
  end
end

function PlayerPotentialPreselectionData:SendDeletePreselection(tbIds, callback)
  local function netCallback(_, mapNetData)
    local tbTemp = {}
    
    for k, v in ipairs(self.tbPreselectionList) do
      if table.indexof(tbIds, v.nId) == 0 then
        table.insert(tbTemp, v)
      end
    end
    self.tbPreselectionList = tbTemp
    local tbAllTeam = PlayerData.Team:GetAllTeamData()
    if tbAllTeam ~= nil then
      for nIdx, v in ipairs(tbAllTeam) do
        if 0 < table.indexof(tbIds, v.nPreselectionId) then
          local tmpDisc = v.tbTeamDiscId
          local tbTeamMemberId = v.tbTeamMemberId
          PlayerData.Team:UpdateFormationInfo(nIdx, tbTeamMemberId, tmpDisc, 0, function()
            EventManager.Hit("UpdateFormationInfoSuc", nIdx)
          end)
        end
      end
    end
    if callback ~= nil then
      callback()
    end
    EventManager.Hit("DeletePotentialPreselection")
  end
  
  local msgData = {Ids = tbIds}
  HttpNetHandler.SendMsg(NetMsgId.Id.potential_preselection_delete_req, msgData, nil, netCallback)
end

function PlayerPotentialPreselectionData:SendChangePreselectionName(nId, sName, callback)
  local function netCallback()
    for _, v in ipairs(self.tbPreselectionList) do
      if v.nId == nId then
        v.sName = sName
        
        break
      end
    end
    if callback ~= nil then
      callback()
    end
  end
  
  local msgData = {Id = nId, Name = sName}
  HttpNetHandler.SendMsg(NetMsgId.Id.potential_preselection_name_set_req, msgData, nil, netCallback)
end

function PlayerPotentialPreselectionData:SendPreselectionPreference(tbCheckIns, tbCheckOutIds, callback)
  local function netCallback(_, mapNetData)
    for _, v in ipairs(self.tbPreselectionList) do
      if tbCheckIns ~= nil and table.indexof(tbCheckIns, v.nId) > 0 then
        v.bPreference = true
      end
      if tbCheckOutIds ~= nil and table.indexof(tbCheckOutIds, v.nId) > 0 then
        v.bPreference = false
      end
    end
    if callback ~= nil then
      callback()
    end
  end
  
  local msgData = {CheckInIds = tbCheckIns, CheckOutIds = tbCheckOutIds}
  HttpNetHandler.SendMsg(NetMsgId.Id.potential_preselection_preference_set_req, msgData, nil, netCallback)
end

function PlayerPotentialPreselectionData:SendUpdatePotential(nId, tbCharPotential, callback)
  local function netCallback(_, mapNetData)
    local mapData = self:CreateNewPreselection(mapNetData)
    
    for k, v in ipairs(self.tbPreselectionList) do
      if v.nId == nId then
        self.tbPreselectionList[k] = mapData
        break
      end
    end
    if callback ~= nil then
      callback(mapData)
    end
  end
  
  local msgData = {Id = nId, CharPotentials = tbCharPotential}
  HttpNetHandler.SendMsg(NetMsgId.Id.potential_preselection_update_req, msgData, nil, netCallback)
end

function PlayerPotentialPreselectionData:SendImportPotential(sName, bPreference, tbCharPotential, callback)
  local function netCallback(_, mapNetData)
    local bInList = false
    
    local mapData = self:CreateNewPreselection(mapNetData)
    for k, v in ipairs(self.tbPreselectionList) do
      if v.nId == mapData.nId then
        bInList = true
        self.tbPreselectionList[k] = mapData
        break
      end
    end
    if not bInList then
      table.insert(self.tbPreselectionList, mapData)
    end
    if callback ~= nil then
      callback(mapData)
    end
  end
  
  local msgData = {
    Name = sName,
    Preference = bPreference,
    CharPotentials = tbCharPotential
  }
  HttpNetHandler.SendMsg(NetMsgId.Id.potential_preselection_import_req, msgData, nil, netCallback)
end

return PlayerPotentialPreselectionData
