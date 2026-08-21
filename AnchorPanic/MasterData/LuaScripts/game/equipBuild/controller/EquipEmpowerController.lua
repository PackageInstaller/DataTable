module("equipBuild.EquipEmpowerController", Class.impl(Controller))

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
    -- 打开芯片培养界面
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_EMPOWER_TIPS_VIEW, self.__onOpenEquipEmpowerPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_EMPOWER_LOCK_SURE_PANEL, self.__onOpenEquipEmpowerLockSurePanelHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_EQUIP_EMPOWER_LOCK_SURE_PANEL, self.__onCloseEquipEmpowerLockSurePanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_EQUIP_EMPOWER_PREPARE_PANEL, self.__onOpenEquipEmpowerPreparePanelHandler, self)
    GameDispatcher:addEventListener(EventName.CLOSE_EQUIP_EMPOWER_PREPARE_PANEL, self.__onCloseEquipEmpowerPreparePanelHandler, self)
    
    
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_EMPOWER_LOCK,self.onReqEquipEmpowerLockHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_EMPOWER_PREPARE,self.onReqEquipEmpowerPpepareHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_SURE_EMPOWER_RESULT,self.onReqSureEmpowerResultHandler,self)
    GameDispatcher:addEventListener(EventName.REQ_EQUIP_EMPOWER_UNCONFIRM,self.onReqEmpowerUnconfirmHandler,self)
    
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
        SC_CHIP_REFACTOR_LOCK = self.onEquipEmpowerLockHandler,
        SC_CHIP_REFACTOR_PREPARE = self.onEquipEmpowerPrepareHandler,
        SC_CHIP_REFACTOR_CONFIRM = self.onReqSureEquipEmpowerResultHandler,
        SC_CHIP_REFACTOR_UNCONFIRM = self.onReqEmpowerUnconfirmResultHandler,
    }
end

function onEquipEmpowerLockHandler(self,msg)
    if msg.result == 1 then
        equipBuild.EquipEmpowerManager:updateEquipEmpowerLockInfo(msg)
    end
end

function onEquipEmpowerPrepareHandler(self,msg)
    if msg.result == 1 then
        equipBuild.EquipEmpowerManager:equipEmpowerPrepareInfo(msg)    
    end
end

function onReqSureEquipEmpowerResultHandler(self,msg)
    if msg.result == 1 then
        equipBuild.EquipEmpowerManager:equipEmpowerResultInfo(msg)
    end
end

function onReqEmpowerUnconfirmResultHandler(self,msg)
    if msg.result == 1 then
        equipBuild.EquipEmpowerManager:oldEmpowerUnconfirm(msg)
    end
end

function onReqEquipEmpowerLockHandler(self,args)
    SOCKET_SEND(Protocol.CS_CHIP_REFACTOR_LOCK,{equip_id = args.equipId,pos = args.pos ,is_lock = args.isLock},Protocol.SC_CHIP_REFACTOR_LOCK)
end

function onReqEquipEmpowerPpepareHandler(self,args)
    SOCKET_SEND(Protocol.CS_CHIP_REFACTOR_PREPARE,{equip_id = args.equipId},Protocol.SC_CHIP_REFACTOR_PREPARE)  
end

function onReqSureEmpowerResultHandler(self,args)
    SOCKET_SEND(Protocol.CS_CHIP_REFACTOR_CONFIRM,{equip_id = args.equipId,is_save = args.isSave},Protocol.SC_CHIP_REFACTOR_CONFIRM)
end

function onReqEmpowerUnconfirmHandler(self,args)
    SOCKET_SEND(Protocol.CS_CHIP_REFACTOR_UNCONFIRM,{equip_id = args.equipId},Protocol.SC_CHIP_REFACTOR_UNCONFIRM)
end

------------------------------------------------------------------------ 培养面板 ------------------------------------------------------------------------
function __onOpenEquipEmpowerPanelHandler(self, args)
    if self.m_equipEmpowerTipsPanel == nil then
        self.m_equipEmpowerTipsPanel = equipBuild.EquipEmpowerTipsPanel.new()
        self.m_equipEmpowerTipsPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipEmpowerTipsPanelHandler, self)
    end
    self.m_equipEmpowerTipsPanel:open(args)
end

function onDestroyEquipEmpowerTipsPanelHandler(self)
    self.m_equipEmpowerTipsPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipEmpowerTipsPanelHandler, self)
    self.m_equipEmpowerTipsPanel = nil
end

function __onOpenEquipEmpowerLockSurePanelHandler(self,args)
    if self.m_equipEmpowerLockSurePanel == nil then
        self.m_equipEmpowerLockSurePanel = equipBuild.EquipEmpowerLockSurePanel.new()
        self.m_equipEmpowerLockSurePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipEmpowerLockSurePanelHandler, self)
    end
    self.m_equipEmpowerLockSurePanel:open(args)

end

function onDestroyEquipEmpowerLockSurePanelHandler(self)
    self.m_equipEmpowerLockSurePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipEmpowerLockSurePanelHandler, self)
    self.m_equipEmpowerLockSurePanel = nil
end

function __onCloseEquipEmpowerLockSurePanelHandler(self)
    if self.m_equipEmpowerLockSurePanel ~= nil then
        self.m_equipEmpowerLockSurePanel:close()
    end
end

function __onOpenEquipEmpowerPreparePanelHandler(self,args)
    if self.m_equipEmpowerPreparePanel == nil then
        self.m_equipEmpowerPreparePanel = equipBuild.EquipEmpowerPreparePanel.new()
        self.m_equipEmpowerPreparePanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipEmpowerPreparePanelHandler, self)
    end
    self.m_equipEmpowerPreparePanel:open(args)
end

function onDestroyEquipEmpowerPreparePanelHandler(self)
    self.m_equipEmpowerPreparePanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyEquipEmpowerPreparePanelHandler, self)
    self.m_equipEmpowerPreparePanel = nil
end

function __onCloseEquipEmpowerPreparePanelHandler(self)
    if self.m_equipEmpowerPreparePanel ~= nil then
        self.m_equipEmpowerPreparePanel:close()
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
