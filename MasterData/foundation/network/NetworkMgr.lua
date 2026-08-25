local corunning = coroutine.running
local coresume = coroutine.resume
local coyield = coroutine.yield
local NetworkMgr, super = System.NewClass("NetworkMgr", Manager, IUpdater)

function NetworkMgr:ctor(showErrCodeTipsCallback)
  super.ctor(self)
  self.cb_showErrCodeTips = showErrCodeTipsCallback
end

function NetworkMgr:Awake()
  Logger.Debug("NetworkMgr:CreateRpcClient")
  self.Login = RpcMgr.Instance:CreateRpcClient("Login")
  self.GameCopy = RpcMgr.Instance:CreateRpcClient("GameCopy", self.cb_showErrCodeTips)
  self.Gm = RpcMgr.Instance:CreateRpcClient("GameGm")
  self.City = RpcMgr.Instance:CreateRpcClient("City", self.cb_showErrCodeTips)
  self.Talent = RpcMgr.Instance:CreateRpcClient("Talents", self.cb_showErrCodeTips)
  self.Awaker = RpcMgr.Instance:CreateRpcClient("Roles", self.cb_showErrCodeTips)
  self.Item = RpcMgr.Instance:CreateRpcClient("Item", self.cb_showErrCodeTips)
  self.Trinket = RpcMgr.Instance:CreateRpcClient("Trinket", self.cb_showErrCodeTips)
  self.Role = RpcMgr.Instance:CreateRpcClient("Base", self.cb_showErrCodeTips)
  self.Teams = RpcMgr.Instance:CreateRpcClient("Teams", self.cb_showErrCodeTips)
  self.Redpoint = RpcMgr.Instance:CreateRpcClient("Redpoint")
  self.Chapter = RpcMgr.Instance:CreateRpcClient("Chapter", self.cb_showErrCodeTips)
  self.TaskModuleMgr = RpcMgr.Instance:CreateRpcClient("TaskModuleMgr", self.cb_showErrCodeTips)
  self.Summon = RpcMgr.Instance:CreateRpcClient("Summon", self.cb_showErrCodeTips)
  self.MainCopy = RpcMgr.Instance:CreateRpcClient("MainCopy", self.cb_showErrCodeTips)
  self.Comment = RpcMgr.Instance:CreateRpcClient("Comment", self.cb_showErrCodeTips)
  self.CopyReview = RpcMgr.Instance:CreateRpcClient("CopyReview", self.cb_showErrCodeTips)
  self.World = RpcMgr.Instance:CreateRpcClient("World", self.cb_showErrCodeTips)
  self.PvpMatch = RpcMgr.Instance:CreateRpcClient("PvpMatch", self.cb_showErrCodeTips)
  self.AvgCommunicate = RpcMgr.Instance:CreateRpcClient("AvgCommunicate", self.cb_showErrCodeTips)
  self.BattleFlow = RpcMgr.Instance:CreateRpcClient("BattleFlow", self.cb_showErrCodeTips)
  self.Pvp = RpcMgr.Instance:CreateRpcClient("Pvp", self.cb_showErrCodeTips)
  self.PvpCollect = RpcMgr.Instance:CreateRpcClient("PvpCollect", self.cb_showErrCodeTips)
  self.PvpTeam = RpcMgr.Instance:CreateRpcClient("PvpTeam", self.cb_showErrCodeTips)
  self.Shop = RpcMgr.Instance:CreateRpcClient("Shop", self.cb_showErrCodeTips)
  self.Equip = RpcMgr.Instance:CreateRpcClient("Equip", self.cb_showErrCodeTips)
  self.Stage = RpcMgr.Instance:CreateRpcClient("Stage", self.cb_showErrCodeTips)
  self.Home = RpcMgr.Instance:CreateRpcClient("Home", self.cb_showErrCodeTips)
  self.DailyChallenge = RpcMgr.Instance:CreateRpcClient("DailyChallenge", self.cb_showErrCodeTips)
  self.WeekChallenge = RpcMgr.Instance:CreateRpcClient("WeekChallenge", self.cb_showErrCodeTips)
  self.HomeConversion = RpcMgr.Instance:CreateRpcClient("HomeConversion", self.cb_showErrCodeTips)
  self.HomeConversionComp = RpcMgr.Instance:CreateRpcClient("HomeConversionComp", self.cb_showErrCodeTips)
  self.SchoolTowerMgr = RpcMgr.Instance:CreateRpcClient("SchoolTowerMgr", self.cb_showErrCodeTips)
  self.Email = RpcMgr.Instance:CreateRpcClient("Email", self.cb_showErrCodeTips)
  self.Intro = RpcMgr.Instance:CreateRpcClient("Introduction", self.cb_showErrCodeTips)
  self.Setting = RpcMgr.Instance:CreateRpcClient("Setting", self.cb_showErrCodeTips)
  self.Recharge = RpcMgr.Instance:CreateRpcClient("Recharge", self.cb_showErrCodeTips)
  self.Turntable = RpcMgr.Instance:CreateRpcClient("Turntable", self.cb_showErrCodeTips)
  self.BattlePass = RpcMgr.Instance:CreateRpcClient("BattlePass", self.cb_showErrCodeTips)
  self.GuideNote = RpcMgr.Instance:CreateRpcClient("GuideNote", self.cb_showErrCodeTips)
  self.ActivityMgr = RpcMgr.Instance:CreateRpcClient("ActivityMgr", self.cb_showErrCodeTips)
  self.Rank = RpcMgr.Instance:CreateRpcClient("Rank", self.cb_showErrCodeTips)
  self.Social = RpcMgr.Instance:CreateRpcClient("Social", self.cb_showErrCodeTips)
  self.Facade = RpcMgr.Instance:CreateRpcClient("Facade", self.cb_showErrCodeTips)
  self.AbyssChallenge = RpcMgr.Instance:CreateRpcClient("AbyssChallenge", self.cb_showErrCodeTips)
  self.MonthCard = RpcMgr.Instance:CreateRpcClient("MonthCard", self.cb_showErrCodeTips)
  self.Tutorial = RpcMgr.Instance:CreateRpcClient("Tutorial", self.cb_showErrCodeTips)
  self.Lottery = RpcMgr.Instance:CreateRpcClient("Lottery", self.cb_showErrCodeTips)
  self.Weapon = RpcMgr.Instance:CreateRpcClient("Weapon", self.cb_showErrCodeTips)
  self.Collection = RpcMgr.Instance:CreateRpcClient("Collection", self.cb_showErrCodeTips)
  self.Produce = RpcMgr.Instance:CreateRpcClient("Produce", self.cb_showErrCodeTips)
  self.Steam = RpcMgr.Instance:CreateRpcClient("Steam", self.cb_showErrCodeTips)
  self.PvpReward = RpcMgr.Instance:CreateRpcClient("PvpReward", self.cb_showErrCodeTips)
  self.RailWay = RpcMgr.Instance:CreateRpcClient("RailWay", self.cb_showErrCodeTips)
  Logger.Debug("NetworkMgr:CreateRpcBattle")
  self.WorldRoles = RpcMgr.Instance:CreateRpcBattle("WorldRoles", self.cb_showErrCodeTips)
  self.WorldCards = RpcMgr.Instance:CreateRpcBattle("WorldCards", self.cb_showErrCodeTips)
  self.WorldTalent = RpcMgr.Instance:CreateRpcBattle("Talent", self.cb_showErrCodeTips)
  self.GearMgr = RpcMgr.Instance:CreateRpcBattle("GearMgr", self.cb_showErrCodeTips)
  self.WorldEffect = RpcMgr.Instance:CreateRpcBattle("WorldEffect", self.cb_showErrCodeTips)
  self.WorldRelic = RpcMgr.Instance:CreateRpcBattle("Relic", self.cb_showErrCodeTips)
  self.WorldStage = RpcMgr.Instance:CreateRpcBattle("Stage", self.cb_showErrCodeTips)
  self.CmdMgr = RpcMgr.Instance:CreateRpcBattle("CmdMgr", self.cb_showErrCodeTips)
  self.Map = RpcMgr.Instance:CreateRpcBattle("Map", self.cb_showErrCodeTips)
  self.Battle = RpcMgr.Instance:CreateRpcBattle("Battle")
  Logger.Debug("NetworkMgr:Rpc Create Done")
end

function NetworkMgr:Connect(address, port, cb, id)
  local s, err = RpcMgr.Instance:Connect("tcp", address, port, cb, id)
  if not s then
    return s, err
  end
  return 1
end

function NetworkMgr:Disconnect(isReconn)
  RpcMgr.Instance:Disconnect(isReconn)
end

function NetworkMgr:Close()
  RpcMgr.Instance:Close()
end

local function RpcCallback(thread, ...)
  local ret, err = coresume(thread, ...)
  if not ret then
    Logger.Error([[
Coroutine LuaError:%s
%s]], err, debug.traceback(thread))
  end
end

function NetworkMgr:Call(_, protoCommand, msg)
  RpcMgr.Instance:Call(protoCommand, msg, RpcCallback, corunning())
  do return end
  return coyield, RpcMgr.Instance, protoCommand, msg, RpcCallback, corunning()
end

function NetworkMgr:Send(_, protoCommand, msg)
  RpcMgr.Instance:Call(protoCommand, msg, nil)
end

return NetworkMgr
