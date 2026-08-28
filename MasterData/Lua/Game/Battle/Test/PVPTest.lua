--[[
    author:luqucheng
    time:2021-03-11 14:14:47
]]
local KNManager = CS.Engine.Network.KNManager
local PVPTest = {}

local PackageIds = {
    RequirePVP = 2101,
    AcceptPVP = 2103,

    ReceivePVPRequire = 2102,
    ReceivePVPAccept = 2104,
}

function PVPTest:Init(  )
    
end

function PVPTest:RequirePPVE(targetId, isReconnect)
    -- local data = {
    --     oppoId = targetId
    -- }
    -- print("RequirePVP", data.oppoId, KNManager.isConnected)
    -- AppService:SendTcpData(PackageIds.RequirePVP, data)
    GameUtils.GetPlayerId = function ()
        return targetId
    end
    
    ---@type BattleMgr
    BattleMgr = import('Game.Battle.Core.BattleMgr')
    BattleMgr.gameMode = Constants.GameMode.PVP
    ---@type BattleViewMgr
    BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
    BattleViewMgr.gameMode = Constants.GameMode.OnlinePVE
    BattleViewMgr.pvpMode = Constants.PVPMode.Annihilation
    BattleViewMgr.address = "139.224.31.165"
    BattleViewMgr.roomId = "roomtestid"
    BattleViewMgr.port = 21904
    BattleViewMgr.isReconnectOutside = isReconnect  -- integer 1是 0否
    -- print("require ppve ", isReconnect)

    GameUtils.OpenLoadingPanel(UIArgs(Constants.UITypeIds.BattleScene, {}), nil, Constants.LoadingType.Battle)
end

function PVPTest:RequirePVP(targetId, isReconnect)
    GameUtils.GetPlayerId = function ()
        return targetId
    end
    
    ---@type BattleMgr
    BattleMgr = import('Game.Battle.Core.BattleMgr')
    BattleMgr.gameMode = Constants.GameMode.PVP
    ---@type BattleViewMgr
    BattleViewMgr = import('Game.BattleView.Core.BattleViewMgr')
    BattleViewMgr.gameMode = Constants.GameMode.PVP
    BattleViewMgr.pvpMode = Constants.PVPMode.LadderCompetion
    BattleViewMgr.address = "139.224.31.165"
    BattleViewMgr.roomId = "roomtestid"
    BattleViewMgr.port = 21902
    BattleViewMgr.isReconnectOutside = isReconnect  -- integer 1是 0否
    -- print("require pvp ", isReconnect)

    GameUtils.OpenLoadingPanel(UIArgs(Constants.UITypeIds.BattleScene, {}), nil, Constants.LoadingType.Battle)
end

return PVPTest