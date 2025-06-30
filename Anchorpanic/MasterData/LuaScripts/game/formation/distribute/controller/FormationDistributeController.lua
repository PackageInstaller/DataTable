module("formation.FormationDistributeController", Class.impl("game.formation.normal.controller.FormationController"))

---------------------------------------------------------------固定需要-----------------------------------------------------------------
function getManager(self)
    return formation.FormationDistributeManager
end

--屏蔽，由父类一次性请求
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    super.listNotification(self)

    -- 打开英雄阵型分配面板
    self:getManager():addEventListener(self:getManager().OPEN_FORMATION_DISTRIBUTE_SELECT_PANEL, self.__onOpenFormationDistributeSelectPanelHandler, self)
    
    -- 请求设置支援队员列表
    self:getManager():addEventListener(self:getManager().REQ_SET_SUPPORT_HERO, self.__onReqSetSupportHeroLsitHandler, self)
    -- 请求获取支援队员列表
    self:getManager():addEventListener(self:getManager().REQ_GET_SUPPORT_HERO, self.__onReqGetSupportHeroLsitHandler, self)
end

--屏蔽，由父类一次性注册
function registerMsgHandler(self)
    local msgDic = super.registerMsgHandler(self)
    --- *s2c* 设置支援战员列表返回 13093
    msgDic["SC_SET_STORY_BATTLE_SUPPORT_HERO_LIST"] = self.__onResSetSupportHeroListSHandler
    --- *s2c* 选择支援战员列表返回 13095
    msgDic["SC_GET_STORY_BATTLE_SUPPORT_HERO_LIST"] = self.__onResSupportHeroListSHandler
    return msgDic

     -- return {
     --     --- *s2c* 设置支援战员列表返回 13093
     --     SC_SET_STORY_BATTLE_SUPPORT_HERO_LIST = self.__onResSetSupportHeroListSHandler,
     --     --- *s2c* 选择支援战员列表返回 13095
     --     SC_GET_STORY_BATTLE_SUPPORT_HERO_LIST = self.__onResSupportHeroListSHandler,
     -- }
end

---------------------------------------------------------------响应------------------------------------------------------------------
-- 设置支援战员列表返回 13093
function __onResSetSupportHeroListSHandler(self, msg)
    if(msg.result == 1)then
        print("选择支援战员列表成功")
        self:getManager():dispatchEvent(self:getManager().RES_SET_SUPPORT_HERO, {})
    else
        print("选择支援战员列表失败")
    end
end

-- *s2c* 选择支援战员列表返回 13095
function __onResSupportHeroListSHandler(self, msg)
    self:getManager():parseDistributeData(msg.dup_type, msg.dup_id,  msg.support_list)
end

---------------------------------------------------------------请求------------------------------------------------------------------
-- 剧情战斗自选支援战员列表
function __onReqSetSupportHeroLsitHandler(self, args)
    -- 测试
    -- self:getManager():setDistributeData(args.battleType, args.dupId, 1, args.selectList_1, 2, args.selectList_2)
    -- self:__onResSupportHeroListSHandler({result = 1})

    self:getManager():setDistributeData(args.battleType, args.dupId, 1, args.selectList_1, 2, args.selectList_2)
    local list = {}
    local selectData = self:getManager():getDistributeData(args.battleType, args.dupId)
    for k, v in pairs(selectData) do
        local data = {}
        data.team_index = v.teamIndex
        data.support_id_list = v.selectIdList
        table.insert(list, data)
    end
    --- *c2s* 剧情战斗自选支援战员列表 13092
    SOCKET_SEND(Protocol.CS_SET_STORY_BATTLE_SUPPORT_HERO_LIST, { dup_type = args.battleType, dup_id = args.dupId, support_list = list })
end

-- 剧情战斗自选支援战员列表
function __onReqGetSupportHeroLsitHandler(self, args)
    --- *c2s* 剧情战斗自选支援战员列表 13094
    SOCKET_SEND(Protocol.CS_GET_STORY_BATTLE_SUPPORT_HERO_LIST, { dup_type = args.battleType, dup_id = args.dupId})
end

---------------------------------------------------------------按需重写-----------------------------------------------------------------

-- 固定阵型屏蔽选择界面
function __onOpenFormationHeroSelectPanelHandler(self, args)
end

function __openFormationPanel(self)
    if self.m_heroFormationPanel == nil then
        self.m_heroFormationPanel = formation.FormationDistributePanel.new()
        self.m_heroFormationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    end
    self.m_heroFormationPanel:open({manager = self:getManager()})
end

------------------------------------------------------------------------ 剧情英雄阵型推荐界面 ------------------------------------------------------------------------
function __onOpenFormationDistributeSelectPanelHandler(self, args)
    if self.m_distributeSelectPanel == nil then
        self.m_distributeSelectPanel = formation.FormationDistributeHeroSelectPanel.new()
        self.m_distributeSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationDistributeSelectPanelHandler, self)
    end
    -- 剧情派发参数
    if (args) then
        self.storyArgs = args.data
    end
    local storyRoId = self.storyArgs[1]
    local storyRo = storyTalk.StoryTalkManager:getStoryRo(storyRoId)
    if(storyRo)then
        self.m_distributeSelectPanel:open({storyRo = storyRo, manager = self:getManager()})
    end
end

function onDestroyFormationDistributeSelectPanelHandler(self)
    self.m_distributeSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationDistributeSelectPanelHandler, self)
    self.m_distributeSelectPanel = nil
    -- 剧情派发参数
    if (self.storyArgs) then
        GameDispatcher:dispatchEvent(EventName.STORY_BACK_TO_STORY, self.storyArgs)
        self.storyArgs = nil
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
