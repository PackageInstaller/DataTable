require("stn_common_wait_game_event")
_class("AniPopStar_OnMatchEnd", Common_WaitGameEvent)
AniPopStar_OnMatchEnd = AniPopStar_OnMatchEnd

function AniPopStar_OnMatchEnd:Constructor(pManger, nEventType)
  self.m_nEventType = GameEventType.BattleResultFinish
end

function AniPopStar_OnMatchEnd:_OnEvent(bVictory)
  if bVictory then
    local anipopModule = GameGlobal.GetModule(AnipopModule)
    local aniPopInfo = anipopModule:GetAniPopInfo()
    local curSeason = aniPopInfo.cur_season
    local roundInfo = aniPopInfo.round_info
    local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
    local anipopCreateInfo = matchEnterData:GetMissionCreateInfo()
    if anipopCreateInfo.mission_index == table.count(roundInfo.level_list) then
      self.m_nLogicResult = 2
    else
      self.m_nLogicResult = 1
    end
  else
    self.m_nLogicResult = 0
  end
  return AniPopStar_OnMatchEnd.super._OnEvent(self, bVictory)
end
