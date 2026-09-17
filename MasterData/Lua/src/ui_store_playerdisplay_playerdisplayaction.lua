local this = {}

function this:req_setStandee(id, callback)
  local cur = self:getCurStandeeInfo()
  local data = {
    backboard = cur.backboard,
    baseboard = cur.baseboard,
    pet_accessory = cur.pet_accessory,
    role = table.clone(cur.role)
  }
  local type = self._playerCardDressTpl:getTplById(id).type
  if type == L_Const.playerDressType.backboard then
    data.backboard = id
  elseif type == L_Const.playerDressType.baseboard then
    data.baseboard = id
  elseif type == L_Const.playerDressType.hero then
    if data.role == nil then
      data.role = {}
    end
    data.role.config = id
    local item = self:getItem(id)
    data.role.url = item.url
  elseif type == L_Const.playerDressType.pet then
    data.pet_accessory = id
  end
  L_Net:sendMessage(MsgGenCode.CSProtoChangeStandPlates, data, function(rspData, errorCode)
    if errorCode == 0 and callback then
      if type == L_Const.playerDressType.backboard then
        cur.backboard = id
      elseif type == L_Const.playerDressType.baseboard then
        cur.baseboard = id
      elseif type == L_Const.playerDressType.hero then
        cur.role.config = id
        local item = self:getItem(id)
        cur.role.url = item.url
      elseif type == L_Const.playerDressType.pet then
        cur.pet_accessory = id
      end
      callback()
    end
  end)
end

function this:req_setStandeeAll(data, callback)
  local cur = self:getCurStandeeInfo()
  L_Net:sendMessage(MsgGenCode.CSProtoChangeStandPlates, data, function(rspData, errorCode)
    if errorCode == 0 and callback then
      cur.backboard = data.backboard
      cur.baseboard = data.baseboard
      cur.role.config = data.role.config
      cur.role.url = data.role.url
      cur.pet_accessory = data.pet_accessory
      callback()
    end
  end)
end

function this:req_setCustomHeroSlot(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoSetStandPlatesRole, data, function(rspData, errorCode)
    if errorCode == 0 and callback then
      callback()
    end
  end)
end

function this:req_setProfile(id, callback)
  local cur = self:getCurStandeeInfo()
  local data = {profile = id}
  L_Net:sendMessage(MsgGenCode.CSProtoChangeStandPlates, data, function(rspData, errorCode)
    if errorCode == 0 and callback then
      cur.profile = id
      callback()
    end
  end)
end

function this:req_setProfileFrame(id, callback)
  local cur = self:getCurStandeeInfo()
  local data = {profile_frame = id}
  L_Net:sendMessage(MsgGenCode.CSProtoChangeStandPlates, data, function(rspData, errorCode)
    if errorCode == 0 and callback then
      cur.profile_frame = id
      callback()
    end
  end)
end

function this:rsp_syncPlayerDisplayItem(data)
  if data.bags ~= nil then
    for _, v in pairs(data.bags) do
      local id = v.config
      local tpl = self._playerCardDressTpl:getTplById(id)
      if self.data.setHasInitSync then
        if tpl.type ~= L_Const.playerDressType.head and tpl.type ~= L_Const.playerDressType.headFrame then
          if not self:getItem(id) then
            L_ReddotManager:markNew(L_ReddotManager.DotDef.PlayerDressItem, id, true)
          end
        elseif not self:getItem(id) then
          L_ReddotManager:markNew(L_ReddotManager.DotDef.PlayerHeadItem, id)
        end
      end
      local url = v.url
      local item = self:getItem(id, true)
      if item and tpl then
        item.id = id
        item.url = url
        item.tpl = tpl
      end
      if self.data.setHasInitSync then
        self:call(self.event.dressItemSync, id)
      end
    end
    self:fillEmptyCustom()
    self.data.setHasInitSync = true
  else
    self:clear()
  end
end

function this:req_setPlayerCardShowType(type)
  local data = {u32 = type}
  L_Net:sendMessage(MsgGenCode.CSProtoChangeShowcaseType, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
    end
  end)
end

function this:req_setPlayerCardSituationId(id, callback)
  local data = {u32 = id}
  L_Net:sendMessage(MsgGenCode.CSProtoChangeShowcaseId, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
    elseif callback then
      callback()
    end
  end)
end

return this
