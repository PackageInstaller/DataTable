_class("UIN34DispatchLocalDb", Object)
UIN34DispatchLocalDb = UIN34DispatchLocalDb

function UIN34DispatchLocalDb:Constructor()
  self._Viewed = {}
end

function UIN34DispatchLocalDb:GetModule(gameModuleProto)
  return GameGlobal.GetModule(gameModuleProto)
end

function UIN34DispatchLocalDb:GetDBViewedKey()
  local key = "UIN34DispatchLocalDb::Viewed"
  local roleModule = self:GetModule(RoleModule)
  return roleModule:GetPstId() .. key
end

function UIN34DispatchLocalDb:ViewedLoadDB()
  local dbKey = self:GetDBViewedKey()
  local content = LocalDB.GetString(dbKey, "")
  local fnString = string.format("return {%s}", content)
  local fnTable = load(fnString)
  local dbData = fnTable()
  self._Viewed = dbData
  for k, v in pairs(dbData) do
    local lookup = {}
    for sk, sv in pairs(v) do
      lookup[sv] = sv
    end
    self._Viewed[k] = lookup
  end
end

function UIN34DispatchLocalDb:ViewedSaveDB()
  local content = ""
  for k, v in pairs(self._Viewed) do
    local mission = ""
    for sk, sv in pairs(v) do
      mission = mission .. string.format("%d, ", sv)
    end
    content = content .. string.format("[%d] = {%s}, ", k, mission)
  end
  local dbKey = self:GetDBViewedKey()
  LocalDB.SetString(dbKey, content)
end

function UIN34DispatchLocalDb:ClearDB()
  self._Viewed = {}
  self:ViewedSaveDB()
end

function UIN34DispatchLocalDb:IsViewed(archId)
  local optionsData = self._Viewed[archId]
  if optionsData == nil then
    return false
  end
  local cfgArch = Cfg.cfg_component_dispatch_arch[archId]
  if cfgArch == nil then
    Log.exception("cfg_component_dispatch_arch中找不到配置:", archId)
    return false
  end
  local options = {}
  local openList = {
    cfgArch.DispatchTalk
  }
  while #openList ~= 0 do
    local loopList = openList
    openList = {}
    for k, v in pairs(loopList) do
      local cfgTalk = Cfg.cfg_mission_multiline_talk[v]
      if cfgTalk == nil then
        Log.exception("cfg_mission_multiline_talk中找不到配置:", v)
      elseif cfgTalk.AnswerID ~= nil then
        table.insert(options, cfgTalk)
        for ak, av in pairs(cfgTalk.AnswerID) do
          table.insert(openList, av)
        end
      elseif cfgTalk.NextWord ~= nil then
        table.insert(openList, cfgTalk.NextWord)
      end
    end
  end
  local viewedDialogue = true
  for k, v in pairs(options) do
    local findOption = false
    for ak, av in pairs(v.AnswerID) do
      if optionsData[av] ~= nil then
        findOption = true
        break
      end
    end
    if not findOption then
      viewedDialogue = false
      break
    end
  end
  return viewedDialogue, optionsData
end

function UIN34DispatchLocalDb:Viewed(archId, options)
  if options == nil then
    options = {}
  end
  local lookup = {}
  for k, v in pairs(options) do
    lookup[v] = v
  end
  self._Viewed[archId] = lookup
  self:ViewedSaveDB()
end
