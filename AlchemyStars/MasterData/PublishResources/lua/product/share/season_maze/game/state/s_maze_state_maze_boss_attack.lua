require("s_maze_state_base")
_class("SMazeState_BossAttack", SMazeStateBase)
SMazeState_BossAttack = SMazeState_BossAttack

function SMazeState_BossAttack:OnEnter()
  self:StartTask(self._AnimTask, self)
end

function SMazeState_BossAttack:_AnimTask(TT)
  local cpt = self._manager:GetMazeComponent()
  local bossInfos = cpt:GetComponentInfo().boss_info
  local bossIndex = 1
  for i = 0, table.count(bossInfos) - 1 do
    local info = bossInfos[i]
    if info.do_cnt ~= -1 then
      break
    end
    bossIndex = bossIndex + 1
  end
  local curBoosInfo = bossInfos[bossIndex - 1]
  local isTheLast = bossIndex >= table.count(bossInfos)
  local missionId = curBoosInfo.cfg_id
  local cfgs = Cfg.cfg_season_maze_mission({SeasonMazeMissionId = missionId})
  if not cfgs or not next(cfgs) then
    Log.exception("cfg_season_maze_mission 中找不到配置:", missionId)
  end
  local levelId = cfgs[1].FightLevel
  self._manager:Lock("BossAttackAnim")
  GameGlobal.UIStateManager():CallUIMethod("UISeasonMazeScene", "BossAtkAnim")
  local animTime = 1567
  YIELD(TT, animTime)
  local duration = 1000
  self:ShowDialog("UISeasonMazeBossAtkTip", levelId, nil, isTheLast)
  YIELD(TT, duration)
  self._manager:UnLock("BossAttackAnim")
  if not self._valid then
    return
  end
  GameGlobal.UIStateManager():CloseDialog("UISeasonMazeBossAtkTip")
  self:ShowDialog("UISeasonMazeRoomStage", nil)
end
