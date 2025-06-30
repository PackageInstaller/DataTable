--[[ 
-----------------------------------------------------
@filename       : CovenantTalentController
@Description    : 战盟天赋
@date           : 2021-06-16 17:34:14
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.covenantTalent.controller.CovenantTalentController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_TALENT_PANEL, self.onOpenCovenantTalentPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_BAG_PANEL, self.onOpenCovenantBagPanel, self)
    GameDispatcher:addEventListener(EventName.OPEN_COVENANT_TALENT_RESET, self.onOpenCovenantResetPanel, self)

    GameDispatcher:addEventListener(EventName.REQ_ALL_HELPER_GENE_INFO, self.onReqAllGeneInfo, self)
    GameDispatcher:addEventListener(EventName.REQ_GENE_LVL_UP, self.onReqGeneLvlUp, self)
    GameDispatcher:addEventListener(EventName.REQ_GENE_ORDER_LOAD, self.onReqGeneOrderLoad, self)
    GameDispatcher:addEventListener(EventName.REQ_GENE_ORDER_UNLOAD, self.onReqGeneOrderUnload, self)
    GameDispatcher:addEventListener(EventName.REQ_GENE_ORDER_REPLACE, self.onReqGeneOrderReplace, self)
    GameDispatcher:addEventListener(EventName.REQ_GENE_RESET, self.onReqResetGene, self)
    GameDispatcher:addEventListener(EventName.REQ_ACTIVE_GROOVE, self.onReqActiveGroove, self)

    GameDispatcher:addEventListener(EventName.REQ_JOIN_RESULT, self.onForcesChangeHandler, self)
    GameDispatcher:addEventListener(EventName.REQ_CHANGE_RESULT, self.onForcesChangeHandler, self)

end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        ---已弃用
        ---SC_HELPER_GENE_INFO = self.onGeneInfoMsg,
        ---已弃用
        ---SC_ALL_HELPER_GENE_INFO = self.onAllGeneInfoMsg,
        ---已弃用
        ---SC_LEVELUP_GENE = self.onGeneLvlUpMsg,
        ---已弃用
        ---SC_LOAD_ORDER = self.onGeneLoadOrderMsg,
        ---已弃用
        ---SC_UNLOAD_ORDER = self.onGeneUnLoadOrderMsg,
        ---已弃用
        ---SC_REPLACE_ORDER = self.onGeneReplaceOrderMsg,
        ---已弃用
        ---SC_RESET_HELPER_GENE = self.onGeneResetMsg,
        ---已弃用
        ---SC_ACTIVE_GROOVE = self.onActiveGrooveMsg,
    }
end

---------------------------消息交互------------------------------------------
--- *c2s* 助手基因信息 21040
function onReqGeneInfo(self, cusId)
    cusLog("已弃用")
    --SOCKET_SEND(Protocol.CS_HELPER_GENE_INFO, { helper_id = cusId })
end
--- *c2s* 所有助手基因信息 21042
function onReqAllGeneInfo(self)
    cusLog("已弃用")
    ---SOCKET_SEND(Protocol.CS_ALL_HELPER_GENE_INFO)
end
--- *c2s* 基因升级 21044
function onReqGeneLvlUp(self, args)
    cusLog("已弃用")
    -- local cmd = {}
    -- cmd.groove_id = args.grooveId
    -- cmd.helper_id = args.helperId
    -- SOCKET_SEND(Protocol.CS_LEVELUP_GENE, cmd)
end
--- *c2s* 助手序列物安装 21046
function onReqGeneOrderLoad(self, args)
    cusLog("已弃用")
    -- local cmd = {}
    -- cmd.helper_id = args.helperId
    -- cmd.groove_id = args.grooveId
    -- cmd.order_id = args.orderId
    -- SOCKET_SEND(Protocol.CS_LOAD_ORDER, cmd)
end
--- *c2s* 卸下助手序列物 21048
function onReqGeneOrderUnload(self, args)
    cusLog("已弃用")
    -- local cmd = {}
    -- cmd.groove_id = args.grooveId
    -- cmd.helper_id = args.helperId
    -- SOCKET_SEND(Protocol.CS_UNLOAD_ORDER, cmd)
end
--- *c2s* 助手序列物替换 21052
function onReqGeneOrderReplace(self, args)
    cusLog("已弃用")
    -- local cmd = {}
    -- cmd.old_helper_id = args.oldHelperId
    -- cmd.old_order_id = args.oldOrderId
    -- cmd.helper_id = args.helperId
    -- cmd.groove_id = args.grooveId
    -- SOCKET_SEND(Protocol.CS_REPLACE_ORDER, cmd)
end
--- *c2s* 重置基因点数 21041
function onReqResetGene(self, cusHelperId)
    cusLog("已弃用")
    -- local cmd = {}
    -- cmd.helper_id = cusHelperId
    -- SOCKET_SEND(Protocol.CS_RESET_HELPER_GENE, cmd)
end
--- *c2s* 激活凹槽 21056
function onReqActiveGroove(self, args)
    cusLog("已弃用")
    -- local cmd = {}
    -- cmd.helper_id = args.helperId
    -- cmd.groove_id = args.grooveId
    -- SOCKET_SEND(Protocol.CS_ACTIVE_GROOVE, cmd)
end




--- *s2c* 助手基因信息 21041
function onGeneInfoMsg(self, msg)
    self.mMgr:parseGeneInfoMsg(msg)
end
--- *s2c* 所有助手基因信息 21043
function onAllGeneInfoMsg(self, msg)
    self.mMgr:parseAllGeneInfoMsg(msg)
end
--- *s2c* 基因升级返回 21045
function onGeneLvlUpMsg(self, msg)
    if msg.result == 1 then
        -- gs.Message.Show2("提升成功")
        gs.Message.Show2(_TT(29525))
    end
    self.mMgr:parseGeneLvlUpMsg(msg)
end
--- *s2c* 助手序列物安装结果返回 21047
function onGeneLoadOrderMsg(self, msg)
    -- gs.Message.Show2("操作成功" .. msg.result)
end
--- *s2c* 卸下助手序列物返回结果 21049
function onGeneUnLoadOrderMsg(self, msg)
    -- gs.Message.Show2("操作成功" .. msg.result)
end
--- *s2c* 替换序列物结果 21051
function onGeneReplaceOrderMsg(self, msg)
    -- gs.Message.Show2("操作成功" .. msg.result)
end
--- *s2c* 重置基因点数 21053
function onGeneResetMsg(self, msg)
    if msg.result == 1 then
        -- gs.Message.Show2("基因重组完成")
        gs.Message.Show2(_TT(29526))
    end
end
--- *s2c* 激活凹槽 21057
function onActiveGrooveMsg(self, msg)
    if msg.result == 1 then
        -- gs.Message.Show2("激活成功")
        gs.Message.Show2(_TT(29527))
    else
        -- gs.Message.Show("激活失败，请激活前置装置")
        gs.Message.Show(_TT(29528))
    end
end

--------------------------逻辑相关--------------------------------------
-- 势力改变
function onForcesChangeHandler(self)
    self.mMgr:clearTalentInfo()
end

---------------------------UI相关---------------------------------------
-- 打开主界面
function onOpenCovenantTalentPanel(self, args)
    -- if self.mMgr:isOpen() == false then
    --     return
    -- end
    local helperIdList = covenant.CovenantManager:getHelperIdList()
    if not helperIdList or #helperIdList <= 0 then
        -- gs.Message.Show("未加入势力")
        gs.Message.Show(_TT(29529))
        return
    end
    if self.mTalentPanel == nil then
        self.mTalentPanel = UI.new(covenantTalent.CovenantTalentPanel)
        self.mTalentPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTalentPanelHandler, self)
    end
    self.mTalentPanel:open(args)
end
-- ui销毁
function onDestroyTalentPanelHandler(self)
    self.mTalentPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyTalentPanelHandler, self)
    self.mTalentPanel = nil
end

-- 打开槽位装备界面
function onOpenCovenantBagPanel(self, args)
    if self.mBagPanel == nil then
        self.mBagPanel = UI.new(covenantTalent.CovenantTalentBagPanel)
        self.mBagPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBagPanelHandler, self)
    end
    self.mBagPanel:open(args)
end
-- ui销毁
function onDestroyBagPanelHandler(self)
    self.mBagPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyBagPanelHandler, self)
    self.mBagPanel = nil
end

-- 打开重组界面
function onOpenCovenantResetPanel(self, args)
    if self.mResetPanel == nil then
        self.mResetPanel = UI.new(covenantTalent.CovenantTalentResetView)
        self.mResetPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyResetViewHandler, self)
    end
    self.mResetPanel:open(args)
end
-- ui销毁
function onDestroyResetViewHandler(self)
    self.mResetPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyResetViewHandler, self)
    self.mResetPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
