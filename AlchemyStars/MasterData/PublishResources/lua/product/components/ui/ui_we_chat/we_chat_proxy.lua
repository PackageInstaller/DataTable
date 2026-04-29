_class("WeChatProxy", Object)
WeChatProxy = WeChatProxy

function WeChatProxy:Constructor(module)
  self.module = module
  self.stateMachine = WeChatStateMachine:New()
  self.localStorage = WeChatLocalStorage:New(self)
  self.roles = {}
  
  local function comparer(a, b)
    if a._heap_index > b._heap_index then
      return 1
    else
      return -1
    end
  end
  
  self.waitQueue = {}
  self.isConstructor = true
  self:AddListener()
end

function WeChatProxy:IsConstructor()
  return self.isConstructor
end

function WeChatProxy:SetIsConstructor(isConstructor)
  self.isConstructor = isConstructor
end

function WeChatProxy:InitLocalSpeaker(speakerId, pstId, serverSpeakerData)
  if self.localStorage then
    return self.localStorage:InitLocalSpeaker(speakerId, pstId, serverSpeakerData)
  else
    return 0
  end
end

function WeChatProxy:InitAllLocalSpeaker(pstId)
  if self.localStorage then
    return self.localStorage:InitAllLocalSpeaker(pstId)
  else
    return 0
  end
end

function WeChatProxy:SaveLocalSpeaker(speakerId, chats)
  if self.localStorage then
    self.localStorage:SaveLocalSpeaker(speakerId, chats)
  end
end

function WeChatProxy:SaveSpeakerLastTime(speakerId, time)
  if self.localStorage then
    self.localStorage:SaveSpeakerLastTime(speakerId, time)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatUpdateLastTime, speakerId)
  end
end

function WeChatProxy:GetSpeakerLastTime(speakerId)
  return self.localStorage and self.localStorage:GetSpeakerLastTime(speakerId) or 0
end

function WeChatProxy:Dispose()
  if self.stateMachine then
    self.stateMachine:Dispose()
    self.stateMachine = nil
  end
  self:RemoveListener()
  self.roles = {}
  self:ResetWaitQueue()
end

function WeChatProxy:AddListener()
  self._onWeChatWaitEndState = GameHelper:GetInstance():CreateCallback(self.OnWeChatWaitEndState, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.WeChatWaitEndState, self._onWeChatWaitEndState)
end

function WeChatProxy:RemoveListener()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.WeChatWaitEndState, self._onWeChatWaitEndState)
  self._onWeChatWaitEndState = nil
end

function WeChatProxy:OnWeChatWaitEndState(data)
  self:SendTalkReaded(data.speakerId, data.chatId, data.talkId, data.triggerIndex)
end

function WeChatProxy:GetCurStateType()
  return self.stateMachine:GetCurStateType()
end

function WeChatProxy:ChangeState(stateType, ...)
  self.stateMachine:ChangeState(stateType, ...)
end

function WeChatProxy:ForceChangeState(stateType, ...)
  self.stateMachine:ForceChangeState(stateType, ...)
end

function WeChatProxy:GetSortedGroup()
  local groups = {}
  for key, value in pairs(self.roles) do
    local petid = value:GetSpeakerId()
    local cfg_pet = Cfg.cfg_pet[petid]
    local ketid
    if cfg_pet then
      local binderID = cfg_pet.BinderPetID
      if binderID then
        ketid = binderID
      else
        ketid = petid
      end
    else
      ketid = petid
    end
    if not groups[ketid] then
      groups[ketid] = DWeChatRoleGroup:New()
    end
    value:SetGroupID(ketid)
    groups[ketid]:AddRole(value)
  end
  for key, value in pairs(groups) do
    if value:RoleCount() > 1 then
      local roleList = value:RoleList()
      table.sort(roleList, function(a, b)
        local petid_a = a:GetSpeakerId()
        local petid_b = b:GetSpeakerId()
        local cfg_a = Cfg.cfg_pet[petid_a]
        local cfg_b = Cfg.cfg_pet[petid_b]
        local binderPetIdx_a = cfg_a.BinderIndex
        local binderPetIdx_b = cfg_b.BinderIndex
        return binderPetIdx_a < binderPetIdx_b
      end)
    end
  end
  return self:SortGroup(groups)
end

function WeChatProxy:SortGroup(groups)
  local array = table.toArray(groups)
  table.sort(array, function(a, b)
    local list_a = a:RoleList()
    local list_b = b:RoleList()
    local weight_a = 0
    local weight_b = 0
    for _, value in pairs(list_a) do
      local chats = value:GetChats()
      local lastChat = chats[#chats]
      if lastChat then
        local talks = lastChat.talks
        local lastTalk = talks[#talks]
        if lastTalk then
          local isEnd = lastTalk.isEnd
          if not isEnd then
            weight_a = weight_a + 1000
            break
          else
            local readed = lastTalk.readed
            if not readed then
              weight_a = weight_b + 1000
            end
          end
        end
      end
    end
    for _, value in pairs(list_b) do
      local chats = value:GetChats()
      local lastChat = chats[#chats]
      if lastChat then
        local talks = lastChat.talks
        local lastTalk = talks[#talks]
        if lastTalk then
          local isEnd = lastTalk.isEnd
          if not isEnd then
            weight_b = weight_b + 1000
            break
          else
            local readed = lastTalk.readed
            if not readed then
              weight_b = weight_b + 1000
            end
          end
        end
      end
    end
    local time_a
    if 1 < #list_a then
      local tmp_time_a
      for i = 1, #list_a do
        local tmp_a = self:GetSpeakerLastTime(list_a[i]:GetSpeakerId())
        if not tmp_time_a then
          tmp_time_a = tmp_a
        elseif tmp_a > tmp_time_a then
          tmp_time_a = tmp_a
        end
      end
      time_a = tmp_time_a
    else
      time_a = self:GetSpeakerLastTime(list_a[1]:GetSpeakerId())
    end
    local time_b
    if 1 < #list_b then
      local tmp_time_b
      for i = 1, #list_b do
        local tmp_b = self:GetSpeakerLastTime(list_b[i]:GetSpeakerId())
        if not tmp_time_b then
          tmp_time_b = tmp_b
        elseif tmp_b > tmp_time_b then
          tmp_time_b = tmp_b
        end
      end
      time_b = tmp_time_b
    else
      time_b = self:GetSpeakerLastTime(list_b[1]:GetSpeakerId())
    end
    if time_a > time_b then
      weight_a = weight_a + 100
    else
      weight_b = weight_b + 100
    end
    return weight_a > weight_b
  end)
  return array
end

function WeChatProxy:GetRoles()
  local array = table.toArray(self.roles)
  table.sort(array, function(a, b)
    return self:GetSpeakerLastTime(a:GetSpeakerId()) > self:GetSpeakerLastTime(b:GetSpeakerId())
  end)
  return array
end

function WeChatProxy:GetFirstSpeakerId()
  local roles = self:GetRoles()
  if roles and table.count(roles) > 0 then
    local role = roles[1]
    local speakerid = roles[1]:GetSpeakerId()
    local cfg_pet = Cfg.cfg_pet[speakerid]
    local gid
    local sid = speakerid
    if cfg_pet and cfg_pet.BinderPetID then
      gid = cfg_pet.BinderPetID
    else
      gid = speakerid
    end
    return gid, speakerid
  end
end

function WeChatProxy:GetRole(speakerId)
  return self.roles[speakerId]
end

function WeChatProxy:GetTalks(speakerId)
  return self.roles[speakerId] and self.roles[speakerId]:GetTalks() or {}
end

function WeChatProxy:GetTalk(speakerId, chatId, talkId, triggerIndex)
  return self.roles[speakerId] and self.roles[speakerId]:GetTalk(chatId, talkId, triggerIndex) or {}
end

function WeChatProxy:UpdateRole(speakerId, serverChatData, fromStorage)
  local role = self:GetRole(speakerId)
  if not role then
    if Cfg.cfg_quest_chat_speaker[speakerId] then
      self:AddRole(speakerId, serverChatData, fromStorage)
    end
  else
    role:Decode(serverChatData.m_vecChatData, fromStorage)
  end
end

function WeChatProxy:AddRole(speakerId, serverChatDatas, fromStorage)
  if speakerId == 1502101 then
    local a = 1
  end
  if not self.roles[speakerId] then
    self.roles[speakerId] = DWeChatRole:New(serverChatDatas, self, fromStorage)
    if not fromStorage then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatUpdateRole, speakerId)
      self:SaveSpeakerLastTime(speakerId, os.time())
    end
  end
end

function WeChatProxy:UpdateChat(speakerId, serverChatData)
  local role = self:GetRole(speakerId)
  if role then
    role:UpdateChat(serverChatData)
  end
end

function WeChatProxy:AddChat(speakerId, serverChatData)
  local role = self:GetRole(speakerId)
  if role then
    self:SaveSpeakerLastTime(speakerId, os.time())
    self._saveRole = role
    self._saveSpeakerId = speakerId
    self._serverChatData = serverChatData
    local waitTime = 0
    if GameGlobal.UIStateManager():IsShow("UIWeChatController") then
      waitTime = 5000
    end
    if self._event then
      GameGlobal.Timer():CancelEvent(self._event)
      self._event = nil
    end
    self._event = GameGlobal.Timer():AddEvent(waitTime, function()
      self:UpdateSaveData()
    end)
  end
end

function WeChatProxy:CancelSaveData()
  self:UpdateSaveData()
  if self._event then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function WeChatProxy:UpdateSaveData()
  if self._saveRole and self._saveSpeakerId and self._serverChatData then
    self._saveRole:UpdateChat(self._serverChatData)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatWaitState, {
      speakerId = self._saveSpeakerId
    })
    if self.curSpeakerId == self._saveSpeakerId then
      local chatId = self._serverChatData.m_nChatID
      local triggerIndex = self._serverChatData.m_nCount
      for _, serverTalkData in ipairs(self._serverChatData.m_vecTalkData) do
        self:UpdateTalkState(self._saveSpeakerId, chatId, triggerIndex, serverTalkData, true)
      end
    end
    self._saveRole = nil
    self._saveSpeakerId = nil
    self._serverChatData = nil
  end
end

function WeChatProxy:AddTalk(speakerId, chatId, status, triggerIndex, serverTalkData, needWait)
  if self.roles[speakerId] then
    self.roles[speakerId]:AddTalk(chatId, triggerIndex, serverTalkData, true)
    local serverChatData = {}
    serverChatData.m_nStatus = status
    serverChatData.m_nCount = triggerIndex
    self.roles[speakerId]:UpdateChatState(chatId, serverChatData)
    self:UpdateTalkState(speakerId, chatId, triggerIndex, serverTalkData, needWait)
  end
end

function WeChatProxy:StopTimer()
  if self.timer then
    GameGlobal.Timer():CancelEvent(self.timer)
    self.timer = nil
  end
end

function WeChatProxy:UpdateTalkState(speakerId, chatId, triggerIndex, serverTalkData, needWait)
  local data = {}
  data.speakerId = speakerId
  data.chatId = chatId
  data.talkId = serverTalkData.m_nTalkID
  data.triggerIndex = triggerIndex
  if needWait then
    local cfg = Cfg.cfg_quest_talk[serverTalkData.m_nTalkID]
    if cfg.IsMainActorWord == 1 then
      self:SetInitState(speakerId)
    else
      table.insert(self.waitQueue, data)
      if self:GetCurStateType() == WeChatState.AddAnswer then
        self:ChangeState(WeChatState.Wait, data)
      else
        self:ChangeState(WeChatState.Wait, data)
      end
    end
  else
    self:ChangeState(WeChatState.AddAnswer, data)
  end
end

function WeChatProxy:SetTalkReaded(speakerId, chatId, talkId, triggerIndex)
  local role = self:GetRole(speakerId)
  if role then
    role:SetTalkReaded(chatId, talkId, triggerIndex)
  end
end

function WeChatProxy:ResetWaitQueue()
  self:StopTimer()
  self.waitQueue = {}
end

function WeChatProxy:GetLastTalk(speakerId)
  if self.roles[speakerId] then
    return self.roles[speakerId]:GetLastTalk()
  end
  return nil
end

function WeChatProxy:SetInitState(speakerId, force)
  self.curSpeakerId = speakerId
  self:ResetWaitQueue()
  local talk = self:GetLastTalk(speakerId)
  local role = self:GetRole(speakerId)
  if talk and talk.options then
    self:ForceChangeState(WeChatState.Reply, speakerId)
  else
    self:ForceChangeState(WeChatState.Normal, speakerId)
  end
end

function WeChatProxy:Reply(speakerId, index)
  local talk = self:GetLastTalk(speakerId)
  if not talk.options then
    return
  end
  local option = talk.options[index]
  TaskManager:GetInstance():StartTask(function(TT)
    GameGlobal.UIStateManager():Lock("WeChatProxy:Reply")
    local result = self.module:Request_UpdateChatAnswer(TT, speakerId, talk.chatId, talk.talkId, option.talkId)
    if result:GetSucc() then
    end
    GameGlobal.UIStateManager():UnLock("WeChatProxy:Reply")
  end)
end

function WeChatProxy:SendTalkReaded(speakerId, chatId, talkId, triggerIndex, onlySend, noCheck)
  local send = false
  if not noCheck then
    if talkId then
      local talk = self:GetTalk(speakerId, chatId, talkId, triggerIndex)
      if talk.talkType == WeChatTalkType.Start then
      elseif talk.talkType == WeChatTalkType.Voice then
      elseif talk.readed == false then
        send = true
      end
    end
  else
    send = true
  end
  if send then
    TaskManager:GetInstance():StartTask(function(TT)
      local result = self.module:Request_SetTalkReaded(TT, speakerId, chatId, talkId, triggerIndex)
      if result:GetSucc() then
        if not onlySend and self.curSpeakerId == speakerId then
          table.remove(self.waitQueue, 1)
          local nextData = self.waitQueue[1]
          if nextData then
            self:ForceChangeState(WeChatState.Wait, nextData)
          else
            self:SetInitState(speakerId)
          end
        else
          GameGlobal.EventDispatcher():Dispatch(GameEventType.WeChatReaded, speakerId, chatId, talkId, triggerIndex)
        end
      end
    end)
  end
end

function WeChatProxy:SendAllTalkReaded(speakerId)
  local role = self:GetRole(speakerId)
  if role then
    local talks = role:GetTalks()
    for index, talk in ipairs(talks) do
      self:SendTalkReaded(speakerId, talk.chatId, talk.talkId, talk.triggerIndex, true)
    end
  end
end

function WeChatProxy:SendAndCheckTalkReaded(speakerId)
end

function WeChatProxy:SendSpeakerHistory(speakerId)
  return TaskManager:GetInstance():StartTask(function(TT)
    local result = self.module:Request_SpeakerHistory(TT, speakerId)
    if result:GetSucc() then
    end
  end)
end

function WeChatProxy:SendSpeakerAllHistory()
  return TaskManager:GetInstance():StartTask(function(TT)
    local result = self.module:Request_AllHistory(TT)
    if result:GetSucc() then
    end
  end)
end

function WeChatProxy:HasRed()
  for index, role in pairs(self.roles) do
    if role:HasRed() then
      return true
    end
  end
  return false
end

function WeChatProxy:GetUnReadCount()
  local maxCount = 0
  for index, role in pairs(self.roles) do
    local count = role:GetUnReadCount()
    maxCount = maxCount + count
  end
  return maxCount
end

function WeChatProxy:GetUnReadChats()
  local tbl = {}
  for index, role in pairs(self.roles) do
    local chats = role:GetUnReadChats()
    table.appendArray(tbl, chats)
  end
  return tbl
end

function WeChatProxy:_DoEscape(strContent)
  if string.isnullorempty(self.roleName) then
    self.roleName = GameGlobal.GetModule(RoleModule):GetName()
  end
  strContent = string.gsub(strContent, "PlayerName", self.roleName)
  return strContent
end

function WeChatProxy:GetRandomUnReadChats()
  local chats = self:GetUnReadChats()
  local txtChats = {}
  for index, chatId in ipairs(chats) do
    local tipWord = Cfg.cfg_quest_chat[chatId].TipWord
    if tipWord then
      local chat = Cfg.cfg_quest_chat[chatId]
      if chat then
        local speakerId = chat.SpeakerID
        if speakerId then
          local cfg_quest_chat_speaker = Cfg.cfg_quest_chat_speaker[speakerId]
          if not cfg_quest_chat_speaker then
            Log.fatal("###[WeChatProxy] cfg_quest_chat_speaker is nil ! id --> ", speakerId)
            return
          end
          local picName
          if cfg_quest_chat_speaker.SpeakerType == 1 and cfg_quest_chat_speaker.TemplateID and cfg_quest_chat_speaker.TemplateID ~= 0 then
            local petid = cfg_quest_chat_speaker.TemplateID
            local petModule = GameGlobal.GetModule(PetModule)
            local matchPet = petModule:GetPetByTemplateId(petid)
            if matchPet then
              picName = matchPet:GetPetVideo(PetSkinEffectPath.HEAD_ICON_WE_CHAT)
            end
          end
          picName = picName or HelperProxy:GetInstance():GetPetVideo(speakerId, 0, 0, PetSkinEffectPath.HEAD_ICON_WE_CHAT)
          table.insert(txtChats, picName)
        end
      end
    end
  end
  local randomChats = {}
  if 3 < #txtChats then
    local tb = {}
    math.randomseed(os.time())
    local rand = math.random
    for i = 1, 6 do
      local x = rand(1, 10)
      tb[i] = x
    end
    table.remove(tb, 1)
    local ran
    for index, value in ipairs(tb) do
      table.insert(randomChats, txtChats[value])
    end
  else
    randomChats = txtChats
  end
  return randomChats
end

function WeChatProxy:IsChatInHistory(nSpeakerID, nChatID)
  local role = self.roles[nSpeakerID]
  if nil == role then
    return false
  end
  local chats = role:GetChats()
  for key, value in pairs(chats) do
    if value.chatId == nChatID then
      if value.state then
        if value.state >= QuestChatStatus.E_ChatState_Completed and value.state <= QuestChatStatus.E_ChatState_Taken then
          return true
        end
      else
        return false
      end
    end
  end
  return false
end

function WeChatProxy:UpdateRoleName(speakerId, name)
  local role = self:GetRole(speakerId)
  if role then
    role:UpdateName(name)
  end
end

function WeChatProxy:EndCurWaitStat()
  if WeChatState.Wait ~= self:GetCurStateType() then
    return
  end
  local waitData = self.waitQueue[1]
  self:ChangeState(WeChatState.WaitEnd, waitData)
  table.remove(self.waitQueue, 1)
end
