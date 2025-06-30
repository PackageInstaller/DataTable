-- @FileName:   GuildBossImitateController.lua
-- @Description:   公会训练Control
-- @Author: ZDH
-- @Date:   2024-04-10 10:33:14
-- @Copyright:   (LY) 2024 锚点降临

module("guildBossImitate.GuildBossImitateController", Class.impl(Controller))

--构造函数
function ctor(self, cusMgr)
    super.ctor(self, cusMgr)
end

--析构函数
function dtor(self)
end

-- Override 重新登录
function reLogin(self)
    super.reLogin(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSSIMITATE_STAGEPANEL, self.onOpenGuildBossImitateStagePanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSSIMITATE_LEVELSELECTPANEL, self.onOpenGuildBossImitateLevelSelectPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSSIMITATE_RANKPANEL, self.onOpenGuildBossImitateRankPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_GUILDBOSSIMITATE_RESULTVIEW, self.onOpenGuildBossImitateResultView, self)

    GameDispatcher:addEventListener(EventName.REQ_GUILDBOSSIMITATE_DUPINFO, self.onReqGuildBossImitateDupInfo, self)
    GameDispatcher:addEventListener(EventName.REQ_GUILDBOSSIMITATE_RANKDATA, self.onReqGuildBossImitateRankData, self)

    GameDispatcher:addEventListener(EventName.RECEIVE_LEAVEGUILD, self.onLeaveGuildHandler, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_GUILD_TRAIN_DUP_PANEL = self.onReceiveGuildBossImitateDupInfo,
        SC_GUILD_TRAIN_RANK = self.onReceiveGuildBossImitateRankData,

    }
end

function onLeaveGuildHandler(self)
    -- 不再主界面不做任何处理
    if map.MapManager:getMapType() ~= MAP_TYPE.MAIN_CITY then
        return
    end

    if self.mGuildBossImitateStagePanel then
        self.mGuildBossImitateStagePanel:close()
    end

    if self.mGuildBossImitateLevelSelectPanel then
        self.mGuildBossImitateLevelSelectPanel:close()

    end
    if self.mGuildBossImitateRankPanel then
        self.mGuildBossImitateRankPanel:close()
    end

    if self.mGuildBossImitateStagePanel or self.mGuildBossImitateLevelSelectPanel or self.mGuildBossImitateRankPanel then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Guild})
    end
end

function onReqGuildBossImitateDupInfo(self, dupId)
    -- logAll(dupId, "19831 请求公会训练场面板信息")
    SOCKET_SEND(Protocol.CS_GUILD_TRAIN_DUP_PANEL, {dup_id = dupId}, Protocol.SC_GUILD_TRAIN_DUP_PANEL)
end

function onReceiveGuildBossImitateDupInfo(self, msg)
    -- logAll(msg, "19832 收到公会训练场面板信息")
    ---- dup_id my_rank my_rank_val
    guildBossImitate.GuildBossImitateManager:setDupInfoData(msg)
    GameDispatcher:dispatchEvent(EventName.RECEIVE_GUILDBOSSIMITATE_DUPINFO, msg.dup_id)
end

function onReqGuildBossImitateRankData(self, dupId)
    -- logAll(dupId, "19834 请求公会训练场排行信息")
    SOCKET_SEND(Protocol.CS_GUILD_TRAIN_RANK, {dup_id = dupId}, Protocol.SC_GUILD_TRAIN_RANK)
end

function onReceiveGuildBossImitateRankData(self, msg)
    -- logAll(msg, "19835 收到公会训练场排行信息")
    GameDispatcher:dispatchEvent(EventName.RECEIVE_GUILDBOSSIMITATE_RANKDATA, msg)
end

-----------------------------------------------View
function onOpenGuildBossImitateStagePanel(self, args)
    if not guild.GuildManager:getJoinGuilded() then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Guild})
        return
    end

    if self.mGuildBossImitateStagePanel == nil then
        self.mGuildBossImitateStagePanel = guildBossImitate.GuildBossImitateStagePanel.new()
        self.mGuildBossImitateStagePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossImitateStagePanelHandler, self)
    end
    self.mGuildBossImitateStagePanel:open(args)
end

function onDestoryGuildBossImitateStagePanelHandler(self)
    self.mGuildBossImitateStagePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossImitateStagePanelHandler, self)
    self.mGuildBossImitateStagePanel = nil
end

function onOpenGuildBossImitateLevelSelectPanel(self, args)
    if self.mGuildBossImitateLevelSelectPanel == nil then
        self.mGuildBossImitateLevelSelectPanel = guildBossImitate.GuildBossImitateLevelSelectPanel.new()
        self.mGuildBossImitateLevelSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossImitateLevelSelectPanelHandler, self)
    end
    self.mGuildBossImitateLevelSelectPanel:open(args)
end

function onDestoryGuildBossImitateLevelSelectPanelHandler(self)
    self.mGuildBossImitateLevelSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossImitateLevelSelectPanelHandler, self)
    self.mGuildBossImitateLevelSelectPanel = nil
end

function onOpenGuildBossImitateRankPanel(self, args)
    if self.mGuildBossImitateRankPanel == nil then
        self.mGuildBossImitateRankPanel = guildBossImitate.GuildBossImitateRankPanel.new()
        self.mGuildBossImitateRankPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossImitateRankPanelHandler, self)
    end
    self.mGuildBossImitateRankPanel:open(args)
end

function onDestoryGuildBossImitateRankPanelHandler(self)
    self.mGuildBossImitateRankPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossImitateRankPanelHandler, self)
    self.mGuildBossImitateRankPanel = nil
end

function onOpenGuildBossImitateResultView(self, args)
    if self.mGuildBossImitateResultView == nil then
        self.mGuildBossImitateResultView = guildBossImitate.GuildBossImitateResultView.new()
        self.mGuildBossImitateResultView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossImitateResultViewHandler, self)
    end
    self.mGuildBossImitateResultView:open(args)
end

function onDestoryGuildBossImitateResultViewHandler(self)
    self.mGuildBossImitateResultView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestoryGuildBossImitateResultViewHandler, self)
    self.mGuildBossImitateResultView = nil
end

return _M
