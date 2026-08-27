local UINTaskListItem = require("Game.Task.NewUI.UINTaskListItem")
local base = UINTaskListItem
local UINBattlePassTaskListItemActivity = class("UINTaskListItem", base)
local TaskEnum = require("Game.Task.TaskEnum")
local JumpManager = require("Game.Jump.JumpManager")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UINBattlePassTaskListItemActivity:OnClickBtn()
  if self.state == TaskEnum.eTaskState.InProgress then
    local jumpId = self.taskCfg.jump_id
    local jumpArgs = self.taskCfg.jumpArgs
    if jumpId ~= nil and 0 < jumpId then
      JumpManager:Jump(jumpId, function(jumpCallback)
        if jumpCallback ~= nil then
          jumpCallback()
        end
      end, nil, jumpArgs)
    end
  elseif self.state == TaskEnum.eTaskState.Completed then
    self.state = TaskEnum.eTaskState.Picked
    self.ctrl:SendCommitQuestReward(self.taskData, nil, function()
      local heroIdSnapShoot = PlayerDataCenter:TakeHeroIdSnapShoot()
      UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
        if window == nil then
          return
        end
        local CRData = CommonRewardData.CreateCRDataUseList(self.taskData.stcData.rewardIds, self.taskData.stcData.rewardNums):SetCRHeroSnapshoot(heroIdSnapShoot, false)
        window:AddAndTryShowReward(CRData)
      end)
    end)
  else
    return
  end
end

return UINBattlePassTaskListItemActivity
