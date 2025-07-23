module("formation.FormationSeabedController", Class.impl("game.formation.normal.controller.FormationController"))

function getManager(self)
    return formation.FormationSeabedManager
end

--屏蔽，由父类一次性请求
function gameStartCallBack(self)
end

function __openFormationPanel(self)
    if self.m_heroFormationPanel == nil then
        self.m_heroFormationPanel = formation.FormationSeabedPanel.new()
        self.m_heroFormationPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    end
    self.m_heroFormationPanel:open({manager = self:getManager()})
end

function __destroyHeroFormationPanel(self)
    self.m_heroFormationPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    self.m_heroFormationPanel = nil
end

function __onOpenFormationHeroSelectPanelHandler(self, args)
    if self.mFormationHeroSelectPanel == nil then
        self.mFormationHeroSelectPanel = formation.FormationSeabedHeroSelectPanel.new()
        self.mFormationHeroSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationHeroSelectPanelHandler, self)
    end
    self.mFormationHeroSelectPanel:open({manager = self:getManager(), data = args})
end

return _M