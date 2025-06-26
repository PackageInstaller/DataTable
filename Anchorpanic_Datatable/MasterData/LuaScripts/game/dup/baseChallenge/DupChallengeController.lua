module('dup/DupChallengeController', Class.impl(Controller))

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
end

--游戏开始的回调
function gameStartCallBack(self)
end

--模块间事件监听
function listNotification(self)
    GameDispatcher:addEventListener(EventName.OPEN_DUP_CHALLENGE_PANEL, self.onOpenPanelHandler, self)
    GameDispatcher:addEventListener(EventName.OPEN_CHALLENGE_DUP, self.onOpenDupEnterHandler, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {
    }
end

function onOpenDupEnterHandler(self, cusType)
    if cusType == DupType.DUP_CLIMB_TOWER then
        -- GameDispatcher:dispatchEvent(EventName.OPEN_CLIMB_TOWER_PANEL)
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CHELLENGE_TOWER, true) == false then
            return
        end

        local curId = dup.DupClimbTowerManager:curDupId()
        curId = curId > 0 and curId or dup.DupClimbTowerManager:maxDupId()
        local dupVo = dup.DupClimbTowerManager:getDupVo(curId)
        GameDispatcher:dispatchEvent(EventName.OPEN_CLIMB_TOWER_PANEL)
    elseif cusType == DupType.DUP_CODE_HOPE then
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_CODE_HOPE, true) == false then
            return
        end

        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_CODE_HOPE_PANEL, dupVo)
    elseif cusType == DupType.DUP_IMPLIED then

        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_IMPLIED, true) == false then
            return
        end

        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_IMPLIED_ENTER_PANEL)
    elseif cusType == DupType.DUP_APOSTLE_WAR then

        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_APOSTLE2_WAR, true) == false then
            return
        end

        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_APOSTLES_WAR_PANEL)
    elseif cusType == DupType.DUP_MAZE then

        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_MAZE, true) == false then
            return
        end

        -- GameDispatcher:dispatchEvent(EventName.REQ_MAZE_ENTER, {mazeId = maze.MazeSceneManager:getLegalMazeId()})
        GameDispatcher:dispatchEvent(EventName.OPEN_MAZE_PANEL)
    end
    if cusType == DupType.DUP_OLD_EQUIP then
        GameDispatcher:dispatchEvent(EventName.OPEN_DUP_OLD_EQUIP_PANEL)
    end

    if cusType == DupType.RogueLike then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.RogueLike })
    end
    if cusType == DupType.Doundless then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Doundless })
    end
    if cusType == DupType.Element then 
        if funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DUP_ELEMENT, true) == false then
            return
        end
        -- local curId = dup.DupClimbTowerManager:curDupId()
        -- curId = curId > 0 and curId or dup.DupClimbTowerManager:maxDupId()
        -- local dupVo = dup.DupClimbTowerManager:getDupVo(curId)
        GameDispatcher:dispatchEvent(EventName.OPEN_DEEP_TOWER_PANEL)
    end
    if cusType == DupType.Seaded then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Seabed })
    end
end


function onOpenPanelHandler(self)
    if self.gPanel == nil then
        self.gPanel = dup.DupChallengePanel.new()
        self.gPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.gPanel:open()
end

-- ui销毁
function onDestroyViewHandler(self)
    self.gPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.gPanel = nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
