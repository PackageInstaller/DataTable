local SdkTrackConst = require("SDK/Const/SdkTrackConst")
local SdkTrackExcludeEvents = {}
SdkTrackExcludeEvents.EvtName = {
  [SdkTrackConst.EvtName.battle_win] = true,
  [SdkTrackConst.EvtName.get_diamond] = true,
  [SdkTrackConst.EvtName.station_buy] = true,
  [SdkTrackConst.EvtName.station_sell] = true,
  [SdkTrackConst.EvtName.get_equip] = true
}
return SdkTrackExcludeEvents
