require("main_lobby_center_camp_data")
_class("TempSignInEnter", MainLobbyCenterCampData)
TempSignInEnter = TempSignInEnter

function TempSignInEnter:CheckRed()
  local tb = {
    NewPlayerLoginStatus.NPLS_UnAccept
  }
  local idx = UITempSignInEnter.CheckDayStatus(tb)
  return idx ~= 0 and 1 or 0
end
