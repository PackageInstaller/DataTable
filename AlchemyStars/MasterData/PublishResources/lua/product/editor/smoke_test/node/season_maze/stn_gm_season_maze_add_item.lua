require("common_async_base")
_class("GM_SeasonMazeAddItem", Common_AsyncBase)
GM_SeasonMazeAddItem = GM_SeasonMazeAddItem

function GM_SeasonMazeAddItem:Constructor(_manager, itemType, itemID, itemCount)
  self._itemType = itemType
  self._itemID = itemID
  self._itemCount = itemCount
end

function GM_SeasonMazeAddItem:TaskFunc(TT, status)
  local runData = self._manager:GetMissionRunData()
  local componentID = runData:GetComponentConfigID()
  self._manager:AsyncGM_SeasonMazeAddItem(TT, status, componentID, self._itemType, self._itemID, self._itemCount)
end
