--[[ 
-----------------------------------------------------
@filename       : OrderFactoryController
@Description    : 序列物加工厂
@date           : 2021-06-23 20:24:30
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.orderFactory.controller.OrderFactoryController', Class.impl(Controller))

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
    GameDispatcher:addEventListener(EventName.OPEN_ORDER_FACTORY_PANEL, self.onOpenOrderFactoryPanel, self)
    GameDispatcher:addEventListener(EventName.REQ_ORDER_PROCESS, self.onReqOrderProcess, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        --已弃用
        SC_PROCESS_DEVICE = self.onProcessOrderMsg
    }
end

--- *c2s* 加工序列物 21054
function onReqOrderProcess(self, args)
    local cmd = {}
    cmd.process_id = args.processId
    cmd.item_id_list = self.mMgr:getSelectMaterialList()
    SOCKET_SEND(Protocol.CS_PROCESS_DEVICE, cmd)
end


--- *s2c* 加工序列物 21055
function onProcessOrderMsg(self, msg)
  self.mMgr:parseProcessOrderMsg(msg)
end

--------------------------逻辑相关--------------------------------------
---------------------------UI相关---------------------------------------
-- 打开主界面
function onOpenOrderFactoryPanel(self, args)
    -- if self.mMgr:isOpen() == false then
    --     return
    -- end
    local helperIdList = covenant.CovenantManager:getHelperIdList()
    if not helperIdList or #helperIdList <= 0 then
        gs.Message.Show("未加入势力")
        return
    end
    if self.mTalentPanel == nil then
        self.mTalentPanel = UI.new(orderFactory.OrderFactoryPanel)
        self.mTalentPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOrderFactoryPanelHandler, self)
    end
    self.mTalentPanel:open(args)
end
-- ui销毁
function onDestroyOrderFactoryPanelHandler(self)
    self.mTalentPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyOrderFactoryPanelHandler, self)
    self.mTalentPanel = nil
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
