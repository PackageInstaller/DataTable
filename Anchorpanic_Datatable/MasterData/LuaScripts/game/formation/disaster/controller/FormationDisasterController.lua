--[[ 
-----------------------------------------------------
@filename       : FormationDisasterController
@Description    : 灾厄控制器
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationDisasterController", Class.impl("game.formation.normal.controller.FormationController"))
---------------------------------------------------------------固定需要-----------------------------------------------------------------
function getManager(self)
    return formation.FormationDisasterManager
end

-- 模块间事件监听
function listNotification(self)
    super.listNotification(self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE,self.onClosePanelHandler,self)
    GameDispatcher:addEventListener(EventName.OPEN_DISASTER_LOG_PANEL,self.onOpenLogPanel,self)
end

function onClosePanelHandler(self,args)
    for _, id in ipairs(args.closeList) do
        if id == activity.ActivityId.Disaster then
            if self.m_heroFormationPanel ~= nil then
                self.m_heroFormationPanel:close()
            end
            if self.mFormationHeroSelectPanel ~= nil then
                self.mFormationHeroSelectPanel:close()
            end
            if self.mLogPanel ~= nil then
                self.mLogPanel:close()
            end
        end
    end
    
end

--屏蔽，由父类一次性请求
function gameStartCallBack(self)
end

-- 请求修改阵型英雄列表
function __onReqFormationHeroListHandler(self, args)
    local list = {}
    local readId ,isImi= self:getManager():getIsReadTeamId()
    local function GetFormationData(teamId, formationId)
        local teamVo = self:getManager():getTeamVoByTeamId(teamId)
        local selectHeroList = formation.FormationManager:getSelectFormationHeroList(teamId) --非当前实例化对象存有数据

        local selectAssistHeroList = self:getManager():getSelectTeamAssistHeroList(teamId)
        local data = {}
        data.team_id = teamId
        data.name = teamVo.teamName
       
        formationId = formationId or teamVo.formationId
        data.formation_id = formationId
        data.is_ready = readId == teamId and isImi == false and 1 or 0
        data.formation_hero_list = {}
        data.assist_fight_list = {}
        for k, formationHeroVo in pairs(selectHeroList) do
            local vo = {}
            vo.is_captain = formationHeroVo.isCaptainHero and 1 or 0
            vo.pos = formationHeroVo.heroPos
            vo.hero_id = formationHeroVo.heroId
            vo.hero_source = formationHeroVo.sourceType
            vo.tid = formationHeroVo:getHeroTid()
            table.insert(data.formation_hero_list, vo)
        end
        for k, assistHeroVo in pairs(selectAssistHeroList) do
            local vo = {}
            vo.pos = assistHeroVo.heroPos
            vo.hero_id = assistHeroVo.heroId
            table.insert(data.assist_fight_list, vo)
        end
        data.pet_id = self:getManager():getPetIdByTeamId(teamId)
        self:getManager():getTeamVoByTeamId(teamId).petId = data.pet_id
        self:getManager():instance().mInUsePetDic[teamId] = data.pet_id
        return data
    end

    local lock, formationId = self:getManager():isLockFormation()
    local changeTeamIdList = self:getManager():getAllTeamIdList()
    for k, teamId in pairs(changeTeamIdList) do
        if lock ~= 0 then
            local data = GetFormationData(teamId, formationId)
            local selectTeamId = formation.FormationManager:getSelectFormationTeamId()
            if selectTeamId == data.team_id then
                table.insert(list, data)
            end
        else
            local data = GetFormationData(teamId)
            if teamId == formation.DISASTAERIMID then
                if readId == nil then
                    readId = 19001
                end
                data = GetFormationData(readId)
                data.team_id = formation.DISASTAERIMID
                data.is_ready = isImi == true and 1 or 0
            end
           
            table.insert(list, data)
        end
    end

    self:getManager():initPetData()

    if (lock == 1 and #list <= 0) then
        Debug:log_error("FormationController", "策划配置了锁阵型，但是没有站员，有问题")
    end
    if (#list > 0) then
        --- *c2s* 请求更新阵型英雄列表 13046
        SOCKET_SEND(Protocol.CS_CHANGE_HERO, {
            type = formation.getFormationTypeByController(self),
            formation_list = list,
            is_lock = lock
        }, Protocol.SC_CHANGE_HERO)
        GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)
    end
end

---------------------------------------------------------------按需重写-----------------------------------------------------------------
function __openFormationPanel(self)
    if self.m_heroFormationPanel == nil then
        self.m_heroFormationPanel = formation.FormationDisasterPanel.new()
        self.m_heroFormationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    end
    self.m_heroFormationPanel:open({ manager = self:getManager() })
end

function __onOpenFormationHeroSelectPanelHandler(self, args)
    if self.mFormationHeroSelectPanel == nil then
        self.mFormationHeroSelectPanel = formation.FormationDisasterSelectPanel.new()
        self.mFormationHeroSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationHeroSelectPanelHandler, self)
    end
    self.mFormationHeroSelectPanel:open({ manager = self:getManager(), data = args })
end

function onOpenLogPanel(self,args)
    if self.mLogPanel == nil then
        self.mLogPanel = formation.FormaionDisasterLogPanel.new()
        self.mLogPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyFormationLogPanel, self)
    end
    self.mLogPanel:open({ manager = self:getManager() })
end

function __destroyFormationLogPanel(self)
    self.mLogPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.__destroyFormationLogPanel, self)
    self.mLogPanel = nil
end

return _M