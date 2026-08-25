local NetworkMgr = require("Network.NetworkMgr")
local RailWayRequest, Super = System.NewClass("RailWayRequest", ProtoBase)

function RailWayRequest:ReqOnOpenRailWay()
  Logger.Proto("RailWayRequest:ReqOnOpenRailWay")
  do return NetworkMgr.Instance.RailWay.OnOpenRailWay end
  return NetworkMgr.Instance.RailWay.OnOpenRailWay, NetworkMgr.Instance.RailWay
end

return RailWayRequest
