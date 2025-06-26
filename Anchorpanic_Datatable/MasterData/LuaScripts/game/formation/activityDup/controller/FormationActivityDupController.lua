module("formation.FormationActivityDupController", Class.impl("game.formation.normal.controller.FormationController"))

---------------------------------------------------------------固定需要-----------------------------------------------------------------
function getManager(self)
    return formation.FormationActivityDupManager
end

--屏蔽，由父类一次性请求
function gameStartCallBack(self)

end

-- 模块间事件监听
function listNotification(self)
    super.listNotification(self)
    GameDispatcher:addEventListener(EventName.ACTIVITY_CLOSE_UPDATE, self.onCloseActivityHandler, self)
end

--屏蔽，由父类一次性注册
-- function registerMsgHandler(self)
-- end

function onCloseActivityHandler(self, args)
    for _, id in ipairs(args.closeList) do
        if id == activity.ActivityId.MainActivity then

            if self.mFormationPosEffPanel then
                self.mFormationPosEffPanel:close()
            end

            if self.mFormationElementPanel then
                self.mFormationElementPanel:close()
            end

            if self.mFormationAssistPreviewPanel then
                self.mFormationAssistPreviewPanel:close()
            end

            if self.mFormationAssistPreviewPanel then
                self.mFormationAssistSelectPanel:close()
            end

            if self.m_heroFormationPanel then
                self.m_heroFormationPanel:close()
            end

        end
    end
end

-- 请求修改阵型英雄列表
function __onReqFormationHeroListHandler(self, args)
    local list = {}

    local function GetFormationData(teamId, formationId)
        local teamVo = self:getManager():getTeamVoByTeamId(teamId)
        local selectHeroList = self:getManager():getSelectFormationHeroList(teamId)
        local selectAssistHeroList = self:getManager():getSelectTeamAssistHeroList(teamId)
        local data = {}
        data.team_id = teamId
        data.name = teamVo.teamName
        formationId = formationId or teamVo.formationId
        data.formation_id = formationId
        data.is_ready = self:getManager():isTeamIdInFight(teamId) and 1 or 0
        data.formation_hero_list = {}
        data.assist_fight_list = {}
        for k, formationHeroVo in pairs(selectHeroList) do
            if formationHeroVo.sourceType == formation.HERO_SOURCE_TYPE.OWN then --差异在这里
                local vo = {}
                vo.is_captain = formationHeroVo.isCaptainHero and 1 or 0
                vo.pos = formationHeroVo.heroPos
                vo.hero_id = formationHeroVo.heroId
                vo.hero_source = formationHeroVo.sourceType
                vo.tid = formationHeroVo:getHeroTid()
                -- vo.lv = formationHeroVo:getHeroLvl()
                -- vo.evolution = formationHeroVo:getHeroEvolutionLvl()
                table.insert(data.formation_hero_list, vo)
            end
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
        self.m_heroFormationPanel = formation.FormationActivityDupPanel.new()
        self.m_heroFormationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    end
    self.m_heroFormationPanel:open({manager = self:getManager()})
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
