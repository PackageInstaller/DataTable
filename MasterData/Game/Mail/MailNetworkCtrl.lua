local MailNetworkCtrl = class("MailNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function MailNetworkCtrl:ctor()
  self.favoriteDic = {}
  self.__mainInitBuff = {}
end

function MailNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Notify, self, proto_csmsg.SC_MAIL_Notify, self.SC_MAIL_Notify)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Fetch, self, proto_csmsg.SC_MAIL_Fetch, self.SC_MAIL_Fetch)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Read, self, proto_csmsg.SC_MAIL_Read, self.SC_MAIL_Read)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Favorite, self, proto_csmsg.SC_MAIL_Favorite, self.SC_MAIL_Favorite)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_ReceiveAttachment, self, proto_csmsg.SC_MAIL_ReceiveAttachment, self.SC_MAIL_ReceiveAttachment)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Delete, self, proto_csmsg.SC_MAIL_Delete, self.SC_MAIL_Delete)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_OneClickPickUp, self, proto_csmsg.SC_MAIL_OneClickPickUp, self.SC_MAIL_OneClickPickUp)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_SyncUpdateDiff, self, proto_csmsg.SC_MAIL_SyncUpdateDiff, self.MailCommonDiff)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_OneKeyDelete, self, proto_csmsg.SC_MAIL_OneKeyDelete, self.SC_MAIL_OneKeyDelete)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_MAIL_Detail_Batch, self, proto_csmsg.SC_MAIL_Detail_Batch, self.SC_MAIL_Detail_Batch)
end

function MailNetworkCtrl:MailCommonDiff(diffMsg)
  ControllerManager:GetController(ControllerTypeId.Mail, true):RecvUpdateDiff(diffMsg.update, diffMsg.delete)
end

function MailNetworkCtrl:SC_MAIL_Notify()
  ControllerManager:GetController(ControllerTypeId.Mail, true):HasMailNotify()
end

local waitNtework = false

function MailNetworkCtrl:CS_MAIL_Fetch(waitRev, callback)
  local msg = {}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_Fetch, proto_csmsg.CS_MAIL_Fetch, msg)
  if waitRev == nil or waitRev == true then
    waitNtework = true
    cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Fetch, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_Fetch)
  end
end

function MailNetworkCtrl:SC_MAIL_Fetch(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if waitNtework then
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Fetch)
    end
    local err = "SC_MAIL_Fetch error,code:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
  else
    ControllerManager:GetController(ControllerTypeId.Mail, true):RecvMailFetch()
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

function MailNetworkCtrl:CS_MAIL_Favorite(uid, favorite, callback)
  self.favoriteDic.mailUid = uid
  self.favoriteDic.favorite = favorite
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_Favorite, proto_csmsg.CS_MAIL_Favorite, self.favoriteDic)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Favorite, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_Favorite)
end

function MailNetworkCtrl:SC_MAIL_Favorite(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_MAIL_Favorite error,code:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Favorite)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

function MailNetworkCtrl:CS_MAIL_Read(uid, callback)
  local msg = {}
  msg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_Read, proto_csmsg.CS_MAIL_Read, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Read, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_Read)
end

function MailNetworkCtrl:SC_MAIL_Read(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_MAIL_Read error,code:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Read)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

function MailNetworkCtrl:CS_MAIL_ReceiveAttachment(uid, callback)
  local msg = {}
  msg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_ReceiveAttachment, proto_csmsg.CS_MAIL_ReceiveAttachment, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_ReceiveAttachment, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_ReceiveAttachment)
end

function MailNetworkCtrl:SC_MAIL_ReceiveAttachment(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.BACKPACK_ITEM_OVERFLOW then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ResourceOverflow))
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_ReceiveAttachment)
      return
    end
    self.currUid = nil
    local err = "SC_MAIL_ReceiveAttachment error,code:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_ReceiveAttachment)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    local syncUpdateDiff = msg.syncUpdateDiff
    if syncUpdateDiff ~= nil and syncUpdateDiff.mail ~= nil and syncUpdateDiff.mail.update ~= nil then
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_MAIL_ReceiveAttachment, syncUpdateDiff.mail.update)
    end
  end
end

function MailNetworkCtrl:CS_MAIL_Delete(uid, callback)
  local msg = {}
  msg.uid = uid
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_Delete, proto_csmsg.CS_MAIL_Delete, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Delete, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_Delete)
end

function MailNetworkCtrl:SC_MAIL_Delete(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    self.currUid = nil
    local err = "SC_MAIL_ReceiveAttachment error,code:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_Delete)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

function MailNetworkCtrl:CS_MAIL_OneClickPickUp(callback)
  local msg = {}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneClickPickUp, proto_csmsg.CS_MAIL_OneClickPickUp, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneClickPickUp, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_OneClickPickUp)
end

function MailNetworkCtrl:SC_MAIL_OneClickPickUp(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    if msg.ret == proto_csmsg_ErrorCode.MAIL_NOT_NEED_ONECLICK_PICKUP then
      CS.MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.ResourceOverflow))
      cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneClickPickUp)
      return
    end
    local err = "SC_MAIL_OneClickPickUp error,code:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneClickPickUp)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
    local syncUpdateDiff = msg.syncUpdateDiff
    if syncUpdateDiff ~= nil and syncUpdateDiff.mail ~= nil and syncUpdateDiff.mail.update ~= nil then
      cs_WaitNetworkResponse:AddWaitData(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneClickPickUp, syncUpdateDiff.mail.update)
    end
  end
end

function MailNetworkCtrl:CS_MAIL_OneKeyDelete(callback)
  local msg = {}
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneKeyDelete, proto_csmsg.CS_MAIL_OneKeyDelete, msg)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneKeyDelete, callback, proto_csmsg_MSG_ID.MSG_SC_MAIL_OneKeyDelete)
end

function MailNetworkCtrl:SC_MAIL_OneKeyDelete(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_MAIL_OneKeyDelete error,code:" .. tostring(msg.ret)
    if isGameDev then
      CS.MessageCommon.ShowMessageTips(err)
    end
    error(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_MAIL_OneKeyDelete)
  else
    NetworkManager:HandleDiff(msg.syncUpdateDiff)
  end
end

function MailNetworkCtrl:CS_MAIL_Detail_Batch(callback)
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_MAIL_Detail_Batch, proto_csmsg.CS_MAIL_Detail_Batch, table.emptytable)
  cs_WaitNetworkResponse:StartWait(eCustomWaitType.CustomWaitMailBath, callback, eCustomWaitType.WaitAthDetailBatch)
end

function MailNetworkCtrl:SC_MAIL_Detail_Batch(msg)
  local data = msg.data
  local count = msg.total
  if self.__mainInitBuff.data == nil then
    self.__mainInitBuff.data = data
    self.__mainInitBuff.curCount = table.count(data)
  else
    for key, value in pairs(data) do
      self.__mainInitBuff.data[key] = value
      self.__mainInitBuff.curCount = self.__mainInitBuff.curCount + 1
    end
  end
  if count <= self.__mainInitBuff.curCount then
    if count < self.__mainInitBuff.curCount then
      error("mail init num illegal")
    end
    cs_WaitNetworkResponse:AddWaitData(eCustomWaitType.CustomWaitMailBath, self.__mainInitBuff.data)
    cs_WaitNetworkResponse:WaitComplete(eCustomWaitType.CustomWaitMailBath)
    self.__mainInitBuff = {}
  end
end

function MailNetworkCtrl:Reset()
  self.currUid = 0
end

return MailNetworkCtrl
