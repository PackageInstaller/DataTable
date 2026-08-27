local EventWeeklyQANetWork = class("EventWeeklyQANetWork", NetworkCtrlBase)
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local cs_MessageCommon = CS.MessageCommon
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function EventWeeklyQANetWork:ctor()
  self._answerChoiceTable = {}
  self._answerRewardTable = {}
end

function EventWeeklyQANetWork:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Answer_Choice, self, proto_csmsg.SC_Activity_Answer_Choice, self.SC_Activity_Answer_Choice)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_Activity_Answer_Reward, self, proto_csmsg.SC_Activity_Answer_Reward, self.SC_Activity_Answer_Reward)
end

function EventWeeklyQANetWork:CS_Activity_Answer_Choice(actId, questionId, choice, callback)
  self._answerChoiceTable.actId = actId
  self._answerChoiceTable.questionId = questionId
  self._answerChoiceTable.choice = choice
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Answer_Choice, proto_csmsg.CS_Activity_Answer_Choice, self._answerChoiceTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Answer_Choice, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Answer_Choice)
end

function EventWeeklyQANetWork:SC_Activity_Answer_Choice(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Answer_Choice error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Answer_Choice)
    return
  end
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

function EventWeeklyQANetWork:CS_Activity_Answer_Reward(actId, needScore, callback)
  self._answerRewardTable.actId = actId
  self._answerRewardTable.needScore = needScore
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_Activity_Answer_Reward, proto_csmsg.CS_Activity_Answer_Reward, self._answerRewardTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Answer_Reward, callback, proto_csmsg_MSG_ID.MSG_SC_Activity_Answer_Reward)
end

function EventWeeklyQANetWork:SC_Activity_Answer_Reward(msg)
  if msg.ret ~= proto_csmsg_ErrorCode.None then
    local err = "SC_Activity_Answer_Choice error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
    cs_WaitNetworkResponse:RemoveWait(proto_csmsg_MSG_ID.MSG_CS_Activity_Answer_Reward)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
    if window == nil then
      return
    end
    local CRData = CommonRewardData.CreateCRDataUseDic(msg.rewards)
    window:AddAndTryShowReward(CRData)
  end)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
end

return EventWeeklyQANetWork
