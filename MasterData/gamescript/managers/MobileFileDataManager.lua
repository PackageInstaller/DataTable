local JSON = require("ejoysdk_lua.libs.lunajson")
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
  local firstStr = string.sub(text, 1, 1)
  if "{" == firstStr then
    self.commFileInfo.data = JSON.decode(text)
  else
    self.commFileInfo.data = self:LegacyDecodeText(text)
  end
end

function MobileFileDataManager:OnSaveCommInfo()
  if not self.commFileInfo.dirty then
    return
  end
  local json_str = JSON.encode(self.commFileInfo.data)
  ApplicationUtils.OnWriteGameFile(self.commFileInfo.file, json_str)
  self.commFileInfo.dirty = false
end

function MobileFileDataManager:GetCommFileValue(key, default)
  do return self.GetFileValue, self, self.commFileInfo, key end
  return self.GetFileValue, self, self.commFileInfo, key, default
end

function MobileFileDataManager:SetCommFileValue(key, value, isSaveImmediately)
  self:SetFileValue(self.commFileInfo, key, value)
  if isSaveImmediately then
    self:OnSaveCommInfo()
  end
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
  local firstStr = string.sub(text, 1, 1)
  local ok, data
  if "{" == firstStr then
    ok, data = pcall(JSON.decode, text)
  else
    ok, data = pcall(self.LegacyDecodeText, self, text)
  end
  if ok then
    self.fileInfo.data = data
  else
    Logger.Error(string.format("MobileFileDataManager OpenPlayerFile parse failed, file:%s, error:%s", self.fileInfo.file, tostring(data)))
  end
end

function MobileFileDataManager:OnSavePlayerFileInfo()
  if not self.fileInfo or not self.fileInfo.dirty then
    return
  end
  local ok, json_str = pcall(JSON.encode, self.fileInfo.data)
  if not ok then
    Logger.Error(string.format("MobileFileDataManager OnSavePlayerFileInfo encode failed, file:%s, error:%s", self.fileInfo.file, tostring(json_str)))
    return
  end
  local writeOk, writeErr = pcall(ApplicationUtils.OnWriteGameFile, self.fileInfo.file, json_str)
  if not writeOk then
    Logger.Error(string.format("MobileFileDataManager OnSavePlayerFileInfo write failed, file:%s, error:%s", self.fileInfo.file, tostring(writeErr)))
    return
  end
  self.fileInfo.dirty = false
end

function MobileFileDataManager:GetPlayerFileValue(key, default)
  if not self.fileInfo or not self.fileInfo.data then
    do return self.GetCommFileValue, self, key end
    return self.GetCommFileValue, self, key, default, nil
  end
  do return self.GetFileValue, self, self.fileInfo, key end
  return self.GetFileValue, self, self.fileInfo, key, default
end

function MobileFileDataManager:SetPlayerFileValue(key, value, isSaveImmediately)
  if not self.fileInfo or not self.fileInfo.data then
    self:SetCommFileValue(key, value, isSaveImmediately)
    return
  end
  self:SetFileValue(self.fileInfo, key, value)
  if isSaveImmediately then
    self:OnSavePlayerFileInfo()
  end
end

function MobileFileDataManager:GetFileValue(fileData, key, default)
  local d = fileData.data[tostring(key)]
  if nil == d then
    return default
  end
  if type(d) == "table" then
    do return self.TranslateToLuaTable, self end
    return self.TranslateToLuaTable, self, d
  end
  return d
end

function MobileFileDataManager:SetFileValue(fileInfo, key, value)
  if not fileInfo or not fileInfo.data then
    return
  end
  key = tostring(key)
  local oldvalue = fileInfo.data[key]
  if type(value) ~= "table" and oldvalue == value then
    return
  end
  if type(value) == "table" then
    value = self:TranslateToJsonTable(table.clone(value))
  end
  fileInfo.data[key] = value
  fileInfo.dirty = true
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

function MobileFileDataManager:LegacyDecodeText(text)
  if not self.legacyManager then
    self.legacyManager = LegacyMobileFileDataManager()
  end
  local data = self.legacyManager:UnparseFileData(text)
  local tableList = self:GetAllTable(data)
  for _, childTb in ipairs(tableList) do
    self:TranslateToJsonTable(childTb)
  end
  return data
end

function MobileFileDataManager:GetAllTable(root)
  local tableList = {}
  local stack = {root}
  while #stack > 0 do
    local t = table.remove(stack)
    table.insert(tableList, t)
    for k, v in pairs(t) do
      if "table" == type(v) then
        table.insert(stack, v)
      end
    end
  end
  return tableList
end

function MobileFileDataManager:TraverseTable(root, dealChildTb)
  local stack = {root}
  while #stack > 0 do
    local t = table.remove(stack)
    dealChildTb(t)
    for k, v in pairs(t) do
      if "table" == type(v) then
        table.insert(stack, v)
      end
    end
  end
end

function MobileFileDataManager:TranslateToJsonTable(tb)
  local numberKeys = {}
  local clearKeys = {}
  for k, _ in pairs(tb) do
    local keyType = type(k)
    if "number" == keyType then
      if not tb[tostring(k)] then
        table.insert(numberKeys, k)
      else
        table.insert(clearKeys, k)
        Logger.Warn(string.format("存盘数据同时包含了相同的Number和String的key:%s, number的key不会保存", k))
      end
    elseif "string" ~= keyType then
      table.insert(clearKeys, k)
    end
  end
  for _, numberKey in ipairs(numberKeys) do
    tb[tostring(numberKey)] = tb[numberKey]
    tb[numberKey] = nil
  end
  for _, clearKey in ipairs(clearKeys) do
    tb[clearKey] = nil
  end
  tb._numberKeys = numberKeys
  return tb
end

function MobileFileDataManager:TranslateToLuaTable(tb)
  local numberKeys = tb._numberKeys or {}
  local newTb = {}
  for k, v in pairs(tb) do
    if tonumber(k) and table.contains(numberKeys, tonumber(k)) then
      newTb[tonumber(k)] = v
    else
      newTb[k] = v
    end
  end
  newTb._numberKeys = nil
  return newTb
end

return MobileFileDataManager
