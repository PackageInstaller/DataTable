--[[ 
-----------------------------------------------------
@filename       : TeachingController
@Description    : 上阵教学控制器
@date           : 2021-08-30 17:06:59
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.teaching.controller.TeachingController', Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)

end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_TEACHING_PANEL, self.onOpenPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_TEACHING_TIPS_VIEW, self.onOpenTipsView, self)
    GameDispatcher:addEventListener(EventName.REQ_TEACHING_FORMATION_FIGHT, self.__onReqFormationHeroListHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {

    }
end

-- 请求修改阵型英雄列表
function __onReqFormationHeroListHandler(self, args)
    local list = {}
    local changeTeamIdList = formation.getTeamIdListByType(formation.TYPE.TEACHING, formation.FormationManager:getDataId())
    for k, teamId in pairs(changeTeamIdList) do
        local selectList = self.mMgr:getSelectHeroList()
        local data = {}
        data.team_id = teamId
        data.name = ""
        data.formation_id = args.formationId
        data.is_ready = 1
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
            vo.tid = formationHeroVo:getHeroTid()
            -- vo.lv = formationHeroVo:getHeroLvl()
            -- vo.evolution = formationHeroVo:getHeroEvolutionLvl()
            table.insert(data.formation_hero_list, vo)
        end
        table.insert(list, data)
    end
    if (#list > 0) then
        -- gs.Message.Show("请求更新阵型英雄列表")
        --- *c2s* 请求更新阵型英雄列表 13046
        SOCKET_SEND(Protocol.CS_CHANGE_HERO, { type = formation.TYPE.NONE, formation_list = list ,is_lock = 0})
        GameDispatcher:dispatchEvent(EventName.REQ_CANNOTDEL_HERO_DATA)

        fight.FightManager:reqBattleEnter(args.battleType, args.dupId)
    end
end



function onOpenPanel(self, args)
    if self.mTeachingPanel == nil then
        self.mTeachingPanel = UI.new(teaching.TeachingPanel)
        self.mTeachingPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTeachingPanelHandler, self)
    end
    self.mTeachingPanel:open(args)
end

-- ui销毁
function onDestroyTeachingPanelHandler(self)
    self.mTeachingPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTeachingPanelHandler, self)
    self.mTeachingPanel = nil
end

function onOpenTipsView(self, args)
    if self.mTeachingTipsView == nil then
        self.mTeachingTipsView = UI.new(teaching.TeachingTipsView)
        self.mTeachingTipsView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTeachingTipViewHandler, self)
    end
    self.mTeachingTipsView:open(args)
end

-- ui销毁
function onDestroyTeachingTipViewHandler(self)
    self.mTeachingTipsView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTeachingTipViewHandler, self)
    self.mTeachingTipsView = nil
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
