require("base_state_node")
_class("AniPopStar_FindRoom", CTestRobot_Base)
AniPopStar_FindRoom = AniPopStar_FindRoom

function AniPopStar_FindRoom:OnWorking()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local aniPopInfo = anipopModule:GetAniPopInfo()
  local curSeason = aniPopInfo.cur_season
  local roundInfo = aniPopInfo.round_info
  local levelInfo = roundInfo.level_list[roundInfo.mission_index]
  if nil == levelInfo then
    self.m_nLogicResult = 0
  else
    self.m_nLogicResult = 1
  end
  self.m_pReturnData = aniPopInfo
  local progressInfo = self.m_pManager:GetProgressInfo()
  if roundInfo.mission_index ~= 0 then
    progressInfo:TickProgress(roundInfo.mission_index + aniPopInfo.cur_season * 100)
  end
  return AniPopStar_FindRoom.super.OnWorking(self)
end

function AniPopStar_FindRoom:OnBegin(...)
  if self.m_pActionTree then
    local listScanID = self.m_pActionTree:GetScanActionID()
    local nTreeID = self.m_pActionTree:GetTreeID()
    self:PrintLog("ScanPath TreeID = ", nTreeID, ", Path = [", table.concat(listScanID, ","), "]")
    self.m_pActionTree:ResetScanActionID()
  end
  local nReturn = AniPopStar_FindRoom.super.OnBegin(self, ...)
  return nReturn
end
