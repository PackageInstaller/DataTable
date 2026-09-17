local this = class("pageTrainTaskSettle", G_UIPageBase)

function this.bind()
  return {
    isOn_success = false,
    go_listReward = false,
    list_reward = L_Const.ModuleInfo.CellIconBag
  }
end

function this.methods()
  return {
    onClick_quit = function(self)
      L_UI:close(self.pageName)
      AzurWorld.DungeonMgr:ExitDungeon(true)
    end,
    onClick_restart = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:check(options, callback)
  callback(AzurWorld.DungeonMgr:CheckIsInTeaching())
end

function this:preOpen(options)
  self:initPage()
end

function this:close(options)
end

function this:escHandle()
end

function this:initPage()
  local dungeonState = AzurWorld.DungeonMgr:GetServerDungeonInfo().state
  local isSuccess = L_WorldManager:getCurModule() == L_Const.worldModule.dungeon and dungeonState == CS.Protocal.Cs.CampaignStatusType.CstWin
  self.bind.isOn_success = isSuccess
  local hasGetReward = true
  self.bind.go_listReward = isSuccess and not hasGetReward
  if self.bind.go_listReward then
    local temp = {}
    self.bind.list_reward:clear()
    self.bind.list_reward:insert_array(temp)
  end
end

return this
