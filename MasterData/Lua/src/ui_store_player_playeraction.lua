local this = {}

function this:req_modifyName(name, callback)
  local data = {name = name}
  L_Net:sendMessage(MsgGenCode.CSProtoChangeName, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self.data.baseInfo.name = name
      self:call(self.event.refreshBaseInfo)
      if callback then
        callback()
      end
    elseif errorCode == L_Const.errorCode.ErrCodeInvalidNick then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_idcard_4"))
    end
  end)
end

function this:req_modifySign(sign, callback)
  local data = {sign = sign}
  L_Net:sendMessage(MsgGenCode.CSProtoChangeSign, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self.data.baseInfo.sign = sign
      self:call(self.event.refreshBaseInfo)
      if callback then
        callback()
      end
    elseif errorCode == L_Const.errorCode.ErrCodeInvalidNick then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_idcard_4"))
    end
  end)
end

function this:req_modifyDisplayHero(hero, callback)
  local data = {hero = hero}
  L_Net:sendMessage(MsgGenCode.CSProtoChangeShowHero, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:modifyDisplayHero(hero)
      self:call(self.event.refreshBaseInfo)
      if callback then
        callback(errorCode)
      end
    end
  end)
end

function this:req_modifyDisplayPet(pets, callback)
  local data = {pet = pets}
  L_Net:sendMessage(MsgGenCode.CSProtoChangeShowPet, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:modifyDisplayPet(pets)
      self:call(self.event.refreshBaseInfo)
      if callback then
        callback(errorCode)
      end
    end
  end)
end

function this:req_CSProtoChangeBirthday(month, day, callback)
  local data = {month = month, day = day}
  L_Net:sendMessage(MsgGenCode.CSProtoChangeBirthday, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self.data.baseInfo.birthday = data
      self:call(self.event.refreshBaseInfo)
      if callback then
        callback(errorCode)
      end
    end
  end)
end

function this:req_buyStamina(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoBuyStamina, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData, errorCode)
    end
  end)
end

function this:req_getPlayerTitle(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoTitleGetList, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData, errorCode)
    end
  end)
end

function this:req_changePlayerTitle(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoTitleChange, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rspData, errorCode)
    end
  end)
end

function this:req_CSProtoWorldMapPlayerStatus(status, arg, callback)
  if status == L_Const.WorldMapPlayerStatusType.WMPST_MOUNT and not arg then
    arg = L_MountStore:getEquipMountId()
  end
  local data = {status = status, arg = arg}
  L_Net:sendMessage(MsgGenCode.CSProtoWorldMapPlayerStatus, data, function(rspData, errorCode)
    if callback then
      callback(rspData, errorCode)
    end
  end)
end

function this:req_syncPose(poseData, isSingle, callback)
  local data = {}
  if isSingle then
    data = {
      pose_id = poseData.poseId
    }
  else
    data = poseData
  end
end

function this:req_replyPose(isAccept, callback)
  local data = {
    u32 = isAccept == true and 1 or 0
  }
  L_Net:sendMessage(MsgGenCode.CSProtoWorldMapPoseReply, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_cancelPose(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoWorldMapPoseCancel, nil, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:req_playerCustomDataUp(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoPinchFaceDataUp, data, function(rsp, errcode)
    if callback ~= nil then
      callback(rsp, errcode)
    end
  end)
end

function this:req_SyncStamina()
  L_Net:sendMessage(MsgGenCode.CSProtoStaminaSync, nil, nil)
end

function this:req_skipGuide(isSkipGuide, callback)
  local data = {u32 = isSkipGuide}
  L_Net:sendMessage(MsgGenCode.CSProtoSkipGuide, data, function(rsp, errcode)
    if errcode == L_Const.errorCode.ErrCodeSucc and callback then
      callback()
    end
  end)
end

function this:rsp_syncPlayerInfo(data)
  local baseInfo = data.basic_info
  if not table.isEmpty(baseInfo) then
    self:refreshBaseInfo(baseInfo)
    table.merge(self.data.baseInfo, baseInfo)
  end
end

function this:rsp_syncPlayerMapInfo(sMapInfo, isSend, stopTransfer)
  local mapInfo = self:getPlayerMapInfo()
  self:syncMountStatus(sMapInfo)
  self:syncPlayerStatus(sMapInfo, isSend)
  if sMapInfo.pose_id then
    mapInfo.pose_id = sMapInfo.pose_id
    mapInfo.poseInfo = sMapInfo.poseInfo
  end
end

function this:syncMountStatus(nextMapInfo)
  local mapInfo = self:getPlayerMapInfo()
  local curMountStatus = mapInfo.mount_status
  local nextMountStatus = nextMapInfo.mount_status
  local curMountId = mapInfo.mount
  local nextMountId = nextMapInfo.mount
  if nextMountStatus ~= curMountStatus then
    mapInfo.mount_status = nextMountStatus
    if not math.isEmpty(curMountStatus) and curMountId == nextMountId then
      self:call(self.event.refreshMountStatus, nextMountStatus)
    end
    L_PlayerManager:refreshMountData()
  end
end

function this:syncPlayerStatus(nextMapInfo, isSend)
  local curMapInfo = self:getPlayerMapInfo()
  local curPlayerStatus = curMapInfo.status
  local nextPlayerStatus = nextMapInfo.status
  if nextPlayerStatus ~= curPlayerStatus then
    local mapMove
    if nextMapInfo.move then
      mapMove = nextMapInfo.move[#nextMapInfo.move]
    end
    local state = {
      cur = curPlayerStatus,
      next = nextPlayerStatus,
      move = mapMove,
      reason = nextMapInfo.reason
    }
    curMapInfo.status = nextPlayerStatus
    self:call(self.event.refreshPlayerStatus, state)
  end
end

function this:syncAttrInfo(attrInfo)
  for i = 0, attrInfo.Count - 1 do
    local attrId = attrInfo[i].attrId
    local attrValue = attrInfo[i].attrVal or 0
    local deadtime = attrInfo[i].deadtime
    local extraLimit = attrInfo[i].extraLimit
    local lastExp
    if attrId == L_Const.currencyType.accountExp then
      lastExp = self.data.baseInfo.exp
      self.data.baseInfo.exp = attrValue
    end
    local player_attr = self:getCurrency(attrId, true)
    player_attr.attr_val = attrValue
    player_attr.deadtime = deadtime or 0
    player_attr.extraLimit = extraLimit or 0
    if self:isElementCurrency(attrId) and player_attr.attr_val < self:getElementCurrencyMaxNum(attrId) then
      self:setShowElementCurrencyLimitFlag(attrId, false)
    end
    self:call(self.event.refreshAttr, player_attr)
    if lastExp ~= nil and lastExp ~= attrValue then
      self:refreshExpUpParam(lastExp)
      self:call(self.event.refreshBaseInfo)
    end
  end
  self:call(self.event.syncAttrInfoComplete)
  AzurWorld.RedDotMgr:MarkDirtyTree(L_ReddotManager.DotDef.HeroHead)
  self:initStaminaRecoverTimer()
end

function this:syncActAttrInfo(actAttrInfo)
  for i = 0, actAttrInfo.Count - 1 do
    local eventId = actAttrInfo[i].eventId
    local attrInfo = actAttrInfo[i].attr
    local attrId = attrInfo.attrId
    local attrValue = attrInfo.attrVal
    local deadtime = attrInfo.deadtime
    local extraLimit = attrInfo.extraLimit
    local player_attr = self:getActCurrency(eventId, attrId, true)
    player_attr.attr_val = attrValue or 0
    player_attr.deadtime = deadtime or 0
    player_attr.extraLimit = extraLimit or 0
  end
  self:call(self.event.syncActAttrInfoComplete)
end

function this:setShowElementCurrencyLimitFlag(itemId, flag)
  local player_attr = self:getCurrency(itemId)
  player_attr.hasShowLimit = flag
end

return this
