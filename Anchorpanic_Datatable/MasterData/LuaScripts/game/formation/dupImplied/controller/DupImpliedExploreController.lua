--[[ 
-----------------------------------------------------
@filename       : DupImpliedExploreController
@Description    : 联合扫荡
@date           : 2022-12-27 17:00:26
@Author         : ZDH
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("formation.DupImpliedExploreController", Class.impl("game.formation.normal.controller.FormationController"))

---------------------------------------------------------------固定需要-----------------------------------------------------------------
--屏蔽，由父类一次性请求
function gameStartCallBack(self)

end

-- --模块间事件监听
function listNotification(self)

end

---------------------------------------------------------------按需重写-----------------------------------------------------------------
function __openFormationPanel(self)
    super.__openFormationPanel(self)

    self:clearTimer()
    local onTimer = function()
        if(dup.DupApostlesWarManager:getWeekEnd()) then
            if self.m_heroFormationPanel ~= nil then
                self.m_heroFormationPanel:closeAll()
            end
        end
    end
    self.timerId = LoopManager:addTimer(1, 0, self, onTimer)
end

function clearTimer(self)
    if self.timerId then
        LoopManager:removeTimerByIndex(self.timerId)
    end
    self.timerId = nil
end

function __destroyHeroFormationPanel(self)
    super.__destroyHeroFormationPanel(self)
    self:clearTimer()
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
