--[[ 
-----------------------------------------------------
@filename       : FormationTeachingController
@Description    : 上阵教学
@date           : 2021-08-31 15:13:41
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("formation.FormationTeachingController", Class.impl("game.formation.normal.controller.FormationController"))

---------------------------------------------------------------固定需要-----------------------------------------------------------------
function getManager(self)
    return formation.FormationTeachingManager
end

--屏蔽，由父类一次性请求
function gameStartCallBack(self)
end

--屏蔽，由父类一次性注册
-- function registerMsgHandler(self)
-- end

-- 请求修改阵型英雄列表
function __onReqFormationHeroListHandler(self, args)
    local list = {}
    local changeTeamIdList = self:getManager():getChangeTeamIdList()
    for k, teamId in pairs(changeTeamIdList) do
        local selectList = self:getManager():getSelectFormationHeroList(teamId)
        local data = {}
        data.team_id = teamId
        data.name = ""
        data.formation_id = self:getManager():getFightFormationId()
        data.is_ready = self:getManager():isTeamIdInFight(teamId) and 1 or 0
        data.formation_hero_list = {}
        data.assist_fight_list = {}
        data.pet_id = 0
        -- 临时处理，随便弄个队长，后面换ui同事对比阵型的看怎么处理
        local _ = false
        for k, formationHeroVo in pairs(selectList) do
            local vo = {}
            vo.is_captain = _ and 0 or 1
            _ = true
            vo.pos = formationHeroVo.heroPos
            vo.hero_id = formationHeroVo.heroId
            vo.hero_source = formationHeroVo.sourceType
            -- vo.tid = formationHeroVo:getHeroTid()
            -- vo.lv = formationHeroVo:getHeroLvl()
            vo.evolution = formationHeroVo:getHeroEvolutionLvl()
            table.insert(data.formation_hero_list, vo)
        end
        table.insert(list, data)
    end
    if(#list > 0)then
        -- gs.Message.Show("请求更新阵型英雄列表")
        --- *c2s* 请求更新阵型英雄列表 13046
        SOCKET_SEND(Protocol.CS_CHANGE_HERO, { type = formation.getFormationTypeByController(self), formation_list = list ,is_lock = 0})
        GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)
    end
end

---------------------------------------------------------------按需重写-----------------------------------------------------------------
function __openFormationPanel(self)
    if self.m_heroFormationPanel == nil then
        self.m_heroFormationPanel = formation.FormationTeachingPanel.new()
        self.m_heroFormationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    end
    self.m_heroFormationPanel:open({manager = self:getManager()})
end

function __onOpenFormationHeroSelectPanelHandler(self, args)
    if self.mFormationHeroSelectPanel == nil then
        self.mFormationHeroSelectPanel = formation.FormationTeachingHeroSelectPanel.new()
        self.mFormationHeroSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationHeroSelectPanelHandler, self)
    end
    self.mFormationHeroSelectPanel:open({manager = self:getManager(), data = args})
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
