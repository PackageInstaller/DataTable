module("formation.FormationArenaDefenseController", Class.impl("game.formation.normal.controller.FormationController"))

---------------------------------------------------------------固定需要-----------------------------------------------------------------
function getManager(self)
    return formation.FormationArenaDefenseManager
end

--屏蔽，由父类一次性请求
function gameStartCallBack(self)
end

--屏蔽，由父类一次性注册
-- function registerMsgHandler(self)
-- end

---------------------------------------------------------------按需重写-----------------------------------------------------------------
function __openFormationPanel(self)
    if self.m_heroFormationPanel == nil then
        self.m_heroFormationPanel = formation.FormationArenaDefensePanel.new()
        self.m_heroFormationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    end
    self.m_heroFormationPanel:open({manager = self:getManager()})
end

function __onOpenFormationHeroSelectPanelHandler(self, args)
    if self.mFormationHeroSelectPanel == nil then
        self.mFormationHeroSelectPanel = formation.FormationArenaDefenseSelectPanel.new()
        self.mFormationHeroSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationHeroSelectPanelHandler, self)
    end
    self.mFormationHeroSelectPanel:open({manager = self:getManager(), data = args})
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
