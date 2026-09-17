local this = {}
local pamiTalkLetterTextTpl = L_GameTpl:getPamiLetterTextTpl()
local pamiTalkReplyTpl = L_GameTpl:getPamiLetterReplyTpl()

function this:req_chooseReply(letterTextId, replyId, callback)
  local data = {text_id = letterTextId, reply_id = replyId}
  L_Net:sendMessage(MsgGenCode.CSProtoPamiMailChoose, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local tpl = pamiTalkLetterTextTpl:getTplById(letterTextId)
      local letterId = pamiTalkLetterTextTpl:getLetterId(tpl)
      local letter = L_PamiTalkManager:getLetterServerData(letterId)
      if not letter then
        return
      end
      if not letter.reply then
        letter.reply = {}
      end
      local replyTpl = pamiTalkReplyTpl:getTplById(replyId)
      local textId = pamiTalkReplyTpl:getTextId(replyTpl)
      if not math.isEmpty(textId) then
        L_PamiTalkManager:setReplyTimer(textId)
      end
      letter.latest_read = false
      table.insert(letter.reply, {
        record = replyId,
        text_id = textId,
        timestamp = L_TimeUtil.getServerTime()
      })
      local talkSequence = L_PamiTalkManager:getLetterTalks(letterId)
      local addMsg = {
        letterId = letterId,
        letterTextId = replyId,
        textType = L_PamiTalkManager.pamiTalkTextType.Reply
      }
      table.insert(talkSequence, addMsg)
      L_PamiTalkManager:updateOneLetterRedInfo(letter)
      if callback then
        callback()
      end
      self:call(self.event.refreshLetter, {addMsg})
      self:call(self.event.refreshLetterRedDot)
    end
  end)
end

function this:req_pamiTalkGetReward(letterId, letterTextId, callback)
  local data = {u32 = letterTextId}
  L_Net:sendMessage(MsgGenCode.CSProtoPamiMailReward, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local rewards = rspData.rewards
      if not table.isEmpty(rewards) then
        L_RewardManager:showPage(rewards, rspData.src)
      end
      local letter = L_PamiTalkManager:getLetterServerData(letterId)
      if not letter then
        return
      end
      if not letter.reward then
        letter.reward = {}
      end
      if table.containsValue(letter.reward, letterTextId) then
        return
      end
      table.insert(letter.reward, letterTextId)
      L_PamiTalkManager:updateOneLetterRedInfo(letter)
      if callback then
        callback()
      end
      self:call(self.event.refreshRewardStatus)
      self:call(self.event.refreshLetterRedDot)
    end
  end)
end

function this:req_pamiTalkReadMail(letterId, callback)
  local data = {u32 = letterId}
  L_Net:sendMessage(MsgGenCode.CSProtoPamiMailRead, data, function(rspData, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      local letter = L_PamiTalkManager:getLetterServerData(letterId)
      if not letter then
        return
      end
      letter.latest_read = true
      L_PamiTalkManager:updateOneLetterRedInfo(letter)
      self:call(self.event.refreshReadStatus, letter)
      self:call(self.event.refreshLetterRedDot)
      if callback then
        callback()
      end
    end
  end)
end

function this:rsp_synPamiMailSync(data, errorCode)
  if errorCode == L_Const.errorCode.ErrCodeSucc then
    if not self.data.pamiTalkData then
      self.data.pamiTalkData = data
    else
      self:mergeTables(self.data.pamiTalkData, data)
    end
    self:parseData()
  end
end

function this:parseData()
  if not self.data.pamiTalkData then
    return
  end
  L_PamiTalkManager:parsePamiTalkData()
  self:call(self.event.refreshLetterRedDot)
  self:call(self.event.refreshLettersData)
end

function this:mergeTables(pamiTalkData, serverData)
  for k, data in pairs(serverData.mail_tab) do
    for i, talkData in pairs(pamiTalkData.mail_tab) do
      if talkData.mail_type == data.mail_type then
        for _, letter in pairs(data.contents) do
          if not self:findDataAndReplace(letter, talkData.contents) then
            table.insert(talkData.contents, letter)
          end
        end
      end
    end
  end
end

function this:findDataAndReplace(newLetter, oldLetters)
  for k, letter in pairs(oldLetters) do
    if letter.mail_id == newLetter.mail_id then
      oldLetters[k] = newLetter
      return true
    end
  end
  return false
end

return this
