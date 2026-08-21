require("common_async_base")
_class("GM_SeasonMazeAddAllBead", Common_AsyncBase)
GM_SeasonMazeAddAllBead = GM_SeasonMazeAddAllBead

function GM_SeasonMazeAddAllBead:Constructor(_manager, count)
  self._count = count
end

function GM_SeasonMazeAddAllBead:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  if self._count then
    self._manager:AsyncGM_SeasonMazeAddItem(TT, status, componentID, 2, 10011, 1)
    self._manager:AsyncGM_SeasonMazeAddItem(TT, status, componentID, 2, 10011, 1)
    self._manager:AsyncGM_SeasonMazeAddItem(TT, status, componentID, 2, 10011, 1)
    self._manager:AsyncGM_SeasonMazeAddItem(TT, status, componentID, 2, 10011, 1)
    local levelOneBeadIDList = {
      10011,
      10021,
      10031,
      10041,
      10051,
      10061,
      10071,
      10081,
      10091,
      10101,
      10111,
      10121,
      10131,
      10141,
      10151,
      10161,
      10171,
      10181,
      10191,
      10201,
      11211,
      11221,
      11231,
      11241,
      11251,
      11261,
      11271,
      11281,
      11291,
      11301,
      11311,
      12321,
      12331,
      12341,
      12351,
      12361,
      12371,
      12381,
      12391,
      12401
    }
    local curBeadList = {}
    while table.count(curBeadList) < self._count do
      local randomIndex = math.random(1, table.count(levelOneBeadIDList))
      local curBeadID = levelOneBeadIDList[randomIndex]
      if curBeadID and not table.icontains(curBeadList, curBeadID) then
        table.insert(curBeadList, curBeadID)
      end
    end
    local itemType = 2
    for _, curBeadID in ipairs(curBeadList) do
      self._manager:AsyncGM_SeasonMazeAddItem(TT, status, componentID, itemType, curBeadID, 1)
    end
  else
    self._manager:AsyncGM_SeasonMazeAddAllBead(TT, status, componentID)
  end
end
