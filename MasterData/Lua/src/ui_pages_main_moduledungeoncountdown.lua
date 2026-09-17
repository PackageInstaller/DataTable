local this = class("moduleDungeonCountdown", G_UIModuleBase)

function this.bind()
  return {txt_countdown = nil, go_content = true}
end

function this.methods()
  return {}
end

function this:open()
  self:dealWithDungeonStatus()
end

function this:close()
  self:removeTimer()
end

function this:dealWithDungeonStatus()
  local dungeonState = AzurWorld.DungeonMgr:GetServerDungeonInfo().state
  self._isWin = L_WorldManager:getCurModule() == L_Const.worldModule.dungeon and dungeonState == CS.Protocal.Cs.CampaignStatusType.CstWin
  self.bind.go_content = self._isWin
  if self._isWin then
    self:openDungeonWinCountdown()
  elseif dungeonState == CS.Protocal.Cs.CampaignStatusType.CstLose then
  end
end

function this:openDungeonWinCountdown()
  if not self._isWin then
    return
  end
  local leftTime = L_GameClientTpl:getData("DUNGEON_STAY_TIME", L_Const.GameTplType.int)
  
  local function func()
    self.bind.txt_countdown = L_WordsTpl:getValue("notice_pageMultiDungeonSettle", {
      [0] = leftTime
    })
    if leftTime <= 0 then
      self:removeTimer()
      AzurWorld.DungeonMgr:ExitDungeon(true)
    end
    leftTime = leftTime - 1
  end
  
  self:removeTimer()
  self.timer = L_GameTimer.repeated(1, func, self)
  func()
end

function this:dealWithMultiDungeonStatus()
  local dungeonState = L_MultiDungeonStore:getCurMultiDungeonInfo().status
  self._isWin = L_WorldManager:getCurModule() == L_Const.worldModule.multiDungeon and dungeonState == L_Const.CampaignStatusType.CST_WIN
  self.bind.go_content = self._isWin
  if self._isWin then
    self:openMultiDungeonWinCountdown()
  elseif dungeonState == L_Const.CampaignStatusType.CST_LOSE then
  end
end

function this:openMultiDungeonWinCountdown()
  if not self._isWin then
    return
  end
  local curDungeon = L_MultiDungeonStore:getCurMultiDungeonInfo()
  self._endTime = curDungeon.end_time + 30
  
  local function func()
    local nowTime = L_TimeUtil.getServerTime()
    local leftTime = self._endTime - nowTime
    self.bind.txt_countdown = L_WordsTpl:getValue("notice_moduleDungeonCountdown", {
      [0] = leftTime
    })
    if leftTime <= 0 then
      L_TimerManager:stopTimer(self, "win_countdown")
      L_UI:backToRoot(function()
        L_UI:open("pageMultiDungeonSettle")
      end)
    end
  end
  
  L_TimerManager:newOrResetTimer(self, "win_countdown", func, 0.5, -1)
  func()
end

function this:removeTimer()
  if self.timer then
    L_GameTimer.remove(self.timer)
    self.timer = nil
  end
end

function this:closeCountdown()
  L_TimerManager:clearTimer(self)
  self.bind.go_content = false
end

function this:activate()
  self:open()
  self:openModules()
  self:show()
  self:showModules()
end

function this:deActivate()
  self:hide()
  self:hideModules()
  self:close()
  self:closeModules()
end

return this
