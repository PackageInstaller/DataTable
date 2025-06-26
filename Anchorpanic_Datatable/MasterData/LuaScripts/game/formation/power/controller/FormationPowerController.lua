module("formation.FormationPowerController", Class.impl("game.formation.normal.controller.FormationController"))

---------------------------------------------------------------固定需要-----------------------------------------------------------------
function getManager(self)
    return formation.FormationPowerManager
end

--屏蔽，由父类一次性请求
function gameStartCallBack(self)
end

--屏蔽，由父类一次性注册
-- function registerMsgHandler(self)
-- end


--模块间事件监听
function listNotification(self)
    super.listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_FORMATION_POWER_TIPS,self.onOpenPowerTips,self)
end
---------------------------------------------------------------按需重写-----------------------------------------------------------------
-- 固定阵型屏蔽选择界面
function __onOpenFormationHeroSelectPanelHandler(self, args)
end


function onOpenPowerTips(self)
    if self.m_poserTips == nil then
        self.m_poserTips = formation.FormationPowerTipsPanel.new()
        self.m_poserTips:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyTipsPanel, self)
    end

    self.m_poserTips:open()
end

function __destroyTipsPanel(self)
    self.m_poserTips:removeEventListener(View.EVENT_VIEW_DESTROY, self.__destroyTipsPanel, self)
    self.m_poserTips = nil
end

function __openFormationPanel(self)
    if self.m_heroFormationPanel == nil then
        self.m_heroFormationPanel = formation.FormationPowerPanel.new()
        self.m_heroFormationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    end
    self.m_heroFormationPanel:open({manager = self:getManager()})
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
