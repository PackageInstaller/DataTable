--[[
-----------------------------------------------------
@filename       : FormationSandPlayPanel
@Description    : 地图探索副本
@date           : 2023-10-23 16:01:27
@Author         : Jacob
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('fomation.FormationSandPlayPanel', Class.impl(formation.FormationPanel))

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁

function deActive(self)
    super.deActive(self)
    if self.timerId then
        LoopManager:removeTimerByIndex(self.timerId)
    end
    self.timerId = nil
end

-- function __updateView(self, cusInit)
--     super.__updateView(self, cusInit)
--     if self.timerId then
--         LoopManager:removeTimerByIndex(self.timerId)
--     end
--     self.timerId = nil
--     local onTimer = function()
--         if (dup.DupApostlesWarManager:getWeekEnd()) then
--             self:closeAll()
--         end
--     end
--     self.timerId = LoopManager:addTimer(1, 0, self, onTimer)
-- end

-- 点击保存出战队列并且回调
function __onClickBtnControlHandler(self)
    local count = self:getManager():getSelectFilterHeroCount(self.m_teamId)
    if (count <= 0) then
        gs.Message.Show(_TT(1284))
        gs.Message.Show(_TT(29119))
    else
        local function run()
            self:onClickBtnControlHandler()
        end

        local recommandFight = self:getManager():getRecommandFight()
        if (recommandFight == nil or recommandFight <= 0) then
            run()
        else
            local fight = self:getFormationFight()
            if (fight >= recommandFight) then
                run()
            else
                UIFactory:alertMessge(_TT(1366),
                    true, function() run() end, _TT(1), nil,
                    true, function() end, _TT(2),
                _TT(5), nil, RemindConst.FORMATION_FIGHT)
            end
        end
    end
end

function onClickBtnControlHandler(self)
    -- if (dup.DupApostlesWarManager.mIsTrain) then
    --     local dupId = self:getManager():getData().dupId
    --     GameDispatcher:dispatchEvent(EventName.REQ_DUP_APOSTLES2_TRAIN, { bossId = self:getManager():getDataId(), dupId = dupId })
    -- end
    -- 可能会有援助的怪物，必要同步
    self:getManager():dispatchEvent(self:getManager().REQ_FORMATION_HERO_LIST, {})
    -- 设置出战队列
    self:getManager():dispatchEvent(self:getManager().REQ_SET_FIGHT_TEAM, {teamId = self.m_teamId})
    -- 放在CALL_FUN_REASON前面，防止会自动弹出其他界面音乐，导致回调打开的界面音乐被顶掉
    self:forceClose()
    -- 回调外部
    self:getManager():runCallBack(formation.CALL_FUN_REASON.CLOSE)
    -- 可能会有援助的怪物，通知后端进入战斗后需要撤下，必要同步
    self:rsyncFormationList(true)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
