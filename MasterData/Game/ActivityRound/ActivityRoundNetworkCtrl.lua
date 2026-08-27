local ActivityRoundNetworkCtrl = class("ActivityRoundNetworkCtrl", NetworkCtrlBase)
local cs_WaitNetworkResponse = CS.WaitNetworkResponse.Instance

function ActivityRoundNetworkCtrl:ctor()
  self._lotteryTable = {}
  self._changePoolTable = {}
end

function ActivityRoundNetworkCtrl:InitNetwork()
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityRound_ExecLottery, self, proto_csmsg.SC_ActivityRound_ExecLottery, self.SC_ActivityRound_ExecLottery)
  self:RegisterNetwork(proto_csmsg_MSG_ID.MSG_SC_ActivityRound_NextLotteryRound, self, proto_csmsg.SC_ActivityRound_NextLotteryRound, self.SC_ActivityRound_NextLotteryRound)
end

function ActivityRoundNetworkCtrl:CS_ActivityRound_ExecLottery(actId, num, roundId, callback)
  self._lotteryTable.actId = actId
  self._lotteryTable.num = num
  self._lotteryTable.roundId = roundId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityRound_ExecLottery, proto_csmsg.CS_ActivityRound_ExecLottery, self._lotteryTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityRound_ExecLottery, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityRound_ExecLottery)
end

function ActivityRoundNetworkCtrl:SC_ActivityRound_ExecLottery(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityRoundNetworkCtrl:ActivityRound_ExecLottery error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  else
    local rewardElem = msg.rewards
    local rewardDic = {}
    for _, elem in ipairs(rewardElem) do
      local tempCount = rewardDic[elem.id] or 0
      rewardDic[elem.id] = tempCount + elem.num
    end
    local rewardIds = {}
    local rewardNums = {}
    for itemId, itemCount in pairs(rewardDic) do
      table.insert(rewardIds, itemId)
      table.insert(rewardNums, itemCount)
    end
    self._heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CommonRewardData = require("Game.CommonUI.CommonRewardData")
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums):SetCRHeroSnapshoot(self._heroIdSnapShoot, false):SetCRNotHandledGreat(true):SetCRShowOverFunc(function()
        local achievementSystemWin = UIManager:GetWindow(UIWindowTypeID.AchievementSystem)
        if achievementSystemWin ~= nil then
          achievementSystemWin.achievementLevelNode.__NeedRefreshPlayerLevel()
        end
      end)
      window:AddAndTryShowReward(CRData)
    end)
  end
end

function ActivityRoundNetworkCtrl:CS_ActivityRound_NextLotteryRound(actId, roundId, callback)
  self._changePoolTable.actId = actId
  self._changePoolTable.roundId = roundId
  self:SendMsg(proto_csmsg_MSG_ID.MSG_CS_ActivityRound_NextLotteryRound, proto_csmsg.CS_ActivityRound_NextLotteryRound, self._changePoolTable)
  cs_WaitNetworkResponse:StartWait(proto_csmsg_MSG_ID.MSG_CS_ActivityRound_NextLotteryRound, callback, proto_csmsg_MSG_ID.MSG_SC_ActivityRound_NextLotteryRound)
end

function ActivityRoundNetworkCtrl:SC_ActivityRound_NextLotteryRound(msg)
  NetworkManager:HandleDiff(msg.syncUpdateDiff)
  if msg.ret ~= 0 then
    local err = "ActivityRoundNetworkCtrl:ActivityRound_NextLotteryRound error:" .. tostring(msg.ret)
    self:ShowSCErrorMsg(err)
  end
end

return ActivityRoundNetworkCtrl
