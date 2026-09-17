local this = class("mailStore", G_BaseStore)
this.event = {
  refreshMailInfo = "refreshMailInfo",
  readMail = "readMail",
  removedMail = "removedMail",
  receiveMail = "receiveMail",
  collectMail = "collectMail",
  refreshMailRedInfo = "refreshMailRedInfo"
}
this:importPartialClass(require(L_R.store .. "mail.mailState"))
this:importPartialClass(require(L_R.store .. "mail.mailAction"))

function this:rsp_syncMailInfo(data, bClear)
  if bClear then
    self.data.mailData = {}
  end
  local bDeletMail = false
  if data.dels then
    for i = 1, #data.dels do
      self:removeMail(data.dels[i])
      bDeletMail = true
    end
  end
  local mailData = data.mails
  if mailData then
    local temp = {}
    local parser = self:getArgsParser()
    for k, v in pairs(mailData) do
      local mail, isNew = self:getMail(v.guid)
      local argsDict, newContent = parser.getArgsDictByMailContent(v.content)
      mail.fetch = v.fetch
      mail.sender_id = v.sender_id
      mail.content = newContent
      mail.title = v.title
      mail.effecttm = v.effecttm
      mail.template_id = v.template_id
      mail.reward = v.reward
      mail.createtm = v.createtm
      mail.guid = v.guid
      mail.read = v.read
      mail.collect = v.collect
      mail.argsDict = argsDict or mail.argsDict
      mail.args = v.args
      if mail.template_id == 0 then
        mail.reward.rewards = L_CommonUtil.reverseList(mail.reward.rewards)
      end
      if isNew then
        self:checkMailTip(v.template_id)
        table.insert(temp, mail)
      end
    end
    if table.isEmpty(temp) then
      return
    end
    for i = 1, #self.data.mailData do
      table.insert(temp, self.data.mailData[i])
    end
    self.data.mailData = temp
    self:call(self.event.refreshMailInfo)
  end
  self:dealMailRedInfo()
  if bDeletMail then
    local mailCountMax = L_GameTpl:getGameConstTpl():getData("MAIL_LIMITS", L_Const.GameTplType.int)
    if L_UI:checkPageOpen("pageMail") and mailCountMax <= table.count(self.data.mailData) then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_new_mail"))
      L_UI:close("pageMail")
    end
  end
end

function this:checkMailTip(template_id)
  if not L_LoadingManager:isLoading() and template_id == L_GameConstTpl:getData("KIBO_ALL_BOX_FULL_MAIL", L_Const.GameTplType.int) then
    if AzurWorld.PetCatchManagerMgr:IsNestCoopPetCatch() then
      self.delayCheckPetGetTip = true
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_box_full_mail"))
      L_RewardManager:showBattlePage(nil, L_Const.FightRewardReason.FRR_Catch)
    end
  end
end

function this:delayCheckKiboMailTip()
  if self.delayCheckPetGetTip == true then
    self.delayCheckPetGetTip = false
    L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_kibo_box_full_mail"))
  end
end

function this:removeMail(guid)
  if self.data.mailData == nil then
    return
  end
  for i, v in pairs(self.data.mailData) do
    if v.guid == guid then
      table.remove(self.data.mailData, i)
      break
    end
  end
end

function this:rsp_syncMailRead(guid)
  local mail = self:getMail(guid)
  mail.read = true
  self:call(self.event.readMail, guid)
  self:dealMailRedInfo()
end

function this:rsp_syncMailReceive(data)
  for i = 1, #data do
    local mail = self:getMail(data[i])
    mail.fetch = true
    mail.read = true
  end
  self:call(self.event.receiveMail, data)
  self:dealMailRedInfo()
end

function this:rsp_synMailCollect(mailGuid)
  self:call(self.event.collectMail, mailGuid)
  self:dealMailRedInfo()
end

function this:rsp_syncMailRemove(data)
  if not data then
    return
  end
  for i = 1, #data do
    for k = #self.data.mailData, 1, -1 do
      if self.data.mailData[k] and data[i] == self.data.mailData[k].guid then
        table.remove(self.data.mailData, k)
      end
    end
  end
  self:call(self.event.removedMail, data)
  self:dealMailRedInfo()
end

function this:setCheckedMail(guid)
  self.checkedMail = guid
end

function this:dealMailRedInfo()
  self:call(self.event.refreshMailRedInfo)
  local now = L_TimeUtil.getServerTime()
  for _, mail in pairs(self.data.mailData) do
    if mail.effecttm ~= 0 then
      if self.data.mailRedTimers[mail.guid] then
        Timer.remove(self.data.mailRedTimers[mail.guid])
        self.data.mailRedTimers[mail.guid] = nil
      end
      local endTime = mail.effecttm + mail.createtm
      local leftTime = endTime - now
      if 0 < leftTime then
        self.data.mailRedTimers[mail.guid] = Timer.once(leftTime + 1, function()
          if self.data.mailRedTimers[mail.guid] then
            Timer.remove(self.data.mailRedTimers[mail.guid])
            self.data.mailRedTimers[mail.guid] = nil
          end
          self:call(self.event.refreshMailRedInfo)
        end, self)
      end
    end
  end
end

return this
