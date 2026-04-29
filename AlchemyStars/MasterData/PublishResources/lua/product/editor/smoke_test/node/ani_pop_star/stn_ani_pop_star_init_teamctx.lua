require("base_state_node")
_class("AniPopStar_InitTeamctx", CTestRobot_Base)
AniPopStar_InitTeamctx = AniPopStar_InitTeamctx

function AniPopStar_InitTeamctx:OnWorking()
  local aniPopInfo = self.m_pRunData
  local curSeason = aniPopInfo.cur_season
  local roundInfo = aniPopInfo.round_info
  local levelInfo = roundInfo.level_list[roundInfo.mission_index]
  local missionCfg = Cfg.cfg_anipop_fight_level[levelInfo.level_id]
  local missionID = missionCfg.LevelID
  local mission_index = roundInfo.mission_index
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local formationInfo = anipopModule:GetFormationInfo()
  local missionModule = self:GetModule(MissionModule)
  local ctx = missionModule:TeamCtx()
  ctx:Init(TeamOpenerType.AniPopStar, {
    missionID,
    nil,
    mission_index,
    curSeason
  })
  ctx:InitAniPopStarTeam(formationInfo)
  self.m_nLogicResult = 1
  self.m_pReturnData = self.m_pRunData
  return AniPopStar_InitTeamctx.super.OnWorking(self)
end
