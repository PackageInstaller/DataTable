
--region import
--- ---@type ClubGVGUtils
--- local ClubGVGUtils     = import('Game.UI.Club.GVG.ClubGVGUtils')
--endregion

--region define
--- local GVGConstants     = ClubGVGUtils.Constants
--- local ReportId = GVGConstants.ReportId
---@type ClubGVGConstants
local GVGConstants     = import('Game.UI.Club.GVG.ClubGVGConstants')
--endregion


---@class ClubGVGReportAnalyzer
---@field _mgr ClubGVGMgr
---@field _component ClubGVGComponent
---@field _timerDriver ClubGVGTimerDriver
local ClubGVGReportAnalyzer = Class('ClubGVGReportAnalyzer')


function ClubGVGReportAnalyzer:__init()

end


function ClubGVGReportAnalyzer:__delete()
    self._mgr         = nil
    self._component   = nil
    self._timerDriver = nil
end

---@param mgr ClubGVGMgr
---@param component ClubGVGComponent
---@param timerDriver ClubGVGTimerDriver
function ClubGVGReportAnalyzer:Init(mgr, component, timerDriver)
    self._mgr         = mgr
    self._component   = component
    self._timerDriver = timerDriver
end

function ClubGVGReportAnalyzer:Analyze(data)
    local ReportId = GVGConstants.ReportId
    local dataType = data.t
    local isFindSelf, extraData
    if dataType == ReportId.Join then
        isFindSelf = self:HandleReportJoin(data)
    elseif dataType == ReportId.March then
        isFindSelf, extraData = self:HandleReportMarch(data)
    elseif dataType == ReportId.Accelerate then
        extraData = self:HandleReportAccelerate(data)
    elseif dataType == ReportId.Building_Atk then
        isFindSelf = self:HandleReportBuildingAtk(data)
    elseif dataType == ReportId.Building_Change then
        extraData = self:HandleReportBuildingChange(data)
    elseif dataType == ReportId.Player_Atk then
        self:HandleReportPlayerAtk(data)
    elseif dataType == ReportId.Player_Atk_Over then
        self:HandleReportPlayerAtkOver(data)
    elseif dataType == ReportId.Player_Die then
        isFindSelf, extraData = self:HandleReportPlayerDie(data)
    elseif dataType == ReportId.Building_Change_Multi then
        self:HandleReportBuildingChangeMulti(data)
    end
    return isFindSelf, extraData
end

---加入战场
---@param data {id:number, t:number, pid:number, playerInfo:table, r:number, rts:number}
function ClubGVGReportAnalyzer:HandleReportJoin(data)
    local isSelf = self._component:UpdatePlayerInfo(data)
    if isSelf then
        self._mgr:InitStageStatus()
    end
    return isSelf
end

---行军
---@param data {id:number, t:number, pid:number, pa:string, mt:number}
function ClubGVGReportAnalyzer:HandleReportMarch(data)
    local marchData, isSelf = self._component:UpdateMarch(data)

    self._timerDriver:AddMarchData(marchData)

    self._mgr:UpdateMarchInfo(marchData)
    
    return isSelf, marchData
end

---行军加速
---@param data {id:number, t:number, pid:number, cd:number, mt:number}
function ClubGVGReportAnalyzer:HandleReportAccelerate(data)
    local oldMarchEndTime, marchData, accelerateCdEndTime = self._component:UpdateMarchAccelerate(data)
    self._timerDriver:AddAccelerateData(oldMarchEndTime, marchData, accelerateCdEndTime)
    return marchData
end

---攻击建筑
---@param data {id:number, t:number, pid:number, bid:number, hp:number, et:number}
function ClubGVGReportAnalyzer:HandleReportBuildingAtk(data)
    local attackCDEndTime, isSelf = self._component:UpdateBuildingAtkData(data)
    self._timerDriver:AddAttackBuildingData(attackCDEndTime, data)
    return isSelf
end

---建筑物变更归属
---@param data {id:number, t:number, bid:number, cid:number, hp:number}   
function ClubGVGReportAnalyzer:HandleReportBuildingChange(data)
    local clubId =  self._mgr:GetBuildInfo(data.bid).clubId
    
    self._mgr:UpdateClubId2Building(data)
    self._component:UpdateBuildingChange(data)

    return clubId
end

---玩家进攻
---@param data {id:number, t:number, pid:number, tid:number, bid:number, et:number}
function ClubGVGReportAnalyzer:HandleReportPlayerAtk(data)
    local attackCDEndTime, bannerData = self._component:UpdatePlayerAtkData(data)
    if attackCDEndTime then
        self._timerDriver:AddPlayerAttackData(attackCDEndTime, data)
        
    end

    if bannerData then
        Events.Broadcast(GVGConstants.EventNames.ShowBannerUI, bannerData, GVGConstants.BannerType.AttackPlayer)
    end

end

---玩家进攻结果
---@param data {id:number, t:number, pid:number, tid:number, bid:number, w:number}
function ClubGVGReportAnalyzer:HandleReportPlayerAtkOver(data)
    self._component:UpdatePlayerAtkOver(data)

end

---玩家死亡
---@param data {id:number, t:number, pids:table, r:number, rt:number}
function ClubGVGReportAnalyzer:HandleReportPlayerDie(data)
    local result = checkNumber(data.r)
    local isClubDie = result == GVGConstants.PlayerDieType.Club
    local isCommitSuicide = result == GVGConstants.PlayerDieType.CommitSuicide
    local playerIds = checkTable(data.pids)
    
    local isFindSelf = false
    local buildingIds = {}
    for index, playerId in ipairs(playerIds) do
        playerId = checkNumber(playerId)
        if isClubDie then
            local marchInfo = self._component:GetMarchInfoById(playerId)
            self._timerDriver:RemoveMarching(marchInfo)
            self._mgr:RemoveMarchInfo(marchInfo)
        end
        local rebirthTime = checkNumber(data.rtm)
        local isSelf, place = self._component:UpdatePlayerDie(isClubDie, playerId, rebirthTime, isCommitSuicide)
        if place then
            table.insert(buildingIds, place)
        end
        if isSelf then
            isFindSelf = true
            -- print("InitRebirthLimitRemoveData--->>>")
            self._mgr:UpdatePlayerDieStatus()
            
            ---工会死亡不需要再显示复活时间
            if not isClubDie then
                self._timerDriver:InitRebirthLimitRemoveData(rebirthTime)
                
            end
        end
    end
    return isFindSelf, {isClubDie = isClubDie, buildingIds = buildingIds}
end

---建筑物变更多次
---@param data {id:number, t:number, bids:table}
function ClubGVGReportAnalyzer:HandleReportBuildingChangeMulti(data)
    local clubId = 0
    local bids = checkTable(data.bids)
    data.bids = bids

    local t = {id = data.id, t = data.t, cid = 0}   
    for index, buildingId in ipairs(bids) do
        t.bid = buildingId
        self:HandleReportBuildingChange(t)
    end

end

return ClubGVGReportAnalyzer
