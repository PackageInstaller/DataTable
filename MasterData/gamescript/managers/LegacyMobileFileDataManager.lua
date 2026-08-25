local FileValueType = {
  number = "1",
  string = "2",
  boolean = "3",
  table = "4"
}
local ValidKeyType = {number = "1", string = "2"}
local MobileFileDataManager, Super = System.NewClass("MobileFileDataManager", Manager)

function MobileFileDataManager:ctor()
  Super.ctor(self)
  self.commFileInfo = {
    file = "z1_use.cfg",
    dirty = false,
    data = {}
  }
  self:OpenCommFile()
end

function MobileFileDataManager:OpenCommFile()
  local text = CS.Framework.AssetLoadUtil.OnReadGameFile(self.commFileInfo.file)
  if "" == text then
    return
  end
  self.commFileInfo.data = self:UnparseFileData(text)
end

function MobileFileDataManager:OnSaveCommInfo()
  if not self.commFileInfo.dirty then
    return
  end
  local text = self:ParseFileData(self.commFileInfo.data)
  if "" ~= text then
    ApplicationUtils.OnWriteGameFile(self.commFileInfo.file, text)
    self.commFileInfo.dirty = false
  end
end

function MobileFileDataManager:GetCommFileValue(key, default)
  local d = self.commFileInfo.data[key]
  if default then
    local typeName = type(default)
    if "number" == typeName then
      return d and tonumber(d) or default
    end
  end
  if nil == d then
    return default
  end
  return d
end

function MobileFileDataManager:SetCommFileValue(key, value)
  local oldvalue = self.commFileInfo.data[key]
  if oldvalue then
    local oType = type(oldvalue)
    local newType = type(value)
    if oType == newType and "table" ~= oType and oldvalue == value then
      return
    end
  end
  
  local function iterate(v)
    local valType = type(v)
    if "table" == valType then
      local data = {}
      for vKey, vVal in pairs(v) do
        data[vKey] = iterate(vVal)
      end
      return data
    else
      return v
    end
  end
  
  self.commFileInfo.data[key] = iterate(value)
  self.commFileInfo.dirty = true
end

function MobileFileDataManager:OpenPlayerFile(serverId, account)
  local fileName = {
    serverId,
    account,
    DataCenter.playerData.DRole.uid
  }
  self.fileInfo = {
    file = table.concat(fileName, "_"),
    dirty = false,
    data = {}
  }
  local text = CS.Framework.AssetLoadUtil.OnReadGameFile(self.fileInfo.file)
  if "" == text then
    return
  end
  self.fileInfo.data = self:UnparseFileData(text)
end

function MobileFileDataManager:TestUnparseFileData()
  local text = CS.Framework.AssetLoadUtil.OnReadGameFile(self.fileInfo.file)
  self.fileInfo.data = self:UnparseFileData(text)
end

function MobileFileDataManager:OnSavePlayerFileInfo()
  if not self.fileInfo or not self.fileInfo.dirty then
    return
  end
  local text = self:ParseFileData(self.fileInfo.data)
  if "" ~= text then
    ApplicationUtils.OnWriteGameFile(self.fileInfo.file, text)
    self.fileInfo.dirty = false
  end
end

function MobileFileDataManager:GetPlayerFileValue(key, default)
  if not self.fileInfo or not self.fileInfo.data then
    return default
  end
  local d = self.fileInfo.data[key]
  if default then
    local typeName = type(default)
    if "number" == typeName then
      return d and tonumber(d) or default
    end
  end
  if nil == d then
    return default
  end
  return d
end

function MobileFileDataManager:SetPlayerFileValue(key, value)
  if not self.fileInfo or not self.fileInfo.data then
    return
  end
  local oldvalue = self.fileInfo.data[key]
  if not oldvalue then
    return
  end
  local oType = type(oldvalue)
  local newType = type(value)
  if oType == newType and "table" ~= oType and oldvalue == value then
    return
  end
  
  local function iterate(v)
    local valType = type(v)
    if "table" == valType then
      local data = {}
      for vKey, vVal in pairs(v) do
        data[vKey] = iterate(vVal)
      end
      return data
    else
      return v
    end
  end
  
  self.fileInfo.data[key] = iterate(value)
  self.fileInfo.dirty = true
end

function MobileFileDataManager:ReadTextFromLocalFile(owner, inputUIName)
  local key = owner.__name .. "_" .. inputUIName
  local savedValue = self:GetCommFileValue(key)
  if savedValue then
    local textComp = owner.ui[inputUIName]:GetComponent(typeof(CS.UnityEngine.UI.Text))
    if textComp then
      textComp.text = savedValue
    end
  end
end

function MobileFileDataManager:SaveTextFromLocalFile(owner, inputUIName)
  local key = owner.__name .. "_" .. inputUIName
  local CSText = typeof(CS.UnityEngine.UI.Text)
  local textComp = owner.ui[inputUIName]:GetComponent(CSText)
  if textComp then
    local writeValue = textComp.text or ""
    self:SetCommFileValue(key, writeValue)
  end
end

function MobileFileDataManager:ParseFileData(dataTable)
  local text = ""
  local cnt = 0
  for k, v in pairs(dataTable) do
    if not ValidKeyType[type(k)] then
      Logger.Error("Parse File Data Error! Invalid Key !!!")
      return ""
    end
    local vType = type(v)
    if not FileValueType[vType] then
      Logger.Error("Parse File Data Error! Invalid Value !!!")
      return ""
    end
    if "table" == vType then
      local str, depth = self:ParseFileData(v)
      text = text .. string.format("%s#%s=%s#%s\n", k, ValidKeyType[type(k)], FileValueType[vType], depth) .. str
    else
      text = text .. string.format("%s#%s=%s#%s\n", k, ValidKeyType[type(k)], FileValueType[vType], v)
    end
    cnt = cnt + 1
  end
  return text, cnt
end

function MobileFileDataManager:UnparseFileData(text)
  local keyValueDatas = string.split(text, "\n")
  local kvIndex = 1
  
  local function enumerateKeyValue(memNum, isRoot)
    local settedMemNum = 0
    local needMemNum = memNum or 0
    local retValue = {}
    while kvIndex <= #keyValueDatas do
      local kvData = keyValueDatas[kvIndex]
      if "" == kvData then
        break
      end
      local kv = string.split(kvData, "=")
      local keyText = string.split(kv[1], "#")
      local key = keyText[1]
      if keyText[2] == ValidKeyType.number then
        key = tonumber(keyText[1])
      end
      local value = kv[2]
      if nil == value then
        break
      end
      local detail = string.split(value, "#")
      if detail[1] == FileValueType.table then
        kvIndex = kvIndex + 1
        retValue[key] = enumerateKeyValue(tonumber(detail[2]))
        settedMemNum = settedMemNum + 1
        if not isRoot and needMemNum <= settedMemNum then
          break
        end
      else
        local v = detail[2]
        if detail[1] == FileValueType.number then
          v = tonumber(detail[2])
        elseif detail[1] == FileValueType.boolean then
          v = false
          if "true" == detail[2] then
            v = true
          end
        end
        retValue[key] = v
        kvIndex = kvIndex + 1
        settedMemNum = settedMemNum + 1
        if not isRoot and needMemNum <= settedMemNum then
          break
        end
      end
    end
    return retValue
  end
  
  local ret = enumerateKeyValue(0, true)
  return ret
end

return MobileFileDataManager
