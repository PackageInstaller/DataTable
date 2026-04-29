require("main_lobby_center_camp_data")
_class("VigorousRewardEnter", MainLobbyCenterCampData)
VigorousRewardEnter = VigorousRewardEnter

function VigorousRewardEnter:CheckNew()
  local pstID = GameGlobal.GetModule(RoleModule):GetPstId()
  return LocalDB.GetInt("UIVigorousRewardEnter_New" .. pstID, 0) == 0 and 1 or 0
end
