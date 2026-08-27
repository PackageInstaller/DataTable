local PersistentManager = {}
local cs_FilePathHelper = CS.FilePathHelper.Instance
local pb = require("pb")
pb.option("int64_as_number")
pb.option("enum_as_value")

function PersistentManager:InitManager()
  local cs_Resources = CS.UnityEngine.Resources
  local resloader = CS.ResLoader.Create()
  for k, v in ipairs(PersistentConfig.PersistentProtoFiles) do
    local pbTextAsset = resloader:LoadABAsset(PathConsts.PbFilePath .. v)
    pb.load(pbTextAsset.bytes)
    cs_Resources.UnloadAsset(pbTextAsset)
  end
  resloader:Put2Pool()
  self.DataModels = {}
  CS.MonoDriver.Instance:SetOnApplicationPause(BindCallback(self, self.SaveAllModelData))
end

function PersistentManager:__encodeAndSaveData(packageId, data)
  local dataConfig = PersistentConfig.PackageData[packageId]
  if dataConfig == nil then
    error("cant find persisten_package:" .. packageId)
    return
  end
  local dataTable
  if dataConfig.SaveSingleton then
    dataTable = self.DataModels[packageId]
  else
    dataTable = data
  end
  if dataTable == nil then
    return
  end
  if not dataTable:IsPstDataDirty() then
    return
  end
  local encodeTable = dataTable:GetSaveEncodeTable()
  local msgContent = pb.encode(dataConfig.PbName, encodeTable)
  local filePath = dataTable:GetSaveDataFilePath()
  if string.IsNullOrEmpty(filePath) == nil then
    return
  end
  self:SaveData(filePath, msgContent)
  dataTable:ResetPstDataDirty()
end

local function DecodeData(PbName, content)
  local msg = pb.decode(PbName, content)
  return msg
end

function PersistentManager:LoadAndDecodeData(packageId, ...)
  local dataConfig = PersistentConfig.PackageData[packageId]
  if dataConfig == nil then
    error("cant find persisten_package:" .. packageId)
    return
  end
  if dataConfig.DataType == PersistentConfig.DataType.User and self.playerId == nil then
    error("cant get ueserModel on user log out")
    return
  end
  local dataModel = dataConfig.DataModel.New(...)
  if dataConfig.SaveSingleton then
    self.DataModels[packageId] = dataModel
    dataModel.__packageId = packageId
  end
  local filePath = dataModel:GetSaveDataFilePath()
  local content = self:LoadData(filePath)
  if content ~= nil then
    local status, data = xpcall(DecodeData, debug.traceback, dataConfig.PbName, content)
    if status then
      dataModel:InitBySaveData(data)
      return dataModel
    else
      warn("PersistentManager decode proto failed:" .. data)
      dataModel:InitByDefaultData()
      self:SaveModelData(packageId)
      return dataModel
    end
  end
  dataModel:InitByDefaultData()
  return dataModel
end

function PersistentManager:SaveAllModelData()
  for _, v in ipairs(PersistentConfig.ModelSaveList) do
    if v ~= nil then
      self:__encodeAndSaveData(v)
    end
  end
end

function PersistentManager:SaveModelData(modelId, data)
  self:__encodeAndSaveData(modelId, data)
end

function PersistentManager:HandleLogOut()
  if self.playerId == PlayerDataCenter.playerId then
    self:SaveAllModelData()
  end
  self:UnLoadAllData()
end

function PersistentManager:GetDataModel(packageId)
  if self.DataModels[packageId] == nil then
    PersistentManager:LoadAndDecodeData(packageId)
  end
  if self.DataModels[packageId] == nil then
    error("Fail to get model data,model id:" .. tostring(PersistentConfig.ePackage.UserData))
    return nil
  end
  return self.DataModels[packageId]
end

function PersistentManager:SaveData(filePath, content)
  cs_FilePathHelper:WriteBytesToFile(filePath, content)
end

function PersistentManager:LoadData(filePath)
  return cs_FilePathHelper:ReadBytesFromFile(filePath)
end

function PersistentManager:UnLoadAllData()
  local tmpDataModels = {}
  for packageId, dataModel in pairs(self.DataModels) do
    local dataConfig = PersistentConfig.PackageData[packageId]
    if dataConfig ~= nil and not dataConfig.LogoutUnload then
      tmpDataModels[packageId] = dataModel
    else
      dataModel:OnLogoutDelete()
    end
  end
  self.DataModels = tmpDataModels
  self.playerId = nil
end

return PersistentManager
