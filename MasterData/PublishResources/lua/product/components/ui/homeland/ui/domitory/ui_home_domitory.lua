_class("UIHomeDomitory", UIController)
UIHomeDomitory = UIHomeDomitory
local HomeSettleOperateType = {
  Add = 1,
  Remove = 2,
  Replace = 3,
  None = 0
}
_enum("HomeSettleOperateType", HomeSettleOperateType)

function UIHomeDomitory:LoadDataOnEnter(TT, res, uiParams)
  self._homeModule = self:GetModule(HomelandModule)
  self._petModule = self:GetModule(PetModule)
  self._domitoryData = self._homeModule:GetHomelandInfo().dormitory_info
  if table.count(self._domitoryData.list) == 0 then
    PopMsgBox("家园中没有建造宿舍")
    res:SetSucc(false)
    return
  end
  res:SetSucc(true)
end

function UIHomeDomitory:OnShow(uiParams)
  self:InitWidget()
  local topBtns = self.topBtn:SpawnObject("UIHomeCommonCloseBtn")
  topBtns:SetData(function()
    self:CloseDialog()
  end, nil, true)
  self._domitories = {}
  for i, domi in ipairs(self._domitoryData.list) do
    if domi.bBulid then
      table.insert(self._domitories, domi)
    end
  end
  table.sort(self._domitories, function(a, b)
    if a.buildTime == b.buildTime then
      return a.architectureID < b.architectureID
    end
    return a.buildTime < b.buildTime
  end)
  self:initSecretMsg()
  self._domitoryCount = #self._domitories
  if self._domitoryCount > 1 then
    self._indexers = self.indexer:SpawnObjects("UIHomeDomitoryIndexer", self._domitoryCount)
    self._lastBtn:SetActive(true)
    self._nextBtn:SetActive(true)
    self:AddUICustomEventListener(UICustomUIEventListener.Get(self._drag), UIEvent.BeginDrag, function(eventData)
      local pos = eventData.position
      local startPos = eventData.pressPosition
      if pos.x > startPos.x then
        self:lastOnClick()
      elseif pos.x < startPos.x then
        self:nextOnClick()
      end
    end)
  else
    self._lastBtn:SetActive(false)
    self._nextBtn:SetActive(false)
  end
  self._domitorySketch = UIDomitorySketch:New(self.sketchImage)
  self.member:SpawnObjects("UIHomeDomitoryMember", 4)
  self._members = self.member:GetAllSpawnList()
  local default = 1
  local pstid = uiParams[1]
  if pstid then
    local defaultRoom = self._homeModule:GetDomitoryByPstID(pstid)
    if defaultRoom then
      for index, value in ipairs(self._domitories) do
        if value.architectureID == defaultRoom.architectureID then
          default = index
          break
        end
      end
    else
      Log.exception("找不到对应的宿舍，建筑ID:", pstid)
    end
  end
  self:refreshDomitory(default)
  self:AttachEvent(GameEventType.UIPetFilterCardsOnSelect, self.onSelectSettlePet)
  self:AttachEvent(GameEventType.HomeDomitoryRefreshRoom, self.refreshCurDomitory)
end

function UIHomeDomitory:OnUpdate(dtMS)
  if self._domitorySketch then
    self._domitorySketch:Update(dtMS)
  end
end

function UIHomeDomitory:OnHide()
  if self._secretMsg then
    self._secretMsg:Dispose()
  end
  self._domitorySketch:Dispose()
end

function UIHomeDomitory:InitWidget()
  self.topBtn = self:GetUIComponent("UISelectObjectPath", "TopBtn")
  self.speed = self:GetUIComponent("UILocalizationText", "speed")
  self.domitoryName = self:GetUIComponent("UILocalizationText", "domitoryName")
  self.indexer = self:GetUIComponent("UISelectObjectPath", "Indexer")
  self.member = self:GetUIComponent("UISelectObjectPath", "Member")
  self.secretContent = self:GetUIComponent("UILocalizationText", "SecretContent")
  self.sketchImage = self:GetUIComponent("RawImage", "sketchImage")
  self._nextBtn = self:GetGameObject("next")
  self._lastBtn = self:GetGameObject("last")
  self._drag = self:GetGameObject("drag")
end

function UIHomeDomitory:initSecretMsg()
  local key = "HomeSecretMsg_" .. GameGlobal.GetModule(RoleModule):GetPstId()
  local data = LocalDB.GetString(key, "")
  local now = math.floor(self:GetModule(SvrTimeModule):GetServerTime() / 1000)
  local petsInDomitory = {}
  local petModule = self:GetModule(PetModule)
  for idx, domi in ipairs(self._domitories) do
    local pets = {}
    for petIdx, pstid in ipairs(domi.petList) do
      local petID = 0
      if 0 < pstid then
        petID = petModule:GetPet(pstid):GetTemplateID()
      end
      pets[petIdx] = petID
    end
    petsInDomitory[domi.index] = pets
  end
  local maxCount = Cfg.cfg_homeland_global.SecretMsgMaxCount.IntValue
  local msgs
  local needSave = false
  if string.isnullorempty(data) then
    msgs = HomeSecretMsg.Random(petsInDomitory, maxCount)
    needSave = true
    Log.debug("首次打开宿舍界面，随机秘闻")
  else
    local tb = string.totable(data)[1]
    local lastSaveTime = tb.Time
    if 86400 < now - lastSaveTime then
      Log.debug("秘闻随机时间超过一天，重新随机")
      msgs = HomeSecretMsg.Random(petsInDomitory, maxCount)
      needSave = true
    else
      local nextTime = self._domitoryData.next_refresh_story_time
      while now > nextTime do
        nextTime = nextTime + 86400
      end
      local lastRefreshTime = nextTime - 86400
      if lastSaveTime < lastRefreshTime and now > lastRefreshTime then
        Log.debug("秘闻随机时间跨越了刷新点，重新随机，上次保存时间:", lastSaveTime, "，上次刷新时间:", lastRefreshTime, "，当前服务器时间:", now)
        msgs = HomeSecretMsg.Random(petsInDomitory, maxCount)
        needSave = true
      else
        Log.debug("使用本地缓存秘闻，上次保存时间:", lastSaveTime, "，上次刷新时间:", lastRefreshTime, "，当前服务器时间:", now)
        local cacheMsg = {}
        for i, msg in ipairs(tb.Msgs) do
          if self:canTriggerMsg(msg) then
            table.insert(cacheMsg, msg)
          end
        end
        if next(cacheMsg) then
          local count = #cacheMsg
          if count == maxCount then
            Log.debug("使用本地缓存秘闻，不需要随机新的秘闻")
            msgs = {}
            for i, msg in ipairs(cacheMsg) do
              local instance = HomeSecretMsg:New()
              instance:Decode(msg)
              msgs[#msgs + 1] = instance
            end
            needSave = false
          elseif maxCount > count then
            local newCount = maxCount - count
            Log.debug("使用本地缓存秘闻，再重新随机", newCount, "条")
            local newMsgs = HomeSecretMsg.Random(petsInDomitory, newCount)
            msgs = {}
            for i, msg in ipairs(cacheMsg) do
              local instance = HomeSecretMsg:New()
              instance:Decode(msg)
              msgs[#msgs + 1] = instance
            end
            for _, msg in ipairs(newMsgs) do
              msgs[#msgs + 1] = msg
            end
            needSave = true
          else
            Log.debug("本地缓存的秘闻大于可触发的最大数量，丢弃多余的秘闻，缓存数量:", count, "，最大数量:", maxCount)
            msgs = {}
            for i = 1, maxCount do
              local instance = HomeSecretMsg:New()
              instance:Decode(cacheMsg[i])
              msgs[#msgs + 1] = instance
            end
            needSave = true
          end
        else
          Log.debug("本地秘闻没有可触发的了，重新随机")
          msgs = HomeSecretMsg.Random(petsInDomitory, maxCount)
          needSave = true
        end
      end
    end
  end
  if needSave then
    local tbs = {}
    for i, msg in ipairs(msgs) do
      tbs[#tbs + 1] = msg:Encode()
    end
    local saveData = {Time = now, Msgs = tbs}
    local data = table.tostring(saveData)
    LocalDB.SetString(key, data)
    Log.debug("保存秘闻：", data)
  end
  local msgsContent = {}
  for i, msg in ipairs(msgs) do
    msgsContent[i] = msg:Content()
  end
  self._secretMsgs = {}
  if 0 < #msgsContent then
    self._secretMsgs = table.shuffle(msgsContent)
    self._secretMsgIdx = 0
    self:_SwitchSecretMsg()
  else
    self.secretContent:SetText(StringTable.Get("str_homeland_domitory_secret_msg_empty"))
  end
end

function UIHomeDomitory:_SwitchSecretMsg()
  if #self._secretMsgs == 0 then
    return
  end
  self._secretMsgIdx = self._secretMsgIdx + 1
  if self._secretMsgIdx > #self._secretMsgs then
    self._secretMsgIdx = 1
  end
  self.secretContent:SetText(self._secretMsgs[self._secretMsgIdx])
end

function UIHomeDomitory:canTriggerMsg(tb)
  local msgID = tb[1]
  local pet1 = tb[2]
  local pet2 = tb[3]
  local cfg = Cfg.cfg_homeland_pet_secret_msg[msgID]
  if not cfg then
    Log.fatal("cfg_homeland_pet_secret_msg配置表中找不到本地缓存的秘闻:", msgID)
    return false
  end
  local type = HomeSecretMsg.GetType(msgID)
  local petModule = self:GetModule(PetModule)
  if type == SecretMsgType.Single then
    local pet = petModule:GetPetByTemplateId(pet1)
    if not pet then
      Log.error("HomeDomitory SecretMsg Error, Pet Not Exist." .. pet1)
      return false
    end
    local room = self._homeModule:GetPetSettledRoom(pet:GetPstID())
    return room ~= nil
  elseif type == SecretMsgType.Double then
    local petInstance1 = petModule:GetPetByTemplateId(pet1)
    local room1 = self._homeModule:GetPetSettledRoom(petInstance1:GetPstID())
    local petInstance2 = petModule:GetPetByTemplateId(pet2)
    local room2 = self._homeModule:GetPetSettledRoom(petInstance2:GetPstID())
    return room1 ~= nil and room2 ~= nil
  elseif type == SecretMsgType.DoubleSameRoom then
    local petInstance1 = petModule:GetPetByTemplateId(pet1)
    local room1 = self._homeModule:GetPetSettledRoom(petInstance1:GetPstID())
    local petInstance2 = petModule:GetPetByTemplateId(pet2)
    local room2 = self._homeModule:GetPetSettledRoom(petInstance2:GetPstID())
    return room1 ~= nil and room2 ~= nil and room1 == room2
  end
end

function UIHomeDomitory:refreshCurDomitory()
  self:refreshDomitory(self._domitoryIdx)
end

function UIHomeDomitory:refreshDomitory(idx)
  if self._domitoryIdx and self._indexers then
    self._indexers[self._domitoryIdx]:Select(false)
  end
  if idx > self._domitoryCount then
    self._domitoryIdx = 1
  elseif idx < 1 then
    self._domitoryIdx = self._domitoryCount
  else
    self._domitoryIdx = idx
  end
  if self._indexers then
    self._indexers[self._domitoryIdx]:Select(true)
  end
  local cur = self._domitories[self._domitoryIdx]
  
  local function onMemberClick(idx)
    self._curClickMemberIdx = idx
    local id = self._domitories[self._domitoryIdx].petList[idx]
    if id and id == 0 then
      id = nil
    end
    self:ShowDialog("UIHomeDomitorySettle", id)
  end
  
  local pets = {}
  for i = 1, 4 do
    local pstid = cur.petList[i]
    self._members[i]:SetData(pstid, i, onMemberClick)
    if 0 < pstid then
      pets[i] = self._petModule:GetPet(pstid)
    end
  end
  self._domitorySketch:OnChange(pets)
  self._domitorySketch:AllPetPlayAnimation("stand")
  if string.isnullorempty(cur.name) then
    self.domitoryName:SetText(StringTable.Get("str_homeland_domitory_default_name"))
  else
    self.domitoryName:SetText(cur.name)
  end
  self.speed:SetText(self._homeModule:GetRoomIntimacySpeed(self._domitories[self._domitoryIdx].index))
end

function UIHomeDomitory:desBtnOnClick(go)
  self:ShowDialog("UIHomeDomitoryAffinityRule")
end

function UIHomeDomitory:changeNameOnClick(go)
  self:ShowDialog("UIHomeDomitoryChangeName", self._domitories[self._domitoryIdx].index)
end

function UIHomeDomitory:lastOnClick(go)
  self:refreshDomitory(self._domitoryIdx - 1)
  self:_SwitchSecretMsg()
end

function UIHomeDomitory:nextOnClick(go)
  self:refreshDomitory(self._domitoryIdx + 1)
  self:_SwitchSecretMsg()
end

function UIHomeDomitory:onSelectSettlePet(pet, isRemove)
  if not self._curClickMemberIdx then
    Log.exception("严重错误，星灵索引未知")
    return
  end
  local pets = {}
  for idx, pstid in ipairs(self._domitories[self._domitoryIdx].petList) do
    pets[idx] = pstid
  end
  local selectPetID = pets[self._curClickMemberIdx]
  local operation = HomeSettleOperateType.None
  local oldPetID = 0
  local spPet, spDomitoryID, spDomitoryIdx
  if isRemove then
    if not selectPetID or selectPetID == 0 then
      Log.exception("当前房间中找不到要移除的星灵:", self._domitoryIdx, "，星灵:", pet:GetTemplateID(), "，星灵索引:", self._curClickMemberIdx)
      return
    end
    pets[self._curClickMemberIdx] = 0
    operation = HomeSettleOperateType.Remove
  else
    if selectPetID and selectPetID ~= 0 and selectPetID == pet:GetPstID() then
      Log.exception("当前星灵与选中星灵相同，不能替换:", self._domitoryIdx, "，星灵:", pet:GetTemplateID(), "，星灵索引:", self._curClickMemberIdx)
      return
    end
    if selectPetID and selectPetID ~= 0 then
      operation = HomeSettleOperateType.Replace
      oldPetID = selectPetID
    else
      operation = HomeSettleOperateType.Add
    end
    pets[self._curClickMemberIdx] = pet:GetPstID()
    spPet, spDomitoryID, spDomitoryIdx = self:GetSpPets(pet:GetPstID())
  end
  local data = {
    [self._domitories[self._domitoryIdx].index] = pets
  }
  if spPet and spPet ~= oldPetID then
    if self._domitories[self._domitoryIdx].index == spDomitoryID then
      data[spDomitoryID][spDomitoryIdx] = 0
    else
      local _pets = self._domitoryData.list[spDomitoryID].petList
      _pets[spDomitoryIdx] = 0
      data[spDomitoryID] = _pets
    end
  end
  Log.fatal("更新家园入住列表，本地索引:", self._domitoryIdx, "，房间索引:", self._domitories[self._domitoryIdx].index)
  if spPet == oldPetID then
    spPet = nil
  end
  self:StartTask(self._ChangeSettledPet, self, data, pet:GetPstID(), operation, oldPetID, spPet)
end

function UIHomeDomitory:GetSpPets(pstid)
  local petModule = GameGlobal.GetModule(PetModule)
  local pet = petModule:GetPet(pstid)
  local tid = pet:GetTemplateID()
  local allPets = {}
  local _allPets = {}
  for id, data in pairs(self._domitoryData.list) do
    local petList = data.petList
    for idx, _pstid in pairs(petList) do
      if _pstid and _pstid ~= 0 then
        table.insert(_allPets, _pstid)
      end
    end
  end
  if _allPets then
    for key, _pstid in pairs(_allPets) do
      local _pet = petModule:GetPet(_pstid)
      local _petid = _pet:GetTemplateID()
      table.insert(allPets, _petid)
    end
  end
  local have, spPet = HelperProxy:GetInstance():CheckBinderID(allPets, tid)
  if have then
    local _pstid = petModule:GetPetByTemplateId(spPet):GetPstID()
    local _id, _idx
    for id, map in pairs(self._domitories) do
      for idx, petPstID in pairs(map.petList) do
        if petPstID == _pstid then
          _id = map.index
          _idx = idx
          return _pstid, _id, _idx
        end
      end
    end
  end
end

function UIHomeDomitory:_ChangeSettledPet(TT, data, pstid, operation, oldPetID, spPet)
  self:Lock("RequestChangeSettlePet")
  local res = self._homeModule:DormitoryUpdatePet(TT, data)
  if res:GetSucc() then
    self._domitoryData = self._homeModule:GetHomelandInfo().dormitory_info
    self._domitories = {}
    for i, domi in ipairs(self._domitoryData.list) do
      if domi.bBulid then
        table.insert(self._domitories, domi)
      end
    end
    table.sort(self._domitories, function(a, b)
      if a.buildTime == b.buildTime then
        return a.architectureID < b.architectureID
      end
      return a.buildTime < b.buildTime
    end)
    self:refreshCurDomitory()
    if operation == HomeSettleOperateType.Add then
    elseif operation == HomeSettleOperateType.Replace then
    elseif operation == HomeSettleOperateType.Remove then
    end
    self:_UpdateHomelandPet(operation, pstid, oldPetID, spPet)
    self._domitorySketch:ResetStartBubble()
    self:ShowTips(pstid, spPet)
  else
    ToastManager.ShowHomeToast(res:GetResult())
  end
  self:UnLock("RequestChangeSettlePet")
end

function UIHomeDomitory:ShowTips(peta, petb)
  if peta and petb then
    local petModule = GameGlobal.GetModule(PetModule)
    local pet_a = petModule:GetPet(peta)
    local pet_b = petModule:GetPet(petb)
    local petName1 = StringTable.Get(pet_a:GetPetName())
    local petName2 = StringTable.Get(pet_b:GetPetName())
    local tips = StringTable.Get("str_homeland_domitory_sp_pet_tips", petName1, petName2)
    ToastManager.ShowHomeToast(tips)
  end
end

function UIHomeDomitory:_UpdateHomelandPet(operation, pstid, oldPstID, spPet)
  local uiHomelandModule = self._homeModule:GetUIModule()
  uiHomelandModule:GetClient():PetManager():UpdateDomitoryPet(operation, pstid, oldPstID, spPet)
end

function UIHomeDomitory:GetFirstMember()
  return self._members[1]:GetGameObject("area")
end
