---
--- 战斗请求接口 router
--- Author: dawanfan
--- Date: 2024-1-4 14:12:54
---

local _UIModule = CS.Engine.UI.UIModule


local BattleRouter = {}

---@type table<Constants.BattleRequestType, table<Constants.BattleRouterType, function>>
BattleRouter.routerDict = {
    -- 进入战斗
    [Constants.BattleRequestType.Enter] = {
        [Constants.BattleRouterType.Default] = function (questId, args, dialogArguments) FightPreWarMgr:GetInstance():DoFightEnter(questId, args, dialogArguments) end,
        [Constants.BattleRouterType.Fairyland] = function (questId, args, dialogArguments) GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent):FightEnter(questId, args, dialogArguments)  end,
    },
    
    -- 战斗结束
    [Constants.BattleRequestType.End] = {
        [Constants.BattleRouterType.Default] = function (args, argument) FightPreWarMgr:GetInstance():DoRequestBattleOver(args, argument) end,
        [Constants.BattleRouterType.Fairyland] = function (args, argument) GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent):FightFinish(args, argument)  end,
    },

    -- 战斗结束请求数据构造
    [Constants.BattleRequestType.GeneratorEndArgs] = {
        [Constants.BattleRouterType.Default] = function (battleFinishData) return FightPreWarMgr:GetInstance():GetFightEndArgs(battleFinishData) end,
        [Constants.BattleRouterType.Fairyland] = function (battleFinishData) return GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.FairylandComponent):GetFightEndArgs(battleFinishData) end,
    }
}

function BattleRouter:CheckRouterExists(requestType, routerType)
    if requestType == nil or routerType == nil then
        printInfo(string.format("[BattleRouter][CheckRouterExists] input type invalid, requestType: %s, routerType: %s", requestType, routerType))
        return false
    end

    if self.routerDict[requestType] == nil then
        return false
    end

    return self.routerDict[requestType][routerType] ~= nil
end

function BattleRouter:FightEnter(routerType, questId, args, dialogArguments)
    if self:CheckRouterExists(Constants.BattleRequestType.Enter, routerType) then
        local func = BattleRouter.routerDict[Constants.BattleRequestType.Enter][routerType]
        func(questId, args, dialogArguments)
    else
        printError(string.format("[BattleRouter][FighterEnter] routerType func is nil, %s", routerType))
        FightPreWarMgr:GetInstance():DoFightEnter(questId, args, dialogArguments)
    end
end

function BattleRouter:GetFightEndArgs(routerType, battleFinishData)
    if self:CheckRouterExists(Constants.BattleRequestType.GeneratorEndArgs, routerType) then
        local func = BattleRouter.routerDict[Constants.BattleRequestType.GeneratorEndArgs][routerType]
        return func(battleFinishData)
    else
        printError(string.format("[BattleRouter][GetFightEndArgs] routerType func is nil, %s", routerType))
        return FightPreWarMgr:GetInstance():GetFightEndArgs(battleFinishData)
    end
end

function BattleRouter:DoRequestBattleOver(routerType, args, argument)
    if self:CheckRouterExists(Constants.BattleRequestType.End, routerType) then
        local func = BattleRouter.routerDict[Constants.BattleRequestType.End][routerType]
        return func(args, argument)
    else
        printError(string.format("[BattleRouter][DoRequestBattleOver] routerType func is nil, %s", routerType))
        return FightPreWarMgr:GetInstance():DoRequestBattleOver(args, argument)
    end
end

return BattleRouter
