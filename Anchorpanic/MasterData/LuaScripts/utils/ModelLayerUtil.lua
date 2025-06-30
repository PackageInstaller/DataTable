module("ModelLayerUtil", Class.impl())

function ctor(self)
    self:__initData()
end

function __initData(self)
    self.m_gameViewList = {}
    table.insert(self.m_gameViewList, {root = GameView.scene, rootDepth = 0, childList = {}})
    table.insert(self.m_gameViewList, {root = GameView.mainUI, rootDepth = 0, childList = {}})
    table.insert(self.m_gameViewList, {root = GameView.pop, rootDepth = 0, childList = {}})
    table.insert(self.m_gameViewList, {root = GameView.subPop, rootDepth = 0, childList = {}})
    table.insert(self.m_gameViewList, {root = GameView.guide, rootDepth = 0, childList = {}})
    table.insert(self.m_gameViewList, {root = GameView.loading, rootDepth = 0, childList = {}})
    table.insert(self.m_gameViewList, {root = GameView.alert, rootDepth = 0, childList = {}})
    table.insert(self.m_gameViewList, {root = GameView.msg, rootDepth = 0, childList = {}})
    table.insert(self.m_gameViewList, {root = GameView.gm, rootDepth = 0, childList = {}})
end

function __addDepth(self, uiPanelIns, layerRootGo, depth)
    if (not self.m_gameViewList) then
        self:__initData()
    end

    if (not depth) then
        depth = 0
    end

    -- 插入数据
    local gameViewData = self:__getGameViewData(layerRootGo)
    if (gameViewData) then
        local isHas = false
        for i = 1, #gameViewData.childList do
            if (gameViewData.childList[i].uiPanelIns == uiPanelIns) then
                gameViewData.childList[i].depth = depth
                isHas = true
            end
        end
        if (not isHas) then
            table.insert(gameViewData.childList, {uiPanelIns = uiPanelIns, depth = depth})
        end
    end

    self:__updateDepth()
end

function __removeDepth(self, uiPanelIns, layerRootGo)
    if (not self.m_gameViewList) then
        self:__initData()
    end
    
    -- 移除数据
    local gameViewData = self:__getGameViewData(layerRootGo)
    if (gameViewData) then
        for i = #gameViewData.childList, 1, -1 do
            if (gameViewData.childList[i].uiPanelIns == uiPanelIns) then
                table.remove(gameViewData.childList, i)
            end
        end
    end

    self:__updateDepth()
end

function __updateDepth(self)
    -- 检查所有gameview
    local totalGameViewDepth = 0
    for i = 1, #self.m_gameViewList do
        local childList = self.m_gameViewList[i].childList

        -- 开始剔除所有gameview下所有失效的子节点
        for i = #childList, 1, -1 do
            local panelGo = childList[i].uiPanelIns.UIObject
            if (not panelGo or gs.GoUtil.IsGoNull(panelGo)) then
                table.remove(childList, i)
            end
        end

        -- 开始更新所有gameview下所有子节点的depth，即z值
        local totalChildDepth = 0
        for i = 1, #childList do
            local maskGo = childList[i].uiPanelIns.mask
            if (maskGo) then
                gs.TransQuick:LPosZ(maskGo.transform, totalChildDepth)
            end

            local baskGo = childList[i].uiPanelIns.UIBase
            if (baskGo) then
                gs.TransQuick:LPosZ(baskGo.transform, totalChildDepth)
            end

            local panelGo = childList[i].uiPanelIns.UIObject
            if (panelGo) then
                gs.TransQuick:LPosZ(panelGo.transform, totalChildDepth)
            end

            totalChildDepth = totalChildDepth - childList[i].depth
        end

        gs.TransQuick:LPosZ(self.m_gameViewList[i].root.transform, totalGameViewDepth)
        totalGameViewDepth = totalGameViewDepth + totalChildDepth
        self.m_gameViewList[i].rootDepth = totalChildDepth
    end
end

function __getGameViewData(self, gameViewGo)
    for i = 1, #self.m_gameViewList do
        if (self.m_gameViewList[i].root == gameViewGo) then
            return self.m_gameViewList[i]
        end
    end
    return nil
end

return _M
