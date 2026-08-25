local table = _ENV.table
local BattleRequest, Super = System.NewClass("BattleRequest", ProtoBase)

function BattleRequest:Startup()
  Super.Startup(self)
end

function BattleRequest:Shutdown()
  Super.Shutdown(self)
end

function BattleRequest:ClearData()
  Super.ClearData(self)
end

function BattleRequest:StartAsyncPvp(cityCid, tileCid)
  Logger.Info("BattleRequest:StartAsyncPvp(), 请求进攻城池, cityCid: %s  tileCid: %s", cityCid, tileCid)
  local data, errcode = NetworkMgr.Instance.Battle:StartAsyncPvp(cityCid, tileCid)
  return data, errcode
end

function BattleRequest:RequestDungeonPvp(uid)
  Logger.Info("请求pvp RequestDungeonPvp -- uid = %d", uid)
  local data, errcode = NetworkMgr.Instance.Battle:RequestDungeonPvp(uid)
  return data, errcode
end

return BattleRequest
