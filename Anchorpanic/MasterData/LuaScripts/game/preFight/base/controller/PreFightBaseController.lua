module('preFight.BaseController', Class.impl(Controller))

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
    local manager = self:getManager()
    manager:addEventListener(manager.OPEN_PRE_FIGHT_PANEL, self.onOpenPreFightPanel, self)
    manager:addEventListener(manager.REQ_START_BATTLE, self.onReqBattle, self)
end

--注册server发来的数据
function registerMsgHandler(self)
    return {}
end

-- 请求出战
function onReqBattle(self)
    local manager = self:getManager()
    -- fight.FightManager:openFormationPanel(manager:getBattleType(), manager.targetId)
    formation.checkFormationFight(manager:getBattleType(), nil, manager.targetId, nil, nil, nil)

    -- local list = {}
    -- local datas = manager:getShowList(true)
    -- for k, vo in pairs(datas) do
    --     if vo.heroVo then
    --         local info = { hero_id = vo.heroVo.id, hero_pos = vo.index }
    --         table.insert(list, info)
    --     end
    -- end

    -- SOCKET_SEND(Protocol.CS_BATTLE_READY, { battleType = manager:getBattleType(), targetId = manager.targetId, hero_info_data = list })
end

function onOpenPreFightPanel(self, cusTargetId)
    self:getManager().targetId = cusTargetId
    if self.gSelectPanel == nil then
        self.gSelectPanel = self:getPanelClass().new()
        self.gSelectPanel:addEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    end
    self.gSelectPanel:open()
end

-- ui销毁
function onDestroyViewHandler(self)
    self.gSelectPanel:removeEventListener(View.EVENT_VIEW_DESTROY, self.onDestroyViewHandler, self)
    self.gSelectPanel = nil
end

function getPanelClass(self)
    return nil
end

------------------------------------------------------子类必须实现方法------------------------------------------------------
function getManager(self)
    return nil
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
