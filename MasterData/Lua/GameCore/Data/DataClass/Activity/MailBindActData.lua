local ActivityDataBase = require("GameCore.Data.DataClass.Activity.ActivityDataBase")
local MailBindActData = class("MailBindActData", ActivityDataBase)
local SDKManager = CS.SDKManager.Instance

function MailBindActData:Init()
  self.bBind = false
  self.bGettedReward = false
  self.bRequestState = false
  self.bQueryEmailBindState = false
  self:AddListeners()
end

function MailBindActData:AddListeners()
  EventManager.Add("OnQueryEmailBindState", self, self.On_QueryEmailBindState)
  EventManager.Add("OnBindEmail", self, self.On_BindEmail)
end

function MailBindActData:On_QueryEmailBindState(nCode, sLog, bBind)
  self.bBind = bBind
  if self.bRequestState then
    if bBind then
      local function callback(_, msgData)
        self.bGettedReward = true
        
        UTILS.OpenReceiveByChangeInfo(msgData)
        EventManager.Hit("MailBind_RequestUpdate")
      end
      
      HttpNetHandler.SendMsg(NetMsgId.Id.activity_mail_bind_reward_receive_req, {
        Value = self.nActId
      }, nil, callback)
      self.bRequestState = false
    elseif self.bQueryEmailBindState then
      SDKManager:ShowBindEmail()
    end
  end
  self.bQueryEmailBindState = false
end

local function UploadLinkMail()
  local tab = {}
  table.insert(tab, {
    "role_id",
    tostring(PlayerData.Base._nPlayerId)
  })
  table.insert(tab, {"action", "1"})
  NovaAPI.UserEventUpload("link_mail", tab)
end

function MailBindActData:On_BindEmail(nCode, sLog)
  if nCode == 0 and self.bBind ~= true then
    self.bBind = true
    
    local function callback(_, msgData)
      self.bGettedReward = true
      UTILS.OpenReceiveByChangeInfo(msgData)
      EventManager.Hit("MailBind_RequestUpdate")
      UploadLinkMail()
    end
    
    HttpNetHandler.SendMsg(NetMsgId.Id.activity_mail_bind_reward_receive_req, {
      Value = self.nActId
    }, nil, callback)
  end
  self.bRequestState = false
end

function MailBindActData:RefreshMailBindActData(actId, msgData)
  self:Init()
  self.bGettedReward = msgData.Bind
end

function MailBindActData:GetRewardData()
  return self.bGettedReward
end

function MailBindActData:GetRequestState()
  return self.bRequestState
end

function MailBindActData:GetBindState()
  return self.bBind
end

function MailBindActData:RequestReward()
  if self.bGettedReward then
    return
  end
  if self.bRequestState then
    return
  end
  self.bRequestState = true
  self.bQueryEmailBindState = true
  SDKManager:QueryEmailBindState()
end

function MailBindActData:CheckActShow()
  if NovaAPI.IsReviewServerEnv() then
    return false
  end
  if self.actCfg.PreLimit == GameEnum.activityPreLimit.WorldClass then
    local nCurWorldClass = PlayerData.Base:GetWorldClass()
    local nNeedWorldClass = tonumber(self.actCfg.LimitParam)
    if nCurWorldClass < nNeedWorldClass then
      return false
    end
  elseif self.actCfg.PreLimit == GameEnum.activityPreLimit.questLimit then
    local nStoryId = tonumber(self.actCfg.LimitParam)
    local bReaded = PlayerData.Avg:IsStoryReaded(nStoryId)
    if not bReaded then
      return false
    end
  end
  if self.bGettedReward then
    return false
  end
  if self.actCfg.EndType == GameEnum.activityEndType.NoLimit then
    return not self.bBanner and self:CheckActivityOpen()
  else
    return self:CheckActivityOpen()
  end
end

function MailBindActData:CheckShowBanner()
  if NovaAPI.IsReviewServerEnv() then
    return false
  end
  if self.actCfg.PreLimit == GameEnum.activityPreLimit.WorldClass then
    local nCurWorldClass = PlayerData.Base:GetWorldClass()
    local nNeedWorldClass = tonumber(self.actCfg.LimitParam)
    if nCurWorldClass < nNeedWorldClass then
      return false
    end
  elseif self.actCfg.PreLimit == GameEnum.activityPreLimit.questLimit then
    local nStoryId = tonumber(self.actCfg.LimitParam)
    local bReaded = PlayerData.Avg:IsStoryReaded(nStoryId)
    if not bReaded then
      return false
    end
  end
  return not self.bGettedReward and self.actCfg.BannerRes ~= "" and self.bBanner == false
end

return MailBindActData
