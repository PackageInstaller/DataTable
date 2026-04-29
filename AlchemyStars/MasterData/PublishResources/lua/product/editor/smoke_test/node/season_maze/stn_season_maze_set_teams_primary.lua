require("base_state_node")
_class("SeasonMaze_SetTeamsPrimary", Common_AsyncBase)
SeasonMaze_SetTeamsPrimary = SeasonMaze_SetTeamsPrimary

function SeasonMaze_SetTeamsPrimary:TaskFunc(TT, result)
  local runData = self.m_pManager:GetMissionRunData()
  local componentsID = runData:GetComponentID()
  self._seasonMazeModule = GameGlobal.GetModule(SeasonMazeModule)
  self._uiSeasonMazeModule = self._seasonMazeModule.uiModule
  self._seasonObj = self._seasonMazeModule:CurSeasonObj()
  self._com = self._seasonObj:GetMazeComponent()
  local diff = 3
  local res = AsyncRequestRes:New()
  local petList = {}
  table.insert(petList, 1600011)
  table.insert(petList, 1600021)
  table.insert(petList, 1600061)
  table.insert(petList, 1500091)
  self._com:HandleSeasonMazeSelectHard(TT, res, diff, petList)
  if res:GetSucc() then
    self._uiSeasonMazeModule:Enter()
  else
    local result = res:GetResult()
    Log.error("###[UISeasonMazePetsTeamsPrimary] HandleSeasonMazeSelectHard fail ! result:", result)
    GameGlobal.GetModule(SeasonMazeModule):CheckSeasonMazeClose(res)
  end
  self.m_nNodeState = 1
end
