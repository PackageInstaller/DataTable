module("formation.FormationController", Class.impl(Controller))

-- 构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

-- 析构函数
function dtor(self)
    super.dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

function getManager(self)
    return formation.FormationManager
end

-- 游戏开始的回调
function gameStartCallBack(self)
    super.gameStartCallBack(self)
end

-- 模块间事件监听
function listNotification(self)
    super.listNotification(self)

    -- 打开阵型选择面板
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_SELECT_PANEL,
    self.__onOpenFormationSelectPanelHandler, self)
    -- 打开阵型英雄选择面板
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_HERO_SELECT_PANEL,
    self.__onOpenFormationHeroSelectPanelHandler, self)
    -- 关闭阵型英雄选择面板
    self:getManager():addEventListener(self:getManager().CLOSE_FORMATION_HERO_SELECT_PANEL,
    self.__onCloseFormationHeroSelectPanel, self)
    -- 打开助战面板
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_ASSIST_PANEL, self.__onOpenAssistPanelHandler,
    self)
    -- 打开助战预览面板
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_ASSIST_PREVIEW_PANEL,
    self.__onOpenAssistPreviewPanelHandler, self)
    -- 打开助战英雄选择面板
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_ASSIST_HERO_SELECT_PANEL,
    self.__onOpenAssistHeroSelectPanelHandler, self)
    -- 打开阵型队长选择面板
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_CAPTAIN_SELECT_PANEL,
    self.__onOpenFormationCaptainSelectPanelHandler, self)
    -- 打开阵型队列名修改面板
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_MODIFY_TEAM_NAME_PANEL,
    self.__onOpenFormationModifyTeamNamePanelHandler, self)

    -- 请求阵型列表
    self:getManager():addEventListener(self:getManager().REQ_FORMATION_LIST, self.__onReqFormationListHandler, self)
    -- 请求改变阵型
    self:getManager():addEventListener(self:getManager().REQ_FORMATION_CHANGE, self.__onReqFormationChangeHandler, self)
    -- 请求设置出战
    self:getManager():addEventListener(self:getManager().REQ_SET_FIGHT_TEAM, self.__onReqSetFightTeamHandler, self)
    -- 请求改变阵型英雄列表
    self:getManager():addEventListener(self:getManager().REQ_FORMATION_HERO_LIST, self.__onReqFormationHeroListHandler,
    self)
    -- 请求阵型队列改名
    self:getManager():addEventListener(self:getManager().REQ_MODIFY_TEAM_NAME, self.__onReqModifyTeamNameHandler, self)
    -- 打开元素同调
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_ELEMENT, self.__onOpenFormationElementHandler,
    self)
    -- 打开战场环境
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_POSEFF, self.__onOpenFormationPosEffHandler,
    self)

    -- 打开战场环境
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_TARGET, self.__onOpenFormationTargetHandler,
    self)
end

-- 注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 英雄阵型列表 13041
        SC_HERO_FORMATION = self.__onResFormationListHandler,
        --- *s2c* 改变阵型 13043
        SC_CHANGE_FORMATION = self.__onResFormationChangeHandler,
        --- *s2c* 设置出战 13045
        SC_SET_READY = self.__onResSetFightTeamHandler,
        --- *s2c* 返回更新阵型英雄列表 13047
        SC_CHANGE_HERO = self.__onResFormationHeroListHandler,
        --- *s2c* 编队改名 13049
        SC_RENAME_FORMATION = self.__onResModifyTeamNameHandler
    }
end

--------------------------------------------------------避免模块同一协议多次触发--------------------------------------------------------
-- 是否可以响应（为了避免多次触发，这里只由对应类型控制器处理）
function __canRes(self, formationType, teamId)
    if (teamId) then
        -- local formationType = formation.getFormationTypeById(teamId)
        local controller = formation.getFormationController(formationType)
        if (controller == self) then
            return true
        end
        return false
    else
        return self.__cname == formation.FormationController.__cname
    end
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 阵型列表返回 13041
function __onResFormationListHandler(self, msg)
    if (not self:__canRes(msg.type, nil)) then
        return
    end
    self:getManager():parseFormationList(msg.formation_list)
end

-- 改变阵型返回 13043
function __onResFormationChangeHandler(self, msg)
    if (not self:__canRes(msg.type, msg.team_id)) then
        return
    end
    if (msg.result == 1) then
        self:getManager():updateTeamFormationId(msg.team_id, msg.formation_id)
        gs.Message.Show(_TT(1263))
    else
        gs.Message.Show(_TT(1264))
    end
end

-- 设置出战 13045
function __onResSetFightTeamHandler(self, msg)
    if (not self:__canRes(msg.type, msg.team_id)) then
        return
    end
    if (msg.result == 1) then
        self:getManager():updateFightTeamId(msg.team_id)
        -- gs.Message.Show("设置出战队列成功")
    else
        gs.Message.Show(_TT(1265))
    end
end

-- 阵型英雄列表返回 13047
function __onResFormationHeroListHandler(self, msg)
    if (#msg.formation_list > 0) then
        if (not self:__canRes(msg.type, msg.formation_list[1].team_id)) then
            return
        end
        local isShowTip = false
        if (#msg.formation_list > 0) then
            local msgVo = msg.formation_list[1]
            local formationType = formation.getFormationTypeById(msgVo.team_id)
            if (formationType == formation.TYPE.ARENA_DEFENSE or formationType == formation.TYPE.ARENA_ATTACK
            or formationType == formation.TYPE.ARENA_PEAK_ATTACK or formationType == formation.TYPE.ARENA_PEAK_DEFENSE) then
                isShowTip = true
            end
        end
        if (msg.result == 1) then
            if (isShowTip) then
                gs.Message.Show(_TT(49712)) -- 保存成功
            end
            self:getManager():parseFormationHeroList(msg.formation_list)
        else
            if (isShowTip) then
                gs.Message.Show(_TT(49713)) -- 保存失败
            end
            self:getManager():dispatchEvent(self:getManager().UPDATE_TEAM_FORMATION_DATA, {})
        end
        GameDispatcher:dispatchEvent(EventName.UPDATE_GUILD_RED_INFO)
    end
end

-- 编队改名 13049
function __onResModifyTeamNameHandler(self, msg)
    if (not self:__canRes(msg.type, msg.team_id)) then
        return
    end
    -- result:结果,1成功0失败,(2-长度限制,3-敏感词汇,4-特殊词汇,5-改名cd
    if (msg.result == 1) then
        self:getManager():updateTeamName(msg.team_id, msg.name)
        gs.Message.Show(_TT(1266))
    else
        gs.Message.Show(_TT(513)) -- "存在敏感字或非法符号"
    end
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 请求阵型列表
function __onReqFormationListHandler(self, args)
    --- *c2s* 英雄阵型列表 13040
    SOCKET_SEND(Protocol.CS_HERO_FORMATION, {
        type = formation.getFormationTypeByController(self)
    }, Protocol.SC_HERO_FORMATION)
end

-- 请求改变阵型
function __onReqFormationChangeHandler(self, args)
    local isLock, formationId = self:getManager():isLockFormation()
    if isLock == 1 then
        args.formationId = formationId
    end
    --- *c2s* 改变阵型 13042 
    SOCKET_SEND(Protocol.CS_CHANGE_FORMATION, {
        type = formation.getFormationTypeByController(self),
        team_id = args.teamId,
        formation_id = args.formationId,
        is_lock = isLock
    }, Protocol.SC_CHANGE_FORMATION)
end

-- 请求设置出战
function __onReqSetFightTeamHandler(self, args)
    --- *c2s* 设置出战 13044
    SOCKET_SEND(Protocol.CS_SET_READY, {
        type = formation.getFormationTypeByController(self),
        team_id = args.teamId
    }, Protocol.SC_SET_READY)
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

-- 请求编队改名
function __onReqModifyTeamNameHandler(self, args)
    --- *c2s* 编队改名 13048
    SOCKET_SEND(Protocol.CS_RENAME_FORMATION, {
        type = formation.getFormationTypeByController(self),
        team_id = args.teamId,
        name = args.name
    }, Protocol.SC_RENAME_FORMATION)
end

------------------------------------------------------------------------ 英雄阵型面板 ------------------------------------------------------------------------
-- 打开阵型选阵界面
function openFormationPanel(self, formationType, cusDataId, data, callFun)
    if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_HERO_TEAM, true) == true then
        self:getManager():setData(formationType, cusDataId, data, callFun)
        self:__openFormationPanel()
    end
end

function __openFormationPanel(self)
    if self.m_heroFormationPanel == nil then
        self.m_heroFormationPanel = formation.FormationPanel.new()
        self.m_heroFormationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    end
    self.m_heroFormationPanel:open({
        manager = self:getManager()
    })
end

function __destroyHeroFormationPanel(self)
    self.m_heroFormationPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    self.m_heroFormationPanel = nil
end

------------------------------------------------------------------------ 阵型选择面板 ------------------------------------------------------------------------
function __onOpenFormationSelectPanelHandler(self, args)
    if self.mFormationSelectPanel == nil then
        self.mFormationSelectPanel = formation.FormationSelectPanel.new()
        self.mFormationSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationSelectPanelHandler,
        self)
    end
    self.mFormationSelectPanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestroyFormationSelectPanelHandler(self)
    self.mFormationSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationSelectPanelHandler,
    self)
    self.mFormationSelectPanel = nil
end

------------------------------------------------------------------------ 阵型英雄选择面板 ------------------------------------------------------------------------
function __onOpenFormationHeroSelectPanelHandler(self, args)
    if self.mFormationHeroSelectPanel == nil then
        self.mFormationHeroSelectPanel = formation.FormationHeroSelectPanel.new()
        self.mFormationHeroSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyFormationHeroSelectPanelHandler, self)
    end
    self.mFormationHeroSelectPanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestroyFormationHeroSelectPanelHandler(self)
    self.mFormationHeroSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
    self.onDestroyFormationHeroSelectPanelHandler, self)
    self.mFormationHeroSelectPanel = nil
end

function __onCloseFormationHeroSelectPanel(self)
    if self.mFormationHeroSelectPanel ~= nil then
        self.mFormationHeroSelectPanel:close()
    end
end

------------------------------------------------------------------------ 助战选择面板 ------------------------------------------------------------------------
function __onOpenAssistPanelHandler(self, args)
    if self.mFormationAssistPanel == nil then
        self.mFormationAssistPanel = formation.FormationAssistPanel.new()
        self.mFormationAssistPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAssistPanelHandler, self)
    end
    self.mFormationAssistPanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestroyAssistPanelHandler(self)
    self.mFormationAssistPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyAssistPanelHandler, self)
    self.mFormationAssistPanel = nil
end

function __onOpenAssistPreviewPanelHandler(self, args)
    if self.mFormationAssistPreviewPanel == nil then
        self.mFormationAssistPreviewPanel = formation.FormationAssistPreviewPanel.new()
        self.mFormationAssistPreviewPanel:addEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyAssistPreviewPanelHandler, self)
    end
    self.mFormationAssistPreviewPanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestroyAssistPreviewPanelHandler(self)
    self.mFormationAssistPreviewPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
    self.onDestroyAssistPreviewPanelHandler, self)
    self.mFormationAssistPreviewPanel = nil
end

------------------------------------------------------------------------ 英雄助战选择面板 ------------------------------------------------------------------------
function __onOpenAssistHeroSelectPanelHandler(self, args)
    if self.mFormationAssistSelectPanel == nil then
        self.mFormationAssistSelectPanel = formation.FormationAssistSelectPanel.new()
        self.mFormationAssistSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyAssistHeroSelectPanelHandler, self)
    end
    self.mFormationAssistSelectPanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestroyAssistHeroSelectPanelHandler(self)
    self.mFormationAssistSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
    self.onDestroyAssistHeroSelectPanelHandler, self)
    self.mFormationAssistSelectPanel = nil
end

------------------------------------------------------------------------ 英雄阵型选择面板 ------------------------------------------------------------------------
function __onOpenFormationCaptainSelectPanelHandler(self, args)
    if self.mFormationCaptainSelectPanel == nil then
        self.mFormationCaptainSelectPanel = formation.FormationCaptainSelectPanel.new()
        self.mFormationCaptainSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyFormationCaptainSelectPanelHandler, self)
    end
    self.mFormationCaptainSelectPanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestroyFormationCaptainSelectPanelHandler(self)
    self.mFormationCaptainSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY,
    self.onDestroyFormationCaptainSelectPanelHandler, self)
    self.mFormationCaptainSelectPanel = nil
end

------------------------------------------------------------------------ 英雄队列名修改面板 ------------------------------------------------------------------------
function __onOpenFormationModifyTeamNamePanelHandler(self, args)
    if self.mFormationModifyTeamNamePanel == nil then
        self.mFormationModifyTeamNamePanel = formation.FormationModifyTeamNamePanel.new()
        self.mFormationModifyTeamNamePanel:addEventListener(View.EVENT_VIEW_DESTROY,
        self.onDestroyFormationModifyTeamNamePanelHandler, self)
    end
    self.mFormationModifyTeamNamePanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestroyFormationModifyTeamNamePanelHandler(self)
    self.mFormationModifyTeamNamePanel:removeEventListener(View.EVENT_VIEW_DESTROY,
    self.onDestroyFormationModifyTeamNamePanelHandler, self)
    self.mFormationModifyTeamNamePanel = nil
end

------------------------------------------------------------------------ 元素同调面板 ------------------------------------------------------------------------
function __onOpenFormationElementHandler(self, args)
    if self.mFormationElementPanel == nil then
        self.mFormationElementPanel = formation.FormationElementHomologyPanel.new()
        self.mFormationElementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryElementPanelHandler, self)
    end
    self.mFormationElementPanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestoryElementPanelHandler(self)
    self.mFormationElementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryElementPanelHandler, self)
    self.mFormationElementPanel = nil
end
------------------------------------------------------------------------ 战场环境面板 ------------------------------------------------------------------------
function __onOpenFormationPosEffHandler(self, args)
    if self.mFormationPosEffPanel == nil then
        self.mFormationPosEffPanel = formation.FormationPosEffPanel.new()
        self.mFormationPosEffPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryPosEffPanelHandler, self)
    end
    self.mFormationPosEffPanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestoryPosEffPanelHandler(self)
    self.mFormationPosEffPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryPosEffPanelHandler, self)
    self.mFormationPosEffPanel = nil
end

function __onOpenFormationTargetHandler(self,args)
    if self.mFormationTargetPanel == nil then
        self.mFormationTargetPanel = formation.FormationTargetPanel.new()
        self.mFormationTargetPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryTargetPanelHandler, self)
    end
    self.mFormationTargetPanel:open({
        manager = self:getManager(),
        data = args
    })
end

function onDestoryTargetPanelHandler(self)
    self.mFormationTargetPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryTargetPanelHandler, self)
    self.mFormationTargetPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1266):	"编队改名成功"
	语言包: _TT(1265):	"设置出战队列失败"
	语言包: _TT(1264):	"选择阵型失败"
	语言包: _TT(1263):	"选择阵型成功"
]]