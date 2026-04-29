_class("UIResInstanceEntryData", Object)
UIResInstanceEntryData = UIResInstanceEntryData
local StringGet = StringTable.Get

function UIResInstanceEntryData:Constructor(cfg)
  if not cfg then
    return
  end
  self.cfg = cfg
  self.instanceList = {}
  self.expInstanceList = {}
  for _, subType in pairs(DungeonSubType) do
    self.expInstanceList[subType] = {}
  end
  self.stack = Stack:New()
  self:InitInstanceList()
  self:InitWord()
end

function UIResInstanceEntryData:InitWord()
  local word = self.cfg and StringGet(self.cfg.word) or ""
  local words = string.split(word, "|")
  self.wordPlayer = words[1]
  self.wordWel = words[2]
  self.wordWait = words[3]
  local voice = self.cfg.voice
  local voices = string.split(voice, "|")
  self.voiceWel = tonumber(voices[1])
  self.voiceWait = tonumber(voices[2])
  self.wordWaitLoopTime = self.cfg.loopTime
  self.interactWords = self.cfg.interactWord
end

function UIResInstanceEntryData:InitInstanceList()
  local levelids = self:GetLevelIds()
  if not levelids then
    return
  end
  for _, instanceId in ipairs(levelids) do
    local i = UIResInstanceData:New(instanceId)
    table.insert(self.instanceList, i)
    if self:GetMainType() == DungeonType.DungeonType_Experience then
      table.insert(self.expInstanceList[i:GetSubType()], i)
    end
  end
end

function UIResInstanceEntryData:GetInstanceList()
  return self.instanceList
end

function UIResInstanceEntryData:GetInstanceById(instanceId)
  for index, data in ipairs(self.instanceList) do
    if data:GetId() == instanceId then
      return data
    end
  end
  return nil
end

function UIResInstanceEntryData:GetExpInstanceList(subType)
  return self.expInstanceList[subType]
end

function UIResInstanceEntryData:GetExpInstanceListSort(subType)
  table.sort(self.expInstanceList[subType], UIResInstanceEntryData.SortExp)
  return table.count(self.expInstanceList[subType])
end

function UIResInstanceEntryData.SortExp(a, b)
  local aOpen = a:Open() == true and 1 or 0
  local bOpen = b:Open() == true and 1 or 0
  if aOpen == bOpen then
    return a:GetId() < b:GetId()
  else
    return aOpen > bOpen
  end
end

function UIResInstanceEntryData:GetMainType()
  return self.cfg and self.cfg.instancetype or 0
end

function UIResInstanceEntryData:GetLevelIds()
  return self.cfg and self.cfg.levelids or nil
end

function UIResInstanceEntryData:GetEntryName()
  return self.cfg and StringGet(self.cfg.entryname) or ""
end

function UIResInstanceEntryData:GetEntryResultName()
  return self.cfg and StringGet(self.cfg.entryresultname) or ""
end

function UIResInstanceEntryData:GetMaterialName()
  return self.cfg and StringGet(self.cfg.resname) or ""
end

function UIResInstanceEntryData:GetDate()
  return self.cfg and self.cfg.opentime[1] or ""
end

function UIResInstanceEntryData:GetShowDate()
  return self.cfg and StringGet(self.cfg.dateshow) or ""
end

function UIResInstanceEntryData:GetEntryPic()
  return self.cfg and self.cfg.entrypic or ""
end

function UIResInstanceEntryData:GetDetailPic()
  return self.cfg and self.cfg.detailpic or ""
end

function UIResInstanceEntryData:GetDetailSpine()
  if self.cfg and self.cfg.spinePetID then
    return self.cfg.spinePetID
  end
end

function UIResInstanceEntryData:GetDetailSpineOffsetAndScale()
  if self.cfg and self.cfg.spineOffsetScale then
    return self.cfg.spineOffsetScale
  end
end

function UIResInstanceEntryData:GetBgPic()
  return self.cfg and self.cfg.bgpic or ""
end

function UIResInstanceEntryData:GetWordPlayerName()
  return self.wordPlayer
end

function UIResInstanceEntryData:GetWelWord()
  return self.wordWel
end

function UIResInstanceEntryData:GetWaitWord()
  return self.wordWait
end

function UIResInstanceEntryData:GetWelVoice()
  return self.voiceWel
end

function UIResInstanceEntryData:GetWaitVoice()
  return self.voiceWait
end

function UIResInstanceEntryData:GetWaitWordLoopTime()
  return self.wordWaitLoopTime
end

function UIResInstanceEntryData:GetInteractWord()
  if self.stack:Size() <= 0 then
    local count = 0
    local all = #self.interactWords
    while count < all do
      local index = math.random(1, all)
      if not self.stack:Contains(index) then
        self.stack:Push(index)
        count = count + 1
      end
    end
  end
  return self.interactWords[self.stack:Pop()]
end

function UIResInstanceEntryData:GetPos()
  if not self.pos then
    local x = self.cfg.pos[1]
    local y = self.cfg.pos[2]
    self.pos = Vector2.New(x, y)
  end
  return self.pos
end
