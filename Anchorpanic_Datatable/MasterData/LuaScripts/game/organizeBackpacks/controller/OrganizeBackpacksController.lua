--[[
-----------------------------------------------------
@filename       : organizeBackpacks
@Description    : 活动控制器
@date           : 2023-5-22 15:43:34
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.organizeBackpacks.controller.OrganizeBackpacksController', Class.impl(Controller))

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
    --小游戏 --主题活动--整理背包  通关
    GameDispatcher:addEventListener(EventName.PASS_CUR_LEVEL, self.onReqPassLevelHandler, self)
    --小游戏 --主题活动--整理背包关卡
    GameDispatcher:addEventListener(EventName.OPEN_ORGANIZE_BACKPACKS_GAME_DUP_VIEW, self.onOpenOrganizeBackpacksDupViewHandler, self)

    GameDispatcher:addEventListener(EventName.CLOSE_ORGANIZE_BACKPACKS_GAME_DUP_VIEW, self.onCloseOrganizeBackpacksPanelHandler, self)

    --小游戏 --主题活动--整理背包
    GameDispatcher:addEventListener(EventName.OPEN_ORGANIZE_BACKPACKS_GAME_PANEL, self.onOpenOrganizeBackpacksPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_ORGANIZE_BACKPACKS_SETTLEMENT_PANEL, self.onOpenOrganizeBackpacksSettlementPanelHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --- *s2c* 整理背包面板 18181
        SC_PACK_BAG_PANEL = self.onUpdateOrganizeBackpacksPanelHandler,
        SC_PASS_PACK_BAG_RESULT = self.ononUpdateOrganizeBackpacksPassHandler
    }
end

function onUpdateOrganizeBackpacksPanelHandler(self, args)
    organizeBackpacks.OrganizeBackpacksManager:onUpdateLevelList(args)
end

function onReqPassLevelHandler(self, msg)
    local dupVo = organizeBackpacks.OrganizeBackpacksManager:getStageVoById(msg)
    if dupVo:getIsPass() then
        GameDispatcher:dispatchEvent(EventName.OPEN_ORGANIZE_BACKPACKS_SETTLEMENT_PANEL, msg)
        return
    end

    SOCKET_SEND(Protocol.CS_PASS_PACK_BAG, {dup_id = msg}, Protocol.SC_PASS_PACK_BAG_RESULT)
end

function ononUpdateOrganizeBackpacksPassHandler(self, msg)
    if msg.result == 0 then
        logAll("通过失败")
        return
    end

    local dupVo = organizeBackpacks.OrganizeBackpacksManager:getStageVoById(msg.dup_id)
    if dupVo:getIsPass() then
        return
    end

    local awardList = dupVo:getAwardList()
    local propsList = {}
    for k, v in pairs(awardList) do
        table.insert(propsList, {tid = v.tid, count = v.num})
    end
    ShowAwardPanel:showPropsAwardMsg(propsList, function ()
        GameDispatcher:dispatchEvent(EventName.CLOSE_ORGANIZE_BACKPACKS_GAME_DUP_VIEW)
        GameDispatcher:dispatchEvent(EventName.OPEN_ORGANIZE_BACKPACKS_GAME_DUP_VIEW)
    end)
end

---------------------------------2,2活动小游戏整理背包关卡界面-----------------------
function onOpenOrganizeBackpacksDupViewHandler(self, args)
    if self.mOrganizeBackpacksDupView == nil then
        self.mOrganizeBackpacksDupView = organizeBackpacks.OrganizeBackpacksDupView.new()
        self.mOrganizeBackpacksDupView:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOrganizeBackpacksDupView, self)
    end
    self.mOrganizeBackpacksDupView:open(args)
end

function onDestroyOrganizeBackpacksDupView(self)
    self.mOrganizeBackpacksDupView:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOrganizeBackpacksDupView, self)
    self.mOrganizeBackpacksDupView = nil
end
---------------------------------2,2活动小游戏整理背包游戏界面-----------------------
function onOpenOrganizeBackpacksPanelHandler(self, args)
    if self.mOrganizeBackpacksPanel == nil then
        self.mOrganizeBackpacksPanel = organizeBackpacks.OrganizeBackpacksPanel.new()
        self.mOrganizeBackpacksPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOrganizeBackpacksPanel, self)
    end
    self.mOrganizeBackpacksPanel:open(args)
end

function onDestroyOrganizeBackpacksPanel(self)
    self.mOrganizeBackpacksPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOrganizeBackpacksPanel, self)
    self.mOrganizeBackpacksPanel = nil
end

function onCloseOrganizeBackpacksPanelHandler(self)
    if self.mOrganizeBackpacksPanel then
        self.mOrganizeBackpacksPanel:close()
    end
end

function onOpenOrganizeBackpacksSettlementPanelHandler(self, args)
    if self.mOrganizeBackpacksSettlementPanel == nil then
        self.mOrganizeBackpacksSettlementPanel = organizeBackpacks.OrganizeBackpacksSettlementPanel.new()
        self.mOrganizeBackpacksSettlementPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOrganizeBackpacksSettlementPanel, self)
    end
    self.mOrganizeBackpacksSettlementPanel:open(args)
end

function onDestroyOrganizeBackpacksSettlementPanel(self)
    self.mOrganizeBackpacksSettlementPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOrganizeBackpacksSettlementPanel, self)
    self.mOrganizeBackpacksSettlementPanel = nil
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
