_class("HomeSecretMsg", Object)
HomeSecretMsg = HomeSecretMsg
local SecretMsgType = {
  Single = 1,
  Double = 2,
  DoubleSameRoom = 3
}
_enum("SecretMsgType", SecretMsgType)

function HomeSecretMsg:Constructor()
end

function HomeSecretMsg:Init(id, petID1, petID2)
  self._id = id
  self._petID1 = petID1
  self._petID2 = petID2
  local cfg = Cfg.cfg_homeland_pet_secret_msg[id]
  if cfg == nil then
    BuildError("找不到秘闻配置:", id)
  end
  if not Cfg.cfg_pet[petID1] then
    BuildError("cfg_pet找不到配置:", petID1)
  end
  if petID2 and not Cfg.cfg_pet[petID2] then
    BuildError("cfg_pet找不到配置:", petID2)
  end
  self._type = nil
  if cfg.Type == 1 then
    self._type = SecretMsgType.Single
  elseif cfg.Type == 2 then
    if cfg.SameRoom == true then
      self._type = SecretMsgType.DoubleSameRoom
    else
      self._type = SecretMsgType.Double
    end
  end
  if self._type == SecretMsgType.Single then
    local pet1Name = StringTable.Get(Cfg.cfg_pet[petID1].Name)
    self._content = StringTable.Get(cfg.Content, pet1Name)
  elseif self._type == SecretMsgType.Double then
    local pet1Name = StringTable.Get(Cfg.cfg_pet[petID1].Name)
    local pet2Name = StringTable.Get(Cfg.cfg_pet[petID2].Name)
    self._content = StringTable.Get(cfg.Content, pet1Name, pet2Name)
  elseif self._type == SecretMsgType.DoubleSameRoom then
    local pet1Name = StringTable.Get(Cfg.cfg_pet[petID1].Name)
    local pet2Name = StringTable.Get(Cfg.cfg_pet[petID2].Name)
    self._content = StringTable.Get(cfg.Content, pet1Name, pet2Name)
  end
end

function HomeSecretMsg:Decode(tb)
  local id = tb[1]
  local pet1 = tb[2]
  local pet2 = tb[3]
  self:Init(id, pet1, pet2)
end

function HomeSecretMsg:Encode()
  local tb = {}
  if self._type == SecretMsgType.Single then
    tb[1] = self._id
    tb[2] = self._petID1
  elseif self._type == SecretMsgType.Double then
    tb[1] = self._id
    tb[2] = self._petID1
    tb[3] = self._petID2
  elseif self._type == SecretMsgType.DoubleSameRoom then
    tb[1] = self._id
    tb[2] = self._petID1
    tb[3] = self._petID2
  end
  return tb
end

function HomeSecretMsg:Content()
  return self._content
end

function HomeSecretMsg:ID()
  return self._id
end

function HomeSecretMsg:Equal(id, pet1, pet2)
  return self._id == id and self._petID1 == pet1 and self._petID2 == pet2
end

function HomeSecretMsg.Random(petsInDomitory, count, excluded)
  local list = {}
  for roomID, pets in pairs(petsInDomitory) do
    for _, petID in ipairs(pets) do
      if 0 < petID then
        local pet = Cfg.cfg_homeland_pet[petID]
        if pet == nil then
          BuildError("cfg_homeland_pet中缺少配置:", petID)
        end
        local msgs = pet.SecretMsg
        if msgs and 0 < #msgs then
          for __, msgInfo in ipairs(msgs) do
            local msgID = msgInfo[1]
            if list[msgID] == nil then
              list[msgID] = {}
            end
            local type = HomeSecretMsg.GetType(msgID)
            if type == SecretMsgType.Single then
              table.insert(list[msgID], petID)
            elseif type == SecretMsgType.Double then
              if list[msgID][1] == nil then
                list[msgID][1] = {}
              end
              if list[msgID][2] == nil then
                list[msgID][2] = {}
              end
              local group = msgInfo[2]
              if group then
                if group ~= 1 and group ~= 2 then
                  Log.exception("双人秘闻分组只能配1或2，星灵ID:", petID, "秘闻ID:", msgID)
                end
                table.insert(list[msgID][group], petID)
              else
                table.insert(list[msgID][1], petID)
                table.insert(list[msgID][2], petID)
              end
            elseif type == SecretMsgType.DoubleSameRoom then
              if list[msgID][roomID] == nil then
                list[msgID][roomID] = {}
              end
              if list[msgID][roomID][1] == nil then
                list[msgID][roomID][1] = {}
              end
              if list[msgID][roomID][2] == nil then
                list[msgID][roomID][2] = {}
              end
              local group = msgInfo[2]
              if group then
                if group ~= 1 and group ~= 2 then
                  Log.exception("双人秘闻分组只能配1或2，星灵ID:", petID, "秘闻ID:", msgID)
                end
                table.insert(list[msgID][roomID][group], petID)
              else
                table.insert(list[msgID][roomID][1], petID)
                table.insert(list[msgID][roomID][2], petID)
              end
            end
          end
        end
      end
    end
  end
  
  local function countExcept(tb, target)
    local count = 0
    for _, value in pairs(tb) do
      if value ~= target then
        count = count + 1
      end
    end
    return count
  end
  
  for msgID, data in pairs(list) do
    local type = HomeSecretMsg.GetType(msgID)
    local canTrigger = false
    if type == SecretMsgType.Single then
      canTrigger = true
    elseif type == SecretMsgType.Double then
      local group1 = data[1]
      local group2 = data[2]
      if #group1 == 0 or #group2 == 0 then
        canTrigger = false
      else
        for _, petID in ipairs(group1) do
          local count = countExcept(group2, petID)
          if 0 < count then
            canTrigger = true
            break
          end
        end
      end
    elseif type == SecretMsgType.DoubleSameRoom then
      for roomID, groups in pairs(data) do
        local group1 = groups[1]
        local group2 = groups[2]
        if #group1 == 0 or #group2 == 0 then
          canTrigger = false
        else
          for _, petID in ipairs(group1) do
            local count = countExcept(group2, petID)
            if 0 < count then
              canTrigger = true
              break
            end
          end
        end
        if canTrigger then
          break
        end
      end
    end
    if canTrigger and excluded then
      for _, msgInstance in ipairs(excluded) do
        if msgID == msgInstance:ID() then
          canTrigger = false
          break
        end
      end
    end
    if not canTrigger then
      list[msgID] = nil
    end
  end
  local elements = {}
  local idx = 1
  for msgID, data in pairs(list) do
    local weight = Cfg.cfg_homeland_pet_secret_msg[msgID].Weight
    elements[idx] = {msgID, weight}
    idx = idx + 1
  end
  HomeSecretMsg.RandomByWeight(elements)
  local count = math.min(count, #elements)
  local msgs = {}
  for i = 1, count do
    local msgID = elements[i][1]
    local type = HomeSecretMsg.GetType(msgID)
    local data = list[msgID]
    local msg = HomeSecretMsg:New()
    if type == SecretMsgType.Single then
      local petID = data[math.random(1, #data)]
      msg:Init(msgID, petID)
    elseif type == SecretMsgType.Double then
      local group1 = table.shuffle(data[1])
      local group2 = table.shuffle(data[2])
      local pet1, pet2
      for _, petID1 in ipairs(group1) do
        local found = false
        for __, petID2 in ipairs(group2) do
          if petID1 ~= petID2 then
            pet1 = petID1
            pet2 = petID2
            found = true
            break
          end
        end
        if found then
          break
        end
      end
      msg:Init(msgID, pet1, pet2)
    elseif type == SecretMsgType.DoubleSameRoom then
      local pet1, pet2
      for roomID, groups in pairs(data) do
        local found = false
        local group1 = groups[1]
        local group2 = groups[2]
        if 0 < #group1 and 0 < #group2 then
          table.shuffle(group1)
          table.shuffle(group2)
          for _, petID1 in ipairs(group1) do
            for __, petID2 in ipairs(group2) do
              if petID1 ~= petID2 then
                pet1 = petID1
                pet2 = petID2
                found = true
                break
              end
            end
            if found then
              break
            end
          end
        end
        if found then
          break
        end
      end
      msg:Init(msgID, pet1, pet2)
    end
    msgs[i] = msg
  end
  return msgs
end

function HomeSecretMsg.GetType(id)
  local cfg = Cfg.cfg_homeland_pet_secret_msg[id]
  if cfg == nil then
    BuildError("找不到秘闻配置:", id)
  end
  local type
  if cfg.Type == 1 then
    type = SecretMsgType.Single
  elseif cfg.Type == 2 then
    if cfg.SameRoom == true then
      type = SecretMsgType.DoubleSameRoom
    else
      type = SecretMsgType.Double
    end
  end
  return type
end

function HomeSecretMsg.RandomByWeight(elements)
  local total = #elements
  local totalWight = 0
  for _, item in ipairs(elements) do
    totalWight = totalWight + item[2]
  end
  local cur = 1
  while total >= cur do
    local r = math.random(1, totalWight)
    local tmp = 0
    local target = cur
    for i = cur, total - cur + 1 do
      tmp = tmp + elements[i][2]
      if r <= tmp then
        target = i
        break
      end
    end
    totalWight = totalWight - elements[target][2]
    if cur ~= target then
      local t = elements[cur]
      elements[cur] = elements[target]
      elements[target] = t
    end
    cur = cur + 1
  end
end
