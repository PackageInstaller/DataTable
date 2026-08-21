require("common_async_base")
_class("GM_SeasonMazeAddAllRelic", Common_AsyncBase)
GM_SeasonMazeAddAllRelic = GM_SeasonMazeAddAllRelic

function GM_SeasonMazeAddAllRelic:Constructor(_manager, count)
  self._count = count
end

function GM_SeasonMazeAddAllRelic:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  local SeasonMazeAddRelicList = {
    9011003,
    9011008,
    9011010,
    9011015,
    9011016,
    9011018,
    9011019,
    9011020,
    9011021,
    9011022,
    9011023,
    9011029,
    9011030,
    9011032,
    9011033,
    9011034,
    9011035,
    9011047,
    9011048,
    9011049,
    9011050,
    9011051,
    9011052,
    9011053,
    9011055,
    9011056,
    9011062,
    9011067,
    9011069,
    9011072,
    9011073,
    9011074,
    9011077,
    9011078,
    9011079,
    9011080,
    9011081,
    9011082,
    9011083,
    9011084,
    9011085,
    9011086,
    9011087,
    9011088
  }
  if self._count then
    local curRelicList = {}
    while table.count(curRelicList) < self._count do
      local randomIndex = math.random(1, table.count(SeasonMazeAddRelicList))
      local curRelicID = SeasonMazeAddRelicList[randomIndex]
      if curRelicID and not table.icontains(curRelicList, curRelicID) then
        table.insert(curRelicList, curRelicID)
      end
    end
    local itemType = 3
    for _, curRelicID in ipairs(curRelicList) do
      self._manager:AsyncGM_SeasonMazeAddItem(TT, status, componentID, itemType, curRelicID, 1)
    end
  else
    self._manager:AsyncGM_SeasonMazeAddAllRelic(TT, status, componentID)
  end
end
