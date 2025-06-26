module("formation.FormationCycleController", Class.impl("game.formation.normal.controller.FormationController"))

function getManager(self)
    return formation.FormationCycleManager
end

-- 模块间事件监听
function listNotification(self)
    super.listNotification(self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_FORMATION_PANEL,self.customCloseFormationPanel,self)
    GameDispatcher:addEventListener(EventName.CLOSE_CYCLE_FORMATION_HERO_SELECT_PANEL,self.customCloseHeroSelectFormationPanel,self)
    
end

--屏蔽，由父类一次性请求
function gameStartCallBack(self)
end

function __openFormationPanel(self)
    if self.mCycleFormationPanel == nil then
        self.mCycleFormationPanel = formation.FormationCyclePanel.new()
        self.mCycleFormationPanel:addEventListener(View.EVENT_VIEW_DESTROY,self.__destroyHeroFormationPanel,self)
    end
    self.mCycleFormationPanel:open({manager = self:getManager()})
end

function __destroyHeroFormationPanel(self)
    self.mCycleFormationPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.__destroyHeroFormationPanel, self)
    self.mCycleFormationPanel = nil
end

function customCloseFormationPanel(self)
    if(self.mCycleFormationPanel) then
        self.mCycleFormationPanel:close()
    end
end

function __onOpenFormationHeroSelectPanelHandler(self, args)
    if self.mFormationHeroSelectPanel == nil then
        self.mFormationHeroSelectPanel = formation.FormationCycleHeroSelectPanel.new()
        self.mFormationHeroSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyFormationHeroSelectPanelHandler, self)
    end
    self.mFormationHeroSelectPanel:open({manager = self:getManager(), data = args})
end

function customCloseHeroSelectFormationPanel(self)
    self.mCycleFormationPanel:closeHeroSelectEvnt()
end

return _M