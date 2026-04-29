require("common_async_base")
_class("ResDungeon_Cheat_UnlockAll", Common_AsyncBase)
ResDungeon_Cheat_UnlockAll = ResDungeon_Cheat_UnlockAll

function ResDungeon_Cheat_UnlockAll:TaskFunc(TT, status)
  self._manager:AsyncGM_UnlockResdungeonRoom(TT, status)
end
