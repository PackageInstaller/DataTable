local this = {}

function this:req_mailInfo(callback)
  L_Net:sendMessage(MsgGenCode.CSProtoMailList, nil, function(data, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      if not table.isEmpty(data) then
        self:rsp_syncMailInfo(data, true)
      end
      self.data.pullMail = true
      if callback then
        callback()
      end
    end
  end)
end

function this:req_changeCSProtoFetchMail(data)
  L_Net:sendMessage(MsgGenCode.CSProtoFetchMail, data, function(rsp_data, errorCode)
    if rsp_data.errcode == L_Const.errorCode.ErrCodeSucc then
      self:showMailRewards(rsp_data)
    elseif rsp_data.rewards and rsp_data.rewards.rewards and #rsp_data.rewards.rewards > 0 then
      self:showMailRewards(rsp_data)
    elseif rsp_data.errcode == L_Const.errorCode.ErrCodeBagFull then
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mail_reward_store"))
    else
      L_FlyMsgManager:showNormalMsg(L_WordsTpl:getValue("notice_mial_receive_fail"))
    end
  end)
end

function this:showMailRewards(rsp_data)
  self:rsp_syncMailReceive(rsp_data.guids)
  local rewards = require("ui.manager.reward.rewardData").new()
  rewards.rewardShowType = L_Const.rewardShowType.full
  local data = L_DataUtil.parseRewardConfig(rsp_data.rewards.rewards, true, true, nil, false, true)
  rewards:constructList(data)
  L_RewardManager:ShowReward(rewards)
end

function this:req_changeCSProtoDelMail(data)
  L_Net:sendMessage(MsgGenCode.CSProtoDelMail, data, function(rsp_data, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:rsp_syncMailRemove(rsp_data.u64s)
    end
  end)
end

function this:req_changeCSProtoReadMail(data, callback)
  if data.read then
    if callback then
      callback()
    end
    return
  end
  L_Net:sendMessage(MsgGenCode.CSProtoReadMail, {
    u64 = data.mailGuid
  }, function(rsp_data, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:rsp_syncMailRead(rsp_data.u64)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_changeCSProtoSetLanguage(data)
  L_Net:sendMessage(MsgGenCode.CSProtoSetLanguage, {u64 = data})
end

function this:req_changeCSProtoCollectMail(data, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoMailCollect, {
    u64 = data.mailGuid
  }, function(rsp_data, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc then
      self:rsp_synMailCollect(data.mailGuid)
      if callback then
        callback()
      end
    end
  end)
end

function this:req_questionLinkUrl(id, callback)
  L_Net:sendMessage(MsgGenCode.CSProtoGetQuestionLink, {u64 = id}, function(rsp_data, errorCode)
    if errorCode == L_Const.errorCode.ErrCodeSucc and callback then
      callback(rsp_data.link)
    end
  end)
end

return this
