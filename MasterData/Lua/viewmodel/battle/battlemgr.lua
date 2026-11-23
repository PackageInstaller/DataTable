require("ViewModel/Battle/InBattleUIConfig")
require("ViewModel/SuiChuNaJi/SCNJBattleInUI")
require("ViewModel/SuiChuNaJi/SCNJBattleEndUI")
BattleMgr = {}
local this = {
    inbattleUIs = {},
    endbattleUIs = {}
}







function BattleMgr.InbattleUIBeforeAwake(params)
    local battleParams = BattlePrepareMgr.GetEnterDungeonParamsObj()
    if battleParams == nil or battleParams.extraParams == nil then
        return
    end
    local battleFalg = battleParams.extraParams[1] or nil
    local uiClassConfig = InBattleUIConfig.Config[battleFalg]
    if uiClassConfig == nil then
        return
    end
    local inbattleUIClassName = uiClassConfig[InBattleUIConfig.UIType.InBattle]
    if inbattleUIClassName ~= nil then
        local class = _G[inbattleUIClassName]
        if class ~= nil and params.rootObj ~= nil then
            local inbattleUI = class.New(params.rootObj)
            this.inbattleUIs[inbattleUIClassName] = inbattleUI
        end
    end
end

function BattleMgr.InbattleUIAfterActive(params)
    local battleParams = BattlePrepareMgr.GetEnterDungeonParamsObj()
    if battleParams == nil or battleParams.extraParams == nil then
        return
    end
    local battleFalg = battleParams.extraParams[1] or nil
    local uiClassConfig = InBattleUIConfig.Config[battleFalg]
    if uiClassConfig == nil then
        return
    end
    local inbattleUIClassName = uiClassConfig[InBattleUIConfig.UIType.InBattle]
    if inbattleUIClassName ~= nil then
        local inbattleUI = this.inbattleUIs[inbattleUIClassName]
        local data = {}
        data.Damage = 0
        inbattleUI:SetData(data)
    end
end


function BattleMgr.InbattleUIOnGetHit(totalDamage)
    local battleParams = BattlePrepareMgr.GetEnterDungeonParamsObj()
    if battleParams == nil or battleParams.extraParams == nil then
        return
    end
    local battleFalg = battleParams.extraParams[1] or nil
    local uiClassConfig = InBattleUIConfig.Config[battleFalg]
    if uiClassConfig == nil then
        return
    end
    local inbattleUIClassName = uiClassConfig[InBattleUIConfig.UIType.InBattle]
    if inbattleUIClassName ~= nil then
        local inbattleUI = this.inbattleUIs[inbattleUIClassName]
        local data = {}
        data.Damage = totalDamage
        inbattleUI:SetData(data)
    end
end


function BattleMgr.InbattleUIOnRegretUpdate(totalDamage)
    local battleParams = BattlePrepareMgr.GetEnterDungeonParamsObj()
    if battleParams == nil or battleParams.extraParams == nil then
        return
    end
    local battleFalg = battleParams.extraParams[1] or nil
    local uiClassConfig = InBattleUIConfig.Config[battleFalg]
    if uiClassConfig == nil then
        return
    end
    local inbattleUIClassName = uiClassConfig[InBattleUIConfig.UIType.InBattle]
    if inbattleUIClassName ~= nil then
        local inbattleUI = this.inbattleUIs[inbattleUIClassName]
        local data = {}
        data.Damage = totalDamage
        inbattleUI:SetData(data)
    end
end




function BattleMgr.EndbattleUI(rootObj, childNode, reportData)
    local battleParams = BattlePrepareMgr.GetEnterDungeonParamsObj()
    if battleParams == nil or battleParams.extraParams == nil then
        return
    end
    local battleFalg = battleParams.extraParams[1] or nil
    local uiClassConfig = InBattleUIConfig.Config[battleFalg]
    if uiClassConfig == nil then
        return
    end
    local inbattleUIClassName = uiClassConfig[InBattleUIConfig.UIType.InBattle]
    if inbattleUIClassName ~= nil then
        local inbattleUI = this.inbattleUIs[inbattleUIClassName]
        inbattleUI:Clear()
    end
    local endbattleUIClassName = uiClassConfig[InBattleUIConfig.UIType.EndBattle]
    if endbattleUIClassName ~= nil then
        local class = _G[endbattleUIClassName]
        if class ~= nil and (rootObj ~= nil or childNode) then
            local endbattleUI = class.New(rootObj, childNode)
            this.endbattleUIs[endbattleUIClassName] = endbattleUI
        end
        if this.endbattleUIs[endbattleUIClassName] ~= nil then
            this.endbattleUIs[endbattleUIClassName]:SetData(reportData)
        end
    end
end

